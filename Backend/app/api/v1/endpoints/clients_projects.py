from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.dependencies.auth import require_any_permissions, require_permission
from app.models.task import Client, Project
from app.models.user import User
from app.schemas.common import Page
from app.schemas.master_data import (
    ClientCreate,
    ClientResponse,
    ClientUpdate,
    ProjectCreate,
    ProjectResponse,
    ProjectUpdate,
)
from app.services.master_data_service import MasterDataService

router = APIRouter(tags=["Clients & Projects"])


def _to_client_response(c: Client) -> ClientResponse:
    details = c.contact_details or {}
    return ClientResponse(
        id=c.id,
        name=c.name,
        contact_person=details.get("contact_person"),
        email=details.get("email"),
        phone=details.get("phone"),
        address=details.get("address"),
        is_active=c.is_active,
        created_at=c.created_at,
    )


# ==============================================================================
# Clients
# ==============================================================================
@router.get("/clients", response_model=Page[ClientResponse], summary="List agency clients")
async def list_clients(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_any_permissions("client.view_all", "task.view_assigned")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[ClientResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        Client, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[_to_client_response(c) for c in items], total=total, page=page, page_size=page_size
    )


@router.post(
    "/clients",
    response_model=ClientResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create agency client",
)
async def create_client(
    payload: ClientCreate,
    request: Request,
    user: User = Depends(require_permission("client.create")),
    session: AsyncSession = Depends(get_db_session),
) -> ClientResponse:
    service = MasterDataService(session)
    client = await service.create_client(payload, actor_id=user.id, request=request)
    return _to_client_response(client)


@router.patch("/clients/{client_id}", response_model=ClientResponse, summary="Update agency client")
async def update_client(
    client_id: uuid.UUID,
    payload: ClientUpdate,
    request: Request,
    user: User = Depends(require_permission("client.update")),
    session: AsyncSession = Depends(get_db_session),
) -> ClientResponse:
    service = MasterDataService(session)
    client = await service.update_client(client_id, payload, actor_id=user.id, request=request)
    return _to_client_response(client)


# ==============================================================================
# Projects
# ==============================================================================
@router.get("/projects", response_model=Page[ProjectResponse], summary="List client projects")
async def list_projects(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    is_active: bool | None = Query(default=None),
    _user: User = Depends(require_any_permissions("project.view_all", "task.view_assigned")),
    session: AsyncSession = Depends(get_db_session),
) -> Page[ProjectResponse]:
    service = MasterDataService(session)
    items, total = await service.repo.list_paginated(
        Project, page=page, page_size=page_size, is_active=is_active
    )
    return Page.create(
        items=[ProjectResponse.model_validate(p) for p in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.post(
    "/projects",
    response_model=ProjectResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create client project",
)
async def create_project(
    payload: ProjectCreate,
    request: Request,
    user: User = Depends(require_permission("project.create")),
    session: AsyncSession = Depends(get_db_session),
) -> ProjectResponse:
    service = MasterDataService(session)
    proj = await service.create_project(payload, actor_id=user.id, request=request)
    return ProjectResponse.model_validate(proj)


@router.patch(
    "/projects/{project_id}", response_model=ProjectResponse, summary="Update client project"
)
async def update_project(
    project_id: uuid.UUID,
    payload: ProjectUpdate,
    request: Request,
    user: User = Depends(require_permission("project.update")),
    session: AsyncSession = Depends(get_db_session),
) -> ProjectResponse:
    service = MasterDataService(session)
    proj = await service.update_project(project_id, payload, actor_id=user.id, request=request)
    return ProjectResponse.model_validate(proj)
