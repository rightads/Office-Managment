from __future__ import annotations

import pytest
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload
from typer.testing import CliRunner

from app.cli.commands import (
    _async_create_admin,
    _async_seed_defaults,
    _async_seed_permissions,
)
from app.models.organization import Department
from app.models.rbac import Role
from app.models.user import User

runner = CliRunner()


@pytest.mark.asyncio
async def test_async_seed_permissions_and_defaults(db_session: AsyncSession) -> None:
    """Verify programmatic execution of seed-permissions and seed-defaults."""
    # 1. Seed Permissions
    synced = await _async_seed_permissions(session=db_session)
    assert synced > 0

    # Idempotent second run adds 0
    synced_again = await _async_seed_permissions(session=db_session)
    assert synced_again == 0

    # 2. Seed Defaults (Roles, Departments, Attendance, Tasks)
    await _async_seed_defaults(session=db_session)

    # Verify roles created
    stmt_roles = select(func.count()).select_from(Role)
    role_count = (await db_session.execute(stmt_roles)).scalar_one()
    # 12 roles defined in roles_permissions.json
    assert role_count >= 12

    # Verify departments created
    stmt_depts = select(func.count()).select_from(Department)
    dept_count = (await db_session.execute(stmt_depts)).scalar_one()
    assert dept_count >= 10

    # Verify Admin role has all permissions mapped via data
    stmt_admin = select(Role).where(Role.name == "Admin").options(selectinload(Role.permissions))
    admin_res = await db_session.execute(stmt_admin)
    admin_role = admin_res.scalar_one()
    assert len(admin_role.permissions) >= 20


@pytest.mark.asyncio
async def test_async_create_admin(db_session: AsyncSession) -> None:
    """Verify admin provisioning without hardcoded defaults."""
    await _async_create_admin(
        email="superadmin@rightads.com",
        name="Super Admin",
        password="SuperAdminPassword123#@",
        session=db_session,
    )

    stmt = (
        select(User).where(User.email == "superadmin@rightads.com").options(selectinload(User.role))
    )
    res = await db_session.execute(stmt)
    admin_user = res.scalar_one()

    assert admin_user.full_name == "Super Admin"
    assert admin_user.role.name == "Admin"
    assert admin_user.is_active is True
