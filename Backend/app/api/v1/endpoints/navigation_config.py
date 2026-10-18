from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db_session
from app.dependencies.auth import (
    get_current_user,
    require_active_user,
    require_permission,
)
from app.models.user import User
from app.schemas.common import MessageResponse
from app.schemas.master_data import (
    AppModuleCreate,
    AppModuleResponse,
    AppModuleUpdate,
    AppRuntimeConfigResponse,
    EffectiveAttendancePolicyResponse,
    UserNavigationResponse,
)
from app.services.master_data_service import MasterDataService

router = APIRouter(tags=["Navigation, Modules & App Config"])


@router.get(
    "/app/config",
    response_model=AppRuntimeConfigResponse,
    summary="Get non-secret public runtime app configuration",
    description=(
        "Public endpoint returning non-secret runtime settings (app timezone, "
        "pagination limits, upload limits, minimum supported version, force-update "
        "flag, password policy summary, and feature flags). Publicly accessible "
        "so mobile clients can evaluate force-update gates and password rules prior to login."
    ),
)
async def get_app_config(
    session: AsyncSession = Depends(get_db_session),
) -> AppRuntimeConfigResponse:
    service = MasterDataService(session)
    return await service.get_app_runtime_config()


@router.get(
    "/me/navigation",
    response_model=UserNavigationResponse,
    summary="Get permission-filtered navigation and modules for current user",
    description=(
        "Returns active modules visible to the current authenticated user based on "
        "their assigned role permissions, ordered by sort_order, along with the user's "
        "permission codes, role display label, department, and security flags."
    ),
)
async def get_my_navigation(
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> UserNavigationResponse:
    service = MasterDataService(session)
    return await service.get_user_navigation(current_user)


@router.get(
    "/me/attendance-policy",
    response_model=EffectiveAttendancePolicyResponse,
    summary="Get effective attendance policy for current user",
    description=(
        "Returns the effective attendance policy for the authenticated user "
        "(user-specific policy or system default policy), including geofence/selfie "
        "requirements, shift hours, and allowed active office locations with coordinates."
    ),
)
async def get_my_attendance_policy(
    current_user: User = Depends(require_active_user),
    session: AsyncSession = Depends(get_db_session),
) -> EffectiveAttendancePolicyResponse:
    service = MasterDataService(session)
    return await service.get_user_effective_attendance_policy(current_user)


# ==============================================================================
# Admin CRUD for App Modules (permission: modules.manage)
# ==============================================================================
@router.get(
    "/app-modules",
    response_model=list[AppModuleResponse],
    summary="List all registered app modules",
    description="Lists all app modules ordered by sort_order. Requires `modules.manage`.",
)
async def list_app_modules(
    is_active: bool | None = Query(default=None, description="Filter by active status"),
    _user: User = Depends(require_permission("modules.manage")),
    session: AsyncSession = Depends(get_db_session),
) -> list[AppModuleResponse]:
    service = MasterDataService(session)
    modules = await service.list_app_modules(is_active=is_active)
    return [AppModuleResponse.model_validate(m) for m in modules]


@router.get(
    "/app-modules/{module_id}",
    response_model=AppModuleResponse,
    summary="Get app module by ID",
    description="Retrieves a single app module definition by ID. Requires `modules.manage`.",
)
async def get_app_module(
    module_id: uuid.UUID,
    _user: User = Depends(require_permission("modules.manage")),
    session: AsyncSession = Depends(get_db_session),
) -> AppModuleResponse:
    service = MasterDataService(session)
    mod = await service.get_app_module(module_id)
    return AppModuleResponse.model_validate(mod)


@router.post(
    "/app-modules",
    response_model=AppModuleResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create app module",
    description="Creates a new app module registry entry. Requires `modules.manage`.",
)
async def create_app_module(
    payload: AppModuleCreate,
    request: Request,
    user: User = Depends(require_permission("modules.manage")),
    session: AsyncSession = Depends(get_db_session),
) -> AppModuleResponse:
    service = MasterDataService(session)
    mod = await service.create_app_module(payload, actor_id=user.id, request=request)
    return AppModuleResponse.model_validate(mod)


@router.patch(
    "/app-modules/{module_id}",
    response_model=AppModuleResponse,
    summary="Update app module",
    description="Updates an existing app module registry entry. Requires `modules.manage`.",
)
async def update_app_module(
    module_id: uuid.UUID,
    payload: AppModuleUpdate,
    request: Request,
    user: User = Depends(require_permission("modules.manage")),
    session: AsyncSession = Depends(get_db_session),
) -> AppModuleResponse:
    service = MasterDataService(session)
    mod = await service.update_app_module(module_id, payload, actor_id=user.id, request=request)
    return AppModuleResponse.model_validate(mod)


@router.delete(
    "/app-modules/{module_id}",
    response_model=MessageResponse,
    summary="Delete non-base app module",
    description="Deletes a custom app module. Base modules are protected and cannot be deleted. Requires `modules.manage`.",
)
async def delete_app_module(
    module_id: uuid.UUID,
    request: Request,
    user: User = Depends(require_permission("modules.manage")),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    service = MasterDataService(session)
    await service.delete_app_module(module_id, actor_id=user.id, request=request)
    return MessageResponse(message="App module deleted successfully.")
