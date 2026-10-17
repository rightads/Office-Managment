from __future__ import annotations

from fastapi import APIRouter

from app.api.v1.endpoints import auth, health

api_v1_router = APIRouter()

# Mount health endpoint under /api/v1 as well
api_v1_router.include_router(health.router)

# Mount authentication endpoints under /api/v1/auth
api_v1_router.include_router(auth.router)
