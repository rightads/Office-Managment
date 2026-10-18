from __future__ import annotations

import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.permissions_registry import PERMISSIONS_CATALOG
from app.core.security import hash_password
from app.models.rbac import Permission, Role
from app.models.user import User


@pytest.fixture
async def seeded_roles_and_users(db_session: AsyncSession) -> dict[str, User]:
    """Seed test permissions, roles (Admin & Employee), and test users."""
    # Seed Permissions
    perms: list[Permission] = []
    for p in PERMISSIONS_CATALOG:
        perm = Permission(code=p.code, description=p.description)
        db_session.add(perm)
        perms.append(perm)
    await db_session.flush()

    # Admin Role has all permissions
    admin_role = Role(name="Admin", is_system=True, permissions=perms)
    # Employee Role has view_own permissions
    emp_perms = [
        p for p in perms if p.code in ("attendance.check_in", "attendance.view_own", "leave.apply")
    ]
    employee_role = Role(name="Employee", is_system=False, permissions=emp_perms)

    db_session.add_all([admin_role, employee_role])
    await db_session.flush()

    # Standard Employee User
    normal_emp = User(
        employee_code="EMP-100",
        email="emp@rightads.com",
        full_name="Standard Employee",
        password_hash=hash_password("ValidPassword123!"),
        role_id=employee_role.id,
        is_active=True,
    )

    # Admin User
    admin_user = User(
        employee_code="ADM-100",
        email="admin@rightads.com",
        full_name="Admin User",
        password_hash=hash_password("AdminSecurePassword123!"),
        role_id=admin_role.id,
        is_active=True,
    )

    # User requiring password change
    forced_pw_user = User(
        employee_code="EMP-101",
        email="forced@rightads.com",
        full_name="Forced PW User",
        password_hash=hash_password("TemporaryPassword123!"),
        role_id=employee_role.id,
        is_active=True,
        must_change_password=True,
    )

    db_session.add_all([normal_emp, admin_user, forced_pw_user])
    await db_session.commit()

    return {
        "employee": normal_emp,
        "admin": admin_user,
        "forced": forced_pw_user,
    }


@pytest.mark.asyncio
async def test_login_success(
    async_client: AsyncClient,
    seeded_roles_and_users: dict[str, User],
) -> None:
    """Verify login with correct credentials yields access and refresh tokens."""
    res = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ValidPassword123!"},
    )
    assert res.status_code == 200
    data = res.json()
    assert data["success"] is True
    assert "access_token" in data["data"]
    assert "refresh_token" in data["data"]
    assert data["data"]["token_type"] == "bearer"


@pytest.mark.asyncio
async def test_login_failure_and_lockout(
    async_client: AsyncClient,
    seeded_roles_and_users: dict[str, User],
) -> None:
    """Verify wrong credentials increment failure count and trigger lockout after threshold."""
    # Settings in conftest has MAX_LOGIN_ATTEMPTS = 3
    for _ in range(settings.MAX_LOGIN_ATTEMPTS):
        res = await async_client.post(
            "/api/v1/auth/login",
            json={"email": "emp@rightads.com", "password": "WrongPassword!"},
        )
        assert res.status_code == 401
        assert res.json()["error"]["code"] == "UNAUTHORIZED"

    # Attempt after lockout threshold
    lockout_res = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ValidPassword123!"},
    )
    assert lockout_res.status_code == 401
    assert "locked" in lockout_res.json()["error"]["message"].lower()


@pytest.mark.asyncio
async def test_refresh_token_rotation_and_reuse_detection(
    async_client: AsyncClient,
    seeded_roles_and_users: dict[str, User],
) -> None:
    """Verify refresh token rotation and reuse detection terminating sessions."""
    # 1. Login to obtain tokens
    login_res = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ValidPassword123!"},
    )
    token_data = login_res.json()["data"]
    old_refresh = token_data["refresh_token"]

    # 2. Refresh token (rotation)
    refresh_res = await async_client.post(
        "/api/v1/auth/refresh",
        json={"refresh_token": old_refresh},
    )
    assert refresh_res.status_code == 200
    new_data = refresh_res.json()["data"]
    new_refresh = new_data["refresh_token"]
    assert new_refresh != old_refresh

    # 3. Reuse old refresh token (Reuse Detection trigger!)
    reuse_res = await async_client.post(
        "/api/v1/auth/refresh",
        json={"refresh_token": old_refresh},
    )
    assert reuse_res.status_code == 401
    assert "reuse detected" in reuse_res.json()["error"]["message"].lower()

    # 4. Even the new token is now revoked due to reuse detection
    after_reuse_res = await async_client.post(
        "/api/v1/auth/refresh",
        json={"refresh_token": new_refresh},
    )
    assert after_reuse_res.status_code == 401


@pytest.mark.asyncio
async def test_user_profile_me_and_permissions(
    async_client: AsyncClient,
    seeded_roles_and_users: dict[str, User],
) -> None:
    """Verify /me returns accurate profile and permissions without role-name checks."""
    login_res = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ValidPassword123!"},
    )
    access_token = login_res.json()["data"]["access_token"]

    me_res = await async_client.get(
        "/api/v1/auth/me",
        headers={"Authorization": f"Bearer {access_token}"},
    )
    assert me_res.status_code == 200
    me_data = me_res.json()["data"]
    assert me_data["email"] == "emp@rightads.com"
    assert me_data["role"] == "Employee"
    assert "attendance.check_in" in me_data["permissions"]
    assert "attendance.view_all" not in me_data["permissions"]


@pytest.mark.asyncio
async def test_change_password_and_policy(
    async_client: AsyncClient,
    seeded_roles_and_users: dict[str, User],
) -> None:
    """Verify password change enforces policy and updates credentials."""
    login_res = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ValidPassword123!"},
    )
    access_token = login_res.json()["data"]["access_token"]

    # Fails complexity (e.g. no special character or too short)
    weak_res = await async_client.post(
        "/api/v1/auth/change-password",
        headers={"Authorization": f"Bearer {access_token}"},
        json={"current_password": "ValidPassword123!", "new_password": "simplepassword"},
    )
    assert weak_res.status_code == 422

    # Valid change
    valid_res = await async_client.post(
        "/api/v1/auth/change-password",
        headers={"Authorization": f"Bearer {access_token}"},
        json={"current_password": "ValidPassword123!", "new_password": "NewBrandSecure123@#"},
    )
    assert valid_res.status_code == 200

    # Old password no longer works
    old_login = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ValidPassword123!"},
    )
    assert old_login.status_code == 401

    # New password succeeds
    new_login = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "NewBrandSecure123@#"},
    )
    assert new_login.status_code == 200


@pytest.mark.asyncio
async def test_forgot_and_reset_password(
    async_client: AsyncClient,
    seeded_roles_and_users: dict[str, User],
) -> None:
    """Verify forgot-password flow and token reset."""
    from app.core.security import create_password_reset_token

    # 1. Forgot password request (generic message)
    forgot_res = await async_client.post(
        "/api/v1/auth/forgot-password",
        json={"email": "emp@rightads.com"},
    )
    assert forgot_res.status_code == 200
    assert "instructions have been sent" in forgot_res.json()["message"]

    # 2. Reset password using valid token
    emp = seeded_roles_and_users["employee"]
    reset_token = create_password_reset_token(str(emp.id))

    reset_res = await async_client.post(
        "/api/v1/auth/reset-password",
        json={"token": reset_token, "new_password": "ResetSuccessPassword999!"},
    )
    assert reset_res.status_code == 200

    # 3. Verify login with reset password
    login_res = await async_client.post(
        "/api/v1/auth/login",
        json={"email": "emp@rightads.com", "password": "ResetSuccessPassword999!"},
    )
    assert login_res.status_code == 200
