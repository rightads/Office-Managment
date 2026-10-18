from __future__ import annotations

import datetime
import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.config import settings
from app.models.base import utc_now
from app.models.rbac import Role
from app.models.user import User
from app.repositories.base import BaseRepository


class UserRepository(BaseRepository[User]):
    """Data access repository for User entities."""

    def __init__(self, session: AsyncSession) -> None:
        super().__init__(User, session)

    async def get_by_email(self, email: str, include_deleted: bool = False) -> User | None:
        """Find an active user by email address."""
        stmt = (
            select(User)
            .where(User.email == email.strip().lower())
            .options(selectinload(User.role).selectinload(Role.permissions))
        )
        if not include_deleted:
            stmt = stmt.where(User.is_deleted.is_(False))

        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()

    async def get_by_id_with_permissions(self, user_id: uuid.UUID) -> User | None:
        """Fetch user by primary key with eagerly loaded role and permissions."""
        stmt = (
            select(User)
            .where(User.id == user_id, User.is_deleted.is_(False))
            .options(selectinload(User.role).selectinload(Role.permissions))
        )
        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()

    async def record_login_failure(self, user: User) -> None:
        """Increments failed login attempts and triggers lockout if threshold is exceeded."""
        user.failed_login_attempts += 1
        if user.failed_login_attempts >= settings.MAX_LOGIN_ATTEMPTS:
            user.locked_until = utc_now() + datetime.timedelta(minutes=settings.LOCKOUT_MINUTES)
        await self.session.flush()

    async def reset_login_failure(self, user: User) -> None:
        """Resets failed login count and updates last login timestamp."""
        user.failed_login_attempts = 0
        user.locked_until = None
        user.last_login_at = utc_now()
        await self.session.flush()

    async def update_password(self, user: User, password_hash: str) -> None:
        """Updates user password and clears forced password change flag."""
        user.password_hash = password_hash
        user.must_change_password = False
        await self.session.flush()

    async def get_user_permissions(self, user: User) -> set[str]:
        """Resolves dynamic permission codes granted to the user through their assigned role."""
        role = user.__dict__.get("role")
        if not role:
            stmt = (
                select(Role).where(Role.id == user.role_id).options(selectinload(Role.permissions))
            )
            res = await self.session.execute(stmt)
            role = res.scalar_one_or_none()
            if not role:
                return set()
            return {p.code for p in role.permissions}
        if "permissions" not in role.__dict__:
            stmt = select(Role).where(Role.id == role.id).options(selectinload(Role.permissions))
            res = await self.session.execute(stmt)
            loaded_role = res.scalar_one_or_none()
            return {p.code for p in loaded_role.permissions} if loaded_role else set()
        return {p.code for p in role.permissions}
