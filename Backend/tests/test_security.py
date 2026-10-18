from __future__ import annotations

from app.core.security import (
    create_access_token,
    create_refresh_token,
    decode_token,
    hash_password,
    verify_password,
)


def test_password_hashing_and_verification() -> None:
    """Verify password hashing with bcrypt works properly."""
    password = "SuperSecretPassword123!"
    hashed = hash_password(password)
    assert hashed != password
    assert verify_password(password, hashed) is True
    assert verify_password("WrongPassword!", hashed) is False


def test_jwt_token_generation_and_decoding() -> None:
    """Verify JWT access and refresh token creation and decoding."""
    subject = "user-123"
    access_token = create_access_token(subject=subject, extra_claims={"role": "admin"})
    decoded = decode_token(access_token)
    assert decoded["sub"] == subject
    assert decoded["type"] == "access"
    assert decoded["role"] == "admin"
    assert "exp" in decoded

    refresh_token = create_refresh_token(subject=subject)
    decoded_refresh = decode_token(refresh_token)
    assert decoded_refresh["sub"] == subject
    assert decoded_refresh["type"] == "refresh"
