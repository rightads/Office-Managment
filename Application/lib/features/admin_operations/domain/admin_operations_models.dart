import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_operations_models.freezed.dart';
part 'admin_operations_models.g.dart';

@freezed
abstract class TaskReportItem with _$TaskReportItem {
  const factory TaskReportItem({
    required String name,
    @JsonKey(name: 'total_tasks') required int totalTasks,
    @JsonKey(name: 'completed_tasks') required int completedTasks,
    @JsonKey(name: 'pending_tasks') required int pendingTasks,
    @JsonKey(name: 'overdue_tasks') required int overdueTasks,
    String? id,
  }) = _TaskReportItem;

  factory TaskReportItem.fromJson(Map<String, dynamic> json) =>
      _$TaskReportItemFromJson(json);
}

@freezed
abstract class TaskSummaryReportsResponse with _$TaskSummaryReportsResponse {
  const factory TaskSummaryReportsResponse({
    @JsonKey(name: 'total_tasks') required int totalTasks,
    @JsonKey(name: 'completed_tasks') required int completedTasks,
    @JsonKey(name: 'pending_tasks') required int pendingTasks,
    @JsonKey(name: 'overdue_tasks') required int overdueTasks,
    @JsonKey(name: 'on_time_completion_rate')
    required double onTimeCompletionRate,
    @JsonKey(name: 'by_employee')
    @Default(<TaskReportItem>[])
    List<TaskReportItem> byEmployee,
    @JsonKey(name: 'by_department')
    @Default(<TaskReportItem>[])
    List<TaskReportItem> byDepartment,
    @JsonKey(name: 'by_client')
    @Default(<TaskReportItem>[])
    List<TaskReportItem> byClient,
  }) = _TaskSummaryReportsResponse;

  factory TaskSummaryReportsResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskSummaryReportsResponseFromJson(json);
}

@freezed
abstract class TaskAssignRequest with _$TaskAssignRequest {
  const factory TaskAssignRequest({
    @JsonKey(name: 'assignee_ids') required List<String> assigneeIds,
    @Default(false) bool replace,
  }) = _TaskAssignRequest;

  factory TaskAssignRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskAssignRequestFromJson(json);
}

@freezed
abstract class LeaveReviewRequest with _$LeaveReviewRequest {
  const factory LeaveReviewRequest({
    @JsonKey(name: 'review_note') String? reviewNote,
  }) = _LeaveReviewRequest;

  factory LeaveReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveReviewRequestFromJson(json);
}

@freezed
abstract class LeaveRejectRequest with _$LeaveRejectRequest {
  const factory LeaveRejectRequest({
    @JsonKey(name: 'review_note') required String reviewNote,
  }) = _LeaveRejectRequest;

  factory LeaveRejectRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRejectRequestFromJson(json);
}

@freezed
abstract class AnnouncementCreateRequest with _$AnnouncementCreateRequest {
  const factory AnnouncementCreateRequest({
    required String title,
    required String body,
    @JsonKey(name: 'target_department_id') String? targetDepartmentId,
    @JsonKey(name: 'expires_at') String? expiresAt,
  }) = _AnnouncementCreateRequest;

  factory AnnouncementCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementCreateRequestFromJson(json);
}

@freezed
abstract class WorkReportReviewRequest with _$WorkReportReviewRequest {
  const factory WorkReportReviewRequest({
    @JsonKey(name: 'review_note') required String reviewNote,
    @Default('reviewed') String status,
  }) = _WorkReportReviewRequest;

  factory WorkReportReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkReportReviewRequestFromJson(json);
}

@freezed
abstract class MissingWorkReportUserResponse
    with _$MissingWorkReportUserResponse {
  const factory MissingWorkReportUserResponse({
    required String id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'department_name') String? departmentName,
  }) = _MissingWorkReportUserResponse;

  factory MissingWorkReportUserResponse.fromJson(Map<String, dynamic> json) =>
      _$MissingWorkReportUserResponseFromJson(json);
}

@freezed
abstract class MissingWorkReportListResponse
    with _$MissingWorkReportListResponse {
  const factory MissingWorkReportListResponse({
    @JsonKey(name: 'report_date') required String reportDate,
    @JsonKey(name: 'missing_count') required int missingCount,
    @Default(<MissingWorkReportUserResponse>[])
    List<MissingWorkReportUserResponse> users,
  }) = _MissingWorkReportListResponse;

  factory MissingWorkReportListResponse.fromJson(Map<String, dynamic> json) =>
      _$MissingWorkReportListResponseFromJson(json);
}
