from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.dependencies.auth import require_any_permissions, require_permission
from app.models.attendance import AttendancePolicy, AttendanceStatus
from app.models.leave import LeaveType
from app.models.organization import Department, OfficeLocation
from app.models.user import User
from app.schemas.common import MessageResponse, Page
from app.schemas.master_data import (
    AttendancePolicyCreate,
    AttendancePolicyResponse,
    AttendancePolicyUpdate,
    AttendanceStatusCreate,
    AttendanceStatusResponse,
    AttendanceStatusUpdate,
    DepartmentCreate,
    DepartmentResponse,
    DepartmentUpdate,
    HolidayCreate,
    HolidayResponse,
    HolidayUpdate,
    LeaveTypeCreate,
    LeaveTypeResponse,
    LeaveTypeUpdate,
    OfficeLocationCreate,
    OfficeLocationResponse,
    OfficeLocationUpdate,
)
from app.services.master_data_service import MasterDataService

router = APIRouter(tags=["Master Data"])


# ==============================================================================
# Departments
# ==============================================================================
@router.get("/departments", response_model=Page[DepartmentResponse], summary="List departments")
async def list_departments(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[DepartmentResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        Department, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[DepartmentResponse.model_validate(d) for d in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/departments",
    response_model=DepartmentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create department",
)
async def create_department(
    payload: DepartmentCreate,
    request: Request,
    user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> DepartmentResponse:
    service = MasterDataService(session)
    dept = await service.create_department(payload, actor_id=user.id, request=request)
    return DepartmentResponse.model_validate(dept)


@router.patch(
    "/departments/{dept_id}", response_model=DepartmentResponse, summary="Update department"
)
async def update_department(
    dept_id: uuid.UUID,
    payload: DepartmentUpdate,
    request: Request,
    user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> DepartmentResponse:
    service = MasterDataService(session)
    dept = await service.update_department(dept_id, payload, actor_id=user.id, request=request)
    return DepartmentResponse.model_validate(dept)


@router.delete(
    "/departments/{dept_id}", response_model=MessageResponse, summary="Deactivate department"
)
async def delete_department(
    dept_id: uuid.UUID,
    request: Request,
    user: User = Depends(require_permission("user.delete")),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    service = MasterDataService(session)
    await service.delete_department(dept_id, actor_id=user.id, request=request)
    return MessageResponse(message="Department deactivated successfully.")


# ==============================================================================
# Office Locations
# ==============================================================================
@router.get(
    "/office-locations",
    response_model=Page[OfficeLocationResponse],
    summary="List office locations",
)
async def list_office_locations(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[OfficeLocationResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        OfficeLocation, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[OfficeLocationResponse.model_validate(loc) for loc in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/office-locations",
    response_model=OfficeLocationResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create office location",
)
async def create_office_location(
    payload: OfficeLocationCreate,
    request: Request,
    user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> OfficeLocationResponse:
    service = MasterDataService(session)
    loc = await service.create_office_location(payload, actor_id=user.id, request=request)
    return OfficeLocationResponse.model_validate(loc)


@router.patch(
    "/office-locations/{location_id}",
    response_model=OfficeLocationResponse,
    summary="Update office location",
)
async def update_office_location(
    location_id: uuid.UUID,
    payload: OfficeLocationUpdate,
    request: Request,
    user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> OfficeLocationResponse:
    service = MasterDataService(session)
    loc = await service.update_office_location(
        location_id, payload, actor_id=user.id, request=request
    )
    return OfficeLocationResponse.model_validate(loc)


# ==============================================================================
# Holidays
# ==============================================================================
@router.get("/holidays", response_model=Page[HolidayResponse], summary="List calendar holidays")
async def list_holidays(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    year: int | None = Query(default=None, ge=2000, le=2100, description="Target calendar year"),
    _user: User = Depends(require_any_permissions("leave.view_all", "leave.view_own", "attendance.view_own")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[HolidayResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_holidays(page=page, page_size=page_size, year=year)
    return Page.create(
        items=[HolidayResponse.model_validate(h) for h in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/holidays",
    response_model=HolidayResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create holiday",
)
async def create_holiday(
    payload: HolidayCreate,
    request: Request,
    user: User = Depends(require_permission("leave.manage_types")),
    session: AsyncSession = Depends(get_db_session),
) -> HolidayResponse:
    service = MasterDataService(session)
    h = await service.create_holiday(payload, actor_id=user.id, request=request)
    return HolidayResponse.model_validate(h)


@router.patch("/holidays/{holiday_id}", response_model=HolidayResponse, summary="Update holiday")
async def update_holiday(
    holiday_id: uuid.UUID,
    payload: HolidayUpdate,
    request: Request,
    user: User = Depends(require_permission("leave.manage_types")),
    session: AsyncSession = Depends(get_db_session),
) -> HolidayResponse:
    service = MasterDataService(session)
    h = await service.update_holiday(holiday_id, payload, actor_id=user.id, request=request)
    return HolidayResponse.model_validate(h)


# ==============================================================================
# Attendance Policies & Statuses
# ==============================================================================
@router.get(
    "/attendance-policies",
    response_model=Page[AttendancePolicyResponse],
    summary="List attendance policies",
)
async def list_attendance_policies(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[AttendancePolicyResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        AttendancePolicy, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[AttendancePolicyResponse.model_validate(p) for p in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/attendance-policies",
    response_model=AttendancePolicyResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create attendance policy",
)
async def create_attendance_policy(
    payload: AttendancePolicyCreate,
    request: Request,
    user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendancePolicyResponse:
    service = MasterDataService(session)
    pol = await service.create_attendance_policy(payload, actor_id=user.id, request=request)
    return AttendancePolicyResponse.model_validate(pol)


@router.patch(
    "/attendance-policies/{policy_id}",
    response_model=AttendancePolicyResponse,
    summary="Update attendance policy",
)
async def update_attendance_policy(
    policy_id: uuid.UUID,
    payload: AttendancePolicyUpdate,
    request: Request,
    user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendancePolicyResponse:
    service = MasterDataService(session)
    pol = await service.update_attendance_policy(
        policy_id, payload, actor_id=user.id, request=request
    )
    return AttendancePolicyResponse.model_validate(pol)


@router.get(
    "/attendance-statuses",
    response_model=Page[AttendanceStatusResponse],
    summary="List attendance statuses",
)
async def list_attendance_statuses(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[AttendanceStatusResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        AttendanceStatus, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[AttendanceStatusResponse.model_validate(s) for s in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/attendance-statuses",
    response_model=AttendanceStatusResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create attendance status",
)
async def create_attendance_status(
    payload: AttendanceStatusCreate,
    request: Request,
    user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceStatusResponse:
    service = MasterDataService(session)
    st = await service.create_attendance_status(payload, actor_id=user.id, request=request)
    return AttendanceStatusResponse.model_validate(st)


@router.patch(
    "/attendance-statuses/{status_id}",
    response_model=AttendanceStatusResponse,
    summary="Update attendance status",
)
async def update_attendance_status(
    status_id: uuid.UUID,
    payload: AttendanceStatusUpdate,
    request: Request,
    user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> AttendanceStatusResponse:
    service = MasterDataService(session)
    st = await service.update_attendance_status(
        status_id, payload, actor_id=user.id, request=request
    )
    return AttendanceStatusResponse.model_validate(st)


# ==============================================================================
# Leave Types
# ==============================================================================
@router.get("/leave-types", response_model=Page[LeaveTypeResponse], summary="List leave types")
async def list_leave_types(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("leave.view_all")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[LeaveTypeResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        LeaveType, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[LeaveTypeResponse.model_validate(lt) for lt in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/leave-types",
    response_model=LeaveTypeResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create leave type",
)
async def create_leave_type(
    payload: LeaveTypeCreate,
    request: Request,
    user: User = Depends(require_permission("leave.manage_types")),
    session: AsyncSession = Depends(get_db_session),
) -> LeaveTypeResponse:
    service = MasterDataService(session)
    lt = await service.create_leave_type(payload, actor_id=user.id, request=request)
    return LeaveTypeResponse.model_validate(lt)


@router.patch(
    "/leave-types/{type_id}", response_model=LeaveTypeResponse, summary="Update leave type"
)
async def update_leave_type(
    type_id: uuid.UUID,
    payload: LeaveTypeUpdate,
    request: Request,
    user: User = Depends(require_permission("leave.manage_types")),
    session: AsyncSession = Depends(get_db_session),
) -> LeaveTypeResponse:
    service = MasterDataService(session)
    lt = await service.update_leave_type(type_id, payload, actor_id=user.id, request=request)
    return LeaveTypeResponse.model_validate(lt)
