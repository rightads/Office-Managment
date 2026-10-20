"""create work_reports and work_report_items tables

Revision ID: f5a6b7c8d9e0
Revises: e4f5a6b7c8d9
Create Date: 2026-10-19 18:30:00.000000

"""

from __future__ import annotations

import sqlalchemy as sa

from alembic import op

# revision identifiers, used by Alembic.
revision: str = "f5a6b7c8d9e0"
down_revision: str | None = "e4f5a6b7c8d9"
branch_labels: str | list[str] | None = None
depends_on: str | list[str] | None = None


def upgrade() -> None:
    op.create_table(
        "work_reports",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("user_id", sa.Uuid(), nullable=False),
        sa.Column("report_date", sa.Date(), nullable=False),
        sa.Column("summary", sa.Text(), nullable=True),
        sa.Column("status", sa.String(length=20), nullable=False, server_default="draft"),
        sa.Column("submitted_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("reviewed_by", sa.Uuid(), nullable=True),
        sa.Column("reviewed_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("review_note", sa.Text(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["reviewed_by"], ["users.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("user_id", "report_date", name="uq_work_reports_user_date"),
    )
    op.create_index(op.f("ix_work_reports_user_id"), "work_reports", ["user_id"], unique=False)
    op.create_index(op.f("ix_work_reports_report_date"), "work_reports", ["report_date"], unique=False)
    op.create_index(op.f("ix_work_reports_status"), "work_reports", ["status"], unique=False)
    op.create_index(op.f("ix_work_reports_reviewed_by"), "work_reports", ["reviewed_by"], unique=False)
    op.create_index(
        "ix_work_reports_user_date",
        "work_reports",
        ["user_id", "report_date"],
        unique=False,
    )
    op.create_index(
        "ix_work_reports_status_date",
        "work_reports",
        ["status", "report_date"],
        unique=False,
    )

    op.create_table(
        "work_report_items",
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("report_id", sa.Uuid(), nullable=False),
        sa.Column("task_id", sa.Uuid(), nullable=True),
        sa.Column("client_id", sa.Uuid(), nullable=True),
        sa.Column("project_id", sa.Uuid(), nullable=True),
        sa.Column("category_id", sa.Uuid(), nullable=True),
        sa.Column("description", sa.Text(), nullable=False),
        sa.Column("minutes_spent", sa.Integer(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.ForeignKeyConstraint(["report_id"], ["work_reports.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["task_id"], ["tasks.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["client_id"], ["clients.id"], ondelete="SET NULL"),
        sa.ForeignKeyConstraint(["project_id"], ["projects.id"], ondelete="SET NULL"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index(
        op.f("ix_work_report_items_report_id"),
        "work_report_items",
        ["report_id"],
        unique=False,
    )
    op.create_index(
        op.f("ix_work_report_items_task_id"),
        "work_report_items",
        ["task_id"],
        unique=False,
    )
    op.create_index(
        op.f("ix_work_report_items_client_id"),
        "work_report_items",
        ["client_id"],
        unique=False,
    )
    op.create_index(
        op.f("ix_work_report_items_project_id"),
        "work_report_items",
        ["project_id"],
        unique=False,
    )


def downgrade() -> None:
    op.drop_index(op.f("ix_work_report_items_project_id"), table_name="work_report_items")
    op.drop_index(op.f("ix_work_report_items_client_id"), table_name="work_report_items")
    op.drop_index(op.f("ix_work_report_items_task_id"), table_name="work_report_items")
    op.drop_index(op.f("ix_work_report_items_report_id"), table_name="work_report_items")
    op.drop_table("work_report_items")

    op.drop_index("ix_work_reports_status_date", table_name="work_reports")
    op.drop_index("ix_work_reports_user_date", table_name="work_reports")
    op.drop_index(op.f("ix_work_reports_reviewed_by"), table_name="work_reports")
    op.drop_index(op.f("ix_work_reports_status"), table_name="work_reports")
    op.drop_index(op.f("ix_work_reports_report_date"), table_name="work_reports")
    op.drop_index(op.f("ix_work_reports_user_id"), table_name="work_reports")
    op.drop_table("work_reports")
