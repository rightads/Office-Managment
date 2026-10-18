from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from sqlalchemy import (
    JSON,
    Boolean,
    CheckConstraint,
    Date,
    DateTime,
    Float,
    ForeignKey,
    Index,
    Integer,
    String,
    Time,
    UniqueConstraint,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.constants import LeaveRequestStatus
from app.core.database import Base
from app.models.base import TimestampMixin, UUIDMixin

if TYPE_CHECKING:
    from app.models.user import User


class AttendancePolicy(Base, UUIDMixin, TimestampMixin):
    """Dynamic attendance rules, shifts, thresholds, and geolocation policies."""

    __tablename__ = "attendance_policies"
    __table_args__ = (
        CheckConstraint("grace_minutes >= 0", name="check_positive_grace_minutes"),
        CheckConstraint("half_day_min_hours >= 0", name="check_positive_half_day_hours"),
        CheckConstraint(
            "full_day_min_hours >= half_day_min_hours",
            name="check_full_day_ge_half_day",
        ),
    )

    name: Mapped[str] = mapped_column(String(100), unique=True, index=True, nullable=False)
    shift_start: Mapped[datetime.time] = mapped_column(Time, nullable=False)
    shift_end: Mapped[datetime.time] = mapped_column(Time, nullable=False)
    grace_minutes: Mapped[int] = mapped_column(Integer, default=15, nullable=False)
    half_day_min_hours: Mapped[float] = mapped_column(Float, default=4.0, nullable=False)
    full_day_min_hours: Mapped[float] = mapped_column(Float, default=8.0, nullable=False)
    week_off_days: Mapped[list[int]] = mapped_column(JSON, default=list, nullable=False)
    require_geofence: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    require_selfie: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    allowed_location_ids: Mapped[list[str]] = mapped_column(JSON, default=list, nullable=False)
    is_default: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    users: Mapped[list[User]] = relationship("User", back_populates="attendance_policy")


class AttendanceStatus(Base, UUIDMixin, TimestampMixin):
    """Database-driven attendance status codes (Present, Absent, Half-Day, Late, etc.)."""

    __tablename__ = "attendance_statuses"

    code: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
    label: Mapped[str] = mapped_column(String(100), nullable=False)
    counts_as_present: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    color: Mapped[str] = mapped_column(String(20), default="#10B981", nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    records: Mapped[list[AttendanceRecord]] = relationship(
        "AttendanceRecord", back_populates="status"
    )


class AttendanceRecord(Base, UUIDMixin, TimestampMixin):
    """Daily employee attendance log with unique (user_id, date) constraint."""

    __tablename__ = "attendance_records"
    __table_args__ = (
        UniqueConstraint("user_id", "date", name="uq_attendance_records_user_date"),
        Index("ix_attendance_user_date", "user_id", "date"),
        Index("ix_attendance_status_date", "status_id", "date"),
        CheckConstraint("total_minutes >= 0", name="check_positive_total_minutes"),
    )

    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    date: Mapped[datetime.date] = mapped_column(Date, nullable=False, index=True)
    check_in_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    check_out_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    check_in_lat: Mapped[float | None] = mapped_column(Float, nullable=True)
    check_in_lng: Mapped[float | None] = mapped_column(Float, nullable=True)
    check_out_lat: Mapped[float | None] = mapped_column(Float, nullable=True)
    check_out_lng: Mapped[float | None] = mapped_column(Float, nullable=True)
    check_in_selfie_url: Mapped[str | None] = mapped_column(String(500), nullable=True)

    status_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("attendance_statuses.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    total_minutes: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    is_manual: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    source: Mapped[str | None] = mapped_column(String(50), nullable=True)
    device_id: Mapped[str | None] = mapped_column(String(100), nullable=True)
    remarks: Mapped[str | None] = mapped_column(String(500), nullable=True)

    # Relationships
    user: Mapped[User] = relationship("User", back_populates="attendance_records")
    status: Mapped[AttendanceStatus] = relationship("AttendanceStatus", back_populates="records")
    corrections: Mapped[list[AttendanceCorrection]] = relationship(
        "AttendanceCorrection",
        back_populates="attendance_record",
        cascade="all, delete-orphan",
    )


class AttendanceCorrection(Base, UUIDMixin, TimestampMixin):
    """Audit log of attendance record changes and manual corrections."""

    __tablename__ = "attendance_corrections"

    attendance_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("attendance_records.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    changed_by: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    old_value: Mapped[dict[str, Any]] = mapped_column(JSON, nullable=False)
    new_value: Mapped[dict[str, Any]] = mapped_column(JSON, nullable=False)
    reason: Mapped[str] = mapped_column(String(500), nullable=False)
    status: Mapped[str] = mapped_column(
        String(50), default=LeaveRequestStatus.APPROVED.value, nullable=False
    )

    # Relationships
    attendance_record: Mapped[AttendanceRecord] = relationship(
        "AttendanceRecord", back_populates="corrections"
    )
    changer: Mapped[User] = relationship("User", foreign_keys=[changed_by])
