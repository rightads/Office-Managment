from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING

from sqlalchemy import (
    Boolean,
    Date,
    DateTime,
    ForeignKey,
    Index,
    Integer,
    String,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import SoftDeleteMixin, TimestampMixin, UUIDMixin

if TYPE_CHECKING:
    from app.models.attendance import AttendancePolicy, AttendanceRecord
    from app.models.communication import DeviceToken, Notification
    from app.models.leave import LeaveBalance, LeaveRequest
    from app.models.organization import Department
    from app.models.rbac import Role
    from app.models.system import RefreshToken
    from app.models.task import Task, TaskAssignee


class User(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    """Core employee and user account model."""

    __tablename__ = "users"
    __table_args__ = (
        Index("ix_users_email_is_active", "email", "is_active"),
        Index("ix_users_department_active", "department_id", "is_active"),
    )

    # Identifiers
    employee_code: Mapped[str] = mapped_column(
        String(50),
        unique=True,
        index=True,
        nullable=False,
    )
    email: Mapped[str] = mapped_column(
        String(255),
        unique=True,
        index=True,
        nullable=False,
    )
    full_name: Mapped[str] = mapped_column(String(150), nullable=False)
    phone: Mapped[str | None] = mapped_column(String(25), nullable=True)
    avatar_url: Mapped[str | None] = mapped_column(String(500), nullable=True)
    device_id: Mapped[str | None] = mapped_column(String(100), nullable=True)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)

    # Organizational Associations
    role_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("roles.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    department_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("departments.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    manager_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    attendance_policy_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("attendance_policies.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )

    # Employment Details
    designation: Mapped[str | None] = mapped_column(String(100), nullable=True)
    date_of_joining: Mapped[datetime.date | None] = mapped_column(Date, nullable=True)

    # State & Security Flags
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False, index=True)
    must_change_password: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    failed_login_attempts: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    locked_until: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        default=None,
        nullable=True,
    )
    last_login_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        default=None,
        nullable=True,
    )

    # Relationships
    role: Mapped[Role] = relationship("Role", back_populates="users", lazy="joined")
    department: Mapped[Department | None] = relationship("Department", back_populates="users")
    manager: Mapped[User | None] = relationship(
        "User",
        remote_side="User.id",
        back_populates="subordinates",
    )
    subordinates: Mapped[list[User]] = relationship("User", back_populates="manager")
    attendance_policy: Mapped[AttendancePolicy | None] = relationship(
        "AttendancePolicy",
        back_populates="users",
    )
    attendance_records: Mapped[list[AttendanceRecord]] = relationship(
        "AttendanceRecord",
        back_populates="user",
        cascade="all, delete-orphan",
    )
    leave_balances: Mapped[list[LeaveBalance]] = relationship(
        "LeaveBalance",
        back_populates="user",
        cascade="all, delete-orphan",
    )
    leave_requests: Mapped[list[LeaveRequest]] = relationship(
        "LeaveRequest",
        back_populates="user",
        foreign_keys="[LeaveRequest.user_id]",
        cascade="all, delete-orphan",
    )
    assigned_tasks: Mapped[list[TaskAssignee]] = relationship(
        "TaskAssignee",
        back_populates="user",
        cascade="all, delete-orphan",
    )
    created_tasks: Mapped[list[Task]] = relationship(
        "Task",
        back_populates="assigner",
        foreign_keys="[Task.assigned_by]",
    )
    device_tokens: Mapped[list[DeviceToken]] = relationship(
        "DeviceToken",
        back_populates="user",
        cascade="all, delete-orphan",
    )
    notifications: Mapped[list[Notification]] = relationship(
        "Notification",
        back_populates="user",
        cascade="all, delete-orphan",
    )
    refresh_tokens: Mapped[list[RefreshToken]] = relationship(
        "RefreshToken",
        back_populates="user",
        cascade="all, delete-orphan",
    )
