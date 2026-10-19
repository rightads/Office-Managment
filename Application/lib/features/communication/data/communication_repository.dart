import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'communication_repository.g.dart';

/// Repository for FCM device registration, in-app notifications inbox,
/// and company/department announcements.
class CommunicationRepository {
  CommunicationRepository({required this.dio});

  final Dio dio;

  /// Registers or refreshes the employee's FCM device token with the backend.
  ///
  /// `POST /api/v1/notifications/devices`
  Future<(DeviceTokenResponseModel?, AppFailure?)> registerDeviceToken(
    DeviceTokenRegisterPayload payload,
  ) async {
    try {
      final response = await dio.post<dynamic>(
        ApiEndpoints.notificationsDevices,
        data: payload.toJson(),
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      return (DeviceTokenResponseModel.fromJson(data), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Unregisters an FCM device token on logout or device removal.
  ///
  /// `DELETE /api/v1/notifications/devices/{device_id}`
  Future<AppFailure?> unregisterDeviceToken(String deviceId) async {
    try {
      await dio.delete<dynamic>(ApiEndpoints.notificationsDevice(deviceId));
      return null;
    } on Object catch (error) {
      return ErrorMapper.mapException(error);
    }
  }

  /// Lists paginated notifications inbox for the current user.
  ///
  /// `GET /api/v1/notifications`
  Future<(NotificationPageResponse?, AppFailure?)> getNotifications({
    int page = 1,
    int pageSize = 20,
    bool unreadOnly = false,
  }) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.notifications,
        queryParameters: <String, dynamic>{
          'page': page,
          'page_size': pageSize,
          'unread_only': unreadOnly,
        },
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      return (NotificationPageResponse.fromJson(data), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Gets the unread notification badge counter for the current user.
  ///
  /// `GET /api/v1/notifications/unread-count`
  Future<(int?, AppFailure?)> getUnreadNotificationCount() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.notificationsUnreadCount,
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final count = data['unread_count'] as int? ?? 0;
      return (count, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Marks a single notification as read.
  ///
  /// `PATCH /api/v1/notifications/{id}/read`
  Future<(NotificationItemModel?, AppFailure?)> markNotificationAsRead(
    String notificationId,
  ) async {
    try {
      final response = await dio.patch<dynamic>(
        ApiEndpoints.notificationRead(notificationId),
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      return (NotificationItemModel.fromJson(data), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Marks all inbox notifications as read.
  ///
  /// `POST /api/v1/notifications/read-all`
  Future<(String?, AppFailure?)> markAllNotificationsAsRead() async {
    try {
      final response = await dio.post<dynamic>(
        ApiEndpoints.notificationsReadAll,
      );
      final data = response.data is Map
          ? Map<String, dynamic>.from(response.data as Map)
          : <String, dynamic>{};
      final message =
          data['message'] as String? ?? 'All notifications marked as read.';
      return (message, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Lists active announcements for the employee (filtered by department on server).
  ///
  /// `GET /api/v1/announcements`
  Future<(List<AnnouncementModel>?, AppFailure?)> getAnnouncements() async {
    try {
      final response = await dio.get<dynamic>(ApiEndpoints.announcements);
      final list = _extractList(response.data);
      final items = list
          .map(
            (e) =>
                AnnouncementModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return (items, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Gets details for a single announcement by ID.
  ///
  /// `GET /api/v1/announcements/{id}`
  Future<(AnnouncementModel?, AppFailure?)> getAnnouncementDetail(
    String announcementId,
  ) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.announcementDetail(announcementId),
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      return (AnnouncementModel.fromJson(data), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  List<dynamic> _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map) {
      if (data['items'] is List) return data['items'] as List<dynamic>;
      if (data['data'] is List) return data['data'] as List<dynamic>;
    }
    return const <dynamic>[];
  }
}

@Riverpod(keepAlive: true)
CommunicationRepository communicationRepository(Ref ref) {
  final client = ref.watch(dioProvider);
  return CommunicationRepository(dio: client);
}
