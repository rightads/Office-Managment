import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leave_repository.g.dart';

/// Repository managing leave balances, leave applications, live previews,
/// requests history, and company holiday calendars.
class LeaveRepository {
  LeaveRepository({required this.dio});

  final Dio dio;

  /// Fetches leave balances for the given calendar year (`GET /api/v1/leaves/my-balances`).
  Future<(List<LeaveBalanceModel>?, AppFailure?)> getMyBalances({
    int? year,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (year != null) {
        queryParams['year'] = year;
      }

      final response = await dio.get<dynamic>(
        ApiEndpoints.leaveBalances,
        queryParameters: queryParams,
      );

      final rawList = _extractList(response.data);
      final balances = rawList
          .map(
            (e) =>
                LeaveBalanceModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();

      return (balances, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches active leave types (`GET /api/v1/leaves/types`).
  Future<(List<LeaveTypeModel>?, AppFailure?)> getLeaveTypes() async {
    try {
      final response = await dio.get<dynamic>(ApiEndpoints.leaveTypes);
      final rawList = _extractList(response.data);
      final types = rawList
          .map(
            (e) => LeaveTypeModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();

      return (types, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches employee's submitted leave requests (`GET /api/v1/leaves/my-requests`).
  Future<(LeaveRequestListResponse?, AppFailure?)> getMyRequests({
    String? status,
    int? year,
    int page = 1,
    int size = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': size,
      };
      if (status != null &&
          status.isNotEmpty &&
          status.toLowerCase() != 'all') {
        queryParams['status'] = status.toLowerCase();
      }
      if (year != null) {
        queryParams['year'] = year;
      }

      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.leaveMyRequests,
        queryParameters: queryParams,
      );

      final result = LeaveRequestListResponse.fromJson(response.data!);
      return (result, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches a single leave application by ID (`GET /api/v1/leaves/{id}`).
  Future<(LeaveRequestModel?, AppFailure?)> getLeaveById(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.leaveDetail(id),
      );
      final leave = LeaveRequestModel.fromJson(response.data!);
      return (leave, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Previews leave working days and live validation (`POST /api/v1/leaves/preview`).
  Future<(LeavePreviewResponse?, AppFailure?)> previewLeave(
    LeavePreviewPayload payload,
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.leavePreview,
        data: payload.toJson(),
      );
      final preview = LeavePreviewResponse.fromJson(response.data!);
      return (preview, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Submits a new leave request (`POST /api/v1/leaves/apply`).
  Future<(LeaveRequestModel?, AppFailure?)> applyLeave(
    LeaveApplyPayload payload,
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.leaveApply,
        data: payload.toJson(),
      );
      final created = LeaveRequestModel.fromJson(response.data!);
      return (created, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Cancels a pending leave request (`POST /api/v1/leaves/{id}/cancel`).
  Future<(LeaveRequestModel?, AppFailure?)> cancelPendingLeave(
    String id,
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.leaveCancel(id),
      );
      final cancelled = LeaveRequestModel.fromJson(response.data!);
      return (cancelled, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Cancels an approved leave request (`POST /api/v1/leaves/{id}/cancel-approved`).
  Future<(LeaveRequestModel?, AppFailure?)> cancelApprovedLeave(
    String id, {
    String? reason,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (reason != null && reason.trim().isNotEmpty) {
        queryParams['reason'] = reason.trim();
      }

      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.leaveCancelApproved(id),
        queryParameters: queryParams,
      );
      final cancelled = LeaveRequestModel.fromJson(response.data!);
      return (cancelled, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches calendar holidays (`GET /api/v1/holidays`).
  Future<(HolidayPageResponse?, AppFailure?)> getHolidays({
    int? year,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'page_size': pageSize,
      };
      if (year != null) {
        queryParams['year'] = year;
      }

      final response = await dio.get<dynamic>(
        ApiEndpoints.holidays,
        queryParameters: queryParams,
      );

      if (response.data is Map<String, dynamic>) {
        final map = response.data as Map<String, dynamic>;
        if (map.containsKey('items')) {
          final pageRes = HolidayPageResponse.fromJson(map);
          return (pageRes, null);
        }
      }

      final rawList = _extractList(response.data);
      final items = rawList
          .map(
            (e) => HolidayModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();

      final pageRes = HolidayPageResponse(
        items: items,
        total: items.length,
        page: page,
        pageSize: pageSize,
      );
      return (pageRes, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  List<dynamic> _extractList(dynamic raw) {
    if (raw is List) {
      return raw;
    }
    if (raw is Map) {
      if (raw['items'] is List) {
        return raw['items'] as List<dynamic>;
      }
      if (raw['data'] is List) {
        return raw['data'] as List<dynamic>;
      }
    }
    return const <dynamic>[];
  }
}

@Riverpod(keepAlive: true)
LeaveRepository leaveRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return LeaveRepository(dio: dio);
}
