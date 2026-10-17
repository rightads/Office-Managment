from __future__ import annotations

from enum import Enum


class Environment(str, Enum):
    DEVELOPMENT = "development"
    STAGING = "staging"
    PRODUCTION = "production"
    TESTING = "testing"


class StorageBackendType(str, Enum):
    LOCAL = "local"
    S3 = "s3"


class ErrorCode(str, Enum):
    """Standard error codes for uniform JSON error responses."""

    VALIDATION_ERROR = "VALIDATION_ERROR"
    NOT_FOUND = "NOT_FOUND"
    UNAUTHORIZED = "UNAUTHORIZED"
    FORBIDDEN = "FORBIDDEN"
    CONFLICT = "CONFLICT"
    INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"
    RATE_LIMIT_EXCEEDED = "RATE_LIMIT_EXCEEDED"
    SERVICE_UNAVAILABLE = "SERVICE_UNAVAILABLE"
    BAD_REQUEST = "BAD_REQUEST"
