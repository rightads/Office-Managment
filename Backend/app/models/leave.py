from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING

from sqlalchemy import (
    Boolean,
    CheckConstraint,
    Date,
    DateTime,
    Float,
    ForeignKey,
    Index,
    Integer,
    String,
    UniqueConstraint,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import TimestampMixin, UUIDMixin

if TYPE_CHECKING:
    from app.models.user import User


class LeaveType(Base, UUIDMixin, TimestampMixin):
    """Dynamic leave category (Casual Leave, Sick Leave, Maternity Leave, etc.)."""

    __tablename__ = "leave_types"

    name: Mapped[str] = mapped_column(String(100), unique=True, index=True, nullable=False)
    annual_quota: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    is_paid: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    carry_forward: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    balances: Mapped[list[LeaveBalance]] = relationship(
        "LeaveBalance", back_populates="leave_type", cascade="all, delete-orphan"
    )
    requests: Mapped[list[LeaveRequest]] = relationship("LeaveRequest", back_populates="leave_type")


class LeaveBalance(Base, UUIDMixin, TimestampMixin):
    """Annual leave allocation and consumption ledger per employee."""

    __tablename__ = "leave_balances"
    __table_args__ = (
        UniqueConstraint(
            "user_id", "leave_type_id", "year", name="uq_leave_balance_user_type_year"
        ),
        Index("ix_leave_balance_user_year", "user_id", "year"),
        CheckConstraint("allocated >= 0", name="check_positive_allocated_leave"),
        CheckConstraint("used >= 0", name="check_positive_used_leave"),
    )

    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    leave_type_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("leave_types.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    year: Mapped[int] = mapped_column(Integer, nullable=False, index=True)
    allocated: Mapped[float] = mapped_column(Float, default=0.0, nullable=False)
    used: Mapped[float] = mapped_column(Float, default=0.0, nullable=False)

    # Relationships
    user: Mapped[User] = relationship("User", back_populates="leave_balances")
    leave_type: Mapped[LeaveType] = relationship("LeaveType", back_populates="balances")


class LeaveRequest(Base, UUIDMixin, TimestampMixin):
    """Leave application submitted by an employee for review."""

    __tablename__ = "leave_requests"
    __table_args__ = (
        CheckConstraint("to_date >= from_date", name="check_leave_dates_valid"),
        Index("ix_leave_requests_dates", "from_date", "to_date"),
    )

    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    leave_type_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("leave_types.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    from_date: Mapped[datetime.date] = mapped_column(Date, nullable=False, index=True)
    to_date: Mapped[datetime.date] = mapped_column(Date, nullable=False, index=True)
    reason: Mapped[str] = mapped_column(String(500), nullable=False)
    status: Mapped[str] = mapped_column(
        String(50), default="pending", nullable=False, index=True
    )  # pending | approved | rejected | cancelled

    reviewed_by: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    reviewed_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    review_note: Mapped[str | None] = mapped_column(String(500), nullable=True)

    # Relationships
    user: Mapped[User] = relationship(
        "User", back_populates="leave_requests", foreign_keys=[user_id]
    )
    leave_type: Mapped[LeaveType] = relationship("LeaveType", back_populates="requests")
    reviewer: Mapped[User | None] = relationship("User", foreign_keys=[reviewed_by])
