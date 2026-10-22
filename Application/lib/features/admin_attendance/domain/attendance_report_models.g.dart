// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportEmployeeItem _$ReportEmployeeItemFromJson(Map<String, dynamic> json) =>
    _ReportEmployeeItem(
      id: json['id'] as String,
      employeeCode: json['employee_code'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      departmentName: json['department_name'] as String?,
      designation: json['designation'] as String?,
    );

Map<String, dynamic> _$ReportEmployeeItemToJson(_ReportEmployeeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_code': instance.employeeCode,
      'full_name': instance.fullName,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'department_name': instance.departmentName,
      'designation': instance.designation,
    };

_AttendanceSummaryStatusCount _$AttendanceSummaryStatusCountFromJson(
  Map<String, dynamic> json,
) => _AttendanceSummaryStatusCount(
  statusId: json['status_id'] as String,
  statusName: json['status_name'] as String,
  statusCode: json['status_code'] as String,
  badgeColor: json['badge_color'] as String,
  count: (json['count'] as num).toInt(),
  employees:
      (json['employees'] as List<dynamic>?)
          ?.map((e) => ReportEmployeeItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReportEmployeeItem>[],
);

Map<String, dynamic> _$AttendanceSummaryStatusCountToJson(
  _AttendanceSummaryStatusCount instance,
) => <String, dynamic>{
  'status_id': instance.statusId,
  'status_name': instance.statusName,
  'status_code': instance.statusCode,
  'badge_color': instance.badgeColor,
  'count': instance.count,
  'employees': instance.employees,
};

_AttendanceTodayReportResponse _$AttendanceTodayReportResponseFromJson(
  Map<String, dynamic> json,
) => _AttendanceTodayReportResponse(
  date: json['date'] as String,
  totalActiveEmployees: (json['total_active_employees'] as num).toInt(),
  presentCount: (json['present_count'] as num).toInt(),
  absentCount: (json['absent_count'] as num).toInt(),
  lateCount: (json['late_count'] as num).toInt(),
  halfDayCount: (json['half_day_count'] as num).toInt(),
  onLeaveCount: (json['on_leave_count'] as num).toInt(),
  statusBreakdown:
      (json['status_breakdown'] as List<dynamic>?)
          ?.map(
            (e) => AttendanceSummaryStatusCount.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const <AttendanceSummaryStatusCount>[],
);

Map<String, dynamic> _$AttendanceTodayReportResponseToJson(
  _AttendanceTodayReportResponse instance,
) => <String, dynamic>{
  'date': instance.date,
  'total_active_employees': instance.totalActiveEmployees,
  'present_count': instance.presentCount,
  'absent_count': instance.absentCount,
  'late_count': instance.lateCount,
  'half_day_count': instance.halfDayCount,
  'on_leave_count': instance.onLeaveCount,
  'status_breakdown': instance.statusBreakdown,
};

_AttendanceDayDetail _$AttendanceDayDetailFromJson(Map<String, dynamic> json) =>
    _AttendanceDayDetail(
      date: json['date'] as String,
      dayOfWeek: json['day_of_week'] as String,
      isWorkingDay: json['is_working_day'] as bool,
      isHoliday: json['is_holiday'] as bool,
      holidayName: json['holiday_name'] as String?,
      statusName: json['status_name'] as String?,
      statusCode: json['status_code'] as String?,
      badgeColor: json['badge_color'] as String?,
      firstCheckIn: json['first_check_in'] as String?,
      lastCheckOut: json['last_check_out'] as String?,
      totalHoursWorked: (json['total_hours_worked'] as num?)?.toDouble() ?? 0.0,
      overtimeHours: (json['overtime_hours'] as num?)?.toDouble() ?? 0.0,
      isLate: json['is_late'] as bool? ?? false,
      isHalfDay: json['is_half_day'] as bool? ?? false,
      correctionApplied: json['correction_applied'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendanceDayDetailToJson(
  _AttendanceDayDetail instance,
) => <String, dynamic>{
  'date': instance.date,
  'day_of_week': instance.dayOfWeek,
  'is_working_day': instance.isWorkingDay,
  'is_holiday': instance.isHoliday,
  'holiday_name': instance.holidayName,
  'status_name': instance.statusName,
  'status_code': instance.statusCode,
  'badge_color': instance.badgeColor,
  'first_check_in': instance.firstCheckIn,
  'last_check_out': instance.lastCheckOut,
  'total_hours_worked': instance.totalHoursWorked,
  'overtime_hours': instance.overtimeHours,
  'is_late': instance.isLate,
  'is_half_day': instance.isHalfDay,
  'correction_applied': instance.correctionApplied,
};

_EmployeeMonthlyReportResponse _$EmployeeMonthlyReportResponseFromJson(
  Map<String, dynamic> json,
) => _EmployeeMonthlyReportResponse(
  employeeId: json['employee_id'] as String,
  employeeName: json['employee_name'] as String,
  employeeCode: json['employee_code'] as String,
  departmentName: json['department_name'] as String?,
  designation: json['designation'] as String?,
  month: (json['month'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  totalDays: (json['total_days'] as num).toInt(),
  workingDays: (json['working_days'] as num).toInt(),
  presentDays: (json['present_days'] as num).toInt(),
  absentDays: (json['absent_days'] as num).toInt(),
  halfDays: (json['half_days'] as num).toInt(),
  lateDays: (json['late_days'] as num).toInt(),
  leaveDays: (json['leave_days'] as num).toInt(),
  holidayDays: (json['holiday_days'] as num).toInt(),
  weekOffDays: (json['week_off_days'] as num).toInt(),
  totalHoursWorked: (json['total_hours_worked'] as num).toDouble(),
  averageHoursPerDay: (json['average_hours_per_day'] as num).toDouble(),
  attendancePercentage: (json['attendance_percentage'] as num).toDouble(),
  dailyRecords:
      (json['daily_records'] as List<dynamic>?)
          ?.map((e) => AttendanceDayDetail.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AttendanceDayDetail>[],
);

Map<String, dynamic> _$EmployeeMonthlyReportResponseToJson(
  _EmployeeMonthlyReportResponse instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'employee_name': instance.employeeName,
  'employee_code': instance.employeeCode,
  'department_name': instance.departmentName,
  'designation': instance.designation,
  'month': instance.month,
  'year': instance.year,
  'total_days': instance.totalDays,
  'working_days': instance.workingDays,
  'present_days': instance.presentDays,
  'absent_days': instance.absentDays,
  'half_days': instance.halfDays,
  'late_days': instance.lateDays,
  'leave_days': instance.leaveDays,
  'holiday_days': instance.holidayDays,
  'week_off_days': instance.weekOffDays,
  'total_hours_worked': instance.totalHoursWorked,
  'average_hours_per_day': instance.averageHoursPerDay,
  'attendance_percentage': instance.attendancePercentage,
  'daily_records': instance.dailyRecords,
};

_MonthSummaryItem _$MonthSummaryItemFromJson(Map<String, dynamic> json) =>
    _MonthSummaryItem(
      month: (json['month'] as num).toInt(),
      monthName: json['month_name'] as String,
      workingDays: (json['working_days'] as num).toInt(),
      presentDays: (json['present_days'] as num).toInt(),
      absentDays: (json['absent_days'] as num).toInt(),
      halfDays: (json['half_days'] as num).toInt(),
      lateDays: (json['late_days'] as num).toInt(),
      leaveDays: (json['leave_days'] as num).toInt(),
      holidayDays: (json['holiday_days'] as num).toInt(),
      attendancePercentage: (json['attendance_percentage'] as num).toDouble(),
      totalHoursWorked: (json['total_hours_worked'] as num).toDouble(),
    );

Map<String, dynamic> _$MonthSummaryItemToJson(_MonthSummaryItem instance) =>
    <String, dynamic>{
      'month': instance.month,
      'month_name': instance.monthName,
      'working_days': instance.workingDays,
      'present_days': instance.presentDays,
      'absent_days': instance.absentDays,
      'half_days': instance.halfDays,
      'late_days': instance.lateDays,
      'leave_days': instance.leaveDays,
      'holiday_days': instance.holidayDays,
      'attendance_percentage': instance.attendancePercentage,
      'total_hours_worked': instance.totalHoursWorked,
    };

_EmployeeYearlyReportResponse _$EmployeeYearlyReportResponseFromJson(
  Map<String, dynamic> json,
) => _EmployeeYearlyReportResponse(
  employeeId: json['employee_id'] as String,
  employeeName: json['employee_name'] as String,
  employeeCode: json['employee_code'] as String,
  departmentName: json['department_name'] as String?,
  year: (json['year'] as num).toInt(),
  annualWorkingDays: (json['annual_working_days'] as num).toInt(),
  annualPresentDays: (json['annual_present_days'] as num).toInt(),
  annualAbsentDays: (json['annual_absent_days'] as num).toInt(),
  annualLeaveDays: (json['annual_leave_days'] as num).toInt(),
  annualTotalHours: (json['annual_total_hours'] as num).toDouble(),
  annualAttendancePercentage: (json['annual_attendance_percentage'] as num)
      .toDouble(),
  months:
      (json['months'] as List<dynamic>?)
          ?.map((e) => MonthSummaryItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MonthSummaryItem>[],
);

Map<String, dynamic> _$EmployeeYearlyReportResponseToJson(
  _EmployeeYearlyReportResponse instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'employee_name': instance.employeeName,
  'employee_code': instance.employeeCode,
  'department_name': instance.departmentName,
  'year': instance.year,
  'annual_working_days': instance.annualWorkingDays,
  'annual_present_days': instance.annualPresentDays,
  'annual_absent_days': instance.annualAbsentDays,
  'annual_leave_days': instance.annualLeaveDays,
  'annual_total_hours': instance.annualTotalHours,
  'annual_attendance_percentage': instance.annualAttendancePercentage,
  'months': instance.months,
};

_MonthlyOverviewEmployeeRow _$MonthlyOverviewEmployeeRowFromJson(
  Map<String, dynamic> json,
) => _MonthlyOverviewEmployeeRow(
  employeeId: json['employee_id'] as String,
  employeeName: json['employee_name'] as String,
  employeeCode: json['employee_code'] as String,
  departmentName: json['department_name'] as String?,
  designation: json['designation'] as String?,
  days:
      (json['days'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  presentCount: (json['present_count'] as num?)?.toInt() ?? 0,
  absentCount: (json['absent_count'] as num?)?.toInt() ?? 0,
  halfDayCount: (json['half_day_count'] as num?)?.toInt() ?? 0,
  lateCount: (json['late_count'] as num?)?.toInt() ?? 0,
  leaveCount: (json['leave_count'] as num?)?.toInt() ?? 0,
  holidayCount: (json['holiday_count'] as num?)?.toInt() ?? 0,
  weekOffCount: (json['week_off_count'] as num?)?.toInt() ?? 0,
  totalHours: (json['total_hours'] as num?)?.toDouble() ?? 0.0,
  attendancePercentage:
      (json['attendance_percentage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$MonthlyOverviewEmployeeRowToJson(
  _MonthlyOverviewEmployeeRow instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'employee_name': instance.employeeName,
  'employee_code': instance.employeeCode,
  'department_name': instance.departmentName,
  'designation': instance.designation,
  'days': instance.days,
  'present_count': instance.presentCount,
  'absent_count': instance.absentCount,
  'half_day_count': instance.halfDayCount,
  'late_count': instance.lateCount,
  'leave_count': instance.leaveCount,
  'holiday_count': instance.holidayCount,
  'week_off_count': instance.weekOffCount,
  'total_hours': instance.totalHours,
  'attendance_percentage': instance.attendancePercentage,
};

_MonthlyOverviewResponse _$MonthlyOverviewResponseFromJson(
  Map<String, dynamic> json,
) => _MonthlyOverviewResponse(
  month: (json['month'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  totalEmployees: (json['total_employees'] as num).toInt(),
  departmentId: json['department_id'] as String?,
  rows:
      (json['rows'] as List<dynamic>?)
          ?.map(
            (e) =>
                MonthlyOverviewEmployeeRow.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <MonthlyOverviewEmployeeRow>[],
);

Map<String, dynamic> _$MonthlyOverviewResponseToJson(
  _MonthlyOverviewResponse instance,
) => <String, dynamic>{
  'month': instance.month,
  'year': instance.year,
  'total_employees': instance.totalEmployees,
  'department_id': instance.departmentId,
  'rows': instance.rows,
};

_AttendanceCorrectionRequest _$AttendanceCorrectionRequestFromJson(
  Map<String, dynamic> json,
) => _AttendanceCorrectionRequest(
  reason: json['reason'] as String,
  checkInAt: json['check_in_at'] as String?,
  checkOutAt: json['check_out_at'] as String?,
  statusId: json['status_id'] as String?,
  remarks: json['remarks'] as String?,
);

Map<String, dynamic> _$AttendanceCorrectionRequestToJson(
  _AttendanceCorrectionRequest instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'check_in_at': instance.checkInAt,
  'check_out_at': instance.checkOutAt,
  'status_id': instance.statusId,
  'remarks': instance.remarks,
};

_AttendanceCorrectionResponse _$AttendanceCorrectionResponseFromJson(
  Map<String, dynamic> json,
) => _AttendanceCorrectionResponse(
  id: json['id'] as String,
  attendanceId: json['attendance_id'] as String,
  changedBy: json['changed_by'] as String,
  oldValue:
      json['old_value'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  newValue:
      json['new_value'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  reason: json['reason'] as String,
  status: json['status'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$AttendanceCorrectionResponseToJson(
  _AttendanceCorrectionResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'attendance_id': instance.attendanceId,
  'changed_by': instance.changedBy,
  'old_value': instance.oldValue,
  'new_value': instance.newValue,
  'reason': instance.reason,
  'status': instance.status,
  'created_at': instance.createdAt,
};
