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
    Integer,
    String,
    Text,
    UniqueConstraint,
    Uuid,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base
from app.models.base import SoftDeleteMixin, TimestampMixin, UUIDMixin, utc_now

if TYPE_CHECKING:
    from app.models.system import AppModule
    from app.models.task import Client
    from app.models.user import User


class ModuleDefinition(Base, UUIDMixin, TimestampMixin):
    """Schema definition for a role-specific or dynamic business module (e.g., Leads, Tickets, Invoices)."""

    __tablename__ = "module_definitions"

    app_module_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("app_modules.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    code: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
    label: Mapped[str] = mapped_column(String(100), nullable=False)
    description: Mapped[str | None] = mapped_column(String(255), nullable=True)
    record_label_singular: Mapped[str] = mapped_column(String(50), nullable=False, default="Record")
    record_label_plural: Mapped[str] = mapped_column(String(50), nullable=False, default="Records")
    version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    app_module: Mapped[AppModule | None] = relationship("AppModule")
    fields: Mapped[list[ModuleField]] = relationship(
        "ModuleField",
        back_populates="module",
        cascade="all, delete-orphan",
        order_by="ModuleField.sort_order",
    )
    statuses: Mapped[list[ModuleStatus]] = relationship(
        "ModuleStatus",
        back_populates="module",
        cascade="all, delete-orphan",
        order_by="ModuleStatus.sort_order",
    )
    transitions: Mapped[list[ModuleStatusTransition]] = relationship(
        "ModuleStatusTransition",
        back_populates="module",
        cascade="all, delete-orphan",
    )
    records: Mapped[list[ModuleRecord]] = relationship(
        "ModuleRecord",
        back_populates="module",
        cascade="all, delete-orphan",
    )


class ModuleField(Base, UUIDMixin, TimestampMixin):
    """Attribute specification and form rules for a field in a dynamic module."""

    __tablename__ = "module_fields"
    __table_args__ = (
        UniqueConstraint("module_id", "key", name="uq_module_fields_module_key"),
        Index("ix_module_fields_module_sort", "module_id", "sort_order"),
    )

    module_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_definitions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    key: Mapped[str] = mapped_column(String(50), nullable=False)
    label: Mapped[str] = mapped_column(String(100), nullable=False)
    type: Mapped[str] = mapped_column(String(30), nullable=False)
    is_required: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    is_list_visible: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    is_filterable: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    is_searchable: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    options: Mapped[list[dict[str, Any]] | None] = mapped_column(JSON, nullable=True)
    validation: Mapped[dict[str, Any] | None] = mapped_column(JSON, nullable=True)
    default_value: Mapped[Any | None] = mapped_column(JSON, nullable=True)
    sort_order: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    section: Mapped[str] = mapped_column(String(50), default="General", nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    module: Mapped[ModuleDefinition] = relationship("ModuleDefinition", back_populates="fields")


class ModuleStatus(Base, UUIDMixin, TimestampMixin):
    """Configurable workflow status for records of a dynamic module."""

    __tablename__ = "module_statuses"
    __table_args__ = (
        UniqueConstraint("module_id", "code", name="uq_module_statuses_module_code"),
        Index("ix_module_statuses_module_sort", "module_id", "sort_order"),
    )

    module_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_definitions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    code: Mapped[str] = mapped_column(String(50), nullable=False)
    label: Mapped[str] = mapped_column(String(100), nullable=False)
    color: Mapped[str] = mapped_column(String(20), default="#3B82F6", nullable=False)
    sort_order: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    is_terminal: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    required_permission: Mapped[str | None] = mapped_column(String(100), nullable=True)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Relationships
    module: Mapped[ModuleDefinition] = relationship("ModuleDefinition", back_populates="statuses")


class ModuleStatusTransition(Base, UUIDMixin):
    """Permitted state machine transition between two statuses within a dynamic module."""

    __tablename__ = "module_status_transitions"
    __table_args__ = (
        UniqueConstraint(
            "module_id",
            "from_status_id",
            "to_status_id",
            name="uq_module_transitions_from_to",
        ),
    )

    module_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_definitions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    from_status_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_statuses.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    to_status_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_statuses.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    required_permission: Mapped[str | None] = mapped_column(String(100), nullable=True)

    # Relationships
    module: Mapped[ModuleDefinition] = relationship("ModuleDefinition", back_populates="transitions")
    from_status: Mapped[ModuleStatus] = relationship("ModuleStatus", foreign_keys=[from_status_id])
    to_status: Mapped[ModuleStatus] = relationship("ModuleStatus", foreign_keys=[to_status_id])


class ModuleRecord(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    """An individual entity instance stored with schema-driven JSON payload."""

    __tablename__ = "module_records"
    __table_args__ = (
        Index("ix_module_records_module_status", "module_id", "status_id"),
        Index("ix_module_records_module_assigned", "module_id", "assigned_to"),
        Index("ix_module_records_module_created_at", "module_id", "created_at"),
    )

    module_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_definitions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    data: Mapped[dict[str, Any]] = mapped_column(JSON, default=dict, nullable=False)
    status_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_statuses.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    created_by: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    assigned_to: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    client_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("clients.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    due_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        nullable=True,
    )

    # Relationships
    module: Mapped[ModuleDefinition] = relationship("ModuleDefinition", back_populates="records")
    status: Mapped[ModuleStatus | None] = relationship("ModuleStatus")
    creator: Mapped[User] = relationship("User", foreign_keys=[created_by])
    assignee: Mapped[User | None] = relationship("User", foreign_keys=[assigned_to])
    client: Mapped[Client | None] = relationship("Client")

    comments: Mapped[list[ModuleRecordComment]] = relationship(
        "ModuleRecordComment",
        back_populates="record",
        cascade="all, delete-orphan",
        order_by="ModuleRecordComment.created_at.desc()",
    )
    attachments: Mapped[list[ModuleRecordAttachment]] = relationship(
        "ModuleRecordAttachment",
        back_populates="record",
        cascade="all, delete-orphan",
        order_by="ModuleRecordAttachment.created_at.desc()",
    )
    activities: Mapped[list[ModuleRecordActivity]] = relationship(
        "ModuleRecordActivity",
        back_populates="record",
        cascade="all, delete-orphan",
        order_by="ModuleRecordActivity.created_at.desc()",
    )


class ModuleRecordComment(Base, UUIDMixin):
    """User comment left on a module record."""

    __tablename__ = "module_record_comments"

    record_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_records.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    comment: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        nullable=False,
    )

    # Relationships
    record: Mapped[ModuleRecord] = relationship("ModuleRecord", back_populates="comments")
    user: Mapped[User] = relationship("User")


class ModuleRecordAttachment(Base, UUIDMixin):
    """File attachment uploaded to a module record."""

    __tablename__ = "module_record_attachments"

    record_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_records.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="RESTRICT"),
        nullable=False,
        index=True,
    )
    file_url: Mapped[str] = mapped_column(String(500), nullable=False)
    file_name: Mapped[str] = mapped_column(String(255), nullable=False)
    file_size: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    mime_type: Mapped[str | None] = mapped_column(String(100), nullable=True)
    created_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        nullable=False,
    )

    # Relationships
    record: Mapped[ModuleRecord] = relationship("ModuleRecord", back_populates="attachments")
    user: Mapped[User] = relationship("User")


class ModuleRecordActivity(Base, UUIDMixin):
    """Audit log entry in the timeline of a module record."""

    __tablename__ = "module_record_activities"

    record_id: Mapped[uuid.UUID] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("module_records.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    user_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid(as_uuid=True),
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    action: Mapped[str] = mapped_column(String(50), nullable=False)
    details: Mapped[dict[str, Any] | None] = mapped_column(JSON, nullable=True)
    created_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        nullable=False,
    )

    # Relationships
    record: Mapped[ModuleRecord] = relationship("ModuleRecord", back_populates="activities")
    user: Mapped[User | None] = relationship("User")
