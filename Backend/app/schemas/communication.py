from __future__ import annotations

import datetime
import uuid
from typing import Any

from pydantic import BaseModel, ConfigDict, Field

from app.schemas.common import UserBriefResponse


# ==============================================================================
# Device Tokens
# ==============================================================================
class DeviceTokenRegisterRequest(BaseModel):
    fcm_token: str = Field(
        ..., min_length=10, max_length=500, description="FCM device registration token"
    )
    device_id: str = Field(
        ..., min_length=2, max_length=100, description="Unique client hardware or browser ID"
    )
    platform: str = Field(..., description="Device platform: 'android', 'ios', or 'web'")


class DeviceTokenResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    device_id: str
    platform: str
    created_at: datetime.datetime


# ==============================================================================
# In-App Notifications
# ==============================================================================
class NotificationResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    title: str
    body: str
    type: str
    data: dict[str, Any]
    is_read: bool
    created_at: datetime.datetime


class NotificationUnreadCountResponse(BaseModel):
    unread_count: int


# ==============================================================================
# Announcements
# ==============================================================================
class AnnouncementCreateRequest(BaseModel):
    title: str = Field(..., min_length=2, max_length=200, description="Announcement title headline")
    body: str = Field(
        ..., min_length=5, max_length=4000, description="Detailed markdown or plaintext message"
    )
    target_department_id: uuid.UUID | None = Field(
        default=None,
        description="Department UUID for targeted announcements, or null for company-wide",
    )
    expires_at: datetime.datetime | None = Field(
        default=None,
        description="Optional expiration datetime after which the announcement is hidden",
    )


class AnnouncementResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    title: str
    body: str
    target_department_id: uuid.UUID | None
    target_department_name: str | None = None
    creator: UserBriefResponse
    expires_at: datetime.datetime | None
    is_active: bool
    created_at: datetime.datetime


# ==============================================================================
# Notification Templates
# ==============================================================================
class NotificationTemplateResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    title_template: str
    body_template: str
    channel_push: bool
    channel_email: bool
    channel_sms: bool
    is_active: bool
    created_at: datetime.datetime
    updated_at: datetime.datetime


class NotificationTemplateUpdateRequest(BaseModel):
    title_template: str | None = Field(default=None, max_length=255)
    body_template: str | None = Field(default=None, max_length=2000)
    channel_push: bool | None = None
    channel_email: bool | None = None
    channel_sms: bool | None = None
    is_active: bool | None = None
