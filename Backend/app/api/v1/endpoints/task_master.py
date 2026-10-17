from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.dependencies.auth import require_permission
from app.models.task import TaskPriority, TaskStatus
from app.models.user import User
from app.schemas.common import MessageResponse, Page
from app.schemas.master_data import (
    TaskPriorityCreate,
    TaskPriorityResponse,
    TaskPriorityUpdate,
    TaskStatusCreate,
    TaskStatusResponse,
    TaskStatusTransitionCreate,
    TaskStatusTransitionResponse,
    TaskStatusUpdate,
)
from app.services.master_data_service import MasterDataService

router = APIRouter(tags=["Task Workflow Master Data"])


# ==============================================================================
# Task Statuses
# ==============================================================================
@router.get(
    "/task-statuses", response_model=Page[TaskStatusResponse], summary="List task workflow statuses"
)
async def list_task_statuses(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("task.view_all")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[TaskStatusResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        TaskStatus, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[TaskStatusResponse.model_validate(ts) for ts in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/task-statuses",
    response_model=TaskStatusResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create task status",
)
async def create_task_status(
    payload: TaskStatusCreate,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskStatusResponse:
    service = MasterDataService(session)
    ts = await service.create_task_status(payload, actor_id=user.id, request=request)
    return TaskStatusResponse.model_validate(ts)


@router.patch(
    "/task-statuses/{status_id}", response_model=TaskStatusResponse, summary="Update task status"
)
async def update_task_status(
    status_id: uuid.UUID,
    payload: TaskStatusUpdate,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskStatusResponse:
    service = MasterDataService(session)
    ts = await service.update_task_status(status_id, payload, actor_id=user.id, request=request)
    return TaskStatusResponse.model_validate(ts)


# ==============================================================================
# Task Priorities
# ==============================================================================
@router.get(
    "/task-priorities",
    response_model=Page[TaskPriorityResponse],
    summary="List task priority tiers",
)
async def list_task_priorities(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_permission("task.view_all")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[TaskPriorityResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        TaskPriority, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[TaskPriorityResponse.model_validate(tp) for tp in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/task-priorities",
    response_model=TaskPriorityResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create task priority",
)
async def create_task_priority(
    payload: TaskPriorityCreate,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskPriorityResponse:
    service = MasterDataService(session)
    tp = await service.create_task_priority(payload, actor_id=user.id, request=request)
    return TaskPriorityResponse.model_validate(tp)


@router.patch(
    "/task-priorities/{priority_id}",
    response_model=TaskPriorityResponse,
    summary="Update task priority",
)
async def update_task_priority(
    priority_id: uuid.UUID,
    payload: TaskPriorityUpdate,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskPriorityResponse:
    service = MasterDataService(session)
    tp = await service.update_task_priority(priority_id, payload, actor_id=user.id, request=request)
    return TaskPriorityResponse.model_validate(tp)


# ==============================================================================
# Task Status Transitions
# ==============================================================================
@router.get(
    "/task-status-transitions",
    response_model=list[TaskStatusTransitionResponse],
    summary="List allowed status transitions",
)
async def list_task_status_transitions(
    _user: User = Depends(require_permission("task.view_all")),
    session: AsyncSession = Depends(get_db_session),
) -> list[TaskStatusTransitionResponse]:
    service = MasterDataService(session)
    transitions = await service.repo.list_task_transitions()
    return [TaskStatusTransitionResponse.model_validate(tr) for tr in transitions]


@router.post(
    "/task-status-transitions",
    response_model=TaskStatusTransitionResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create status transition rule",
)
async def create_task_status_transition(
    payload: TaskStatusTransitionCreate,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> TaskStatusTransitionResponse:
    service = MasterDataService(session)
    tr = await service.create_task_transition(payload, actor_id=user.id, request=request)
    return TaskStatusTransitionResponse.model_validate(tr)


@router.delete(
    "/task-status-transitions/{from_status_id}/{to_status_id}",
    response_model=MessageResponse,
    summary="Delete status transition rule",
)
async def delete_task_status_transition(
    from_status_id: uuid.UUID,
    to_status_id: uuid.UUID,
    request: Request,
    user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    service = MasterDataService(session)
    await service.delete_task_transition(
        from_status_id, to_status_id, actor_id=user.id, request=request
    )
    return MessageResponse(message="Task transition rule deleted successfully.")
