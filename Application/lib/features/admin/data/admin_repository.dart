import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/admin_models.dart';

part 'admin_repository.g.dart';

class AdminRepository {
  AdminRepository(this._dio);

  final Dio _dio;

  // ---------------------------------------------------------------------------
  // Employees
  // ---------------------------------------------------------------------------

  Future<List<EmployeeItem>> getEmployees({
    String? search,
    String? departmentId,
    String? roleId,
    bool? isActive,
    int page = 1,
    int pageSize = 20,
  }) async {
    final query = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
      if (search != null && search.isNotEmpty) 'search': search,
      if (departmentId != null && departmentId.isNotEmpty)
        'department_id': departmentId,
      if (roleId != null && roleId.isNotEmpty) 'role_id': roleId,
      if (isActive != null) 'is_active': isActive,
    };

    final response = await _dio.get<dynamic>(
      ApiEndpoints.employees,
      queryParameters: query,
    );

    final raw = response.data;
    final List<dynamic> items;
    if (raw is List) {
      items = raw;
    } else if (raw is Map<String, dynamic> && raw['items'] is List) {
      items = raw['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }

    return items
        .map((e) => EmployeeItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<EmployeeItem> getEmployeeDetail(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.employeeDetail(id),
    );
    return EmployeeItem.fromJson(response.data!);
  }

  Future<EmployeeItem> createEmployee(EmployeeCreatePayload payload) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.employees,
      data: payload.toJson(),
    );
    return EmployeeItem.fromJson(response.data!);
  }

  Future<EmployeeItem> updateEmployee(
    String id,
    EmployeeUpdatePayload payload,
  ) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      ApiEndpoints.employeeDetail(id),
      data: payload.toJson(),
    );
    return EmployeeItem.fromJson(response.data!);
  }

  Future<void> activateEmployee(String id) async {
    await _dio.post<dynamic>(ApiEndpoints.employeeActivate(id));
  }

  Future<void> deactivateEmployee(String id) async {
    await _dio.post<dynamic>(ApiEndpoints.employeeDeactivate(id));
  }

  Future<void> resetPassword(String id, {String? newPassword}) async {
    await _dio.post<dynamic>(
      ApiEndpoints.employeeResetPassword(id),
      data: <String, dynamic>{
        if (newPassword != null) 'new_password': newPassword,
      },
    );
  }

  Future<void> assignRole(String id, String roleId) async {
    await _dio.patch<dynamic>(
      ApiEndpoints.employeeRole(id),
      queryParameters: <String, dynamic>{'role_id': roleId},
    );
  }

  Future<void> assignManager(String id, String? managerId) async {
    await _dio.patch<dynamic>(
      ApiEndpoints.employeeManager(id),
      queryParameters: <String, dynamic>{
        if (managerId != null) 'manager_id': managerId,
      },
    );
  }

  Future<void> assignAttendancePolicy(String id, String? policyId) async {
    await _dio.patch<dynamic>(
      ApiEndpoints.employeeAttendancePolicy(id),
      queryParameters: <String, dynamic>{
        if (policyId != null) 'policy_id': policyId,
      },
    );
  }

  Future<void> resetDevice(String userId) async {
    await _dio.post<dynamic>(ApiEndpoints.userResetDevice(userId));
  }

  Future<BulkImportReport> bulkImportEmployees({
    required List<int> fileBytes,
    required String fileName,
    bool dryRun = false,
  }) async {
    final formData = FormData.fromMap(<String, dynamic>{
      'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
      'dry_run': dryRun,
    });

    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.employeesBulkImport,
      data: formData,
    );

    return BulkImportReport.fromJson(response.data!);
  }

  // ---------------------------------------------------------------------------
  // Roles
  // ---------------------------------------------------------------------------

  Future<List<RoleItem>> getRoles() async {
    final response = await _dio.get<dynamic>(ApiEndpoints.roles);
    final raw = response.data;
    final List<dynamic> items;
    if (raw is List) {
      items = raw;
    } else if (raw is Map<String, dynamic> && raw['items'] is List) {
      items = raw['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }

    return items
        .map((e) => RoleItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Master Data CRUD
  // ---------------------------------------------------------------------------

  Future<List<MasterDataItem>> getMasterDataList(String basePath) async {
    final response = await _dio.get<dynamic>(basePath);
    final raw = response.data;
    final List<dynamic> items;
    if (raw is List) {
      items = raw;
    } else if (raw is Map<String, dynamic> && raw['items'] is List) {
      items = raw['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }

    return items
        .map((e) => MasterDataItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<MasterDataItem> createMasterDataItem(
    String basePath,
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      basePath,
      data: data,
    );
    return MasterDataItem.fromJson(response.data!);
  }

  Future<MasterDataItem> updateMasterDataItem(
    String itemPath,
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      itemPath,
      data: data,
    );
    return MasterDataItem.fromJson(response.data!);
  }

  Future<void> deleteMasterDataItem(String itemPath) async {
    await _dio.delete<dynamic>(itemPath);
  }
}

@riverpod
AdminRepository adminRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AdminRepository(dio);
}
