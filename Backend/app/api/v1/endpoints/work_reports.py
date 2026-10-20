from __future__ import annotations

import datetime
import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db_session
from app.dependencies.auth import (
    require_active_user,
    require_any_permissions,
    require_permission,
)
from app.models.user import User
from app.schemas.work_report import (
    MissingWorkReportListResponse,
    WorkReportCreate,
    WorkReportPageResponse,
    WorkReportResponse,
    WorkReportReviewRequest,
    WorkReportUpdate,
)
from app.services.work_report_service import WorkReportService

router = APIRouter(prefix="/work-reports", tags=["Daily Work Reports & Timesheets"])


# ==============================================================================
# Employee Self-Service Endpoints
# ==============================================================================
@router.post(
    "",
    response_model=WorkReportResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create or save draft daily work report",
    description=(
        "Creates a new draft daily work report or updates an existing draft for the given date. "
        "Validates future dates, editable window, and maximum logged minutes per day."
    ),
)
async def create_or_save_draft(
    payload: WorkReportCreate,
    request: Request,
    current_user: User = Depends(require_permission("work_reports.submit_own")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportResponse:
    service = WorkReportService(session)
    return await service.create_or_save_draft(current_user, payload, request=request)


@router.get(
    "/me",
    response_model=WorkReportPageResponse,
    summary="List personal daily work reports",
    description="Lists the authenticated employee's daily work reports with pagination and date filters.",
)
async def list_my_reports(
    from_date: datetime.date | None = Query(default=None, description="Start date filter"),
    to_date: datetime.date | None = Query(default=None, description="End date filter"),
    status: str | None = Query(default=None, description="Status filter (draft, submitted, reviewed)"),
    page: int = Query(default=1, ge=1, description="Page number"),
    page_size: int = Query(default=20, ge=1, le=100, description="Items per page"),
    current_user: User = Depends(require_permission("work_reports.submit_own")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportPageResponse:
    service = WorkReportService(session)
    return await service.list_my_reports(
        user_id=current_user.id,
        from_date=from_date,
        to_date=to_date,
        status=status,
        page=page,
        page_size=page_size,
    )


@router.get(
    "/by-date/{date}",
    response_model=WorkReportResponse | None,
    summary="Get personal work report for a specific date",
    description="Returns the authenticated employee's work report for the specified date, or null if not yet created.",
)
async def get_my_report_by_date(
    date: datetime.date,
    current_user: User = Depends(require_permission("work_reports.submit_own")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportResponse | None:
    service = WorkReportService(session)
    return await service.get_my_report_by_date(current_user.id, date)


@router.get(
    "/missing",
    response_model=MissingWorkReportListResponse,
    summary="List employees with missing work reports for a date",
    description=(
        "Returns active employees who have not yet submitted a daily work report for the specified date. "
        "Scoped to department if the requester only has team-level permissions."
    ),
)
async def get_missing_reports(
    date: datetime.date = Query(..., description="Target date to check missing reports for"),
    department_id: uuid.UUID | None = Query(default=None, description="Optional department filter"),
    current_user: User = Depends(require_any_permissions("work_reports.view_all", "work_reports.view_team")),
    session: AsyncSession = Depends(get_db_session),
) -> MissingWorkReportListResponse:
    service = WorkReportService(session)
    return await service.get_missing_reports(
        user=current_user,
        report_date=date,
        department_id=department_id,
    )


@router.get(
    "",
    response_model=WorkReportPageResponse,
    summary="List all employee work reports (Manager / Admin)",
    description=(
        "Lists work reports across team members or company-wide. "
        "Requires `work_reports.view_team` or `work_reports.view_all`."
    ),
)
async def list_all_reports(
    employee_id: uuid.UUID | None = Query(default=None, description="Filter by employee"),
    department_id: uuid.UUID | None = Query(default=None, description="Filter by department"),
    from_date: datetime.date | None = Query(default=None, description="Start date filter"),
    to_date: datetime.date | None = Query(default=None, description="End date filter"),
    status: str | None = Query(default=None, description="Filter by status"),
    page: int = Query(default=1, ge=1, description="Page number"),
    page_size: int = Query(default=20, ge=1, le=100, description="Items per page"),
    current_user: User = Depends(require_any_permissions("work_reports.view_all", "work_reports.view_team")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportPageResponse:
    service = WorkReportService(session)
    return await service.list_all_reports(
        user=current_user,
        employee_id=employee_id,
        department_id=department_id,
        from_date=from_date,
        to_date=to_date,
        status=status,
        page=page,
        page_size=page_size,
    )


@router.get(
    "/{id}",
    response_model=WorkReportResponse,
    summary="Get work report detail",
    description="Returns detailed information for a specific work report including items and review comments.",
)
async def get_report_by_id(
    id: uuid.UUID,
    current_user: User = Depends(require_active_user),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportResponse:
    service = WorkReportService(session)
    return await service.get_report_by_id(id, current_user)


@router.put(
    "/{id}",
    response_model=WorkReportResponse,
    summary="Update draft work report",
    description="Updates summary and items of a work report while still in draft mode.",
)
async def update_report(
    id: uuid.UUID,
    payload: WorkReportUpdate,
    request: Request,
    current_user: User = Depends(require_permission("work_reports.submit_own")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportResponse:
    service = WorkReportService(session)
    return await service.update_report(current_user, id, payload, request=request)


@router.post(
    "/{id}/submit",
    response_model=WorkReportResponse,
    summary="Submit daily work report",
    description="Transitions the daily work report from draft to submitted and dispatches notifications to reviewers.",
)
async def submit_report(
    id: uuid.UUID,
    request: Request,
    current_user: User = Depends(require_permission("work_reports.submit_own")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportResponse:
    service = WorkReportService(session)
    return await service.submit_report(current_user, id, request=request)


@router.post(
    "/{id}/review",
    response_model=WorkReportResponse,
    summary="Review employee work report",
    description="Reviews a submitted work report with feedback notes and notifies the employee.",
)
async def review_report(
    id: uuid.UUID,
    payload: WorkReportReviewRequest,
    request: Request,
    current_user: User = Depends(require_permission("work_reports.review")),
    session: AsyncSession = Depends(get_db_session),
) -> WorkReportResponse:
    service = WorkReportService(session)
    return await service.review_report(current_user, id, payload, request=request)
