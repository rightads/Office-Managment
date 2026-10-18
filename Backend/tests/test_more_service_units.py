from __future__ import annotations

import datetime
import uuid

import pytest
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import (
    BadRequestException,
)
from app.models.leave import LeaveType
from app.models.rbac import Role
from app.models.task import TaskPriority, TaskStatus
from app.models.user import User
from app.schemas.attendance import (
    CheckInRequest,
    CheckOutRequest,
)
from app.schemas.leave import AllocateAnnualBalancesRequest, LeaveApplyRequest
from app.schemas.task import (
    TaskCreateRequest,
    TaskUpdateRequest,
)
from app.services.attendance_report_service import AttendanceReportService
from app.services.attendance_service import AttendanceService
from app.services.bulk_import_service import BulkImportService
from app.services.leave_service import LeaveService
from app.services.task_service import TaskService
from app.utils.timezone import get_local_today, now_utc


@pytest.mark.asyncio
async def test_leave_service_comprehensive_unit(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise LeaveService calculation, validation rules, balances, and allocations."""
    emp, _ = employee_auth_headers
    service = LeaveService(db_session)
    today = get_local_today()

    # 1. calculate_working_days
    from_d = today + datetime.timedelta(days=1)
    to_d = today + datetime.timedelta(days=5)
    days_cnt, dates = await service.calculate_working_days(emp, from_d, to_d)
    assert days_cnt >= 0.0

    # 2. to_date < from_date raises BadRequestException
    lt = (await db_session.execute(select(LeaveType).limit(1))).scalar_one()
    with pytest.raises(BadRequestException):
        await service.apply_leave(
            emp,
            LeaveApplyRequest(
                leave_type_id=lt.id,
                from_date=today + datetime.timedelta(days=5),
                to_date=today + datetime.timedelta(days=2),
                is_half_day=False,
                reason="Invalid date order",
            ),
        )

    # 3. Half day multi-date raises BadRequestException
    with pytest.raises(BadRequestException):
        await service.apply_leave(
            emp,
            LeaveApplyRequest(
                leave_type_id=lt.id,
                from_date=today + datetime.timedelta(days=2),
                to_date=today + datetime.timedelta(days=3),
                is_half_day=True,
                half_day_session="first_half",
                reason="Invalid multi-date half day",
            ),
        )

    # 4. Balances query
    balances = await service.get_my_balances(emp, today.year)
    assert isinstance(balances, list)

    # 5. Annual quota allocation
    admin_role = (await db_session.execute(select(Role).where(Role.name == "Admin"))).scalar_one()
    admin_user = User(
        employee_code="ADMIN-LEAVE-01",
        email=f"admin.leave.{uuid.uuid4().hex[:6]}@agency.com",
        full_name="Admin Leave Allocator",
        password_hash="fakehash123",
        role_id=admin_role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(admin_user)
    await db_session.commit()

    alloc_req = AllocateAnnualBalancesRequest(year=today.year + 1)
    allocated_resp = await service.allocate_annual_balances(alloc_req, actor=admin_user)
    assert allocated_resp.users_processed >= 0


@pytest.mark.asyncio
async def test_task_service_comprehensive_unit(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise TaskService creation, updates, comments, and summary reports."""
    emp, _ = employee_auth_headers
    service = TaskService(db_session)

    priority = (await db_session.execute(select(TaskPriority).limit(1))).scalar_one()
    status = (await db_session.execute(select(TaskStatus).limit(1))).scalar_one()

    # 1. Create Task
    req = TaskCreateRequest(
        title="Unit Test Task Extra",
        description="Comprehensive task test",
        priority_id=priority.id,
        status_id=status.id,
        assignee_ids=[emp.id],
        due_at=now_utc() + datetime.timedelta(days=2),
    )
    task_resp = await service.create_task(req, creator=emp)
    assert task_resp.title == "Unit Test Task Extra"
    assert len(task_resp.assignees) == 1

    # 2. Update Task
    up_req = TaskUpdateRequest(
        title="Unit Test Task Extra Renamed",
        description="Updated description",
    )
    task_up = await service.update_task(task_resp.id, up_req, actor=emp)
    assert task_up.title == "Unit Test Task Extra Renamed"

    # 3. Add Comment
    comment_resp = await service.add_comment(
        task_id=task_resp.id,
        comment_text="Testing comment from unit test.",
        author=emp,
        can_view_all=True,
    )
    assert comment_resp.comment == "Testing comment from unit test."

    # 4. Summary Reports
    reports = await service.get_summary_reports()
    assert reports.total_tasks >= 1


@pytest.mark.asyncio
async def test_attendance_service_comprehensive_unit(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise AttendanceService mock detection, check-out without check-in, today, and calendar."""
    emp, _ = employee_auth_headers
    service = AttendanceService(db_session)

    # 1. Anti-spoofing rejection
    with pytest.raises(BadRequestException):
        await service.check_in(
            emp.id,
            CheckInRequest(
                latitude=12.9716,
                longitude=77.5946,
                device_id="some_device",
                is_mock_location=True,
            ),
        )

    # 2. Check out without check-in raises BadRequestException
    with pytest.raises(BadRequestException):
        await service.check_out(
            emp.id,
            CheckOutRequest(
                latitude=12.9716,
                longitude=77.5946,
                device_id="some_device",
            ),
        )

    # 3. Get today record
    today_resp = await service.get_today(emp.id)
    assert today_resp.date is not None

    # 4. Get monthly calendar
    today = get_local_today()
    cal = await service.get_calendar(emp.id, today.year, today.month)
    assert cal.month == today.month

    # 5. Reset device
    await service.reset_device(emp.id, actor_id=emp.id)


@pytest.mark.asyncio
async def test_attendance_report_service_unit(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise AttendanceReportService today dashboard, monthly report, and matrix."""
    emp, _ = employee_auth_headers
    admin_role = (await db_session.execute(select(Role).where(Role.name == "Admin"))).scalar_one()
    admin_user = User(
        employee_code="ADMIN-REP-01",
        email=f"admin.rep.{uuid.uuid4().hex[:6]}@agency.com",
        full_name="Admin Rep",
        password_hash="fakehash123",
        role_id=admin_role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(admin_user)
    await db_session.commit()

    report_service = AttendanceReportService(db_session)
    today = get_local_today()

    # 1. Today dashboard
    dash = await report_service.get_today_dashboard(current_user=admin_user)
    assert dash.total_active_employees >= 1

    # 2. Employee monthly report
    month_rep = await report_service.get_employee_monthly(
        current_user=admin_user,
        employee_id=emp.id,
        month=today.month,
        year=today.year,
    )
    assert month_rep.employee_id == emp.id

    # 3. Monthly overview matrix
    matrix = await report_service.get_monthly_overview(
        current_user=admin_user,
        month=today.month,
        year=today.year,
    )
    assert matrix.year == today.year
    assert matrix.month == today.month


@pytest.mark.asyncio
async def test_bulk_import_service_unit(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise BulkImportService validation and dry-run importing."""
    emp, _ = employee_auth_headers
    service = BulkImportService(db_session)

    csv_data = (
        "full_name,email,role,designation,phone\n"
        "Bulk Person One,bulk.p1@agency.com,Tele sales,Executive,+919999911111\n"
        "Bulk Person Two,bulk.p2@agency.com,Tele sales,Senior Executive,+919999922222\n"
    )

    summary = await service.import_employees_csv(csv_data, actor_id=emp.id, dry_run=True)
    assert summary.total_rows == 2
    assert summary.successful_imports == 2
    assert summary.dry_run is True
