from __future__ import annotations

import uuid

from pydantic import BaseModel, EmailStr, Field


class LoginRequest(BaseModel):
    """User credentials for authentication."""

    email: EmailStr = Field(..., description="Employee email address")
    password: str = Field(..., min_length=1, description="Account password")
    device_id: str | None = Field(
        default=None, description="Optional unique client device identifier"
    )


class TokenResponse(BaseModel):
    """Authentication tokens returned upon successful login or rotation."""

    access_token: str = Field(..., description="JWT Bearer access token")
    refresh_token: str = Field(..., description="Rotatable opaque refresh token")
    token_type: str = Field(default="bearer", description="Token authorization type")
    expires_in_minutes: int = Field(..., description="Access token lifetime in minutes")


class RefreshTokenRequest(BaseModel):
    """Refresh token payload."""

    refresh_token: str = Field(..., description="Current active refresh token")
    device_id: str | None = Field(default=None, description="Client device identifier")


class ChangePasswordRequest(BaseModel):
    """Self-service password update payload."""

    current_password: str = Field(..., min_length=1, description="Existing account password")
    new_password: str = Field(..., min_length=6, description="New secure password meeting policy")


class ForgotPasswordRequest(BaseModel):
    """Password reset recovery request."""

    email: EmailStr = Field(..., description="Registered account email address")


class ResetPasswordRequest(BaseModel):
    """Token-based password reset payload."""

    token: str = Field(..., description="Password reset verification token")
    new_password: str = Field(..., min_length=6, description="New secure password meeting policy")


class UserProfileResponse(BaseModel):
    """Current authenticated user profile and dynamically resolved permissions."""

    id: uuid.UUID
    employee_code: str
    full_name: str
    email: str
    phone: str | None = None
    designation: str | None = None
    role: str
    permissions: list[str]
    must_change_password: bool
    department_id: uuid.UUID | None = None
