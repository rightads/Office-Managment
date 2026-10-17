from __future__ import annotations

import json
from functools import lru_cache
from typing import Any, Literal

from pydantic import (
    Field,
    field_validator,
    model_validator,
)
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """
    Central Application Settings loaded strictly from environment variables.
    Part A Non-Negotiable Rule: Zero Hardcoding.
    """

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=True,
        extra="ignore",
    )

    # Core Application Info
    APP_NAME: str = Field(
        default="Right Ads",
        description="Application name",
    )
    ENVIRONMENT: str = Field(
        default="development",
        description="Runtime environment: development | staging | production",
    )
    DEBUG: bool = Field(default=False, description="Enable debug mode")
    APP_TIMEZONE: str = Field(
        default="UTC",
        description="Display timezone name, e.g. UTC, Asia/Kolkata",
    )

    # Database Settings
    DATABASE_URL: str = Field(
        ...,
        description="Async PostgreSQL connection URL (postgresql+asyncpg://user:pass@host:port/db)",
    )

    # Security & JWT Tokens
    JWT_SECRET_KEY: str = Field(
        ...,
        description="Secret key for JWT generation; minimum 32 characters required",
    )
    JWT_ALGORITHM: str = Field(
        default="HS256",
        description="Cryptographic algorithm for JWT",
    )
    ACCESS_TOKEN_EXPIRE_MINUTES: int = Field(
        default=60,
        gt=0,
        description="Expiration time in minutes for access tokens",
    )
    REFRESH_TOKEN_EXPIRE_DAYS: int = Field(
        default=7,
        gt=0,
        description="Expiration time in days for refresh tokens",
    )
    MAX_LOGIN_ATTEMPTS: int = Field(
        default=5,
        gt=0,
        description="Max failed login attempts before lockout",
    )
    LOCKOUT_MINUTES: int = Field(
        default=15,
        gt=0,
        description="Lockout period in minutes following failed attempts",
    )

    # CORS Settings
    CORS_ORIGINS: list[str] = Field(
        default_factory=lambda: ["http://localhost:3000", "http://localhost:8000"],
        description="Allowed CORS origins",
    )

    # Pagination Settings
    DEFAULT_PAGE_SIZE: int = Field(
        default=20,
        gt=0,
        description="Default number of items per page",
    )
    MAX_PAGE_SIZE: int = Field(
        default=100,
        gt=0,
        description="Maximum allowed items per page",
    )

    # File Upload & Storage Settings
    MAX_UPLOAD_MB: int = Field(
        default=10,
        gt=0,
        description="Maximum upload size in megabytes",
    )
    ALLOWED_UPLOAD_MIME_TYPES: list[str] = Field(
        default_factory=lambda: [
            "image/jpeg",
            "image/png",
            "image/webp",
            "application/pdf",
        ],
        description="Allowed MIME types for uploads",
    )
    STORAGE_BACKEND: Literal["local", "s3"] = Field(
        default="local",
        description="Storage provider: local or s3",
    )
    LOCAL_STORAGE_PATH: str = Field(
        default="./uploads",
        description="Directory for local storage",
    )
    S3_BUCKET_NAME: str | None = Field(
        default=None,
        description="AWS S3 Bucket Name",
    )
    S3_REGION: str | None = Field(
        default=None,
        description="AWS S3 Region",
    )
    S3_ACCESS_KEY_ID: str | None = Field(
        default=None,
        description="AWS S3 Access Key ID",
    )
    S3_SECRET_ACCESS_KEY: str | None = Field(
        default=None,
        description="AWS S3 Secret Access Key",
    )
    S3_ENDPOINT_URL: str | None = Field(
        default=None,
        description="Custom endpoint URL for S3-compatible providers (MinIO, etc.)",
    )

    # Firebase Cloud Messaging (FCM)
    FCM_CREDENTIALS_PATH: str | None = Field(
        default=None,
        description="File path to Firebase service account JSON",
    )

    # Redis Cache & Rate Limiting
    REDIS_URL: str | None = Field(
        default=None,
        description="Redis connection URL (redis://...)",
    )
    RATE_LIMIT_ENABLED: bool = Field(
        default=True,
        description="Enable API rate limiting",
    )
    RATE_LIMIT_REQUESTS_PER_MINUTE: int = Field(
        default=60,
        gt=0,
        description="Max requests per minute per IP/user",
    )

    @field_validator("JWT_SECRET_KEY")
    @classmethod
    def validate_jwt_secret_key(cls, v: str) -> str:
        cleaned = v.strip()
        if not cleaned or len(cleaned) < 32:
            raise ValueError(
                "JWT_SECRET_KEY must be provided and must be at least 32 characters long."
            )
        return cleaned

    @field_validator("DATABASE_URL")
    @classmethod
    def normalize_database_url(cls, v: str) -> str:
        # Standardize postgresql:// to postgresql+asyncpg:// if not specified
        url = v.strip()
        if url.startswith("postgres://"):
            url = url.replace("postgres://", "postgresql+asyncpg://", 1)
        elif url.startswith("postgresql://") and not url.startswith("postgresql+asyncpg://"):
            url = url.replace("postgresql://", "postgresql+asyncpg://", 1)
        return url

    @field_validator("CORS_ORIGINS", mode="before")
    @classmethod
    def parse_cors_origins(cls, v: Any) -> list[str]:
        if isinstance(v, str):
            v = v.strip()
            if not v:
                return []
            if v.startswith("[") and v.endswith("]"):
                try:
                    loaded = json.loads(v)
                    if isinstance(loaded, list):
                        return [str(item).strip() for item in loaded if str(item).strip()]
                except json.JSONDecodeError:
                    pass
            return [part.strip() for part in v.split(",") if part.strip()]
        if isinstance(v, (list, tuple, set)):
            return [str(item).strip() for item in v if str(item).strip()]
        return []

    @field_validator("ALLOWED_UPLOAD_MIME_TYPES", mode="before")
    @classmethod
    def parse_mime_types(cls, v: Any) -> list[str]:
        if isinstance(v, str):
            v = v.strip()
            if not v:
                return []
            if v.startswith("[") and v.endswith("]"):
                try:
                    loaded = json.loads(v)
                    if isinstance(loaded, list):
                        return [str(item).strip().lower() for item in loaded if str(item).strip()]
                except json.JSONDecodeError:
                    pass
            return [part.strip().lower() for part in v.split(",") if part.strip()]
        if isinstance(v, (list, tuple, set)):
            return [str(item).strip().lower() for item in v if str(item).strip()]
        return []

    @model_validator(mode="after")
    def validate_pagination_and_storage(self) -> Settings:
        if self.DEFAULT_PAGE_SIZE > self.MAX_PAGE_SIZE:
            raise ValueError("DEFAULT_PAGE_SIZE cannot exceed MAX_PAGE_SIZE.")
        if self.STORAGE_BACKEND == "s3":
            if not self.S3_BUCKET_NAME:
                raise ValueError("S3_BUCKET_NAME must be specified when STORAGE_BACKEND is 's3'.")
        return self


@lru_cache
def get_settings() -> Settings:
    """Cached accessor for application settings."""
    return Settings()


settings: Settings = get_settings()
