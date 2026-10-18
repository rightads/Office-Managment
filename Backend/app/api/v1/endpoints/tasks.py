from __future__ import annotations

import datetime
import os
import uuid

from fastapi import (
    APIRouter,
    Depends,
    File,
    Query,
    UploadFile,
    status,
)
from fastapi.responses import FileResponse
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.core.exceptions import (
    BadRequestException,
    ForbiddenException,
    NotFoundException,
)
from app.dependencies.auth import get_current_user, require_permission
from app.models.user import User
from app.schemas.common import Page, UserBriefResponse
from app.schemas.task import (
    TaskActivityResponse,
    TaskAssignRequest,
    TaskAttachmentResponse,
    TaskCommentCreate,
    TaskCommentResponse,
    TaskCreateRequest,
    TaskDetailResponse,
    TaskResponse,
    TaskStatusTransitionRequest,
    TaskSummaryReportsResponse,
    TaskUpdateRequest,
)
from app.services.storage_service import LocalStorageService, get_storage_service
from app.services.task_service import TaskService

router = APIRouter(prefix="/tasks", tags=["Task Management"])


# ==============================================================================
# Helper to check permissions dynamically
# ==============================================================================
def _has_permission(user: User, perm: str) -> bool:
    if not user.role:
        return False
    return any(p.code == "*" or p.code == perm for p in user.role.permissions)


def _get_user_permissions(user: User) -> set[str]:
    if not user.role:
        return set()
    return {p.code for p in user.role.permissions}


# ==============================================================================
# Reports & Analytics (Must be defined above /{task_id} to avoid path collision)
# ==============================================================================
@router.get(
    "/reports/summary",
    response_model=TaskSummaryReportsResponse,
    summary="Task completion, overdue, and distribution metrics",
)
async def get_task_reports(
    current_user: User = Depends(require_permission("task.view_all")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskSummaryReportsResponse:
    service = TaskService(session)
    return await service.get_summary_reports()


# ==============================================================================
# Local Attachment Signed Download
# ==============================================================================
@router.get(
    "/attachments/download",
    summary="Download task attachment via signed URL",
)
async def download_task_attachment(
    key: str = Query(...),
    expires: int = Query(...),
    signature: str = Query(...),
    filename: str = Query(default="attachment"),
) -> FileResponse:
    storage = get_storage_service()
    if isinstance(storage, LocalStorageService):
        if not storage.verify_signature(key, expires, signature):
            raise ForbiddenException("Invalid or expired download link.")

        clean_key = os.path.normpath(key).replace("\\", "/")
        if ".." in clean_key or clean_key.startswith("/"):
            raise ForbiddenException("Invalid file path.")

        full_path = os.path.join(storage.base_path, clean_key)
        if not os.path.exists(full_path):
            raise NotFoundException("File not found on server.")

        return FileResponse(
            path=full_path,
            filename=filename,
            media_type="application/octet-stream",
        )
    raise BadRequestException("Direct download endpoint only supported for local storage.")


# ==============================================================================
# My Tasks (Employee convenience endpoint)
# ==============================================================================
@router.get(
    "/my",
    response_model=Page[TaskResponse],
    summary="List tasks assigned to current employee",
)
async def get_my_tasks(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    status_id: uuid.UUID | None = Query(default=None),
    priority_id: uuid.UUID | None = Query(default=None),
    is_overdue: bool | None = Query(default=None),
    due_from: datetime.datetime | None = Query(default=None),
    due_to: datetime.datetime | None = Query(default=None),
    search: str | None = Query(default=None),
    sort_by: str = Query(default="created_at"),
    sort_desc: bool = Query(default=True),
    current_user: User = Depends(require_permission("task.view_assigned")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[TaskResponse]:
    service = TaskService(session)
    tasks, total = await service.repo.list_tasks_paginated(
        page=page,
        page_size=page_size,
        status_id=status_id,
        priority_id=priority_id,
        is_overdue=is_overdue,
        due_from=due_from,
        due_to=due_to,
        search=search,
        sort_by=sort_by,
        sort_desc=sort_desc,
        scoped_user_id=current_user.id,
    )
    return Page.create(
        items=[service._to_task_response(t) for t in tasks],
        total=total,
        page=page,
        page_size=page_size,
    )


# ==============================================================================
# General Task Listing & Creation
# ==============================================================================
@router.get(
    "",
    response_model=Page[TaskResponse],
    summary="List tasks with filters, search, and pagination",
)
async def list_tasks(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    assignee_id: uuid.UUID | None = Query(default=None),
    department_id: uuid.UUID | None = Query(default=None),
    client_id: uuid.UUID | None = Query(default=None),
    project_id: uuid.UUID | None = Query(default=None),
    status_id: uuid.UUID | None = Query(default=None),
    priority_id: uuid.UUID | None = Query(default=None),
    is_overdue: bool | None = Query(default=None),
    due_from: datetime.datetime | None = Query(default=None),
    due_to: datetime.datetime | None = Query(default=None),
    search: str | None = Query(default=None),
    sort_by: str = Query(default="created_at"),
    sort_desc: bool = Query(default=True),
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> Page[TaskResponse]:
    can_view_all = _has_permission(current_user, "task.view_all")
    can_view_assigned = _has_permission(current_user, "task.view_assigned")

    if not can_view_all and not can_view_assigned:
        raise ForbiddenException("You do not have permission to view tasks.")

    # Scope to current_user if user cannot view all tasks
    scoped_user_id = None if can_view_all else current_user.id

    service = TaskService(session)
    tasks, total = await service.repo.list_tasks_paginated(
        page=page,
        page_size=page_size,
        assignee_id=assignee_id,
        department_id=department_id,
        client_id=client_id,
        project_id=project_id,
        status_id=status_id,
        priority_id=priority_id,
        is_overdue=is_overdue,
        due_from=due_from,
        due_to=due_to,
        search=search,
        sort_by=sort_by,
        sort_desc=sort_desc,
        scoped_user_id=scoped_user_id,
    )
    return Page.create(
        items=[service._to_task_response(t) for t in tasks],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "",
    response_model=TaskResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a new task with assignees",
)
async def create_task(
    payload: TaskCreateRequest,
    current_user: User = Depends(require_permission("task.create")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskResponse:
    service = TaskService(session)
    return await service.create_task(payload, creator=current_user)


# ==============================================================================
# Task Details, Edit, Archive
# ==============================================================================
@router.get(
    "/{task_id}",
    response_model=TaskDetailResponse,
    summary="Get task details",
)
async def get_task_detail(
    task_id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> TaskDetailResponse:
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    return await service.get_task_detail(task_id, current_user, can_view_all=can_view_all)


@router.patch(
    "/{task_id}",
    response_model=TaskResponse,
    summary="Update task properties (title, description, client, project, priority, due date)",
)
async def update_task(
    task_id: uuid.UUID,
    payload: TaskUpdateRequest,
    current_user: User = Depends(require_permission("task.update")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskResponse:
    service = TaskService(session)
    return await service.update_task(task_id, payload, actor=current_user)


@router.delete(
    "/{task_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Archive / Soft delete a task",
)
async def archive_task(
    task_id: uuid.UUID,
    current_user: User = Depends(require_permission("task.delete")),
    session: AsyncSession = Depends(get_db_session),
) -> None:
    service = TaskService(session)
    await service.archive_task(task_id, actor=current_user)


# ==============================================================================
# Assignment & Status Transitions
# ==============================================================================
@router.post(
    "/{task_id}/assign",
    response_model=TaskResponse,
    summary="Bulk assign or reassign task assignees",
)
async def assign_task(
    task_id: uuid.UUID,
    payload: TaskAssignRequest,
    current_user: User = Depends(require_permission("task.update")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskResponse:
    service = TaskService(session)
    return await service.assign_task(task_id, payload, actor=current_user)


@router.post(
    "/{task_id}/status",
    response_model=TaskResponse,
    summary="Update task status along allowed DB transitions",
)
async def update_task_status(
    task_id: uuid.UUID,
    payload: TaskStatusTransitionRequest,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> TaskResponse:
    user_perms = _get_user_permissions(current_user)
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    return await service.update_status(
        task_id=task_id,
        payload=payload,
        actor=current_user,
        user_permissions=user_perms,
        can_view_all=can_view_all,
    )


# ==============================================================================
# Timeline
# ==============================================================================
@router.get(
    "/{task_id}/timeline",
    response_model=list[TaskActivityResponse],
    summary="Get task activity audit history timeline",
)
async def get_task_timeline(
    task_id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> list[TaskActivityResponse]:
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    activities = await service.get_timeline(task_id, current_user, can_view_all=can_view_all)
    return [
        TaskActivityResponse(
            id=a.id,
            task_id=a.task_id,
            action=a.action,
            details=a.details or {},
            actor=UserBriefResponse.model_validate(a.actor),
            created_at=a.created_at,
        )
        for a in activities
    ]


# ==============================================================================
# Comments
# ==============================================================================
@router.post(
    "/{task_id}/comments",
    response_model=TaskCommentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Post a comment on a task",
)
async def add_task_comment(
    task_id: uuid.UUID,
    payload: TaskCommentCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> TaskCommentResponse:
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    return await service.add_comment(
        task_id=task_id,
        comment_text=payload.comment,
        author=current_user,
        can_view_all=can_view_all,
    )


@router.get(
    "/{task_id}/comments",
    response_model=list[TaskCommentResponse],
    summary="List comments for a task",
)
async def list_task_comments(
    task_id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> list[TaskCommentResponse]:
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    return await service.list_comments(task_id, current_user, can_view_all=can_view_all)


# ==============================================================================
# Attachments
# ==============================================================================
@router.post(
    "/{task_id}/attachments",
    response_model=TaskAttachmentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Upload a file attachment to a task",
)
async def upload_task_attachment(
    task_id: uuid.UUID,
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> TaskAttachmentResponse:
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    att = await service.upload_attachment(task_id, file, current_user, can_view_all=can_view_all)

    download_url = service.storage.generate_signed_url(
        storage_key=att.file_url,
        filename=att.file_name,
        expires_in_seconds=3600,
    )
    return TaskAttachmentResponse(
        id=att.id,
        task_id=att.task_id,
        file_name=att.file_name,
        file_size_bytes=att.file_size_bytes,
        mime_type=att.mime_type,
        download_url=download_url,
        uploader=UserBriefResponse.model_validate(current_user),
        created_at=att.created_at,
    )


@router.get(
    "/{task_id}/attachments",
    response_model=list[TaskAttachmentResponse],
    summary="List file attachments with time-limited signed URLs",
)
async def list_task_attachments(
    task_id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> list[TaskAttachmentResponse]:
    can_view_all = _has_permission(current_user, "task.view_all")
    service = TaskService(session)
    data = await service.list_attachments(task_id, current_user, can_view_all=can_view_all)
    return [TaskAttachmentResponse(**item) for item in data]
