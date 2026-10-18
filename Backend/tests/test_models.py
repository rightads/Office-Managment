from __future__ import annotations

import datetime
import uuid

import pytest
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.attendance import (
    AttendanceRecord,
    AttendanceStatus,
)
from app.models.organization import Department
from app.models.rbac import Permission, Role
from app.models.system import SystemSetting
from app.models.task import (
    Client,
    Project,
    Task,
    TaskAssignee,
    TaskComment,
    TaskPriority,
    TaskStatus,
)
from app.models.user import User


@pytest.mark.asyncio
async def test_rbac_models(db_session: AsyncSession) -> None:
    """Test Role, Permission, and Many-to-Many association."""
    perm = Permission(code="attendance.view_all", description="View all attendance records")
    role = Role(name="HR Manager", description="Human Resources Manager", permissions=[perm])

    db_session.add(role)
    await db_session.commit()

    stmt = select(Role).where(Role.name == "HR Manager")
    result = await db_session.execute(stmt)
    loaded_role = result.scalar_one()

    assert loaded_role.id is not None
    assert isinstance(loaded_role.id, uuid.UUID)
    assert len(loaded_role.permissions) == 1
    assert loaded_role.permissions[0].code == "attendance.view_all"


@pytest.mark.asyncio
async def test_user_and_organization_models(db_session: AsyncSession) -> None:
    """Test User creation, department association, manager self-FK, and soft-delete."""
    role = Role(name="Employee")
    dept = Department(name="Engineering", description="Software development")
    db_session.add_all([role, dept])
    await db_session.flush()

    manager = User(
        employee_code="RA-001",
        email="manager@rightads.com",
        full_name="Lead Manager",
        password_hash="hashed_pw_here",
        role_id=role.id,
        department_id=dept.id,
    )
    db_session.add(manager)
    await db_session.flush()

    employee = User(
        employee_code="RA-002",
        email="employee@rightads.com",
        full_name="Staff Engineer",
        password_hash="hashed_pw_here",
        role_id=role.id,
        department_id=dept.id,
        manager_id=manager.id,
    )
    db_session.add(employee)
    await db_session.commit()

    stmt = select(User).where(User.employee_code == "RA-002")
    res = await db_session.execute(stmt)
    loaded_emp = res.scalar_one()

    assert loaded_emp.manager_id == manager.id
    assert loaded_emp.is_active is True
    assert loaded_emp.is_deleted is False

    # Test soft-delete functionality
    loaded_emp.soft_delete()
    await db_session.commit()

    assert loaded_emp.is_deleted is True
    assert loaded_emp.deleted_at is not None


@pytest.mark.asyncio
async def test_attendance_records_unique_constraint(db_session: AsyncSession) -> None:
    """Test attendance record uniqueness per user and date."""
    role = Role(name="Staff")
    db_session.add(role)
    await db_session.flush()

    user = User(
        employee_code="RA-010",
        email="staff@rightads.com",
        full_name="John Doe",
        password_hash="hashed_pw",
        role_id=role.id,
    )
    status_present = AttendanceStatus(code="PRESENT", label="Present", counts_as_present=True)
    db_session.add_all([user, status_present])
    await db_session.flush()

    today = datetime.date.today()
    record1 = AttendanceRecord(
        user_id=user.id,
        date=today,
        status_id=status_present.id,
        total_minutes=480,
    )
    db_session.add(record1)
    await db_session.commit()

    # Attempt duplicate attendance on same date for same user
    record2 = AttendanceRecord(
        user_id=user.id,
        date=today,
        status_id=status_present.id,
        total_minutes=480,
    )
    db_session.add(record2)
    with pytest.raises(IntegrityError):
        await db_session.commit()
    await db_session.rollback()


@pytest.mark.asyncio
async def test_task_domain_models(db_session: AsyncSession) -> None:
    """Test Client, Project, Task, Priorities, Statuses, and Assignees."""
    role = Role(name="ProjectManager")
    db_session.add(role)
    await db_session.flush()

    user = User(
        employee_code="RA-020",
        email="pm@rightads.com",
        full_name="Task Assigner",
        password_hash="hashed_pw",
        role_id=role.id,
    )
    client = Client(name="Acme Corp", contact_details={"email": "contact@acme.com"})
    db_session.add_all([user, client])
    await db_session.flush()

    project = Project(client_id=client.id, name="Q4 Brand Campaign")
    status_todo = TaskStatus(code="TODO", label="To Do", order=1)
    priority_high = TaskPriority(code="HIGH", label="High Priority", weight=3)
    db_session.add_all([project, status_todo, priority_high])
    await db_session.flush()

    task = Task(
        title="Design Social Ad Mockups",
        client_id=client.id,
        project_id=project.id,
        status_id=status_todo.id,
        priority_id=priority_high.id,
        assigned_by=user.id,
    )
    db_session.add(task)
    await db_session.flush()

    assignee = TaskAssignee(task_id=task.id, user_id=user.id)
    comment = TaskComment(task_id=task.id, user_id=user.id, comment="Initial briefing complete")
    db_session.add_all([assignee, comment])
    await db_session.commit()

    stmt = select(Task).where(Task.id == task.id)
    res = await db_session.execute(stmt)
    loaded_task = res.scalar_one()

    assert loaded_task.title == "Design Social Ad Mockups"
    assert loaded_task.priority.code == "HIGH"
    assert loaded_task.status.code == "TODO"


@pytest.mark.asyncio
async def test_system_settings_zero_hardcoding(db_session: AsyncSession) -> None:
    """Test SystemSetting key-value JSON storage for dynamic runtime configs."""
    setting = SystemSetting(
        key="EMPLOYEE_CODE_CONFIG",
        value={"prefix": "RA", "length": 4, "separator": "-"},
        description="Configuration for auto-generating employee codes",
    )
    db_session.add(setting)
    await db_session.commit()

    stmt = select(SystemSetting).where(SystemSetting.key == "EMPLOYEE_CODE_CONFIG")
    res = await db_session.execute(stmt)
    loaded_setting = res.scalar_one()

    assert loaded_setting.value["prefix"] == "RA"
    assert loaded_setting.value["length"] == 4
