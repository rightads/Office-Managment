// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserBriefModel _$UserBriefModelFromJson(Map<String, dynamic> json) =>
    _UserBriefModel(
      id: json['id'] as String,
      employeeCode: json['employee_code'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$UserBriefModelToJson(_UserBriefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_code': instance.employeeCode,
      'full_name': instance.fullName,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
    };

_TaskStatusModel _$TaskStatusModelFromJson(Map<String, dynamic> json) =>
    _TaskStatusModel(
      id: json['id'] as String,
      code: json['code'] as String,
      label: json['label'] as String,
      order: (json['order'] as num).toInt(),
      isTerminal: json['is_terminal'] as bool,
      color: json['color'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$TaskStatusModelToJson(_TaskStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'label': instance.label,
      'order': instance.order,
      'is_terminal': instance.isTerminal,
      'color': instance.color,
      'is_active': instance.isActive,
    };

_TaskPriorityModel _$TaskPriorityModelFromJson(Map<String, dynamic> json) =>
    _TaskPriorityModel(
      id: json['id'] as String,
      code: json['code'] as String,
      label: json['label'] as String,
      weight: (json['weight'] as num).toInt(),
      color: json['color'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$TaskPriorityModelToJson(_TaskPriorityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'label': instance.label,
      'weight': instance.weight,
      'color': instance.color,
      'is_active': instance.isActive,
    };

_TaskStatusTransitionModel _$TaskStatusTransitionModelFromJson(
  Map<String, dynamic> json,
) => _TaskStatusTransitionModel(
  id: json['id'] as String,
  fromStatusId: json['from_status_id'] as String,
  toStatusId: json['to_status_id'] as String,
  requiredPermission: json['required_permission'] as String?,
);

Map<String, dynamic> _$TaskStatusTransitionModelToJson(
  _TaskStatusTransitionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'from_status_id': instance.fromStatusId,
  'to_status_id': instance.toStatusId,
  'required_permission': instance.requiredPermission,
};

_TaskItemModel _$TaskItemModelFromJson(Map<String, dynamic> json) =>
    _TaskItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      priority: TaskPriorityModel.fromJson(
        json['priority'] as Map<String, dynamic>,
      ),
      status: TaskStatusModel.fromJson(json['status'] as Map<String, dynamic>),
      assigner: UserBriefModel.fromJson(
        json['assigner'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      description: json['description'] as String?,
      departmentId: json['department_id'] as String?,
      departmentName: json['department_name'] as String?,
      clientId: json['client_id'] as String?,
      clientName: json['client_name'] as String?,
      projectId: json['project_id'] as String?,
      projectName: json['project_name'] as String?,
      assignees:
          (json['assignees'] as List<dynamic>?)
              ?.map((e) => UserBriefModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserBriefModel>[],
      dueAt: json['due_at'] == null
          ? null
          : DateTime.parse(json['due_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      isOverdue: json['is_overdue'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      commentsCount: (json['comments_count'] as num?)?.toInt() ?? 0,
      attachmentsCount: (json['attachments_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TaskItemModelToJson(_TaskItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'priority': instance.priority,
      'status': instance.status,
      'assigner': instance.assigner,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'description': instance.description,
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'project_id': instance.projectId,
      'project_name': instance.projectName,
      'assignees': instance.assignees,
      'due_at': instance.dueAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'is_overdue': instance.isOverdue,
      'is_active': instance.isActive,
      'comments_count': instance.commentsCount,
      'attachments_count': instance.attachmentsCount,
    };

_TaskPageResponse _$TaskPageResponseFromJson(Map<String, dynamic> json) =>
    _TaskPageResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => TaskItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      pages: (json['pages'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$TaskPageResponseToJson(_TaskPageResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
      'pages': instance.pages,
    };

_TaskCommentModel _$TaskCommentModelFromJson(Map<String, dynamic> json) =>
    _TaskCommentModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      author: UserBriefModel.fromJson(json['author'] as Map<String, dynamic>),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TaskCommentModelToJson(_TaskCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'author': instance.author,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
    };

_TaskAttachmentModel _$TaskAttachmentModelFromJson(Map<String, dynamic> json) =>
    _TaskAttachmentModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      fileName: json['file_name'] as String,
      fileSizeBytes: (json['file_size_bytes'] as num).toInt(),
      mimeType: json['mime_type'] as String,
      downloadUrl: json['download_url'] as String,
      uploader: UserBriefModel.fromJson(
        json['uploader'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TaskAttachmentModelToJson(
  _TaskAttachmentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'task_id': instance.taskId,
  'file_name': instance.fileName,
  'file_size_bytes': instance.fileSizeBytes,
  'mime_type': instance.mimeType,
  'download_url': instance.downloadUrl,
  'uploader': instance.uploader,
  'created_at': instance.createdAt.toIso8601String(),
};

_TaskActivityModel _$TaskActivityModelFromJson(Map<String, dynamic> json) =>
    _TaskActivityModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      action: json['action'] as String,
      actor: UserBriefModel.fromJson(json['actor'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      details:
          json['details'] as Map<String, dynamic>? ?? const <String, dynamic>{},
    );

Map<String, dynamic> _$TaskActivityModelToJson(_TaskActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'action': instance.action,
      'actor': instance.actor,
      'created_at': instance.createdAt.toIso8601String(),
      'details': instance.details,
    };

_DepartmentModel _$DepartmentModelFromJson(Map<String, dynamic> json) =>
    _DepartmentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$DepartmentModelToJson(_DepartmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_active': instance.isActive,
    };

_ClientBriefModel _$ClientBriefModelFromJson(Map<String, dynamic> json) =>
    _ClientBriefModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$ClientBriefModelToJson(_ClientBriefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_active': instance.isActive,
    };

_ProjectBriefModel _$ProjectBriefModelFromJson(Map<String, dynamic> json) =>
    _ProjectBriefModel(
      id: json['id'] as String,
      name: json['name'] as String,
      clientId: json['client_id'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$ProjectBriefModelToJson(_ProjectBriefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'client_id': instance.clientId,
      'is_active': instance.isActive,
    };

_TaskFilterState _$TaskFilterStateFromJson(Map<String, dynamic> json) =>
    _TaskFilterState(
      statusId: json['statusId'] as String?,
      priorityId: json['priorityId'] as String?,
      departmentId: json['departmentId'] as String?,
      clientId: json['clientId'] as String?,
      projectId: json['projectId'] as String?,
      isOverdue: json['isOverdue'] as bool?,
      dueFrom: json['dueFrom'] == null
          ? null
          : DateTime.parse(json['dueFrom'] as String),
      dueTo: json['dueTo'] == null
          ? null
          : DateTime.parse(json['dueTo'] as String),
      search: json['search'] as String?,
      sortBy: json['sortBy'] as String? ?? 'created_at',
      sortDesc: json['sortDesc'] as bool? ?? true,
    );

Map<String, dynamic> _$TaskFilterStateToJson(_TaskFilterState instance) =>
    <String, dynamic>{
      'statusId': instance.statusId,
      'priorityId': instance.priorityId,
      'departmentId': instance.departmentId,
      'clientId': instance.clientId,
      'projectId': instance.projectId,
      'isOverdue': instance.isOverdue,
      'dueFrom': instance.dueFrom?.toIso8601String(),
      'dueTo': instance.dueTo?.toIso8601String(),
      'search': instance.search,
      'sortBy': instance.sortBy,
      'sortDesc': instance.sortDesc,
    };
