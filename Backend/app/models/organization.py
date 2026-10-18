from __future__ import annotations

import datetime
from typing import TYPE_CHECKING

from sqlalchemy import Boolean, CheckConstraint, Date, Float, Integer, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import TimestampMixin, UUIDMixin

if TYPE_CHECKING:
    from app.models.communication import Announcement
    from app.models.task import Task
    from app.models.user import User


class Department(Base, UUIDMixin, TimestampMixin):
    """Department/category entity (SEO, Social Media, etc. are dynamic data rows)."""

    __tablename__ = "departments"

    name: Mapped[str] = mapped_column(String(100), unique=True, index=True, nullable=False)
    description: Mapped[str | None] = mapped_column(String(255), nullable=True)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    users: Mapped[list[User]] = relationship("User", back_populates="department")
    tasks: Mapped[list[Task]] = relationship("Task", back_populates="department")
    announcements: Mapped[list[Announcement]] = relationship(
        "Announcement", back_populates="target_department"
    )


class OfficeLocation(Base, UUIDMixin, TimestampMixin):
    """Geofenced physical office location for attendance validation."""

    __tablename__ = "office_locations"
    __table_args__ = (CheckConstraint("radius_meters > 0", name="check_positive_office_radius"),)

    name: Mapped[str] = mapped_column(String(100), nullable=False)
    latitude: Mapped[float] = mapped_column(Float, nullable=False)
    longitude: Mapped[float] = mapped_column(Float, nullable=False)
    radius_meters: Mapped[float] = mapped_column(Float, default=100.0, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)


class Holiday(Base, UUIDMixin, TimestampMixin):
    """Company holiday calendar entry."""

    __tablename__ = "holidays"
    __table_args__ = (UniqueConstraint("date", "name", name="uq_holiday_date_name"),)

    date: Mapped[datetime.date] = mapped_column(Date, nullable=False, index=True)
    name: Mapped[str] = mapped_column(String(150), nullable=False)
    is_optional: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    year: Mapped[int] = mapped_column(Integer, nullable=False, index=True)
