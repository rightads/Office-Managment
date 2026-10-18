from __future__ import annotations

import uuid
from typing import Any

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.system import AuditLog


class AuditRepository:
    """Persistence operations for immutable audit trail entries."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    async def create(
        self,
        *,
        action: str,
        entity_type: str,
        entity_id: str,
        actor_id: uuid.UUID | None = None,
        old_data: dict[str, Any] | None = None,
        new_data: dict[str, Any] | None = None,
        ip_address: str | None = None,
    ) -> AuditLog:
        """Appends a new audit record to the log."""
        log = AuditLog(
            actor_id=actor_id,
            action=action,
            entity_type=entity_type,
            entity_id=str(entity_id),
            old_data=old_data,
            new_data=new_data,
            ip_address=ip_address,
        )
        self.session.add(log)
        await self.session.flush()
        return log

    async def list_logs(
        self,
        *,
        page: int = 1,
        page_size: int = 20,
        entity_type: str | None = None,
        entity_id: str | None = None,
        actor_id: uuid.UUID | None = None,
        action: str | None = None,
    ) -> tuple[list[AuditLog], int]:
        """Queries audit records with filtering and pagination."""
        stmt = select(AuditLog)
        count_stmt = select(func.count()).select_from(AuditLog)

        if entity_type:
            stmt = stmt.where(AuditLog.entity_type == entity_type)
            count_stmt = count_stmt.where(AuditLog.entity_type == entity_type)
        if entity_id:
            stmt = stmt.where(AuditLog.entity_id == entity_id)
            count_stmt = count_stmt.where(AuditLog.entity_id == entity_id)
        if actor_id:
            stmt = stmt.where(AuditLog.actor_id == actor_id)
            count_stmt = count_stmt.where(AuditLog.actor_id == actor_id)
        if action:
            stmt = stmt.where(AuditLog.action == action)
            count_stmt = count_stmt.where(AuditLog.action == action)

        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar_one()

        stmt = stmt.order_by(AuditLog.created_at.desc())
        offset = (page - 1) * page_size
        stmt = stmt.offset(offset).limit(page_size)

        result = await self.session.execute(stmt)
        items = list(result.scalars().all())
        return items, total
