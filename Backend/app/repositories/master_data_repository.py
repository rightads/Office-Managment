from __future__ import annotations

import uuid
from typing import Any, TypeVar, cast

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.rbac import Permission, Role
from app.models.system import AppModule, SystemSetting
from app.models.task import TaskStatusTransition

M = TypeVar("M")


class MasterDataRepository:
    """Consolidated persistence queries for master data domains."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    # ==========================================================================
    # Generic Helpers
    # ==========================================================================
    async def get_by_id(self, model_cls: type[M], entity_id: uuid.UUID) -> M | None:
        cls_any = cast(Any, model_cls)
        stmt = select(model_cls).where(cls_any.id == entity_id)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_paginated(
        self,
        model_cls: type[M],
        page: int = 1,
        page_size: int = 20,
        is_active: bool | None = None,
    ) -> tuple[list[M], int]:
        stmt = select(model_cls)
        count_stmt = select(func.count()).select_from(model_cls)

        cls_any = cast(Any, model_cls)
        if is_active is not None and hasattr(model_cls, "is_active"):
            stmt = stmt.where(cls_any.is_active == is_active)
            count_stmt = count_stmt.where(cls_any.is_active == is_active)

        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar_one()

        offset = (page - 1) * page_size
        stmt = stmt.offset(offset).limit(page_size)
        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    # ==========================================================================
    # Roles & Permissions
    # ==========================================================================
    async def get_role_by_id(self, role_id: uuid.UUID) -> Role | None:
        stmt = select(Role).where(Role.id == role_id).options(selectinload(Role.permissions))
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_role_by_name(self, name: str) -> Role | None:
        stmt = select(Role).where(func.lower(Role.name) == name.strip().lower())
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_roles(
        self,
        page: int = 1,
        page_size: int = 20,
        is_active: bool | None = None,
    ) -> tuple[list[Role], int]:
        stmt = select(Role).options(selectinload(Role.permissions))
        count_stmt = select(func.count()).select_from(Role)

        if is_active is not None:
            stmt = stmt.where(Role.is_active == is_active)
            count_stmt = count_stmt.where(Role.is_active == is_active)

        total = (await self.session.execute(count_stmt)).scalar_one()
        stmt = stmt.offset((page - 1) * page_size).limit(page_size)
        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    async def list_permissions(
        self,
        page: int = 1,
        page_size: int = 50,
    ) -> tuple[list[Permission], int]:
        count_stmt = select(func.count()).select_from(Permission)
        total = (await self.session.execute(count_stmt)).scalar_one()

        stmt = (
            select(Permission)
            .order_by(Permission.code.asc())
            .offset((page - 1) * page_size)
            .limit(page_size)
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    async def get_permissions_by_ids(self, perm_ids: list[uuid.UUID]) -> list[Permission]:
        stmt = select(Permission).where(Permission.id.in_(perm_ids))
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    # ==========================================================================
    # System Settings
    # ==========================================================================
    async def get_setting(self, key: str) -> SystemSetting | None:
        stmt = select(SystemSetting).where(SystemSetting.key == key)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_settings(self) -> list[SystemSetting]:
        stmt = select(SystemSetting).order_by(SystemSetting.key.asc())
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def upsert_setting(
        self, key: str, value: Any, description: str | None = None
    ) -> SystemSetting:
        setting = await self.get_setting(key)
        if setting:
            setting.value = value
            if description is not None:
                setting.description = description
        else:
            setting = SystemSetting(key=key, value=value, description=description)
            self.session.add(setting)
        await self.session.flush()
        return setting

    # ==========================================================================
    # App Modules
    # ==========================================================================
    async def get_app_module_by_code(self, code: str) -> AppModule | None:
        stmt = select(AppModule).where(func.lower(AppModule.code) == code.strip().lower())
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_app_modules(self, is_active: bool | None = None) -> list[AppModule]:
        stmt = select(AppModule)
        if is_active is not None:
            stmt = stmt.where(AppModule.is_active == is_active)
        stmt = stmt.order_by(AppModule.sort_order.asc(), AppModule.label.asc())
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    # ==========================================================================
    # Task Status Transitions
    # ==========================================================================
    async def list_task_transitions(self) -> list[TaskStatusTransition]:
        stmt = select(TaskStatusTransition)
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_transition(
        self, from_id: uuid.UUID, to_id: uuid.UUID
    ) -> TaskStatusTransition | None:
        stmt = select(TaskStatusTransition).where(
            TaskStatusTransition.from_status_id == from_id,
            TaskStatusTransition.to_status_id == to_id,
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

