import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_models.freezed.dart';
part 'leave_models.g.dart';

/// Configured active leave categories from `GET /api/v1/leaves/types`.
@freezed
abstract class LeaveTypeModel with _$LeaveTypeModel {
  const factory LeaveTypeModel({
    required String id,
    required String name,
    @JsonKey(name: 'annual_quota') required int annualQuota,
    @JsonKey(name: 'is_paid') required bool isPaid,
    @JsonKey(name: 'carry_forward') required bool carryForward,
    @JsonKey(name: 'max_carry_forward') required int maxCarryForward,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _LeaveTypeModel;

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeModelFromJson(json);
}

/// Employee annual leave balances from `GET /api/v1/leaves/my-balances`.
@freezed
abstract class LeaveBalanceModel with _$LeaveBalanceModel {
  const factory LeaveBalanceModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'leave_type_id') required String leaveTypeId,
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
    required int year,
    required double allocated,
    @JsonKey(name: 'carried_forward') required double carriedForward,
    required double used,
    required double available,
  }) = _LeaveBalanceModel;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceModelFromJson(json);
}

/// An employee leave application record.
@freezed
abstract class LeaveRequestModel with _$LeaveRequestModel {
  const factory LeaveRequestModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_full_name') required String userFullName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'leave_type_id') required String leaveTypeId,
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
    @JsonKey(name: 'from_date') required DateTime fromDate,
    @JsonKey(name: 'to_date') required DateTime toDate,
    @JsonKey(name: 'is_half_day') required bool isHalfDay,
    @JsonKey(name: 'total_days') required double totalDays,
    required String reason,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'department_name') String? departmentName,
    @JsonKey(name: 'half_day_session') String? halfDaySession,
    @JsonKey(name: 'reviewed_by') String? reviewedBy,
    @JsonKey(name: 'reviewer_name') String? reviewerName,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'review_note') String? reviewNote,
  }) = _LeaveRequestModel;

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestModelFromJson(json);
}

/// Paginated wrapper for leave requests.
@freezed
abstract class LeaveRequestListResponse with _$LeaveRequestListResponse {
  const factory LeaveRequestListResponse({
    required List<LeaveRequestModel> items,
    required int total,
    required int page,
    required int size,
    required int pages,
  }) = _LeaveRequestListResponse;

  factory LeaveRequestListResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestListResponseFromJson(json);
}

/// Request body for applying for leave (`POST /api/v1/leaves/apply`).
@freezed
abstract class LeaveApplyPayload with _$LeaveApplyPayload {
  const factory LeaveApplyPayload({
    @JsonKey(name: 'leave_type_id') required String leaveTypeId,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    required String reason,
    @JsonKey(name: 'is_half_day') @Default(false) bool isHalfDay,
    @JsonKey(name: 'half_day_session') String? halfDaySession,
  }) = _LeaveApplyPayload;

  factory LeaveApplyPayload.fromJson(Map<String, dynamic> json) =>
      _$LeaveApplyPayloadFromJson(json);
}

/// Request body for live working-day calculation preview (`POST /api/v1/leaves/preview`).
@freezed
abstract class LeavePreviewPayload with _$LeavePreviewPayload {
  const factory LeavePreviewPayload({
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    @JsonKey(name: 'leave_type_id') String? leaveTypeId,
    @JsonKey(name: 'is_half_day') @Default(false) bool isHalfDay,
    @JsonKey(name: 'half_day_session') String? halfDaySession,
  }) = _LeavePreviewPayload;

  factory LeavePreviewPayload.fromJson(Map<String, dynamic> json) =>
      _$LeavePreviewPayloadFromJson(json);
}

/// Response returned from live preview calculation (`POST /api/v1/leaves/preview`).
@freezed
abstract class LeavePreviewResponse with _$LeavePreviewResponse {
  const factory LeavePreviewResponse({
    @JsonKey(name: 'from_date') required DateTime fromDate,
    @JsonKey(name: 'to_date') required DateTime toDate,
    @JsonKey(name: 'is_half_day') required bool isHalfDay,
    @JsonKey(name: 'working_days') required double workingDays,
    @JsonKey(name: 'is_valid') required bool isValid,
    @JsonKey(name: 'half_day_session') String? halfDaySession,
    @JsonKey(name: 'validation_error') String? validationError,
    @JsonKey(name: 'available_balance') double? availableBalance,
    @JsonKey(name: 'has_overlap') @Default(false) bool hasOverlap,
    @JsonKey(name: 'overlapping_request_id') String? overlappingRequestId,
  }) = _LeavePreviewResponse;

  factory LeavePreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$LeavePreviewResponseFromJson(json);
}

/// Calendar holiday definition from `GET /api/v1/holidays`.
@freezed
abstract class HolidayModel with _$HolidayModel {
  const factory HolidayModel({
    required String id,
    required String name,
    required DateTime date,
    required int year,
    @JsonKey(name: 'is_optional') @Default(false) bool isOptional,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _HolidayModel;

  factory HolidayModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayModelFromJson(json);
}

/// Paginated page envelope for calendar holidays.
@freezed
abstract class HolidayPageResponse with _$HolidayPageResponse {
  const factory HolidayPageResponse({
    required List<HolidayModel> items,
    required int total,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
  }) = _HolidayPageResponse;

  factory HolidayPageResponse.fromJson(Map<String, dynamic> json) =>
      _$HolidayPageResponseFromJson(json);
}
