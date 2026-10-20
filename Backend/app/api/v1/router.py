from __future__ import annotations

from fastapi import APIRouter

from app.api.v1.endpoints import (
    announcements,
    attendance,
    attendance_reports,
    auth,
    clients_projects,
    employees,
    health,
    leaves,
    master_data,
    navigation_config,
    notifications,
    roles,
    system_settings,
    task_master,
    tasks,
    work_reports,
)

api_v1_router = APIRouter()

# Core system endpoints
api_v1_router.include_router(health.router)
api_v1_router.include_router(auth.router)
api_v1_router.include_router(navigation_config.router)

# Employee lifecycle & self-service
api_v1_router.include_router(employees.router)

# Attendance Engine & Reports
api_v1_router.include_router(attendance.router)
api_v1_router.include_router(attendance_reports.router)

# Leave Management
api_v1_router.include_router(leaves.router)

# Task Management & Categories/Projects
api_v1_router.include_router(tasks.router)
api_v1_router.include_router(task_master.router)
api_v1_router.include_router(clients_projects.router)

# Daily Work Reports & Timesheets (Backend Addendum A2)
api_v1_router.include_router(work_reports.router)

# Communication & Notifications
api_v1_router.include_router(notifications.router)
api_v1_router.include_router(announcements.router)

# Master Data & RBAC
api_v1_router.include_router(roles.router)
api_v1_router.include_router(master_data.router)
api_v1_router.include_router(system_settings.router)
