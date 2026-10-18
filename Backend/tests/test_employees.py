from __future__ import annotations

import uuid

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.organization import Department
from app.models.rbac import Role
from app.models.system import AuditLog
from app.models.user import User


@pytest.mark.asyncio
async def test_create_and_list_employees(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test administrative employee provisioning and listing with search and pagination."""
    # Find Graphic designer role and Graphic Design department
    role_res = await db_session.execute(select(Role).where(Role.name == "Graphic designer"))
    role = role_res.scalar_one()

    dept_res = await db_session.execute(
        select(Department).where(Department.name == "Graphic Design")
    )
    dept = dept_res.scalar_one()

    payload = {
        "email": "designer.jane@agency.com",
        "full_name": "Jane Designer",
        "role_id": str(role.id),
        "department_id": str(dept.id),
        "phone_number": "+1234567890",
        "designation": "Lead Designer",
    }

    # 1. Create employee
    res = await async_client.post("/api/v1/employees", json=payload, headers=admin_auth_headers)
    assert res.status_code == 201
    data = res.json()
    assert data["email"] == "designer.jane@agency.com"
    assert data["full_name"] == "Jane Designer"
    assert data["employee_code"].startswith("EMP-")
    assert data["is_active"] is True
    assert data["must_change_password"] is True
    assert data["role_name"] == "Graphic designer"
    emp_id = data["id"]

    # Verify audit log recorded
    audit_res = await db_session.execute(
        select(AuditLog).where(AuditLog.entity_id == emp_id, AuditLog.action == "CREATE")
    )
    assert audit_res.scalar_one_or_none() is not None

    # 2. List employees with search query
    list_res = await async_client.get(
        "/api/v1/employees?search=Jane&page=1&page_size=10", headers=admin_auth_headers
    )
    assert list_res.status_code == 200
    list_data = list_res.json()
    assert list_data["total"] >= 1
    assert any(e["email"] == "designer.jane@agency.com" for e in list_data["items"])


@pytest.mark.asyncio
async def test_employee_detail_and_update(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test detail retrieval with permissions and administrative profile editing."""
    role = (await db_session.execute(select(Role).where(Role.name == "SEO"))).scalar_one()

    payload = {
        "email": "alex.seo@agency.com",
        "full_name": "Alex SEO Specialist",
        "role_id": str(role.id),
    }
    create_res = await async_client.post(
        "/api/v1/employees", json=payload, headers=admin_auth_headers
    )
    emp_id = create_res.json()["id"]

    # Detail
    get_res = await async_client.get(f"/api/v1/employees/{emp_id}", headers=admin_auth_headers)
    assert get_res.status_code == 200
    detail = get_res.json()
    assert "project.view_all" in detail["permissions"]

    # Update
    patch_res = await async_client.patch(
        f"/api/v1/employees/{emp_id}",
        json={"designation": "Principal SEO Lead", "phone_number": "+9876543210"},
        headers=admin_auth_headers,
    )
    assert patch_res.status_code == 200
    updated = patch_res.json()
    assert updated["designation"] == "Principal SEO Lead"
    assert updated["phone_number"] == "+9876543210"


@pytest.mark.asyncio
async def test_self_service_profile_update(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Test self-service update endpoint on /me restricts edits to whitelisted fields."""
    _emp, headers = employee_auth_headers

    # 1. Get /me
    me_res = await async_client.get("/api/v1/employees/me", headers=headers)
    assert me_res.status_code == 200
    assert me_res.json()["email"] == "sales.rep@agency.com"

    # 2. Update allowed field (phone, avatar)
    patch_res = await async_client.patch(
        "/api/v1/employees/me",
        json={"phone_number": "+1122334455", "avatar_url": "https://img.agency.com/avatar.jpg"},
        headers=headers,
    )
    assert patch_res.status_code == 200
    assert patch_res.json()["phone_number"] == "+1122334455"
    assert patch_res.json()["avatar_url"] == "https://img.agency.com/avatar.jpg"


@pytest.mark.asyncio
async def test_deactivate_and_last_admin_protection(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Ensure deactivation works for normal users, but is blocked for the last active admin."""
    role = (
        await db_session.execute(select(Role).where(Role.name == "Web Application"))
    ).scalar_one()
    res = await async_client.post(
        "/api/v1/employees",
        json={"email": "dev.user@agency.com", "full_name": "Dev User", "role_id": str(role.id)},
        headers=admin_auth_headers,
    )
    dev_id = res.json()["id"]

    # 1. Deactivate normal employee
    deact_res = await async_client.post(
        f"/api/v1/employees/{dev_id}/deactivate", headers=admin_auth_headers
    )
    assert deact_res.status_code == 200
    assert deact_res.json()["is_active"] is False

    # 2. Attempt to deactivate the only active admin -> Must be blocked!
    admin_user = (
        await db_session.execute(select(User).where(User.email == "superadmin@agency.com"))
    ).scalar_one()
    admin_deact_res = await async_client.post(
        f"/api/v1/employees/{admin_user.id}/deactivate",
        headers=admin_auth_headers,
    )
    assert admin_deact_res.status_code == 400
    assert "last active system administrator" in admin_deact_res.json()["error"]["message"]

    # 3. Attempt to demote the only active admin -> Must be blocked!
    demote_res = await async_client.patch(
        f"/api/v1/employees/{admin_user.id}/role",
        json={"role_id": str(role.id)},
        headers=admin_auth_headers,
    )
    assert demote_res.status_code == 400
    assert "last active system administrator" in demote_res.json()["error"]["message"]


@pytest.mark.asyncio
async def test_admin_reset_password_and_assignments(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test administrative password reset and manager assignment."""
    role = (await db_session.execute(select(Role).where(Role.name == "Accounts"))).scalar_one()
    res = await async_client.post(
        "/api/v1/employees",
        json={
            "email": "acc.officer@agency.com",
            "full_name": "Account Officer",
            "role_id": str(role.id),
        },
        headers=admin_auth_headers,
    )
    acc_id = res.json()["id"]

    # Reset password
    pw_res = await async_client.post(
        f"/api/v1/employees/{acc_id}/reset-password",
        json={},
        headers=admin_auth_headers,
    )
    assert pw_res.status_code == 200
    assert "successfully reset" in pw_res.json()["message"]

    # Verify must_change_password is true
    user = (await db_session.execute(select(User).where(User.id == uuid.UUID(acc_id)))).scalar_one()
    assert user.must_change_password is True
