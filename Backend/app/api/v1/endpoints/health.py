from __future__ import annotations

import datetime

from fastapi import APIRouter, Depends, status
from pydantic import BaseModel
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.dependencies.database import get_db

router = APIRouter(tags=["Health"])


class ComponentHealth(BaseModel):
    status: str
    details: str | None = None


class HealthResponse(BaseModel):
    status: str
    environment: str
    timestamp: str
    components: dict[str, ComponentHealth]


@router.get(
    "/health",
    response_model=HealthResponse,
    status_code=status.HTTP_200_OK,
    summary="Application Health & Readiness Probe",
)
async def check_health(
    db: AsyncSession | None = Depends(get_db),
) -> HealthResponse:
    """Check health status of the application, database, and cache."""
    components: dict[str, ComponentHealth] = {}
    overall_status = "ok"

    # Database connectivity check
    if db is not None:
        try:
            await db.execute(text("SELECT 1"))
            components["database"] = ComponentHealth(status="reachable")
        except Exception as exc:
            overall_status = "degraded"
            components["database"] = ComponentHealth(
                status="unreachable",
                details=f"DB check failed: {type(exc).__name__}",
            )
    else:
        components["database"] = ComponentHealth(status="disabled")

    # Redis connectivity check (if configured)
    if settings.REDIS_URL:
        try:
            import redis.asyncio as aioredis

            client = aioredis.from_url(settings.REDIS_URL)
            await client.ping()
            await client.aclose()
            components["redis"] = ComponentHealth(status="reachable")
        except Exception as exc:
            # Redis is optional per stack definition
            components["redis"] = ComponentHealth(
                status="unreachable",
                details=f"Redis check failed: {type(exc).__name__}",
            )
    else:
        components["redis"] = ComponentHealth(status="not_configured")

    return HealthResponse(
        status=overall_status,
        environment=settings.ENVIRONMENT,
        timestamp=datetime.datetime.now(datetime.timezone.utc).isoformat(),
        components=components,
    )
