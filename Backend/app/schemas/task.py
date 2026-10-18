from __future__ import annotations

import datetime
import uuid
from typing import Any

from pydantic import BaseModel, ConfigDict, Field

from app.schemas.common import UserBriefResponse


# ==============================================================================
# Master Lookups
# ==============================================================================
class TaskStatusBriefResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    order: int
    is_terminal: bool
    color: str


class TaskPriorityBriefResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    weight: int
    color: str


class TaskAssigneeResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    user: UserBriefResponse
    assigned_at: datetime.datetime


# ==============================================================================
# Task Create & Update
# ==============================================================================
class TaskCreateRequest(BaseModel):
    title: str = Field(..., min_length=2, max_length=200)
    description: str | None = Field(default=None, max_length=2000)
    department_id: uuid.UUID | None = None
    client_id: uuid.UUID | None = None
    project_id: uuid.UUID | None = None
    priority_id: uuid.UUID
    status_id: uuid.UUID | None = None  # If None, defaults to lowest order non-terminal status
    due_at: datetime.datetime | None = None
    assignee_ids: list[uuid.UUID] = Field(default_factory=list)


class TaskUpdateRequest(BaseModel):
    title: str | None = Field(default=None, min_length=2, max_length=200)
    description: str | None = Field(default=None, max_length=2000)
    department_id: uuid.UUID | None = None
    client_id: uuid.UUID | None = None
    project_id: uuid.UUID | None = None
    priority_id: uuid.UUID | None = None
    due_at: datetime.datetime | None = None


class TaskAssignRequest(BaseModel):
    assignee_ids: list[uuid.UUID] = Field(..., min_length=1)
    replace: bool = Field(
        default=False,
        description="If True, replaces current assignees; if False, adds new assignees.",
    )


class TaskStatusTransitionRequest(BaseModel):
    to_status_id: uuid.UUID
    remarks: str | None = Field(default=None, max_length=500)


# ==============================================================================
# Comments & Attachments
# ==============================================================================
class TaskCommentCreate(BaseModel):
    comment: str = Field(..., min_length=1, max_length=2000)


class TaskCommentResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    task_id: uuid.UUID
    author: UserBriefResponse
    comment: str
    created_at: datetime.datetime


class TaskAttachmentResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    task_id: uuid.UUID
    file_name: str
    file_size_bytes: int
    mime_type: str
    download_url: str
    uploader: UserBriefResponse
    created_at: datetime.datetime


class TaskActivityResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    task_id: uuid.UUID
    action: str
    details: dict[str, Any]
    actor: UserBriefResponse
    created_at: datetime.datetime


# ==============================================================================
# Task Details & Responses
# ==============================================================================
class TaskResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    title: str
    description: str | None
    department_id: uuid.UUID | None
    department_name: str | None = None
    client_id: uuid.UUID | None
    client_name: str | None = None
    project_id: uuid.UUID | None
    project_name: str | None = None
    priority: TaskPriorityBriefResponse
    status: TaskStatusBriefResponse
    assigner: UserBriefResponse
    assignees: list[UserBriefResponse] = Field(default_factory=list)
    due_at: datetime.datetime | None
    completed_at: datetime.datetime | None
    is_overdue: bool = False
    is_active: bool
    created_at: datetime.datetime
    updated_at: datetime.datetime


class TaskDetailResponse(TaskResponse):
    comments_count: int = 0
    attachments_count: int = 0


# ==============================================================================
# Reports & Analytics
# ==============================================================================
class TaskReportItem(BaseModel):
    id: uuid.UUID | None
    name: str
    total_tasks: int
    completed_tasks: int
    pending_tasks: int
    overdue_tasks: int


class TaskSummaryReportsResponse(BaseModel):
    total_tasks: int
    completed_tasks: int
    pending_tasks: int
    overdue_tasks: int
    on_time_completion_rate: float
    by_employee: list[TaskReportItem]
    by_department: list[TaskReportItem]
    by_client: list[TaskReportItem]
