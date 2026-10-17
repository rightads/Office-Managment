from __future__ import annotations

import logging
from typing import Protocol

logger = logging.getLogger(__name__)


class EmailService(Protocol):
    """Abstract interface for dispatching transactional emails."""

    async def send_password_reset_email(self, to_email: str, reset_token: str) -> None:
        """Send password reset instructions containing a secure reset token."""
        ...

    async def send_welcome_credentials(
        self,
        to_email: str,
        full_name: str,
        employee_code: str,
        temporary_password: str,
    ) -> None:
        """Send welcome email with generated employee credentials."""
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

    async def send_welcome_credentials(
        self,
        to_email: str,
        full_name: str,
        employee_code: str,
        temporary_password: str,
    ) -> None:
        logger.info(
            "Dispatching employee welcome email with credentials",
            extra={
                "to_email": to_email,
                "full_name": full_name,
                "employee_code": employee_code,
                "action": "employee_welcome_dispatch",
            },
        )


# Global default email service instance
email_service: EmailService = ConsoleEmailService()
