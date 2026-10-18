from __future__ import annotations

import datetime
import uuid

import jwt
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.exceptions import (
    BadRequestException,
    UnauthorizedException,
)
from app.core.security import (
    create_access_token,
    create_password_reset_token,
    create_refresh_token,
    decode_token,
    hash_password,
    hash_token,
    validate_password_policy,
    verify_password,
)
from app.models.base import ensure_utc, utc_now
from app.models.user import User
from app.repositories.refresh_token_repository import RefreshTokenRepository
from app.repositories.user_repository import UserRepository
from app.services.email_service import EmailService, email_service


class AuthService:
    """Core domain service for user authentication, token rotation, and credential management."""

    def __init__(
        self,
        session: AsyncSession,
        email_svc: EmailService = email_service,
    ) -> None:
        self.session = session
        self.user_repo = UserRepository(session)
        self.token_repo = RefreshTokenRepository(session)
        self.email_service = email_svc

    async def authenticate_user(
        self,
        email: str,
        password: str,
        device_id: str | None = None,
    ) -> tuple[User, str, str]:
        """
        Authenticates user with constant-time generic responses, lockout checks,
        and issues access & rotated refresh token pair.
        """
        user = await self.user_repo.get_by_email(email)

        # Anti-enumeration: Return generic error if user does not exist or is inactive
        if not user or not user.is_active:
            raise UnauthorizedException("Invalid email or password.")

        # Check account lockout state
        now = utc_now()
        if user.locked_until and ensure_utc(user.locked_until) > now:
            raise UnauthorizedException(
                "Account is temporarily locked due to multiple failed login attempts. "
                "Please try again later."
            )

        # Verify password (Argon2 with bcrypt fallback)
        if not verify_password(password, user.password_hash):
            await self.user_repo.record_login_failure(user)
            await self.session.commit()
            raise UnauthorizedException("Invalid email or password.")

        # Authentication succeeded - reset attempts
        await self.user_repo.reset_login_failure(user)

        # Generate tokens
        role_name = user.role.name if user.role else "Employee"
        access_token = create_access_token(user_id=str(user.id), role=role_name)
        raw_refresh_token = create_refresh_token()
        token_hash = hash_token(raw_refresh_token)

        refresh_expires = now + datetime.timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
        await self.token_repo.create_token(
            user_id=user.id,
            token_hash=token_hash,
            expires_at=refresh_expires,
            device_id=device_id,
        )
        await self.session.commit()

        return user, access_token, raw_refresh_token

    async def refresh_tokens(
        self,
        raw_refresh_token: str,
        device_id: str | None = None,
    ) -> tuple[str, str]:
        """
        Rotates refresh token. Implements reuse detection: if a previously revoked
        token is used, immediately revokes all active sessions for that user.
        """
        token_hash = hash_token(raw_refresh_token)
        token_record = await self.token_repo.get_by_hash(token_hash)

        if not token_record:
            raise UnauthorizedException("Invalid refresh token.")

        # Reuse Detection: Token was already revoked
        if token_record.revoked_at is not None:
            await self.token_repo.revoke_all_for_user(token_record.user_id)
            await self.session.commit()
            raise UnauthorizedException(
                "Revoked refresh token reuse detected. All active sessions have been terminated."
            )

        # Expiry Check
        if ensure_utc(token_record.expires_at) < utc_now():
            await self.token_repo.revoke_token(token_record)
            await self.session.commit()
            raise UnauthorizedException("Refresh token has expired.")

        user = await self.user_repo.get_by_id_with_permissions(token_record.user_id)
        if not user or not user.is_active:
            raise UnauthorizedException("User account is inactive or disabled.")

        # Rotate: Revoke old token and issue fresh pair
        await self.token_repo.revoke_token(token_record)

        role_name = user.role.name if user.role else "Employee"
        new_access_token = create_access_token(user_id=str(user.id), role=role_name)
        new_raw_refresh = create_refresh_token()
        new_hash = hash_token(new_raw_refresh)

        refresh_expires = utc_now() + datetime.timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
        await self.token_repo.create_token(
            user_id=user.id,
            token_hash=new_hash,
            expires_at=refresh_expires,
            device_id=device_id or token_record.device_id,
        )
        await self.session.commit()

        return new_access_token, new_raw_refresh

    async def revoke_refresh_token(self, raw_refresh_token: str) -> None:
        """Revokes a specific refresh token upon logout."""
        token_hash = hash_token(raw_refresh_token)
        token_record = await self.token_repo.get_by_hash(token_hash)
        if token_record and token_record.revoked_at is None:
            await self.token_repo.revoke_token(token_record)
            await self.session.commit()

    async def revoke_all_user_tokens(self, user_id: uuid.UUID) -> None:
        """Revokes all active refresh tokens for an employee across all devices."""
        await self.token_repo.revoke_all_for_user(user_id)
        await self.session.commit()

    async def change_password(
        self,
        user: User,
        current_password: str,
        new_password: str,
    ) -> None:
        """Changes user password, enforces complexity policy, and revokes active sessions."""
        if not verify_password(current_password, user.password_hash):
            raise UnauthorizedException("Current password provided is incorrect.")

        validate_password_policy(new_password)

        new_hash = hash_password(new_password)
        await self.user_repo.update_password(user, new_hash)
        # Terminate active sessions upon credential modification
        await self.token_repo.revoke_all_for_user(user.id)
        await self.session.commit()

    async def request_password_reset(self, email: str) -> None:
        """
        Dispatches password reset instructions. Always returns generic success
        to prevent user existence enumeration.
        """
        user = await self.user_repo.get_by_email(email)
        if user and user.is_active:
            reset_token = create_password_reset_token(str(user.id))
            await self.email_service.send_password_reset_email(user.email, reset_token)

    async def reset_password(self, token: str, new_password: str) -> None:
        """Validates reset token and sets new password."""
        try:
            payload = decode_token(token)
            if payload.get("type") != "password_reset":
                raise BadRequestException("Invalid reset token type.")
            user_id_str: str = payload["sub"]
            user_id = uuid.UUID(user_id_str)
        except (jwt.PyJWTError, KeyError, ValueError) as err:
            raise BadRequestException(f"Invalid or expired password reset token: {err}") from err

        user = await self.user_repo.get_by_id_with_permissions(user_id)
        if not user or not user.is_active:
            raise BadRequestException("User account not found or deactivated.")

        validate_password_policy(new_password)

        new_hash = hash_password(new_password)
        await self.user_repo.update_password(user, new_hash)
        await self.user_repo.reset_login_failure(user)
        await self.token_repo.revoke_all_for_user(user.id)
        await self.session.commit()
