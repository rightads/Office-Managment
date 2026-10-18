from __future__ import annotations

import uuid
from collections.abc import Callable, Coroutine
from typing import Any

import jwt
from fastapi import Depends
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import ForbiddenException, UnauthorizedException
from app.core.security import decode_token
from app.dependencies.database import get_db
from app.models.user import User
from app.repositories.user_repository import UserRepository

# Reusable HTTP Bearer scheme
security_scheme = HTTPBearer(auto_error=False)


async def get_current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(security_scheme),
    db: AsyncSession = Depends(get_db),
) -> User:
    """
    Validates JWT Bearer access token and returns active User instance
    with loaded role and permissions.
    """
    if credentials is None:
        raise UnauthorizedException("Missing bearer authentication token.")

    token = credentials.credentials
    try:
        payload = decode_token(token)
        if payload.get("type") != "access":
            raise UnauthorizedException("Invalid token type. Access token required.")
        user_id_str: str = payload["sub"]
        user_id = uuid.UUID(user_id_str)
    except (jwt.PyJWTError, KeyError, ValueError) as err:
        raise UnauthorizedException(f"Invalid or expired authentication token: {err}") from err

    user_repo = UserRepository(db)
    user = await user_repo.get_by_id_with_permissions(user_id)

    if not user or not user.is_active or user.is_deleted:
        raise UnauthorizedException("User account is inactive or has been deleted.")

    return user


def require_active_user(
    current_user: User = Depends(get_current_user),
) -> User:
    """Guards endpoints ensuring must_change_password is not blocking access."""
    if current_user.must_change_password:
        raise ForbiddenException(
            "Password change required before accessing system resources.",
            details=[
                {
                    "loc": ["password"],
                    "msg": "must_change_password flag is set",
                    "type": "password_change_required",
                }
            ],
        )
    return current_user


def require_permissions(*required_permissions: str) -> Callable[..., Coroutine[Any, Any, User]]:
    """
    Dependency factory verifying that current user holds ALL specified permissions.
    Admin role gets all permissions strictly via database mappings, never code branches.
    """

    async def permission_checker(
        current_user: User = Depends(require_active_user),
        db: AsyncSession = Depends(get_db),
    ) -> User:
        user_repo = UserRepository(db)
        granted_permissions = await user_repo.get_user_permissions(current_user)

        missing = [p for p in required_permissions if p not in granted_permissions]
        if missing:
            raise ForbiddenException(
                "Access forbidden. Missing required permissions.",
                details=[
                    {
                        "loc": ["permissions"],
                        "msg": f"Missing permission: {p}",
                        "type": "insufficient_permission",
                    }
                    for p in missing
                ],
            )
        return current_user

    return permission_checker


def require_any_permissions(*required_permissions: str) -> Callable[..., Coroutine[Any, Any, User]]:
    """
    Dependency factory verifying that current user holds AT LEAST ONE of the specified permissions.
    """

    async def any_permission_checker(
        current_user: User = Depends(require_active_user),
        db: AsyncSession = Depends(get_db),
    ) -> User:
        user_repo = UserRepository(db)
        granted_permissions = await user_repo.get_user_permissions(current_user)

        has_any = any(p in granted_permissions for p in required_permissions)
        if not has_any:
            raise ForbiddenException(
                "Access forbidden. None of the authorized permissions are granted.",
                details=[
                    {
                        "loc": ["permissions"],
                        "msg": f"Requires at least one of: {required_permissions}",
                        "type": "insufficient_permission",
                    }
                ],
            )
        return current_user

    return any_permission_checker


# Convenient aliases for singular permission checks and active user retrieval
require_permission = require_permissions
get_current_active_user = require_active_user
