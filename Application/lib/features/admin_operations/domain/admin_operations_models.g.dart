// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_operations_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskReportItem _$TaskReportItemFromJson(Map<String, dynamic> json) =>
    _TaskReportItem(
      id: json['id'] as String?,
      name: json['name'] as String,
      totalTasks: (json['total_tasks'] as num).toInt(),
      completedTasks: (json['completed_tasks'] as num).toInt(),
      pendingTasks: (json['pending_tasks'] as num).toInt(),
      overdueTasks: (json['overdue_tasks'] as num).toInt(),
    );

Map<String, dynamic> _$TaskReportItemToJson(_TaskReportItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total_tasks': instance.totalTasks,
      'completed_tasks': instance.completedTasks,
      'pending_tasks': instance.pendingTasks,
      'overdue_tasks': instance.overdueTasks,
    };

_TaskSummaryReportsResponse _$TaskSummaryReportsResponseFromJson(
  Map<String, dynamic> json,
) => _TaskSummaryReportsResponse(
  totalTasks: (json['total_tasks'] as num).toInt(),
  completedTasks: (json['completed_tasks'] as num).toInt(),
  pendingTasks: (json['pending_tasks'] as num).toInt(),
  overdueTasks: (json['overdue_tasks'] as num).toInt(),
  onTimeCompletionRate: (json['on_time_completion_rate'] as num).toDouble(),
  byEmployee:
      (json['by_employee'] as List<dynamic>?)
          ?.map((e) => TaskReportItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TaskReportItem>[],
  byDepartment:
      (json['by_department'] as List<dynamic>?)
          ?.map((e) => TaskReportItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TaskReportItem>[],
  byClient:
      (json['by_client'] as List<dynamic>?)
          ?.map((e) => TaskReportItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TaskReportItem>[],
);

Map<String, dynamic> _$TaskSummaryReportsResponseToJson(
  _TaskSummaryReportsResponse instance,
) => <String, dynamic>{
  'total_tasks': instance.totalTasks,
  'completed_tasks': instance.completedTasks,
  'pending_tasks': instance.pendingTasks,
  'overdue_tasks': instance.overdueTasks,
  'on_time_completion_rate': instance.onTimeCompletionRate,
  'by_employee': instance.byEmployee,
  'by_department': instance.byDepartment,
  'by_client': instance.byClient,
};

_TaskAssignRequest _$TaskAssignRequestFromJson(Map<String, dynamic> json) =>
    _TaskAssignRequest(
      assigneeIds: (json['assignee_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      replace: json['replace'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskAssignRequestToJson(_TaskAssignRequest instance) =>
    <String, dynamic>{
      'assignee_ids': instance.assigneeIds,
      'replace': instance.replace,
    };

_LeaveReviewRequest _$LeaveReviewRequestFromJson(Map<String, dynamic> json) =>
    _LeaveReviewRequest(reviewNote: json['review_note'] as String?);

Map<String, dynamic> _$LeaveReviewRequestToJson(_LeaveReviewRequest instance) =>
    <String, dynamic>{'review_note': instance.reviewNote};

_LeaveRejectRequest _$LeaveRejectRequestFromJson(Map<String, dynamic> json) =>
    _LeaveRejectRequest(reviewNote: json['review_note'] as String);

Map<String, dynamic> _$LeaveRejectRequestToJson(_LeaveRejectRequest instance) =>
    <String, dynamic>{'review_note': instance.reviewNote};

_AnnouncementCreateRequest _$AnnouncementCreateRequestFromJson(
  Map<String, dynamic> json,
) => _AnnouncementCreateRequest(
  title: json['title'] as String,
  body: json['body'] as String,
  targetDepartmentId: json['target_department_id'] as String?,
  expiresAt: json['expires_at'] as String?,
);

Map<String, dynamic> _$AnnouncementCreateRequestToJson(
  _AnnouncementCreateRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
  'target_department_id': instance.targetDepartmentId,
  'expires_at': instance.expiresAt,
};

_WorkReportReviewRequest _$WorkReportReviewRequestFromJson(
  Map<String, dynamic> json,
) => _WorkReportReviewRequest(
  reviewNote: json['review_note'] as String,
  status: json['status'] as String? ?? 'reviewed',
);

Map<String, dynamic> _$WorkReportReviewRequestToJson(
  _WorkReportReviewRequest instance,
) => <String, dynamic>{
  'review_note': instance.reviewNote,
  'status': instance.status,
};

_MissingWorkReportUserResponse _$MissingWorkReportUserResponseFromJson(
  Map<String, dynamic> json,
) => _MissingWorkReportUserResponse(
  id: json['id'] as String,
  employeeCode: json['employee_code'] as String,
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  departmentName: json['department_name'] as String?,
);

Map<String, dynamic> _$MissingWorkReportUserResponseToJson(
  _MissingWorkReportUserResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'employee_code': instance.employeeCode,
  'full_name': instance.fullName,
  'email': instance.email,
  'department_name': instance.departmentName,
};

_MissingWorkReportListResponse _$MissingWorkReportListResponseFromJson(
  Map<String, dynamic> json,
) => _MissingWorkReportListResponse(
  reportDate: json['report_date'] as String,
  missingCount: (json['missing_count'] as num).toInt(),
  users:
      (json['users'] as List<dynamic>?)
          ?.map(
            (e) => MissingWorkReportUserResponse.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const <MissingWorkReportUserResponse>[],
);

Map<String, dynamic> _$MissingWorkReportListResponseToJson(
  _MissingWorkReportListResponse instance,
) => <String, dynamic>{
  'report_date': instance.reportDate,
  'missing_count': instance.missingCount,
  'users': instance.users,
};
