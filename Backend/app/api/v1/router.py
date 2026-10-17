from __future__ import annotations

from fastapi import APIRouter

from app.api.v1.endpoints import health

api_v1_router = APIRouter()

# Mount health endpoint under /api/v1 as well
api_v1_router.include_router(health.router)
