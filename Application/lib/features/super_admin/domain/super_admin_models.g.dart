// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_admin_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PermissionModel _$PermissionModelFromJson(Map<String, dynamic> json) =>
    _PermissionModel(
      id: json['id'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PermissionModelToJson(_PermissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
    };

_RoleDetailModel _$RoleDetailModelFromJson(Map<String, dynamic> json) =>
    _RoleDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isSystem: json['is_system'] as bool? ?? false,
      userCount: (json['user_count'] as num?)?.toInt() ?? 0,
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PermissionModel>[],
    );

Map<String, dynamic> _$RoleDetailModelToJson(_RoleDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_system': instance.isSystem,
      'user_count': instance.userCount,
      'permissions': instance.permissions,
    };

_RoleUpsertRequest _$RoleUpsertRequestFromJson(Map<String, dynamic> json) =>
    _RoleUpsertRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      permissionIds:
          (json['permission_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$RoleUpsertRequestToJson(_RoleUpsertRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'permission_ids': instance.permissionIds,
    };

_SystemSettingModel _$SystemSettingModelFromJson(Map<String, dynamic> json) =>
    _SystemSettingModel(
      key: json['key'] as String,
      value: json['value'],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SystemSettingModelToJson(_SystemSettingModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'description': instance.description,
    };

_SystemSettingUpdateRequest _$SystemSettingUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _SystemSettingUpdateRequest(value: json['value']);

Map<String, dynamic> _$SystemSettingUpdateRequestToJson(
  _SystemSettingUpdateRequest instance,
) => <String, dynamic>{'value': instance.value};

_AuditLogItemModel _$AuditLogItemModelFromJson(Map<String, dynamic> json) =>
    _AuditLogItemModel(
      id: json['id'] as String,
      actorId: json['actor_id'] as String?,
      actorName: json['actor_name'] as String?,
      actorEmail: json['actor_email'] as String?,
      action: json['action'] as String,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String,
      oldData: json['old_data'] as Map<String, dynamic>?,
      newData: json['new_data'] as Map<String, dynamic>?,
      ipAddress: json['ip_address'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AuditLogItemModelToJson(_AuditLogItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actor_id': instance.actorId,
      'actor_name': instance.actorName,
      'actor_email': instance.actorEmail,
      'action': instance.action,
      'entity_type': instance.entityType,
      'entity_id': instance.entityId,
      'old_data': instance.oldData,
      'new_data': instance.newData,
      'ip_address': instance.ipAddress,
      'created_at': instance.createdAt.toIso8601String(),
    };

_AuditLogQueryResponse _$AuditLogQueryResponseFromJson(
  Map<String, dynamic> json,
) => _AuditLogQueryResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => AuditLogItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AuditLogItemModel>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  size: (json['size'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$AuditLogQueryResponseToJson(
  _AuditLogQueryResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'size': instance.size,
};

_NotificationTemplateModel _$NotificationTemplateModelFromJson(
  Map<String, dynamic> json,
) => _NotificationTemplateModel(
  id: json['id'] as String,
  code: json['code'] as String,
  titleTemplate: json['title_template'] as String,
  bodyTemplate: json['body_template'] as String,
  channelPush: json['channel_push'] as bool? ?? true,
  channelEmail: json['channel_email'] as bool? ?? false,
  channelSms: json['channel_sms'] as bool? ?? false,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationTemplateModelToJson(
  _NotificationTemplateModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'title_template': instance.titleTemplate,
  'body_template': instance.bodyTemplate,
  'channel_push': instance.channelPush,
  'channel_email': instance.channelEmail,
  'channel_sms': instance.channelSms,
  'is_active': instance.isActive,
};

_NotificationTemplateUpdateRequest _$NotificationTemplateUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _NotificationTemplateUpdateRequest(
  titleTemplate: json['title_template'] as String,
  bodyTemplate: json['body_template'] as String,
  channelPush: json['channel_push'] as bool?,
  channelEmail: json['channel_email'] as bool?,
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$NotificationTemplateUpdateRequestToJson(
  _NotificationTemplateUpdateRequest instance,
) => <String, dynamic>{
  'title_template': instance.titleTemplate,
  'body_template': instance.bodyTemplate,
  'channel_push': instance.channelPush,
  'channel_email': instance.channelEmail,
  'is_active': instance.isActive,
};
