from __future__ import annotations

import datetime
import uuid

import pytest
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import (
    BadRequestException,
    ConflictException,
    UnauthorizedException,
)
from app.models.organization import Department, Holiday, OfficeLocation
from app.models.rbac import Role
from app.models.user import User
from app.schemas.employee import (
    EmployeeCreate,
    EmployeeSelfUpdate,
    EmployeeUpdate,
)
from app.schemas.master_data import (
    AttendancePolicyCreate,
    AttendancePolicyUpdate,
    ClientCreate,
    ClientUpdate,
    DepartmentCreate,
    DepartmentUpdate,
    HolidayCreate,
    HolidayUpdate,
    OfficeLocationCreate,
    OfficeLocationUpdate,
    ProjectCreate,
    ProjectUpdate,
    RoleCreate,
    RoleUpdate,
    TaskPriorityCreate,
    TaskPriorityUpdate,
    TaskStatusCreate,
    TaskStatusUpdate,
)
from app.services.auth_service import AuthService
from app.services.employee_service import EmployeeService
from app.services.master_data_service import MasterDataService
from app.utils.timezone import get_local_today


@pytest.mark.asyncio
async def test_master_data_service_roles(db_session: AsyncSession) -> None:
    """Exercise MasterDataService role operations and validation edge cases."""
    service = MasterDataService(db_session)
    actor_id = uuid.uuid4()

    # 1. Create Role
    r_create = RoleCreate(
        name="Unit Test Role",
        description="Testing role creation",
        permission_codes=[],
    )
    role = await service.create_role(r_create, actor_id=actor_id)
    assert role.name == "Unit Test Role"

    # 2. Duplicate role raises ConflictException
    with pytest.raises(ConflictException):
        await service.create_role(r_create, actor_id=actor_id)

    # 3. Update Role
    r_up = RoleUpdate(name="Updated Unit Role", description="Updated description")
    updated = await service.update_role(role.id, r_up, actor_id=actor_id)
    assert updated.name == "Updated Unit Role"

    # 4. Get Role via repo
    fetched = await service.repo.get_role_by_id(role.id)
    assert fetched is not None
    assert fetched.name == "Updated Unit Role"

    # 5. Delete Role
    await service.delete_role(role.id, actor_id=actor_id)
    fetched_after = await service.repo.get_role_by_id(role.id)
    assert fetched_after is None


@pytest.mark.asyncio
async def test_master_data_service_departments_and_locations(db_session: AsyncSession) -> None:
    """Exercise Department and Office Location CRUD."""
    service = MasterDataService(db_session)
    actor_id = uuid.uuid4()

    # 1. Department
    d_create = DepartmentCreate(name="Unit Test Dept", description="Test Dept")
    dept = await service.create_department(d_create, actor_id=actor_id)
    assert dept.name == "Unit Test Dept"

    with pytest.raises(ConflictException):
        await service.create_department(d_create, actor_id=actor_id)

    d_up = DepartmentUpdate(name="Unit Test Dept Renamed")
    dept_up = await service.update_department(dept.id, d_up, actor_id=actor_id)
    assert dept_up.name == "Unit Test Dept Renamed"

    depts, count = await service.repo.list_paginated(Department)
    assert count >= 1

    await service.delete_department(dept.id, actor_id=actor_id)

    # 2. Office Location
    loc_create = OfficeLocationCreate(
        name="Unit Test Office",
        address="123 Unit Ave",
        latitude=12.9716,
        longitude=77.5946,
        radius_meters=150,
    )
    loc = await service.create_office_location(loc_create, actor_id=actor_id)
    assert loc.radius_meters == 150

    loc_up = OfficeLocationUpdate(radius_meters=200)
    loc_updated = await service.update_office_location(loc.id, loc_up, actor_id=actor_id)
    assert loc_updated.radius_meters == 200

    locs, loc_count = await service.repo.list_paginated(OfficeLocation)
    assert loc_count >= 1


@pytest.mark.asyncio
async def test_master_data_service_holidays_and_policies(db_session: AsyncSession) -> None:
    """Exercise Holiday and Attendance Policy CRUD."""
    service = MasterDataService(db_session)
    actor_id = uuid.uuid4()

    # 1. Holiday
    today = get_local_today()
    h_create = HolidayCreate(
        name="Unit Test Day",
        date=today + datetime.timedelta(days=100),
        is_optional=False,
    )
    holiday = await service.create_holiday(h_create, actor_id=actor_id)
    assert holiday.name == "Unit Test Day"

    h_up = HolidayUpdate(name="Updated Holiday Day")
    h_updated = await service.update_holiday(holiday.id, h_up, actor_id=actor_id)
    assert h_updated.name == "Updated Holiday Day"

    holidays, h_count = await service.repo.list_paginated(Holiday)
    assert h_count >= 1

    # 2. Attendance Policy
    pol_create = AttendancePolicyCreate(
        name="Unit Flexible Shift",
        shift_start=datetime.time(9, 30),
        shift_end=datetime.time(18, 30),
        grace_minutes=20,
        half_day_min_hours=4.0,
        full_day_min_hours=8.0,
        week_off_days=[6],
    )
    policy = await service.create_attendance_policy(pol_create, actor_id=actor_id)
    assert policy.grace_minutes == 20

    pol_up = AttendancePolicyUpdate(grace_minutes=25)
    pol_updated = await service.update_attendance_policy(policy.id, pol_up, actor_id=actor_id)
    assert pol_updated.grace_minutes == 25

    from app.models.attendance import AttendancePolicy

    pols, p_count = await service.repo.list_paginated(AttendancePolicy)
    assert p_count >= 1


@pytest.mark.asyncio
async def test_master_data_service_task_elements(db_session: AsyncSession) -> None:
    """Exercise TaskStatus, TaskPriority, Clients, Projects, and Transitions."""
    service = MasterDataService(db_session)
    actor_id = uuid.uuid4()

    # 1. Task Status
    ts_create = TaskStatusCreate(
        code="UNIT_STATUS_XYZ",
        label="Unit Status",
        order=50,
        color="#00AA00",
        is_terminal=False,
    )
    status_obj = await service.create_task_status(ts_create, actor_id=actor_id)
    assert status_obj.code == "UNIT_STATUS_XYZ"

    ts_up = TaskStatusUpdate(color="#00CC00")
    status_up = await service.update_task_status(status_obj.id, ts_up, actor_id=actor_id)
    assert status_up.color == "#00CC00"

    # 2. Task Priority
    tp_create = TaskPriorityCreate(
        code="UNIT_CRITICAL_XYZ",
        label="Unit Critical",
        weight=99,
        color="#FF0000",
    )
    priority = await service.create_task_priority(tp_create, actor_id=actor_id)
    assert priority.weight == 99

    tp_up = TaskPriorityUpdate(weight=95)
    pri_up = await service.update_task_priority(priority.id, tp_up, actor_id=actor_id)
    assert pri_up.weight == 95

    # 3. Client & Project
    c_create = ClientCreate(
        name="Unit Test Client Ltd",
        email="client@test.com",
        phone="+1234567890",
    )
    client = await service.create_client(c_create, actor_id=actor_id)
    assert client.name == "Unit Test Client Ltd"

    c_up = ClientUpdate(email="updated_client@test.com")
    client_up = await service.update_client(client.id, c_up, actor_id=actor_id)
    assert client_up.contact_details.get("email") == "updated_client@test.com"

    proj_create = ProjectCreate(
        client_id=client.id,
        name="Unit Test Project Alpha",
        description="Alpha project",
    )
    project = await service.create_project(proj_create, actor_id=actor_id)
    assert project.name == "Unit Test Project Alpha"

    proj_up = ProjectUpdate(name="Unit Test Project Beta")
    proj_updated = await service.update_project(project.id, proj_up, actor_id=actor_id)
    assert proj_updated.name == "Unit Test Project Beta"

    # 4. System Settings
    setting = await service.repo.upsert_setting(
        key="unit_test_dynamic_param",
        value={"enabled": True, "threshold": 42},
        description="Setting for unit test",
    )
    assert setting.key == "unit_test_dynamic_param"

    val = await service.repo.get_setting("unit_test_dynamic_param")
    assert val is not None


@pytest.mark.asyncio
async def test_employee_service_comprehensive(
    db_session: AsyncSession,
    admin_auth_headers: dict[str, str],
) -> None:
    """Exercise EmployeeService creation, self-update, deactivation, and protections."""
    service = EmployeeService(db_session)

    role = (await db_session.execute(select(Role).where(Role.name == "Tele sales"))).scalar_one()
    actor = (
        await db_session.execute(select(User).where(User.employee_code == "ADMIN-001"))
    ).scalar_one()

    # 1. Create employee
    req = EmployeeCreate(
        email="unit.emp.001@agency.com",
        full_name="Unit Employee One",
        role_id=role.id,
        phone_number="+919999988888",
        designation="Junior Specialist",
    )
    emp_resp, temp_pwd = await service.create_employee(req, actor_id=actor.id)
    assert emp_resp.email == "unit.emp.001@agency.com"
    assert len(temp_pwd) > 8

    # 2. Duplicate email rejected
    with pytest.raises(ConflictException):
        await service.create_employee(req, actor_id=actor.id)

    # 3. Update employee
    up_req = EmployeeUpdate(
        full_name="Unit Employee Modified",
        phone_number="+919999977777",
    )
    updated = await service.update_employee(emp_resp.id, up_req, actor_id=actor.id)
    assert updated.full_name == "Unit Employee Modified"

    # 4. Self update
    self_up = EmployeeSelfUpdate(phone_number="+919999966666")
    self_res = await service.self_update_profile(emp_resp.id, self_up)
    assert self_res.phone_number == "+919999966666"

    # 5. Admin reset password
    new_pwd = await service.admin_reset_password(
        emp_resp.id, new_password="BrandNewSecretPass123!#", actor_id=actor.id
    )
    assert len(new_pwd) > 8

    # 6. Deactivate employee
    deactivated = await service.deactivate_employee(emp_resp.id, actor_id=actor.id)
    assert deactivated.is_active is False


@pytest.mark.asyncio
async def test_auth_service_edge_cases(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise AuthService session refresh, password change rules, and invalid tokens."""
    service = AuthService(db_session)
    emp, _ = employee_auth_headers

    # 1. Change password with incorrect current password
    with pytest.raises(UnauthorizedException):
        await service.change_password(
            user=emp,
            current_password="IncorrectCurrentPassword123!",
            new_password="NewValidPassword123!#",
        )

    # 2. Refresh non-existent token raises exception
    with pytest.raises(UnauthorizedException):
        await service.refresh_tokens(raw_refresh_token="non_existent_fake_token_123")

    # 3. Reset password with invalid token
    with pytest.raises(BadRequestException):
        await service.reset_password(token="invalid_token_xyz", new_password="NewPassword123!#")
