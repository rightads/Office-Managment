import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'work_report_repository.g.dart';

/// Repository for the employee's daily work reports / timesheets
/// (`/api/v1/work-reports`). Manager/admin endpoints are added in Prompt 14.
class WorkReportRepository {
  WorkReportRepository({required this.dio});

  final Dio dio;

  /// Fetches the authenticated user's report for [date]
  /// (`GET /api/v1/work-reports/by-date/{date}`).
  ///
  /// A `null` report with a `null` failure means "no report exists yet".
  Future<(WorkReportModel?, AppFailure?)> getByDate(DateTime date) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.workReportByDate(WorkReportRules.toIsoDate(date)),
      );
      final data = response.data;
      if (data is Map) {
        return (WorkReportModel.fromJson(Map<String, dynamic>.from(data)), null);
      }
      return (null, null);
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        return (null, null);
      }
      return (null, ErrorMapper.mapException(dioError));
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches a single report (`GET /api/v1/work-reports/{id}`).
  Future<(WorkReportModel?, AppFailure?)> getById(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.workReportDetail(id),
      );
      return (WorkReportModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches the user's report history (`GET /api/v1/work-reports/me`).
  Future<(WorkReportPageResponse?, AppFailure?)> getMyReports({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final query = <String, dynamic>{'page': page, 'page_size': pageSize};
      if (status != null &&
          status.isNotEmpty &&
          status.toLowerCase() != 'all') {
        query['status'] = status.toLowerCase();
      }
      if (fromDate != null) {
        query['from_date'] = WorkReportRules.toIsoDate(fromDate);
      }
      if (toDate != null) {
        query['to_date'] = WorkReportRules.toIsoDate(toDate);
      }

      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.workReportsMe,
        queryParameters: query,
      );
      return (WorkReportPageResponse.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Creates a new draft, or refreshes the existing draft for the same date
  /// (`POST /api/v1/work-reports`).
  Future<(WorkReportModel?, AppFailure?)> createOrSaveDraft(
    WorkReportCreatePayload payload,
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.workReports,
        data: payload.toJson(),
      );
      return (WorkReportModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Updates summary and items of an existing report
  /// (`PUT /api/v1/work-reports/{id}`).
  Future<(WorkReportModel?, AppFailure?)> updateReport(
    String id,
    WorkReportUpdatePayload payload,
  ) async {
    try {
      final response = await dio.put<Map<String, dynamic>>(
        ApiEndpoints.workReportDetail(id),
        data: payload.toJson(),
      );
      return (WorkReportModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Submits a draft report for review
  /// (`POST /api/v1/work-reports/{id}/submit`).
  Future<(WorkReportModel?, AppFailure?)> submitReport(String id) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.workReportSubmit(id),
      );
      return (WorkReportModel.fromJson(response.data!), null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }
}

@Riverpod(keepAlive: true)
WorkReportRepository workReportRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return WorkReportRepository(dio: dio);
}
