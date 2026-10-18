from __future__ import annotations

import datetime
import logging
import uuid

from sqlalchemy import and_, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.constants import AttendanceStatusCode, LeaveRequestStatus
from app.core.exceptions import (
    BadRequestException,
    ConflictException,
    ForbiddenException,
    NotFoundException,
)
from app.core.redis import invalidate_cache_pattern
from app.models.attendance import AttendanceRecord, AttendanceStatus
from app.models.leave import LeaveBalance, LeaveRequest
from app.models.user import User
from app.repositories.attendance_repository import AttendanceRepository
from app.repositories.leave_repository import LeaveRepository
from app.repositories.user_repository import UserRepository
from app.schemas.leave import (
    AllocateAnnualBalancesRequest,
    AnnualAllocationResultResponse,
    LeaveApplyRequest,
    LeaveBalanceResponse,
    LeaveRejectRequest,
    LeaveRequestListResponse,
    LeaveRequestResponse,
    LeaveReviewRequest,
    LeaveTypeResponse,
)
from app.services.audit_service import AuditService
from app.services.notification_service import NotificationService
from app.utils.timezone import get_local_today, now_utc

logger = logging.getLogger(__name__)


class LeaveService:
    """Core domain logic for leave applications, approvals, balance management, and attendance synchronization."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.repo = LeaveRepository(session)
        self.att_repo = AttendanceRepository(session)
        self.user_repo = UserRepository(session)

    # -------------------------------------------------------------------------
    # Helper: Working Day Calculation
    # -------------------------------------------------------------------------
    async def calculate_working_days(
        self,
        user: User,
        from_date: datetime.date,
        to_date: datetime.date,
    ) -> tuple[float, list[datetime.date]]:
        """
        Calculate working days between from_date and to_date (inclusive),
        excluding company holidays and the employee's policy week-off days.
        Returns (working_days_count, list_of_working_dates).
        """
        policy = await self.att_repo.get_effective_policy(user)
        week_off_days = policy.week_off_days if policy else [6]

        holidays = await self.att_repo.get_holidays_in_range(from_date, to_date)
        holiday_dates = {h.date for h in holidays}

        working_dates: list[datetime.date] = []
        curr = from_date
        while curr <= to_date:
            if curr.weekday() not in week_off_days and curr not in holiday_dates:
                working_dates.append(curr)
            curr += datetime.timedelta(days=1)

        return float(len(working_dates)), working_dates

    # -------------------------------------------------------------------------
    # 1. Apply For Leave
    # -------------------------------------------------------------------------
    async def apply_leave(
        self,
        user: User,
        payload: LeaveApplyRequest,
    ) -> LeaveRequestResponse:
        if payload.to_date < payload.from_date:
            raise BadRequestException("to_date cannot be earlier than from_date.")

        # 1. Half-day validation
        if payload.is_half_day:
            if payload.from_date != payload.to_date:
                raise BadRequestException(
                    "Half-day leave must be for a single date (from_date must equal to_date)."
                )
            if not payload.half_day_session or payload.half_day_session not in (
                "first_half",
                "second_half",
            ):
                raise BadRequestException(
                    "half_day_session ('first_half' or 'second_half') is required for half-day leaves."
                )

            # Check if this single date is a working day
            policy = await self.att_repo.get_effective_policy(user)
            week_off_days = policy.week_off_days if policy else [6]
            holiday = await self.att_repo.get_holiday_on_date(payload.from_date)

            if payload.from_date.weekday() in week_off_days or holiday is not None:
                raise BadRequestException(
                    "Cannot apply for half-day leave on a weekend or company holiday."
                )
            working_days = 0.5
        else:
            working_days, _ = await self.calculate_working_days(
                user, payload.from_date, payload.to_date
            )
            if working_days <= 0:
                raise BadRequestException(
                    "Selected date range contains no working days (all dates fall on weekends or company holidays)."
                )

        # 2. Past-date rule validation from system_settings
        local_today = get_local_today()
        if payload.from_date < local_today:
            allow_past = await self.repo.get_system_setting("allow_past_leave_applications")
            if allow_past is False:
                raise BadRequestException(
                    "Retroactive leave applications are not permitted by company policy."
                )
            max_past_days = await self.repo.get_system_setting("past_leave_max_days_allowed") or 7
            if (local_today - payload.from_date).days > int(max_past_days):
                raise BadRequestException(
                    f"Retroactive leave applications cannot exceed {max_past_days} past days."
                )

        # 3. Overlapping leave check
        overlap = await self.repo.get_overlapping_request(
            user.id, payload.from_date, payload.to_date
        )
        if overlap:
            raise ConflictException(
                "An existing pending or approved leave request overlaps with the requested date range."
            )

        # 4. Leave type validation & balance check
        leave_type = await self.repo.get_type_by_id(payload.leave_type_id)
        if not leave_type or not leave_type.is_active:
            raise NotFoundException("Leave type not found or is inactive.")

        if leave_type.is_paid:
            balance = await self.repo.get_balance(user.id, leave_type.id, payload.from_date.year)
            available = (
                (balance.allocated + balance.carried_forward - balance.used) if balance else 0.0
            )
            if available < working_days:
                raise BadRequestException(
                    f"Insufficient leave balance for {leave_type.name}. "
                    f"Available: {available:.1f} days, Requested: {working_days:.1f} days."
                )

        # 5. Persist leave request
        leave_req = LeaveRequest(
            user_id=user.id,
            leave_type_id=leave_type.id,
            from_date=payload.from_date,
            to_date=payload.to_date,
            is_half_day=payload.is_half_day,
            half_day_session=payload.half_day_session,
            total_days=working_days,
            reason=payload.reason.strip(),
            status=LeaveRequestStatus.PENDING.value,
        )
        self.session.add(leave_req)
        await self.session.flush()
        await self.session.refresh(leave_req)

        # 6. Disptach notification to manager if assigned
        if user.manager_id:
            await NotificationService.send(
                self.session,
                user_id=user.manager_id,
                title="New Leave Application Submitted",
                body=f"{user.full_name} applied for {working_days:.1f} day(s) of {leave_type.name} ({payload.from_date} to {payload.to_date}).",
                notification_type="LEAVE_APPLIED",
                data={"leave_id": str(leave_req.id), "applicant_id": str(user.id)},
            )

        # 7. Audit log
        await AuditService.record(
            self.session,
            action="LEAVE_APPLY",
            entity_type="LEAVE_REQUEST",
            entity_id=leave_req.id,
            actor_id=user.id,
            new_data={
                "leave_type": leave_type.name,
                "from_date": payload.from_date.isoformat(),
                "to_date": payload.to_date.isoformat(),
                "total_days": working_days,
                "is_half_day": payload.is_half_day,
                "half_day_session": payload.half_day_session,
                "reason": payload.reason.strip(),
            },
        )

        await self.session.commit()

        # Re-fetch with relationships loaded
        saved = await self.repo.get_request_by_id(leave_req.id)
        assert saved is not None
        return self._to_response(saved)

    # -------------------------------------------------------------------------
    # 2. Cancel Pending Leave
    # -------------------------------------------------------------------------
    async def cancel_pending_leave(
        self,
        leave_id: uuid.UUID,
        actor: User,
    ) -> LeaveRequestResponse:
        leave_req = await self.repo.get_request_by_id(leave_id)
        if not leave_req:
            raise NotFoundException("Leave request not found.")

        perms = await self.user_repo.get_user_permissions(actor)
        if (
            leave_req.user_id != actor.id
            and "leave.approve" not in perms
            and "leave.view_all" not in perms
        ):
            raise ForbiddenException("You cannot cancel another employee's leave request.")

        if leave_req.status != LeaveRequestStatus.PENDING.value:
            raise BadRequestException(
                f"Only pending leave requests can be cancelled (current status: '{leave_req.status}')."
            )

        old_status = leave_req.status
        leave_req.status = LeaveRequestStatus.CANCELLED.value
        await self.session.flush()

        # Notify manager if cancelled by employee
        if actor.id == leave_req.user_id and leave_req.user and leave_req.user.manager_id:
            await NotificationService.send(
                self.session,
                user_id=leave_req.user.manager_id,
                title="Leave Application Cancelled",
                body=f"{leave_req.user.full_name} cancelled their pending leave request for {leave_req.from_date} to {leave_req.to_date}.",
                notification_type="LEAVE_CANCELLED",
                data={"leave_id": str(leave_req.id)},
            )

        # Audit log
        await AuditService.record(
            self.session,
            action="LEAVE_CANCEL",
            entity_type="LEAVE_REQUEST",
            entity_id=leave_req.id,
            actor_id=actor.id,
            old_data={"status": old_status},
            new_data={"status": "cancelled"},
        )

        await self.session.commit()
        return self._to_response(leave_req)

    # -------------------------------------------------------------------------
    # 3. Approve Leave
    # -------------------------------------------------------------------------
    async def approve_leave(
        self,
        leave_id: uuid.UUID,
        actor: User,
        payload: LeaveReviewRequest,
    ) -> LeaveRequestResponse:
        leave_req = await self.repo.get_request_by_id(leave_id)
        if not leave_req:
            raise NotFoundException("Leave request not found.")

        # Permissions check
        perms = await self.user_repo.get_user_permissions(actor)
        is_direct_manager = leave_req.user and leave_req.user.manager_id == actor.id
        if "leave.approve" not in perms and "leave.view_all" not in perms and not is_direct_manager:
            raise ForbiddenException("You are not authorized to approve this leave request.")

        if leave_req.status != LeaveRequestStatus.PENDING.value:
            raise BadRequestException(
                f"Cannot approve leave request with status '{leave_req.status}'."
            )

        # Deduct balance
        balance = await self.repo.get_balance(
            leave_req.user_id, leave_req.leave_type_id, leave_req.from_date.year
        )
        if balance:
            balance.used += leave_req.total_days

        # Mark attendance days
        on_leave_code = (
            AttendanceStatusCode.HALF_DAY.value
            if leave_req.is_half_day
            else AttendanceStatusCode.ON_LEAVE.value
        )
        status_stmt = select(AttendanceStatus).where(AttendanceStatus.code == on_leave_code)
        status_res = await self.session.execute(status_stmt)
        att_status = status_res.scalar_one_or_none()

        if att_status:
            _, working_dates = await self.calculate_working_days(
                leave_req.user, leave_req.from_date, leave_req.to_date
            )
            if leave_req.is_half_day and not working_dates:
                working_dates = [leave_req.from_date]

            for d in working_dates:
                existing_record = await self.att_repo.get_by_user_and_date(leave_req.user_id, d)
                if existing_record:
                    existing_record.status_id = att_status.id
                    existing_record.is_manual = True
                    existing_record.source = "LEAVE_APPROVAL"
                    existing_record.remarks = f"Approved leave: {leave_req.leave_type.name}"
                else:
                    new_rec = AttendanceRecord(
                        user_id=leave_req.user_id,
                        date=d,
                        status_id=att_status.id,
                        total_minutes=240 if leave_req.is_half_day else 0,
                        is_manual=True,
                        source="LEAVE_APPROVAL",
                        remarks=f"Approved leave: {leave_req.leave_type.name}",
                    )
                    self.session.add(new_rec)

            # Invalidate attendance reports Redis cache
            await invalidate_cache_pattern(f"reports:attendance:*:{leave_req.user_id}:*")
            await invalidate_cache_pattern("reports:attendance:overview:*")
            await invalidate_cache_pattern("reports:attendance:today:*")

        old_status = leave_req.status
        leave_req.status = LeaveRequestStatus.APPROVED.value
        leave_req.reviewed_by = actor.id
        leave_req.reviewed_at = now_utc()
        leave_req.review_note = payload.review_note.strip() if payload.review_note else None

        await self.session.flush()

        # Send notification to applicant
        await NotificationService.send(
            self.session,
            user_id=leave_req.user_id,
            title="Leave Request Approved",
            body=f"Your leave request for {leave_req.from_date} to {leave_req.to_date} has been approved by {actor.full_name}.",
            notification_type="LEAVE_APPROVED",
            data={"leave_id": str(leave_req.id), "reviewer_id": str(actor.id)},
        )

        # Audit log
        await AuditService.record(
            self.session,
            action="LEAVE_APPROVE",
            entity_type="LEAVE_REQUEST",
            entity_id=leave_req.id,
            actor_id=actor.id,
            old_data={"status": old_status},
            new_data={
                "status": "approved",
                "review_note": leave_req.review_note,
                "days_deducted": leave_req.total_days,
            },
        )

        await self.session.commit()
        refreshed = await self.repo.get_request_by_id(leave_req.id)
        assert refreshed is not None
        return self._to_response(refreshed)

    # -------------------------------------------------------------------------
    # 4. Reject Leave
    # -------------------------------------------------------------------------
    async def reject_leave(
        self,
        leave_id: uuid.UUID,
        actor: User,
        payload: LeaveRejectRequest,
    ) -> LeaveRequestResponse:
        leave_req = await self.repo.get_request_by_id(leave_id)
        if not leave_req:
            raise NotFoundException("Leave request not found.")

        perms = await self.user_repo.get_user_permissions(actor)
        is_direct_manager = leave_req.user and leave_req.user.manager_id == actor.id
        if "leave.approve" not in perms and "leave.view_all" not in perms and not is_direct_manager:
            raise ForbiddenException("You are not authorized to reject this leave request.")

        if leave_req.status != LeaveRequestStatus.PENDING.value:
            raise BadRequestException(
                f"Cannot reject leave request with status '{leave_req.status}'."
            )

        old_status = leave_req.status
        leave_req.status = LeaveRequestStatus.REJECTED.value
        leave_req.reviewed_by = actor.id
        leave_req.reviewed_at = now_utc()
        leave_req.review_note = payload.review_note.strip()

        await self.session.flush()

        # Notify applicant
        await NotificationService.send(
            self.session,
            user_id=leave_req.user_id,
            title="Leave Request Rejected",
            body=f"Your leave request for {leave_req.from_date} to {leave_req.to_date} was rejected. Note: {leave_req.review_note}",
            notification_type="LEAVE_REJECTED",
            data={"leave_id": str(leave_req.id), "reviewer_id": str(actor.id)},
        )

        # Audit log
        await AuditService.record(
            self.session,
            action="LEAVE_REJECT",
            entity_type="LEAVE_REQUEST",
            entity_id=leave_req.id,
            actor_id=actor.id,
            old_data={"status": old_status},
            new_data={"status": "rejected", "review_note": leave_req.review_note},
        )

        await self.session.commit()
        refreshed = await self.repo.get_request_by_id(leave_req.id)
        assert refreshed is not None
        return self._to_response(refreshed)

    # -------------------------------------------------------------------------
    # 5. Cancel Approved Leave (Restores Balance & Attendance)
    # -------------------------------------------------------------------------
    async def cancel_approved_leave(
        self,
        leave_id: uuid.UUID,
        actor: User,
        reason: str | None = None,
    ) -> LeaveRequestResponse:
        leave_req = await self.repo.get_request_by_id(leave_id)
        if not leave_req:
            raise NotFoundException("Leave request not found.")

        perms = await self.user_repo.get_user_permissions(actor)
        is_direct_manager = leave_req.user and leave_req.user.manager_id == actor.id
        is_owner = leave_req.user_id == actor.id

        if (
            not is_owner
            and not is_direct_manager
            and "leave.approve" not in perms
            and "leave.view_all" not in perms
        ):
            raise ForbiddenException(
                "You are not authorized to cancel this approved leave request."
            )

        if leave_req.status != LeaveRequestStatus.APPROVED.value:
            raise BadRequestException("Only approved leave requests can have approval cancelled.")

        # 1. Restore balance
        balance = await self.repo.get_balance(
            leave_req.user_id, leave_req.leave_type_id, leave_req.from_date.year
        )
        if balance:
            balance.used = max(0.0, balance.used - leave_req.total_days)

        # 2. Restore / Clean attendance records created by leave approval
        att_stmt = select(AttendanceRecord).where(
            and_(
                AttendanceRecord.user_id == leave_req.user_id,
                AttendanceRecord.date >= leave_req.from_date,
                AttendanceRecord.date <= leave_req.to_date,
                AttendanceRecord.source == "LEAVE_APPROVAL",
            )
        )
        att_res = await self.session.execute(att_stmt)
        records_to_clean = list(att_res.scalars().all())
        for r in records_to_clean:
            await self.session.delete(r)

        # Invalidate attendance reports Redis cache
        await invalidate_cache_pattern(f"reports:attendance:*:{leave_req.user_id}:*")
        await invalidate_cache_pattern("reports:attendance:overview:*")
        await invalidate_cache_pattern("reports:attendance:today:*")

        old_status = leave_req.status
        leave_req.status = LeaveRequestStatus.CANCELLED.value
        if reason:
            leave_req.review_note = f"Approved leave cancelled: {reason.strip()}"

        await self.session.flush()

        # Notify employee and manager
        await NotificationService.send(
            self.session,
            user_id=leave_req.user_id,
            title="Approved Leave Cancelled",
            body=f"Approved leave for {leave_req.from_date} to {leave_req.to_date} was cancelled. Balance of {leave_req.total_days:.1f} day(s) restored.",
            notification_type="LEAVE_APPROVED_CANCELLED",
            data={"leave_id": str(leave_req.id)},
        )

        # Audit log
        await AuditService.record(
            self.session,
            action="LEAVE_CANCEL_APPROVED",
            entity_type="LEAVE_REQUEST",
            entity_id=leave_req.id,
            actor_id=actor.id,
            old_data={"status": old_status},
            new_data={"status": "cancelled", "restored_days": leave_req.total_days},
        )

        await self.session.commit()
        refreshed = await self.repo.get_request_by_id(leave_req.id)
        assert refreshed is not None
        return self._to_response(refreshed)

    # -------------------------------------------------------------------------
    # 6. Allocate Annual Leave Balances Job / Endpoint
    # -------------------------------------------------------------------------
    async def allocate_annual_balances(
        self,
        payload: AllocateAnnualBalancesRequest,
        actor: User,
    ) -> AnnualAllocationResultResponse:
        perms = await self.user_repo.get_user_permissions(actor)
        if "leave.manage_types" not in perms and "leave.view_all" not in perms:
            raise ForbiddenException("You are not authorized to allocate annual leave balances.")

        target_year = payload.year
        prev_year = target_year - 1

        # Query all active employees
        users_stmt = select(User).where(
            and_(
                User.is_active == True,  # noqa: E712
                User.deleted_at.is_(None),
            )
        )
        users_res = await self.session.execute(users_stmt)
        users = list(users_res.scalars().all())

        leave_types = await self.repo.list_active_types()

        created_count = 0
        updated_count = 0

        for u in users:
            for lt in leave_types:
                # Calculate carry-forward amount if allowed
                cf_amount = 0.0
                if lt.carry_forward:
                    prev_balance = await self.repo.get_balance(u.id, lt.id, prev_year)
                    if prev_balance:
                        unused = max(
                            0.0,
                            prev_balance.allocated
                            + prev_balance.carried_forward
                            - prev_balance.used,
                        )
                        if lt.max_carry_forward > 0:
                            cf_amount = min(unused, float(lt.max_carry_forward))
                        else:
                            cf_amount = unused

                existing = await self.repo.get_balance(u.id, lt.id, target_year)
                if existing is None:
                    new_bal = LeaveBalance(
                        user_id=u.id,
                        leave_type_id=lt.id,
                        year=target_year,
                        allocated=float(lt.annual_quota),
                        carried_forward=cf_amount,
                        used=0.0,
                    )
                    self.session.add(new_bal)
                    created_count += 1
                else:
                    existing.allocated = float(lt.annual_quota)
                    existing.carried_forward = cf_amount
                    updated_count += 1

        await AuditService.record(
            self.session,
            action="ALLOCATE_ANNUAL_LEAVE_BALANCES",
            entity_type="SYSTEM",
            entity_id=str(target_year),
            actor_id=actor.id,
            new_data={
                "target_year": target_year,
                "users_processed": len(users),
                "balances_created": created_count,
                "balances_updated": updated_count,
            },
        )

        await self.session.commit()

        return AnnualAllocationResultResponse(
            year=target_year,
            users_processed=len(users),
            balances_created=created_count,
            balances_updated=updated_count,
        )

    # -------------------------------------------------------------------------
    # 7. Queries: Balances & Requests
    # -------------------------------------------------------------------------
    async def get_my_balances(
        self, user: User, year: int | None = None
    ) -> list[LeaveBalanceResponse]:
        target_year = year or get_local_today().year
        balances = await self.repo.list_balances_for_user(user.id, target_year)
        results: list[LeaveBalanceResponse] = []
        for b in balances:
            available = b.allocated + b.carried_forward - b.used
            results.append(
                LeaveBalanceResponse(
                    id=b.id,
                    user_id=b.user_id,
                    leave_type_id=b.leave_type_id,
                    leave_type_name=b.leave_type.name if b.leave_type else "Leave",
                    year=b.year,
                    allocated=b.allocated,
                    carried_forward=b.carried_forward,
                    used=b.used,
                    available=max(0.0, available),
                )
            )
        return results

    async def list_leaves(
        self,
        current_user: User,
        user_id: uuid.UUID | None = None,
        status: str | None = None,
        leave_type_id: uuid.UUID | None = None,
        department_id: uuid.UUID | None = None,
        year: int | None = None,
        page: int = 1,
        size: int = 20,
    ) -> LeaveRequestListResponse:
        perms = await self.user_repo.get_user_permissions(current_user)

        scoped_user_ids: list[uuid.UUID] | None = None
        filter_user_id: uuid.UUID | None = user_id

        if "leave.view_all" in perms:
            pass  # Full access
        elif "leave.approve" in perms or "attendance.view_team" in perms:
            # Can see direct reports + self
            team_stmt = select(User.id).where(
                and_(
                    User.is_active == True,  # noqa: E712
                    User.deleted_at.is_(None),
                    (User.manager_id == current_user.id) | (User.id == current_user.id),
                )
            )
            team_res = await self.session.execute(team_stmt)
            scoped_user_ids = list(team_res.scalars().all())
            if filter_user_id and filter_user_id not in scoped_user_ids:
                raise ForbiddenException("You cannot view leaves for employees outside your team.")
        else:
            # Regular employee -> self only
            filter_user_id = current_user.id

        skip = (page - 1) * size
        requests, total = await self.repo.list_requests(
            user_id=filter_user_id,
            user_ids=scoped_user_ids,
            status=status,
            leave_type_id=leave_type_id,
            department_id=department_id,
            year=year,
            skip=skip,
            limit=size,
        )

        pages = (total + size - 1) // size if total > 0 else 1
        items = [self._to_response(r) for r in requests]

        return LeaveRequestListResponse(
            items=items,
            total=total,
            page=page,
            size=size,
            pages=pages,
        )

    async def get_leave_by_id(
        self, leave_id: uuid.UUID, current_user: User
    ) -> LeaveRequestResponse:
        leave_req = await self.repo.get_request_by_id(leave_id)
        if not leave_req:
            raise NotFoundException("Leave request not found.")

        perms = await self.user_repo.get_user_permissions(current_user)
        is_owner = leave_req.user_id == current_user.id
        is_manager = leave_req.user and leave_req.user.manager_id == current_user.id

        if (
            not is_owner
            and not is_manager
            and "leave.view_all" not in perms
            and "leave.approve" not in perms
        ):
            raise ForbiddenException("You are not authorized to view this leave request.")

        return self._to_response(leave_req)

    async def list_active_leave_types(self) -> list[LeaveTypeResponse]:
        types = await self.repo.list_active_types()
        return [LeaveTypeResponse.model_validate(t) for t in types]

    # -------------------------------------------------------------------------
    # Helper: Entity to Response Model
    # -------------------------------------------------------------------------
    def _to_response(self, r: LeaveRequest) -> LeaveRequestResponse:
        return LeaveRequestResponse(
            id=r.id,
            user_id=r.user_id,
            user_full_name=r.user.full_name if r.user else "Unknown",
            employee_code=r.user.employee_code if r.user else "Unknown",
            department_name=r.user.department.name if r.user and r.user.department else None,
            leave_type_id=r.leave_type_id,
            leave_type_name=r.leave_type.name if r.leave_type else "Leave",
            from_date=r.from_date,
            to_date=r.to_date,
            is_half_day=r.is_half_day,
            half_day_session=r.half_day_session,
            total_days=r.total_days,
            reason=r.reason,
            status=r.status,
            reviewed_by=r.reviewed_by,
            reviewer_name=r.reviewer.full_name if r.reviewer else None,
            reviewed_at=r.reviewed_at,
            review_note=r.review_note,
            created_at=r.created_at,
        )
