"""create dynamic module engine tables

Revision ID: a6b7c8d9e0f1
Revises: f5a6b7c8d9e0
Create Date: 2026-10-20 17:30:00.000000

"""

from __future__ import annotations

import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision: str = "a6b7c8d9e0f1"
down_revision: str | None = "f5a6b7c8d9e0"
branch_labels: str | list[str] | None = None
depends_on: str | list[str] | None = None


def upgrade() -> None:
    # 1. module_definitions
    op.create_table(
        "module_definitions",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("app_module_id", sa.Uuid(), nullable=True),
        sa.Column("code", sa.String(length=50), nullable=False),
        sa.Column("label", sa.String(length=100), nullable=False),
        sa.Column("description", sa.String(length=255), nullable=True),
        sa.Column("record_label_singular", sa.String(length=50), nullable=False, server_default="Record"),
        sa.Column("record_label_plural", sa.String(length=50), nullable=False, server_default="Records"),
        sa.Column("version", sa.Integer(), nullable=False, server_default="1"),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default=sa.text("true")),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["app_module_id"], ["app_modules.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index("ix_module_definitions_code", "module_definitions", ["code"], unique=True)
    op.create_index("ix_module_definitions_app_module_id", "module_definitions", ["app_module_id"], unique=False)

    # 2. module_fields
    op.create_table(
        "module_fields",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("module_id", sa.Uuid(), nullable=False),
        sa.Column("key", sa.String(length=50), nullable=False),
        sa.Column("label", sa.String(length=100), nullable=False),
        sa.Column("type", sa.String(length=30), nullable=False),
        sa.Column("is_required", sa.Boolean(), nullable=False, server_default=sa.text("false")),
        sa.Column("is_list_visible", sa.Boolean(), nullable=False, server_default=sa.text("true")),
        sa.Column("is_filterable", sa.Boolean(), nullable=False, server_default=sa.text("false")),
        sa.Column("is_searchable", sa.Boolean(), nullable=False, server_default=sa.text("false")),
        sa.Column("options", sa.JSON(), nullable=True),
        sa.Column("validation", sa.JSON(), nullable=True),
        sa.Column("default_value", sa.JSON(), nullable=True),
        sa.Column("sort_order", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("section", sa.String(length=50), nullable=False, server_default="General"),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default=sa.text("true")),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["module_id"], ["module_definitions.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("module_id", "key", name="uq_module_fields_module_key"),
    )
    op.create_index("ix_module_fields_module_id", "module_fields", ["module_id"], unique=False)
    op.create_index("ix_module_fields_module_sort", "module_fields", ["module_id", "sort_order"], unique=False)

    # 3. module_statuses
    op.create_table(
        "module_statuses",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("module_id", sa.Uuid(), nullable=False),
        sa.Column("code", sa.String(length=50), nullable=False),
        sa.Column("label", sa.String(length=100), nullable=False),
        sa.Column("color", sa.String(length=20), nullable=False, server_default="#3B82F6"),
        sa.Column("sort_order", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("is_terminal", sa.Boolean(), nullable=False, server_default=sa.text("false")),
        sa.Column("required_permission", sa.String(length=100), nullable=True),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default=sa.text("true")),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["module_id"], ["module_definitions.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("module_id", "code", name="uq_module_statuses_module_code"),
    )
    op.create_index("ix_module_statuses_module_id", "module_statuses", ["module_id"], unique=False)
    op.create_index("ix_module_statuses_module_sort", "module_statuses", ["module_id", "sort_order"], unique=False)

    # 4. module_status_transitions
    op.create_table(
        "module_status_transitions",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("module_id", sa.Uuid(), nullable=False),
        sa.Column("from_status_id", sa.Uuid(), nullable=False),
        sa.Column("to_status_id", sa.Uuid(), nullable=False),
        sa.Column("required_permission", sa.String(length=100), nullable=True),
        sa.ForeignKeyConstraint(["from_status_id"], ["module_statuses.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["module_id"], ["module_definitions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["to_status_id"], ["module_statuses.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("module_id", "from_status_id", "to_status_id", name="uq_module_transitions_from_to"),
    )
    op.create_index("ix_module_status_transitions_module_id", "module_status_transitions", ["module_id"], unique=False)
    op.create_index("ix_module_status_transitions_from_status_id", "module_status_transitions", ["from_status_id"], unique=False)
    op.create_index("ix_module_status_transitions_to_status_id", "module_status_transitions", ["to_status_id"], unique=False)

    # 5. module_records
    op.create_table(
        "module_records",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("module_id", sa.Uuid(), nullable=False),
        sa.Column("data", sa.JSON(), nullable=False),
        sa.Column("status_id", sa.Uuid(), nullable=True),
        sa.Column("created_by", sa.Uuid(), nullable=False),
        sa.Column("assigned_to", sa.Uuid(), nullable=True),
        sa.Column("client_id", sa.Uuid(), nullable=True),
        sa.Column("due_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("is_deleted", sa.Boolean(), nullable=False, server_default=sa.text("false")),
        sa.Column("deleted_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["assigned_to"], ["users.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["client_id"], ["clients.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["created_by"], ["users.id"], ondelete="RESTRICT"),
        sa.ForeignKeyConstraint(["module_id"], ["module_definitions.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["status_id"], ["module_statuses.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index("ix_module_records_module_id", "module_records", ["module_id"], unique=False)
    op.create_index("ix_module_records_status_id", "module_records", ["status_id"], unique=False)
    op.create_index("ix_module_records_created_by", "module_records", ["created_by"], unique=False)
    op.create_index("ix_module_records_assigned_to", "module_records", ["assigned_to"], unique=False)
    op.create_index("ix_module_records_client_id", "module_records", ["client_id"], unique=False)
    op.create_index("ix_module_records_is_deleted", "module_records", ["is_deleted"], unique=False)
    op.create_index("ix_module_records_module_status", "module_records", ["module_id", "status_id"], unique=False)
    op.create_index("ix_module_records_module_assigned", "module_records", ["module_id", "assigned_to"], unique=False)
    op.create_index("ix_module_records_module_created_at", "module_records", ["module_id", "created_at"], unique=False)

    # 6. module_record_comments
    op.create_table(
        "module_record_comments",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("record_id", sa.Uuid(), nullable=False),
        sa.Column("user_id", sa.Uuid(), nullable=False),
        sa.Column("comment", sa.Text(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["record_id"], ["module_records.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="RESTRICT"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index("ix_module_record_comments_record_id", "module_record_comments", ["record_id"], unique=False)
    op.create_index("ix_module_record_comments_user_id", "module_record_comments", ["user_id"], unique=False)

    # 7. module_record_attachments
    op.create_table(
        "module_record_attachments",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("record_id", sa.Uuid(), nullable=False),
        sa.Column("user_id", sa.Uuid(), nullable=False),
        sa.Column("file_url", sa.String(length=500), nullable=False),
        sa.Column("file_name", sa.String(length=255), nullable=False),
        sa.Column("file_size", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("mime_type", sa.String(length=100), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["record_id"], ["module_records.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="RESTRICT"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index("ix_module_record_attachments_record_id", "module_record_attachments", ["record_id"], unique=False)
    op.create_index("ix_module_record_attachments_user_id", "module_record_attachments", ["user_id"], unique=False)

    # 8. module_record_activities
    op.create_table(
        "module_record_activities",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("record_id", sa.Uuid(), nullable=False),
        sa.Column("user_id", sa.Uuid(), nullable=True),
        sa.Column("action", sa.String(length=50), nullable=False),
        sa.Column("details", sa.JSON(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False, server_default=sa.func.now()),
        sa.ForeignKeyConstraint(["record_id"], ["module_records.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index("ix_module_record_activities_record_id", "module_record_activities", ["record_id"], unique=False)
    op.create_index("ix_module_record_activities_user_id", "module_record_activities", ["user_id"], unique=False)


def downgrade() -> None:
    op.drop_table("module_record_activities")
    op.drop_table("module_record_attachments")
    op.drop_table("module_record_comments")
    op.drop_table("module_records")
    op.drop_table("module_status_transitions")
    op.drop_table("module_statuses")
    op.drop_table("module_fields")
    op.drop_table("module_definitions")
