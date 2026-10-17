from __future__ import annotations

import datetime
import hashlib
import re
import secrets
from typing import Any

import argon2
import bcrypt
import jwt
from argon2.exceptions import VerifyMismatchError

from app.core.config import settings
from app.core.exceptions import ValidationException

# Argon2 Password Hasher
ph = argon2.PasswordHasher(
    time_cost=2,
    memory_cost=65536,
    parallelism=1,
    hash_len=32,
    type=argon2.Type.ID,
)


def hash_password(password: str) -> str:
    """Hash password using Argon2id."""
    return ph.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify password supporting Argon2id with bcrypt backward compatibility."""
    if not hashed_password or not plain_password:
        return False
    try:
        if hashed_password.startswith("$argon2"):
            return ph.verify(hashed_password, plain_password)
        elif hashed_password.startswith(("$2a$", "$2b$", "$2y$")):
            pw_bytes = plain_password.encode("utf-8")[:72]
            hash_bytes = hashed_password.encode("utf-8")
            return bool(bcrypt.checkpw(pw_bytes, hash_bytes))
        return False
    except (VerifyMismatchError, Exception):
        return False


def validate_password_policy(password: str) -> None:
    """Validates that a password satisfies policy requirements defined in settings."""
    errors: list[str] = []

    if len(password) < settings.PASSWORD_MIN_LENGTH:
        errors.append(f"Password must be at least {settings.PASSWORD_MIN_LENGTH} characters long.")

    if settings.PASSWORD_REQUIRE_UPPERCASE and not re.search(r"[A-Z]", password):
        errors.append("Password must contain at least one uppercase letter.")

    if settings.PASSWORD_REQUIRE_LOWERCASE and not re.search(r"[a-z]", password):
        errors.append("Password must contain at least one lowercase letter.")

    if settings.PASSWORD_REQUIRE_DIGIT and not re.search(r"\d", password):
        errors.append("Password must contain at least one numeric digit.")

    if settings.PASSWORD_REQUIRE_SPECIAL and not re.search(
        r'[!@#$%^&*(),.?":{}|<>_\-+=/~`\[\]]', password
    ):
        errors.append("Password must contain at least one special character.")

    if errors:
        details = [
            {"loc": ["password"], "msg": err, "type": "password_policy_violation"} for err in errors
        ]
        raise ValidationException(
            message="Password does not meet security policy requirements.",
            details=details,
        )


def hash_token(raw_token: str) -> str:
    """Hashes a refresh or reset token using SHA-256 for secure database storage."""
    return hashlib.sha256(raw_token.encode("utf-8")).hexdigest()


def generate_raw_token() -> str:
    """Generates a cryptographically strong random token."""
    return secrets.token_urlsafe(48)


def create_access_token(
    user_id: str | None = None,
    role: str = "Employee",
    expires_delta: datetime.timedelta | None = None,
    extra_claims: dict[str, Any] | None = None,
    subject: str | None = None,
) -> str:
    """
    Generates a signed JWT access token containing user id and role only.
    Permissions are loaded dynamically from data, not embedded in token.
    """
    now = datetime.datetime.now(datetime.timezone.utc)
    if expires_delta:
        expire = now + expires_delta
    else:
        expire = now + datetime.timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)

    sub_val = str(user_id) if user_id is not None else str(subject)
    to_encode: dict[str, Any] = {
        "sub": sub_val,
        "role": str(role),
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
    subject: str | None = None,
    expires_delta: datetime.timedelta | None = None,
) -> str:
    """Generates an opaque refresh token, or signed JWT if subject provided for testing."""
    if subject is not None:
        now = datetime.datetime.now(datetime.timezone.utc)
        expire = now + (
            expires_delta or datetime.timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
        )
        to_encode = {
            "sub": str(subject),
            "type": "refresh",
            "iat": now,
            "exp": expire,
        }
        return jwt.encode(to_encode, settings.JWT_SECRET_KEY, algorithm=settings.JWT_ALGORITHM)
    return generate_raw_token()


def create_password_reset_token(user_id: str) -> str:
    """Creates a short-lived signed JWT token specifically for password resets."""
    now = datetime.datetime.now(datetime.timezone.utc)
    expire = now + datetime.timedelta(minutes=settings.RESET_TOKEN_EXPIRE_MINUTES)
    to_encode = {
        "sub": str(user_id),
        "type": "password_reset",
        "iat": now,
        "exp": expire,
    }
    return jwt.encode(to_encode, settings.JWT_SECRET_KEY, algorithm=settings.JWT_ALGORITHM)


def decode_token(token: str) -> dict[str, Any]:
    """Decodes and validates a signed JWT token."""
    return jwt.decode(
        token,
        settings.JWT_SECRET_KEY,
        algorithms=[settings.JWT_ALGORITHM],
    )
