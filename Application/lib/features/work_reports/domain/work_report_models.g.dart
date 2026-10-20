// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkReportItemModel _$WorkReportItemModelFromJson(Map<String, dynamic> json) =>
    _WorkReportItemModel(
      id: json['id'] as String,
      description: json['description'] as String,
      minutesSpent: (json['minutes_spent'] as num).toInt(),
      reportId: json['report_id'] as String? ?? '',
      taskId: json['task_id'] as String?,
      taskTitle: json['task_title'] as String?,
      clientId: json['client_id'] as String?,
      clientName: json['client_name'] as String?,
      projectId: json['project_id'] as String?,
      projectName: json['project_name'] as String?,
    );

Map<String, dynamic> _$WorkReportItemModelToJson(
  _WorkReportItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'minutes_spent': instance.minutesSpent,
  'report_id': instance.reportId,
  'task_id': instance.taskId,
  'task_title': instance.taskTitle,
  'client_id': instance.clientId,
  'client_name': instance.clientName,
  'project_id': instance.projectId,
  'project_name': instance.projectName,
};

_WorkReportModel _$WorkReportModelFromJson(Map<String, dynamic> json) =>
    _WorkReportModel(
      id: json['id'] as String,
      reportDate: DateTime.parse(json['report_date'] as String),
      status: json['status'] as String,
      userId: json['user_id'] as String? ?? '',
      userFullName: json['user_full_name'] as String?,
      summary: json['summary'] as String?,
      totalMinutes: (json['total_minutes'] as num?)?.toInt() ?? 0,
      submittedAt: json['submitted_at'] == null
          ? null
          : DateTime.parse(json['submitted_at'] as String),
      reviewedBy: json['reviewed_by'] as String?,
      reviewerName: json['reviewer_name'] as String?,
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      reviewNote: json['review_note'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => WorkReportItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <WorkReportItemModel>[],
    );

Map<String, dynamic> _$WorkReportModelToJson(_WorkReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'report_date': instance.reportDate.toIso8601String(),
      'status': instance.status,
      'user_id': instance.userId,
      'user_full_name': instance.userFullName,
      'summary': instance.summary,
      'total_minutes': instance.totalMinutes,
      'submitted_at': instance.submittedAt?.toIso8601String(),
      'reviewed_by': instance.reviewedBy,
      'reviewer_name': instance.reviewerName,
      'reviewed_at': instance.reviewedAt?.toIso8601String(),
      'review_note': instance.reviewNote,
      'items': instance.items,
    };

_WorkReportPageResponse _$WorkReportPageResponseFromJson(
  Map<String, dynamic> json,
) => _WorkReportPageResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => WorkReportModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WorkReportModel>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['page_size'] as num?)?.toInt() ?? 20,
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$WorkReportPageResponseToJson(
  _WorkReportPageResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
  'total_pages': instance.totalPages,
};
