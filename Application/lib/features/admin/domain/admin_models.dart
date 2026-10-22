import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_models.freezed.dart';
part 'admin_models.g.dart';

@freezed
abstract class EmployeeItem with _$EmployeeItem {
  const factory EmployeeItem({
    required String id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    required String email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'must_change_password') required bool mustChangePassword,
    @JsonKey(name: 'role_id') required String roleId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? designation,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'joining_date') String? joiningDate,
    @JsonKey(name: 'department_id') String? departmentId,
    @JsonKey(name: 'department_name') String? departmentName,
    @JsonKey(name: 'role_name') String? roleName,
    @JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,
    @JsonKey(name: 'attendance_policy_name') String? attendancePolicyName,
    @JsonKey(name: 'manager_id') String? managerId,
    @JsonKey(name: 'manager_name') String? managerName,
  }) = _EmployeeItem;

  factory EmployeeItem.fromJson(Map<String, dynamic> json) =>
      _$EmployeeItemFromJson(json);
}

@freezed
abstract class EmployeeCreatePayload with _$EmployeeCreatePayload {
  const factory EmployeeCreatePayload({
    required String email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'role_id') required String roleId,
    @JsonKey(name: 'department_id') String? departmentId,
    @JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,
    @JsonKey(name: 'manager_id') String? managerId,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? designation,
    @JsonKey(name: 'joining_date') String? joiningDate,
  }) = _EmployeeCreatePayload;

  factory EmployeeCreatePayload.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCreatePayloadFromJson(json);
}

@freezed
abstract class EmployeeUpdatePayload with _$EmployeeUpdatePayload {
  const factory EmployeeUpdatePayload({
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'department_id') String? departmentId,
    @JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,
    @JsonKey(name: 'manager_id') String? managerId,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? designation,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'joining_date') String? joiningDate,
  }) = _EmployeeUpdatePayload;

  factory EmployeeUpdatePayload.fromJson(Map<String, dynamic> json) =>
      _$EmployeeUpdatePayloadFromJson(json);
}

@freezed
abstract class RoleItem with _$RoleItem {
  const factory RoleItem({
    required String id,
    required String name,
    @JsonKey(name: 'is_system') required bool isSystem,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') required String createdAt,
    String? description,
  }) = _RoleItem;

  factory RoleItem.fromJson(Map<String, dynamic> json) =>
      _$RoleItemFromJson(json);
}

@freezed
abstract class BulkImportRowError with _$BulkImportRowError {
  const factory BulkImportRowError({
    required int row,
    required String field,
    required String error,
    String? value,
  }) = _BulkImportRowError;

  factory BulkImportRowError.fromJson(Map<String, dynamic> json) =>
      _$BulkImportRowErrorFromJson(json);
}

@freezed
abstract class BulkImportReport with _$BulkImportReport {
  const factory BulkImportReport({
    @JsonKey(name: 'total_rows') required int totalRows,
    @JsonKey(name: 'successful_imports') required int successfulImports,
    @JsonKey(name: 'failed_rows') required int failedRows,
    @JsonKey(name: 'dry_run') required bool dryRun,
    @Default(<BulkImportRowError>[]) List<BulkImportRowError> errors,
  }) = _BulkImportReport;

  factory BulkImportReport.fromJson(Map<String, dynamic> json) =>
      _$BulkImportReportFromJson(json);
}

@freezed
abstract class MasterDataItem with _$MasterDataItem {
  const factory MasterDataItem({
    required String id,
    String? name,
    String? label,
    String? code,
    String? description,
    String? color,
    int? order,
    int? weight,
    @JsonKey(name: 'is_terminal') bool? isTerminal,
    @JsonKey(name: 'annual_quota') double? annualQuota,
    @JsonKey(name: 'is_paid') bool? isPaid,
    @JsonKey(name: 'carry_forward') bool? carryForward,
    String? date,
    int? year,
    @JsonKey(name: 'is_optional') bool? isOptional,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'radius_meters') double? radiusMeters,
    String? address,
    @JsonKey(name: 'client_id') String? clientId,
    @JsonKey(name: 'contact_person') String? contactPerson,
    String? email,
    String? phone,
    @JsonKey(name: 'shift_start') String? shiftStart,
    @JsonKey(name: 'shift_end') String? shiftEnd,
    @JsonKey(name: 'grace_minutes') int? graceMinutes,
    @JsonKey(name: 'half_day_min_hours') double? halfDayMinHours,
    @JsonKey(name: 'full_day_min_hours') double? fullDayMinHours,
    @JsonKey(name: 'require_geofence') bool? requireGeofence,
    @JsonKey(name: 'require_selfie') bool? requireSelfie,
    @JsonKey(name: 'is_default') bool? isDefault,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'from_status_id') String? fromStatusId,
    @JsonKey(name: 'to_status_id') String? toStatusId,
    @JsonKey(name: 'required_permission') String? requiredPermission,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _MasterDataItem;

  factory MasterDataItem.fromJson(Map<String, dynamic> json) =>
      _$MasterDataItemFromJson(json);
}
