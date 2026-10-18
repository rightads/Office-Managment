"""create app_modules table

Revision ID: e4f5a6b7c8d9
Revises: d3e4f5a6b7c8
Create Date: 2026-10-18 21:15:00.000000

"""

from __future__ import annotations

import sqlalchemy as sa

from alembic import op

# revision identifiers, used by Alembic.
revision: str = "e4f5a6b7c8d9"
down_revision: str | None = "d3e4f5a6b7c8"
branch_labels: str | list[str] | None = None
depends_on: str | list[str] | None = None


def upgrade() -> None:
    op.create_table(
        "app_modules",
        sa.Column("code", sa.String(length=100), nullable=False),
        sa.Column("label", sa.String(length=150), nullable=False),
        sa.Column("icon_key", sa.String(length=100), nullable=False),
        sa.Column("route_key", sa.String(length=100), nullable=False),
        sa.Column("sort_order", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("required_permission", sa.String(length=100), nullable=True),
        sa.Column("is_base", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("show_on_home", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("id", sa.Uuid(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), nullable=False),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index(op.f("ix_app_modules_code"), "app_modules", ["code"], unique=True)
    op.create_index(
        op.f("ix_app_modules_required_permission"),
        "app_modules",
        ["required_permission"],
        unique=False,
    )


def downgrade() -> None:
    op.drop_index(op.f("ix_app_modules_required_permission"), table_name="app_modules")
    op.drop_index(op.f("ix_app_modules_code"), table_name="app_modules")
    op.drop_table("app_modules")
