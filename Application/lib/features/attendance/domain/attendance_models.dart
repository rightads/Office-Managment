import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_models.freezed.dart';
part 'attendance_models.g.dart';

/// Allowed office location returned inside `GET /api/v1/me/attendance-policy`.
@freezed
abstract class OfficeLocationModel with _$OfficeLocationModel {
  const factory OfficeLocationModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    String? address,
    @JsonKey(name: 'radius_meters') @Default(100) int radiusMeters,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _OfficeLocationModel;

  factory OfficeLocationModel.fromJson(Map<String, dynamic> json) =>
      _$OfficeLocationModelFromJson(json);
}

/// Effective attendance policy returned by `GET /api/v1/me/attendance-policy`.
///
/// Drives whether geofence verification (`requireGeofence`) and selfie capture
/// (`requireSelfie`) are required at check-in/check-out. Never inspect user
/// roles in the client to make these decisions.
@freezed
abstract class EffectiveAttendancePolicyModel
    with _$EffectiveAttendancePolicyModel {
  const factory EffectiveAttendancePolicyModel({
    required String id,
    required String name,
    @JsonKey(name: 'shift_start') @Default('09:30:00') String shiftStart,
    @JsonKey(name: 'shift_end') @Default('18:30:00') String shiftEnd,
    @JsonKey(name: 'grace_minutes') @Default(15) int graceMinutes,
    @JsonKey(name: 'half_day_min_hours') @Default(4.0) double halfDayMinHours,
    @JsonKey(name: 'full_day_min_hours') @Default(8.0) double fullDayMinHours,
    @JsonKey(name: 'week_off_days') @Default(<int>[6]) List<int> weekOffDays,
    @JsonKey(name: 'require_geofence') @Default(true) bool requireGeofence,
    @JsonKey(name: 'require_selfie') @Default(false) bool requireSelfie,
    @JsonKey(name: 'allowed_locations')
    @Default(<OfficeLocationModel>[])
    List<OfficeLocationModel> allowedLocations,
  }) = _EffectiveAttendancePolicyModel;

  factory EffectiveAttendancePolicyModel.fromJson(Map<String, dynamic> json) =>
      _$EffectiveAttendancePolicyModelFromJson(json);
}

/// Attendance record returned by `GET /api/v1/attendance/today`,
/// `POST /api/v1/attendance/check-in`, and `POST /api/v1/attendance/check-out`.
@freezed
abstract class AttendanceRecordModel with _$AttendanceRecordModel {
  const factory AttendanceRecordModel({
    required String id,
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'attendance_date') required String attendanceDate,
    required String status,
    @JsonKey(name: 'status_label') required String statusLabel,
    @JsonKey(name: 'status_color') required String statusColor,
    @JsonKey(name: 'check_in_at') DateTime? checkInAt,
    @JsonKey(name: 'check_out_at') DateTime? checkOutAt,
    @JsonKey(name: 'check_in_lat') double? checkInLat,
    @JsonKey(name: 'check_in_lng') double? checkInLng,
    @JsonKey(name: 'check_out_lat') double? checkOutLat,
    @JsonKey(name: 'check_out_lng') double? checkOutLng,
    @JsonKey(name: 'device_id') String? deviceId,
    @JsonKey(name: 'is_manual') @Default(false) bool isManual,
    @JsonKey(name: 'work_hours') double? workHours,
    String? remarks,
    @JsonKey(name: 'selfie_url') String? selfieUrl,
  }) = _AttendanceRecordModel;

  const AttendanceRecordModel._();

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordModelFromJson(json);

  /// True when the employee has checked in today and has not yet checked out.
  bool get isCurrentlyCheckedIn => checkInAt != null && checkOutAt == null;

  /// True when both check-in and check-out have been recorded for today.
  bool get isCompletedForToday => checkInAt != null && checkOutAt != null;
}

/// Request payload for `POST /api/v1/attendance/check-in`.
///
/// Never includes a client timestamp; the server records UTC check-in time.
@freezed
abstract class CheckInRequestPayload with _$CheckInRequestPayload {
  const factory CheckInRequestPayload({
    required double latitude,
    required double longitude,
    @JsonKey(name: 'device_id') required String deviceId,
    @JsonKey(name: 'is_mock_location') @Default(false) bool isMockLocation,
    @JsonKey(name: 'selfie_url', includeIfNull: false) String? selfieUrl,
  }) = _CheckInRequestPayload;

  factory CheckInRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestPayloadFromJson(json);
}

/// Request payload for `POST /api/v1/attendance/check-out`.
///
/// Never includes a client timestamp; the server records UTC check-out time.
@freezed
abstract class CheckOutRequestPayload with _$CheckOutRequestPayload {
  const factory CheckOutRequestPayload({
    required double latitude,
    required double longitude,
    @JsonKey(name: 'device_id') required String deviceId,
    @JsonKey(name: 'is_mock_location') @Default(false) bool isMockLocation,
    @JsonKey(includeIfNull: false) String? remarks,
  }) = _CheckOutRequestPayload;

  factory CheckOutRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$CheckOutRequestPayloadFromJson(json);
}

/// Single day entry in `GET /api/v1/attendance/me` (`AttendanceCalendarResponse`).
@freezed
abstract class AttendanceCalendarDayModel with _$AttendanceCalendarDayModel {
  const factory AttendanceCalendarDayModel({
    required String date,
    required String status,
    @JsonKey(name: 'status_label') required String statusLabel,
    @JsonKey(name: 'status_color') required String statusColor,
    @JsonKey(name: 'check_in_at') DateTime? checkInAt,
    @JsonKey(name: 'check_out_at') DateTime? checkOutAt,
    @JsonKey(name: 'work_hours') double? workHours,
    @JsonKey(name: 'is_manual') @Default(false) bool isManual,
    @JsonKey(name: 'holiday_name') String? holidayName,
    @JsonKey(name: 'leave_type_name') String? leaveTypeName,
  }) = _AttendanceCalendarDayModel;

  factory AttendanceCalendarDayModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCalendarDayModelFromJson(json);
}

/// Monthly calendar response from `GET /api/v1/attendance/me`.
@freezed
abstract class AttendanceCalendarModel with _$AttendanceCalendarModel {
  const factory AttendanceCalendarModel({
    required int year,
    required int month,
    @JsonKey(name: 'total_working_days') @Default(0) int totalWorkingDays,
    @JsonKey(name: 'total_present_days') @Default(0) int totalPresentDays,
    @JsonKey(name: 'total_absent_days') @Default(0) int totalAbsentDays,
    @JsonKey(name: 'total_half_days') @Default(0) int totalHalfDays,
    @JsonKey(name: 'total_leave_days') @Default(0) int totalLeaveDays,
    @JsonKey(name: 'total_holidays') @Default(0) int totalHolidays,
    @Default(<AttendanceCalendarDayModel>[])
    List<AttendanceCalendarDayModel> days,
  }) = _AttendanceCalendarModel;

  factory AttendanceCalendarModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCalendarModelFromJson(json);
}

/// Enriched daily record from `GET /api/v1/reports/attendance/employee/{id}/monthly`.
@freezed
abstract class DailyAttendanceRecordModel with _$DailyAttendanceRecordModel {
  const factory DailyAttendanceRecordModel({
    required String date,
    required String status,
    @JsonKey(name: 'status_label') required String statusLabel,
    @JsonKey(name: 'status_color') required String statusColor,
    @JsonKey(name: 'check_in_at') DateTime? checkInAt,
    @JsonKey(name: 'check_out_at') DateTime? checkOutAt,
    @JsonKey(name: 'work_hours') double? workHours,
    @JsonKey(name: 'is_manual') @Default(false) bool isManual,
    @JsonKey(name: 'correction_applied') @Default(false) bool correctionApplied,
    String? remarks,
    @JsonKey(name: 'holiday_name') String? holidayName,
    @JsonKey(name: 'leave_type_name') String? leaveTypeName,
  }) = _DailyAttendanceRecordModel;

  factory DailyAttendanceRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DailyAttendanceRecordModelFromJson(json);
}

/// Detailed monthly attendance report from
/// `GET /api/v1/reports/attendance/employee/{id}/monthly`.
@freezed
abstract class EmployeeMonthlyReportModel with _$EmployeeMonthlyReportModel {
  const factory EmployeeMonthlyReportModel({
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'full_name') required String fullName,
    required int year,
    required int month,
    @JsonKey(name: 'department_name') String? departmentName,
    String? designation,
    @JsonKey(name: 'total_days_in_month') @Default(0) int totalDaysInMonth,
    @JsonKey(name: 'working_days') @Default(0) int workingDays,
    @JsonKey(name: 'present_days') @Default(0) int presentDays,
    @JsonKey(name: 'late_days') @Default(0) int lateDays,
    @JsonKey(name: 'half_days') @Default(0) int halfDays,
    @JsonKey(name: 'absent_days') @Default(0) int absentDays,
    @JsonKey(name: 'leave_days') @Default(0) int leaveDays,
    @JsonKey(name: 'holiday_days') @Default(0) int holidayDays,
    @JsonKey(name: 'week_off_days') @Default(0) int weekOffDays,
    @JsonKey(name: 'total_hours_worked') @Default(0.0) double totalHoursWorked,
    @JsonKey(name: 'average_hours_per_day')
    @Default(0.0)
    double averageHoursPerDay,
    @JsonKey(name: 'attendance_percentage')
    @Default(0.0)
    double attendancePercentage,
    @JsonKey(name: 'daily_records')
    @Default(<DailyAttendanceRecordModel>[])
    List<DailyAttendanceRecordModel> dailyRecords,
  }) = _EmployeeMonthlyReportModel;

  factory EmployeeMonthlyReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeMonthlyReportModelFromJson(json);
}

/// Monthly summary item in `GET /api/v1/reports/attendance/employee/{id}/yearly`.
@freezed
abstract class MonthSummaryItemModel with _$MonthSummaryItemModel {
  const factory MonthSummaryItemModel({
    required int month,
    @JsonKey(name: 'month_name') required String monthName,
    @JsonKey(name: 'working_days') @Default(0) int workingDays,
    @JsonKey(name: 'present_days') @Default(0) int presentDays,
    @JsonKey(name: 'late_days') @Default(0) int lateDays,
    @JsonKey(name: 'half_days') @Default(0) int halfDays,
    @JsonKey(name: 'absent_days') @Default(0) int absentDays,
    @JsonKey(name: 'leave_days') @Default(0) int leaveDays,
    @JsonKey(name: 'holiday_days') @Default(0) int holidayDays,
    @JsonKey(name: 'total_hours_worked') @Default(0.0) double totalHoursWorked,
    @JsonKey(name: 'attendance_percentage')
    @Default(0.0)
    double attendancePercentage,
  }) = _MonthSummaryItemModel;

  factory MonthSummaryItemModel.fromJson(Map<String, dynamic> json) =>
      _$MonthSummaryItemModelFromJson(json);
}

/// Yearly summary report from `GET /api/v1/reports/attendance/employee/{id}/yearly`.
@freezed
abstract class EmployeeYearlyReportModel with _$EmployeeYearlyReportModel {
  const factory EmployeeYearlyReportModel({
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'full_name') required String fullName,
    required int year,
    @JsonKey(name: 'department_name') String? departmentName,
    @JsonKey(name: 'annual_working_days') @Default(0) int annualWorkingDays,
    @JsonKey(name: 'annual_present_days') @Default(0) int annualPresentDays,
    @JsonKey(name: 'annual_absent_days') @Default(0) int annualAbsentDays,
    @JsonKey(name: 'annual_leave_days') @Default(0) int annualLeaveDays,
    @JsonKey(name: 'annual_total_hours') @Default(0.0) double annualTotalHours,
    @JsonKey(name: 'annual_attendance_percentage')
    @Default(0.0)
    double annualAttendancePercentage,
    @Default(<MonthSummaryItemModel>[]) List<MonthSummaryItemModel> months,
  }) = _EmployeeYearlyReportModel;

  factory EmployeeYearlyReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeYearlyReportModelFromJson(json);
}
