from __future__ import annotations

import datetime
import uuid
from typing import Any

from sqlalchemy import and_, func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.constants import LeaveRequestStatus
from app.models.leave import LeaveBalance, LeaveRequest, LeaveType
from app.models.system import SystemSetting
from app.models.user import User


class LeaveRepository:
    """Data persistence and query operations for leave types, balances, and requests."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    # -------------------------------------------------------------------------
    # Leave Types
    # -------------------------------------------------------------------------
    async def get_type_by_id(self, leave_type_id: uuid.UUID) -> LeaveType | None:
        stmt = select(LeaveType).where(LeaveType.id == leave_type_id)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_active_types(self) -> list[LeaveType]:
        stmt = (
            select(LeaveType)
            .where(LeaveType.is_active == True)  # noqa: E712
            .order_by(LeaveType.name.asc())
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    # -------------------------------------------------------------------------
    # Leave Balances
    # -------------------------------------------------------------------------
    async def get_balance(
        self, user_id: uuid.UUID, leave_type_id: uuid.UUID, year: int
    ) -> LeaveBalance | None:
        stmt = (
            select(LeaveBalance)
            .where(
                and_(
                    LeaveBalance.user_id == user_id,
                    LeaveBalance.leave_type_id == leave_type_id,
                    LeaveBalance.year == year,
                )
            )
            .options(selectinload(LeaveBalance.leave_type))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_balances_for_user(self, user_id: uuid.UUID, year: int) -> list[LeaveBalance]:
        stmt = (
            select(LeaveBalance)
            .where(
                and_(
                    LeaveBalance.user_id == user_id,
                    LeaveBalance.year == year,
                )
            )
            .options(selectinload(LeaveBalance.leave_type))
            .order_by(LeaveBalance.created_at.asc())
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    # -------------------------------------------------------------------------
    # Leave Requests
    # -------------------------------------------------------------------------
    async def get_request_by_id(self, request_id: uuid.UUID) -> LeaveRequest | None:
        stmt = (
            select(LeaveRequest)
            .where(LeaveRequest.id == request_id)
            .options(
                selectinload(LeaveRequest.user).selectinload(User.department),
                selectinload(LeaveRequest.leave_type),
                selectinload(LeaveRequest.reviewer),
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_overlapping_request(
        self,
        user_id: uuid.UUID,
        from_date: datetime.date,
        to_date: datetime.date,
        exclude_request_id: uuid.UUID | None = None,
    ) -> LeaveRequest | None:
        """
        Check if user has an existing active (pending or approved) request
        intersecting the date range [from_date, to_date].
        """
        stmt = select(LeaveRequest).where(
            and_(
                LeaveRequest.user_id == user_id,
                LeaveRequest.status.in_(
                    [LeaveRequestStatus.PENDING.value, LeaveRequestStatus.APPROVED.value]
                ),
                LeaveRequest.from_date <= to_date,
                LeaveRequest.to_date >= from_date,
            )
        )
        if exclude_request_id is not None:
            stmt = stmt.where(LeaveRequest.id != exclude_request_id)

        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_requests(
        self,
        user_id: uuid.UUID | None = None,
        user_ids: list[uuid.UUID] | None = None,
        status: str | None = None,
        leave_type_id: uuid.UUID | None = None,
        department_id: uuid.UUID | None = None,
        year: int | None = None,
        skip: int = 0,
        limit: int = 20,
    ) -> tuple[list[LeaveRequest], int]:
        stmt = (
            select(LeaveRequest)
            .join(LeaveRequest.user)
            .options(
                selectinload(LeaveRequest.user).selectinload(User.department),
                selectinload(LeaveRequest.leave_type),
                selectinload(LeaveRequest.reviewer),
            )
        )

        conditions: list[Any] = []

        if user_id is not None:
            conditions.append(LeaveRequest.user_id == user_id)
        elif user_ids is not None:
            conditions.append(LeaveRequest.user_id.in_(user_ids))

        if status:
            conditions.append(LeaveRequest.status == status.lower().strip())

        if leave_type_id is not None:
            conditions.append(LeaveRequest.leave_type_id == leave_type_id)

        if department_id is not None:
            conditions.append(User.department_id == department_id)

        if year is not None:
            start_year = datetime.date(year, 1, 1)
            end_year = datetime.date(year, 12, 31)
            conditions.append(
                and_(
                    LeaveRequest.from_date <= end_year,
                    LeaveRequest.to_date >= start_year,
                )
            )

        if conditions:
            stmt = stmt.where(and_(*conditions))

        # Count total
        count_stmt = select(func.count(LeaveRequest.id)).join(LeaveRequest.user)
        if conditions:
            count_stmt = count_stmt.where(and_(*conditions))

        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar_one()

        stmt = stmt.order_by(LeaveRequest.created_at.desc()).offset(skip).limit(limit)
        items_res = await self.session.execute(stmt)
        return list(items_res.scalars().all()), int(total)

    # -------------------------------------------------------------------------
    # System Settings
    # -------------------------------------------------------------------------
    async def get_system_setting(self, key: str) -> Any | None:
        stmt = select(SystemSetting.value).where(SystemSetting.key == key)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()
