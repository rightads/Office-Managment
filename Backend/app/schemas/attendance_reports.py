from __future__ import annotations

import datetime
import uuid
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class ReportEmployeeItem(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    employee_code: str
    full_name: str
    email: str
    avatar_url: str | None = None
    department_name: str | None = None
    designation: str | None = None


class AttendanceSummaryStatusCount(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    status_id: uuid.UUID
    status_name: str
    status_code: str
    badge_color: str
    count: int
    employees: list[ReportEmployeeItem] = Field(default_factory=list)


class AttendanceTodayReportResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    date: datetime.date
    total_active_employees: int
    present_count: int
    absent_count: int
    late_count: int
    half_day_count: int
    on_leave_count: int
    status_breakdown: list[AttendanceSummaryStatusCount] = Field(default_factory=list)


class AttendanceDayDetail(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    date: datetime.date
    day_of_week: str
    is_working_day: bool
    is_holiday: bool
    holiday_name: str | None = None
    status_name: str | None = None
    status_code: str | None = None
    badge_color: str | None = None
    first_check_in: datetime.datetime | None = None
    last_check_out: datetime.datetime | None = None
    total_hours_worked: float = 0.0
    overtime_hours: float = 0.0
    is_late: bool = False
    is_half_day: bool = False
    correction_applied: bool = False


class EmployeeMonthlyReportResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    employee_id: uuid.UUID
    employee_name: str
    employee_code: str
    department_name: str | None = None
    designation: str | None = None
    month: int
    year: int
    total_days: int
    working_days: int
    present_days: int
    absent_days: int
    half_days: int
    late_days: int
    leave_days: int
    holiday_days: int
    week_off_days: int
    total_hours_worked: float
    average_hours_per_day: float
    attendance_percentage: float
    daily_records: list[AttendanceDayDetail] = Field(default_factory=list)


class MonthSummaryItem(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    month: int
    month_name: str
    working_days: int
    present_days: int
    absent_days: int
    half_days: int
    late_days: int
    leave_days: int
    holiday_days: int
    attendance_percentage: float
    total_hours_worked: float


class EmployeeYearlyReportResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    employee_id: uuid.UUID
    employee_name: str
    employee_code: str
    department_name: str | None = None
    year: int
    annual_working_days: int
    annual_present_days: int
    annual_absent_days: int
    annual_leave_days: int
    annual_total_hours: float
    annual_attendance_percentage: float
    months: list[MonthSummaryItem] = Field(default_factory=list)


class MonthlyOverviewEmployeeRow(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    employee_id: uuid.UUID
    employee_name: str
    employee_code: str
    department_name: str | None = None
    designation: str | None = None
    days: dict[int, str] = Field(default_factory=dict)  # day_number -> status_code
    present_count: int = 0
    absent_count: int = 0
    half_day_count: int = 0
    late_count: int = 0
    leave_count: int = 0
    holiday_count: int = 0
    week_off_count: int = 0
    total_hours: float = 0.0
    attendance_percentage: float = 0.0


class MonthlyOverviewResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    month: int
    year: int
    total_employees: int
    department_id: uuid.UUID | None = None
    rows: list[MonthlyOverviewEmployeeRow] = Field(default_factory=list)


ReportType = Literal["today", "employee_monthly", "employee_yearly", "monthly_overview"]
ExportFormat = Literal["excel", "pdf"]
