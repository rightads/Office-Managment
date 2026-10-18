from __future__ import annotations

import calendar
import datetime
import logging
import uuid

from sqlalchemy import and_, or_, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.constants import AttendanceStatusCode, LeaveRequestStatus
from app.core.exceptions import (
    ForbiddenException,
    NotFoundException,
)
from app.core.redis import get_cache, set_cache
from app.models.attendance import AttendanceRecord
from app.models.leave import LeaveRequest
from app.models.user import User
from app.repositories.attendance_repository import AttendanceRepository
from app.repositories.user_repository import UserRepository
from app.schemas.attendance_reports import (
    AttendanceDayDetail,
    AttendanceSummaryStatusCount,
    AttendanceTodayReportResponse,
    EmployeeMonthlyReportResponse,
    EmployeeYearlyReportResponse,
    MonthlyOverviewEmployeeRow,
    MonthlyOverviewResponse,
    MonthSummaryItem,
    ReportEmployeeItem,
)
from app.utils.timezone import get_local_today

logger = logging.getLogger(__name__)


class AttendanceReportService:
    """Service providing SQL-aggregated attendance dashboards, calendar reports, matrices, and Redis caching."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.repo = AttendanceRepository(session)
        self.user_repo = UserRepository(session)

    async def _resolve_permissions_and_scope(
        self,
        current_user: User,
        target_user_id: uuid.UUID | None = None,
        department_id: uuid.UUID | None = None,
    ) -> tuple[set[str], list[uuid.UUID] | None]:
        """
        Evaluate granted permissions and determine scoped employee IDs.
        Returns (permissions_set, scoped_user_ids). If scoped_user_ids is None, company-wide access is granted.
        """
        perms = await self.user_repo.get_user_permissions(current_user)

        if "attendance.view_all" in perms:
            # Full company-wide access
            if target_user_id is not None:
                return perms, [target_user_id]
            return perms, None

        if "attendance.view_team" in perms:
            # Query direct reports + current user
            stmt = select(User.id).where(
                and_(
                    User.is_active == True,  # noqa: E712
                    User.deleted_at.is_(None),
                    or_(User.manager_id == current_user.id, User.id == current_user.id),
                )
            )
            if department_id is not None:
                stmt = stmt.where(User.department_id == department_id)
            res = await self.session.execute(stmt)
            team_ids = list(res.scalars().all())

            if target_user_id is not None:
                if target_user_id not in team_ids:
                    raise ForbiddenException(
                        "Access forbidden. You may only view attendance reports for your direct team members."
                    )
                return perms, [target_user_id]
            return perms, team_ids

        if "attendance.view_own" in perms and target_user_id is not None:
            if target_user_id != current_user.id:
                raise ForbiddenException(
                    "Access forbidden. You only have permission to view your own attendance reports."
                )
            return perms, [current_user.id]

        raise ForbiddenException(
            "Access forbidden. Missing required attendance reporting permissions."
        )

    # -------------------------------------------------------------------------
    # 1. TODAY ATTENDANCE DASHBOARD
    # -------------------------------------------------------------------------
    async def get_today_dashboard(
        self,
        current_user: User,
        department_id: uuid.UUID | None = None,
    ) -> AttendanceTodayReportResponse:
        perms, scoped_ids = await self._resolve_permissions_and_scope(
            current_user, department_id=department_id
        )

        today_date = get_local_today()

        # Query all active employees in scope
        emp_stmt = (
            select(User)
            .options(selectinload(User.department))
            .where(
                and_(
                    User.is_active == True,  # noqa: E712
                    User.deleted_at.is_(None),
                )
            )
        )
        if scoped_ids is not None:
            emp_stmt = emp_stmt.where(User.id.in_(scoped_ids))
        if department_id is not None:
            emp_stmt = emp_stmt.where(User.department_id == department_id)

        emp_stmt = emp_stmt.order_by(User.full_name.asc())
        emp_res = await self.session.execute(emp_stmt)
        employees = list(emp_res.scalars().all())
        employee_ids = [e.id for e in employees]

        # Query all active statuses
        statuses = await self.repo.list_statuses()

        # Query today's attendance records
        records_stmt = (
            select(AttendanceRecord)
            .options(selectinload(AttendanceRecord.status))
            .where(
                and_(
                    AttendanceRecord.date == today_date,
                    AttendanceRecord.user_id.in_(employee_ids),
                )
            )
        )
        rec_res = await self.session.execute(records_stmt)
        record_map = {r.user_id: r for r in rec_res.scalars().all()}

        # Query today's approved leaves
        leave_stmt = select(LeaveRequest).where(
            and_(
                LeaveRequest.status == LeaveRequestStatus.APPROVED.value,
                LeaveRequest.from_date <= today_date,
                LeaveRequest.to_date >= today_date,
                LeaveRequest.user_id.in_(employee_ids),
            )
        )
        leave_res = await self.session.execute(leave_stmt)
        leave_map = {lv.user_id: lv for lv in leave_res.scalars().all()}

        # Check if today is a public holiday
        holiday = await self.repo.get_holiday_on_date(today_date)

        # Categorize employees into statuses
        status_employees: dict[str, list[ReportEmployeeItem]] = {s.code: [] for s in statuses}
        if "ABSENT" not in status_employees:
            status_employees["ABSENT"] = []

        present_count = 0
        absent_count = 0
        late_count = 0
        half_day_count = 0
        on_leave_count = 0

        for emp in employees:
            item = ReportEmployeeItem(
                id=emp.id,
                employee_code=emp.employee_code,
                full_name=emp.full_name,
                email=emp.email,
                avatar_url=emp.avatar_url,
                department_name=emp.department.name if emp.department else None,
                designation=emp.designation,
            )

            rec = record_map.get(emp.id)
            if rec and rec.status:
                code = rec.status.code
                if code in status_employees:
                    status_employees[code].append(item)
                if rec.status.counts_as_present:
                    present_count += 1
                if code == "LATE":
                    late_count += 1
                elif code == "HALF_DAY":
                    half_day_count += 1
            elif emp.id in leave_map:
                if "ON_LEAVE" in status_employees:
                    status_employees["ON_LEAVE"].append(item)
                on_leave_count += 1
            elif holiday is not None:
                if "HOLIDAY" in status_employees:
                    status_employees["HOLIDAY"].append(item)
            else:
                if "ABSENT" in status_employees:
                    status_employees["ABSENT"].append(item)
                absent_count += 1

        breakdown: list[AttendanceSummaryStatusCount] = []
        for s in statuses:
            breakdown.append(
                AttendanceSummaryStatusCount(
                    status_id=s.id,
                    status_name=s.label,
                    status_code=s.code,
                    badge_color=s.color,
                    count=len(status_employees.get(s.code, [])),
                    employees=status_employees.get(s.code, []),
                )
            )

        return AttendanceTodayReportResponse(
            date=today_date,
            total_active_employees=len(employees),
            present_count=present_count,
            absent_count=absent_count,
            late_count=late_count,
            half_day_count=half_day_count,
            on_leave_count=on_leave_count,
            status_breakdown=breakdown,
        )

    # -------------------------------------------------------------------------
    # 2. EMPLOYEE MONTHLY REPORT
    # -------------------------------------------------------------------------
    async def get_employee_monthly(
        self,
        current_user: User,
        employee_id: uuid.UUID,
        month: int,
        year: int,
    ) -> EmployeeMonthlyReportResponse:
        await self._resolve_permissions_and_scope(current_user, target_user_id=employee_id)

        local_today = get_local_today()
        is_closed_month = (year < local_today.year) or (
            year == local_today.year and month < local_today.month
        )
        cache_key = f"reports:attendance:monthly:{employee_id}:{year}:{month}"

        # Check Redis Cache
        if is_closed_month:
            cached_data = await get_cache(cache_key)
            if cached_data:
                try:
                    return EmployeeMonthlyReportResponse.model_validate_json(cached_data)
                except Exception as exc:
                    logger.warning("Cache deserialization failed for %s: %s", cache_key, exc)

        # Fetch employee with details
        emp_stmt = (
            select(User)
            .options(
                selectinload(User.department),
                selectinload(User.attendance_policy),
            )
            .where(User.id == employee_id)
        )
        emp_res = await self.session.execute(emp_stmt)
        employee = emp_res.scalar_one_or_none()
        if not employee or employee.deleted_at is not None:
            raise NotFoundException("Employee not found.")

        # Compute month dates
        _, num_days = calendar.monthrange(year, month)
        start_date = datetime.date(year, month, 1)
        end_date = datetime.date(year, month, num_days)

        policy = await self.repo.get_effective_policy(employee)
        week_off_days = policy.week_off_days if policy else [6]

        holidays = await self.repo.get_holidays_in_range(start_date, end_date)
        holiday_map = {h.date: h for h in holidays}

        leaves = await self.repo.get_approved_leaves_for_user_in_range(
            employee_id, start_date, end_date
        )

        records = await self.repo.get_records_for_user_in_range(employee_id, start_date, end_date)
        record_map = {r.date: r for r in records}

        daily_records: list[AttendanceDayDetail] = []
        working_days = 0
        present_days = 0
        absent_days = 0
        half_days = 0
        late_days = 0
        leave_days = 0
        holiday_days = 0
        week_off_days_count = 0
        total_minutes = 0

        for day in range(1, num_days + 1):
            curr_date = datetime.date(year, month, day)
            dow = curr_date.strftime("%A")
            is_week_off = curr_date.weekday() in week_off_days
            is_holiday = curr_date in holiday_map
            holiday_obj = holiday_map.get(curr_date)
            is_working_day = not is_week_off and not is_holiday

            if is_week_off:
                week_off_days_count += 1
            if is_holiday:
                holiday_days += 1
            if is_working_day:
                working_days += 1

            rec = record_map.get(curr_date)
            active_leave = next(
                (lv for lv in leaves if lv.from_date <= curr_date <= lv.to_date),
                None,
            )

            status_name = None
            status_code = None
            badge_color = None
            first_check_in = None
            last_check_out = None
            hours_worked = 0.0
            overtime = 0.0
            is_late = False
            is_half_day = False
            correction_applied = False

            if rec is not None:
                status_code = rec.status.code
                status_name = rec.status.label
                badge_color = rec.status.color
                first_check_in = rec.check_in_at
                last_check_out = rec.check_out_at
                hours_worked = round(rec.total_minutes / 60.0, 2)
                total_minutes += rec.total_minutes
                correction_applied = rec.is_manual

                if policy and hours_worked > policy.full_day_min_hours:
                    overtime = round(hours_worked - policy.full_day_min_hours, 2)

                if status_code == AttendanceStatusCode.PRESENT.value:
                    present_days += 1
                elif status_code == AttendanceStatusCode.LATE.value:
                    late_days += 1
                    present_days += 1
                    is_late = True
                elif status_code == AttendanceStatusCode.HALF_DAY.value:
                    half_days += 1
                    is_half_day = True
                elif status_code == AttendanceStatusCode.ABSENT.value:
                    absent_days += 1
            elif active_leave is not None:
                status_code = AttendanceStatusCode.ON_LEAVE.value
                status_name = "Approved Leave"
                badge_color = "#6366F1"
                leave_days += 1
            elif is_holiday:
                status_code = AttendanceStatusCode.HOLIDAY.value
                status_name = holiday_obj.name if holiday_obj else "Public Holiday"
                badge_color = "#8B5CF6"
            elif is_week_off:
                status_code = AttendanceStatusCode.WEEK_OFF.value
                status_name = "Weekly Off"
                badge_color = "#64748B"
            else:
                if curr_date <= local_today:
                    status_code = AttendanceStatusCode.ABSENT.value
                    status_name = "Absent"
                    badge_color = "#EF4444"
                    absent_days += 1
                else:
                    status_code = "UPCOMING"
                    status_name = "Upcoming"
                    badge_color = "#94A3B8"

            daily_records.append(
                AttendanceDayDetail(
                    date=curr_date,
                    day_of_week=dow,
                    is_working_day=is_working_day,
                    is_holiday=is_holiday,
                    holiday_name=holiday_obj.name if holiday_obj else None,
                    status_name=status_name,
                    status_code=status_code,
                    badge_color=badge_color,
                    first_check_in=first_check_in,
                    last_check_out=last_check_out,
                    total_hours_worked=hours_worked,
                    overtime_hours=overtime,
                    is_late=is_late,
                    is_half_day=is_half_day,
                    correction_applied=correction_applied,
                )
            )

        total_hours = round(total_minutes / 60.0, 2)
        effective_present = present_days + (0.5 * half_days)
        att_pct = round((effective_present / working_days * 100.0), 2) if working_days > 0 else 0.0
        avg_hours = round(total_hours / working_days, 2) if working_days > 0 else 0.0

        response = EmployeeMonthlyReportResponse(
            employee_id=employee.id,
            employee_name=employee.full_name,
            employee_code=employee.employee_code,
            department_name=employee.department.name if employee.department else None,
            designation=employee.designation,
            month=month,
            year=year,
            total_days=num_days,
            working_days=working_days,
            present_days=present_days,
            absent_days=absent_days,
            half_days=half_days,
            late_days=late_days,
            leave_days=leave_days,
            holiday_days=holiday_days,
            week_off_days=week_off_days_count,
            total_hours_worked=total_hours,
            average_hours_per_day=avg_hours,
            attendance_percentage=att_pct,
            daily_records=daily_records,
        )

        # Cache in Redis if month has concluded
        if is_closed_month:
            await set_cache(cache_key, response.model_dump_json(), expire_seconds=86400)

        return response

    # -------------------------------------------------------------------------
    # 3. EMPLOYEE YEARLY REPORT
    # -------------------------------------------------------------------------
    async def get_employee_yearly(
        self,
        current_user: User,
        employee_id: uuid.UUID,
        year: int,
    ) -> EmployeeYearlyReportResponse:
        await self._resolve_permissions_and_scope(current_user, target_user_id=employee_id)

        local_today = get_local_today()
        is_closed_year = year < local_today.year
        cache_key = f"reports:attendance:yearly:{employee_id}:{year}"

        if is_closed_year:
            cached_data = await get_cache(cache_key)
            if cached_data:
                try:
                    return EmployeeYearlyReportResponse.model_validate_json(cached_data)
                except Exception as exc:
                    logger.warning("Cache deserialization failed for %s: %s", cache_key, exc)

        # Fetch employee info
        emp_stmt = select(User).options(selectinload(User.department)).where(User.id == employee_id)
        emp_res = await self.session.execute(emp_stmt)
        employee = emp_res.scalar_one_or_none()
        if not employee or employee.deleted_at is not None:
            raise NotFoundException("Employee not found.")

        months_summary: list[MonthSummaryItem] = []
        annual_working_days = 0
        annual_present_days = 0
        annual_absent_days = 0
        annual_leave_days = 0
        annual_total_hours = 0.0

        for m in range(1, 13):
            month_report = await self.get_employee_monthly(
                current_user=current_user,
                employee_id=employee_id,
                month=m,
                year=year,
            )

            annual_working_days += month_report.working_days
            annual_present_days += month_report.present_days
            annual_absent_days += month_report.absent_days
            annual_leave_days += month_report.leave_days
            annual_total_hours += month_report.total_hours_worked

            months_summary.append(
                MonthSummaryItem(
                    month=m,
                    month_name=calendar.month_name[m],
                    working_days=month_report.working_days,
                    present_days=month_report.present_days,
                    absent_days=month_report.absent_days,
                    half_days=month_report.half_days,
                    late_days=month_report.late_days,
                    leave_days=month_report.leave_days,
                    holiday_days=month_report.holiday_days,
                    attendance_percentage=month_report.attendance_percentage,
                    total_hours_worked=month_report.total_hours_worked,
                )
            )

        annual_total_hours = round(annual_total_hours, 2)
        annual_effective_present = sum(m.present_days + (0.5 * m.half_days) for m in months_summary)
        annual_att_pct = (
            round((annual_effective_present / annual_working_days * 100.0), 2)
            if annual_working_days > 0
            else 0.0
        )

        response = EmployeeYearlyReportResponse(
            employee_id=employee.id,
            employee_name=employee.full_name,
            employee_code=employee.employee_code,
            department_name=employee.department.name if employee.department else None,
            year=year,
            annual_working_days=annual_working_days,
            annual_present_days=annual_present_days,
            annual_absent_days=annual_absent_days,
            annual_leave_days=annual_leave_days,
            annual_total_hours=annual_total_hours,
            annual_attendance_percentage=annual_att_pct,
            months=months_summary,
        )

        if is_closed_year:
            await set_cache(cache_key, response.model_dump_json(), expire_seconds=86400)

        return response

    # -------------------------------------------------------------------------
    # 4. MONTHLY OVERVIEW MATRIX (ALL EMPLOYEES)
    # -------------------------------------------------------------------------
    async def get_monthly_overview(
        self,
        current_user: User,
        month: int,
        year: int,
        department_id: uuid.UUID | None = None,
    ) -> MonthlyOverviewResponse:
        perms, scoped_ids = await self._resolve_permissions_and_scope(
            current_user, department_id=department_id
        )

        local_today = get_local_today()
        is_closed_month = (year < local_today.year) or (
            year == local_today.year and month < local_today.month
        )
        cache_key = f"reports:attendance:overview:{year}:{month}:{department_id}:{current_user.id}"

        if is_closed_month:
            cached_data = await get_cache(cache_key)
            if cached_data:
                try:
                    return MonthlyOverviewResponse.model_validate_json(cached_data)
                except Exception as exc:
                    logger.warning("Cache deserialization failed for %s: %s", cache_key, exc)

        # Query all matching employees
        emp_stmt = (
            select(User)
            .options(
                selectinload(User.department),
                selectinload(User.attendance_policy),
            )
            .where(
                and_(
                    User.is_active == True,  # noqa: E712
                    User.deleted_at.is_(None),
                )
            )
        )
        if scoped_ids is not None:
            emp_stmt = emp_stmt.where(User.id.in_(scoped_ids))
        if department_id is not None:
            emp_stmt = emp_stmt.where(User.department_id == department_id)

        emp_stmt = emp_stmt.order_by(User.full_name.asc())
        emp_res = await self.session.execute(emp_stmt)
        employees = list(emp_res.scalars().all())
        employee_ids = [e.id for e in employees]

        _, num_days = calendar.monthrange(year, month)
        start_date = datetime.date(year, month, 1)
        end_date = datetime.date(year, month, num_days)

        # Batch query holidays
        holidays = await self.repo.get_holidays_in_range(start_date, end_date)
        holiday_map = {h.date: h for h in holidays}

        # Batch query all attendance records in range
        rec_stmt = (
            select(AttendanceRecord)
            .options(selectinload(AttendanceRecord.status))
            .where(
                and_(
                    AttendanceRecord.user_id.in_(employee_ids),
                    AttendanceRecord.date >= start_date,
                    AttendanceRecord.date <= end_date,
                )
            )
        )
        rec_res = await self.session.execute(rec_stmt)
        all_records = list(rec_res.scalars().all())

        # Map by (user_id, date)
        records_by_user_date: dict[tuple[uuid.UUID, datetime.date], AttendanceRecord] = {
            (r.user_id, r.date): r for r in all_records
        }

        # Batch query leaves
        leave_stmt = select(LeaveRequest).where(
            and_(
                LeaveRequest.status == LeaveRequestStatus.APPROVED.value,
                LeaveRequest.user_id.in_(employee_ids),
                LeaveRequest.from_date <= end_date,
                LeaveRequest.to_date >= start_date,
            )
        )
        leave_res = await self.session.execute(leave_stmt)
        all_leaves = list(leave_res.scalars().all())
        leaves_by_user: dict[uuid.UUID, list[LeaveRequest]] = {}
        for lv in all_leaves:
            leaves_by_user.setdefault(lv.user_id, []).append(lv)

        # Build overview rows
        rows: list[MonthlyOverviewEmployeeRow] = []

        for emp in employees:
            policy = await self.repo.get_effective_policy(emp)
            week_off_days = policy.week_off_days if policy else [6]
            emp_leaves = leaves_by_user.get(emp.id, [])

            days_dict: dict[int, str] = {}
            p_cnt = 0
            a_cnt = 0
            hd_cnt = 0
            late_cnt = 0
            leave_cnt = 0
            holiday_cnt = 0
            week_off_cnt = 0
            total_minutes = 0
            working_days_count = 0

            for d in range(1, num_days + 1):
                curr_date = datetime.date(year, month, d)
                is_week_off = curr_date.weekday() in week_off_days
                is_holiday = curr_date in holiday_map
                is_working_day = not is_week_off and not is_holiday
                if is_working_day:
                    working_days_count += 1

                rec = records_by_user_date.get((emp.id, curr_date))
                active_leave = next(
                    (lv for lv in emp_leaves if lv.from_date <= curr_date <= lv.to_date),
                    None,
                )

                if rec and rec.status:
                    code = rec.status.code
                    days_dict[d] = code
                    total_minutes += rec.total_minutes
                    if code == "PRESENT":
                        p_cnt += 1
                    elif code == "LATE":
                        late_cnt += 1
                        p_cnt += 1
                    elif code == "HALF_DAY":
                        hd_cnt += 1
                    elif code == "ABSENT":
                        a_cnt += 1
                elif active_leave:
                    days_dict[d] = "ON_LEAVE"
                    leave_cnt += 1
                elif is_holiday:
                    days_dict[d] = "HOLIDAY"
                    holiday_cnt += 1
                elif is_week_off:
                    days_dict[d] = "WEEK_OFF"
                    week_off_cnt += 1
                else:
                    if curr_date <= local_today:
                        days_dict[d] = "ABSENT"
                        a_cnt += 1
                    else:
                        days_dict[d] = "UPCOMING"

            total_hours = round(total_minutes / 60.0, 2)
            effective_present = p_cnt + (0.5 * hd_cnt)
            att_pct = (
                round((effective_present / working_days_count * 100.0), 2)
                if working_days_count > 0
                else 0.0
            )

            rows.append(
                MonthlyOverviewEmployeeRow(
                    employee_id=emp.id,
                    employee_name=emp.full_name,
                    employee_code=emp.employee_code,
                    department_name=emp.department.name if emp.department else None,
                    designation=emp.designation,
                    days=days_dict,
                    present_count=p_cnt,
                    absent_count=a_cnt,
                    half_day_count=hd_cnt,
                    late_count=late_cnt,
                    leave_count=leave_cnt,
                    holiday_count=holiday_cnt,
                    week_off_count=week_off_cnt,
                    total_hours=total_hours,
                    attendance_percentage=att_pct,
                )
            )

        response = MonthlyOverviewResponse(
            month=month,
            year=year,
            total_employees=len(employees),
            department_id=department_id,
            rows=rows,
        )

        if is_closed_month:
            await set_cache(cache_key, response.model_dump_json(), expire_seconds=86400)

        return response
