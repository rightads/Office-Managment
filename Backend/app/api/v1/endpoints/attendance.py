from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db_session
from app.dependencies.auth import require_permission
from app.models.user import User
from app.schemas.attendance import (
    AttendanceCalendarResponse,
    AttendanceCorrectionRequest,
    AttendanceCorrectionResponse,
    AttendanceRecordResponse,
    AttendanceTodayResponse,
    CheckInRequest,
    CheckOutRequest,
    DeviceResetResponse,
)
from app.services.attendance_service import AttendanceService
from app.utils.timezone import get_local_today

router = APIRouter(prefix="/attendance", tags=["Attendance Engine"])


@router.post(
    "/check-in",
    response_model=AttendanceRecordResponse,
    status_code=status.HTTP_200_OK,
    summary="Employee daily check-in",
    description="Records server-time check-in with geofence validation, device binding, and anti-spoofing.",
)
async def check_in(
    payload: CheckInRequest,
    request: Request,
    current_user: User = Depends(require_permission("attendance.check_in")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceRecordResponse:
    service = AttendanceService(session)
    record = await service.check_in(current_user.id, payload, request=request)
    return AttendanceRecordResponse.model_validate(record)


@router.post(
    "/check-out",
    response_model=AttendanceRecordResponse,
    status_code=status.HTTP_200_OK,
    summary="Employee daily check-out",
    description="Records server-time check-out, calculates total work minutes, and resolves final attendance status.",
)
async def check_out(
    payload: CheckOutRequest,
    request: Request,
    current_user: User = Depends(require_permission("attendance.check_in")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceRecordResponse:
    service = AttendanceService(session)
    record = await service.check_out(current_user.id, payload, request=request)
    return AttendanceRecordResponse.model_validate(record)


@router.get(
    "/today",
    response_model=AttendanceTodayResponse,
    summary="Get today's attendance status",
    description="Returns today's shift details, check-in/out timestamps, and current attendance status.",
)
async def get_today_attendance(
    current_user: User = Depends(require_permission("attendance.view_own")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceTodayResponse:
    service = AttendanceService(session)
    return await service.get_today(current_user.id)


@router.get(
    "/me",
    response_model=AttendanceCalendarResponse,
    summary="Get employee monthly attendance calendar",
    description="Returns calendar view for the specified month with day-by-day attendance, holidays, leaves, and week-offs.",
)
async def get_my_calendar(
    month: int = Query(default_factory=lambda: get_local_today().month, ge=1, le=12),
    year: int = Query(default_factory=lambda: get_local_today().year, ge=2000, le=2100),
    current_user: User = Depends(require_permission("attendance.view_own")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceCalendarResponse:
    service = AttendanceService(session)
    return await service.get_calendar(current_user.id, year=year, month=month)


@router.post(
    "/{record_id}/correct",
    response_model=AttendanceCorrectionResponse,
    summary="Manual attendance correction",
    description="Administrator or HR manual override of an attendance record with mandatory reason and immutable audit trail.",
)
async def manual_correction(
    record_id: uuid.UUID,
    payload: AttendanceCorrectionRequest,
    request: Request,
    current_user: User = Depends(require_permission("attendance.correct")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceCorrectionResponse:
    service = AttendanceService(session)
    return await service.manual_correction(
        record_id=record_id,
        payload=payload,
        actor_id=current_user.id,
        request=request,
    )


@router.post(
    "/users/{user_id}/reset-device",
    response_model=DeviceResetResponse,
    summary="Reset employee device binding",
    description="Clears registered device ID for an employee allowing them to bind a replacement device.",
)
async def reset_employee_device(
    user_id: uuid.UUID,
    request: Request,
    current_user: User = Depends(require_permission("user.manage_roles")),
    session: AsyncSession = Depends(get_db_session),
) -> DeviceResetResponse:
    service = AttendanceService(session)
    return await service.reset_device(
        user_id=user_id,
        actor_id=current_user.id,
        request=request,
    )
