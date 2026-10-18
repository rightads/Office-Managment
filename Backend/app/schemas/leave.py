from __future__ import annotations

import datetime
import uuid
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class LeaveTypeResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str
    annual_quota: int
    is_paid: bool
    carry_forward: bool
    max_carry_forward: int
    is_active: bool


class LeaveBalanceResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    user_id: uuid.UUID
    leave_type_id: uuid.UUID
    leave_type_name: str
    year: int
    allocated: float
    carried_forward: float
    used: float
    available: float


class LeaveApplyRequest(BaseModel):
    leave_type_id: uuid.UUID = Field(..., description="ID of the leave type being requested")
    from_date: datetime.date = Field(..., description="Start date of leave (inclusive)")
    to_date: datetime.date = Field(..., description="End date of leave (inclusive)")
    is_half_day: bool = Field(default=False, description="Flag for single-day half day leave")
    half_day_session: Literal["first_half", "second_half"] | None = Field(
        default=None, description="Half day session: 'first_half' or 'second_half'"
    )
    reason: str = Field(..., min_length=3, max_length=500, description="Reason for leave request")


class LeavePreviewRequest(BaseModel):
    leave_type_id: uuid.UUID | None = Field(default=None, description="Optional ID of the leave type")
    from_date: datetime.date = Field(..., description="Start date of leave (inclusive)")
    to_date: datetime.date = Field(..., description="End date of leave (inclusive)")
    is_half_day: bool = Field(default=False, description="Flag for single-day half day leave")
    half_day_session: Literal["first_half", "second_half"] | None = Field(
        default=None, description="Half day session: 'first_half' or 'second_half'"
    )


class LeavePreviewResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    from_date: datetime.date
    to_date: datetime.date
    is_half_day: bool
    half_day_session: str | None = None
    working_days: float
    is_valid: bool
    validation_error: str | None = None
    available_balance: float | None = None
    has_overlap: bool = False
    overlapping_request_id: uuid.UUID | None = None



class LeaveReviewRequest(BaseModel):
    review_note: str | None = Field(
        default=None, max_length=500, description="Optional review/approval note"
    )


class LeaveRejectRequest(BaseModel):
    review_note: str = Field(
        ..., min_length=3, max_length=500, description="Mandatory reason for rejection"
    )


class LeaveRequestResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    user_id: uuid.UUID
    user_full_name: str
    employee_code: str
    department_name: str | None = None
    leave_type_id: uuid.UUID
    leave_type_name: str
    from_date: datetime.date
    to_date: datetime.date
    is_half_day: bool
    half_day_session: str | None
    total_days: float
    reason: str
    status: str
    reviewed_by: uuid.UUID | None = None
    reviewer_name: str | None = None
    reviewed_at: datetime.datetime | None = None
    review_note: str | None = None
    created_at: datetime.datetime


class LeaveRequestListResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    items: list[LeaveRequestResponse]
    total: int
    page: int
    size: int
    pages: int


class AllocateAnnualBalancesRequest(BaseModel):
    year: int = Field(..., ge=2000, le=2100, description="Target calendar year for allocation")


class AnnualAllocationResultResponse(BaseModel):
    year: int
    users_processed: int
    balances_created: int
    balances_updated: int
