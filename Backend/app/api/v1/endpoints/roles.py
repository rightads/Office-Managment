from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.dependencies.auth import require_permission
from app.models.user import User
from app.schemas.common import MessageResponse, Page
from app.schemas.master_data import PermissionResponse, RoleCreate, RoleResponse, RoleUpdate
from app.services.master_data_service import MasterDataService

router = APIRouter(tags=["Roles & Permissions"])


@router.get(
    "/roles",
    response_model=Page[RoleResponse],
    summary="List authorization roles",
    description="Returns a paginated list of system and custom roles with their associated permissions.",
)
async def list_roles(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _current_user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[RoleResponse]:
    service = MasterDataService(session)
    roles, total = await service.repo.list_roles(
        page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[RoleResponse.model_validate(r) for r in roles],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/roles",
    response_model=RoleResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create authorization role",
    description="Creates a new custom role with designated granular permissions.",
)
async def create_role(
    payload: RoleCreate,
    request: Request,
    current_user: User = Depends(require_permission("user.manage_roles")),
    session: AsyncSession = Depends(get_db_session),
) -> RoleResponse:
    service = MasterDataService(session)
    role = await service.create_role(payload=payload, actor_id=current_user.id, request=request)
    return RoleResponse.model_validate(role)


@router.get(
    "/roles/{role_id}",
    response_model=RoleResponse,
    summary="Get role details",
    description="Fetches role metadata and associated permissions.",
)
async def get_role(
    role_id: uuid.UUID,
    _current_user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> RoleResponse:
    service = MasterDataService(session)
    role = await service.repo.get_role_by_id(role_id)
    if not role:
        from app.core.exceptions import NotFoundException

        raise NotFoundException(f"Role with ID '{role_id}' not found.")
    return RoleResponse.model_validate(role)


@router.patch(
    "/roles/{role_id}",
    response_model=RoleResponse,
    summary="Update role",
    description="Updates role details or modifies assigned permissions.",
)
async def update_role(
    role_id: uuid.UUID,
    payload: RoleUpdate,
    request: Request,
    current_user: User = Depends(require_permission("user.manage_roles")),
    session: AsyncSession = Depends(get_db_session),
) -> RoleResponse:
    service = MasterDataService(session)
    role = await service.update_role(
        role_id=role_id, payload=payload, actor_id=current_user.id, request=request
    )
    return RoleResponse.model_validate(role)


@router.delete(
    "/roles/{role_id}",
    response_model=MessageResponse,
    summary="Delete role",
    description="Deletes a custom role. System roles are protected and cannot be deleted.",
)
async def delete_role(
    role_id: uuid.UUID,
    request: Request,
    current_user: User = Depends(require_permission("user.manage_roles")),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    service = MasterDataService(session)
    await service.delete_role(role_id=role_id, actor_id=current_user.id, request=request)
    return MessageResponse(message="Role deleted successfully.")


@router.get(
    "/permissions",
    response_model=Page[PermissionResponse],
    summary="List granular system permissions",
    description="Read-only paginated catalog of all functional permission codes available in the application.",
)
async def list_permissions(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=50, ge=1, le=100),
    _current_user: User = Depends(require_permission("user.read")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[PermissionResponse]:
    service = MasterDataService(session)
    perms, total = await service.list_permissions(page=page, page_size=page_size)
    return Page.create(
        items=[PermissionResponse.model_validate(p) for p in perms],
        total=total,
        page=page,
        page_size=page_size,
    )
