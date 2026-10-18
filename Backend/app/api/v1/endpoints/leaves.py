from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.dependencies.auth import (
    get_current_active_user,
    require_any_permissions,
    require_permission,
)
from app.dependencies.database import get_db
from app.models.user import User
from app.schemas.leave import (
    AllocateAnnualBalancesRequest,
    AnnualAllocationResultResponse,
    LeaveApplyRequest,
    LeaveBalanceResponse,
    LeavePreviewRequest,
    LeavePreviewResponse,
    LeaveRejectRequest,
    LeaveRequestListResponse,
    LeaveRequestResponse,
    LeaveReviewRequest,
    LeaveTypeResponse,
)
from app.services.leave_service import LeaveService

router = APIRouter(prefix="/leaves", tags=["Leave Management"])


@router.get(
    "/types",
    response_model=list[LeaveTypeResponse],
    summary="List Active Leave Types",
    description="Fetch list of configured active leave categories (Casual, Sick, Maternity, etc.).",
)
async def list_leave_types(
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_active_user),
) -> list[LeaveTypeResponse]:
    service = LeaveService(db)
    return await service.list_active_leave_types()


@router.post(
    "/preview",
    response_model=LeavePreviewResponse,
    summary="Preview Leave Application & Calculate Working Days",
    description="Live calculation of working days, balance availability, and overlap check prior to submission.",
)
async def preview_leave(
    payload: LeavePreviewRequest,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_permission("leave.apply")),
) -> LeavePreviewResponse:
    service = LeaveService(db)
    return await service.preview_leave(user=current_user, payload=payload)


@router.post(
    "/apply",
    response_model=LeaveRequestResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Apply for Leave",
    description="Submit a leave application with balance checking, overlap rejection, working-day counting, and past-date validations.",
)
async def apply_leave(
    payload: LeaveApplyRequest,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_permission("leave.apply")),
) -> LeaveRequestResponse:
    service = LeaveService(db)
    return await service.apply_leave(user=current_user, payload=payload)


@router.get(
    "/my-balances",
    response_model=list[LeaveBalanceResponse],
    summary="View Own Leave Balances",
    description="View remaining, allocated, carried-forward, and consumed leave balances for the given year.",
)
async def get_my_balances(
    year: int | None = Query(None, ge=2000, le=2100, description="Target calendar year"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_permission("leave.view_own")),
) -> list[LeaveBalanceResponse]:
    service = LeaveService(db)
    return await service.get_my_balances(user=current_user, year=year)


@router.get(
    "/my-requests",
    response_model=LeaveRequestListResponse,
    summary="View Own Leave Requests",
    description="Paginated list of own submitted leave requests and statuses.",
)
async def get_my_requests(
    status_filter: str | None = Query(None, alias="status", description="Filter by status"),
    year: int | None = Query(None, ge=2000, le=2100, description="Filter by year"),
    page: int = Query(1, ge=1, description="Page number"),
    size: int = Query(20, ge=1, le=100, description="Page size"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_permission("leave.view_own")),
) -> LeaveRequestListResponse:
    service = LeaveService(db)
    return await service.list_leaves(
        current_user=current_user,
        user_id=current_user.id,
        status=status_filter,
        year=year,
        page=page,
        size=size,
    )


@router.get(
    "",
    response_model=LeaveRequestListResponse,
    summary="List Organization / Team Leave Requests",
    description="Admin/Manager endpoint to list and filter leave applications across employees or teams.",
)
async def list_leave_requests(
    user_id: uuid.UUID | None = Query(None, description="Optional employee filter"),
    status_filter: str | None = Query(None, alias="status", description="Filter by status"),
    leave_type_id: uuid.UUID | None = Query(None, description="Filter by leave type"),
    department_id: uuid.UUID | None = Query(None, description="Filter by department"),
    year: int | None = Query(None, ge=2000, le=2100, description="Filter by year"),
    page: int = Query(1, ge=1, description="Page number"),
    size: int = Query(20, ge=1, le=100, description="Page size"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(
        require_any_permissions("leave.view_all", "leave.approve", "attendance.view_team")
    ),
) -> LeaveRequestListResponse:
    service = LeaveService(db)
    return await service.list_leaves(
        current_user=current_user,
        user_id=user_id,
        status=status_filter,
        leave_type_id=leave_type_id,
        department_id=department_id,
        year=year,
        page=page,
        size=size,
    )


@router.get(
    "/{id}",
    response_model=LeaveRequestResponse,
    summary="Get Leave Request Details",
    description="Fetch single leave application by ID.",
)
async def get_leave_by_id(
    id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(
        require_any_permissions("leave.view_own", "leave.view_all", "leave.approve")
    ),
) -> LeaveRequestResponse:
    service = LeaveService(db)
    return await service.get_leave_by_id(leave_id=id, current_user=current_user)


@router.post(
    "/{id}/cancel",
    response_model=LeaveRequestResponse,
    summary="Cancel Pending Leave Request",
    description="Cancel a pending leave application before review.",
)
async def cancel_pending_leave(
    id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_active_user),
) -> LeaveRequestResponse:
    service = LeaveService(db)
    return await service.cancel_pending_leave(leave_id=id, actor=current_user)


@router.post(
    "/{id}/approve",
    response_model=LeaveRequestResponse,
    summary="Approve Leave Request",
    description="Approve a pending leave application, deduct balance, mark attendance days as Leave, and notify the employee.",
)
async def approve_leave(
    id: uuid.UUID,
    payload: LeaveReviewRequest,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_any_permissions("leave.approve", "leave.view_all")),
) -> LeaveRequestResponse:
    service = LeaveService(db)
    return await service.approve_leave(leave_id=id, actor=current_user, payload=payload)


@router.post(
    "/{id}/reject",
    response_model=LeaveRequestResponse,
    summary="Reject Leave Request",
    description="Reject a pending leave application with a required reason/note and notify the employee.",
)
async def reject_leave(
    id: uuid.UUID,
    payload: LeaveRejectRequest,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_any_permissions("leave.approve", "leave.view_all")),
) -> LeaveRequestResponse:
    service = LeaveService(db)
    return await service.reject_leave(leave_id=id, actor=current_user, payload=payload)


@router.post(
    "/{id}/cancel-approved",
    response_model=LeaveRequestResponse,
    summary="Cancel Approved Leave Request",
    description="Cancel an already approved leave, restore deducted balance and revert attendance records.",
)
async def cancel_approved_leave(
    id: uuid.UUID,
    reason: str | None = Query(None, description="Optional cancellation reason"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_active_user),
) -> LeaveRequestResponse:
    service = LeaveService(db)
    return await service.cancel_approved_leave(leave_id=id, actor=current_user, reason=reason)


@router.post(
    "/allocate-annual-balances",
    response_model=AnnualAllocationResultResponse,
    summary="Allocate Annual Leave Balances Job",
    description="Admin/HR batch allocation of leave balances for all active employees with carry-forward rules from DB.",
)
async def allocate_annual_balances(
    payload: AllocateAnnualBalancesRequest,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(require_permission("leave.manage_types")),
) -> AnnualAllocationResultResponse:
    service = LeaveService(db)
    return await service.allocate_annual_balances(payload=payload, actor=current_user)
