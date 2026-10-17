from __future__ import annotations

from typing import Generic, TypeVar

from pydantic import BaseModel, Field

from app.core.config import settings

T = TypeVar("T")


class PaginationParams(BaseModel):
    """Pagination query parameters validated dynamically against settings."""

    page: int = Field(default=1, ge=1, description="Page number (1-indexed)")
    page_size: int = Field(
        default_factory=lambda: settings.DEFAULT_PAGE_SIZE,
        ge=1,
        description="Number of records per page",
    )

    @property
    def offset(self) -> int:
        return (self.page - 1) * self.page_size

    @property
    def limit(self) -> int:
        # Enforce max page size from configuration
        return min(self.page_size, settings.MAX_PAGE_SIZE)


class PaginationMeta(BaseModel):
    page: int
    page_size: int
    total_items: int
    total_pages: int
    has_next: bool
    has_prev: bool


class PaginatedResponse(BaseModel, Generic[T]):
    """Standard generic envelope for all paginated lists."""

    success: bool = True
    data: list[T]
    pagination: PaginationMeta


class StandardResponse(BaseModel, Generic[T]):
    """Standard generic envelope for single-resource responses."""

    success: bool = True
    data: T
    message: str | None = None
