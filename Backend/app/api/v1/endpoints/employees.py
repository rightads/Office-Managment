from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, File, Query, Request, UploadFile, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.core.exceptions import BadRequestException
from app.dependencies.auth import get_current_active_user, require_permission
from app.models.user import User
from app.schemas.bulk_import import BulkImportReport
from app.schemas.common import MessageResponse, Page
from app.schemas.employee import (
    EmployeeAdminResetPassword,
    EmployeeAssignManager,
    EmployeeAssignPolicy,
    EmployeeChangeRole,
    EmployeeCreate,
    EmployeeDetailResponse,
    EmployeeResponse,
    EmployeeSelfUpdate,
    EmployeeUpdate,
)
from app.services.bulk_import_service import BulkImportService
from app.services.employee_service import EmployeeService

router = APIRouter(prefix="/employees", tags=["Employees"])


@router.post(
    "",
    response_model=EmployeeResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a new employee",
    description="Provisions a new employee, generates sequential code, creates temporary credentials, and dispatches welcome email.",
)
async def create_employee(
    payload: EmployeeCreate,
    request: Request,
    current_user: User = Depends(require_permission("user.create")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    employee, _temp_password = await service.create_employee(
        payload=payload,
        actor_id=current_user.id,
        request=request,
    )
    return employee


@router.get(
    "",
    response_model=Page[EmployeeResponse],
    summary="List and filter employees",
    description="Returns a paginated list of employees with search across names, emails, and codes, and filtering by department, role, or active status.",
)
async def list_employees(
    page: int = Query(default=1, ge=1, description="Page number"),
    page_size: int = Query(
        default=settings.DEFAULT_PAGE_SIZE,
        ge=1,
        le=settings.MAX_PAGE_SIZE,
        description="Items per page",
    ),
    search: str | None = Query(
        default=None, description="Search term for name, email, code, or phone"
    ),
    department_id: uuid.UUID | None = Query(default=None, description="Filter by department UUID"),
    role_id: uuid.UUID | None = Query(default=None, description="Filter by role UUID"),
    is_active: bool | None = Query(default=None, description="Filter by active status"),
    sort_by: str = Query(default="created_at", description="Field to sort by"),
    sort_order: str = Query(default="desc", pattern="^(asc|desc)$", description="Sort order"),
    _current_user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[EmployeeResponse]:
    service = EmployeeService(session)
    items, total = await service.list_employees(
        page=page,
        page_size=page_size,
        search=search,
        department_id=department_id,
        role_id=role_id,
        is_active=is_active,
        sort_by=sort_by,
        sort_order=sort_order,
    )
    return Page.create(items=items, total=total, page=page, page_size=page_size)


@router.get(
    "/me",
    response_model=EmployeeDetailResponse,
    summary="Get current employee profile",
    description="Self-service endpoint retrieving personal details and assigned permission codes.",
)
async def get_my_profile(
    current_user: User = Depends(get_current_active_user),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeDetailResponse:
    service = EmployeeService(session)
    return await service.get_employee(current_user.id)


@router.patch(
    "/me",
    response_model=EmployeeResponse,
    summary="Self-service profile update",
    description="Allows employees to update limited whitelisted personal fields (phone number, avatar photo).",
)
async def update_my_profile(
    payload: EmployeeSelfUpdate,
    request: Request,
    current_user: User = Depends(get_current_active_user),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.self_update_profile(
        user_id=current_user.id,
        payload=payload,
        request=request,
    )


@router.post(
    "/bulk-import",
    response_model=BulkImportReport,
    summary="Bulk import employees via CSV",
    description="Validates and imports employee rosters from a CSV upload. Supports dry_run mode for pre-validation.",
)
async def bulk_import_employees(
    request: Request,
    file: UploadFile = File(..., description="CSV file with employee roster"),
    dry_run: bool = Query(
        default=False, description="Simulate validation without committing changes"
    ),
    current_user: User = Depends(require_permission("user.create")),
    session: AsyncSession = Depends(get_db_session),
) -> BulkImportReport:
    if not file.filename or not file.filename.lower().endswith(".csv"):
        raise BadRequestException("Uploaded file must be a valid .csv file.")

    content_bytes = await file.read()
    max_bytes = settings.MAX_UPLOAD_MB * 1024 * 1024
    if len(content_bytes) > max_bytes:
        raise BadRequestException(
            f"CSV file exceeds maximum upload limit of {settings.MAX_UPLOAD_MB}MB."
        )

    csv_text = content_bytes.decode("utf-8-sig", errors="replace")
    service = BulkImportService(session)
    return await service.import_employees_csv(
        csv_content=csv_text,
        actor_id=current_user.id,
        dry_run=dry_run,
        request=request,
    )


@router.get(
    "/{employee_id}",
    response_model=EmployeeDetailResponse,
    summary="Get employee details",
    description="Fetches full profile, organizational assignments, and resolved permissions for an employee.",
)
async def get_employee(
    employee_id: uuid.UUID,
    _current_user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeDetailResponse:
    service = EmployeeService(session)
    return await service.get_employee(employee_id)


@router.patch(
    "/{employee_id}",
    response_model=EmployeeResponse,
    summary="Update employee details",
    description="Updates general employee details, designations, and organizational links.",
)
async def update_employee(
    employee_id: uuid.UUID,
    payload: EmployeeUpdate,
    request: Request,
    current_user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.update_employee(
        user_id=employee_id,
        payload=payload,
        actor_id=current_user.id,
        request=request,
    )


@router.post(
    "/{employee_id}/deactivate",
    response_model=EmployeeResponse,
    summary="Deactivate an employee",
    description="Disables an employee account, revokes all active refresh tokens, and enforces last active admin protection.",
)
async def deactivate_employee(
    employee_id: uuid.UUID,
    request: Request,
    current_user: User = Depends(require_permission("user.delete")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.deactivate_employee(
        user_id=employee_id,
        actor_id=current_user.id,
        request=request,
    )


@router.post(
    "/{employee_id}/activate",
    response_model=EmployeeResponse,
    summary="Activate an employee",
    description="Re-enables a previously deactivated employee account.",
)
async def activate_employee(
    employee_id: uuid.UUID,
    request: Request,
    current_user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.activate_employee(
        user_id=employee_id,
        actor_id=current_user.id,
        request=request,
    )


@router.post(
    "/{employee_id}/reset-password",
    response_model=MessageResponse,
    summary="Admin reset employee password",
    description="Generates or sets a temporary password for an employee and flags must_change_password=True.",
)
async def admin_reset_password(
    employee_id: uuid.UUID,
    payload: EmployeeAdminResetPassword,
    request: Request,
    current_user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    service = EmployeeService(session)
    _temp = await service.admin_reset_password(
        user_id=employee_id,
        new_password=payload.new_password,
        actor_id=current_user.id,
        request=request,
    )
    return MessageResponse(message="Employee password has been successfully reset.")


@router.patch(
    "/{employee_id}/role",
    response_model=EmployeeResponse,
    summary="Change employee role",
    description="Reassigns employee role and permissions, enforcing last active admin demotion protection.",
)
async def change_employee_role(
    employee_id: uuid.UUID,
    payload: EmployeeChangeRole,
    request: Request,
    current_user: User = Depends(require_permission("user.manage_roles")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.change_role(
        user_id=employee_id,
        new_role_id=payload.role_id,
        actor_id=current_user.id,
        request=request,
    )


@router.patch(
    "/{employee_id}/manager",
    response_model=EmployeeResponse,
    summary="Assign reporting manager",
    description="Sets or clears the reporting manager for an employee.",
)
async def assign_employee_manager(
    employee_id: uuid.UUID,
    payload: EmployeeAssignManager,
    request: Request,
    current_user: User = Depends(require_permission("user.update")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.assign_manager(
        user_id=employee_id,
        manager_id=payload.manager_id,
        actor_id=current_user.id,
        request=request,
    )


@router.patch(
    "/{employee_id}/attendance-policy",
    response_model=EmployeeResponse,
    summary="Assign attendance policy",
    description="Associates an attendance shift and geofence policy with an employee.",
)
async def assign_employee_policy(
    employee_id: uuid.UUID,
    payload: EmployeeAssignPolicy,
    request: Request,
    current_user: User = Depends(require_permission("attendance.manage_policy")),
    session: AsyncSession = Depends(get_db_session),
) -> EmployeeResponse:
    service = EmployeeService(session)
    return await service.assign_policy(
        user_id=employee_id,
        policy_id=payload.attendance_policy_id,
        actor_id=current_user.id,
        request=request,
    )
