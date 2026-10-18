import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance_repository.g.dart';

/// Repository for Employee Attendance, Effective Attendance Policy, Monthly
/// Calendar, and Monthly/Yearly Attendance Reports.
class AttendanceRepository {
  AttendanceRepository({required this._dio});

  final Dio _dio;

  /// Fetches the current employee's effective attendance policy
  /// (`GET /api/v1/me/attendance-policy`).
  Future<(EffectiveAttendancePolicyModel?, AppFailure?)>
  fetchEffectivePolicy() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.meAttendancePolicy,
      );
      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (EffectiveAttendancePolicyModel.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches today's attendance record (`GET /api/v1/attendance/today`).
  ///
  /// Returns `(null, null)` when the employee has not yet checked in today.
  Future<(AttendanceRecordModel?, AppFailure?)> fetchTodayAttendance() async {
    try {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.attendanceToday,
      );
      final raw = response.data;
      if (raw == null) {
        return (null, null);
      }
      if (raw is Map<String, dynamic>) {
        if (raw.containsKey('data') && raw['data'] == null) {
          return (null, null);
        }
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        if (payload.isEmpty || !payload.containsKey('id')) {
          return (null, null);
        }
        return (AttendanceRecordModel.fromJson(payload), null);
      }
      return (null, null);
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Submits an attendance check-in (`POST /api/v1/attendance/check-in`).
  Future<(AttendanceRecordModel?, AppFailure?)> checkIn(
    CheckInRequestPayload payload,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.attendanceCheckIn,
        data: payload.toJson(),
      );
      final raw = response.data;
      if (raw != null) {
        final data = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (AttendanceRecordModel.fromJson(data), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Submits an attendance check-out (`POST /api/v1/attendance/check-out`).
  Future<(AttendanceRecordModel?, AppFailure?)> checkOut(
    CheckOutRequestPayload payload,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.attendanceCheckOut,
        data: payload.toJson(),
      );
      final raw = response.data;
      if (raw != null) {
        final data = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (AttendanceRecordModel.fromJson(data), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches the current employee's monthly attendance calendar
  /// (`GET /api/v1/attendance/me?month=&year=`).
  Future<(AttendanceCalendarModel?, AppFailure?)> fetchMyCalendar({
    required int month,
    required int year,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.attendanceMe,
        queryParameters: <String, dynamic>{
          'month': month,
          'year': year,
        },
      );
      final raw = response.data;
      if (raw != null) {
        final data = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (AttendanceCalendarModel.fromJson(data), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches the detailed monthly attendance report for [employeeId]
  /// (`GET /api/v1/reports/attendance/employee/{id}/monthly?month=&year=`).
  Future<(EmployeeMonthlyReportModel?, AppFailure?)> fetchMonthlyReport({
    required String employeeId,
    required int month,
    required int year,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.employeeMonthlyAttendanceReport(employeeId),
        queryParameters: <String, dynamic>{
          'month': month,
          'year': year,
        },
      );
      final raw = response.data;
      if (raw != null) {
        final data = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (EmployeeMonthlyReportModel.fromJson(data), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches the yearly month-wise attendance summary report for [employeeId]
  /// (`GET /api/v1/reports/attendance/employee/{id}/yearly?year=`).
  Future<(EmployeeYearlyReportModel?, AppFailure?)> fetchYearlyReport({
    required String employeeId,
    required int year,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.employeeYearlyAttendanceReport(employeeId),
        queryParameters: <String, dynamic>{
          'year': year,
        },
      );
      final raw = response.data;
      if (raw != null) {
        final data = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (EmployeeYearlyReportModel.fromJson(data), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }
}

@Riverpod(keepAlive: true)
AttendanceRepository attendanceRepository(Ref ref) {
  return AttendanceRepository(dio: ref.watch(dioProvider));
}
