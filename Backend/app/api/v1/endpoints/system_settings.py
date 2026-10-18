from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.dependencies.auth import require_permission
from app.models.user import User
from app.repositories.audit_repository import AuditRepository
from app.schemas.common import Page
from app.schemas.master_data import (
    AuditLogResponse,
    SystemSettingCreateUpdate,
    SystemSettingResponse,
)
from app.services.master_data_service import MasterDataService

router = APIRouter(tags=["System Settings & Audit"])


@router.get(
    "/system-settings",
    response_model=list[SystemSettingResponse],
    summary="List all dynamic system settings",
    description="Retrieves all operational configurations stored dynamically in JSON format.",
)
async def list_system_settings(
    _user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> list[SystemSettingResponse]:
    service = MasterDataService(session)
    settings_list = await service.list_settings()
    return [SystemSettingResponse.model_validate(s) for s in settings_list]


@router.get(
    "/system-settings/{key}",
    response_model=SystemSettingResponse,
    summary="Get system setting by key",
    description="Retrieves a specific operational configuration by its unique key string.",
)
async def get_system_setting(
    key: str,
    _user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> SystemSettingResponse:
    service = MasterDataService(session)
    s = await service.get_setting(key)
    return SystemSettingResponse.model_validate(s)


@router.post(
    "/system-settings",
    response_model=SystemSettingResponse,
    summary="Create or update dynamic system setting",
    description="Idempotently sets an operational configuration in JSON format without hardcoding in application code.",
)
async def upsert_system_setting(
    payload: SystemSettingCreateUpdate,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> SystemSettingResponse:
    service = MasterDataService(session)
    s = await service.upsert_setting(payload, actor_id=user.id, request=request)
    return SystemSettingResponse.model_validate(s)


@router.get(
    "/audit-logs",
    response_model=Page[AuditLogResponse],
    summary="Inspect audit trail logs",
    description="Returns a paginated list of immutable security, employee, and business action audit logs.",
)
async def list_audit_logs(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    entity_type: str | None = Query(
        default=None, description="Filter by entity type (e.g. USER, ROLE)"
    ),
    entity_id: str | None = Query(default=None, description="Filter by target entity ID"),
    actor_id: uuid.UUID | None = Query(default=None, description="Filter by acting user ID"),
    action: str | None = Query(
        default=None, description="Filter by action code (e.g. CREATE, UPDATE)"
    ),
    _user: User = Depends(require_permission("system.view_audit_logs")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[AuditLogResponse]:
    repo = AuditRepository(session)
    items, total = await repo.list_logs(
        page=page,
        page_size=page_size,
        entity_type=entity_type,
        entity_id=entity_id,
        actor_id=actor_id,
        action=action,
    )
    return Page.create(
        items=[AuditLogResponse.model_validate(log) for log in items],
        total=total,
        page=page,
        page_size=page_size,
    )
