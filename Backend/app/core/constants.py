from __future__ import annotations

import datetime
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


class LeaveRequestStatus(str, Enum):
    """Lifecycle statuses for employee leave applications."""

    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"
    CANCELLED = "cancelled"


class AttendanceStatusCode(str, Enum):
    """Standard dynamic attendance status lookup codes."""

    PRESENT = "PRESENT"
    ABSENT = "ABSENT"
    HALF_DAY = "HALF_DAY"
    LATE = "LATE"
    ON_LEAVE = "ON_LEAVE"
    WEEK_OFF = "WEEK_OFF"
    HOLIDAY = "HOLIDAY"


# Numeric fallback constants in business logic when unconfigured
DEFAULT_SHIFT_END_TIME: datetime.time = datetime.time(18, 30)
DEFAULT_FULL_DAY_HOURS: float = 8.0
DEFAULT_HALF_DAY_HOURS: float = 4.0
DEFAULT_AUTO_CHECKOUT_DURATION_HOURS: int = 8
DEFAULT_TASK_DUE_REMINDER_LEAD_HOURS: int = 24
