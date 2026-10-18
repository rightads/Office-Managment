from __future__ import annotations

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.dependencies.auth import get_current_user
from app.dependencies.database import get_db
from app.dependencies.rate_limiter import RateLimiter
from app.models.user import User
from app.repositories.user_repository import UserRepository
from app.schemas.auth import (
    ChangePasswordRequest,
    ForgotPasswordRequest,
    LoginRequest,
    RefreshTokenRequest,
    ResetPasswordRequest,
    TokenResponse,
    UserProfileResponse,
)
from app.schemas.common import StandardResponse
from app.services.auth_service import AuthService

router = APIRouter(prefix="/auth", tags=["Authentication"])


@router.post(
    "/login",
    response_model=StandardResponse[TokenResponse],
    status_code=status.HTTP_200_OK,
    summary="User Login",
    dependencies=[Depends(RateLimiter(times=5, seconds=60, prefix="login"))],
)
async def login(
    payload: LoginRequest,
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[TokenResponse]:
    """Authenticates credentials, checks lockout, and returns access and refresh tokens."""
    service = AuthService(db)
    user, access_token, refresh_token = await service.authenticate_user(
        email=payload.email,
        password=payload.password,
        device_id=payload.device_id,
    )

    data = TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        token_type="bearer",
        expires_in_minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES,
    )
    return StandardResponse(data=data, message="Login successful.")


@router.post(
    "/refresh",
    response_model=StandardResponse[TokenResponse],
    status_code=status.HTTP_200_OK,
    summary="Token Refresh with Rotation",
)
async def refresh_tokens(
    payload: RefreshTokenRequest,
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[TokenResponse]:
    """Rotates refresh token and issues fresh access token. Employs reuse detection."""
    service = AuthService(db)
    access_token, new_refresh_token = await service.refresh_tokens(
        raw_refresh_token=payload.refresh_token,
        device_id=payload.device_id,
    )
    data = TokenResponse(
        access_token=access_token,
        refresh_token=new_refresh_token,
        token_type="bearer",
        expires_in_minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES,
    )
    return StandardResponse(data=data, message="Token rotated successfully.")


@router.post(
    "/logout",
    response_model=StandardResponse[dict[str, str]],
    status_code=status.HTTP_200_OK,
    summary="Revoke Single Session",
)
async def logout(
    payload: RefreshTokenRequest,
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[dict[str, str]]:
    """Revokes the current refresh token."""
    service = AuthService(db)
    await service.revoke_refresh_token(payload.refresh_token)
    return StandardResponse(data={"status": "revoked"}, message="Logged out successfully.")


@router.post(
    "/logout-all",
    response_model=StandardResponse[dict[str, str]],
    status_code=status.HTTP_200_OK,
    summary="Revoke All Sessions",
)
async def logout_all(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[dict[str, str]]:
    """Revokes all active refresh tokens for the current user."""
    service = AuthService(db)
    await service.revoke_all_user_tokens(current_user.id)
    return StandardResponse(data={"status": "all_revoked"}, message="All sessions revoked.")


@router.post(
    "/change-password",
    response_model=StandardResponse[dict[str, str]],
    status_code=status.HTTP_200_OK,
    summary="Self-Service Password Change",
)
async def change_password(
    payload: ChangePasswordRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[dict[str, str]]:
    """Changes password, enforces policy rules, and revokes other sessions."""
    service = AuthService(db)
    await service.change_password(
        user=current_user,
        current_password=payload.current_password,
        new_password=payload.new_password,
    )
    return StandardResponse(data={"status": "updated"}, message="Password updated successfully.")


@router.post(
    "/forgot-password",
    response_model=StandardResponse[dict[str, str]],
    status_code=status.HTTP_200_OK,
    summary="Request Password Reset Link",
    dependencies=[Depends(RateLimiter(times=3, seconds=60, prefix="forgot_password"))],
)
async def forgot_password(
    payload: ForgotPasswordRequest,
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[dict[str, str]]:
    """Dispatches a password reset link without leaking email existence."""
    service = AuthService(db)
    await service.request_password_reset(payload.email)
    return StandardResponse(
        data={"status": "initiated"},
        message="If an account with that email exists, password reset instructions have been sent.",
    )


@router.post(
    "/reset-password",
    response_model=StandardResponse[dict[str, str]],
    status_code=status.HTTP_200_OK,
    summary="Reset Password with Token",
    dependencies=[Depends(RateLimiter(times=3, seconds=60, prefix="reset_password"))],
)
async def reset_password(
    payload: ResetPasswordRequest,
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[dict[str, str]]:
    """Resets password using verification token."""
    service = AuthService(db)
    await service.reset_password(token=payload.token, new_password=payload.new_password)
    return StandardResponse(
        data={"status": "reset"}, message="Password has been reset successfully."
    )


@router.get(
    "/me",
    response_model=StandardResponse[UserProfileResponse],
    status_code=status.HTTP_200_OK,
    summary="Current User Profile & Permissions",
)
async def get_my_profile(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> StandardResponse[UserProfileResponse]:
    """Returns profile and permission catalog for the current user."""
    user_repo = UserRepository(db)
    permissions = await user_repo.get_user_permissions(current_user)

    data = UserProfileResponse(
        id=current_user.id,
        employee_code=current_user.employee_code,
        full_name=current_user.full_name,
        email=current_user.email,
        phone=current_user.phone,
        designation=current_user.designation,
        role=current_user.role.name if current_user.role else "Employee",
        permissions=sorted(permissions),
        must_change_password=current_user.must_change_password,
        department_id=current_user.department_id,
    )
    return StandardResponse(data=data)
