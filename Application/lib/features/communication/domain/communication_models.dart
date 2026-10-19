import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

part 'communication_models.freezed.dart';
part 'communication_models.g.dart';

/// Single in-app notification item received from `GET /api/v1/notifications`.
@freezed
abstract class NotificationItemModel with _$NotificationItemModel {
  const factory NotificationItemModel({
    required String id,
    required String title,
    required String body,
    required String type,
    @JsonKey(name: 'is_read') required bool isRead,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
  }) = _NotificationItemModel;

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemModelFromJson(json);
}

/// Paginated notifications response.
@freezed
abstract class NotificationPageResponse with _$NotificationPageResponse {
  const factory NotificationPageResponse({
    required List<NotificationItemModel> items,
    required int total,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
    @JsonKey(name: 'total_pages') required int totalPages,
  }) = _NotificationPageResponse;

  factory NotificationPageResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationPageResponseFromJson(json);
}

/// Company or department announcement from `GET /api/v1/announcements`.
@freezed
abstract class AnnouncementModel with _$AnnouncementModel {
  const factory AnnouncementModel({
    required String id,
    required String title,
    required String body,
    required UserBriefModel creator,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'target_department_id') String? targetDepartmentId,
    @JsonKey(name: 'target_department_name') String? targetDepartmentName,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _AnnouncementModel;

  const AnnouncementModel._();

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);

  /// Whether this announcement is past its expiration date.
  bool get isExpired =>
      expiresAt != null && expiresAt!.isBefore(DateTime.now());

  /// Whether this announcement is company-wide (not targeted to a single department).
  bool get isCompanyWide =>
      targetDepartmentId == null || targetDepartmentId!.isEmpty;
}

/// Request body for `POST /api/v1/notifications/devices`.
@freezed
abstract class DeviceTokenRegisterPayload with _$DeviceTokenRegisterPayload {
  const factory DeviceTokenRegisterPayload({
    @JsonKey(name: 'fcm_token') required String fcmToken,
    @JsonKey(name: 'device_id') required String deviceId,
    required String platform,
  }) = _DeviceTokenRegisterPayload;

  factory DeviceTokenRegisterPayload.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenRegisterPayloadFromJson(json);
}

/// Response returned from `POST /api/v1/notifications/devices`.
@freezed
abstract class DeviceTokenResponseModel with _$DeviceTokenResponseModel {
  const factory DeviceTokenResponseModel({
    required String id,
    @JsonKey(name: 'device_id') required String deviceId,
    required String platform,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _DeviceTokenResponseModel;

  factory DeviceTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenResponseModelFromJson(json);
}
