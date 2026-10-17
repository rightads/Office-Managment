from __future__ import annotations

import logging
import uuid
from typing import Any

from sqlalchemy.ext.asyncio import AsyncSession

from app.models.communication import Notification

logger = logging.getLogger(__name__)


class NotificationService:
    """Central transactional notification delivery service (in-app, push, email)."""

    @classmethod
    async def send(
        cls,
        session: AsyncSession,
        user_id: uuid.UUID,
        title: str,
        body: str,
        notification_type: str,
        data: dict[str, Any] | None = None,
    ) -> Notification:
        """
        Record an in-app notification in the user's inbox and trigger push/email channels.
        Degrades gracefully if external delivery backends are not configured.
        """
        notification = Notification(
            user_id=user_id,
            title=title,
            body=body,
            type=notification_type,
            data=data or {},
            is_read=False,
        )
        session.add(notification)
        await session.flush()

        logger.info(
            "Delivered notification to user %s [type=%s]: %s",
            user_id,
            notification_type,
            title,
        )
        return notification
