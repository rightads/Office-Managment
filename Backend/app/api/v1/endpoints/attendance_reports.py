from __future__ import annotations

import uuid
from typing import Any

from fastapi import APIRouter, Depends, Query
from fastapi.responses import StreamingResponse
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import BadRequestException
from app.dependencies.auth import (
    get_current_active_user,
    require_any_permissions,
)
from app.dependencies.database import get_db
from app.models.user import User
from app.schemas.attendance_reports import (
    AttendanceTodayReportResponse,
    EmployeeMonthlyReportResponse,
    EmployeeYearlyReportResponse,
    ExportFormat,
    MonthlyOverviewResponse,
    ReportType,
)
from app.services.attendance_export_service import AttendanceExportService
from app.services.attendance_report_service import AttendanceReportService
from app.utils.timezone import get_local_today

router = APIRouter(prefix="/reports/attendance", tags=["Attendance Reports & Exports"])


@router.get(
    "/today",
    response_model=AttendanceTodayReportResponse,
    summary="Live Today Attendance Dashboard",
    description="Real-time count of active employees across attendance statuses with employee lists.",
)
async def get_today_dashboard(
    department_id: uuid.UUID | None = Query(None, description="Optional department filter"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(
        require_any_permissions("attendance.view_all", "attendance.view_team")
    ),
) -> AttendanceTodayReportResponse:
    service = AttendanceReportService(db)
    return await service.get_today_dashboard(current_user=current_user, department_id=department_id)


@router.get(
    "/employee/{id}/monthly",
    response_model=EmployeeMonthlyReportResponse,
    summary="Individual Employee Monthly Attendance Calendar",
    description="Full monthly breakdown with working days, hours worked, overtime, and daily status details.",
)
async def get_employee_monthly(
    id: uuid.UUID,
    month: int = Query(..., ge=1, le=12, description="Target month (1-12)"),
    year: int = Query(..., ge=2000, le=2100, description="Target year (e.g. 2026)"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(
        require_any_permissions(
            "attendance.view_all", "attendance.view_team", "attendance.view_own"
        )
    ),
) -> EmployeeMonthlyReportResponse:
    service = AttendanceReportService(db)
    return await service.get_employee_monthly(
        current_user=current_user,
        employee_id=id,
        month=month,
        year=year,
    )


@router.get(
    "/employee/{id}/yearly",
    response_model=EmployeeYearlyReportResponse,
    summary="Individual Employee 12-Month Attendance Breakdown",
    description="Annual performance metrics, total hours worked, and month-by-month attendance statistics.",
)
async def get_employee_yearly(
    id: uuid.UUID,
    year: int = Query(..., ge=2000, le=2100, description="Target year (e.g. 2026)"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(
        require_any_permissions(
            "attendance.view_all", "attendance.view_team", "attendance.view_own"
        )
    ),
) -> EmployeeYearlyReportResponse:
    service = AttendanceReportService(db)
    return await service.get_employee_yearly(
        current_user=current_user,
        employee_id=id,
        year=year,
    )


@router.get(
    "/monthly-overview",
    response_model=MonthlyOverviewResponse,
    summary="Organization Monthly Attendance Matrix",
    description="Matrix of all employees with daily status codes and aggregate attendance totals.",
)
async def get_monthly_overview(
    month: int = Query(..., ge=1, le=12, description="Target month (1-12)"),
    year: int = Query(..., ge=2000, le=2100, description="Target year (e.g. 2026)"),
    department_id: uuid.UUID | None = Query(None, description="Optional department filter"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(
        require_any_permissions("attendance.view_all", "attendance.view_team")
    ),
) -> MonthlyOverviewResponse:
    service = AttendanceReportService(db)
    return await service.get_monthly_overview(
        current_user=current_user,
        month=month,
        year=year,
        department_id=department_id,
    )


@router.get(
    "/export",
    summary="Export Attendance Reports to Excel or PDF",
    description="Generate and stream formatted Excel (.xlsx) or PDF (.pdf) attendance reports.",
)
async def export_attendance_report(
    report_type: ReportType = Query(
        ...,
        description="Type of report: 'today', 'employee_monthly', 'employee_yearly', or 'monthly_overview'",
    ),
    format: ExportFormat = Query(..., description="Export format: 'excel' or 'pdf'"),
    month: int | None = Query(None, ge=1, le=12, description="Required for monthly reports"),
    year: int | None = Query(
        None, ge=2000, le=2100, description="Required for monthly and yearly reports"
    ),
    employee_id: uuid.UUID | None = Query(
        None, description="Required for employee-specific reports"
    ),
    department_id: uuid.UUID | None = Query(None, description="Optional department filter"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_active_user),
) -> StreamingResponse:
    service = AttendanceReportService(db)
    data: Any = None

    # Validate parameters per report_type
    if report_type == "today":
        data = await service.get_today_dashboard(
            current_user=current_user,
            department_id=department_id,
        )
        file_suffix = get_local_today().isoformat()
    elif report_type == "employee_monthly":
        if not employee_id:
            raise BadRequestException(
                "employee_id query parameter is required for employee_monthly export."
            )
        if not month or not year:
            raise BadRequestException(
                "month and year query parameters are required for employee_monthly export."
            )
        data = await service.get_employee_monthly(
            current_user=current_user,
            employee_id=employee_id,
            month=month,
            year=year,
        )
        file_suffix = f"{employee_id}_{year}_{month:02d}"
    elif report_type == "employee_yearly":
        if not employee_id:
            raise BadRequestException(
                "employee_id query parameter is required for employee_yearly export."
            )
        if not year:
            raise BadRequestException(
                "year query parameter is required for employee_yearly export."
            )
        data = await service.get_employee_yearly(
            current_user=current_user,
            employee_id=employee_id,
            year=year,
        )
        file_suffix = f"{employee_id}_{year}"
    elif report_type == "monthly_overview":
        if not month or not year:
            raise BadRequestException(
                "month and year query parameters are required for monthly_overview export."
            )
        data = await service.get_monthly_overview(
            current_user=current_user,
            month=month,
            year=year,
            department_id=department_id,
        )
        file_suffix = f"overview_{year}_{month:02d}"
    else:
        raise BadRequestException(f"Unsupported report_type: {report_type}")

    if format == "excel":
        stream = AttendanceExportService.generate_excel(report_type, data)
        media_type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        filename = f"attendance_{report_type}_{file_suffix}.xlsx"
    elif format == "pdf":
        stream = AttendanceExportService.generate_pdf(report_type, data)
        media_type = "application/pdf"
        filename = f"attendance_{report_type}_{file_suffix}.pdf"
    else:
        raise BadRequestException(f"Unsupported format: {format}")

    headers = {
        "Content-Disposition": f'attachment; filename="{filename}"',
        "Access-Control-Expose-Headers": "Content-Disposition",
    }
    return StreamingResponse(stream, media_type=media_type, headers=headers)
