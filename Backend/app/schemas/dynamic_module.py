from __future__ import annotations

import datetime
import uuid
from typing import Any

from pydantic import BaseModel, ConfigDict, Field

# ---------------------------------------------------------------------------
# Module Fields
# ---------------------------------------------------------------------------

class ModuleFieldOption(BaseModel):
    value: str
    label: str
    color: str | None = None


class ModuleFieldBase(BaseModel):
    key: str = Field(..., max_length=50)
    label: str = Field(..., max_length=100)
    type: str = Field(
        ...,
        description=(
            "Data type: text, long_text, number, currency, date, datetime, "
            "phone, email, url, single_select, multi_select, boolean, file, "
            "image, user, client, project, geo_point"
        ),
    )
    is_required: bool = False
    is_list_visible: bool = True
    is_filterable: bool = False
    is_searchable: bool = False
    options: list[dict[str, Any]] | None = None
    validation: dict[str, Any] | None = None
    default_value: Any | None = None
    sort_order: int = 0
    section: str = "General"
    is_active: bool = True


class ModuleFieldCreate(ModuleFieldBase):
    pass


class ModuleFieldUpdate(BaseModel):
    label: str | None = None
    is_required: bool | None = None
    is_list_visible: bool | None = None
    is_filterable: bool | None = None
    is_searchable: bool | None = None
    options: list[dict[str, Any]] | None = None
    validation: dict[str, Any] | None = None
    default_value: Any | None = None
    sort_order: int | None = None
    section: str | None = None
    is_active: bool | None = None


class ModuleFieldResponse(ModuleFieldBase):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    module_id: uuid.UUID
    created_at: datetime.datetime
    updated_at: datetime.datetime


# ---------------------------------------------------------------------------
# Module Statuses & Transitions
# ---------------------------------------------------------------------------

class ModuleStatusBase(BaseModel):
    code: str = Field(..., max_length=50)
    label: str = Field(..., max_length=100)
    color: str = Field(default="#3B82F6", max_length=20)
    sort_order: int = 0
    is_terminal: bool = False
    required_permission: str | None = None
    is_active: bool = True


class ModuleStatusCreate(ModuleStatusBase):
    pass


class ModuleStatusUpdate(BaseModel):
    label: str | None = None
    color: str | None = None
    sort_order: int | None = None
    is_terminal: bool | None = None
    required_permission: str | None = None
    is_active: bool | None = None


class ModuleStatusResponse(ModuleStatusBase):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    module_id: uuid.UUID
    created_at: datetime.datetime
    updated_at: datetime.datetime


class ModuleStatusTransitionBase(BaseModel):
    from_status_id: uuid.UUID
    to_status_id: uuid.UUID
    required_permission: str | None = None


class ModuleStatusTransitionCreate(ModuleStatusTransitionBase):
    pass


class ModuleStatusTransitionResponse(ModuleStatusTransitionBase):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    module_id: uuid.UUID


# ---------------------------------------------------------------------------
# Module Definitions
# ---------------------------------------------------------------------------

class ModuleDefinitionBase(BaseModel):
    code: str = Field(..., max_length=50)
    label: str = Field(..., max_length=100)
    description: str | None = None
    record_label_singular: str = "Record"
    record_label_plural: str = "Records"
    is_active: bool = True


class ModuleDefinitionCreate(ModuleDefinitionBase):
    app_module_id: uuid.UUID | None = None
    fields: list[ModuleFieldCreate] = []
    statuses: list[ModuleStatusCreate] = []
    transitions: list[ModuleStatusTransitionCreate] = []


class ModuleDefinitionUpdate(BaseModel):
    label: str | None = None
    description: str | None = None
    record_label_singular: str | None = None
    record_label_plural: str | None = None
    is_active: bool | None = None
    app_module_id: uuid.UUID | None = None


class ModuleDefinitionResponse(ModuleDefinitionBase):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    app_module_id: uuid.UUID | None = None
    version: int = 1
    created_at: datetime.datetime
    updated_at: datetime.datetime
    fields: list[ModuleFieldResponse] = []
    statuses: list[ModuleStatusResponse] = []
    transitions: list[ModuleStatusTransitionResponse] = []


# ---------------------------------------------------------------------------
# Module Records
# ---------------------------------------------------------------------------

class ModuleRecordCreate(BaseModel):
    data: dict[str, Any] = Field(default_factory=dict)
    status_id: uuid.UUID | None = None
    assigned_to: uuid.UUID | None = None
    client_id: uuid.UUID | None = None
    due_at: datetime.datetime | None = None


class ModuleRecordUpdate(BaseModel):
    data: dict[str, Any] | None = None
    assigned_to: uuid.UUID | None = None
    client_id: uuid.UUID | None = None
    due_at: datetime.datetime | None = None


class ModuleRecordStatusChange(BaseModel):
    to_status_id: uuid.UUID
    note: str | None = None


class ModuleRecordResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    module_id: uuid.UUID
    data: dict[str, Any]
    status_id: uuid.UUID | None = None
    status: ModuleStatusResponse | None = None
    created_by: uuid.UUID
    creator_name: str | None = None
    assigned_to: uuid.UUID | None = None
    assignee_name: str | None = None
    client_id: uuid.UUID | None = None
    client_name: str | None = None
    due_at: datetime.datetime | None = None
    created_at: datetime.datetime
    updated_at: datetime.datetime
    allowed_transitions: list[ModuleStatusTransitionResponse] = []


class ModuleRecordCommentCreate(BaseModel):
    comment: str = Field(..., min_length=1)


class ModuleRecordCommentResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    record_id: uuid.UUID
    user_id: uuid.UUID
    user_name: str | None = None
    comment: str
    created_at: datetime.datetime


class ModuleRecordAttachmentCreate(BaseModel):
    file_url: str = Field(..., max_length=500)
    file_name: str = Field(..., max_length=255)
    file_size: int = 0
    mime_type: str | None = None


class ModuleRecordAttachmentResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    record_id: uuid.UUID
    user_id: uuid.UUID
    user_name: str | None = None
    file_url: str
    file_name: str
    file_size: int
    mime_type: str | None = None
    created_at: datetime.datetime


class ModuleRecordActivityResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    record_id: uuid.UUID
    user_id: uuid.UUID | None = None
    user_name: str | None = None
    action: str
    details: dict[str, Any] | None = None
    created_at: datetime.datetime


class ModuleRecordDetailResponse(ModuleRecordResponse):
    comments: list[ModuleRecordCommentResponse] = []
    attachments: list[ModuleRecordAttachmentResponse] = []
    activities: list[ModuleRecordActivityResponse] = []


class ModuleRecordPageResponse(BaseModel):
    items: list[ModuleRecordResponse]
    total: int
    page: int
    page_size: int
    total_pages: int


class ModuleSummaryResponse(BaseModel):
    total_records: int
    counts_by_status: dict[str, int]
    counts_by_assignee: list[dict[str, Any]]
    field_totals: dict[str, float]
