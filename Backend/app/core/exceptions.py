from __future__ import annotations

from typing import Any

from fastapi import status
from pydantic import BaseModel, Field

from app.core.constants import ErrorCode


class ErrorDetail(BaseModel):
    loc: list[str | int] | None = Field(
        default=None, description="Location of the error (e.g. field path)"
    )
    msg: str = Field(..., description="Description of the specific error")
    type: str | None = Field(default=None, description="Type/code of the specific error")


class ErrorEnvelope(BaseModel):
    code: str = Field(..., description="High-level machine-readable error code")
    message: str = Field(..., description="Human-readable error summary")
    details: list[ErrorDetail] = Field(default_factory=list, description="Granular error details")


class StandardErrorResponse(BaseModel):
    success: bool = Field(default=False, description="Always false for error responses")
    error: ErrorEnvelope


class AppException(Exception):
    """Base application exception for all domain and operational errors."""

    def __init__(
        self,
        message: str,
        status_code: int = status.HTTP_500_INTERNAL_SERVER_ERROR,
        error_code: str = ErrorCode.INTERNAL_SERVER_ERROR.value,
        details: list[dict[str, Any]] | list[ErrorDetail] | None = None,
    ) -> None:
        super().__init__(message)
        self.message = message
        self.status_code = status_code
        self.error_code = error_code
        self.details: list[ErrorDetail] = []
        if details:
            for item in details:
                if isinstance(item, ErrorDetail):
                    self.details.append(item)
                elif isinstance(item, dict):
                    self.details.append(ErrorDetail(**item))


class NotFoundException(AppException):
    def __init__(
        self,
        message: str = "Resource not found",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_404_NOT_FOUND,
            error_code=ErrorCode.NOT_FOUND.value,
            details=details,
        )


class UnauthorizedException(AppException):
    def __init__(
        self,
        message: str = "Authentication required or invalid credentials",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_401_UNAUTHORIZED,
            error_code=ErrorCode.UNAUTHORIZED.value,
            details=details,
        )


class ForbiddenException(AppException):
    def __init__(
        self,
        message: str = "Permission denied",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_403_FORBIDDEN,
            error_code=ErrorCode.FORBIDDEN.value,
            details=details,
        )


class ValidationException(AppException):
    def __init__(
        self,
        message: str = "Validation failed",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=getattr(status, "HTTP_422_UNPROCESSABLE_CONTENT", 422),
            error_code=ErrorCode.VALIDATION_ERROR.value,
            details=details,
        )


class ConflictException(AppException):
    def __init__(
        self,
        message: str = "Resource conflict detected",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_409_CONFLICT,
            error_code=ErrorCode.CONFLICT.value,
            details=details,
        )


class BadRequestException(AppException):
    def __init__(
        self,
        message: str = "Bad request",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_400_BAD_REQUEST,
            error_code=ErrorCode.BAD_REQUEST.value,
            details=details,
        )


class RateLimitExceededException(AppException):
    def __init__(
        self,
        message: str = "Rate limit exceeded. Please try again later.",
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            error_code=ErrorCode.RATE_LIMIT_EXCEEDED.value,
            details=details,
        )


class BusinessRuleViolationException(AppException):
    def __init__(
        self,
        message: str,
        details: list[dict[str, Any]] | None = None,
    ) -> None:
        super().__init__(
            message=message,
            status_code=status.HTTP_400_BAD_REQUEST,
            error_code=ErrorCode.BAD_REQUEST.value,
            details=details,
        )
