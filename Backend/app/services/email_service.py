from __future__ import annotations

import logging
from typing import Protocol

logger = logging.getLogger(__name__)


class EmailService(Protocol):
    """Abstract interface for dispatching transactional emails."""

    async def send_password_reset_email(self, to_email: str, reset_token: str) -> None:
        """Send password reset instructions containing a secure reset token."""
        ...


class ConsoleEmailService:
    """Development and testing implementation printing email actions to structured logger."""

    async def send_password_reset_email(self, to_email: str, reset_token: str) -> None:
        logger.info(
            "Dispatching password reset email",
            extra={
                "to_email": to_email,
                "reset_token": reset_token,
                "action": "password_reset_dispatch",
            },
        )


# Global default email service instance
email_service: EmailService = ConsoleEmailService()
