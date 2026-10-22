import 'package:dio/dio.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'super_admin_repository.g.dart';

class SuperAdminRepository {
  SuperAdminRepository(this._dio);

  final Dio _dio;

  // Roles & Permissions
  Future<List<RoleDetailModel>> getRoles() async {
    final response = await _dio.get<dynamic>(ApiEndpoints.roles);
    final data = response.data;
    final List<dynamic> items;
    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }
    return items
        .map((e) => RoleDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PermissionModel>> getPermissions() async {
    final response = await _dio.get<dynamic>(ApiEndpoints.permissions);
    final data = response.data;
    final List<dynamic> items;
    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }
    return items
        .map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createRole(RoleUpsertRequest request) async {
    await _dio.post<dynamic>(
      ApiEndpoints.roles,
      data: request.toJson(),
    );
  }

  Future<void> updateRole(String roleId, RoleUpsertRequest request) async {
    await _dio.patch<dynamic>(
      ApiEndpoints.roleDetail(roleId),
      data: request.toJson(),
    );
  }

  Future<void> deleteRole(String roleId) async {
    await _dio.delete<dynamic>(ApiEndpoints.roleDetail(roleId));
  }

  // System Settings
  Future<List<SystemSettingModel>> getSystemSettings() async {
    final response = await _dio.get<dynamic>(ApiEndpoints.systemSettings);
    final data = response.data;
    final List<dynamic> items;
    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }
    return items
        .map((e) => SystemSettingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateSystemSetting(String key, dynamic value) async {
    await _dio.post<dynamic>(
      ApiEndpoints.systemSettings,
      data: <String, dynamic>{
        'key': key,
        'value': value,
      },
    );
  }

  // Audit Logs
  Future<AuditLogQueryResponse> getAuditLogs({
    int page = 1,
    int size = 20,
    String? actorId,
    String? entityType,
    String? action,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.auditLogs,
      queryParameters: <String, dynamic>{
        'page': page,
        'size': size,
        if (actorId != null && actorId.isNotEmpty) 'actor_id': actorId,
        if (entityType != null && entityType.isNotEmpty)
          'entity_type': entityType,
        if (action != null && action.isNotEmpty) 'action': action,
      },
    );
    return AuditLogQueryResponse.fromJson(response.data!);
  }

  // Notification Templates
  Future<List<NotificationTemplateModel>> getNotificationTemplates() async {
    final response = await _dio.get<dynamic>(
      ApiEndpoints.notificationTemplates,
    );
    final data = response.data;
    final List<dynamic> items;
    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }
    return items
        .map(
          (e) => NotificationTemplateModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> updateNotificationTemplate(
    String code,
    NotificationTemplateUpdateRequest request,
  ) async {
    await _dio.patch<dynamic>(
      ApiEndpoints.notificationTemplate(code),
      data: request.toJson(),
    );
  }

  // App Modules (Module Builder)
  Future<List<Map<String, dynamic>>> getAppModules() async {
    final response = await _dio.get<dynamic>(ApiEndpoints.appModules);
    final data = response.data;
    if (data is List) {
      return data.cast<Map<String, dynamic>>();
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      return (data['items'] as List<dynamic>).cast<Map<String, dynamic>>();
    }
    return <Map<String, dynamic>>[];
  }
}

@riverpod
SuperAdminRepository superAdminRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SuperAdminRepository(dio);
}
