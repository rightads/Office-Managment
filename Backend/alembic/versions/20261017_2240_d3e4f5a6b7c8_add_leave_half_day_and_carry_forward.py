"""add leave half day and carry forward columns

Revision ID: d3e4f5a6b7c8
Revises: c2d3e4f5a6b7
Create Date: 2026-10-17 22:40:00.000000

"""

from __future__ import annotations

import sqlalchemy as sa

from alembic import op

# revision identifiers, used by Alembic.
revision: str = "d3e4f5a6b7c8"
down_revision: str | None = "c2d3e4f5a6b7"
branch_labels: str | list[str] | None = None
depends_on: str | list[str] | None = None


def upgrade() -> None:
    op.add_column(
        "leave_types",
        sa.Column("max_carry_forward", sa.Integer(), nullable=False, server_default="0"),
    )
    op.add_column(
        "leave_balances",
        sa.Column("carried_forward", sa.Float(), nullable=False, server_default="0.0"),
    )
    op.add_column(
        "leave_requests",
        sa.Column("is_half_day", sa.Boolean(), nullable=False, server_default="false"),
    )
    op.add_column(
        "leave_requests",
        sa.Column("half_day_session", sa.String(length=20), nullable=True),
    )
    op.add_column(
        "leave_requests",
        sa.Column("total_days", sa.Float(), nullable=False, server_default="1.0"),
    )


def downgrade() -> None:
    op.drop_column("leave_requests", "total_days")
    op.drop_column("leave_requests", "half_day_session")
    op.drop_column("leave_requests", "is_half_day")
    op.drop_column("leave_balances", "carried_forward")
    op.drop_column("leave_types", "max_carry_forward")
