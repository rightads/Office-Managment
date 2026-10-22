import 'package:freezed_annotation/freezed_annotation.dart';

part 'super_admin_models.freezed.dart';
part 'super_admin_models.g.dart';

/// Single permission entity from `GET /api/v1/permissions`.
@freezed
abstract class PermissionModel with _$PermissionModel {
  const factory PermissionModel({
    required String id,
    required String code,
    required String description,
  }) = _PermissionModel;

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);
}

/// Detailed role record with assigned permissions from `GET /api/v1/roles`.
@freezed
abstract class RoleDetailModel with _$RoleDetailModel {
  const factory RoleDetailModel({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'is_system') @Default(false) bool isSystem,
    @JsonKey(name: 'user_count') @Default(0) int userCount,
    @Default(<PermissionModel>[]) List<PermissionModel> permissions,
  }) = _RoleDetailModel;

  factory RoleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RoleDetailModelFromJson(json);
}

/// Request payload for creating or editing roles (`POST /roles` or `PATCH /roles/{id}`).
@freezed
abstract class RoleUpsertRequest with _$RoleUpsertRequest {
  const factory RoleUpsertRequest({
    required String name,
    String? description,
    @JsonKey(name: 'permission_ids')
    @Default(<String>[])
    List<String> permissionIds,
  }) = _RoleUpsertRequest;

  factory RoleUpsertRequest.fromJson(Map<String, dynamic> json) =>
      _$RoleUpsertRequestFromJson(json);
}

/// System setting item from `GET /api/v1/system-settings`.
@freezed
abstract class SystemSettingModel with _$SystemSettingModel {
  const factory SystemSettingModel({
    required String key,
    required dynamic value,
    String? description,
  }) = _SystemSettingModel;

  factory SystemSettingModel.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingModelFromJson(json);
}

/// Request payload to update a system setting value.
@freezed
abstract class SystemSettingUpdateRequest with _$SystemSettingUpdateRequest {
  const factory SystemSettingUpdateRequest({
    required dynamic value,
  }) = _SystemSettingUpdateRequest;

  factory SystemSettingUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingUpdateRequestFromJson(json);
}

/// Single immutable audit log record from `GET /api/v1/audit-logs`.
@freezed
abstract class AuditLogItemModel with _$AuditLogItemModel {
  const factory AuditLogItemModel({
    required String id,
    required String action,
    @JsonKey(name: 'entity_type') required String entityType,
    @JsonKey(name: 'entity_id') required String entityId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'actor_id') String? actorId,
    @JsonKey(name: 'actor_name') String? actorName,
    @JsonKey(name: 'actor_email') String? actorEmail,
    @JsonKey(name: 'old_data') Map<String, dynamic>? oldData,
    @JsonKey(name: 'new_data') Map<String, dynamic>? newData,
    @JsonKey(name: 'ip_address') String? ipAddress,
  }) = _AuditLogItemModel;

  factory AuditLogItemModel.fromJson(Map<String, dynamic> json) =>
      _$AuditLogItemModelFromJson(json);
}

/// Paginated audit logs response.
@freezed
abstract class AuditLogQueryResponse with _$AuditLogQueryResponse {
  const factory AuditLogQueryResponse({
    @Default(<AuditLogItemModel>[]) List<AuditLogItemModel> items,
    @Default(0) int total,
    @Default(1) int page,
    @Default(20) int size,
  }) = _AuditLogQueryResponse;

  factory AuditLogQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$AuditLogQueryResponseFromJson(json);
}

/// Notification template configuration from `GET /api/v1/notifications/templates`.
@freezed
abstract class NotificationTemplateModel with _$NotificationTemplateModel {
  const factory NotificationTemplateModel({
    required String id,
    required String code,
    @JsonKey(name: 'title_template') required String titleTemplate,
    @JsonKey(name: 'body_template') required String bodyTemplate,
    @JsonKey(name: 'channel_push') @Default(true) bool channelPush,
    @JsonKey(name: 'channel_email') @Default(false) bool channelEmail,
    @JsonKey(name: 'channel_sms') @Default(false) bool channelSms,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _NotificationTemplateModel;

  factory NotificationTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationTemplateModelFromJson(json);
}

/// Request to update a notification template.
@freezed
abstract class NotificationTemplateUpdateRequest
    with _$NotificationTemplateUpdateRequest {
  const factory NotificationTemplateUpdateRequest({
    @JsonKey(name: 'title_template') required String titleTemplate,
    @JsonKey(name: 'body_template') required String bodyTemplate,
    @JsonKey(name: 'channel_push') bool? channelPush,
    @JsonKey(name: 'channel_email') bool? channelEmail,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _NotificationTemplateUpdateRequest;

  factory NotificationTemplateUpdateRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$NotificationTemplateUpdateRequestFromJson(json);
}
