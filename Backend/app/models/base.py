from __future__ import annotations

import datetime

from sqlalchemy import Boolean, DateTime
from sqlalchemy.orm import Mapped, mapped_column

from app.core.database import Base

__all__ = ["Base", "TimestampMixin", "SoftDeleteMixin", "utc_now"]


def utc_now() -> datetime.datetime:
    """Returns timezone-aware UTC datetime."""
    return datetime.datetime.now(datetime.timezone.utc)


class TimestampMixin:
    """Mixin providing timezone-aware UTC timestamps for creation and modification."""

    created_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        nullable=False,
    )
    updated_at: Mapped[datetime.datetime] = mapped_column(
        DateTime(timezone=True),
        default=utc_now,
        onupdate=utc_now,
        nullable=False,
    )


class SoftDeleteMixin:
    """Mixin supporting non-destructive soft deletes."""

    is_deleted: Mapped[bool] = mapped_column(
        Boolean,
        default=False,
        nullable=False,
        index=True,
    )
    deleted_at: Mapped[datetime.datetime | None] = mapped_column(
        DateTime(timezone=True),
        default=None,
        nullable=True,
    )

    def soft_delete(self) -> None:
        self.is_deleted = True
        self.deleted_at = utc_now()

    def restore(self) -> None:
        self.is_deleted = False
        self.deleted_at = None
