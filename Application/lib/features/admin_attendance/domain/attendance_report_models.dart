import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report_models.freezed.dart';
part 'attendance_report_models.g.dart';

@freezed
abstract class ReportEmployeeItem with _$ReportEmployeeItem {
  const factory ReportEmployeeItem({
    required String id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'department_name') String? departmentName,
    String? designation,
  }) = _ReportEmployeeItem;

  factory ReportEmployeeItem.fromJson(Map<String, dynamic> json) =>
      _$ReportEmployeeItemFromJson(json);
}

@freezed
abstract class AttendanceSummaryStatusCount
    with _$AttendanceSummaryStatusCount {
  const factory AttendanceSummaryStatusCount({
    @JsonKey(name: 'status_id') required String statusId,
    @JsonKey(name: 'status_name') required String statusName,
    @JsonKey(name: 'status_code') required String statusCode,
    @JsonKey(name: 'badge_color') required String badgeColor,
    required int count,
    @Default(<ReportEmployeeItem>[]) List<ReportEmployeeItem> employees,
  }) = _AttendanceSummaryStatusCount;

  factory AttendanceSummaryStatusCount.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryStatusCountFromJson(json);
}

@freezed
abstract class AttendanceTodayReportResponse
    with _$AttendanceTodayReportResponse {
  const factory AttendanceTodayReportResponse({
    required String date,
    @JsonKey(name: 'total_active_employees') required int totalActiveEmployees,
    @JsonKey(name: 'present_count') required int presentCount,
    @JsonKey(name: 'absent_count') required int absentCount,
    @JsonKey(name: 'late_count') required int lateCount,
    @JsonKey(name: 'half_day_count') required int halfDayCount,
    @JsonKey(name: 'on_leave_count') required int onLeaveCount,
    @JsonKey(name: 'status_breakdown')
    @Default(<AttendanceSummaryStatusCount>[])
    List<AttendanceSummaryStatusCount> statusBreakdown,
  }) = _AttendanceTodayReportResponse;

  factory AttendanceTodayReportResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceTodayReportResponseFromJson(json);
}

@freezed
abstract class AttendanceDayDetail with _$AttendanceDayDetail {
  const factory AttendanceDayDetail({
    required String date,
    @JsonKey(name: 'day_of_week') required String dayOfWeek,
    @JsonKey(name: 'is_working_day') required bool isWorkingDay,
    @JsonKey(name: 'is_holiday') required bool isHoliday,
    @JsonKey(name: 'holiday_name') String? holidayName,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'status_code') String? statusCode,
    @JsonKey(name: 'badge_color') String? badgeColor,
    @JsonKey(name: 'first_check_in') String? firstCheckIn,
    @JsonKey(name: 'last_check_out') String? lastCheckOut,
    @JsonKey(name: 'total_hours_worked') @Default(0.0) double totalHoursWorked,
    @JsonKey(name: 'overtime_hours') @Default(0.0) double overtimeHours,
    @JsonKey(name: 'is_late') @Default(false) bool isLate,
    @JsonKey(name: 'is_half_day') @Default(false) bool isHalfDay,
    @JsonKey(name: 'correction_applied') @Default(false) bool correctionApplied,
  }) = _AttendanceDayDetail;

  factory AttendanceDayDetail.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDayDetailFromJson(json);
}

@freezed
abstract class EmployeeMonthlyReportResponse
    with _$EmployeeMonthlyReportResponse {
  const factory EmployeeMonthlyReportResponse({
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    required int month,
    required int year,
    @JsonKey(name: 'total_days') required int totalDays,
    @JsonKey(name: 'working_days') required int workingDays,
    @JsonKey(name: 'present_days') required int presentDays,
    @JsonKey(name: 'absent_days') required int absentDays,
    @JsonKey(name: 'half_days') required int halfDays,
    @JsonKey(name: 'late_days') required int lateDays,
    @JsonKey(name: 'leave_days') required int leaveDays,
    @JsonKey(name: 'holiday_days') required int holidayDays,
    @JsonKey(name: 'week_off_days') required int weekOffDays,
    @JsonKey(name: 'total_hours_worked') required double totalHoursWorked,
    @JsonKey(name: 'average_hours_per_day') required double averageHoursPerDay,
    @JsonKey(name: 'attendance_percentage')
    required double attendancePercentage,
    @JsonKey(name: 'department_name') String? departmentName,
    String? designation,
    @JsonKey(name: 'daily_records')
    @Default(<AttendanceDayDetail>[])
    List<AttendanceDayDetail> dailyRecords,
  }) = _EmployeeMonthlyReportResponse;

  factory EmployeeMonthlyReportResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeMonthlyReportResponseFromJson(json);
}

@freezed
abstract class MonthSummaryItem with _$MonthSummaryItem {
  const factory MonthSummaryItem({
    required int month,
    @JsonKey(name: 'month_name') required String monthName,
    @JsonKey(name: 'working_days') required int workingDays,
    @JsonKey(name: 'present_days') required int presentDays,
    @JsonKey(name: 'absent_days') required int absentDays,
    @JsonKey(name: 'half_days') required int halfDays,
    @JsonKey(name: 'late_days') required int lateDays,
    @JsonKey(name: 'leave_days') required int leaveDays,
    @JsonKey(name: 'holiday_days') required int holidayDays,
    @JsonKey(name: 'attendance_percentage')
    required double attendancePercentage,
    @JsonKey(name: 'total_hours_worked') required double totalHoursWorked,
  }) = _MonthSummaryItem;

  factory MonthSummaryItem.fromJson(Map<String, dynamic> json) =>
      _$MonthSummaryItemFromJson(json);
}

@freezed
abstract class EmployeeYearlyReportResponse
    with _$EmployeeYearlyReportResponse {
  const factory EmployeeYearlyReportResponse({
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    required int year,
    @JsonKey(name: 'annual_working_days') required int annualWorkingDays,
    @JsonKey(name: 'annual_present_days') required int annualPresentDays,
    @JsonKey(name: 'annual_absent_days') required int annualAbsentDays,
    @JsonKey(name: 'annual_leave_days') required int annualLeaveDays,
    @JsonKey(name: 'annual_total_hours') required double annualTotalHours,
    @JsonKey(name: 'annual_attendance_percentage')
    required double annualAttendancePercentage,
    @JsonKey(name: 'department_name') String? departmentName,
    @Default(<MonthSummaryItem>[]) List<MonthSummaryItem> months,
  }) = _EmployeeYearlyReportResponse;

  factory EmployeeYearlyReportResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeYearlyReportResponseFromJson(json);
}

@freezed
abstract class MonthlyOverviewEmployeeRow with _$MonthlyOverviewEmployeeRow {
  const factory MonthlyOverviewEmployeeRow({
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'department_name') String? departmentName,
    String? designation,
    @Default(<String, String>{}) Map<String, String> days,
    @JsonKey(name: 'present_count') @Default(0) int presentCount,
    @JsonKey(name: 'absent_count') @Default(0) int absentCount,
    @JsonKey(name: 'half_day_count') @Default(0) int halfDayCount,
    @JsonKey(name: 'late_count') @Default(0) int lateCount,
    @JsonKey(name: 'leave_count') @Default(0) int leaveCount,
    @JsonKey(name: 'holiday_count') @Default(0) int holidayCount,
    @JsonKey(name: 'week_off_count') @Default(0) int weekOffCount,
    @JsonKey(name: 'total_hours') @Default(0.0) double totalHours,
    @JsonKey(name: 'attendance_percentage')
    @Default(0.0)
    double attendancePercentage,
  }) = _MonthlyOverviewEmployeeRow;

  factory MonthlyOverviewEmployeeRow.fromJson(Map<String, dynamic> json) =>
      _$MonthlyOverviewEmployeeRowFromJson(json);
}

@freezed
abstract class MonthlyOverviewResponse with _$MonthlyOverviewResponse {
  const factory MonthlyOverviewResponse({
    required int month,
    required int year,
    @JsonKey(name: 'total_employees') required int totalEmployees,
    @JsonKey(name: 'department_id') String? departmentId,
    @Default(<MonthlyOverviewEmployeeRow>[])
    List<MonthlyOverviewEmployeeRow> rows,
  }) = _MonthlyOverviewResponse;

  factory MonthlyOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$MonthlyOverviewResponseFromJson(json);
}

@freezed
abstract class AttendanceCorrectionRequest with _$AttendanceCorrectionRequest {
  const factory AttendanceCorrectionRequest({
    required String reason,
    @JsonKey(name: 'check_in_at') String? checkInAt,
    @JsonKey(name: 'check_out_at') String? checkOutAt,
    @JsonKey(name: 'status_id') String? statusId,
    String? remarks,
  }) = _AttendanceCorrectionRequest;

  factory AttendanceCorrectionRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCorrectionRequestFromJson(json);
}

@freezed
abstract class AttendanceCorrectionResponse
    with _$AttendanceCorrectionResponse {
  const factory AttendanceCorrectionResponse({
    required String id,
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'changed_by') required String changedBy,
    required String reason,
    required String status,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'old_value')
    @Default(<String, dynamic>{})
    Map<String, dynamic> oldValue,
    @JsonKey(name: 'new_value')
    @Default(<String, dynamic>{})
    Map<String, dynamic> newValue,
  }) = _AttendanceCorrectionResponse;

  factory AttendanceCorrectionResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCorrectionResponseFromJson(json);
}
