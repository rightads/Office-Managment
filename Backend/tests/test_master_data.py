from __future__ import annotations

import datetime

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.rbac import Permission, Role


@pytest.mark.asyncio
async def test_roles_and_system_role_protection(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test custom role creation, permission assignment, and system role deletion prevention."""
    # 1. Fetch permissions
    perm_res = await db_session.execute(select(Permission).limit(3))
    perms = list(perm_res.scalars().all())
    perm_ids = [str(p.id) for p in perms]

    # 2. Create custom role
    create_res = await async_client.post(
        "/api/v1/roles",
        json={
            "name": "Social Media Manager",
            "description": "SMM Lead",
            "permission_ids": perm_ids,
        },
        headers=admin_auth_headers,
    )
    assert create_res.status_code == 201
    custom_role = create_res.json()
    assert custom_role["name"] == "Social Media Manager"
    assert custom_role["is_system"] is False
    assert len(custom_role["permissions"]) == len(perm_ids)

    # 3. List roles
    list_res = await async_client.get("/api/v1/roles", headers=admin_auth_headers)
    assert list_res.status_code == 200
    assert list_res.json()["total"] >= 13  # 12 seeded + 1 created

    # 4. Attempt to delete a system role (e.g. Admin) -> Must be rejected!
    admin_role = (await db_session.execute(select(Role).where(Role.name == "Admin"))).scalar_one()
    del_admin_res = await async_client.delete(
        f"/api/v1/roles/{admin_role.id}", headers=admin_auth_headers
    )
    assert del_admin_res.status_code == 400
    assert "System role" in del_admin_res.json()["error"]["message"]

    # 5. Delete custom role -> Should succeed
    del_custom_res = await async_client.delete(
        f"/api/v1/roles/{custom_role['id']}", headers=admin_auth_headers
    )
    assert del_custom_res.status_code == 200


@pytest.mark.asyncio
async def test_department_and_office_location_crud(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """Test Department and Office Location administrative CRUD endpoints."""
    # Department
    dept_res = await async_client.post(
        "/api/v1/departments",
        json={"name": "Video Production", "description": "Editing and Motion Graphics"},
        headers=admin_auth_headers,
    )
    assert dept_res.status_code == 201
    dept_id = dept_res.json()["id"]

    # Office Location
    loc_res = await async_client.post(
        "/api/v1/office-locations",
        json={
            "name": "Main Agency HQ",
            "address": "100 Marketing Boulevard, Suite 500",
            "latitude": 40.7128,
            "longitude": -74.0060,
            "radius_meters": 150,
        },
        headers=admin_auth_headers,
    )
    assert loc_res.status_code == 201
    loc_id = loc_res.json()["id"]

    # Read both
    get_depts = await async_client.get(
        "/api/v1/departments?page_size=50", headers=admin_auth_headers
    )
    assert get_depts.status_code == 200
    assert any(d["id"] == dept_id for d in get_depts.json()["items"])

    get_locs = await async_client.get(
        "/api/v1/office-locations?page_size=50", headers=admin_auth_headers
    )
    assert get_locs.status_code == 200
    assert any(loc["id"] == loc_id for loc in get_locs.json()["items"])


@pytest.mark.asyncio
async def test_clients_and_projects_crud(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """Test Client and Project master data management."""
    # Client
    client_res = await async_client.post(
        "/api/v1/clients",
        json={"name": "Acme Global Brands", "email": "contact@acme.com", "phone": "+15551234567"},
        headers=admin_auth_headers,
    )
    assert client_res.status_code == 201
    client_id = client_res.json()["id"]

    # Project
    proj_res = await async_client.post(
        "/api/v1/projects",
        json={
            "name": "Acme Q4 Growth Campaign",
            "code": "PRJ-ACME-001",
            "client_id": client_id,
            "start_date": str(datetime.date.today()),
        },
        headers=admin_auth_headers,
    )
    assert proj_res.status_code == 201
    proj_id = proj_res.json()["id"]

    list_proj = await async_client.get("/api/v1/projects", headers=admin_auth_headers)
    assert list_proj.status_code == 200
    assert any(p["id"] == proj_id for p in list_proj.json()["items"])


@pytest.mark.asyncio
async def test_system_settings_and_audit_logs(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """Test dynamic JSON system settings and audit trail querying."""
    # Upsert custom setting
    setting_res = await async_client.post(
        "/api/v1/system-settings",
        json={
            "key": "employee_code_config",
            "value": {"prefix": "RAD", "padding": 5},
            "description": "Custom prefix for Right Ads",
        },
        headers=admin_auth_headers,
    )
    assert setting_res.status_code == 200
    assert setting_res.json()["value"]["prefix"] == "RAD"

    # Query audit logs
    audit_res = await async_client.get("/api/v1/audit-logs", headers=admin_auth_headers)
    assert audit_res.status_code == 200
    assert audit_res.json()["total"] >= 1
