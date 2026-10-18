import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/services/device_info_service.dart';
import 'package:right_ads/core/services/photo_picker_service.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

/// Employee profile representation matching `EmployeeDetailResponse` /
/// `EmployeeResponse` from `GET/PATCH /api/v1/employees/me`.
@freezed
abstract class EmployeeProfile with _$EmployeeProfile {
  const factory EmployeeProfile({
    required String id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    required String email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'role_id') required String roleId,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? designation,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'must_change_password')
    @Default(false)
    bool mustChangePassword,
    @JsonKey(name: 'joining_date') String? joiningDate,
    @JsonKey(name: 'department_id') String? departmentId,
    @JsonKey(name: 'department_name') String? departmentName,
    @JsonKey(name: 'role_name') String? roleName,
    @JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,
    @JsonKey(name: 'attendance_policy_name') String? attendancePolicyName,
    @JsonKey(name: 'manager_id') String? managerId,
    @JsonKey(name: 'manager_name') String? managerName,
    @JsonKey(name: 'created_at') String? createdAt,
    @Default(<String>[]) List<String> permissions,
  }) = _EmployeeProfile;

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) =>
      _$EmployeeProfileFromJson(json);
}

/// Request payload for `PATCH /api/v1/employees/me` (`EmployeeSelfUpdate`).
@freezed
abstract class EmployeeSelfUpdatePayload with _$EmployeeSelfUpdatePayload {
  const factory EmployeeSelfUpdatePayload({
    @JsonKey(name: 'phone_number', includeIfNull: false) String? phoneNumber,
    @JsonKey(name: 'avatar_url', includeIfNull: false) String? avatarUrl,
  }) = _EmployeeSelfUpdatePayload;

  factory EmployeeSelfUpdatePayload.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSelfUpdatePayloadFromJson(json);
}

/// Reactive state for the Profile & Account feature.
@freezed
abstract class ProfileViewState with _$ProfileViewState {
  const factory ProfileViewState({
    EmployeeProfile? profile,
    @Default(false) bool isLoading,
    @Default(false) bool isSavingProfile,
    @Default(false) bool isChangingPassword,
    @Default(false) bool isBiometricSupported,
    @Default(false) bool isBiometricEnabled,
    DeviceMetadata? deviceMetadata,
    AppFailure? failure,
    PhotoValidationError? photoValidationError,
    @Default(<String, List<String>>{})
    Map<String, List<String>> profileFieldErrors,
    @Default(<String, List<String>>{})
    Map<String, List<String>> passwordFieldErrors,
  }) = _ProfileViewState;

  const ProfileViewState._();

  /// Returns the first validation error message for [fieldName] in the
  /// self-service profile form (`phone_number`, `avatar_url`), or `null`.
  String? profileFieldError(String fieldName) {
    final errors = profileFieldErrors[fieldName];
    if (errors == null || errors.isEmpty) return null;
    return errors.first;
  }

  /// Returns the first validation error message for [fieldName] in the
  /// change-password form (`current_password`, `new_password`), or `null`.
  String? passwordFieldError(String fieldName) {
    final errors = passwordFieldErrors[fieldName];
    if (errors == null || errors.isEmpty) return null;
    return errors.first;
  }
}
