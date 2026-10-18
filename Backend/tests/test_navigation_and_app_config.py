from __future__ import annotations

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.security import create_access_token, hash_password
from app.models.rbac import Permission, Role
from app.models.user import User


@pytest.mark.anyio
async def test_public_app_config_and_dynamic_override(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """GET /api/v1/app/config is public and reflects dynamic system_settings overrides."""
    res = await async_client.get("/api/v1/app/config")
    assert res.status_code == 200
    data = res.json()
    assert data["app_timezone"] == "UTC"
    assert data["default_page_size"] == 10
    assert data["max_page_size"] == 50
    assert data["max_upload_mb"] == 5
    assert "image/jpeg" in data["allowed_upload_mime_types"]
    assert data["min_supported_app_version"] == "1.0.0"
    assert data["force_update"] is False
    assert data["navigation_refresh_interval_minutes"] == 5
    assert data["password_policy"]["min_length"] >= 8
    assert isinstance(data["feature_flags"], dict)

    # Override min_supported_app_version and force_update via /api/v1/system-settings
    upsert_ver = await async_client.post(
        "/api/v1/system-settings",
        headers=admin_auth_headers,
        json={
            "key": "min_supported_app_version",
            "value": "2.1.0",
            "description": "Bump min supported version",
        },
    )
    assert upsert_ver.status_code == 200

    upsert_force = await async_client.post(
        "/api/v1/system-settings",
        headers=admin_auth_headers,
        json={
            "key": "force_update",
            "value": True,
            "description": "Enable force update gate",
        },
    )
    assert upsert_force.status_code == 200

    res_updated = await async_client.get("/api/v1/app/config")
    assert res_updated.status_code == 200
    updated_data = res_updated.json()
    assert updated_data["min_supported_app_version"] == "2.1.0"
    assert updated_data["force_update"] is True


@pytest.mark.anyio
async def test_navigation_permission_filtering_and_admin_module_crud(
    async_client: AsyncClient,
    db_session: AsyncSession,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """
    Verifies:
    1. Base modules are seeded via seed-defaults (7 modules).
    2. Admin CRUD on /api/v1/app-modules requires `modules.manage`.
    3. /api/v1/me/navigation filters modules by the user's permission set and is_active flag.
    4. Base modules are protected against deletion.
    """
    _emp_user, emp_headers = employee_auth_headers

    # Employee without modules.manage cannot create a module
    forbidden_res = await async_client.post(
        "/api/v1/app-modules",
        headers=emp_headers,
        json={
            "code": "audit_logs",
            "label": "Audit Logs",
            "icon_key": "audit",
            "route_key": "admin_audit_logs",
            "sort_order": 90,
            "required_permission": "system.view_audit_logs",
            "is_base": False,
            "is_active": True,
            "show_on_home": True,
        },
    )
    assert forbidden_res.status_code == 403

    # Admin creates an extra module requiring `system.view_audit_logs`
    create_res = await async_client.post(
        "/api/v1/app-modules",
        headers=admin_auth_headers,
        json={
            "code": "audit_logs",
            "label": "Audit Logs",
            "icon_key": "audit",
            "route_key": "admin_audit_logs",
            "sort_order": 90,
            "required_permission": "system.view_audit_logs",
            "is_base": False,
            "is_active": True,
            "show_on_home": True,
            "description": "Immutable security audit trail",
        },
    )
    assert create_res.status_code == 201
    created_module = create_res.json()
    module_id = created_module["id"]

    # Admin sees all 7 base modules + audit_logs
    admin_nav_res = await async_client.get("/api/v1/me/navigation", headers=admin_auth_headers)
    assert admin_nav_res.status_code == 200
    admin_nav = admin_nav_res.json()
    admin_codes = [m["code"] for m in admin_nav["modules"]]
    assert "attendance" in admin_codes
    assert "tasks" in admin_codes
    assert "leave" in admin_codes
    assert "work_reports" in admin_codes
    assert "announcements" in admin_codes
    assert "notifications" in admin_codes
    assert "profile" in admin_codes
    assert "audit_logs" in admin_codes
    assert "modules.manage" in admin_nav["permissions"]

    # Employee (Tele sales) sees the 7 base modules, but NOT audit_logs
    emp_nav_res = await async_client.get("/api/v1/me/navigation", headers=emp_headers)
    assert emp_nav_res.status_code == 200
    emp_nav = emp_nav_res.json()
    emp_codes = [m["code"] for m in emp_nav["modules"]]
    assert len(emp_codes) == 7
    assert "audit_logs" not in emp_codes
    assert emp_nav["role_name"] == "Tele sales"
    assert emp_nav["must_change_password"] is False

    # Create a restricted user whose role only has `attendance.view_own`
    att_perm = (
        await db_session.execute(
            select(Permission).where(Permission.code == "attendance.view_own")
        )
    ).scalar_one()
    minimal_role = Role(
        name="Minimal Contractor",
        description="Only attendance",
        is_system=False,
        permissions=[att_perm],
    )
    db_session.add(minimal_role)
    await db_session.flush()

    contractor = User(
        employee_code="CON-001",
        email="contractor@agency.com",
        full_name="Contractor User",
        password_hash=hash_password("ContractorPass123!#"),
        role_id=minimal_role.id,
        is_active=True,
        must_change_password=True,
    )
    db_session.add(contractor)
    await db_session.commit()

    contractor_token = create_access_token(
        user_id=str(contractor.id), role="Minimal Contractor"
    )
    contractor_headers = {"Authorization": f"Bearer {contractor_token}"}

    # Contractor should only see attendance + permissionless base modules (work_reports, notifications, profile)
    con_nav_res = await async_client.get("/api/v1/me/navigation", headers=contractor_headers)
    assert con_nav_res.status_code == 200
    con_nav = con_nav_res.json()
    con_codes = [m["code"] for m in con_nav["modules"]]
    assert con_codes == ["attendance", "work_reports", "notifications", "profile"]
    assert con_nav["must_change_password"] is True

    # Deactivating audit_logs hides it from Admin navigation too
    patch_res = await async_client.patch(
        f"/api/v1/app-modules/{module_id}",
        headers=admin_auth_headers,
        json={"is_active": False},
    )
    assert patch_res.status_code == 200
    assert patch_res.json()["is_active"] is False

    admin_nav_after = await async_client.get("/api/v1/me/navigation", headers=admin_auth_headers)
    assert "audit_logs" not in [m["code"] for m in admin_nav_after.json()["modules"]]

    # Base module cannot be deleted
    all_mods_res = await async_client.get("/api/v1/app-modules", headers=admin_auth_headers)
    assert all_mods_res.status_code == 200
    attendance_mod = next(m for m in all_mods_res.json() if m["code"] == "attendance")
    del_base_res = await async_client.delete(
        f"/api/v1/app-modules/{attendance_mod['id']}",
        headers=admin_auth_headers,
    )
    assert del_base_res.status_code in (400, 422)

    # Custom non-base module CAN be deleted
    del_custom_res = await async_client.delete(
        f"/api/v1/app-modules/{module_id}",
        headers=admin_auth_headers,
    )
    assert del_custom_res.status_code == 200


@pytest.mark.anyio
async def test_effective_attendance_policy_with_locations(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """GET /api/v1/me/attendance-policy returns effective policy and active office locations."""
    _emp_user, emp_headers = employee_auth_headers

    # Create an active office location as Admin
    loc_res = await async_client.post(
        "/api/v1/office-locations",
        headers=admin_auth_headers,
        json={
            "name": "Mumbai HQ",
            "latitude": 19.0760,
            "longitude": 72.8777,
            "radius_meters": 150.0,
        },
    )
    assert loc_res.status_code == 201

    pol_res = await async_client.get("/api/v1/me/attendance-policy", headers=emp_headers)
    assert pol_res.status_code == 200
    pol = pol_res.json()
    assert pol["name"] == "Standard Office Shift"
    assert "require_geofence" in pol
    assert "require_selfie" in pol
    assert len(pol["allowed_locations"]) == 1
    assert pol["allowed_locations"][0]["name"] == "Mumbai HQ"
    assert pol["allowed_locations"][0]["radius_meters"] == 150.0

