from __future__ import annotations

import datetime
import uuid

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.attendance import (
    AttendanceCorrection,
    AttendancePolicy,
    AttendanceRecord,
    AttendanceStatus,
)
from app.models.organization import OfficeLocation
from app.models.rbac import Role
from app.models.system import AuditLog
from app.models.user import User
from app.services.attendance_scheduler import (
    auto_close_unclosed_checkouts,
    nightly_attendance_processor,
)
from app.utils.geofence import haversine_distance, is_within_geofence
from app.utils.timezone import get_local_today


def test_geofence_haversine_calculation() -> None:
    """Unit test for Haversine distance and geofence radius check."""
    # Exact same coordinate -> distance 0
    dist_zero = haversine_distance(28.6139, 77.2090, 28.6139, 77.2090)
    assert round(dist_zero, 2) == 0.0

    # New Delhi to Mumbai (~1150 km)
    dist_delhi_mumbai = haversine_distance(28.6139, 77.2090, 19.0760, 72.8777)
    assert 1_100_000 < dist_delhi_mumbai < 1_200_000

    # Within 100m radius test
    loc_lat, loc_lng = 28.6139, 77.2090
    user_lat, user_lng = 28.6140, 77.2091  # ~15 meters away
    inside, dist = is_within_geofence(user_lat, user_lng, loc_lat, loc_lng, radius_meters=100.0)
    assert inside is True
    assert dist < 50.0

    # Outside radius test
    user_far_lat, user_far_lng = 28.6200, 77.2150  # ~900 meters away
    inside_far, dist_far = is_within_geofence(
        user_far_lat, user_far_lng, loc_lat, loc_lng, radius_meters=100.0
    )
    assert inside_far is False
    assert dist_far > 500.0


@pytest.mark.asyncio
async def test_check_in_and_check_out_flow(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test full employee check-in and check-out cycle with geofence and double check-in rejection."""
    # 1. Create Office Location
    office = OfficeLocation(
        name="Main Office HQ",
        latitude=28.6139,
        longitude=77.2090,
        radius_meters=200.0,
        is_active=True,
    )
    db_session.add(office)
    await db_session.commit()
    await db_session.refresh(office)

    # 2. Create Attendance Policy requiring geofence
    policy = AttendancePolicy(
        name="HQ Geofenced Shift",
        shift_start=datetime.time(9, 30),
        shift_end=datetime.time(18, 30),
        grace_minutes=15,
        half_day_min_hours=4.0,
        full_day_min_hours=8.0,
        week_off_days=[6],
        require_geofence=True,
        require_selfie=False,
        allowed_location_ids=[str(office.id)],
        is_default=True,
        is_active=True,
    )
    db_session.add(policy)
    await db_session.commit()
    await db_session.refresh(policy)

    # 3. Create employee with Graphic designer role
    role = (
        await db_session.execute(select(Role).where(Role.name == "Graphic designer"))
    ).scalar_one()
    emp_res = await async_client.post(
        "/api/v1/employees",
        json={
            "email": "designer.test@agency.com",
            "full_name": "Test Designer",
            "role_id": str(role.id),
        },
        headers=admin_auth_headers,
    )
    assert emp_res.status_code == 201
    emp_id = emp_res.json()["id"]

    # Assign policy to user
    user = (await db_session.execute(select(User).where(User.id == uuid.UUID(emp_id)))).scalar_one()
    user.attendance_policy_id = policy.id
    user.must_change_password = False
    await db_session.commit()

    # Log in as the employee to get auth headers
    from app.core.security import create_access_token

    token = create_access_token(user_id=str(user.id), role="Graphic designer")
    emp_headers = {"Authorization": f"Bearer {token}"}

    # 4. Successful check-in within geofence
    checkin_res = await async_client.post(
        "/api/v1/attendance/check-in",
        json={
            "latitude": 28.6140,
            "longitude": 77.2091,
            "device_id": "DEVICE-MOB-001",
            "is_mock_location": False,
        },
        headers=emp_headers,
    )
    assert checkin_res.status_code == 200
    rec = checkin_res.json()
    assert rec["check_in_at"] is not None
    assert rec["device_id"] == "DEVICE-MOB-001"

    # 5. Double check-in must be rejected (409 Conflict)
    double_res = await async_client.post(
        "/api/v1/attendance/check-in",
        json={
            "latitude": 28.6140,
            "longitude": 77.2091,
            "device_id": "DEVICE-MOB-001",
        },
        headers=emp_headers,
    )
    assert double_res.status_code == 409
    assert "already checked in" in double_res.json()["error"]["message"]

    # 6. Check-out
    checkout_res = await async_client.post(
        "/api/v1/attendance/check-out",
        json={
            "latitude": 28.6140,
            "longitude": 77.2091,
            "device_id": "DEVICE-MOB-001",
            "remarks": "Completed graphic mockups",
        },
        headers=emp_headers,
    )
    assert checkout_res.status_code == 200
    out_rec = checkout_res.json()
    assert out_rec["check_out_at"] is not None
    assert out_rec["remarks"] == "Completed graphic mockups"

    # 7. Second check-out rejected
    dup_out = await async_client.post(
        "/api/v1/attendance/check-out",
        json={
            "latitude": 28.6140,
            "longitude": 77.2091,
            "device_id": "DEVICE-MOB-001",
        },
        headers=emp_headers,
    )
    assert dup_out.status_code == 400
    assert "already checked out" in dup_out.json()["error"]["message"]


@pytest.mark.asyncio
async def test_mock_location_and_device_binding(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test rejection of mock location and enforcement of hardware device binding & reset."""
    role = (
        await db_session.execute(select(Role).where(Role.name == "Web Application"))
    ).scalar_one()

    office = OfficeLocation(
        name="Connaught Place Office",
        latitude=28.6139,
        longitude=77.2090,
        radius_meters=300.0,
        is_active=True,
    )
    db_session.add(office)
    await db_session.commit()
    emp_res = await async_client.post(
        "/api/v1/employees",
        json={"email": "webapp.dev@agency.com", "full_name": "Webapp Dev", "role_id": str(role.id)},
        headers=admin_auth_headers,
    )
    emp_id = emp_res.json()["id"]

    user = (await db_session.execute(select(User).where(User.id == uuid.UUID(emp_id)))).scalar_one()
    user.must_change_password = False
    await db_session.commit()

    from app.core.security import create_access_token

    token = create_access_token(user_id=str(user.id), role="Web Application")
    emp_headers = {"Authorization": f"Bearer {token}"}

    # 1. Mock location rejection
    mock_res = await async_client.post(
        "/api/v1/attendance/check-in",
        json={
            "latitude": 28.6139,
            "longitude": 77.2090,
            "device_id": "DEV-TEST-01",
            "is_mock_location": True,
        },
        headers=emp_headers,
    )
    assert mock_res.status_code == 400
    assert "Mock location detected" in mock_res.json()["error"]["message"]

    # 2. First check-in binds device ID
    checkin_res = await async_client.post(
        "/api/v1/attendance/check-in",
        json={
            "latitude": 28.6139,
            "longitude": 77.2090,
            "device_id": "DEV-AUTHORIZED-PHONE",
            "is_mock_location": False,
        },
        headers=emp_headers,
    )
    assert checkin_res.status_code == 200

    # 3. Subsequent action with different device is rejected (403 Forbidden)
    rogue_res = await async_client.post(
        "/api/v1/attendance/check-out",
        json={
            "latitude": 28.6139,
            "longitude": 77.2090,
            "device_id": "ROGUE-DEVICE-999",
            "is_mock_location": False,
        },
        headers=emp_headers,
    )
    assert rogue_res.status_code == 403
    assert "Device ID mismatch" in rogue_res.json()["error"]["message"]

    # 4. Admin resets device
    reset_res = await async_client.post(
        f"/api/v1/attendance/users/{emp_id}/reset-device",
        headers=admin_auth_headers,
    )
    assert reset_res.status_code == 200
    assert "reset successfully" in reset_res.json()["message"]

    # Verify user.device_id in DB is cleared
    user = (await db_session.execute(select(User).where(User.id == uuid.UUID(emp_id)))).scalar_one()
    assert user.device_id is None

    # Check-out from new replacement device now succeeds and binds to new device
    checkout_new = await async_client.post(
        "/api/v1/attendance/check-out",
        json={
            "latitude": 28.6139,
            "longitude": 77.2090,
            "device_id": "NEW-REPLACEMENT-DEVICE",
            "is_mock_location": False,
        },
        headers=emp_headers,
    )
    assert checkout_new.status_code == 200


@pytest.mark.asyncio
async def test_outside_geofence_rejected(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Verify that check-in attempts outside the designated office geofence are blocked."""
    # Create office location with 50m radius
    office = OfficeLocation(
        name="Branch Office Gurgaon",
        latitude=28.4595,
        longitude=77.0266,
        radius_meters=50.0,
        is_active=True,
    )
    db_session.add(office)
    await db_session.commit()
    await db_session.refresh(office)

    # Policy requiring geofence
    policy = AttendancePolicy(
        name="Strict Geofence Policy",
        shift_start=datetime.time(9, 0),
        shift_end=datetime.time(18, 0),
        grace_minutes=15,
        half_day_min_hours=4.0,
        full_day_min_hours=8.0,
        week_off_days=[6],
        require_geofence=True,
        require_selfie=False,
        allowed_location_ids=[str(office.id)],
        is_default=False,
        is_active=True,
    )
    db_session.add(policy)
    await db_session.commit()
    await db_session.refresh(policy)

    role = (await db_session.execute(select(Role).where(Role.name == "SEO"))).scalar_one()
    emp_res = await async_client.post(
        "/api/v1/employees",
        json={
            "email": "seo.specialist@agency.com",
            "full_name": "SEO Specialist",
            "role_id": str(role.id),
        },
        headers=admin_auth_headers,
    )
    emp_id = emp_res.json()["id"]

    user = (await db_session.execute(select(User).where(User.id == uuid.UUID(emp_id)))).scalar_one()
    user.attendance_policy_id = policy.id
    user.must_change_password = False
    await db_session.commit()

    from app.core.security import create_access_token

    token = create_access_token(user_id=str(user.id), role="SEO")
    headers = {"Authorization": f"Bearer {token}"}

    # Check-in 10 km away
    far_res = await async_client.post(
        "/api/v1/attendance/check-in",
        json={
            "latitude": 28.5500,
            "longitude": 77.1000,
            "device_id": "SEO-PHONE-01",
            "is_mock_location": False,
        },
        headers=headers,
    )
    assert far_res.status_code == 400
    assert "outside the designated office geofence" in far_res.json()["error"]["message"]


@pytest.mark.asyncio
async def test_today_and_calendar_endpoints(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test /attendance/today and /attendance/me monthly calendar data."""
    role = (await db_session.execute(select(Role).where(Role.name == "HR"))).scalar_one()

    office = OfficeLocation(
        name="HR Central Branch",
        latitude=28.6139,
        longitude=77.2090,
        radius_meters=300.0,
        is_active=True,
    )
    db_session.add(office)
    await db_session.commit()

    emp_res = await async_client.post(
        "/api/v1/employees",
        json={"email": "hr.officer@agency.com", "full_name": "HR Officer", "role_id": str(role.id)},
        headers=admin_auth_headers,
    )
    emp_id = emp_res.json()["id"]

    user = (await db_session.execute(select(User).where(User.id == uuid.UUID(emp_id)))).scalar_one()
    user.must_change_password = False
    await db_session.commit()

    from app.core.security import create_access_token

    token = create_access_token(user_id=str(user.id), role="HR")
    headers = {"Authorization": f"Bearer {token}"}

    # 1. Today endpoint before check-in
    today_res = await async_client.get("/api/v1/attendance/today", headers=headers)
    assert today_res.status_code == 200
    assert today_res.json()["has_checked_in"] is False

    # 2. Check-in
    await async_client.post(
        "/api/v1/attendance/check-in",
        json={"latitude": 28.6139, "longitude": 77.2090, "device_id": "HR-PHONE-01"},
        headers=headers,
    )

    # 3. Today endpoint after check-in
    today_res2 = await async_client.get("/api/v1/attendance/today", headers=headers)
    assert today_res2.status_code == 200
    assert today_res2.json()["has_checked_in"] is True

    # 4. Monthly Calendar
    today = get_local_today()
    cal_res = await async_client.get(
        f"/api/v1/attendance/me?month={today.month}&year={today.year}",
        headers=headers,
    )
    assert cal_res.status_code == 200
    cal_data = cal_res.json()
    assert cal_data["year"] == today.year
    assert cal_data["month"] == today.month
    assert len(cal_data["days"]) >= 28


@pytest.mark.asyncio
async def test_manual_attendance_correction_and_audit(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test administrative manual attendance correction with reason and audit logging."""
    # Find present status and absent status
    pres_status = (
        await db_session.execute(select(AttendanceStatus).where(AttendanceStatus.code == "PRESENT"))
    ).scalar_one()
    abs_status = (
        await db_session.execute(select(AttendanceStatus).where(AttendanceStatus.code == "ABSENT"))
    ).scalar_one()

    admin_user = (
        await db_session.execute(select(User).where(User.email == "superadmin@agency.com"))
    ).scalar_one()

    # Create dummy attendance record
    record = AttendanceRecord(
        user_id=admin_user.id,
        date=datetime.date(2026, 10, 1),
        status_id=abs_status.id,
        total_minutes=0,
        is_manual=False,
    )
    db_session.add(record)
    await db_session.commit()
    await db_session.refresh(record)

    # Correct record
    check_in_time = datetime.datetime(2026, 10, 1, 9, 30, tzinfo=datetime.timezone.utc)
    check_out_time = datetime.datetime(2026, 10, 1, 18, 30, tzinfo=datetime.timezone.utc)

    corr_res = await async_client.post(
        f"/api/v1/attendance/{record.id}/correct",
        json={
            "check_in_at": check_in_time.isoformat(),
            "check_out_at": check_out_time.isoformat(),
            "status_id": str(pres_status.id),
            "reason": "Biometric terminal network failure, employee was present all day",
        },
        headers=admin_auth_headers,
    )
    assert corr_res.status_code == 200
    corr_data = corr_res.json()
    assert corr_data["attendance_id"] == str(record.id)
    assert "Biometric terminal" in corr_data["reason"]

    # Verify AttendanceCorrection in DB
    corr_db = (
        await db_session.execute(
            select(AttendanceCorrection).where(AttendanceCorrection.attendance_id == record.id)
        )
    ).scalar_one()
    assert corr_db.reason == "Biometric terminal network failure, employee was present all day"

    # Verify AuditLog created
    audit = (
        await db_session.execute(
            select(AuditLog).where(
                AuditLog.action == "CORRECT_ATTENDANCE",
                AuditLog.entity_id == str(record.id),
            )
        )
    ).scalar_one_or_none()
    assert audit is not None


@pytest.mark.asyncio
async def test_nightly_scheduler_and_auto_close(
    db_session: AsyncSession,
    admin_auth_headers: dict[str, str],
) -> None:
    """Test idempotent nightly attendance auto-marking and auto-closing forgotten checkouts."""
    # Create test user
    role = (await db_session.execute(select(Role).where(Role.name == "CSD"))).scalar_one()
    user = User(
        employee_code="EMP-TEST-CSD",
        email="csd.agent@agency.com",
        full_name="CSD Agent",
        role_id=role.id,
        password_hash="argon2id$hashed",
        is_active=True,
    )
    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)

    target_date = datetime.date(2026, 9, 15)  # Tuesday

    # 1. Run nightly processor on empty day -> Should mark ABSENT
    marked = await nightly_attendance_processor(db_session, target_date=target_date)
    assert marked >= 1

    rec = (
        await db_session.execute(
            select(AttendanceRecord)
            .where(
                AttendanceRecord.user_id == user.id,
                AttendanceRecord.date == target_date,
            )
            .options(selectinload(AttendanceRecord.status))
        )
    ).scalar_one()
    assert rec.status.code in ("ABSENT", "WEEK_OFF")

    # 2. Idempotent re-run -> Should mark 0 records (already exists)
    marked_second = await nightly_attendance_processor(db_session, target_date=target_date)
    assert marked_second == 0

    # 3. Test Auto-Close job
    # Create an unclosed record on a past date
    past_date = datetime.date(2026, 9, 10)
    pres_status = (
        await db_session.execute(select(AttendanceStatus).where(AttendanceStatus.code == "PRESENT"))
    ).scalar_one()
    unclosed_rec = AttendanceRecord(
        user_id=user.id,
        date=past_date,
        check_in_at=datetime.datetime(2026, 9, 10, 9, 30, tzinfo=datetime.timezone.utc),
        check_out_at=None,
        status_id=pres_status.id,
        total_minutes=0,
    )
    db_session.add(unclosed_rec)
    await db_session.commit()

    closed = await auto_close_unclosed_checkouts(db_session)
    assert closed >= 1

    await db_session.refresh(unclosed_rec)
    assert unclosed_rec.check_out_at is not None
    assert unclosed_rec.total_minutes > 0
    assert "Auto-closed" in (unclosed_rec.remarks or "")


def test_timezone_boundary_conversion() -> None:
    """Verify that UTC timestamps crossing midnight map to the next day in Eastern/IST timezones."""
    import zoneinfo

    # 23:55 UTC on 2026-10-15
    utc_dt = datetime.datetime(2026, 10, 15, 23, 55, tzinfo=datetime.timezone.utc)

    # In UTC, the date is 2026-10-15
    assert utc_dt.date() == datetime.date(2026, 10, 15)

    # In Asia/Kolkata (UTC+5:30), the time is 05:25 on 2026-10-16
    ist_tz = zoneinfo.ZoneInfo("Asia/Kolkata")
    ist_dt = utc_dt.astimezone(ist_tz)
    assert ist_dt.date() == datetime.date(2026, 10, 16)
    assert ist_dt.hour == 5
    assert ist_dt.minute == 25
