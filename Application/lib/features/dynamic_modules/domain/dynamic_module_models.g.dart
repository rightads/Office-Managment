// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_module_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DynamicSelectOption _$DynamicSelectOptionFromJson(Map<String, dynamic> json) =>
    _DynamicSelectOption(
      value: json['value'] as String,
      label: json['label'] as String,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$DynamicSelectOptionToJson(
  _DynamicSelectOption instance,
) => <String, dynamic>{
  'value': instance.value,
  'label': instance.label,
  'color': instance.color,
};

_DynamicFieldValidation _$DynamicFieldValidationFromJson(
  Map<String, dynamic> json,
) => _DynamicFieldValidation(
  min: json['min'] as num?,
  max: json['max'] as num?,
  minLength: (json['min_length'] as num?)?.toInt(),
  maxLength: (json['max_length'] as num?)?.toInt(),
  regex: json['regex'] as String?,
  regexMessage: json['regex_message'] as String?,
);

Map<String, dynamic> _$DynamicFieldValidationToJson(
  _DynamicFieldValidation instance,
) => <String, dynamic>{
  'min': instance.min,
  'max': instance.max,
  'min_length': instance.minLength,
  'max_length': instance.maxLength,
  'regex': instance.regex,
  'regex_message': instance.regexMessage,
};

_DynamicModuleField _$DynamicModuleFieldFromJson(Map<String, dynamic> json) =>
    _DynamicModuleField(
      id: json['id'] as String,
      key: json['key'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
      isRequired: json['is_required'] as bool? ?? false,
      isListVisible: json['is_list_visible'] as bool? ?? true,
      isFilterable: json['is_filterable'] as bool? ?? false,
      isSearchable: json['is_searchable'] as bool? ?? false,
      options:
          (json['options'] as List<dynamic>?)
              ?.map(
                (e) => DynamicSelectOption.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <DynamicSelectOption>[],
      validation: json['validation'] == null
          ? null
          : DynamicFieldValidation.fromJson(
              json['validation'] as Map<String, dynamic>,
            ),
      defaultValue: json['default_value'],
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      section: json['section'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$DynamicModuleFieldToJson(_DynamicModuleField instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'label': instance.label,
      'type': instance.type,
      'is_required': instance.isRequired,
      'is_list_visible': instance.isListVisible,
      'is_filterable': instance.isFilterable,
      'is_searchable': instance.isSearchable,
      'options': instance.options,
      'validation': instance.validation,
      'default_value': instance.defaultValue,
      'sort_order': instance.sortOrder,
      'section': instance.section,
      'is_active': instance.isActive,
    };

_DynamicModuleStatus _$DynamicModuleStatusFromJson(Map<String, dynamic> json) =>
    _DynamicModuleStatus(
      id: json['id'] as String,
      code: json['code'] as String,
      label: json['label'] as String,
      color: json['color'] as String? ?? '#6B7280',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isTerminal: json['is_terminal'] as bool? ?? false,
      requiredPermission: json['required_permission'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$DynamicModuleStatusToJson(
  _DynamicModuleStatus instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'label': instance.label,
  'color': instance.color,
  'sort_order': instance.sortOrder,
  'is_terminal': instance.isTerminal,
  'required_permission': instance.requiredPermission,
  'is_active': instance.isActive,
};

_DynamicModuleTransition _$DynamicModuleTransitionFromJson(
  Map<String, dynamic> json,
) => _DynamicModuleTransition(
  id: json['id'] as String,
  fromStatusId: json['from_status_id'] as String,
  toStatusId: json['to_status_id'] as String,
  toStatusCode: json['to_status_code'] as String?,
  toStatusLabel: json['to_status_label'] as String?,
  toStatusColor: json['to_status_color'] as String?,
  requiredPermission: json['required_permission'] as String?,
);

Map<String, dynamic> _$DynamicModuleTransitionToJson(
  _DynamicModuleTransition instance,
) => <String, dynamic>{
  'id': instance.id,
  'from_status_id': instance.fromStatusId,
  'to_status_id': instance.toStatusId,
  'to_status_code': instance.toStatusCode,
  'to_status_label': instance.toStatusLabel,
  'to_status_color': instance.toStatusColor,
  'required_permission': instance.requiredPermission,
};

_DynamicModuleDefinition _$DynamicModuleDefinitionFromJson(
  Map<String, dynamic> json,
) => _DynamicModuleDefinition(
  id: json['id'] as String,
  code: json['code'] as String,
  label: json['label'] as String,
  version: (json['version'] as num?)?.toInt() ?? 1,
  recordLabelSingular: json['record_label_singular'] as String? ?? 'Record',
  recordLabelPlural: json['record_label_plural'] as String? ?? 'Records',
  description: json['description'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  appModuleId: json['app_module_id'] as String?,
  fields:
      (json['fields'] as List<dynamic>?)
          ?.map((e) => DynamicModuleField.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DynamicModuleField>[],
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map((e) => DynamicModuleStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DynamicModuleStatus>[],
  transitions:
      (json['transitions'] as List<dynamic>?)
          ?.map(
            (e) => DynamicModuleTransition.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DynamicModuleTransition>[],
);

Map<String, dynamic> _$DynamicModuleDefinitionToJson(
  _DynamicModuleDefinition instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'label': instance.label,
  'version': instance.version,
  'record_label_singular': instance.recordLabelSingular,
  'record_label_plural': instance.recordLabelPlural,
  'description': instance.description,
  'is_active': instance.isActive,
  'app_module_id': instance.appModuleId,
  'fields': instance.fields,
  'statuses': instance.statuses,
  'transitions': instance.transitions,
};

_DynamicRecordComment _$DynamicRecordCommentFromJson(
  Map<String, dynamic> json,
) => _DynamicRecordComment(
  id: json['id'] as String,
  recordId: json['record_id'] as String,
  userId: json['user_id'] as String,
  userName: json['user_name'] as String?,
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$DynamicRecordCommentToJson(
  _DynamicRecordComment instance,
) => <String, dynamic>{
  'id': instance.id,
  'record_id': instance.recordId,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'comment': instance.comment,
  'created_at': instance.createdAt.toIso8601String(),
};

_DynamicRecordAttachment _$DynamicRecordAttachmentFromJson(
  Map<String, dynamic> json,
) => _DynamicRecordAttachment(
  id: json['id'] as String,
  recordId: json['record_id'] as String,
  userId: json['user_id'] as String,
  userName: json['user_name'] as String?,
  fileUrl: json['file_url'] as String,
  fileName: json['file_name'] as String,
  fileSize: (json['file_size'] as num?)?.toInt() ?? 0,
  mimeType: json['mime_type'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$DynamicRecordAttachmentToJson(
  _DynamicRecordAttachment instance,
) => <String, dynamic>{
  'id': instance.id,
  'record_id': instance.recordId,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'file_url': instance.fileUrl,
  'file_name': instance.fileName,
  'file_size': instance.fileSize,
  'mime_type': instance.mimeType,
  'created_at': instance.createdAt.toIso8601String(),
};

_DynamicRecordActivity _$DynamicRecordActivityFromJson(
  Map<String, dynamic> json,
) => _DynamicRecordActivity(
  id: json['id'] as String,
  recordId: json['record_id'] as String,
  userId: json['user_id'] as String?,
  userName: json['user_name'] as String?,
  action: json['action'] as String,
  details: json['details'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$DynamicRecordActivityToJson(
  _DynamicRecordActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'record_id': instance.recordId,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'action': instance.action,
  'details': instance.details,
  'created_at': instance.createdAt.toIso8601String(),
};

_DynamicRecordModel _$DynamicRecordModelFromJson(Map<String, dynamic> json) =>
    _DynamicRecordModel(
      id: json['id'] as String,
      moduleId: json['module_id'] as String,
      data: json['data'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      statusId: json['status_id'] as String?,
      status: json['status'] == null
          ? null
          : DynamicModuleStatus.fromJson(
              json['status'] as Map<String, dynamic>,
            ),
      createdBy: json['created_by'] as String,
      creatorName: json['creator_name'] as String?,
      assignedTo: json['assigned_to'] as String?,
      assigneeName: json['assignee_name'] as String?,
      clientId: json['client_id'] as String?,
      clientName: json['client_name'] as String?,
      dueAt: json['due_at'] == null
          ? null
          : DateTime.parse(json['due_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      allowedTransitions:
          (json['allowed_transitions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    DynamicModuleTransition.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <DynamicModuleTransition>[],
    );

Map<String, dynamic> _$DynamicRecordModelToJson(_DynamicRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'module_id': instance.moduleId,
      'data': instance.data,
      'status_id': instance.statusId,
      'status': instance.status,
      'created_by': instance.createdBy,
      'creator_name': instance.creatorName,
      'assigned_to': instance.assignedTo,
      'assignee_name': instance.assigneeName,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'due_at': instance.dueAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'allowed_transitions': instance.allowedTransitions,
    };

_DynamicRecordDetailModel _$DynamicRecordDetailModelFromJson(
  Map<String, dynamic> json,
) => _DynamicRecordDetailModel(
  id: json['id'] as String,
  moduleId: json['module_id'] as String,
  data: json['data'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  statusId: json['status_id'] as String?,
  status: json['status'] == null
      ? null
      : DynamicModuleStatus.fromJson(json['status'] as Map<String, dynamic>),
  createdBy: json['created_by'] as String,
  creatorName: json['creator_name'] as String?,
  assignedTo: json['assigned_to'] as String?,
  assigneeName: json['assignee_name'] as String?,
  clientId: json['client_id'] as String?,
  clientName: json['client_name'] as String?,
  dueAt: json['due_at'] == null
      ? null
      : DateTime.parse(json['due_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  allowedTransitions:
      (json['allowed_transitions'] as List<dynamic>?)
          ?.map(
            (e) => DynamicModuleTransition.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DynamicModuleTransition>[],
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => DynamicRecordComment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DynamicRecordComment>[],
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map(
            (e) => DynamicRecordAttachment.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DynamicRecordAttachment>[],
  activities:
      (json['activities'] as List<dynamic>?)
          ?.map(
            (e) => DynamicRecordActivity.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DynamicRecordActivity>[],
);

Map<String, dynamic> _$DynamicRecordDetailModelToJson(
  _DynamicRecordDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'module_id': instance.moduleId,
  'data': instance.data,
  'status_id': instance.statusId,
  'status': instance.status,
  'created_by': instance.createdBy,
  'creator_name': instance.creatorName,
  'assigned_to': instance.assignedTo,
  'assignee_name': instance.assigneeName,
  'client_id': instance.clientId,
  'client_name': instance.clientName,
  'due_at': instance.dueAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'allowed_transitions': instance.allowedTransitions,
  'comments': instance.comments,
  'attachments': instance.attachments,
  'activities': instance.activities,
};

_DynamicRecordPageResponse _$DynamicRecordPageResponseFromJson(
  Map<String, dynamic> json,
) => _DynamicRecordPageResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => DynamicRecordModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DynamicRecordModel>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['page_size'] as num?)?.toInt() ?? 20,
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$DynamicRecordPageResponseToJson(
  _DynamicRecordPageResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
  'total_pages': instance.totalPages,
};

_DynamicModuleSummary _$DynamicModuleSummaryFromJson(
  Map<String, dynamic> json,
) => _DynamicModuleSummary(
  totalRecords: (json['total_records'] as num?)?.toInt() ?? 0,
  countsByStatus:
      (json['counts_by_status'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
  fieldTotals:
      (json['field_totals'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
);

Map<String, dynamic> _$DynamicModuleSummaryToJson(
  _DynamicModuleSummary instance,
) => <String, dynamic>{
  'total_records': instance.totalRecords,
  'counts_by_status': instance.countsByStatus,
  'field_totals': instance.fieldTotals,
};
