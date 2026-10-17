from __future__ import annotations

import uuid
from typing import Any

from fastapi import Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.system import AuditLog
from app.repositories.audit_repository import AuditRepository


class AuditService:
    """Reusable service for recording auditable state changes across the application."""

    @staticmethod
    def extract_client_ip(request: Request | None) -> str | None:
        """Extracts client IP address respecting X-Forwarded-For if available."""
        if not request:
            return None
        forwarded = request.headers.get("x-forwarded-for")
        if forwarded:
            return forwarded.split(",")[0].strip()
        if request.client:
            return request.client.host
        return None

    @classmethod
    async def record(
        cls,
        session: AsyncSession,
        *,
        action: str,
        entity_type: str,
        entity_id: str | uuid.UUID,
        actor_id: uuid.UUID | None = None,
        old_data: dict[str, Any] | None = None,
        new_data: dict[str, Any] | None = None,
        request: Request | None = None,
        ip_address: str | None = None,
    ) -> AuditLog:
        """Appends an immutable audit log entry."""
        resolved_ip = ip_address or cls.extract_client_ip(request)
        repo = AuditRepository(session)
        return await repo.create(
            actor_id=actor_id,
            action=action,
            entity_type=entity_type,
            entity_id=str(entity_id),
            old_data=old_data,
            new_data=new_data,
            ip_address=resolved_ip,
        )
