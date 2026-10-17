from __future__ import annotations

from fastapi import APIRouter

from app.api.v1.endpoints import (
    auth,
    clients_projects,
    employees,
    health,
    master_data,
    roles,
    system_settings,
    task_master,
)

api_v1_router = APIRouter()

# Core system endpoints
api_v1_router.include_router(health.router)
api_v1_router.include_router(auth.router)

# Employee lifecycle & self-service
api_v1_router.include_router(employees.router)

# Master Data & RBAC
api_v1_router.include_router(roles.router)
api_v1_router.include_router(master_data.router)
api_v1_router.include_router(task_master.router)
api_v1_router.include_router(clients_projects.router)
api_v1_router.include_router(system_settings.router)
