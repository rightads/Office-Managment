// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OfficeLocationModel _$OfficeLocationModelFromJson(Map<String, dynamic> json) =>
    _OfficeLocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      radiusMeters: (json['radius_meters'] as num?)?.toInt() ?? 100,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$OfficeLocationModelToJson(
  _OfficeLocationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
  'radius_meters': instance.radiusMeters,
  'is_active': instance.isActive,
};

_EffectiveAttendancePolicyModel _$EffectiveAttendancePolicyModelFromJson(
  Map<String, dynamic> json,
) => _EffectiveAttendancePolicyModel(
  id: json['id'] as String,
  name: json['name'] as String,
  shiftStart: json['shift_start'] as String? ?? '09:30:00',
  shiftEnd: json['shift_end'] as String? ?? '18:30:00',
  graceMinutes: (json['grace_minutes'] as num?)?.toInt() ?? 15,
  halfDayMinHours: (json['half_day_min_hours'] as num?)?.toDouble() ?? 4.0,
  fullDayMinHours: (json['full_day_min_hours'] as num?)?.toDouble() ?? 8.0,
  weekOffDays:
      (json['week_off_days'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[6],
  requireGeofence: json['require_geofence'] as bool? ?? true,
  requireSelfie: json['require_selfie'] as bool? ?? false,
  allowedLocations:
      (json['allowed_locations'] as List<dynamic>?)
          ?.map((e) => OfficeLocationModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OfficeLocationModel>[],
);

Map<String, dynamic> _$EffectiveAttendancePolicyModelToJson(
  _EffectiveAttendancePolicyModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shift_start': instance.shiftStart,
  'shift_end': instance.shiftEnd,
  'grace_minutes': instance.graceMinutes,
  'half_day_min_hours': instance.halfDayMinHours,
  'full_day_min_hours': instance.fullDayMinHours,
  'week_off_days': instance.weekOffDays,
  'require_geofence': instance.requireGeofence,
  'require_selfie': instance.requireSelfie,
  'allowed_locations': instance.allowedLocations,
};

_AttendanceRecordModel _$AttendanceRecordModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceRecordModel(
  id: json['id'] as String,
  employeeId: json['employee_id'] as String,
  attendanceDate: json['attendance_date'] as String,
  status: json['status'] as String,
  statusLabel: json['status_label'] as String,
  statusColor: json['status_color'] as String,
  checkInAt: json['check_in_at'] == null
      ? null
      : DateTime.parse(json['check_in_at'] as String),
  checkOutAt: json['check_out_at'] == null
      ? null
      : DateTime.parse(json['check_out_at'] as String),
  checkInLat: (json['check_in_lat'] as num?)?.toDouble(),
  checkInLng: (json['check_in_lng'] as num?)?.toDouble(),
  checkOutLat: (json['check_out_lat'] as num?)?.toDouble(),
  checkOutLng: (json['check_out_lng'] as num?)?.toDouble(),
  deviceId: json['device_id'] as String?,
  isManual: json['is_manual'] as bool? ?? false,
  workHours: (json['work_hours'] as num?)?.toDouble(),
  remarks: json['remarks'] as String?,
  selfieUrl: json['selfie_url'] as String?,
);

Map<String, dynamic> _$AttendanceRecordModelToJson(
  _AttendanceRecordModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employee_id': instance.employeeId,
  'attendance_date': instance.attendanceDate,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'status_color': instance.statusColor,
  'check_in_at': instance.checkInAt?.toIso8601String(),
  'check_out_at': instance.checkOutAt?.toIso8601String(),
  'check_in_lat': instance.checkInLat,
  'check_in_lng': instance.checkInLng,
  'check_out_lat': instance.checkOutLat,
  'check_out_lng': instance.checkOutLng,
  'device_id': instance.deviceId,
  'is_manual': instance.isManual,
  'work_hours': instance.workHours,
  'remarks': instance.remarks,
  'selfie_url': instance.selfieUrl,
};

_CheckInRequestPayload _$CheckInRequestPayloadFromJson(
  Map<String, dynamic> json,
) => _CheckInRequestPayload(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  deviceId: json['device_id'] as String,
  isMockLocation: json['is_mock_location'] as bool? ?? false,
  selfieUrl: json['selfie_url'] as String?,
);

Map<String, dynamic> _$CheckInRequestPayloadToJson(
  _CheckInRequestPayload instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'device_id': instance.deviceId,
  'is_mock_location': instance.isMockLocation,
  'selfie_url': ?instance.selfieUrl,
};

_CheckOutRequestPayload _$CheckOutRequestPayloadFromJson(
  Map<String, dynamic> json,
) => _CheckOutRequestPayload(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  deviceId: json['device_id'] as String,
  isMockLocation: json['is_mock_location'] as bool? ?? false,
  remarks: json['remarks'] as String?,
);

Map<String, dynamic> _$CheckOutRequestPayloadToJson(
  _CheckOutRequestPayload instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'device_id': instance.deviceId,
  'is_mock_location': instance.isMockLocation,
  'remarks': ?instance.remarks,
};

_AttendanceCalendarDayModel _$AttendanceCalendarDayModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceCalendarDayModel(
  date: json['date'] as String,
  status: json['status'] as String,
  statusLabel: json['status_label'] as String,
  statusColor: json['status_color'] as String,
  checkInAt: json['check_in_at'] == null
      ? null
      : DateTime.parse(json['check_in_at'] as String),
  checkOutAt: json['check_out_at'] == null
      ? null
      : DateTime.parse(json['check_out_at'] as String),
  workHours: (json['work_hours'] as num?)?.toDouble(),
  isManual: json['is_manual'] as bool? ?? false,
  holidayName: json['holiday_name'] as String?,
  leaveTypeName: json['leave_type_name'] as String?,
);

Map<String, dynamic> _$AttendanceCalendarDayModelToJson(
  _AttendanceCalendarDayModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'status_color': instance.statusColor,
  'check_in_at': instance.checkInAt?.toIso8601String(),
  'check_out_at': instance.checkOutAt?.toIso8601String(),
  'work_hours': instance.workHours,
  'is_manual': instance.isManual,
  'holiday_name': instance.holidayName,
  'leave_type_name': instance.leaveTypeName,
};

_AttendanceCalendarModel _$AttendanceCalendarModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceCalendarModel(
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  totalWorkingDays: (json['total_working_days'] as num?)?.toInt() ?? 0,
  totalPresentDays: (json['total_present_days'] as num?)?.toInt() ?? 0,
  totalAbsentDays: (json['total_absent_days'] as num?)?.toInt() ?? 0,
  totalHalfDays: (json['total_half_days'] as num?)?.toInt() ?? 0,
  totalLeaveDays: (json['total_leave_days'] as num?)?.toInt() ?? 0,
  totalHolidays: (json['total_holidays'] as num?)?.toInt() ?? 0,
  days:
      (json['days'] as List<dynamic>?)
          ?.map(
            (e) =>
                AttendanceCalendarDayModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <AttendanceCalendarDayModel>[],
);

Map<String, dynamic> _$AttendanceCalendarModelToJson(
  _AttendanceCalendarModel instance,
) => <String, dynamic>{
  'year': instance.year,
  'month': instance.month,
  'total_working_days': instance.totalWorkingDays,
  'total_present_days': instance.totalPresentDays,
  'total_absent_days': instance.totalAbsentDays,
  'total_half_days': instance.totalHalfDays,
  'total_leave_days': instance.totalLeaveDays,
  'total_holidays': instance.totalHolidays,
  'days': instance.days,
};

_DailyAttendanceRecordModel _$DailyAttendanceRecordModelFromJson(
  Map<String, dynamic> json,
) => _DailyAttendanceRecordModel(
  date: json['date'] as String,
  status: json['status'] as String,
  statusLabel: json['status_label'] as String,
  statusColor: json['status_color'] as String,
  checkInAt: json['check_in_at'] == null
      ? null
      : DateTime.parse(json['check_in_at'] as String),
  checkOutAt: json['check_out_at'] == null
      ? null
      : DateTime.parse(json['check_out_at'] as String),
  workHours: (json['work_hours'] as num?)?.toDouble(),
  isManual: json['is_manual'] as bool? ?? false,
  correctionApplied: json['correction_applied'] as bool? ?? false,
  remarks: json['remarks'] as String?,
  holidayName: json['holiday_name'] as String?,
  leaveTypeName: json['leave_type_name'] as String?,
);

Map<String, dynamic> _$DailyAttendanceRecordModelToJson(
  _DailyAttendanceRecordModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'status_color': instance.statusColor,
  'check_in_at': instance.checkInAt?.toIso8601String(),
  'check_out_at': instance.checkOutAt?.toIso8601String(),
  'work_hours': instance.workHours,
  'is_manual': instance.isManual,
  'correction_applied': instance.correctionApplied,
  'remarks': instance.remarks,
  'holiday_name': instance.holidayName,
  'leave_type_name': instance.leaveTypeName,
};

_EmployeeMonthlyReportModel _$EmployeeMonthlyReportModelFromJson(
  Map<String, dynamic> json,
) => _EmployeeMonthlyReportModel(
  employeeId: json['employee_id'] as String,
  employeeCode: json['employee_code'] as String,
  fullName: json['full_name'] as String,
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  departmentName: json['department_name'] as String?,
  designation: json['designation'] as String?,
  totalDaysInMonth: (json['total_days_in_month'] as num?)?.toInt() ?? 0,
  workingDays: (json['working_days'] as num?)?.toInt() ?? 0,
  presentDays: (json['present_days'] as num?)?.toInt() ?? 0,
  lateDays: (json['late_days'] as num?)?.toInt() ?? 0,
  halfDays: (json['half_days'] as num?)?.toInt() ?? 0,
  absentDays: (json['absent_days'] as num?)?.toInt() ?? 0,
  leaveDays: (json['leave_days'] as num?)?.toInt() ?? 0,
  holidayDays: (json['holiday_days'] as num?)?.toInt() ?? 0,
  weekOffDays: (json['week_off_days'] as num?)?.toInt() ?? 0,
  totalHoursWorked: (json['total_hours_worked'] as num?)?.toDouble() ?? 0.0,
  averageHoursPerDay:
      (json['average_hours_per_day'] as num?)?.toDouble() ?? 0.0,
  attendancePercentage:
      (json['attendance_percentage'] as num?)?.toDouble() ?? 0.0,
  dailyRecords:
      (json['daily_records'] as List<dynamic>?)
          ?.map(
            (e) =>
                DailyAttendanceRecordModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DailyAttendanceRecordModel>[],
);

Map<String, dynamic> _$EmployeeMonthlyReportModelToJson(
  _EmployeeMonthlyReportModel instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'employee_code': instance.employeeCode,
  'full_name': instance.fullName,
  'year': instance.year,
  'month': instance.month,
  'department_name': instance.departmentName,
  'designation': instance.designation,
  'total_days_in_month': instance.totalDaysInMonth,
  'working_days': instance.workingDays,
  'present_days': instance.presentDays,
  'late_days': instance.lateDays,
  'half_days': instance.halfDays,
  'absent_days': instance.absentDays,
  'leave_days': instance.leaveDays,
  'holiday_days': instance.holidayDays,
  'week_off_days': instance.weekOffDays,
  'total_hours_worked': instance.totalHoursWorked,
  'average_hours_per_day': instance.averageHoursPerDay,
  'attendance_percentage': instance.attendancePercentage,
  'daily_records': instance.dailyRecords,
};

_MonthSummaryItemModel _$MonthSummaryItemModelFromJson(
  Map<String, dynamic> json,
) => _MonthSummaryItemModel(
  month: (json['month'] as num).toInt(),
  monthName: json['month_name'] as String,
  workingDays: (json['working_days'] as num?)?.toInt() ?? 0,
  presentDays: (json['present_days'] as num?)?.toInt() ?? 0,
  lateDays: (json['late_days'] as num?)?.toInt() ?? 0,
  halfDays: (json['half_days'] as num?)?.toInt() ?? 0,
  absentDays: (json['absent_days'] as num?)?.toInt() ?? 0,
  leaveDays: (json['leave_days'] as num?)?.toInt() ?? 0,
  holidayDays: (json['holiday_days'] as num?)?.toInt() ?? 0,
  totalHoursWorked: (json['total_hours_worked'] as num?)?.toDouble() ?? 0.0,
  attendancePercentage:
      (json['attendance_percentage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$MonthSummaryItemModelToJson(
  _MonthSummaryItemModel instance,
) => <String, dynamic>{
  'month': instance.month,
  'month_name': instance.monthName,
  'working_days': instance.workingDays,
  'present_days': instance.presentDays,
  'late_days': instance.lateDays,
  'half_days': instance.halfDays,
  'absent_days': instance.absentDays,
  'leave_days': instance.leaveDays,
  'holiday_days': instance.holidayDays,
  'total_hours_worked': instance.totalHoursWorked,
  'attendance_percentage': instance.attendancePercentage,
};

_EmployeeYearlyReportModel _$EmployeeYearlyReportModelFromJson(
  Map<String, dynamic> json,
) => _EmployeeYearlyReportModel(
  employeeId: json['employee_id'] as String,
  employeeCode: json['employee_code'] as String,
  fullName: json['full_name'] as String,
  year: (json['year'] as num).toInt(),
  departmentName: json['department_name'] as String?,
  annualWorkingDays: (json['annual_working_days'] as num?)?.toInt() ?? 0,
  annualPresentDays: (json['annual_present_days'] as num?)?.toInt() ?? 0,
  annualAbsentDays: (json['annual_absent_days'] as num?)?.toInt() ?? 0,
  annualLeaveDays: (json['annual_leave_days'] as num?)?.toInt() ?? 0,
  annualTotalHours: (json['annual_total_hours'] as num?)?.toDouble() ?? 0.0,
  annualAttendancePercentage:
      (json['annual_attendance_percentage'] as num?)?.toDouble() ?? 0.0,
  months:
      (json['months'] as List<dynamic>?)
          ?.map(
            (e) => MonthSummaryItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <MonthSummaryItemModel>[],
);

Map<String, dynamic> _$EmployeeYearlyReportModelToJson(
  _EmployeeYearlyReportModel instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'employee_code': instance.employeeCode,
  'full_name': instance.fullName,
  'year': instance.year,
  'department_name': instance.departmentName,
  'annual_working_days': instance.annualWorkingDays,
  'annual_present_days': instance.annualPresentDays,
  'annual_absent_days': instance.annualAbsentDays,
  'annual_leave_days': instance.annualLeaveDays,
  'annual_total_hours': instance.annualTotalHours,
  'annual_attendance_percentage': instance.annualAttendancePercentage,
  'months': instance.months,
};
