from __future__ import annotations

from collections.abc import Sequence
from typing import Any, Generic, TypeVar

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import Base
from app.models.base import SoftDeleteMixin

ModelType = TypeVar("ModelType", bound=Base)


class BaseRepository(Generic[ModelType]):
    """Generic async repository providing CRUD abstraction."""

    def __init__(self, model: type[ModelType], session: AsyncSession) -> None:
        self.model = model
        self.session = session

    async def get_by_id(self, id_val: Any) -> ModelType | None:
        """Fetch a single record by primary key."""
        result = await self.session.get(self.model, id_val)
        if (
            result
            and issubclass(self.model, SoftDeleteMixin)
            and getattr(result, "is_deleted", False)
        ):
            return None
        return result

    async def list_paginated(
        self,
        offset: int = 0,
        limit: int = 20,
        include_deleted: bool = False,
    ) -> tuple[Sequence[ModelType], int]:
        """Fetch paginated records alongside total count."""
        base_query = select(self.model)
        count_query = select(func.count()).select_from(self.model)

        if issubclass(self.model, SoftDeleteMixin) and not include_deleted:
            base_query = base_query.where(self.model.is_deleted.is_(False))
            count_query = count_query.where(self.model.is_deleted.is_(False))

        total_result = await self.session.execute(count_query)
        total: int = total_result.scalar_one()

        items_query = base_query.offset(offset).limit(limit)
        items_result = await self.session.execute(items_query)
        items: Sequence[ModelType] = items_result.scalars().all()

        return items, total

    async def create(self, instance: ModelType) -> ModelType:
        """Add and flush a new record."""
        self.session.add(instance)
        await self.session.flush()
        await self.session.refresh(instance)
        return instance

    async def update(self, instance: ModelType) -> ModelType:
        """Flush changes to an existing record."""
        await self.session.flush()
        await self.session.refresh(instance)
        return instance

    async def soft_delete(self, instance: ModelType) -> None:
        """Soft delete a record if supported, or raise error."""
        if isinstance(instance, SoftDeleteMixin):
            instance.soft_delete()
            await self.session.flush()
        else:
            raise NotImplementedError(f"Model {self.model.__name__} does not support soft deletes.")
