from __future__ import annotations

import calendar
import datetime
import uuid
from typing import Any

from fastapi import Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.constants import (
    DEFAULT_FULL_DAY_HOURS,
    DEFAULT_HALF_DAY_HOURS,
    AttendanceStatusCode,
)
from app.core.exceptions import (
    BadRequestException,
    ConflictException,
    ForbiddenException,
    NotFoundException,
)
from app.core.redis import invalidate_cache_pattern
from app.models.attendance import (
    AttendanceCorrection,
    AttendanceRecord,
)
from app.models.user import User
from app.repositories.attendance_repository import AttendanceRepository
from app.schemas.attendance import (
    AttendanceCalendarDay,
    AttendanceCalendarResponse,
    AttendanceCorrectionRequest,
    AttendanceCorrectionResponse,
    AttendanceRecordResponse,
    AttendanceStatusBrief,
    AttendanceTodayResponse,
    CheckInRequest,
    CheckOutRequest,
    DeviceResetResponse,
)
from app.services.audit_service import AuditService
from app.utils.geofence import is_within_geofence
from app.utils.timezone import (
    get_local_today,
    now_utc,
    to_app_timezone,
    to_utc,
)


class AttendanceService:
    """Core attendance verification, time tracking, and calendar engine."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.repo = AttendanceRepository(session)

    async def check_in(
        self,
        user_id: uuid.UUID,
        payload: CheckInRequest,
        request: Request | None = None,
    ) -> AttendanceRecord:
        # 1. Anti-spoofing check
        if payload.is_mock_location:
            raise BadRequestException("Mock location detected. Check-in rejected.")

        # 2. Retrieve user
        user = await self.session.get(User, user_id)
        if not user or not user.is_active or user.deleted_at is not None:
            raise NotFoundException("User not found or inactive.")

        # 3. Device binding validation
        clean_device_id = payload.device_id.strip()
        if not user.device_id:
            user.device_id = clean_device_id
        elif user.device_id != clean_device_id:
            raise ForbiddenException(
                "Device ID mismatch. Your account is bound to a different device. "
                "Contact an administrator to reset your registered device."
            )

        # 4. Working date & time in local APP_TIMEZONE
        server_now_utc = now_utc()
        today_local = get_local_today()

        # 5. Prevent double check-in
        existing = await self.repo.get_by_user_and_date(user.id, today_local)
        if existing and existing.check_in_at is not None:
            raise ConflictException("Employee has already checked in for today.")

        # 6. Retrieve effective policy
        policy = await self.repo.get_effective_policy(user)
        if not policy:
            raise BadRequestException(
                "No active attendance policy configured for your department/organization."
            )

        # 7. Geofence verification
        if policy.require_geofence:
            locations = await self.repo.get_office_locations(policy.allowed_location_ids)
            if not locations:
                raise BadRequestException(
                    "No valid office locations configured for geofence validation."
                )

            inside_any = False
            closest_dist = float("inf")
            for loc in locations:
                is_in, dist = is_within_geofence(
                    payload.latitude,
                    payload.longitude,
                    loc.latitude,
                    loc.longitude,
                    loc.radius_meters,
                )
                if is_in:
                    inside_any = True
                    break
                if dist < closest_dist:
                    closest_dist = dist

            if not inside_any:
                raise BadRequestException(
                    f"Check-in rejected: you are outside the designated office geofence. "
                    f"Distance to nearest office: {int(closest_dist)} meters."
                )

        # 8. Selfie upload verification
        if policy.require_selfie and not payload.selfie_url:
            raise BadRequestException(
                "A verified selfie photo is required for attendance check-in."
            )

        # 9. Late arrival calculation (in APP_TIMEZONE)
        local_now = to_app_timezone(server_now_utc)
        shift_start_dt = datetime.datetime.combine(
            today_local, policy.shift_start, tzinfo=local_now.tzinfo
        )
        grace_cutoff = shift_start_dt + datetime.timedelta(minutes=policy.grace_minutes)

        is_late = local_now > grace_cutoff
        status_code = "LATE" if is_late else "PRESENT"

        status_obj = await self.repo.get_status_by_code(status_code)
        if not status_obj:
            # Fallback to PRESENT if LATE not specifically defined
            status_obj = await self.repo.get_status_by_code("PRESENT")
            if not status_obj:
                raise BadRequestException(
                    "Attendance status master table is uninitialized. Run system seed CLI."
                )

        # 10. Persist or update record
        if existing:
            record = existing
            record.check_in_at = server_now_utc
            record.check_in_lat = payload.latitude
            record.check_in_lng = payload.longitude
            record.check_in_selfie_url = payload.selfie_url
            record.device_id = clean_device_id
            record.status_id = status_obj.id
            record.is_manual = False
        else:
            record = AttendanceRecord(
                user_id=user.id,
                date=today_local,
                check_in_at=server_now_utc,
                check_in_lat=payload.latitude,
                check_in_lng=payload.longitude,
                check_in_selfie_url=payload.selfie_url,
                device_id=clean_device_id,
                status_id=status_obj.id,
                total_minutes=0,
                is_manual=False,
                source="mobile_app",
            )
            self.session.add(record)

        await self.session.commit()
        refreshed = await self.repo.get_by_id(record.id)
        if not refreshed:
            raise NotFoundException("Attendance record not found after creation.")
        return refreshed

    async def check_out(
        self,
        user_id: uuid.UUID,
        payload: CheckOutRequest,
        request: Request | None = None,
    ) -> AttendanceRecord:
        # 1. Anti-spoofing check
        if payload.is_mock_location:
            raise BadRequestException("Mock location detected. Check-out rejected.")

        # 2. Retrieve user
        user = await self.session.get(User, user_id)
        if not user or not user.is_active or user.deleted_at is not None:
            raise NotFoundException("User not found or inactive.")

        # 3. Device binding validation
        clean_device_id = payload.device_id.strip()
        if user.device_id and user.device_id != clean_device_id:
            raise ForbiddenException(
                "Device ID mismatch. Check-out must originate from your registered device."
            )

        # 4. Server time & working date
        server_now_utc = now_utc()
        today_local = get_local_today()

        # 5. Retrieve today's record
        record = await self.repo.get_by_user_and_date(user.id, today_local)
        if not record or record.check_in_at is None:
            raise BadRequestException("No active check-in record found for today.")

        if record.check_out_at is not None:
            raise BadRequestException("Employee has already checked out for today.")

        # 6. Calculate duration
        duration_seconds = (server_now_utc - to_utc(record.check_in_at)).total_seconds()
        total_minutes = max(0, int(duration_seconds // 60))

        record.check_out_at = server_now_utc
        record.check_out_lat = payload.latitude
        record.check_out_lng = payload.longitude
        record.total_minutes = total_minutes
        if payload.remarks:
            record.remarks = payload.remarks.strip()

        # 7. Status calculation using policy thresholds
        policy = await self.repo.get_effective_policy(user)
        full_day_hours = policy.full_day_min_hours if policy else DEFAULT_FULL_DAY_HOURS
        half_day_hours = policy.half_day_min_hours if policy else DEFAULT_HALF_DAY_HOURS
        hours_worked = total_minutes / 60.0

        if hours_worked >= full_day_hours:
            # If initially marked late, preserve LATE; otherwise PRESENT
            if record.status and record.status.code == AttendanceStatusCode.LATE.value:
                pass
            else:
                pres_status = await self.repo.get_status_by_code(AttendanceStatusCode.PRESENT.value)
                if pres_status:
                    record.status_id = pres_status.id
        elif hours_worked >= half_day_hours:
            half_status = await self.repo.get_status_by_code(AttendanceStatusCode.HALF_DAY.value)
            if half_status:
                record.status_id = half_status.id
        else:
            # Under half-day threshold marks as ABSENT due to insufficient hours
            abs_status = await self.repo.get_status_by_code(AttendanceStatusCode.ABSENT.value)
            if abs_status:
                record.status_id = abs_status.id

        await self.session.commit()
        refreshed = await self.repo.get_by_id(record.id)
        if not refreshed:
            raise NotFoundException("Attendance record not found after update.")
        return refreshed

    async def get_today(self, user_id: uuid.UUID) -> AttendanceTodayResponse:
        user = await self.session.get(User, user_id)
        if not user:
            raise NotFoundException("User not found.")

        today_local = get_local_today()
        record = await self.repo.get_by_user_and_date(user_id, today_local)
        policy = await self.repo.get_effective_policy(user)

        record_resp: AttendanceRecordResponse | None = None
        if record:
            record_resp = AttendanceRecordResponse(
                id=record.id,
                user_id=record.user_id,
                date=record.date,
                check_in_at=record.check_in_at,
                check_out_at=record.check_out_at,
                check_in_lat=record.check_in_lat,
                check_in_lng=record.check_in_lng,
                check_out_lat=record.check_out_lat,
                check_out_lng=record.check_out_lng,
                check_in_selfie_url=record.check_in_selfie_url,
                status=AttendanceStatusBrief.model_validate(record.status),
                total_minutes=record.total_minutes,
                is_manual=record.is_manual,
                source=record.source,
                device_id=record.device_id,
                remarks=record.remarks,
                created_at=record.created_at,
            )

        return AttendanceTodayResponse(
            date=today_local,
            has_checked_in=record is not None and record.check_in_at is not None,
            has_checked_out=record is not None and record.check_out_at is not None,
            record=record_resp,
            policy_name=policy.name if policy else None,
            shift_start=policy.shift_start.isoformat() if policy else None,
            shift_end=policy.shift_end.isoformat() if policy else None,
        )

    async def get_calendar(
        self,
        user_id: uuid.UUID,
        year: int,
        month: int,
    ) -> AttendanceCalendarResponse:
        user = await self.session.get(User, user_id)
        if not user:
            raise NotFoundException("User not found.")

        # Determine date range for month
        _, num_days = calendar.monthrange(year, month)
        start_date = datetime.date(year, month, 1)
        end_date = datetime.date(year, month, num_days)

        # Bulk fetch records, holidays, and approved leaves
        records = await self.repo.get_records_for_user_in_range(user_id, start_date, end_date)
        records_by_date = {r.date: r for r in records}

        holidays = await self.repo.get_holidays_in_range(start_date, end_date)
        holidays_by_date = {h.date: h for h in holidays}

        leaves = await self.repo.get_approved_leaves_for_user_in_range(
            user_id, start_date, end_date
        )
        policy = await self.repo.get_effective_policy(user)
        week_off_days = policy.week_off_days if policy else [6]  # default Sunday

        total_working_days = 0
        total_present_days = 0.0
        total_absent_days = 0
        total_half_days = 0
        total_leave_days = 0
        total_holidays = 0
        calendar_days: list[AttendanceCalendarDay] = []

        for day in range(1, num_days + 1):
            cur_date = datetime.date(year, month, day)
            dow = cur_date.weekday()  # 0=Monday, 6=Sunday
            is_weekend = dow in (5, 6)
            is_week_off = dow in week_off_days

            holiday_obj = holidays_by_date.get(cur_date)
            is_holiday = holiday_obj is not None

            # Check if covered by approved leave
            active_leave = next(
                (lv for lv in leaves if lv.from_date <= cur_date <= lv.to_date), None
            )
            is_leave = active_leave is not None

            rec = records_by_date.get(cur_date)

            status_code: str | None = None
            status_label: str | None = None
            status_color: str | None = None
            check_in_at: datetime.datetime | None = None
            check_out_at: datetime.datetime | None = None
            minutes = 0

            if rec:
                check_in_at = rec.check_in_at
                check_out_at = rec.check_out_at
                minutes = rec.total_minutes
                if rec.status:
                    status_code = rec.status.code
                    status_label = rec.status.label
                    status_color = rec.status.color

            # Count metrics
            if is_holiday:
                total_holidays += 1
                if not status_code:
                    status_code = "HOLIDAY"
                    status_label = holiday_obj.name if holiday_obj else "Holiday"
                    status_color = "#8B5CF6"
            elif is_leave:
                total_leave_days += 1
                if not status_code:
                    status_code = "ON_LEAVE"
                    status_label = (
                        active_leave.leave_type.name
                        if active_leave and active_leave.leave_type
                        else "Leave"
                    )
                    status_color = "#6366F1"
            elif is_week_off:
                if not status_code:
                    status_code = AttendanceStatusCode.WEEK_OFF.value
                    status_label = "Weekly Off"
                    status_color = "#64748B"
            else:
                total_working_days += 1
                if status_code in (
                    AttendanceStatusCode.PRESENT.value,
                    AttendanceStatusCode.LATE.value,
                ):
                    total_present_days += 1.0
                elif status_code == AttendanceStatusCode.HALF_DAY.value:
                    total_present_days += 0.5
                    total_half_days += 1
                elif status_code == AttendanceStatusCode.ABSENT.value:
                    total_absent_days += 1

            calendar_days.append(
                AttendanceCalendarDay(
                    date=cur_date,
                    day_of_week=dow,
                    is_weekend=is_weekend,
                    is_holiday=is_holiday,
                    holiday_name=holiday_obj.name if holiday_obj else None,
                    is_week_off=is_week_off,
                    is_leave=is_leave,
                    leave_type_name=(
                        active_leave.leave_type.name
                        if active_leave and active_leave.leave_type
                        else None
                    ),
                    status_code=status_code,
                    status_label=status_label,
                    status_color=status_color,
                    check_in_at=check_in_at,
                    check_out_at=check_out_at,
                    total_minutes=minutes,
                )
            )

        return AttendanceCalendarResponse(
            year=year,
            month=month,
            total_working_days=total_working_days,
            total_present_days=total_present_days,
            total_absent_days=total_absent_days,
            total_half_days=total_half_days,
            total_leave_days=total_leave_days,
            total_holidays=total_holidays,
            days=calendar_days,
        )

    async def manual_correction(
        self,
        record_id: uuid.UUID,
        payload: AttendanceCorrectionRequest,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> AttendanceCorrectionResponse:
        record = await self.repo.get_by_id(record_id)
        if not record:
            raise NotFoundException("Attendance record not found.")

        old_state: dict[str, Any] = {
            "check_in_at": record.check_in_at.isoformat() if record.check_in_at else None,
            "check_out_at": record.check_out_at.isoformat() if record.check_out_at else None,
            "status_id": str(record.status_id),
            "status_code": record.status.code if record.status else None,
            "total_minutes": record.total_minutes,
            "remarks": record.remarks,
        }

        # Apply updates
        if payload.check_in_at is not None:
            record.check_in_at = payload.check_in_at
        if payload.check_out_at is not None:
            record.check_out_at = payload.check_out_at
        if payload.status_id is not None:
            record.status_id = payload.status_id
        if payload.remarks is not None:
            record.remarks = payload.remarks

        # Recompute total minutes if both check-in and check-out exist
        if record.check_in_at and record.check_out_at:
            duration = (to_utc(record.check_out_at) - to_utc(record.check_in_at)).total_seconds()
            record.total_minutes = max(0, int(duration // 60))

        record.is_manual = True

        new_state: dict[str, Any] = {
            "check_in_at": record.check_in_at.isoformat() if record.check_in_at else None,
            "check_out_at": record.check_out_at.isoformat() if record.check_out_at else None,
            "status_id": str(record.status_id),
            "total_minutes": record.total_minutes,
            "remarks": record.remarks,
        }

        # 1. Create AttendanceCorrection row
        correction = AttendanceCorrection(
            attendance_id=record.id,
            changed_by=actor_id,
            old_value=old_state,
            new_value=new_state,
            reason=payload.reason.strip(),
            status="approved",
        )
        self.session.add(correction)

        # 2. Record immutable system audit log
        await AuditService.record(
            self.session,
            action="CORRECT_ATTENDANCE",
            entity_type="ATTENDANCE_RECORD",
            entity_id=record.id,
            actor_id=actor_id,
            old_data=old_state,
            new_data={**new_state, "reason": payload.reason.strip()},
            request=request,
        )

        await self.session.commit()
        await self.session.refresh(correction)

        # Invalidate attendance reports Redis cache
        await invalidate_cache_pattern(f"reports:attendance:*:{record.user_id}:*")
        await invalidate_cache_pattern("reports:attendance:overview:*")
        await invalidate_cache_pattern("reports:attendance:today:*")

        return AttendanceCorrectionResponse(
            id=correction.id,
            attendance_id=correction.attendance_id,
            changed_by=correction.changed_by,
            old_value=correction.old_value,
            new_value=correction.new_value,
            reason=correction.reason,
            status=correction.status,
            created_at=correction.created_at,
        )

    async def reset_device(
        self,
        user_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> DeviceResetResponse:
        user = await self.session.get(User, user_id)
        if not user or not user.is_active or user.deleted_at is not None:
            raise NotFoundException("User not found or inactive.")

        old_device_id = user.device_id
        user.device_id = None

        await AuditService.record(
            self.session,
            action="RESET_DEVICE_BINDING",
            entity_type="USER",
            entity_id=user.id,
            actor_id=actor_id,
            old_data={"device_id": old_device_id},
            new_data={"device_id": None},
            request=request,
        )

        await self.session.commit()
        return DeviceResetResponse(
            user_id=user.id,
            message="Device binding has been reset successfully. Employee can bind a new device on next check-in.",
        )
