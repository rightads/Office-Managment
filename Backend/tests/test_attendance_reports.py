from __future__ import annotations

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.redis import get_cache, invalidate_cache_pattern, set_cache
from app.core.security import create_access_token, hash_password
from app.models.attendance import (
    AttendanceRecord,
    AttendanceStatus,
)
from app.models.rbac import Role
from app.models.user import User
from app.utils.timezone import get_local_today, now_utc


@pytest.mark.asyncio
async def test_today_dashboard_admin(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Verify today's live attendance dashboard with counts and status breakdown."""
    today = get_local_today()

    # Seed an attendance record for admin
    admin_user = (
        await db_session.execute(select(User).where(User.employee_code == "ADMIN-001"))
    ).scalar_one()

    present_status = (
        await db_session.execute(select(AttendanceStatus).where(AttendanceStatus.code == "PRESENT"))
    ).scalar_one()

    record = AttendanceRecord(
        user_id=admin_user.id,
        date=today,
        check_in_at=now_utc(),
        status_id=present_status.id,
        total_minutes=480,
    )
    db_session.add(record)
    await db_session.commit()

    resp = await async_client.get(
        "/api/v1/reports/attendance/today",
        headers=admin_auth_headers,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert data["total_active_employees"] >= 1
    assert data["present_count"] >= 1
    assert len(data["status_breakdown"]) > 0

    # Verify present status contains admin
    present_group = next(
        (g for g in data["status_breakdown"] if g["status_code"] == "PRESENT"),
        None,
    )
    assert present_group is not None
    assert any(emp["employee_code"] == "ADMIN-001" for emp in present_group["employees"])


@pytest.mark.asyncio
async def test_today_dashboard_team_scoping_and_forbidden(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Ensure regular employees without view_team / view_all receive 403 Forbidden."""
    emp, headers = employee_auth_headers

    # Regular employee with only attendance.view_own
    resp = await async_client.get(
        "/api/v1/reports/attendance/today",
        headers=headers,
    )
    assert resp.status_code == 403

    # Now create a manager with CSD role (which has attendance.view_team)
    csd_role = (await db_session.execute(select(Role).where(Role.name == "CSD"))).scalar_one()
    manager = User(
        employee_code="MGR-001",
        email="manager.csd@agency.com",
        full_name="CSD Manager",
        password_hash=hash_password("Manager123!#"),
        role_id=csd_role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(manager)
    await db_session.commit()

    # Assign emp's manager_id to manager.id
    emp_db = (await db_session.execute(select(User).where(User.id == emp.id))).scalar_one()
    emp_db.manager_id = manager.id
    await db_session.commit()

    mgr_token = create_access_token(user_id=str(manager.id), role="CSD")
    mgr_headers = {"Authorization": f"Bearer {mgr_token}"}

    resp_mgr = await async_client.get(
        "/api/v1/reports/attendance/today",
        headers=mgr_headers,
    )
    assert resp_mgr.status_code == 200
    mgr_data = resp_mgr.json()
    # Manager should see themselves and their direct report (emp)
    scoped_codes = [
        e["employee_code"] for g in mgr_data["status_breakdown"] for e in g["employees"]
    ]
    assert "EMP-0001" in scoped_codes
    assert "MGR-001" in scoped_codes


@pytest.mark.asyncio
async def test_employee_monthly_report_and_permissions(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test monthly attendance report metrics, daily breakdown, and permission enforcement."""
    emp, emp_headers = employee_auth_headers
    today = get_local_today()

    # Employee views their own monthly report
    resp_own = await async_client.get(
        f"/api/v1/reports/attendance/employee/{emp.id}/monthly?month={today.month}&year={today.year}",
        headers=emp_headers,
    )
    assert resp_own.status_code == 200
    data_own = resp_own.json()
    assert data_own["employee_id"] == str(emp.id)
    assert data_own["month"] == today.month
    assert data_own["year"] == today.year
    assert len(data_own["daily_records"]) >= 28

    # Employee attempts to view Admin's monthly report -> 403 Forbidden
    admin_user = (
        await db_session.execute(select(User).where(User.employee_code == "ADMIN-001"))
    ).scalar_one()

    resp_forbidden = await async_client.get(
        f"/api/v1/reports/attendance/employee/{admin_user.id}/monthly?month={today.month}&year={today.year}",
        headers=emp_headers,
    )
    assert resp_forbidden.status_code == 403

    # Admin views employee's monthly report -> 200 OK
    resp_admin = await async_client.get(
        f"/api/v1/reports/attendance/employee/{emp.id}/monthly?month={today.month}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert resp_admin.status_code == 200
    assert resp_admin.json()["employee_code"] == "EMP-0001"


@pytest.mark.asyncio
async def test_employee_yearly_report(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Test 12-month annual attendance summary report."""
    emp, _ = employee_auth_headers
    today = get_local_today()

    resp = await async_client.get(
        f"/api/v1/reports/attendance/employee/{emp.id}/yearly?year={today.year}",
        headers=admin_auth_headers,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert data["year"] == today.year
    assert len(data["months"]) == 12
    assert "annual_working_days" in data
    assert "annual_attendance_percentage" in data


@pytest.mark.asyncio
async def test_monthly_overview_matrix(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Test organization-wide monthly matrix of all employees."""
    today = get_local_today()

    resp = await async_client.get(
        f"/api/v1/reports/attendance/monthly-overview?month={today.month}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert data["month"] == today.month
    assert data["year"] == today.year
    assert len(data["rows"]) >= 1

    first_row = data["rows"][0]
    assert "days" in first_row
    assert "attendance_percentage" in first_row


@pytest.mark.asyncio
async def test_export_endpoints_excel_and_pdf(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Test streaming Excel (.xlsx) and PDF (.pdf) exports across all report types."""
    emp, _ = employee_auth_headers
    today = get_local_today()

    # 1. Today Excel & PDF
    res_today_excel = await async_client.get(
        "/api/v1/reports/attendance/export?report_type=today&format=excel",
        headers=admin_auth_headers,
    )
    assert res_today_excel.status_code == 200
    assert "spreadsheetml.sheet" in res_today_excel.headers["content-type"]
    assert len(res_today_excel.content) > 100

    res_today_pdf = await async_client.get(
        "/api/v1/reports/attendance/export?report_type=today&format=pdf",
        headers=admin_auth_headers,
    )
    assert res_today_pdf.status_code == 200
    assert "application/pdf" in res_today_pdf.headers["content-type"]
    assert res_today_pdf.content.startswith(b"%PDF")

    # 2. Employee Monthly Excel & PDF
    res_monthly_excel = await async_client.get(
        f"/api/v1/reports/attendance/export?report_type=employee_monthly&format=excel&employee_id={emp.id}&month={today.month}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert res_monthly_excel.status_code == 200
    assert len(res_monthly_excel.content) > 100

    res_monthly_pdf = await async_client.get(
        f"/api/v1/reports/attendance/export?report_type=employee_monthly&format=pdf&employee_id={emp.id}&month={today.month}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert res_monthly_pdf.status_code == 200
    assert res_monthly_pdf.content.startswith(b"%PDF")

    # 3. Employee Yearly Excel & PDF
    res_yearly_excel = await async_client.get(
        f"/api/v1/reports/attendance/export?report_type=employee_yearly&format=excel&employee_id={emp.id}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert res_yearly_excel.status_code == 200

    res_yearly_pdf = await async_client.get(
        f"/api/v1/reports/attendance/export?report_type=employee_yearly&format=pdf&employee_id={emp.id}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert res_yearly_pdf.status_code == 200
    assert res_yearly_pdf.content.startswith(b"%PDF")

    # 4. Monthly Overview Matrix Excel & PDF
    res_overview_excel = await async_client.get(
        f"/api/v1/reports/attendance/export?report_type=monthly_overview&format=excel&month={today.month}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert res_overview_excel.status_code == 200

    res_overview_pdf = await async_client.get(
        f"/api/v1/reports/attendance/export?report_type=monthly_overview&format=pdf&month={today.month}&year={today.year}",
        headers=admin_auth_headers,
    )
    assert res_overview_pdf.status_code == 200
    assert res_overview_pdf.content.startswith(b"%PDF")


@pytest.mark.asyncio
async def test_redis_cache_helpers_and_fallback() -> None:
    """Ensure Redis cache functions handle offline Redis gracefully without raising exceptions."""
    # When REDIS_URL is not set or server is offline, helpers should gracefully return None / False / 0
    val = await get_cache("non_existent_key")
    assert val is None

    success = await set_cache("test_key", "test_val", expire_seconds=10)
    assert success in (True, False)

    deleted = await invalidate_cache_pattern("reports:attendance:*")
    assert isinstance(deleted, int)
