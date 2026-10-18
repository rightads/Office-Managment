from __future__ import annotations

import datetime
import uuid
from typing import Any

from pydantic import BaseModel, ConfigDict, Field


class CheckInRequest(BaseModel):
    latitude: float = Field(..., ge=-90.0, le=90.0, description="WGS84 latitude")
    longitude: float = Field(..., ge=-180.0, le=180.0, description="WGS84 longitude")
    device_id: str = Field(
        ..., min_length=2, max_length=100, description="Client hardware/app device ID"
    )
    is_mock_location: bool = Field(
        default=False, description="Flag indicating spoofed/mock GPS location"
    )
    selfie_url: str | None = Field(default=None, description="Uploaded selfie URL (if required)")


class CheckOutRequest(BaseModel):
    latitude: float = Field(..., ge=-90.0, le=90.0, description="WGS84 latitude")
    longitude: float = Field(..., ge=-180.0, le=180.0, description="WGS84 longitude")
    device_id: str = Field(
        ..., min_length=2, max_length=100, description="Client hardware/app device ID"
    )
    is_mock_location: bool = Field(
        default=False, description="Flag indicating spoofed/mock GPS location"
    )
    remarks: str | None = Field(
        default=None, max_length=500, description="Optional checkout remarks"
    )


class AttendanceStatusBrief(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    code: str
    label: str
    counts_as_present: bool
    color: str


class AttendanceRecordResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    user_id: uuid.UUID
    date: datetime.date
    check_in_at: datetime.datetime | None
    check_out_at: datetime.datetime | None
    check_in_lat: float | None
    check_in_lng: float | None
    check_out_lat: float | None
    check_out_lng: float | None
    check_in_selfie_url: str | None
    status: AttendanceStatusBrief
    total_minutes: int
    is_manual: bool
    source: str | None
    device_id: str | None
    remarks: str | None
    created_at: datetime.datetime


class AttendanceTodayResponse(BaseModel):
    date: datetime.date
    has_checked_in: bool
    has_checked_out: bool
    record: AttendanceRecordResponse | None = None
    policy_name: str | None = None
    shift_start: str | None = None
    shift_end: str | None = None


class AttendanceCalendarDay(BaseModel):
    date: datetime.date
    day_of_week: int  # 0=Monday, 6=Sunday
    is_weekend: bool
    is_holiday: bool
    holiday_name: str | None = None
    is_week_off: bool
    is_leave: bool
    leave_type_name: str | None = None
    status_code: str | None = None
    status_label: str | None = None
    status_color: str | None = None
    check_in_at: datetime.datetime | None = None
    check_out_at: datetime.datetime | None = None
    total_minutes: int = 0


class AttendanceCalendarResponse(BaseModel):
    year: int
    month: int
    total_working_days: int
    total_present_days: float
    total_absent_days: int
    total_half_days: int
    total_leave_days: int
    total_holidays: int
    days: list[AttendanceCalendarDay]


class AttendanceCorrectionRequest(BaseModel):
    check_in_at: datetime.datetime | None = None
    check_out_at: datetime.datetime | None = None
    status_id: uuid.UUID | None = None
    remarks: str | None = None
    reason: str = Field(
        ..., min_length=5, max_length=500, description="Mandatory reason for manual override"
    )


class AttendanceCorrectionResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    attendance_id: uuid.UUID
    changed_by: uuid.UUID
    old_value: dict[str, Any]
    new_value: dict[str, Any]
    reason: str
    status: str
    created_at: datetime.datetime


class DeviceResetResponse(BaseModel):
    user_id: uuid.UUID
    message: str
