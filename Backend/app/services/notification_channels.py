from __future__ import annotations

import abc
import logging
import os
from typing import Any

from app.core.config import settings

logger = logging.getLogger(__name__)


class BaseNotificationChannel(abc.ABC):
    """Abstract interface for a notification delivery channel."""

    @abc.abstractmethod
    async def send(
        self,
        recipient_tokens: list[str],
        title: str,
        body: str,
        data: dict[str, Any] | None = None,
    ) -> list[str]:
        """
        Send notification payload to the specified tokens/destinations.
        Returns:
            list[str]: list of stale/invalid tokens to be unregistered.
        """
        pass


class FCMNotificationChannel(BaseNotificationChannel):
    """
    Firebase Cloud Messaging push notification channel using firebase-admin.
    Safely reads credentials from FCM_CREDENTIALS_PATH and detects/cleans invalid tokens.
    """

    def __init__(self) -> None:
        self._app: Any = None
        self._initialized: bool = False

    def _ensure_firebase_initialized(self) -> bool:
        if self._initialized:
            return True

        if not settings.FCM_CREDENTIALS_PATH:
            logger.debug("FCM_CREDENTIALS_PATH not set; FCM channel inactive.")
            return False

        if not os.path.exists(settings.FCM_CREDENTIALS_PATH):
            logger.warning("FCM credentials file not found at '%s'.", settings.FCM_CREDENTIALS_PATH)
            return False

        try:
            import firebase_admin  # type: ignore[import-not-found]
            from firebase_admin import credentials

            if not firebase_admin._apps:
                cred = credentials.Certificate(settings.FCM_CREDENTIALS_PATH)
                self._app = firebase_admin.initialize_app(cred)
            else:
                self._app = firebase_admin.get_app()

            self._initialized = True
            return True
        except Exception as e:
            logger.error("Failed to initialize Firebase Admin SDK: %s", e)
            return False

    async def send(
        self,
        recipient_tokens: list[str],
        title: str,
        body: str,
        data: dict[str, Any] | None = None,
    ) -> list[str]:
        """
        Send FCM multicast message to recipient tokens.
        Identifies and returns invalid/unregistered tokens for automatic deletion.
        """
        if not recipient_tokens or not settings.ENABLE_PUSH_NOTIFICATIONS:
            return []

        try:
            import firebase_admin
            from firebase_admin import messaging
        except ImportError:
            logger.warning("firebase-admin library not installed. FCM messages skipped.")
            return []

        # If running in environment without initialized app, attempt initialization
        if not firebase_admin._apps:
            if not self._ensure_firebase_initialized():
                return []

        # Prepare stringified data dictionary for FCM
        fcm_data = {k: str(v) for k, v in (data or {}).items()}

        message = messaging.MulticastMessage(
            notification=messaging.Notification(
                title=title,
                body=body,
            ),
            data=fcm_data,
            tokens=recipient_tokens,
        )

        invalid_tokens: list[str] = []
        try:
            response = messaging.send_multicast(message)
            logger.info(
                "FCM multicast dispatch: %d successful, %d failed out of %d tokens.",
                response.success_count,
                response.failure_count,
                len(recipient_tokens),
            )

            # Inspect errors to find stale/unregistered tokens
            for idx, resp in enumerate(response.responses):
                if not resp.success:
                    err = resp.exception
                    # Unregistered or InvalidArgument indicates token must be purged
                    err_code = getattr(err, "code", str(err))
                    unregistered_types = tuple(
                        t
                        for t in (
                            getattr(messaging, "UnregisteredError", None),
                            getattr(messaging, "SenderIdMismatchError", None),
                        )
                        if isinstance(t, type)
                    )
                    if (
                        (unregistered_types and isinstance(err, unregistered_types))
                        or err.__class__.__name__ in ("UnregisteredError", "SenderIdMismatchError")
                        or "registration-token-not-registered" in str(err).lower()
                        or "invalid-argument" in str(err_code).lower()
                    ):
                        invalid_tokens.append(recipient_tokens[idx])

        except Exception as e:
            logger.error("Exception during FCM multicast sending: %s", e)

        return invalid_tokens


class EmailNotificationChannel(BaseNotificationChannel):
    """Email delivery channel wrapper."""

    async def send(
        self,
        recipient_tokens: list[str],
        title: str,
        body: str,
        data: dict[str, Any] | None = None,
    ) -> list[str]:
        if not settings.ENABLE_EMAIL_NOTIFICATIONS:
            return []
        logger.info(
            "Simulated email notification to %d recipients: %s", len(recipient_tokens), title
        )
        return []
