from __future__ import annotations

import datetime
import uuid

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.security import hash_password
from app.models.leave import LeaveType
from app.models.organization import Department
from app.models.rbac import Role
from app.models.task import TaskPriority, TaskStatus
from app.models.user import User
from app.schemas.attendance import (
    AttendanceCorrectionRequest,
    CheckInRequest,
    CheckOutRequest,
)
from app.schemas.employee import EmployeeSelfUpdate, EmployeeUpdate
from app.schemas.leave import (
    AllocateAnnualBalancesRequest,
    LeaveApplyRequest,
    LeaveRejectRequest,
    LeaveReviewRequest,
)
from app.schemas.task import (
    TaskAssignRequest,
    TaskCreateRequest,
    TaskStatusTransitionRequest,
)
from app.services.attendance_service import AttendanceService
from app.services.auth_service import AuthService
from app.services.bulk_import_service import BulkImportService
from app.services.employee_service import EmployeeService
from app.services.leave_service import LeaveService
from app.services.task_service import TaskService
from app.utils.timezone import get_local_today, now_utc
from tests.conftest import _async_seed_defaults, _async_seed_permissions


async def _get_or_create_admin(db_session: AsyncSession) -> User:
    await _async_seed_permissions(session=db_session)
    await _async_seed_defaults(session=db_session)
    admin_role = (await db_session.execute(select(Role).where(Role.name == "Admin"))).scalar_one()
    admin_user = (
        await db_session.execute(select(User).where(User.email == "coverage_admin@agency.com"))
    ).scalar_one_or_none()
    if not admin_user:
        admin_user = User(
            employee_code="COV-ADMIN-01",
            email="coverage_admin@agency.com",
            full_name="Coverage Admin",
            password_hash=hash_password("SuperSecretAdmin123!#"),
            role_id=admin_role.id,
            is_active=True,
            must_change_password=False,
        )
        db_session.add(admin_user)
        await db_session.commit()
    return admin_user


@pytest.mark.asyncio
async def test_auth_service_full_cycle(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise AuthService login, token refresh, and revocations."""
    emp, _ = employee_auth_headers
    service = AuthService(db_session)

    # 1. Successful authentication
    user, access_tok, refresh_tok = await service.authenticate_user(
        email=emp.email,
        password="EmployeeSecret123!#",
    )
    assert access_tok is not None
    assert refresh_tok is not None
    assert user.id == emp.id

    # 2. Token refresh
    new_acc, new_ref = await service.refresh_tokens(
        raw_refresh_token=refresh_tok,
    )
    assert new_acc is not None
    assert new_ref is not None

    # 3. Revoke single token
    await service.revoke_refresh_token(new_ref)

    # 4. Revoke all user tokens
    await service.revoke_all_user_tokens(emp.id)

    # 5. Password reset request
    await service.request_password_reset(emp.email)


@pytest.mark.asyncio
async def test_employee_service_full_cycle(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise EmployeeService get, list, self update, admin update, and deactivation."""
    emp, _ = employee_auth_headers
    admin_user = await _get_or_create_admin(db_session)
    service = EmployeeService(db_session)

    # 1. Get employee detail
    detail = await service.get_employee(emp.id)
    assert detail.id == emp.id
    assert detail.email == emp.email

    # 2. List employees
    employees, total = await service.list_employees(page=1, page_size=10, is_active=True)
    assert total >= 1
    assert len(employees) >= 1

    # 3. Self update profile
    self_up = await service.self_update_profile(
        user_id=emp.id,
        payload=EmployeeSelfUpdate(phone_number="+919876543210"),
    )
    assert self_up.phone_number == "+919876543210"

    # 4. Admin update employee
    admin_up = await service.update_employee(
        user_id=emp.id,
        payload=EmployeeUpdate(designation="Senior Executive Lead"),
        actor_id=admin_user.id,
    )
    assert admin_up.designation == "Senior Executive Lead"

    # 5. Deactivate and reactivate
    await service.deactivate_employee(user_id=emp.id, actor_id=admin_user.id)
    await service.activate_employee(user_id=emp.id, actor_id=admin_user.id)


@pytest.mark.asyncio
async def test_leave_service_full_workflow(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise LeaveService allocations, approvals, rejections, and cancellations."""
    emp, _ = employee_auth_headers
    admin_user = await _get_or_create_admin(db_session)
    service = LeaveService(db_session)
    today = get_local_today()

    # 1. Allocate balances
    await service.allocate_annual_balances(
        AllocateAnnualBalancesRequest(year=today.year),
        actor=admin_user,
    )

    # 2. Apply and approve
    lt = (await db_session.execute(select(LeaveType).limit(1))).scalar_one()
    from_d = today + datetime.timedelta(days=10)
    to_d = today + datetime.timedelta(days=11)

    leave_req1 = await service.apply_leave(
        user=emp,
        payload=LeaveApplyRequest(
            leave_type_id=lt.id,
            from_date=from_d,
            to_date=to_d,
            is_half_day=False,
            reason="Planned personal leaves",
        ),
    )
    assert leave_req1.status == "pending"

    approved = await service.approve_leave(
        leave_id=leave_req1.id,
        actor=admin_user,
        payload=LeaveReviewRequest(review_note="Approved by management"),
    )
    assert approved.status == "approved"

    # 3. Apply and reject
    from_d2 = today + datetime.timedelta(days=20)
    to_d2 = today + datetime.timedelta(days=21)
    leave_req2 = await service.apply_leave(
        user=emp,
        payload=LeaveApplyRequest(
            leave_type_id=lt.id,
            from_date=from_d2,
            to_date=to_d2,
            is_half_day=False,
            reason="Another trip",
        ),
    )
    rejected = await service.reject_leave(
        leave_id=leave_req2.id,
        actor=admin_user,
        payload=LeaveRejectRequest(review_note="Peak marketing client launch"),
    )
    assert rejected.status == "rejected"

    # 4. Apply and cancel by employee
    from_d3 = today + datetime.timedelta(days=30)
    to_d3 = today + datetime.timedelta(days=30)
    leave_req3 = await service.apply_leave(
        user=emp,
        payload=LeaveApplyRequest(
            leave_type_id=lt.id,
            from_date=from_d3,
            to_date=to_d3,
            is_half_day=False,
            reason="Cancelled doctor appointment",
        ),
    )
    cancelled = await service.cancel_pending_leave(leave_id=leave_req3.id, actor=emp)
    assert cancelled.status == "cancelled"

    # 5. List and get leaves
    leaves = await service.list_leaves(current_user=admin_user, page=1, size=10)
    assert leaves.total >= 3

    single = await service.get_leave_by_id(leave_id=leave_req1.id, current_user=emp)
    assert single.id == leave_req1.id

    types = await service.list_active_leave_types()
    assert len(types) >= 1


@pytest.mark.asyncio
async def test_task_service_full_workflow(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise TaskService detail, assign, status update, timeline, comments, and archive."""
    emp, _ = employee_auth_headers
    admin_user = await _get_or_create_admin(db_session)
    service = TaskService(db_session)

    priority = (await db_session.execute(select(TaskPriority).limit(1))).scalar_one()
    statuses = (
        (await db_session.execute(select(TaskStatus).order_by(TaskStatus.order))).scalars().all()
    )
    initial_status = statuses[0]
    next_status = statuses[1] if len(statuses) > 1 else statuses[0]

    # 1. Create task
    task = await service.create_task(
        payload=TaskCreateRequest(
            title="Complete Agency Deliverable",
            description="Client deliverable execution",
            priority_id=priority.id,
            status_id=initial_status.id,
            assignee_ids=[emp.id],
            due_at=now_utc() + datetime.timedelta(days=5),
        ),
        creator=admin_user,
    )
    assert task.title == "Complete Agency Deliverable"

    # 2. Get detail
    detail = await service.get_task_detail(task_id=task.id, current_user=emp, can_view_all=True)
    assert detail.id == task.id

    # 3. Assign task
    assigned = await service.assign_task(
        task_id=task.id,
        payload=TaskAssignRequest(assignee_ids=[emp.id, admin_user.id], replace=True),
        actor=admin_user,
    )
    assert len(assigned.assignees) == 2

    # 4. Status update
    updated_status = await service.update_status(
        task_id=task.id,
        payload=TaskStatusTransitionRequest(
            to_status_id=next_status.id,
            remarks="Moved to in progress",
        ),
        actor=emp,
        user_permissions={"task.update"},
        can_view_all=True,
    )
    assert updated_status.status.id == next_status.id

    # 5. Timeline and comments list
    timeline = await service.get_timeline(task_id=task.id, current_user=emp, can_view_all=True)
    assert len(timeline) >= 1

    comments = await service.list_comments(task_id=task.id, current_user=emp, can_view_all=True)
    assert isinstance(comments, list)

    # 6. Archive
    await service.archive_task(task_id=task.id, actor=admin_user)


@pytest.mark.asyncio
async def test_bulk_import_real_insert(
    db_session: AsyncSession,
) -> None:
    """Exercise BulkImportService actual database insertion."""
    admin_user = await _get_or_create_admin(db_session)
    service = BulkImportService(db_session)

    unique_suffix = uuid.uuid4().hex[:6]
    csv_data = (
        "full_name,email,role,designation,phone\n"
        f"Imported Alpha,alpha.{unique_suffix}@agency.com,Graphic designer,Designer,+919988112233\n"
        f"Imported Beta,beta.{unique_suffix}@agency.com,Website designer,UI UX,+919988223344\n"
    )

    report = await service.import_employees_csv(
        csv_content=csv_data,
        actor_id=admin_user.id,
        dry_run=False,
    )
    assert report.total_rows == 2
    assert report.successful_imports == 2
    assert report.failed_rows == 0


@pytest.mark.asyncio
async def test_attendance_service_checkin_checkout_happy_path(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Exercise AttendanceService check-in, check-out, and manual correction."""
    emp, _ = employee_auth_headers
    admin_user = await _get_or_create_admin(db_session)
    service = AttendanceService(db_session)

    # 0. Adjust policy for test
    policy = await service.repo.get_effective_policy(emp)
    if policy:
        policy.require_geofence = False
        policy.require_selfie = False
        await db_session.commit()

    # 1. Check in at Bangalore office coordinates
    checkin_payload = CheckInRequest(
        latitude=12.9716,
        longitude=77.5946,
        device_id="emp_phone_123",
        is_mock_location=False,
    )
    record = await service.check_in(user_id=emp.id, payload=checkin_payload)
    assert record.user_id == emp.id
    assert record.check_in_at is not None

    # 2. Check out
    checkout_payload = CheckOutRequest(
        latitude=12.9716,
        longitude=77.5946,
        device_id="emp_phone_123",
        remarks="Leaving for the day",
    )
    checkout_record = await service.check_out(user_id=emp.id, payload=checkout_payload)
    assert checkout_record.check_out_at is not None

    # 3. Manual correction
    correction_payload = AttendanceCorrectionRequest(
        reason="Missed checkout timestamp adjustment",
        remarks="Adjusted by admin",
    )
    corrected = await service.manual_correction(
        record_id=record.id,
        payload=correction_payload,
        actor_id=admin_user.id,
    )
    assert corrected.attendance_id == record.id


@pytest.mark.asyncio
async def test_roles_and_master_endpoints_via_api(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """Exercise Roles, Permissions, Task Master, and System Settings API routes."""
    # 1. Permissions list
    res = await async_client.get("/api/v1/permissions", headers=admin_auth_headers)
    assert res.status_code == 200

    # 2. Roles list
    res = await async_client.get("/api/v1/roles", headers=admin_auth_headers)
    assert res.status_code == 200
    roles = res.json()["items"]
    admin_r = next(r for r in roles if r["name"] == "Admin")

    # 3. Get role detail
    res = await async_client.get(f"/api/v1/roles/{admin_r['id']}", headers=admin_auth_headers)
    assert res.status_code == 200

    # 4. Create custom role, update it, and delete it
    res = await async_client.post(
        "/api/v1/roles",
        headers=admin_auth_headers,
        json={
            "name": "Temp Test Role",
            "description": "Temp role for coverage",
            "permission_ids": [],
        },
    )
    assert res.status_code == 201
    new_role = res.json()

    res = await async_client.patch(
        f"/api/v1/roles/{new_role['id']}",
        headers=admin_auth_headers,
        json={"description": "Updated temp description"},
    )
    assert res.status_code == 200

    res = await async_client.delete(f"/api/v1/roles/{new_role['id']}", headers=admin_auth_headers)
    assert res.status_code == 200

    # 5. Task master endpoints
    res = await async_client.get("/api/v1/task-statuses", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.get("/api/v1/task-priorities", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.post(
        "/api/v1/clients",
        headers=admin_auth_headers,
        json={"name": "New Coverage Client", "email": "client@cov.com"},
    )
    assert res.status_code == 201
    client_id = res.json()["id"]

    res = await async_client.get("/api/v1/clients", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.post(
        "/api/v1/projects",
        headers=admin_auth_headers,
        json={"name": "New Coverage Project", "client_id": client_id},
    )
    assert res.status_code == 201

    res = await async_client.get("/api/v1/projects", headers=admin_auth_headers)
    assert res.status_code == 200

    # 6. System settings & audit logs
    res = await async_client.get("/api/v1/system-settings", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.get("/api/v1/audit-logs", headers=admin_auth_headers)
    assert res.status_code == 200


@pytest.mark.asyncio
async def test_master_data_and_communication_routes(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """Exercise master data (departments, locations, holidays, policies) and communications routes."""
    # 1. Departments
    res = await async_client.get("/api/v1/departments", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.post(
        "/api/v1/departments",
        headers=admin_auth_headers,
        json={"name": "New Agency Dept", "code": "NAD", "description": "New department"},
    )
    assert res.status_code == 201

    # 2. Office Locations
    res = await async_client.get("/api/v1/office-locations", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.post(
        "/api/v1/office-locations",
        headers=admin_auth_headers,
        json={
            "name": "Mumbai Branch",
            "latitude": 19.0760,
            "longitude": 72.8777,
            "radius_meters": 200,
        },
    )
    assert res.status_code == 201

    # 3. Holidays
    res = await async_client.get("/api/v1/holidays", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.post(
        "/api/v1/holidays",
        headers=admin_auth_headers,
        json={"name": "Founders Day", "date": "2026-11-15", "is_optional": False},
    )
    assert res.status_code == 201

    # 4. Attendance Policies & Statuses & Leave Types
    res = await async_client.get("/api/v1/attendance-policies", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.get("/api/v1/attendance-statuses", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.get("/api/v1/leave-types", headers=admin_auth_headers)
    assert res.status_code == 200

    # 5. Announcements
    res = await async_client.get("/api/v1/announcements", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.post(
        "/api/v1/announcements",
        headers=admin_auth_headers,
        json={"title": "Agency Town Hall", "body": "All hands on Friday at 4 PM."},
    )
    assert res.status_code == 201

    # 6. Notifications
    res = await async_client.get("/api/v1/notifications", headers=admin_auth_headers)
    assert res.status_code == 200

    res = await async_client.get("/api/v1/notifications/unread-count", headers=admin_auth_headers)
    assert res.status_code == 200


@pytest.mark.asyncio
async def test_schedulers_direct_units(db_session: AsyncSession) -> None:
    """Exercise background scheduler tasks for attendance and task reminders directly."""
    from app.services.attendance_scheduler import (
        auto_close_unclosed_checkouts,
        nightly_attendance_processor,
    )
    from app.services.task_scheduler import send_due_soon_reminders

    # Nightly attendance processor
    count = await nightly_attendance_processor(db_session)
    assert count >= 0

    # Auto-close checkouts
    closed = await auto_close_unclosed_checkouts(db_session)
    assert closed >= 0

    # Task due soon reminders
    reminders = await send_due_soon_reminders(db_session)
    assert reminders >= 0


@pytest.mark.asyncio
async def test_base_repository_crud(db_session: AsyncSession) -> None:
    """Exercise BaseRepository CRUD operations."""
    from app.repositories.base import BaseRepository

    repo = BaseRepository(Department, db_session)
    dept = Department(name=f"Base Repo Test Dept {uuid.uuid4().hex[:4]}", description="Some desc")
    created = await repo.create(dept)
    assert created.id is not None

    fetched = await repo.get_by_id(created.id)
    assert fetched is not None
    assert fetched.name == dept.name

    items, total = await repo.list_paginated(offset=0, limit=10)
    assert total >= 1

    created.description = "Updated description"
    updated = await repo.update(created)
    assert updated.description == "Updated description"

    # Department does not inherit SoftDeleteMixin, raises NotImplementedError
    with pytest.raises(NotImplementedError):
        await repo.soft_delete(created)

    # User inherits SoftDeleteMixin
    admin = await _get_or_create_admin(db_session)
    user_repo = BaseRepository(User, db_session)
    test_u = User(
        employee_code=f"SD-{uuid.uuid4().hex[:4]}",
        email=f"sd.{uuid.uuid4().hex[:4]}@agency.com",
        full_name="Soft Delete Tester",
        password_hash="fake",
        role_id=admin.role_id,
    )
    await user_repo.create(test_u)
    await user_repo.soft_delete(test_u)
    assert test_u.is_deleted is True


def test_logging_formatting() -> None:
    """Exercise JSONFormatter and setup_logging."""
    import logging
    import sys

    from app.core.logging import JSONFormatter, setup_logging

    setup_logging(debug=True)
    formatter = JSONFormatter()

    record = logging.LogRecord(
        name="test_logger",
        level=logging.INFO,
        pathname=__file__,
        lineno=10,
        msg="Test message %s",
        args=("arg1",),
        exc_info=None,
    )
    formatted = formatter.format(record)
    assert "Test message arg1" in formatted

    # With exception
    try:
        raise ValueError("Boom")
    except ValueError:
        record_exc = logging.LogRecord(
            name="test_logger",
            level=logging.ERROR,
            pathname=__file__,
            lineno=20,
            msg="Error occurred",
            args=(),
            exc_info=sys.exc_info(),
        )
        formatted_exc = formatter.format(record_exc)
        assert "Boom" in formatted_exc


@pytest.mark.asyncio
async def test_redis_helpers() -> None:
    """Exercise Redis cache graceful degradation helpers."""
    from app.core.redis import close_redis, get_cache, invalidate_cache_pattern, set_cache

    val = await get_cache("non_existent_key")
    assert val is None or isinstance(val, str)

    res = await set_cache("test_key", "test_val", 60)
    assert isinstance(res, bool)

    inv = await invalidate_cache_pattern("test:*")
    assert isinstance(inv, int)

    await close_redis()
