from __future__ import annotations

import datetime
import uuid

from pydantic import BaseModel, ConfigDict, Field


class WorkReportItemCreate(BaseModel):
    task_id: uuid.UUID | None = None
    client_id: uuid.UUID | None = None
    project_id: uuid.UUID | None = None
    category_id: uuid.UUID | None = None
    description: str = Field(..., min_length=2, max_length=2000)
    minutes_spent: int = Field(..., gt=0, description="Minutes spent on this item (must be > 0)")


class WorkReportItemResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    report_id: uuid.UUID
    task_id: uuid.UUID | None = None
    task_title: str | None = None
    client_id: uuid.UUID | None = None
    client_name: str | None = None
    project_id: uuid.UUID | None = None
    project_name: str | None = None
    category_id: uuid.UUID | None = None
    description: str
    minutes_spent: int
    created_at: datetime.datetime


class WorkReportCreate(BaseModel):
    report_date: datetime.date
    summary: str | None = Field(default=None, max_length=2000)
    items: list[WorkReportItemCreate] = Field(default_factory=list)


class WorkReportUpdate(BaseModel):
    summary: str | None = Field(default=None, max_length=2000)
    items: list[WorkReportItemCreate] | None = None


class WorkReportReviewRequest(BaseModel):
    review_note: str = Field(..., min_length=1, max_length=2000)
    status: str = Field(default="reviewed", pattern="^(reviewed|draft)$")


class WorkReportResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    user_id: uuid.UUID
    user_full_name: str | None = None
    user_employee_code: str | None = None
    department_id: uuid.UUID | None = None
    department_name: str | None = None
    report_date: datetime.date
    summary: str | None = None
    status: str
    total_minutes: int = 0
    submitted_at: datetime.datetime | None = None
    reviewed_by: uuid.UUID | None = None
    reviewer_name: str | None = None
    reviewed_at: datetime.datetime | None = None
    review_note: str | None = None
    items: list[WorkReportItemResponse] = Field(default_factory=list)
    created_at: datetime.datetime
    updated_at: datetime.datetime


class WorkReportPageResponse(BaseModel):
    items: list[WorkReportResponse]
    total: int
    page: int
    page_size: int
    total_pages: int


class MissingWorkReportUserResponse(BaseModel):
    user_id: uuid.UUID
    full_name: str
    employee_code: str
    email: str
    department_id: uuid.UUID | None = None
    department_name: str | None = None
    manager_name: str | None = None


class MissingWorkReportListResponse(BaseModel):
    report_date: datetime.date
    missing_count: int
    users: list[MissingWorkReportUserResponse]
