// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationItemModel _$NotificationItemModelFromJson(
  Map<String, dynamic> json,
) => _NotificationItemModel(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  type: json['type'] as String,
  isRead: json['is_read'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  data: json['data'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$NotificationItemModelToJson(
  _NotificationItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'type': instance.type,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
  'data': instance.data,
};

_NotificationPageResponse _$NotificationPageResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationPageResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => NotificationItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
);

Map<String, dynamic> _$NotificationPageResponseToJson(
  _NotificationPageResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
  'total_pages': instance.totalPages,
};

_AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    _AnnouncementModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      creator: UserBriefModel.fromJson(json['creator'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      targetDepartmentId: json['target_department_id'] as String?,
      targetDepartmentName: json['target_department_name'] as String?,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$AnnouncementModelToJson(_AnnouncementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'creator': instance.creator,
      'created_at': instance.createdAt.toIso8601String(),
      'target_department_id': instance.targetDepartmentId,
      'target_department_name': instance.targetDepartmentName,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'is_active': instance.isActive,
    };

_DeviceTokenRegisterPayload _$DeviceTokenRegisterPayloadFromJson(
  Map<String, dynamic> json,
) => _DeviceTokenRegisterPayload(
  fcmToken: json['fcm_token'] as String,
  deviceId: json['device_id'] as String,
  platform: json['platform'] as String,
);

Map<String, dynamic> _$DeviceTokenRegisterPayloadToJson(
  _DeviceTokenRegisterPayload instance,
) => <String, dynamic>{
  'fcm_token': instance.fcmToken,
  'device_id': instance.deviceId,
  'platform': instance.platform,
};

_DeviceTokenResponseModel _$DeviceTokenResponseModelFromJson(
  Map<String, dynamic> json,
) => _DeviceTokenResponseModel(
  id: json['id'] as String,
  deviceId: json['device_id'] as String,
  platform: json['platform'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$DeviceTokenResponseModelToJson(
  _DeviceTokenResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'device_id': instance.deviceId,
  'platform': instance.platform,
  'created_at': instance.createdAt.toIso8601String(),
};
