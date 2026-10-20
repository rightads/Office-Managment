import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_report_models.freezed.dart';
part 'work_report_models.g.dart';

/// Status codes returned by the backend for a daily work report.
abstract final class WorkReportStatus {
  static const String draft = 'draft';
  static const String submitted = 'submitted';
  static const String reviewed = 'reviewed';

  static const List<String> all = <String>[draft, submitted, reviewed];
}

/// A single logged activity inside a daily work report.
@freezed
abstract class WorkReportItemModel with _$WorkReportItemModel {
  const factory WorkReportItemModel({
    required String id,
    required String description,
    @JsonKey(name: 'minutes_spent') required int minutesSpent,
    @JsonKey(name: 'report_id') @Default('') String reportId,
    @JsonKey(name: 'task_id') String? taskId,
    @JsonKey(name: 'task_title') String? taskTitle,
    @JsonKey(name: 'client_id') String? clientId,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'project_id') String? projectId,
    @JsonKey(name: 'project_name') String? projectName,
  }) = _WorkReportItemModel;

  factory WorkReportItemModel.fromJson(Map<String, dynamic> json) =>
      _$WorkReportItemModelFromJson(json);
}

/// An employee's daily work report (`/api/v1/work-reports`).
@freezed
abstract class WorkReportModel with _$WorkReportModel {
  const factory WorkReportModel({
    required String id,
    @JsonKey(name: 'report_date') required DateTime reportDate,
    required String status,
    @JsonKey(name: 'user_id') @Default('') String userId,
    @JsonKey(name: 'user_full_name') String? userFullName,
    String? summary,
    @JsonKey(name: 'total_minutes') @Default(0) int totalMinutes,
    @JsonKey(name: 'submitted_at') DateTime? submittedAt,
    @JsonKey(name: 'reviewed_by') String? reviewedBy,
    @JsonKey(name: 'reviewer_name') String? reviewerName,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'review_note') String? reviewNote,
    @Default(<WorkReportItemModel>[]) List<WorkReportItemModel> items,
  }) = _WorkReportModel;

  const WorkReportModel._();

  factory WorkReportModel.fromJson(Map<String, dynamic> json) =>
      _$WorkReportModelFromJson(json);

  bool get isDraft => status == WorkReportStatus.draft;
  bool get isSubmitted => status == WorkReportStatus.submitted;
  bool get isReviewed => status == WorkReportStatus.reviewed;

  /// True once the employee has handed the report in (submitted or reviewed).
  bool get isHandedIn => isSubmitted || isReviewed;

  bool get hasReviewNote => (reviewNote ?? '').trim().isNotEmpty;
}

/// Paginated wrapper for `GET /api/v1/work-reports/me`.
@freezed
abstract class WorkReportPageResponse with _$WorkReportPageResponse {
  const factory WorkReportPageResponse({
    @Default(<WorkReportModel>[]) List<WorkReportModel> items,
    @Default(0) int total,
    @Default(1) int page,
    @JsonKey(name: 'page_size') @Default(20) int pageSize,
    @JsonKey(name: 'total_pages') @Default(1) int totalPages,
  }) = _WorkReportPageResponse;

  factory WorkReportPageResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkReportPageResponseFromJson(json);
}

/// Request body for one item of `POST/PUT /api/v1/work-reports`.
///
/// Null relation ids are omitted so the server stores them as `NULL`.
class WorkReportItemPayload {
  const WorkReportItemPayload({
    required this.description,
    required this.minutesSpent,
    this.taskId,
    this.clientId,
    this.projectId,
  });

  final String description;
  final int minutesSpent;
  final String? taskId;
  final String? clientId;
  final String? projectId;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'description': description,
    'minutes_spent': minutesSpent,
    if (taskId != null) 'task_id': taskId,
    if (clientId != null) 'client_id': clientId,
    if (projectId != null) 'project_id': projectId,
  };
}

/// Request body for `POST /api/v1/work-reports` (create or save draft).
class WorkReportCreatePayload {
  const WorkReportCreatePayload({
    required this.reportDate,
    required this.items,
    this.summary,
  });

  /// ISO calendar date (`yyyy-MM-dd`).
  final String reportDate;
  final String? summary;
  final List<WorkReportItemPayload> items;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'report_date': reportDate,
    'summary': summary,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

/// Request body for `PUT /api/v1/work-reports/{id}`.
class WorkReportUpdatePayload {
  const WorkReportUpdatePayload({required this.items, this.summary});

  final String? summary;
  final List<WorkReportItemPayload> items;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'summary': summary,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

/// Local, editable representation of one activity row in the editor form.
@freezed
abstract class WorkReportItemDraft with _$WorkReportItemDraft {
  const factory WorkReportItemDraft({
    /// Stable local identity so rows keep focus/state while being edited.
    required String localId,
    @Default('') String description,

    /// `null` while the minutes field is empty or unparsable.
    int? minutes,
    String? taskId,
    String? taskTitle,
    String? clientId,
    String? clientName,
    String? projectId,
    String? projectName,
  }) = _WorkReportItemDraft;

  const WorkReportItemDraft._();

  factory WorkReportItemDraft.fromItem(
    WorkReportItemModel item, {
    required String localId,
  }) => WorkReportItemDraft(
    localId: localId,
    description: item.description,
    minutes: item.minutesSpent,
    taskId: item.taskId,
    taskTitle: item.taskTitle,
    clientId: item.clientId,
    clientName: item.clientName,
    projectId: item.projectId,
    projectName: item.projectName,
  );

  WorkReportItemPayload toPayload() => WorkReportItemPayload(
    description: description.trim(),
    minutesSpent: minutes ?? 0,
    taskId: taskId,
    clientId: clientId,
    projectId: projectId,
  );
}
