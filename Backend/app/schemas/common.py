from __future__ import annotations

import math
import uuid
from typing import Generic, TypeVar

from pydantic import BaseModel, ConfigDict, Field

T = TypeVar("T")


class Page(BaseModel, Generic[T]):
    """Standardized generic pagination envelope for all list endpoints."""

    items: list[T] = Field(..., description="List of paginated items")
    total: int = Field(..., description="Total number of items matching criteria")
    page: int = Field(..., description="Current page number (1-indexed)")
    page_size: int = Field(..., description="Number of items per page")
    total_pages: int = Field(..., description="Total pages available")

    @classmethod
    def create(
        cls,
        items: list[T],
        total: int,
        page: int,
        page_size: int,
    ) -> Page[T]:
        """Constructs a paginated envelope computing total_pages safely."""
        total_pages = math.ceil(total / page_size) if page_size > 0 else 0
        return cls(
            items=items,
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
        )


class MessageResponse(BaseModel):
    """Standardized operation message response."""

    message: str = Field(..., description="Operation feedback message")
    success: bool = Field(default=True, description="Whether operation succeeded")


class StandardResponse(BaseModel, Generic[T]):
    """Standardized API response wrapper."""

    success: bool = Field(default=True, description="Whether operation succeeded")
    data: T | None = Field(default=None, description="Response payload")
    message: str | None = Field(default=None, description="Optional informational message")


class UserBriefResponse(BaseModel):
    """Compact employee / user reference for tasks, audits, and comments."""

    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    email: str
    full_name: str
    employee_code: str
    avatar_url: str | None = None
    designation: str | None = None
