from __future__ import annotations

import datetime
import uuid
from typing import Any

from pydantic import BaseModel, ConfigDict, EmailStr, Field


# ==============================================================================
# RBAC: Roles & Permissions
# ==============================================================================
class PermissionResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    description: str | None = None
    created_at: datetime.datetime


class RoleCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=100, description="Role title")
    description: str | None = Field(default=None, max_length=255)
    permission_ids: list[uuid.UUID] = Field(
        default_factory=list, description="Associated permission IDs"
    )


class RoleUpdate(BaseModel):
    name: str | None = Field(default=None, min_length=2, max_length=100)
    description: str | None = Field(default=None, max_length=255)
    is_active: bool | None = None
    permission_ids: list[uuid.UUID] | None = None


class RoleResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    description: str | None = None
    is_system: bool
    is_active: bool
    permissions: list[PermissionResponse] = Field(default_factory=list)
    created_at: datetime.datetime


# ==============================================================================
# Organization: Departments & Locations
# ==============================================================================
class DepartmentCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=100)
    description: str | None = Field(default=None, max_length=255)


class DepartmentUpdate(BaseModel):
    name: str | None = Field(default=None, min_length=2, max_length=100)
    description: str | None = Field(default=None, max_length=255)
    is_active: bool | None = None


class DepartmentResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    description: str | None = None
    is_active: bool
    created_at: datetime.datetime


class OfficeLocationCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=100)
    latitude: float = Field(..., ge=-90.0, le=90.0)
    longitude: float = Field(..., ge=-180.0, le=180.0)
    radius_meters: float = Field(default=100.0, gt=0, le=5000)
    address: str | None = None


class OfficeLocationUpdate(BaseModel):
    name: str | None = None
    latitude: float | None = Field(default=None, ge=-90.0, le=90.0)
    longitude: float | None = Field(default=None, ge=-180.0, le=180.0)
    radius_meters: float | None = Field(default=None, gt=0, le=5000)
    is_active: bool | None = None


class OfficeLocationResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    latitude: float
    longitude: float
    radius_meters: float
    is_active: bool
    created_at: datetime.datetime


class HolidayCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=100)
    date: datetime.date
    is_optional: bool = False


class HolidayUpdate(BaseModel):
    name: str | None = None
    date: datetime.date | None = None
    is_optional: bool | None = None


class HolidayResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    date: datetime.date
    year: int
    is_optional: bool
    created_at: datetime.datetime


# ==============================================================================
# Attendance & Leave Policies
# ==============================================================================
class AttendanceStatusCreate(BaseModel):
    code: str = Field(..., min_length=2, max_length=50)
    label: str = Field(..., min_length=2, max_length=100)
    counts_as_present: bool = False
    color: str = Field(default="#10B981", max_length=20)


class AttendanceStatusUpdate(BaseModel):
    label: str | None = None
    counts_as_present: bool | None = None
    color: str | None = None
    is_active: bool | None = None


class AttendanceStatusResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    counts_as_present: bool
    color: str
    is_active: bool
    created_at: datetime.datetime


class AttendancePolicyCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=100)
    shift_start: datetime.time
    shift_end: datetime.time
    grace_minutes: int = Field(default=15, ge=0)
    half_day_min_hours: float = Field(default=4.5, gt=0)
    full_day_min_hours: float = Field(default=8.0, gt=0)
    week_off_days: list[int] = Field(default_factory=lambda: [6])
    require_geofence: bool = True
    require_selfie: bool = False
    allowed_location_ids: list[str] = Field(default_factory=list)
    is_default: bool = False


class AttendancePolicyUpdate(BaseModel):
    name: str | None = None
    shift_start: datetime.time | None = None
    shift_end: datetime.time | None = None
    grace_minutes: int | None = None
    half_day_min_hours: float | None = None
    full_day_min_hours: float | None = None
    week_off_days: list[int] | None = None
    require_geofence: bool | None = None
    require_selfie: bool | None = None
    allowed_location_ids: list[str] | None = None
    is_default: bool | None = None
    is_active: bool | None = None


class AttendancePolicyResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    shift_start: datetime.time
    shift_end: datetime.time
    grace_minutes: int
    half_day_min_hours: float
    full_day_min_hours: float
    week_off_days: list[int]
    require_geofence: bool
    require_selfie: bool
    allowed_location_ids: list[str]
    is_default: bool
    is_active: bool
    created_at: datetime.datetime


class LeaveTypeCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=100)
    annual_quota: int = Field(default=0, ge=0)
    is_paid: bool = True
    carry_forward: bool = False


class LeaveTypeUpdate(BaseModel):
    name: str | None = None
    annual_quota: int | None = None
    is_paid: bool | None = None
    carry_forward: bool | None = None
    is_active: bool | None = None


class LeaveTypeResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    annual_quota: int
    is_paid: bool
    carry_forward: bool
    is_active: bool
    created_at: datetime.datetime


# ==============================================================================
# Tasks & Deliverables Master
# ==============================================================================
class TaskStatusCreate(BaseModel):
    code: str = Field(..., min_length=2, max_length=50)
    label: str = Field(..., min_length=2, max_length=100)
    order: int = Field(default=0)
    is_terminal: bool = False
    color: str = Field(default="#3B82F6", max_length=20)


class TaskStatusUpdate(BaseModel):
    label: str | None = None
    order: int | None = None
    is_terminal: bool | None = None
    color: str | None = None
    is_active: bool | None = None


class TaskStatusResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    order: int
    is_terminal: bool
    color: str
    is_active: bool
    created_at: datetime.datetime


class TaskPriorityCreate(BaseModel):
    code: str = Field(..., min_length=2, max_length=50)
    label: str = Field(..., min_length=2, max_length=100)
    weight: int = Field(default=1, ge=1)
    color: str = Field(default="#6B7280", max_length=20)


class TaskPriorityUpdate(BaseModel):
    label: str | None = None
    weight: int | None = None
    color: str | None = None
    is_active: bool | None = None


class TaskPriorityResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    weight: int
    color: str
    is_active: bool
    created_at: datetime.datetime


class TaskStatusTransitionCreate(BaseModel):
    from_status_id: uuid.UUID
    to_status_id: uuid.UUID
    required_permission: str | None = None


class TaskStatusTransitionResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    from_status_id: uuid.UUID
    to_status_id: uuid.UUID
    required_permission: str | None = None
    created_at: datetime.datetime


# ==============================================================================
# Clients & Projects
# ==============================================================================
class ClientCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=150)
    contact_person: str | None = None
    email: EmailStr | None = None
    phone: str | None = None
    address: str | None = None


class ClientUpdate(BaseModel):
    name: str | None = None
    contact_person: str | None = None
    email: EmailStr | None = None
    phone: str | None = None
    address: str | None = None
    is_active: bool | None = None


class ClientResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    contact_person: str | None = None
    email: str | None = None
    phone: str | None = None
    address: str | None = None
    is_active: bool
    created_at: datetime.datetime


class ProjectCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=150)
    client_id: uuid.UUID
    description: str | None = None
    code: str | None = None
    start_date: datetime.date | None = None
    end_date: datetime.date | None = None


class ProjectUpdate(BaseModel):
    name: str | None = None
    description: str | None = None
    client_id: uuid.UUID | None = None
    start_date: datetime.date | None = None
    end_date: datetime.date | None = None
    status: str | None = None
    is_active: bool | None = None


class ProjectResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    description: str | None = None
    client_id: uuid.UUID
    start_date: datetime.date | None = None
    end_date: datetime.date | None = None
    status: str = "active"
    is_active: bool
    created_at: datetime.datetime


# ==============================================================================
# Dynamic System Settings
# ==============================================================================
class SystemSettingCreateUpdate(BaseModel):
    key: str = Field(..., min_length=2, max_length=100)
    value: Any = Field(..., description="Arbitrary JSON-serializable value")
    description: str | None = None


class SystemSettingResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    key: str
    value: Any
    description: str | None = None
    updated_at: datetime.datetime


class AuditLogResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    actor_id: uuid.UUID | None = None
    action: str
    entity_type: str
    entity_id: str
    old_data: dict[str, Any] | None = None
    new_data: dict[str, Any] | None = None
    ip_address: str | None = None
    created_at: datetime.datetime


# ==============================================================================
# App Modules, Navigation & Public Runtime Config (Backend Addendum A1)
# ==============================================================================
class AppModuleCreate(BaseModel):
    code: str = Field(..., min_length=2, max_length=100, description="Unique module code")
    label: str = Field(..., min_length=2, max_length=150, description="Display label")
    icon_key: str = Field(..., min_length=1, max_length=100, description="Client icon key")
    route_key: str = Field(..., min_length=1, max_length=100, description="Client route key")
    sort_order: int = Field(default=0, description="Ascending sort order in navigation")
    required_permission: str | None = Field(
        default=None,
        max_length=100,
        description="Permission code required to see and access this module (null if open to all authenticated users)",
    )
    is_base: bool = Field(default=False, description="True if part of the base employee app")
    is_active: bool = Field(default=True, description="True if currently enabled")
    show_on_home: bool = Field(default=True, description="True if module tile appears on Home")
    description: str | None = Field(default=None, description="Module description")


class AppModuleUpdate(BaseModel):
    label: str | None = Field(default=None, min_length=2, max_length=150)
    icon_key: str | None = Field(default=None, min_length=1, max_length=100)
    route_key: str | None = Field(default=None, min_length=1, max_length=100)
    sort_order: int | None = None
    required_permission: str | None = Field(default=None, max_length=100)
    is_base: bool | None = None
    is_active: bool | None = None
    show_on_home: bool | None = None
    description: str | None = None


class AppModuleResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    icon_key: str
    route_key: str
    sort_order: int
    required_permission: str | None = None
    is_base: bool
    is_active: bool
    show_on_home: bool
    description: str | None = None
    created_at: datetime.datetime
    updated_at: datetime.datetime


class PasswordPolicySummary(BaseModel):
    min_length: int
    require_uppercase: bool
    require_lowercase: bool
    require_digit: bool
    require_special: bool


class AppRuntimeConfigResponse(BaseModel):
    app_timezone: str
    default_page_size: int
    max_page_size: int
    max_upload_mb: int
    allowed_upload_mime_types: list[str]
    min_supported_app_version: str
    force_update: bool
    navigation_refresh_interval_minutes: int
    password_policy: PasswordPolicySummary
    feature_flags: dict[str, Any] = Field(default_factory=dict)


class UserNavigationResponse(BaseModel):
    modules: list[AppModuleResponse] = Field(default_factory=list)
    permissions: list[str] = Field(default_factory=list)
    role_name: str
    role_label: str
    department_id: uuid.UUID | None = None
    department_name: str | None = None
    must_change_password: bool


class EffectiveAttendancePolicyResponse(BaseModel):
    id: uuid.UUID
    name: str
    shift_start: datetime.time
    shift_end: datetime.time
    grace_minutes: int
    half_day_min_hours: float
    full_day_min_hours: float
    week_off_days: list[int]
    require_geofence: bool
    require_selfie: bool
    allowed_locations: list[OfficeLocationResponse] = Field(default_factory=list)

