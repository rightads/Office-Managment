from __future__ import annotations

import datetime
from typing import Any

import bcrypt
import jwt

from app.core.config import settings


def hash_password(password: str) -> str:
    """Hash plain text password using bcrypt with standard 72-byte truncation."""
    # Bcrypt supports maximum 72 bytes password length
    pw_bytes = password.encode("utf-8")[:72]
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(pw_bytes, salt).decode("utf-8")


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify plain password against hashed password."""
    try:
        pw_bytes = plain_password.encode("utf-8")[:72]
        hash_bytes = hashed_password.encode("utf-8")
        return bool(bcrypt.checkpw(pw_bytes, hash_bytes))
    except Exception:
        return False


def create_access_token(
    subject: str | int,
    expires_delta: datetime.timedelta | None = None,
    extra_claims: dict[str, Any] | None = None,
) -> str:
    """Generates a signed JWT access token."""
    now = datetime.datetime.now(datetime.timezone.utc)
    if expires_delta:
        expire = now + expires_delta
    else:
        expire = now + datetime.timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)

    to_encode: dict[str, Any] = {
        "sub": str(subject),
        "iat": now,
        "exp": expire,
        "type": "access",
    }
    if extra_claims:
        to_encode.update(extra_claims)

    return jwt.encode(
        to_encode,
        settings.JWT_SECRET_KEY,
        algorithm=settings.JWT_ALGORITHM,
    )


def create_refresh_token(
    subject: str | int,
    expires_delta: datetime.timedelta | None = None,
) -> str:
    """Generates a signed JWT refresh token."""
    now = datetime.datetime.now(datetime.timezone.utc)
    if expires_delta:
        expire = now + expires_delta
    else:
        expire = now + datetime.timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)

    to_encode: dict[str, Any] = {
        "sub": str(subject),
        "iat": now,
        "exp": expire,
        "type": "refresh",
    }

    return jwt.encode(
        to_encode,
        settings.JWT_SECRET_KEY,
        algorithm=settings.JWT_ALGORITHM,
    )


def decode_token(token: str) -> dict[str, Any]:
    """Decodes and validates a signed JWT token."""
    return jwt.decode(
        token,
        settings.JWT_SECRET_KEY,
        algorithms=[settings.JWT_ALGORITHM],
    )
