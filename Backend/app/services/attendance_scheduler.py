from __future__ import annotations

import datetime
import logging
from typing import TYPE_CHECKING

from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.cron import CronTrigger

from app.core.config import settings
from app.core.database import async_session_factory
from app.models.attendance import AttendanceRecord
from app.repositories.attendance_repository import AttendanceRepository
from app.utils.timezone import (
    combine_date_time_to_utc,
    get_app_timezone,
    get_local_today,
    to_utc,
)

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession

logger = logging.getLogger(__name__)


async def auto_close_unclosed_checkouts(session: AsyncSession) -> int:
    """
    Auto-close attendance records where employees checked in but forgot to check out.
    Applies shift_end as check_out_at and recalculates final status and total minutes.
    """
    repo = AttendanceRepository(session)
    today_local = get_local_today()

    # Records from previous working days that are still unclosed
    unclosed = await repo.get_unclosed_records(today_local - datetime.timedelta(days=1))
    closed_count = 0

    for rec in unclosed:
        if not rec.check_in_at:
            continue

        policy = await repo.get_effective_policy(rec.user)
        shift_end = policy.shift_end if policy else datetime.time(18, 30)
        auto_checkout_utc = combine_date_time_to_utc(rec.date, shift_end)

        # Ensure checkout is after check-in
        check_in_utc = to_utc(rec.check_in_at)
        if auto_checkout_utc <= check_in_utc:
            auto_checkout_utc = check_in_utc + datetime.timedelta(hours=8)

        diff_seconds = (auto_checkout_utc - check_in_utc).total_seconds()
        total_mins = max(0, int(diff_seconds // 60))

        rec.check_out_at = auto_checkout_utc
        rec.total_minutes = total_mins
        rec.remarks = f"{rec.remarks or ''} [Auto-closed by system]".strip()

        # Re-evaluate status based on policy thresholds
        hours = total_mins / 60.0
        full_day = policy.full_day_min_hours if policy else 8.0
        half_day = policy.half_day_min_hours if policy else 4.0

        if hours >= full_day:
            if rec.status and rec.status.code == "LATE":
                pass
            else:
                pres = await repo.get_status_by_code("PRESENT")
                if pres:
                    rec.status_id = pres.id
        elif hours >= half_day:
            half = await repo.get_status_by_code("HALF_DAY")
            if half:
                rec.status_id = half.id
        else:
            absent = await repo.get_status_by_code("ABSENT")
            if absent:
                rec.status_id = absent.id

        closed_count += 1

    await session.commit()
    logger.info("Auto-closed %d unclosed check-in records.", closed_count)
    return closed_count


async def nightly_attendance_processor(
    session: AsyncSession, target_date: datetime.date | None = None
) -> int:
    """
    Idempotent nightly processor: finds active employees with no record on target_date,
    and assigns them HOLIDAY, WEEK_OFF, ON_LEAVE, or ABSENT.
    """
    repo = AttendanceRepository(session)
    date_to_process = target_date or get_local_today()

    missing_users = await repo.get_active_users_missing_attendance(date_to_process)
    if not missing_users:
        logger.info("Nightly processor: all employees have records for %s.", date_to_process)
        return 0

    holiday = await repo.get_holiday_on_date(date_to_process)
    created_count = 0

    for user in missing_users:
        status_code = "ABSENT"
        remarks = "Unexcused absence"

        if holiday:
            status_code = "HOLIDAY"
            remarks = holiday.name
        else:
            # Check for approved leave
            approved_leave = await repo.get_approved_leave_on_date(user.id, date_to_process)
            if approved_leave:
                status_code = "ON_LEAVE"
                leave_name = (
                    approved_leave.leave_type.name
                    if approved_leave.leave_type
                    else "Approved Leave"
                )
                remarks = f"Approved Leave ({leave_name})"
            else:
                policy = await repo.get_effective_policy(user)
                week_off_days = policy.week_off_days if policy else [6]
                if date_to_process.weekday() in week_off_days:
                    status_code = "WEEK_OFF"
                    remarks = "Weekly scheduled off"

        status_obj = await repo.get_status_by_code(status_code)
        if not status_obj:
            status_obj = await repo.get_status_by_code("ABSENT")
            if not status_obj:
                continue

        record = AttendanceRecord(
            user_id=user.id,
            date=date_to_process,
            status_id=status_obj.id,
            total_minutes=0,
            is_manual=False,
            source="nightly_cron",
            remarks=remarks,
        )
        session.add(record)
        created_count += 1

    await session.commit()
    logger.info("Nightly processor marked %d records for %s.", created_count, date_to_process)
    return created_count


class AttendanceScheduler:
    """Manages APScheduler background tasks for attendance automation."""

    def __init__(self) -> None:
        self.scheduler = AsyncIOScheduler(timezone=str(get_app_timezone()))

    async def _run_auto_close(self) -> None:
        async with async_session_factory() as session:
            try:
                await auto_close_unclosed_checkouts(session)
            except Exception as e:
                logger.error("Error running auto_close_unclosed_checkouts job: %s", e)

    async def _run_nightly_processor(self) -> None:
        async with async_session_factory() as session:
            try:
                await nightly_attendance_processor(session)
            except Exception as e:
                logger.error("Error running nightly_attendance_processor job: %s", e)

    def start(self) -> None:
        if not settings.SCHEDULER_ENABLED:
            logger.info("Background scheduler is disabled via settings.")
            return

        # 1. Hourly job to close forgotten checkouts
        self.scheduler.add_job(
            self._run_auto_close,
            trigger=CronTrigger(minute=0),
            id="attendance_auto_close",
            name="Auto-close forgotten check-outs",
            replace_existing=True,
        )

        # 2. Nightly job to mark missing records
        self.scheduler.add_job(
            self._run_nightly_processor,
            trigger=CronTrigger(
                hour=settings.SCHEDULER_NIGHTLY_HOUR,
                minute=settings.SCHEDULER_NIGHTLY_MINUTE,
            ),
            id="attendance_nightly_processor",
            name="Nightly employee attendance processor",
            replace_existing=True,
        )

        self.scheduler.start()
        logger.info("Attendance background scheduler started successfully.")

    def shutdown(self) -> None:
        if self.scheduler.running:
            self.scheduler.shutdown(wait=False)
            logger.info("Attendance background scheduler stopped.")


scheduler_instance = AttendanceScheduler()
