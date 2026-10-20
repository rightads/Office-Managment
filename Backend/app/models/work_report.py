from __future__ import annotations

import datetime
import enum
import uuid
from typing import TYPE_CHECKING

from sqlalchemy import (
    Date,
    DateTime,
    ForeignKey,
    Index,
    Integer,
    String,
    Text,
    UniqueConstraint,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import TimestampMixin, UUIDMixin

if TYPE_CHECKING:
    from app.models.task import Client, Project, Task
    from app.models.user import User


class WorkReportStatus(str, enum.Enum):
    DRAFT = "draft"
    SUBMITTED = "submitted"
    REVIEWED = "reviewed"


class WorkReport(Base, UUIDMixin, TimestampMixin):
    """Daily timesheet and work progress report submitted by an employee."""

    __tablename__ = "work_reports"
    __table_args__ = (
        UniqueConstraint("user_id", "report_date", name="uq_work_reports_user_date"),
        Index("ix_work_reports_status_date", "status", "report_date"),
    )

    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    report_date: Mapped[datetime.date] = mapped_column(Date, nullable=False, index=True)
    summary: Mapped[str | None] = mapped_column(Text, nullable=True)
    status: Mapped[str] = mapped_column(
        String(20),
        default=WorkReportStatus.DRAFT.value,
        nullable=False,
        index=True,
    )
    submitted_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
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
    review_note: Mapped[str | None] = mapped_column(Text, nullable=True)

    # Relationships
    user: Mapped[User] = relationship(
        "User",
        foreign_keys=[user_id],
        backref="work_reports",
    )
    reviewer: Mapped[User | None] = relationship(
        "User",
        foreign_keys=[reviewed_by],
    )
    items: Mapped[list[WorkReportItem]] = relationship(
        "WorkReportItem",
        back_populates="report",
        cascade="all, delete-orphan",
        order_by="WorkReportItem.created_at.asc()",
    )

    @property
    def total_minutes(self) -> int:
        return sum(item.minutes_spent for item in self.items)


class WorkReportItem(Base, UUIDMixin, TimestampMixin):
    """Granular work activity or task logged within a daily report."""

    __tablename__ = "work_report_items"

    report_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("work_reports.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    task_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("tasks.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    client_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("clients.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    project_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("projects.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    category_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        nullable=True,
    )
    description: Mapped[str] = mapped_column(Text, nullable=False)
    minutes_spent: Mapped[int] = mapped_column(Integer, nullable=False)

    # Relationships
    report: Mapped[WorkReport] = relationship("WorkReport", back_populates="items")
    task: Mapped[Task | None] = relationship("Task")
    client: Mapped[Client | None] = relationship("Client")
    project: Mapped[Project | None] = relationship("Project")
