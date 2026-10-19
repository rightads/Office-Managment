from __future__ import annotations

import uuid

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db_session
from app.core.exceptions import NotFoundException
from app.dependencies.auth import require_permission
from app.models.communication import Announcement
from app.models.user import User
from app.repositories.notification_repository import NotificationRepository
from app.schemas.common import UserBriefResponse
from app.schemas.communication import (
    AnnouncementCreateRequest,
    AnnouncementResponse,
)
from app.services.notification_service import NotificationService

router = APIRouter(prefix="/announcements", tags=["Announcements"])


def _to_announcement_response(a: Announcement) -> AnnouncementResponse:
    return AnnouncementResponse(
        id=a.id,
        title=a.title,
        body=a.body,
        target_department_id=a.target_department_id,
        target_department_name=a.target_department.name if a.target_department else None,
        creator=UserBriefResponse.model_validate(a.creator),
        expires_at=a.expires_at,
        is_active=a.is_active,
        created_at=a.created_at,
    )


@router.post(
    "",
    response_model=AnnouncementResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Publish company or department announcement and trigger push notification",
)
async def create_announcement(
    payload: AnnouncementCreateRequest,
    current_user: User = Depends(require_permission("announcement.create")),
    session: AsyncSession = Depends(get_db_session),
) -> AnnouncementResponse:
    repo = NotificationRepository(session)
    ann = await repo.create_announcement(
        title=payload.title,
        body=payload.body,
        creator_id=current_user.id,
        target_department_id=payload.target_department_id,
        expires_at=payload.expires_at,
    )
    await session.commit()

    # Re-fetch with loaded relations
    reloaded = await repo.get_announcement_by_id(ann.id)
    if not reloaded:
        raise NotFoundException("Failed to reload announcement.")

    # Target users for notifications
    target_users = await repo.get_active_users_for_announcement(payload.target_department_id)
    recipient_ids = [u.id for u in target_users if u.id != current_user.id]

    if recipient_ids:
        # Snippet for notification body
        snippet = (payload.body[:150] + "...") if len(payload.body) > 150 else payload.body
        await NotificationService.send_to_multiple(
            session=session,
            user_ids=recipient_ids,
            title=f"Announcement: {payload.title}",
            body=snippet,
            notification_type="ANNOUNCEMENT_NEW",
            data={"announcement_id": str(ann.id)},
            template_params={
                "announcement_title": payload.title,
                "announcement_body": snippet,
            },
        )
        await session.commit()

    return _to_announcement_response(reloaded)


@router.get(
    "",
    response_model=list[AnnouncementResponse],
    summary="List active unexpired announcements visible to current employee",
)
async def list_announcements(
    current_user: User = Depends(require_permission("announcement.view")),
    session: AsyncSession = Depends(get_db_session),
) -> list[AnnouncementResponse]:
    repo = NotificationRepository(session)
    announcements = await repo.list_active_announcements(
        user_department_id=current_user.department_id
    )
    return [_to_announcement_response(a) for a in announcements]


@router.get(
    "/{announcement_id}",
    response_model=AnnouncementResponse,
    summary="Get announcement details by ID",
)
async def get_announcement(
    announcement_id: uuid.UUID,
    current_user: User = Depends(require_permission("announcement.view")),
    session: AsyncSession = Depends(get_db_session),
) -> AnnouncementResponse:
    repo = NotificationRepository(session)
    ann = await repo.get_announcement_by_id(announcement_id)
    if not ann:
        raise NotFoundException("Announcement not found.")
    if ann.target_department_id and ann.target_department_id != current_user.department_id:
        raise NotFoundException("Announcement not found.")
    return _to_announcement_response(ann)
