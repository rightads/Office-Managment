from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING

from sqlalchemy import desc, func, or_, select, update
from sqlalchemy.orm import selectinload

from app.models.base import utc_now
from app.models.communication import (
    Announcement,
    DeviceToken,
    Notification,
    NotificationTemplate,
)
from app.models.user import User

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession


class NotificationRepository:
    """Data persistence and query layer for notifications, device tokens, announcements, and templates."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    # ==============================================================================
    # Device Tokens
    # ==============================================================================
    async def get_device_tokens_for_user(self, user_id: uuid.UUID) -> list[DeviceToken]:
        stmt = select(DeviceToken).where(DeviceToken.user_id == user_id)
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_device_tokens_for_users(self, user_ids: list[uuid.UUID]) -> list[DeviceToken]:
        if not user_ids:
            return []
        stmt = select(DeviceToken).where(DeviceToken.user_id.in_(user_ids))
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def register_device_token(
        self,
        user_id: uuid.UUID,
        fcm_token: str,
        device_id: str,
        platform: str,
    ) -> DeviceToken:
        stmt = select(DeviceToken).where(
            DeviceToken.user_id == user_id,
            DeviceToken.device_id == device_id,
            DeviceToken.platform == platform,
        )
        res = await self.session.execute(stmt)
        existing = res.scalar_one_or_none()

        if existing:
            existing.fcm_token = fcm_token
            return existing

        token = DeviceToken(
            user_id=user_id,
            fcm_token=fcm_token,
            device_id=device_id,
            platform=platform,
        )
        self.session.add(token)
        await self.session.flush()
        return token

    async def delete_device_token(self, user_id: uuid.UUID, device_id: str) -> bool:
        stmt = select(DeviceToken).where(
            DeviceToken.user_id == user_id,
            DeviceToken.device_id == device_id,
        )
        res = await self.session.execute(stmt)
        token = res.scalar_one_or_none()
        if token:
            await self.session.delete(token)
            return True
        return False

    async def delete_invalid_fcm_tokens(self, invalid_tokens: list[str]) -> int:
        if not invalid_tokens:
            return 0
        stmt = select(DeviceToken).where(DeviceToken.fcm_token.in_(invalid_tokens))
        res = await self.session.execute(stmt)
        tokens = list(res.scalars().all())
        for t in tokens:
            await self.session.delete(t)
        return len(tokens)

    # ==============================================================================
    # In-App Notifications
    # ==============================================================================
    async def list_notifications_paginated(
        self,
        user_id: uuid.UUID,
        page: int = 1,
        page_size: int = 20,
        unread_only: bool = False,
    ) -> tuple[list[Notification], int]:
        base_query = select(Notification).where(Notification.user_id == user_id)
        if unread_only:
            base_query = base_query.where(Notification.is_read.is_(False))

        count_stmt = select(func.count()).select_from(base_query.subquery())
        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar_one() or 0

        offset = (page - 1) * page_size
        stmt = base_query.order_by(desc(Notification.created_at)).offset(offset).limit(page_size)
        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    async def get_unread_count(self, user_id: uuid.UUID) -> int:
        stmt = (
            select(func.count())
            .select_from(Notification)
            .where(Notification.user_id == user_id, Notification.is_read.is_(False))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one() or 0

    async def mark_notification_as_read(
        self, notification_id: uuid.UUID, user_id: uuid.UUID
    ) -> Notification | None:
        stmt = select(Notification).where(
            Notification.id == notification_id,
            Notification.user_id == user_id,
        )
        res = await self.session.execute(stmt)
        notif = res.scalar_one_or_none()
        if notif:
            notif.is_read = True
        return notif

    async def mark_all_as_read(self, user_id: uuid.UUID) -> int:
        stmt = (
            update(Notification)
            .where(Notification.user_id == user_id, Notification.is_read.is_(False))
            .values(is_read=True)
        )
        res = await self.session.execute(stmt)
        return int(getattr(res, "rowcount", 0) or 0)

    # ==============================================================================
    # Templates
    # ==============================================================================
    async def get_template_by_code(self, code: str) -> NotificationTemplate | None:
        stmt = select(NotificationTemplate).where(
            NotificationTemplate.code == code, NotificationTemplate.is_active.is_(True)
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_templates(self) -> list[NotificationTemplate]:
        stmt = select(NotificationTemplate).order_by(NotificationTemplate.code.asc())
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    # ==============================================================================
    # Announcements
    # ==============================================================================
    async def create_announcement(
        self,
        title: str,
        body: str,
        creator_id: uuid.UUID,
        target_department_id: uuid.UUID | None = None,
        expires_at: datetime.datetime | None = None,
    ) -> Announcement:
        ann = Announcement(
            title=title.strip(),
            body=body.strip(),
            created_by=creator_id,
            target_department_id=target_department_id,
            expires_at=expires_at,
            is_active=True,
        )
        self.session.add(ann)
        await self.session.flush()
        return ann

    async def get_announcement_by_id(self, announcement_id: uuid.UUID) -> Announcement | None:
        stmt = (
            select(Announcement)
            .where(Announcement.id == announcement_id, Announcement.is_active.is_(True))
            .options(
                selectinload(Announcement.target_department),
                selectinload(Announcement.creator),
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_active_announcements(
        self, user_department_id: uuid.UUID | None = None
    ) -> list[Announcement]:
        now = utc_now()
        base_query = select(Announcement).where(
            Announcement.is_active.is_(True),
            or_(Announcement.expires_at.is_(None), Announcement.expires_at > now),
        )

        if user_department_id:
            base_query = base_query.where(
                or_(
                    Announcement.target_department_id.is_(None),
                    Announcement.target_department_id == user_department_id,
                )
            )
        else:
            base_query = base_query.where(Announcement.target_department_id.is_(None))

        stmt = base_query.order_by(desc(Announcement.created_at)).options(
            selectinload(Announcement.target_department),
            selectinload(Announcement.creator),
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_active_users_for_announcement(
        self, target_department_id: uuid.UUID | None = None
    ) -> list[User]:
        stmt = select(User).where(User.is_active.is_(True), User.is_deleted.is_(False))
        if target_department_id:
            stmt = stmt.where(User.department_id == target_department_id)
        res = await self.session.execute(stmt)
        return list(res.scalars().all())
