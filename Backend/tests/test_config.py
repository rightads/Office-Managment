from __future__ import annotations

import pytest
from pydantic import ValidationError

from app.core.config import Settings


def test_valid_settings() -> None:
    """Ensure Settings instantiates with valid parameters."""
    cfg = Settings(
        APP_NAME="Right Ads",
        DATABASE_URL="postgresql+asyncpg://user:pass@localhost:5432/db",
        JWT_SECRET_KEY="super_secret_key_that_is_very_long_and_secure",
        DEFAULT_PAGE_SIZE=20,
        MAX_PAGE_SIZE=100,
    )
    assert cfg.APP_NAME == "Right Ads"
    assert cfg.JWT_ALGORITHM == "HS256"
    assert cfg.DEFAULT_PAGE_SIZE == 20
    assert cfg.MAX_PAGE_SIZE == 100


def test_jwt_secret_key_too_short_raises_error() -> None:
    """Per Part A: app must refuse to start if JWT_SECRET_KEY is shorter than 32 chars."""
    with pytest.raises(ValidationError) as exc_info:
        Settings(
            APP_NAME="Right Ads",
            DATABASE_URL="postgresql+asyncpg://user:pass@localhost:5432/db",
            JWT_SECRET_KEY="too_short_secret",
        )
    assert "JWT_SECRET_KEY must be provided and must be at least 32 characters long" in str(
        exc_info.value
    )


def test_jwt_secret_key_missing_raises_error() -> None:
    """Ensure missing JWT_SECRET_KEY fails validation."""
    with pytest.raises(ValidationError):
        Settings(
            APP_NAME="Right Ads",
            DATABASE_URL="postgresql+asyncpg://user:pass@localhost:5432/db",
            JWT_SECRET_KEY="",
        )


def test_cors_origins_parsing() -> None:
    """Test both JSON list and comma-separated string formats for CORS_ORIGINS."""
    cfg1 = Settings(
        APP_NAME="Test",
        DATABASE_URL="postgresql+asyncpg://u:p@localhost/db",
        JWT_SECRET_KEY="a" * 32,
        CORS_ORIGINS='["http://example.com", "http://app.com"]',
    )
    assert cfg1.CORS_ORIGINS == ["http://example.com", "http://app.com"]

    cfg2 = Settings(
        APP_NAME="Test",
        DATABASE_URL="postgresql+asyncpg://u:p@localhost/db",
        JWT_SECRET_KEY="a" * 32,
        CORS_ORIGINS="http://example.com, http://app.com",
    )
    assert cfg2.CORS_ORIGINS == ["http://example.com", "http://app.com"]


def test_pagination_validation() -> None:
    """Ensure DEFAULT_PAGE_SIZE cannot exceed MAX_PAGE_SIZE."""
    with pytest.raises(ValidationError) as exc_info:
        Settings(
            APP_NAME="Test",
            DATABASE_URL="postgresql+asyncpg://u:p@localhost/db",
            JWT_SECRET_KEY="a" * 32,
            DEFAULT_PAGE_SIZE=200,
            MAX_PAGE_SIZE=50,
        )
    assert "DEFAULT_PAGE_SIZE cannot exceed MAX_PAGE_SIZE" in str(exc_info.value)


def test_s3_storage_validation() -> None:
    """Ensure S3 storage requires bucket name."""
    with pytest.raises(ValidationError) as exc_info:
        Settings(
            APP_NAME="Test",
            DATABASE_URL="postgresql+asyncpg://u:p@localhost/db",
            JWT_SECRET_KEY="a" * 32,
            STORAGE_BACKEND="s3",
            S3_BUCKET_NAME=None,
        )
    assert "S3_BUCKET_NAME must be specified" in str(exc_info.value)
