import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_models.freezed.dart';
part 'task_models.g.dart';

/// Brief user summary representation embedded in task endpoints.
@freezed
abstract class UserBriefModel with _$UserBriefModel {
  const factory UserBriefModel({
    required String id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _UserBriefModel;

  factory UserBriefModel.fromJson(Map<String, dynamic> json) =>
      _$UserBriefModelFromJson(json);
}

/// Dynamic workflow status returned by `/api/v1/task-statuses`.
///
/// Statuses are ordered dynamically by [order]. Status labels and hex colors
/// come exclusively from the backend, never hardcoded in client code.
@freezed
abstract class TaskStatusModel with _$TaskStatusModel {
  const factory TaskStatusModel({
    required String id,
    required String code,
    required String label,
    required int order,
    @JsonKey(name: 'is_terminal') required bool isTerminal,
    required String color,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _TaskStatusModel;

  factory TaskStatusModel.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusModelFromJson(json);
}

/// Dynamic task priority tier returned by `/api/v1/task-priorities`.
@freezed
abstract class TaskPriorityModel with _$TaskPriorityModel {
  const factory TaskPriorityModel({
    required String id,
    required String code,
    required String label,
    required int weight,
    required String color,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _TaskPriorityModel;

  factory TaskPriorityModel.fromJson(Map<String, dynamic> json) =>
      _$TaskPriorityModelFromJson(json);
}

/// Allowed state transitions between statuses returned by
/// `/api/v1/task-status-transitions`.
@freezed
abstract class TaskStatusTransitionModel with _$TaskStatusTransitionModel {
  const factory TaskStatusTransitionModel({
    required String id,
    @JsonKey(name: 'from_status_id') required String fromStatusId,
    @JsonKey(name: 'to_status_id') required String toStatusId,
    @JsonKey(name: 'required_permission') String? requiredPermission,
  }) = _TaskStatusTransitionModel;

  factory TaskStatusTransitionModel.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusTransitionModelFromJson(json);
}

/// Core task model representing tasks in both list and detail views.
@freezed
abstract class TaskItemModel with _$TaskItemModel {
  const factory TaskItemModel({
    required String id,
    required String title,
    required TaskPriorityModel priority,
    required TaskStatusModel status,
    required UserBriefModel assigner,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    String? description,
    @JsonKey(name: 'department_id') String? departmentId,
    @JsonKey(name: 'department_name') String? departmentName,
    @JsonKey(name: 'client_id') String? clientId,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'project_id') String? projectId,
    @JsonKey(name: 'project_name') String? projectName,
    @Default(<UserBriefModel>[]) List<UserBriefModel> assignees,
    @JsonKey(name: 'due_at') DateTime? dueAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'is_overdue') @Default(false) bool isOverdue,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'comments_count') @Default(0) int commentsCount,
    @JsonKey(name: 'attachments_count') @Default(0) int attachmentsCount,
  }) = _TaskItemModel;

  factory TaskItemModel.fromJson(Map<String, dynamic> json) =>
      _$TaskItemModelFromJson(json);
}

/// Paginated page wrapper returned by `/api/v1/tasks/my` and `/api/v1/tasks`.
@freezed
abstract class TaskPageResponse with _$TaskPageResponse {
  const factory TaskPageResponse({
    required List<TaskItemModel> items,
    required int total,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
    @Default(1) int pages,
  }) = _TaskPageResponse;

  factory TaskPageResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskPageResponseFromJson(json);
}

/// Task comment returned by `/api/v1/tasks/{id}/comments`.
@freezed
abstract class TaskCommentModel with _$TaskCommentModel {
  const factory TaskCommentModel({
    required String id,
    @JsonKey(name: 'task_id') required String taskId,
    required UserBriefModel author,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TaskCommentModel;

  factory TaskCommentModel.fromJson(Map<String, dynamic> json) =>
      _$TaskCommentModelFromJson(json);
}

/// Task attachment returned by `/api/v1/tasks/{id}/attachments`.
@freezed
abstract class TaskAttachmentModel with _$TaskAttachmentModel {
  const factory TaskAttachmentModel({
    required String id,
    @JsonKey(name: 'task_id') required String taskId,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'file_size_bytes') required int fileSizeBytes,
    @JsonKey(name: 'mime_type') required String mimeType,
    @JsonKey(name: 'download_url') required String downloadUrl,
    required UserBriefModel uploader,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TaskAttachmentModel;

  factory TaskAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$TaskAttachmentModelFromJson(json);
}

/// Task audit activity timeline item returned by `/api/v1/tasks/{id}/timeline`.
@freezed
abstract class TaskActivityModel with _$TaskActivityModel {
  const factory TaskActivityModel({
    required String id,
    @JsonKey(name: 'task_id') required String taskId,
    required String action,
    required UserBriefModel actor,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(<String, dynamic>{}) Map<String, dynamic> details,
  }) = _TaskActivityModel;

  factory TaskActivityModel.fromJson(Map<String, dynamic> json) =>
      _$TaskActivityModelFromJson(json);
}

/// Organization department returned by `/api/v1/departments`.
@freezed
abstract class DepartmentModel with _$DepartmentModel {
  const factory DepartmentModel({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _DepartmentModel;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);
}

/// Agency client returned by `/api/v1/clients`.
@freezed
abstract class ClientBriefModel with _$ClientBriefModel {
  const factory ClientBriefModel({
    required String id,
    required String name,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _ClientBriefModel;

  factory ClientBriefModel.fromJson(Map<String, dynamic> json) =>
      _$ClientBriefModelFromJson(json);
}

/// Client project returned by `/api/v1/projects`.
@freezed
abstract class ProjectBriefModel with _$ProjectBriefModel {
  const factory ProjectBriefModel({
    required String id,
    required String name,
    @JsonKey(name: 'client_id') required String clientId,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _ProjectBriefModel;

  factory ProjectBriefModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectBriefModelFromJson(json);
}

/// Immutable filter and search state for task queries.
@freezed
abstract class TaskFilterState with _$TaskFilterState {
  const factory TaskFilterState({
    String? statusId,
    String? priorityId,
    String? departmentId,
    String? clientId,
    String? projectId,
    bool? isOverdue,
    DateTime? dueFrom,
    DateTime? dueTo,
    String? search,
    @Default('created_at') String sortBy,
    @Default(true) bool sortDesc,
  }) = _TaskFilterState;

  factory TaskFilterState.fromJson(Map<String, dynamic> json) =>
      _$TaskFilterStateFromJson(json);
}
