import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_module_repository.g.dart';

/// Repository handling API communication for schema-driven dynamic modules.
class DynamicModuleRepository {
  DynamicModuleRepository({required this.dio});

  final Dio dio;

  /// Fetches schema definition for [code] (`GET /modules/{code}`).
  Future<(DynamicModuleDefinition?, AppFailure?)> getDefinition(
    String code,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.moduleDefinition(code),
      );
      return (DynamicModuleDefinition.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches aggregate summary for [code] (`GET /modules/{code}/summary`).
  Future<(DynamicModuleSummary?, AppFailure?)> getSummary(String code) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.moduleSummary(code),
      );
      return (DynamicModuleSummary.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Lists paginated records with optional search, status, and filter params.
  Future<(DynamicRecordPageResponse?, AppFailure?)> listRecords(
    String code, {
    int page = 1,
    int pageSize = 20,
    String? search,
    String? status,
    String? sortBy,
    bool sortDesc = true,
    Map<String, dynamic>? dynamicFilters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'page_size': pageSize,
        'sort_desc': sortDesc,
      };
      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }
      if (status != null && status.trim().isNotEmpty) {
        queryParams['status'] = status.trim();
      }
      if (sortBy != null && sortBy.trim().isNotEmpty) {
        queryParams['sort_by'] = sortBy.trim();
      }
      if (dynamicFilters != null && dynamicFilters.isNotEmpty) {
        queryParams.addAll(dynamicFilters);
      }

      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.moduleRecords(code),
        queryParameters: queryParams,
      );
      return (DynamicRecordPageResponse.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches single record detail with comments, attachments & activities.
  Future<(DynamicRecordDetailModel?, AppFailure?)> getRecord(
    String code,
    String id,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.moduleRecordDetail(code, id),
      );
      return (DynamicRecordDetailModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Creates a new record in [code].
  Future<(DynamicRecordModel?, AppFailure?)> createRecord(
    String code, {
    required Map<String, dynamic> data,
    String? statusId,
    String? assignedTo,
    String? clientId,
    DateTime? dueAt,
  }) async {
    try {
      final body = <String, dynamic>{
        'data': data,
        if (statusId != null) 'status_id': statusId,
        if (assignedTo != null) 'assigned_to': assignedTo,
        if (clientId != null) 'client_id': clientId,
        if (dueAt != null) 'due_at': dueAt.toUtc().toIso8601String(),
      };
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.moduleRecords(code),
        data: body,
      );
      return (DynamicRecordModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Updates an existing record's fields or assignments.
  Future<(DynamicRecordModel?, AppFailure?)> updateRecord(
    String code,
    String id, {
    required Map<String, dynamic> data,
    String? statusId,
    String? assignedTo,
    String? clientId,
    DateTime? dueAt,
  }) async {
    try {
      final body = <String, dynamic>{
        'data': data,
        if (statusId != null) 'status_id': statusId,
        if (assignedTo != null) 'assigned_to': assignedTo,
        if (clientId != null) 'client_id': clientId,
        if (dueAt != null) 'due_at': dueAt.toUtc().toIso8601String(),
      };
      final response = await dio.put<Map<String, dynamic>>(
        ApiEndpoints.moduleRecordDetail(code, id),
        data: body,
      );
      return (DynamicRecordModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Deletes a record.
  Future<AppFailure?> deleteRecord(String code, String id) async {
    try {
      await dio.delete<dynamic>(ApiEndpoints.moduleRecordDetail(code, id));
      return null;
    } on Object catch (error) {
      return ErrorMapper.mapException(error);
    }
  }

  /// Changes a record's status via allowed transition.
  Future<(DynamicRecordModel?, AppFailure?)> changeStatus(
    String code,
    String id, {
    required String toStatusId,
    String? note,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.moduleRecordStatus(code, id),
        data: <String, dynamic>{
          'to_status_id': toStatusId,
          if (note != null && note.trim().isNotEmpty) 'note': note.trim(),
        },
      );
      return (DynamicRecordModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Adds a comment to a record.
  Future<(DynamicRecordComment?, AppFailure?)> addComment(
    String code,
    String id,
    String comment,
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.moduleRecordComments(code, id),
        data: <String, dynamic>{'comment': comment.trim()},
      );
      return (DynamicRecordComment.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Adds a file attachment to a record.
  Future<(DynamicRecordAttachment?, AppFailure?)> addAttachment(
    String code,
    String id, {
    required String fileUrl,
    required String fileName,
    int fileSize = 0,
    String? mimeType,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.moduleRecordAttachments(code, id),
        data: <String, dynamic>{
          'file_url': fileUrl,
          'file_name': fileName,
          'file_size': fileSize,
          if (mimeType != null) 'mime_type': mimeType,
        },
      );
      return (DynamicRecordAttachment.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Downloads exported records as bytes (`GET /modules/{code}/export?format=csv|xlsx`).
  Future<(List<int>?, String?, AppFailure?)> exportRecords(
    String code, {
    String format = 'csv',
  }) async {
    try {
      final response = await dio.get<List<dynamic>>(
        ApiEndpoints.moduleExport(code),
        queryParameters: <String, dynamic>{'format': format},
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = response.data?.cast<int>();
      return (bytes, format, null);
    } on Object catch (error) {
      return (null, null, ErrorMapper.mapException(error));
    }
  }
}

@Riverpod(keepAlive: true)
DynamicModuleRepository dynamicModuleRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return DynamicModuleRepository(dio: dio);
}
