from __future__ import annotations

import asyncio
import datetime
import json
import os
from pathlib import Path

import typer
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.database import async_session_factory
from app.core.permissions_registry import PERMISSIONS_CATALOG
from app.core.security import hash_password, validate_password_policy
from app.models.attendance import (
    AttendancePolicy,
    AttendanceStatus,
)
from app.models.organization import Department
from app.models.rbac import Permission, Role
from app.models.task import (
    TaskPriority,
    TaskStatus,
    TaskStatusTransition,
)
from app.models.user import User

cli_app = typer.Typer(
    name="right-ads-cli",
    help="Right Ads Administrative Management & Database Seeding Utility",
)

SEED_DIR = Path(__file__).resolve().parent.parent / "seed_data"


async def _async_seed_permissions(session: AsyncSession | None = None) -> int:
    """Async worker syncing the permission catalog idempotently."""
    if session is None:
        async with async_session_factory() as sess:
            return await _async_seed_permissions(sess)

    synced_count = 0
    for item in PERMISSIONS_CATALOG:
        stmt = select(Permission).where(Permission.code == item.code)
        res = await session.execute(stmt)
        perm = res.scalar_one_or_none()
        if perm is None:
            perm = Permission(code=item.code, description=item.description)
            session.add(perm)
            synced_count += 1
        else:
            perm.description = item.description

    await session.commit()
    return synced_count


@cli_app.command("seed-permissions")
def seed_permissions() -> None:
    """Sync all permission codes from permissions_registry into the database."""
    typer.echo("Syncing permissions catalog...")
    synced = asyncio.run(_async_seed_permissions())
    typer.secho(
        f"Successfully synced permissions (added {synced} new permissions).", fg=typer.colors.GREEN
    )


async def _async_seed_defaults(session: AsyncSession | None = None) -> None:
    """Async worker loading seed data from JSON files and populating defaults idempotently."""
    if session is None:
        async with async_session_factory() as sess:
            await _async_seed_defaults(sess)
            return

    # Ensure all permissions are present first
    await _async_seed_permissions(session)

    # 1. Seed Roles & Role Permissions
    roles_file = SEED_DIR / "roles_permissions.json"
    if roles_file.exists():
        roles_data = json.loads(roles_file.read_text(encoding="utf-8"))
        all_perms_res = await session.execute(select(Permission))
        all_perms = {p.code: p for p in all_perms_res.scalars().all()}

        for r_data in roles_data:
            stmt = (
                select(Role)
                .where(Role.name == r_data["name"])
                .options(selectinload(Role.permissions))
            )
            res = await session.execute(stmt)
            role = res.scalar_one_or_none()
            # Map permissions
            if r_data["permissions"] == "*":
                mapped_perms = list(all_perms.values())
            else:
                mapped_perms = [all_perms[p] for p in r_data["permissions"] if p in all_perms]

            if role is None:
                role = Role(
                    name=r_data["name"],
                    description=r_data.get("description"),
                    is_system=r_data.get("is_system", False),
                    permissions=mapped_perms,
                )
                session.add(role)
            else:
                role.permissions = mapped_perms

    # 2. Seed Departments
    dept_file = SEED_DIR / "departments.json"
    if dept_file.exists():
        dept_data = json.loads(dept_file.read_text(encoding="utf-8"))
        for d in dept_data:
            stmt_dept = select(Department).where(Department.name == d["name"])
            res_dept = await session.execute(stmt_dept)
            if res_dept.scalar_one_or_none() is None:
                session.add(Department(name=d["name"], description=d.get("description")))

    # 3. Seed Attendance Defaults
    att_file = SEED_DIR / "attendance_defaults.json"
    if att_file.exists():
        att_data = json.loads(att_file.read_text(encoding="utf-8"))
        for st in att_data.get("statuses", []):
            stmt_st = select(AttendanceStatus).where(AttendanceStatus.code == st["code"])
            res_st = await session.execute(stmt_st)
            if res_st.scalar_one_or_none() is None:
                session.add(
                    AttendanceStatus(
                        code=st["code"],
                        label=st["label"],
                        counts_as_present=st["counts_as_present"],
                        color=st.get("color", "#10B981"),
                    )
                )

        pol = att_data.get("default_policy")
        if pol:
            stmt_pol = select(AttendancePolicy).where(AttendancePolicy.name == pol["name"])
            res_pol = await session.execute(stmt_pol)
            if res_pol.scalar_one_or_none() is None:
                session.add(
                    AttendancePolicy(
                        name=pol["name"],
                        shift_start=datetime.time.fromisoformat(pol["shift_start"]),
                        shift_end=datetime.time.fromisoformat(pol["shift_end"]),
                        grace_minutes=pol["grace_minutes"],
                        half_day_min_hours=pol["half_day_min_hours"],
                        full_day_min_hours=pol["full_day_min_hours"],
                        week_off_days=pol.get("week_off_days", [6]),
                        require_geofence=pol.get("require_geofence", True),
                        require_selfie=pol.get("require_selfie", False),
                        allowed_location_ids=pol.get("allowed_location_ids", []),
                        is_default=pol.get("is_default", True),
                    )
                )

    # 4. Seed Task Defaults
    task_file = SEED_DIR / "task_defaults.json"
    if task_file.exists():
        task_data = json.loads(task_file.read_text(encoding="utf-8"))
        status_map: dict[str, TaskStatus] = {}
        for t_st in task_data.get("statuses", []):
            stmt_task_st = select(TaskStatus).where(TaskStatus.code == t_st["code"])
            res_task_st = await session.execute(stmt_task_st)
            task_status_obj: TaskStatus | None = res_task_st.scalar_one_or_none()
            if task_status_obj is None:
                task_status_obj = TaskStatus(
                    code=t_st["code"],
                    label=t_st["label"],
                    order=t_st.get("order", 0),
                    is_terminal=t_st.get("is_terminal", False),
                    color=t_st.get("color", "#3B82F6"),
                )
                session.add(task_status_obj)
                await session.flush()
            status_map[t_st["code"]] = task_status_obj

        for prio in task_data.get("priorities", []):
            stmt_prio = select(TaskPriority).where(TaskPriority.code == prio["code"])
            res_prio = await session.execute(stmt_prio)
            if res_prio.scalar_one_or_none() is None:
                session.add(
                    TaskPriority(
                        code=prio["code"],
                        label=prio["label"],
                        weight=prio.get("weight", 1),
                        color=prio.get("color", "#6B7280"),
                    )
                )

        for tr in task_data.get("transitions", []):
            from_obj = status_map.get(tr["from_status"])
            to_obj = status_map.get(tr["to_status"])
            if from_obj and to_obj:
                stmt_tr = select(TaskStatusTransition).where(
                    TaskStatusTransition.from_status_id == from_obj.id,
                    TaskStatusTransition.to_status_id == to_obj.id,
                )
                res_tr = await session.execute(stmt_tr)
                if res_tr.scalar_one_or_none() is None:
                    session.add(
                        TaskStatusTransition(
                            from_status_id=from_obj.id,
                            to_status_id=to_obj.id,
                            required_permission=tr.get("required_permission"),
                        )
                    )

    await session.commit()


@cli_app.command("seed-defaults")
def seed_defaults() -> None:
    """Load and synchronize versioned JSON seed data into database idempotently."""
    typer.echo("Loading default seed configurations from app/seed_data/...")
    asyncio.run(_async_seed_defaults())
    typer.secho(
        "Default system roles, permissions, departments, and workflows successfully seeded.",
        fg=typer.colors.GREEN,
    )


async def _async_create_admin(
    email: str,
    name: str,
    password: str,
    session: AsyncSession | None = None,
) -> None:
    """Async worker creating or provisioning an initial administrator account."""
    if session is None:
        async with async_session_factory() as sess:
            await _async_create_admin(email, name, password, sess)
            return

    # Ensure default roles exist
    await _async_seed_defaults(session)

    # Fetch Admin role
    stmt = select(Role).where(Role.name == "Admin")
    res = await session.execute(stmt)
    admin_role = res.scalar_one_or_none()
    if not admin_role:
        raise RuntimeError("Admin role not found. Run seed-defaults first.")

    # Check existing user
    stmt_user = select(User).where(User.email == email.strip().lower())
    res_user = await session.execute(stmt_user)
    existing_user = res_user.scalar_one_or_none()

    pw_hash = hash_password(password)

    if existing_user:
        existing_user.password_hash = pw_hash
        existing_user.role_id = admin_role.id
        existing_user.is_active = True
        existing_user.must_change_password = False
        typer.secho(f"Updated existing user '{email}' as Super Admin.", fg=typer.colors.YELLOW)
    else:
        admin_user = User(
            employee_code="ADMIN-001",
            email=email.strip().lower(),
            full_name=name.strip(),
            password_hash=pw_hash,
            role_id=admin_role.id,
            designation="System Administrator",
            is_active=True,
            must_change_password=False,
        )
        session.add(admin_user)
        typer.secho(f"Successfully created Super Admin user '{email}'.", fg=typer.colors.GREEN)

    await session.commit()


@cli_app.command("create-admin")
def create_admin(
    email: str | None = typer.Option(None, "--email", "-e", help="Administrator email address"),
    name: str | None = typer.Option(None, "--name", "-n", help="Administrator full name"),
    password: str | None = typer.Option(
        None, "--password", "-p", help="Administrator password", hide_input=True
    ),
) -> None:
    """Create an administrator account without hardcoded defaults."""
    admin_email: str = email or os.getenv("ADMIN_EMAIL") or typer.prompt("Admin Email")
    admin_name: str = name or os.getenv("ADMIN_NAME") or typer.prompt("Admin Full Name")
    admin_password: str = (
        password
        or os.getenv("ADMIN_PASSWORD")
        or typer.prompt("Admin Password", hide_input=True, confirmation_prompt=True)
    )

    try:
        validate_password_policy(admin_password)
    except Exception as exc:
        typer.secho(f"Password Policy Violation: {exc}", fg=typer.colors.RED)
        raise typer.Exit(code=1) from exc

    asyncio.run(_async_create_admin(email=admin_email, name=admin_name, password=admin_password))
