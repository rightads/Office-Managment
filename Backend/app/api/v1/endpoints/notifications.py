from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.database import get_db_session
from app.core.exceptions import NotFoundException
from app.dependencies.auth import get_current_user, require_permission
from app.models.user import User
from app.repositories.notification_repository import NotificationRepository
from app.schemas.common import MessageResponse, Page
from app.schemas.communication import (
    DeviceTokenRegisterRequest,
    DeviceTokenResponse,
    NotificationResponse,
    NotificationTemplateResponse,
    NotificationTemplateUpdateRequest,
    NotificationUnreadCountResponse,
)

router = APIRouter(prefix="/notifications", tags=["Notifications"])


# ==============================================================================
# Device Tokens
# ==============================================================================
@router.post(
    "/devices",
    response_model=DeviceTokenResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Register employee mobile/web FCM device token",
)
async def register_device(
    payload: DeviceTokenRegisterRequest,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> DeviceTokenResponse:
    repo = NotificationRepository(session)
    token = await repo.register_device_token(
        user_id=current_user.id,
        fcm_token=payload.fcm_token,
        device_id=payload.device_id,
        platform=payload.platform,
    )
    await session.commit()
    return DeviceTokenResponse.model_validate(token)


@router.delete(
    "/devices/{device_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Unregister device token on logout or device removal",
)
async def unregister_device(
    device_id: str,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> None:
    repo = NotificationRepository(session)
    await repo.delete_device_token(user_id=current_user.id, device_id=device_id)
    await session.commit()


# ==============================================================================
# In-App Notifications Inbox
# ==============================================================================
@router.get(
    "",
    response_model=Page[NotificationResponse],
    summary="List employee inbox notifications (paginated)",
)
async def list_notifications(
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=settings.DEFAULT_PAGE_SIZE, ge=1, le=settings.MAX_PAGE_SIZE),
    unread_only: bool = Query(default=False),
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> Page[NotificationResponse]:
    repo = NotificationRepository(session)
    items, total = await repo.list_notifications_paginated(
        user_id=current_user.id,
        page=page,
        page_size=page_size,
        unread_only=unread_only,
    )
    return Page.create(
        items=[NotificationResponse.model_validate(n) for n in items],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.get(
    "/unread-count",
    response_model=NotificationUnreadCountResponse,
    summary="Get employee unread notification count badge",
)
async def get_unread_count(
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> NotificationUnreadCountResponse:
    repo = NotificationRepository(session)
    count = await repo.get_unread_count(current_user.id)
    return NotificationUnreadCountResponse(unread_count=count)


@router.patch(
    "/{notification_id}/read",
    response_model=NotificationResponse,
    summary="Mark single notification as read",
)
async def mark_notification_read(
    notification_id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> NotificationResponse:
    repo = NotificationRepository(session)
    notif = await repo.mark_notification_as_read(notification_id, current_user.id)
    if not notif:
        raise NotFoundException("Notification not found.")
    await session.commit()
    return NotificationResponse.model_validate(notif)


@router.post(
    "/read-all",
    response_model=MessageResponse,
    summary="Mark all inbox notifications as read",
)
async def mark_all_read(
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_db_session),
) -> MessageResponse:
    repo = NotificationRepository(session)
    updated = await repo.mark_all_as_read(current_user.id)
    await session.commit()
    return MessageResponse(message=f"Marked {updated} notifications as read.")


# ==============================================================================
# Admin Template Management
# ==============================================================================
@router.get(
    "/templates",
    response_model=list[NotificationTemplateResponse],
    summary="List configurable notification templates (Admin/Settings)",
)
async def list_templates(
    current_user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> list[NotificationTemplateResponse]:
    repo = NotificationRepository(session)
    templates = await repo.list_templates()
    return [NotificationTemplateResponse.model_validate(t) for t in templates]


@router.patch(
    "/templates/{code}",
    response_model=NotificationTemplateResponse,
    summary="Edit title/body templates and channel flags (Admin/Settings)",
)
async def update_template(
    code: str,
    payload: NotificationTemplateUpdateRequest,
    current_user: User = Depends(require_permission("system.manage_settings")),
    session: AsyncSession = Depends(get_db_session),
) -> NotificationTemplateResponse:
    repo = NotificationRepository(session)
    tmpl = await repo.get_template_by_code(code)
    if not tmpl:
        raise NotFoundException(f"Template with code '{code}' not found.")

    if payload.title_template is not None:
        tmpl.title_template = payload.title_template
    if payload.body_template is not None:
        tmpl.body_template = payload.body_template
    if payload.channel_push is not None:
        tmpl.channel_push = payload.channel_push
    if payload.channel_email is not None:
        tmpl.channel_email = payload.channel_email
    if payload.channel_sms is not None:
        tmpl.channel_sms = payload.channel_sms
    if payload.is_active is not None:
        tmpl.is_active = payload.is_active

    await session.commit()
    return NotificationTemplateResponse.model_validate(tmpl)
