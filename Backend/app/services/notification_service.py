from __future__ import annotations

import asyncio
import logging
import uuid
from typing import TYPE_CHECKING, Any

from app.core.config import settings
from app.core.database import async_session_factory
from app.models.communication import Notification
from app.repositories.notification_repository import NotificationRepository
from app.services.notification_channels import (
    BaseNotificationChannel,
    EmailNotificationChannel,
    FCMNotificationChannel,
)

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession

logger = logging.getLogger(__name__)


class NotificationService:
    """
    Central transactional notification service.
    - Manages in-app inbox records.
    - Resolves DB templates dynamically (Zero Hardcoding).
    - Dispatches to push (FCM) and email channels in non-blocking background tasks.
    - Automatically purges invalid/unregistered device tokens upon failed push delivery.
    """

    _fcm_channel: BaseNotificationChannel = FCMNotificationChannel()
    _email_channel: BaseNotificationChannel = EmailNotificationChannel()
    session_factory: Any = async_session_factory

    @classmethod
    async def send(
        cls,
        session: AsyncSession,
        user_id: uuid.UUID,
        title: str,
        body: str,
        notification_type: str,
        data: dict[str, Any] | None = None,
        template_params: dict[str, Any] | None = None,
    ) -> Notification:
        """
        Record an in-app notification in the user's inbox and trigger push/email background tasks.
        Uses database templates if available, substituting provided template_params.
        """
        repo = NotificationRepository(session)

        final_title = title
        final_body = body

        # Attempt to load template from DB
        template = await repo.get_template_by_code(notification_type)
        if template:
            params = template_params or {}
            try:
                final_title = template.title_template.format(**params)
            except Exception:
                final_title = template.title_template

            try:
                final_body = template.body_template.format(**params)
            except Exception:
                final_body = template.body_template

        notification = Notification(
            user_id=user_id,
            title=final_title,
            body=final_body,
            type=notification_type,
            data=data or {},
            is_read=False,
        )
        session.add(notification)
        await session.flush()

        # Trigger background delivery for push & email (non-blocking)
        asyncio.create_task(
            cls._dispatch_background(
                user_id=user_id,
                title=final_title,
                body=final_body,
                data=data or {},
                channel_push=template.channel_push if template else True,
                channel_email=template.channel_email if template else False,
            )
        )

        return notification

    @classmethod
    async def send_to_multiple(
        cls,
        session: AsyncSession,
        user_ids: list[uuid.UUID],
        title: str,
        body: str,
        notification_type: str,
        data: dict[str, Any] | None = None,
        template_params: dict[str, Any] | None = None,
    ) -> list[Notification]:
        """Broadcast in-app notifications and trigger background push dispatches."""
        notifications: list[Notification] = []
        for uid in user_ids:
            notif = await cls.send(
                session=session,
                user_id=uid,
                title=title,
                body=body,
                notification_type=notification_type,
                data=data,
                template_params=template_params,
            )
            notifications.append(notif)
        return notifications

    @classmethod
    async def _dispatch_background(
        cls,
        user_id: uuid.UUID,
        title: str,
        body: str,
        data: dict[str, Any],
        channel_push: bool = True,
        channel_email: bool = False,
    ) -> None:
        """Isolated background worker sending push/email and pruning invalid tokens."""
        if not settings.ENABLE_PUSH_NOTIFICATIONS and not settings.ENABLE_EMAIL_NOTIFICATIONS:
            return

        try:
            async with cls.session_factory() as bg_session:
                repo = NotificationRepository(bg_session)

                # Push Channel
                if channel_push and settings.ENABLE_PUSH_NOTIFICATIONS:
                    tokens = await repo.get_device_tokens_for_user(user_id)
                    token_strings = [t.fcm_token for t in tokens if t.fcm_token]
                    if token_strings:
                        invalid_tokens = await cls._fcm_channel.send(
                            recipient_tokens=token_strings,
                            title=title,
                            body=body,
                            data=data,
                        )
                        if invalid_tokens:
                            deleted = await repo.delete_invalid_fcm_tokens(invalid_tokens)
                            await bg_session.commit()
                            logger.info(
                                "Purged %d invalid FCM tokens for user %s.",
                                deleted,
                                user_id,
                            )

                # Email Channel
                if channel_email and settings.ENABLE_EMAIL_NOTIFICATIONS:
                    # In a full system, looks up user email and dispatches
                    await cls._email_channel.send(
                        recipient_tokens=[str(user_id)],
                        title=title,
                        body=body,
                        data=data,
                    )
        except Exception as e:
            logger.error(
                "Error during background notification dispatch for user %s: %s", user_id, e
            )
