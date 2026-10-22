import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'admin_attendance_repository.g.dart';

class AdminAttendanceRepository {
  AdminAttendanceRepository(this._dio);

  final Dio _dio;

  Future<AttendanceTodayReportResponse> getTodayDashboard({
    String? departmentId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.attendanceTodayReport,
      queryParameters: <String, dynamic>{
        if (departmentId != null && departmentId.isNotEmpty)
          'department_id': departmentId,
      },
    );
    return AttendanceTodayReportResponse.fromJson(response.data!);
  }

  Future<EmployeeMonthlyReportResponse> getEmployeeMonthly(
    String employeeId, {
    int? month,
    int? year,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.employeeMonthlyAttendanceReport(employeeId),
      queryParameters: <String, dynamic>{
        'month': ?month,
        'year': ?year,
      },
    );
    return EmployeeMonthlyReportResponse.fromJson(response.data!);
  }

  Future<EmployeeYearlyReportResponse> getEmployeeYearly(
    String employeeId, {
    int? year,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.employeeYearlyAttendanceReport(employeeId),
      queryParameters: <String, dynamic>{
        'year': ?year,
      },
    );
    return EmployeeYearlyReportResponse.fromJson(response.data!);
  }

  Future<MonthlyOverviewResponse> getMonthlyOverview({
    required int month,
    required int year,
    String? departmentId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.attendanceMonthlyOverview,
      queryParameters: <String, dynamic>{
        'month': month,
        'year': year,
        if (departmentId != null && departmentId.isNotEmpty)
          'department_id': departmentId,
      },
    );
    return MonthlyOverviewResponse.fromJson(response.data!);
  }

  Future<AttendanceCorrectionResponse> submitCorrection(
    String recordId,
    AttendanceCorrectionRequest request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.attendanceCorrection(recordId),
      data: request.toJson(),
    );
    return AttendanceCorrectionResponse.fromJson(response.data!);
  }

  Future<String> exportReport({
    required String reportType,
    required String format,
    int? month,
    int? year,
    String? departmentId,
    String? employeeId,
  }) async {
    final response = await _dio.get<List<int>>(
      ApiEndpoints.attendanceExport,
      queryParameters: <String, dynamic>{
        'report_type': reportType,
        'format': format,
        'month': ?month,
        'year': ?year,
        if (departmentId != null && departmentId.isNotEmpty)
          'department_id': departmentId,
        if (employeeId != null && employeeId.isNotEmpty)
          'employee_id': employeeId,
      },
      options: Options(responseType: ResponseType.bytes),
    );

    final bytes = response.data!;
    final tempDir = await getTemporaryDirectory();
    final fileName =
        'attendance_${reportType}_${DateTime.now().millisecondsSinceEpoch}.$format';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Attendance Export: $fileName',
      ),
    );

    return file.path;
  }
}

@riverpod
AdminAttendanceRepository adminAttendanceRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AdminAttendanceRepository(dio);
}
