from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from sqlalchemy import (
    JSON,
    Boolean,
    DateTime,
    ForeignKey,
    Index,
    String,
    UniqueConstraint,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import TimestampMixin, UUIDMixin

if TYPE_CHECKING:
    from app.models.organization import Department
    from app.models.user import User


class Announcement(Base, UUIDMixin, TimestampMixin):
    """Company-wide or department-targeted bulletin board announcement."""

    __tablename__ = "announcements"

    title: Mapped[str] = mapped_column(String(200), nullable=False)
    body: Mapped[str] = mapped_column(String(4000), nullable=False)
    target_department_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("departments.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    created_by: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    expires_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
        index=True,
    )
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    target_department: Mapped[Department | None] = relationship(
        "Department", back_populates="announcements"
    )
    creator: Mapped[User] = relationship("User")


class NotificationTemplate(Base, UUIDMixin, TimestampMixin):
    """Configurable templates for transactional notifications."""

    __tablename__ = "notification_templates"

    code: Mapped[str] = mapped_column(String(100), unique=True, index=True, nullable=False)
    title_template: Mapped[str] = mapped_column(String(255), nullable=False)
    body_template: Mapped[str] = mapped_column(String(2000), nullable=False)
    channel_push: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    channel_email: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    channel_sms: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)


class Notification(Base, UUIDMixin, TimestampMixin):
    """In-app and push notification inbox record for an employee."""

    __tablename__ = "notifications"
    __table_args__ = (Index("ix_notifications_user_read", "user_id", "is_read"),)

    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    title: Mapped[str] = mapped_column(String(200), nullable=False)
    body: Mapped[str] = mapped_column(String(1000), nullable=False)
    type: Mapped[str] = mapped_column(String(50), nullable=False)
    data: Mapped[dict[str, Any]] = mapped_column(JSON, default=dict, nullable=False)
    is_read: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)

    # Relationships
    user: Mapped[User] = relationship("User", back_populates="notifications")


class DeviceToken(Base, UUIDMixin, TimestampMixin):
    """Registered mobile and web FCM push notification device tokens."""

    __tablename__ = "device_tokens"
    __table_args__ = (
        UniqueConstraint("user_id", "device_id", "platform", name="uq_user_device_platform"),
    )

    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    fcm_token: Mapped[str] = mapped_column(String(500), nullable=False)
    device_id: Mapped[str] = mapped_column(String(100), nullable=False)
    platform: Mapped[str] = mapped_column(String(20), nullable=False)  # android | ios | web

    # Relationships
    user: Mapped[User] = relationship("User", back_populates="device_tokens")
