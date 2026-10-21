from __future__ import annotations

import datetime
import uuid

from fastapi import APIRouter, Depends, Query, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db_session
from app.dependencies.auth import get_current_user
from app.models.user import User
from app.schemas.common import MessageResponse
from app.schemas.dynamic_module import (
    ModuleDefinitionCreate,
    ModuleDefinitionResponse,
    ModuleDefinitionUpdate,
    ModuleFieldCreate,
    ModuleFieldResponse,
    ModuleFieldUpdate,
    ModuleRecordAttachmentCreate,
    ModuleRecordAttachmentResponse,
    ModuleRecordCommentCreate,
    ModuleRecordCommentResponse,
    ModuleRecordCreate,
    ModuleRecordDetailResponse,
    ModuleRecordPageResponse,
    ModuleRecordResponse,
    ModuleRecordStatusChange,
    ModuleRecordUpdate,
    ModuleSummaryResponse,
)
from app.services.dynamic_module_service import DynamicModuleService

router = APIRouter(prefix="/modules", tags=["Dynamic Module Engine"])


# ---------------------------------------------------------------------------
# Module Definitions (Metadata & Schemas)
# ---------------------------------------------------------------------------

@router.get(
    "",
    response_model=list[ModuleDefinitionResponse],
    summary="List all active module definitions visible to current user",
)
async def list_modules(
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> list[ModuleDefinitionResponse]:
    service = DynamicModuleService(session)
    return await service.list_definitions(current_user)


@router.post(
    "/definitions",
    response_model=ModuleDefinitionResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a new dynamic module schema definition (Admin)",
)
async def create_module_definition(
    payload: ModuleDefinitionCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleDefinitionResponse:
    service = DynamicModuleService(session)
    return await service.create_definition(payload, current_user)


@router.get(
    "/{code}",
    response_model=ModuleDefinitionResponse,
    summary="Get complete schema definition, fields, and statuses for a module",
)
async def get_module_definition(
    code: str,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleDefinitionResponse:
    service = DynamicModuleService(session)
    return await service.get_definition(code, current_user)


@router.put(
    "/{code}",
    response_model=ModuleDefinitionResponse,
    summary="Update module metadata (Admin)",
)
async def update_module_definition(
    code: str,
    payload: ModuleDefinitionUpdate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleDefinitionResponse:
    service = DynamicModuleService(session)
    return await service.update_definition(code, payload, current_user)


@router.post(
    "/{code}/fields",
    response_model=ModuleFieldResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Add a field specification to a module (Admin)",
)
async def add_module_field(
    code: str,
    payload: ModuleFieldCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleFieldResponse:
    service = DynamicModuleService(session)
    return await service.add_field(code, payload, current_user)


@router.put(
    "/{code}/fields/{field_id}",
    response_model=ModuleFieldResponse,
    summary="Update or deactivate a module field (Admin)",
)
async def update_module_field(
    code: str,
    field_id: uuid.UUID,
    payload: ModuleFieldUpdate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleFieldResponse:
    service = DynamicModuleService(session)
    return await service.update_field(code, field_id, payload, current_user)


# ---------------------------------------------------------------------------
# Module Records (Data Engine)
# ---------------------------------------------------------------------------

@router.get(
    "/{code}/records",
    response_model=ModuleRecordPageResponse,
    summary="List and filter records for a dynamic module",
)
async def list_module_records(
    code: str,
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=20, ge=1, le=100),
    search: str | None = Query(default=None),
    status: str | None = Query(default=None, description="Status code (e.g. 'new', 'won')"),
    status_id: uuid.UUID | None = Query(default=None),
    assigned_to: uuid.UUID | None = Query(default=None),
    client_id: uuid.UUID | None = Query(default=None),
    from_date: datetime.date | None = Query(default=None),
    to_date: datetime.date | None = Query(default=None),
    sort_by: str | None = Query(default=None),
    sort_desc: bool = Query(default=True),
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordPageResponse:
    service = DynamicModuleService(session)
    return await service.list_records(
        code=code,
        current_user=current_user,
        page=page,
        page_size=page_size,
        search=search,
        status_id=status_id,
        status_code=status,
        assigned_to=assigned_to,
        client_id=client_id,
        from_date=from_date,
        to_date=to_date,
        sort_by=sort_by,
        sort_desc=sort_desc,
    )


@router.post(
    "/{code}/records",
    response_model=ModuleRecordResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a new record in a dynamic module with schema validation",
)
async def create_module_record(
    code: str,
    payload: ModuleRecordCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordResponse:
    service = DynamicModuleService(session)
    return await service.create_record(code, payload, current_user)


@router.get(
    "/{code}/summary",
    response_model=ModuleSummaryResponse,
    summary="Get aggregated counts and field totals for a dynamic module",
)
async def get_module_summary(
    code: str,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleSummaryResponse:
    service = DynamicModuleService(session)
    return await service.get_summary(code, current_user)


@router.get(
    "/{code}/export",
    summary="Export module records to CSV or Excel",
)
async def export_module_records(
    code: str,
    format: str = Query(default="csv", pattern="^(csv|xlsx)$"),
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> Response:
    service = DynamicModuleService(session)
    content, media_type, filename = await service.export_records(code, current_user, export_format=format)
    return Response(
        content=content,
        media_type=media_type,
        headers={"Content-Disposition": f'attachment; filename="{filename}"'},
    )


@router.get(
    "/{code}/records/{id}",
    response_model=ModuleRecordDetailResponse,
    summary="Get record details with comments, attachments, timeline, and allowed transitions",
)
async def get_module_record(
    code: str,
    id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordDetailResponse:
    service = DynamicModuleService(session)
    return await service.get_record(code, id, current_user)


@router.put(
    "/{code}/records/{id}",
    response_model=ModuleRecordResponse,
    summary="Update record data, assignment, or due date",
)
async def update_module_record(
    code: str,
    id: uuid.UUID,
    payload: ModuleRecordUpdate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordResponse:
    service = DynamicModuleService(session)
    return await service.update_record(code, id, payload, current_user)


@router.post(
    "/{code}/records/{id}/status",
    response_model=ModuleRecordResponse,
    summary="Change record status executing valid transition rules",
)
async def change_record_status(
    code: str,
    id: uuid.UUID,
    payload: ModuleRecordStatusChange,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordResponse:
    service = DynamicModuleService(session)
    return await service.change_status(code, id, payload, current_user)


@router.delete(
    "/{code}/records/{id}",
    response_model=MessageResponse,
    summary="Soft-delete a record",
)
async def delete_module_record(
    code: str,
    id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    service = DynamicModuleService(session)
    await service.delete_record(code, id, current_user)
    return MessageResponse(message="Record successfully deleted.")


@router.post(
    "/{code}/records/{id}/comments",
    response_model=ModuleRecordCommentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Add a comment to a module record",
)
async def add_module_record_comment(
    code: str,
    id: uuid.UUID,
    payload: ModuleRecordCommentCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordCommentResponse:
    service = DynamicModuleService(session)
    return await service.add_comment(code, id, payload, current_user)


@router.post(
    "/{code}/records/{id}/attachments",
    response_model=ModuleRecordAttachmentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Add an attachment to a module record",
)
async def add_module_record_attachment(
    code: str,
    id: uuid.UUID,
    payload: ModuleRecordAttachmentCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> ModuleRecordAttachmentResponse:
    service = DynamicModuleService(session)
    return await service.add_attachment(code, id, payload, current_user)
