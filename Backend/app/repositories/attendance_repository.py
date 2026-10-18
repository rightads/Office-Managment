from __future__ import annotations

import datetime
import uuid

from sqlalchemy import and_, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.constants import LeaveRequestStatus
from app.models.attendance import (
    AttendancePolicy,
    AttendanceRecord,
    AttendanceStatus,
)
from app.models.leave import LeaveRequest
from app.models.organization import Holiday, OfficeLocation
from app.models.user import User


class AttendanceRepository:
    """Database query and persistence operations for the attendance engine."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    async def get_by_id(self, record_id: uuid.UUID) -> AttendanceRecord | None:
        stmt = (
            select(AttendanceRecord)
            .where(AttendanceRecord.id == record_id)
            .options(selectinload(AttendanceRecord.status))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_by_user_and_date(
        self, user_id: uuid.UUID, record_date: datetime.date
    ) -> AttendanceRecord | None:
        stmt = (
            select(AttendanceRecord)
            .where(
                and_(
                    AttendanceRecord.user_id == user_id,
                    AttendanceRecord.date == record_date,
                )
            )
            .options(selectinload(AttendanceRecord.status))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_records_for_user_in_range(
        self,
        user_id: uuid.UUID,
        start_date: datetime.date,
        end_date: datetime.date,
    ) -> list[AttendanceRecord]:
        stmt = (
            select(AttendanceRecord)
            .where(
                and_(
                    AttendanceRecord.user_id == user_id,
                    AttendanceRecord.date >= start_date,
                    AttendanceRecord.date <= end_date,
                )
            )
            .options(selectinload(AttendanceRecord.status))
            .order_by(AttendanceRecord.date.asc())
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_status_by_code(self, code: str) -> AttendanceStatus | None:
        stmt = select(AttendanceStatus).where(AttendanceStatus.code == code.upper().strip())
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_statuses(self) -> list[AttendanceStatus]:
        stmt = select(AttendanceStatus).where(AttendanceStatus.is_active == True)  # noqa: E712
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_holidays_in_range(
        self, start_date: datetime.date, end_date: datetime.date
    ) -> list[Holiday]:
        stmt = (
            select(Holiday)
            .where(
                and_(
                    Holiday.date >= start_date,
                    Holiday.date <= end_date,
                )
            )
            .order_by(Holiday.date.asc())
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_holiday_on_date(self, check_date: datetime.date) -> Holiday | None:
        stmt = select(Holiday).where(Holiday.date == check_date)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_approved_leaves_for_user_in_range(
        self,
        user_id: uuid.UUID,
        start_date: datetime.date,
        end_date: datetime.date,
    ) -> list[LeaveRequest]:
        stmt = (
            select(LeaveRequest)
            .where(
                and_(
                    LeaveRequest.user_id == user_id,
                    LeaveRequest.status == LeaveRequestStatus.APPROVED.value,
                    LeaveRequest.from_date <= end_date,
                    LeaveRequest.to_date >= start_date,
                )
            )
            .options(selectinload(LeaveRequest.leave_type))
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_approved_leave_on_date(
        self, user_id: uuid.UUID, check_date: datetime.date
    ) -> LeaveRequest | None:
        stmt = (
            select(LeaveRequest)
            .where(
                and_(
                    LeaveRequest.user_id == user_id,
                    LeaveRequest.status == LeaveRequestStatus.APPROVED.value,
                    LeaveRequest.from_date <= check_date,
                    LeaveRequest.to_date >= check_date,
                )
            )
            .options(selectinload(LeaveRequest.leave_type))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_office_locations(
        self, allowed_ids: list[str] | None = None
    ) -> list[OfficeLocation]:
        stmt = select(OfficeLocation).where(OfficeLocation.is_active == True)  # noqa: E712
        if allowed_ids:
            # Parse UUIDs from strings
            valid_uuids: list[uuid.UUID] = []
            for item in allowed_ids:
                try:
                    valid_uuids.append(uuid.UUID(str(item)))
                except ValueError:
                    continue
            if valid_uuids:
                stmt = stmt.where(OfficeLocation.id.in_(valid_uuids))
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_effective_policy(self, user: User) -> AttendancePolicy | None:
        if user.attendance_policy_id:
            stmt = select(AttendancePolicy).where(
                and_(
                    AttendancePolicy.id == user.attendance_policy_id,
                    AttendancePolicy.is_active == True,  # noqa: E712
                )
            )
            res = await self.session.execute(stmt)
            policy = res.scalar_one_or_none()
            if policy:
                return policy

        # Fallback to system default policy
        default_stmt = select(AttendancePolicy).where(
            and_(
                AttendancePolicy.is_default == True,  # noqa: E712
                AttendancePolicy.is_active == True,  # noqa: E712
            )
        )
        res_default = await self.session.execute(default_stmt)
        return res_default.scalar_one_or_none()

    async def get_unclosed_records(self, cutoff_date: datetime.date) -> list[AttendanceRecord]:
        """Find records where check-in was recorded but check-out is missing for dates <= cutoff_date."""
        stmt = (
            select(AttendanceRecord)
            .where(
                and_(
                    AttendanceRecord.date <= cutoff_date,
                    AttendanceRecord.check_in_at.is_not(None),
                    AttendanceRecord.check_out_at.is_(None),
                )
            )
            .options(
                selectinload(AttendanceRecord.status),
                selectinload(AttendanceRecord.user),
            )
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_active_users_missing_attendance(self, target_date: datetime.date) -> list[User]:
        """Find all active users who do NOT have an AttendanceRecord for target_date."""
        existing_subq = (
            select(AttendanceRecord.user_id)
            .where(AttendanceRecord.date == target_date)
            .scalar_subquery()
        )
        stmt = (
            select(User)
            .where(
                and_(
                    User.is_active == True,  # noqa: E712
                    User.deleted_at.is_(None),
                    User.id.not_in(existing_subq),
                )
            )
            .options(selectinload(User.attendance_policy))
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())
