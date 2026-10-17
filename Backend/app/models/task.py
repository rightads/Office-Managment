from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from sqlalchemy import (
    JSON,
    Boolean,
    Date,
    DateTime,
    ForeignKey,
    Index,
    Integer,
    String,
    UniqueConstraint,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import SoftDeleteMixin, TimestampMixin, UUIDMixin, utc_now

if TYPE_CHECKING:
    from app.models.organization import Department
    from app.models.user import User


class Client(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    """Marketing agency client record."""

    __tablename__ = "clients"

    name: Mapped[str] = mapped_column(String(150), index=True, nullable=False)
    contact_details: Mapped[dict[str, Any]] = mapped_column(JSON, default=dict, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    projects: Mapped[list[Project]] = relationship(
        "Project", back_populates="client", cascade="all, delete-orphan"
    )
    tasks: Mapped[list[Task]] = relationship("Task", back_populates="client")


class Project(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    """Client project grouping tasks and deliverables."""

    __tablename__ = "projects"
    __table_args__ = (Index("ix_projects_client_active", "client_id", "is_active"),)

    client_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("clients.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    name: Mapped[str] = mapped_column(String(150), nullable=False)
    description: Mapped[str | None] = mapped_column(String(500), nullable=True)
    start_date: Mapped[datetime.date | None] = mapped_column(Date, nullable=True)
    end_date: Mapped[datetime.date | None] = mapped_column(Date, nullable=True)
    status: Mapped[str] = mapped_column(String(50), default="active", nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    client: Mapped[Client] = relationship("Client", back_populates="projects")
    tasks: Mapped[list[Task]] = relationship("Task", back_populates="project")


class TaskStatus(Base, UUIDMixin, TimestampMixin):
    """Admin-manageable task lifecycle stage (To Do, In Progress, In Review, Done)."""

    __tablename__ = "task_statuses"

    code: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
    label: Mapped[str] = mapped_column(String(100), nullable=False)
    order: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    is_terminal: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    color: Mapped[str] = mapped_column(String(20), default="#3B82F6", nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    tasks: Mapped[list[Task]] = relationship("Task", back_populates="status")


class TaskStatusTransition(Base, UUIDMixin, TimestampMixin):
    """Permitted state transitions between task statuses, guarded by optional permissions."""

    __tablename__ = "task_status_transitions"
    __table_args__ = (
        UniqueConstraint("from_status_id", "to_status_id", name="uq_task_status_transition_path"),
    )

    from_status_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("task_statuses.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    to_status_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("task_statuses.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    required_permission: Mapped[str | None] = mapped_column(String(100), nullable=True)

    # Relationships
    from_status: Mapped[TaskStatus] = relationship("TaskStatus", foreign_keys=[from_status_id])
    to_status: Mapped[TaskStatus] = relationship("TaskStatus", foreign_keys=[to_status_id])


class TaskPriority(Base, UUIDMixin, TimestampMixin):
    """Database-driven task priority weightings and labels."""

    __tablename__ = "task_priorities"

    code: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
    label: Mapped[str] = mapped_column(String(100), nullable=False)
    weight: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    color: Mapped[str] = mapped_column(String(20), default="#6B7280", nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    tasks: Mapped[list[Task]] = relationship("Task", back_populates="priority")


class Task(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    """Core task deliverable entity."""

    __tablename__ = "tasks"
    __table_args__ = (
        Index("ix_tasks_status_due", "status_id", "due_at"),
        Index("ix_tasks_due_at", "due_at"),
        Index("ix_tasks_dept_active", "department_id", "is_active"),
    )

    title: Mapped[str] = mapped_column(String(200), nullable=False)
    description: Mapped[str | None] = mapped_column(String(2000), nullable=True)

    department_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("departments.id", ondelete="SET NULL"),
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
    priority_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("task_priorities.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    status_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("task_statuses.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    assigned_by: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )

    due_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    completed_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    department: Mapped[Department | None] = relationship("Department", back_populates="tasks")
    client: Mapped[Client | None] = relationship("Client", back_populates="tasks")
    project: Mapped[Project | None] = relationship("Project", back_populates="tasks")
    priority: Mapped[TaskPriority] = relationship("TaskPriority", back_populates="tasks")
    status: Mapped[TaskStatus] = relationship("TaskStatus", back_populates="tasks")
    assigner: Mapped[User] = relationship(
        "User", back_populates="created_tasks", foreign_keys=[assigned_by]
    )

    assignees: Mapped[list[TaskAssignee]] = relationship(
        "TaskAssignee", back_populates="task", cascade="all, delete-orphan"
    )
    comments: Mapped[list[TaskComment]] = relationship(
        "TaskComment", back_populates="task", cascade="all, delete-orphan"
    )
    attachments: Mapped[list[TaskAttachment]] = relationship(
        "TaskAttachment", back_populates="task", cascade="all, delete-orphan"
    )
    activities: Mapped[list[TaskActivity]] = relationship(
        "TaskActivity", back_populates="task", cascade="all, delete-orphan"
    )


class TaskAssignee(Base):
    """Association table linking tasks to one or more assigned employees."""

    __tablename__ = "task_assignees"

    task_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("tasks.id", ondelete="CASCADE"),
        primary_key=True,
    )
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        index=True,
    )
    assigned_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        nullable=False,
    )

    # Relationships
    task: Mapped[Task] = relationship("Task", back_populates="assignees")
    user: Mapped[User] = relationship("User", back_populates="assigned_tasks")


class TaskComment(Base, UUIDMixin, TimestampMixin):
    """Discussion comments on tasks."""

    __tablename__ = "task_comments"

    task_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("tasks.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    comment: Mapped[str] = mapped_column(String(2000), nullable=False)

    # Relationships
    task: Mapped[Task] = relationship("Task", back_populates="comments")
    author: Mapped[User] = relationship("User")


class TaskAttachment(Base, UUIDMixin, TimestampMixin):
    """File attachment metadata associated with tasks."""

    __tablename__ = "task_attachments"

    task_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("tasks.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    uploaded_by: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    file_name: Mapped[str] = mapped_column(String(255), nullable=False)
    file_url: Mapped[str] = mapped_column(String(500), nullable=False)
    file_size_bytes: Mapped[int] = mapped_column(Integer, nullable=False)
    mime_type: Mapped[str] = mapped_column(String(100), nullable=False)

    # Relationships
    task: Mapped[Task] = relationship("Task", back_populates="attachments")
    uploader: Mapped[User] = relationship("User")


class TaskActivity(Base, UUIDMixin):
    """Timeline and history audit log for task status/assignment events."""

    __tablename__ = "task_activities"

    task_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("tasks.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    actor_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    action: Mapped[str] = mapped_column(String(100), nullable=False)
    details: Mapped[dict[str, Any]] = mapped_column(JSON, default=dict, nullable=False)
    created_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        nullable=False,
    )

    # Relationships
    task: Mapped[Task] = relationship("Task", back_populates="activities")
    actor: Mapped[User] = relationship("User")
