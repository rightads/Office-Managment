from __future__ import annotations

import datetime
import uuid

from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.base import utc_now
from app.models.system import RefreshToken
from app.repositories.base import BaseRepository


class RefreshTokenRepository(BaseRepository[RefreshToken]):
    """Data access repository for session refresh tokens."""

    def __init__(self, session: AsyncSession) -> None:
        super().__init__(RefreshToken, session)

    async def get_by_hash(self, token_hash: str) -> RefreshToken | None:
        """Find a refresh token by its SHA-256 hash."""
        stmt = select(RefreshToken).where(RefreshToken.token_hash == token_hash)
        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()

    async def create_token(
        self,
        user_id: uuid.UUID,
        token_hash: str,
        expires_at: datetime.datetime,
        device_id: str | None = None,
    ) -> RefreshToken:
        """Save a new active refresh token session."""
        token_record = RefreshToken(
            user_id=user_id,
            token_hash=token_hash,
            device_id=device_id,
            expires_at=expires_at,
        )
        self.session.add(token_record)
        await self.session.flush()
        return token_record

    async def revoke_token(self, token: RefreshToken) -> None:
        """Revoke a single refresh token."""
        token.revoked_at = utc_now()
        await self.session.flush()

    async def revoke_all_for_user(self, user_id: uuid.UUID) -> None:
        """Revoke all active refresh tokens for user (reuse detection / logout-all)."""
        stmt = (
            update(RefreshToken)
            .where(RefreshToken.user_id == user_id, RefreshToken.revoked_at.is_(None))
            .values(revoked_at=utc_now())
        )
        await self.session.execute(stmt)
        await self.session.flush()
