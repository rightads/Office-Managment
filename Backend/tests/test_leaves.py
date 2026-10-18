from __future__ import annotations

import datetime

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.attendance import AttendanceRecord, AttendanceStatus
from app.models.communication import Notification
from app.models.leave import LeaveBalance, LeaveType
from app.models.organization import Holiday
from app.models.user import User
from app.utils.timezone import get_local_today


@pytest.mark.asyncio
async def test_list_leave_types(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Ensure any active authenticated employee can list active leave types."""
    _, headers = employee_auth_headers
    resp = await async_client.get("/api/v1/leaves/types", headers=headers)
    assert resp.status_code == 200
    types = resp.json()
    assert len(types) >= 2
    type_names = [t["name"] for t in types]
    assert "Casual Leave" in type_names
    assert "Sick Leave" in type_names


@pytest.mark.asyncio
async def test_apply_leave_and_balance_validation(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Verify leave application flow and balance validation."""
    emp, headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    # Allocate 5 days to employee
    balance = LeaveBalance(
        user_id=emp.id,
        leave_type_id=casual_type.id,
        year=today.year,
        allocated=5.0,
        carried_forward=0.0,
        used=0.0,
    )
    db_session.add(balance)
    await db_session.commit()

    # Find next Tuesday to Wednesday (2 working days)
    days_ahead = (1 - today.weekday() + 7) % 7
    if days_ahead == 0:
        days_ahead = 7
    next_tue = today + datetime.timedelta(days=days_ahead)
    next_wed = next_tue + datetime.timedelta(days=1)

    # 1. Apply for 2 days -> 201 Created
    apply_payload = {
        "leave_type_id": str(casual_type.id),
        "from_date": next_tue.isoformat(),
        "to_date": next_wed.isoformat(),
        "is_half_day": False,
        "reason": "Family vacation",
    }
    resp = await async_client.post("/api/v1/leaves/apply", json=apply_payload, headers=headers)
    assert resp.status_code == 201
    data = resp.json()
    assert data["status"] == "pending"
    assert data["total_days"] == 2.0
    assert data["user_id"] == str(emp.id)

    # 2. Check my balances
    bal_resp = await async_client.get(
        f"/api/v1/leaves/my-balances?year={today.year}", headers=headers
    )
    assert bal_resp.status_code == 200
    user_bals = bal_resp.json()
    cl_bal = next(b for b in user_bals if b["leave_type_name"] == "Casual Leave")
    assert cl_bal["allocated"] == 5.0
    # used is still 0 because leave is pending
    assert cl_bal["used"] == 0.0

    # 3. Apply for 10 days -> 400 Bad Request (exceeds 5 available)
    far_future = today + datetime.timedelta(days=60)
    far_future_end = far_future + datetime.timedelta(days=15)
    exceed_payload = {
        "leave_type_id": str(casual_type.id),
        "from_date": far_future.isoformat(),
        "to_date": far_future_end.isoformat(),
        "is_half_day": False,
        "reason": "Exceeding available balance",
    }
    resp_exceed = await async_client.post(
        "/api/v1/leaves/apply", json=exceed_payload, headers=headers
    )
    assert resp_exceed.status_code == 400
    assert "Insufficient leave balance" in resp_exceed.json()["error"]["message"]


@pytest.mark.asyncio
async def test_apply_leave_half_day(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Verify single-day half day leave validations."""
    emp, headers = employee_auth_headers
    today = get_local_today()

    sick_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Sick Leave"))
    ).scalar_one()

    # Allocate balance
    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=sick_type.id,
            year=today.year,
            allocated=3.0,
            used=0.0,
        )
    )
    await db_session.commit()

    # Find next working day
    days_ahead = (0 - today.weekday() + 7) % 7
    if days_ahead == 0:
        days_ahead = 7
    next_mon = today + datetime.timedelta(days=days_ahead)

    # 1. Invalid: half-day across multiple dates
    bad_payload = {
        "leave_type_id": str(sick_type.id),
        "from_date": next_mon.isoformat(),
        "to_date": (next_mon + datetime.timedelta(days=1)).isoformat(),
        "is_half_day": True,
        "half_day_session": "first_half",
        "reason": "Dentist appointment",
    }
    resp_bad = await async_client.post("/api/v1/leaves/apply", json=bad_payload, headers=headers)
    assert resp_bad.status_code == 400
    assert "single date" in resp_bad.json()["error"]["message"]

    # 2. Valid: single date with first_half
    good_payload = {
        "leave_type_id": str(sick_type.id),
        "from_date": next_mon.isoformat(),
        "to_date": next_mon.isoformat(),
        "is_half_day": True,
        "half_day_session": "first_half",
        "reason": "Dentist appointment morning",
    }
    resp_good = await async_client.post("/api/v1/leaves/apply", json=good_payload, headers=headers)
    assert resp_good.status_code == 201
    data = resp_good.json()
    assert data["is_half_day"] is True
    assert data["half_day_session"] == "first_half"
    assert data["total_days"] == 0.5


@pytest.mark.asyncio
async def test_working_days_exclude_weekends_and_holidays(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Verify that working day counting skips policy week-off days and company holidays."""
    emp, headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=casual_type.id,
            year=today.year,
            allocated=10.0,
            used=0.0,
        )
    )

    # Next Saturday to Monday (Sat is day 5, Sun is day 6 week-off, Mon is day 0)
    # Plus, add a Holiday on Monday!
    days_to_sat = (5 - today.weekday() + 7) % 7
    if days_to_sat == 0:
        days_to_sat = 7
    sat_date = today + datetime.timedelta(days=days_to_sat)
    mon_date = sat_date + datetime.timedelta(days=2)

    holiday = Holiday(date=mon_date, name="Test Festival Holiday", year=mon_date.year)
    db_session.add(holiday)
    await db_session.commit()

    # Applying from Saturday to Monday:
    # Saturday: working day (policy week-off default is [6] Sunday)
    # Sunday: week-off (excluded)
    # Monday: holiday (excluded)
    # Net working days = 1.0!
    payload = {
        "leave_type_id": str(casual_type.id),
        "from_date": sat_date.isoformat(),
        "to_date": mon_date.isoformat(),
        "is_half_day": False,
        "reason": "Weekend trip with holiday",
    }
    resp = await async_client.post("/api/v1/leaves/apply", json=payload, headers=headers)
    assert resp.status_code == 201
    data = resp.json()
    assert data["total_days"] == 1.0


@pytest.mark.asyncio
async def test_overlap_and_past_date_rejections(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Ensure overlapping requests and excessive past dates are rejected."""
    emp, headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=casual_type.id,
            year=today.year,
            allocated=10.0,
            used=0.0,
        )
    )
    await db_session.commit()

    # Target dates in the future
    d1 = today + datetime.timedelta(days=10)
    d2 = today + datetime.timedelta(days=12)

    # 1. First leave application succeeds
    p1 = {
        "leave_type_id": str(casual_type.id),
        "from_date": d1.isoformat(),
        "to_date": d2.isoformat(),
        "is_half_day": False,
        "reason": "First application",
    }
    res1 = await async_client.post("/api/v1/leaves/apply", json=p1, headers=headers)
    assert res1.status_code == 201

    # 2. Overlapping application -> 409 Conflict
    p2 = {
        "leave_type_id": str(casual_type.id),
        "from_date": (d1 + datetime.timedelta(days=1)).isoformat(),
        "to_date": (d2 + datetime.timedelta(days=2)).isoformat(),
        "is_half_day": False,
        "reason": "Overlapping attempt",
    }
    res2 = await async_client.post("/api/v1/leaves/apply", json=p2, headers=headers)
    assert res2.status_code == 409
    assert "overlaps" in res2.json()["error"]["message"]

    # 3. Past-date rule rejection (> 7 days in the past)
    way_past = today - datetime.timedelta(days=20)
    p_past = {
        "leave_type_id": str(casual_type.id),
        "from_date": way_past.isoformat(),
        "to_date": (way_past + datetime.timedelta(days=1)).isoformat(),
        "is_half_day": False,
        "reason": "Way past date",
    }
    res_past = await async_client.post("/api/v1/leaves/apply", json=p_past, headers=headers)
    assert res_past.status_code == 400
    assert "past days" in res_past.json()["error"]["message"]


@pytest.mark.asyncio
async def test_approval_flow_and_attendance_synchronization(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test full approval lifecycle: balance deduction, attendance marking, and notification."""
    emp, emp_headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=casual_type.id,
            year=today.year,
            allocated=8.0,
            used=0.0,
        )
    )
    await db_session.commit()

    # Find Tuesday (working day)
    days_ahead = (1 - today.weekday() + 7) % 7
    if days_ahead == 0:
        days_ahead = 7
    target_date = today + datetime.timedelta(days=days_ahead)

    # 1. Apply
    apply_res = await async_client.post(
        "/api/v1/leaves/apply",
        json={
            "leave_type_id": str(casual_type.id),
            "from_date": target_date.isoformat(),
            "to_date": target_date.isoformat(),
            "is_half_day": False,
            "reason": "Personal work",
        },
        headers=emp_headers,
    )
    assert apply_res.status_code == 201
    leave_id = apply_res.json()["id"]

    # 2. Admin approves
    approve_res = await async_client.post(
        f"/api/v1/leaves/{leave_id}/approve",
        json={"review_note": "Approved by management."},
        headers=admin_auth_headers,
    )
    assert approve_res.status_code == 200
    app_data = approve_res.json()
    assert app_data["status"] == "approved"
    assert app_data["review_note"] == "Approved by management."

    # 3. Check balance is deducted
    bal = (
        await db_session.execute(
            select(LeaveBalance).where(
                LeaveBalance.user_id == emp.id, LeaveBalance.leave_type_id == casual_type.id
            )
        )
    ).scalar_one()
    assert bal.used == 1.0

    # 4. Check AttendanceRecord was created with ON_LEAVE
    att_rec = (
        await db_session.execute(
            select(AttendanceRecord).where(
                AttendanceRecord.user_id == emp.id, AttendanceRecord.date == target_date
            )
        )
    ).scalar_one()
    on_leave_status = (
        await db_session.execute(
            select(AttendanceStatus).where(AttendanceStatus.code == "ON_LEAVE")
        )
    ).scalar_one()
    assert att_rec.status_id == on_leave_status.id
    assert att_rec.source == "LEAVE_APPROVAL"

    # 5. Check in-app notification delivered
    notifs = (
        (await db_session.execute(select(Notification).where(Notification.user_id == emp.id)))
        .scalars()
        .all()
    )
    assert any(n.type == "LEAVE_APPROVED" for n in notifs)


@pytest.mark.asyncio
async def test_rejection_and_cancel_pending_flow(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test rejection with note and cancelling pending requests."""
    emp, emp_headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=casual_type.id,
            year=today.year,
            allocated=5.0,
            used=0.0,
        )
    )
    await db_session.commit()

    d = today + datetime.timedelta(days=25)

    # 1. Apply
    app_res = await async_client.post(
        "/api/v1/leaves/apply",
        json={
            "leave_type_id": str(casual_type.id),
            "from_date": d.isoformat(),
            "to_date": d.isoformat(),
            "is_half_day": False,
            "reason": "Test rejection",
        },
        headers=emp_headers,
    )
    assert app_res.status_code == 201
    leave_id = app_res.json()["id"]

    # 2. Admin rejects
    rej_res = await async_client.post(
        f"/api/v1/leaves/{leave_id}/reject",
        json={"review_note": "Critical deliverables due on this day."},
        headers=admin_auth_headers,
    )
    assert rej_res.status_code == 200
    assert rej_res.json()["status"] == "rejected"

    # Balance used remains 0.0
    bal = (
        await db_session.execute(
            select(LeaveBalance).where(
                LeaveBalance.user_id == emp.id, LeaveBalance.leave_type_id == casual_type.id
            )
        )
    ).scalar_one()
    assert bal.used == 0.0

    # 3. Employee self-cancel on a pending request
    d_cancel = today + datetime.timedelta(days=35)
    while d_cancel.weekday() >= 5:
        d_cancel += datetime.timedelta(days=1)
    app2 = await async_client.post(
        "/api/v1/leaves/apply",
        json={
            "leave_type_id": str(casual_type.id),
            "from_date": d_cancel.isoformat(),
            "to_date": d_cancel.isoformat(),
            "is_half_day": False,
            "reason": "Will cancel myself",
        },
        headers=emp_headers,
    )
    cancel_id = app2.json()["id"]
    cancel_res = await async_client.post(f"/api/v1/leaves/{cancel_id}/cancel", headers=emp_headers)
    assert cancel_res.status_code == 200
    assert cancel_res.json()["status"] == "cancelled"


@pytest.mark.asyncio
async def test_cancel_approved_leave_restores_balance_and_attendance(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Ensure cancelling an approved leave restores balance and deletes leave attendance records."""
    emp, emp_headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=casual_type.id,
            year=today.year,
            allocated=5.0,
            used=0.0,
        )
    )
    await db_session.commit()

    days_ahead = (2 - today.weekday() + 7) % 7
    if days_ahead == 0:
        days_ahead = 7
    target_date = today + datetime.timedelta(days=days_ahead)

    # 1. Apply & Approve
    app_res = await async_client.post(
        "/api/v1/leaves/apply",
        json={
            "leave_type_id": str(casual_type.id),
            "from_date": target_date.isoformat(),
            "to_date": target_date.isoformat(),
            "is_half_day": False,
            "reason": "Approved then cancelled",
        },
        headers=emp_headers,
    )
    leave_id = app_res.json()["id"]

    await async_client.post(
        f"/api/v1/leaves/{leave_id}/approve",
        json={"review_note": "Approved"},
        headers=admin_auth_headers,
    )

    # Balance used should be 1.0
    bal_before = (
        await db_session.execute(
            select(LeaveBalance).where(
                LeaveBalance.user_id == emp.id, LeaveBalance.leave_type_id == casual_type.id
            )
        )
    ).scalar_one()
    assert bal_before.used == 1.0

    # 2. Cancel approved leave
    cancel_app_res = await async_client.post(
        f"/api/v1/leaves/{leave_id}/cancel-approved?reason=Emergency+postponed",
        headers=admin_auth_headers,
    )
    assert cancel_app_res.status_code == 200
    assert cancel_app_res.json()["status"] == "cancelled"

    # 3. Check balance is restored
    bal_after = (
        await db_session.execute(
            select(LeaveBalance).where(
                LeaveBalance.user_id == emp.id, LeaveBalance.leave_type_id == casual_type.id
            )
        )
    ).scalar_one()
    assert bal_after.used == 0.0

    # 4. Check AttendanceRecord created by LEAVE_APPROVAL is cleaned up
    att_rec = (
        await db_session.execute(
            select(AttendanceRecord).where(
                AttendanceRecord.user_id == emp.id,
                AttendanceRecord.date == target_date,
                AttendanceRecord.source == "LEAVE_APPROVAL",
            )
        )
    ).scalar_one_or_none()
    assert att_rec is None


@pytest.mark.asyncio
async def test_annual_balance_allocation_job(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test yearly allocation batch job and carry-forward calculation."""
    emp, _ = employee_auth_headers
    current_year = get_local_today().year
    target_year = current_year + 1

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    # Give employee 12 allocated in current_year with 4 used (unused = 8)
    # Casual leave max_carry_forward is 5, so 5 should be carried forward!
    db_session.add(
        LeaveBalance(
            user_id=emp.id,
            leave_type_id=casual_type.id,
            year=current_year,
            allocated=12.0,
            carried_forward=0.0,
            used=4.0,
        )
    )
    await db_session.commit()

    # Trigger annual balance allocation for target_year
    alloc_res = await async_client.post(
        "/api/v1/leaves/allocate-annual-balances",
        json={"year": target_year},
        headers=admin_auth_headers,
    )
    assert alloc_res.status_code == 200
    data = alloc_res.json()
    assert data["year"] == target_year
    assert data["users_processed"] >= 1
    assert data["balances_created"] >= 1

    # Check new target_year balance for Casual Leave
    new_bal = (
        await db_session.execute(
            select(LeaveBalance).where(
                LeaveBalance.user_id == emp.id,
                LeaveBalance.leave_type_id == casual_type.id,
                LeaveBalance.year == target_year,
            )
        )
    ).scalar_one()

    assert new_bal.allocated == float(casual_type.annual_quota)
    # Carry forward must be capped at max_carry_forward (5)
    assert new_bal.carried_forward == 5.0
    assert new_bal.used == 0.0
