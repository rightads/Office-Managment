from __future__ import annotations

import datetime
import uuid

from pydantic import BaseModel, ConfigDict, EmailStr, Field


class EmployeeCreate(BaseModel):
    """Payload for administrative employee creation."""

    email: EmailStr = Field(..., description="Unique business email address")
    full_name: str = Field(..., min_length=2, max_length=150, description="Employee full name")
    role_id: uuid.UUID = Field(..., description="ID of assigned authorization role")
    department_id: uuid.UUID | None = Field(default=None, description="Department UUID")
    attendance_policy_id: uuid.UUID | None = Field(
        default=None, description="Assigned attendance policy UUID"
    )
    manager_id: uuid.UUID | None = Field(default=None, description="Reporting manager UUID")
    phone_number: str | None = Field(default=None, max_length=20, description="Contact phone")
    designation: str | None = Field(default=None, max_length=100, description="Job title")
    joining_date: datetime.date | None = Field(default=None, description="Employment start date")


class EmployeeUpdate(BaseModel):
    """Payload for administrative employee profile updates."""

    full_name: str | None = Field(
        default=None, min_length=2, max_length=150, description="Employee full name"
    )
    department_id: uuid.UUID | None = Field(default=None, description="Department UUID")
    attendance_policy_id: uuid.UUID | None = Field(
        default=None, description="Assigned attendance policy UUID"
    )
    manager_id: uuid.UUID | None = Field(default=None, description="Reporting manager UUID")
    phone_number: str | None = Field(default=None, max_length=20, description="Contact phone")
    designation: str | None = Field(default=None, max_length=100, description="Job title")
    avatar_url: str | None = Field(default=None, max_length=500, description="Profile photo URL")
    joining_date: datetime.date | None = Field(default=None, description="Employment start date")


class EmployeeSelfUpdate(BaseModel):
    """Self-service update payload restricted to whitelisted fields."""

    phone_number: str | None = Field(default=None, max_length=20, description="Contact phone")
    avatar_url: str | None = Field(default=None, max_length=500, description="Profile photo URL")


class EmployeeChangeRole(BaseModel):
    """Payload for changing an employee's role."""

    role_id: uuid.UUID = Field(..., description="Target role UUID")


class EmployeeAssignManager(BaseModel):
    """Payload for assigning or unassigning a reporting manager."""

    manager_id: uuid.UUID | None = Field(
        default=None, description="Reporting manager UUID or null to unassign"
    )


class EmployeeAssignPolicy(BaseModel):
    """Payload for assigning an attendance shift policy."""

    attendance_policy_id: uuid.UUID | None = Field(
        default=None, description="Attendance policy UUID or null to unassign"
    )


class EmployeeAdminResetPassword(BaseModel):
    """Administrative password reset payload."""

    new_password: str | None = Field(
        default=None,
        description="Optional explicit password; if omitted, a temporary one is generated",
    )


class EmployeeResponse(BaseModel):
    """Employee representation returned by list and detail endpoints."""

    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    employee_code: str
    email: str
    full_name: str
    phone_number: str | None = None
    designation: str | None = None
    avatar_url: str | None = None
    is_active: bool
    must_change_password: bool
    joining_date: datetime.date | None = None
    department_id: uuid.UUID | None = None
    department_name: str | None = None
    role_id: uuid.UUID
    role_name: str | None = None
    attendance_policy_id: uuid.UUID | None = None
    attendance_policy_name: str | None = None
    manager_id: uuid.UUID | None = None
    manager_name: str | None = None
    created_at: datetime.datetime


class EmployeeDetailResponse(EmployeeResponse):
    """Detailed employee representation including assigned permission codes."""

    permissions: list[str] = Field(default_factory=list, description="Resolved permission codes")
