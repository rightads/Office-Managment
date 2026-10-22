import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/features/admin_attendance/data/admin_attendance_repository.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';

class _FakeDio extends Fake implements Dio {
  dynamic nextGetResponse;
  dynamic nextPostResponse;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response<T>(
      data: nextGetResponse as T,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response<T>(
      data: nextPostResponse as T,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }
}

void main() {
  late _FakeDio fakeDio;
  late AdminAttendanceRepository repository;

  setUp(() {
    fakeDio = _FakeDio();
    repository = AdminAttendanceRepository(fakeDio);
  });

  group('AdminAttendanceRepository', () {
    test('getTodayDashboard returns AttendanceTodayReportResponse', () async {
      fakeDio.nextGetResponse = <String, dynamic>{
        'date': '2026-10-22',
        'total_active_employees': 10,
        'present_count': 8,
        'absent_count': 1,
        'late_count': 1,
        'half_day_count': 0,
        'on_leave_count': 0,
        'status_breakdown': <dynamic>[],
      };

      final res = await repository.getTodayDashboard();
      expect(res.totalActiveEmployees, 10);
      expect(res.presentCount, 8);
    });

    test('getMonthlyOverview returns MonthlyOverviewResponse', () async {
      fakeDio.nextGetResponse = <String, dynamic>{
        'month': 10,
        'year': 2026,
        'total_employees': 5,
        'rows': <dynamic>[],
      };

      final res = await repository.getMonthlyOverview(month: 10, year: 2026);
      expect(res.totalEmployees, 5);
      expect(res.month, 10);
    });

    test(
      'submitCorrection posts to correct endpoint and parses response',
      () async {
        fakeDio.nextPostResponse = <String, dynamic>{
          'id': 'c1',
          'attendance_id': 'att1',
          'changed_by': 'u1',
          'reason': 'Approved punch correction',
          'status': 'APPROVED',
          'created_at': '2026-10-22T08:00:00Z',
        };

        final res = await repository.submitCorrection(
          'att1',
          const AttendanceCorrectionRequest(
            reason: 'Approved punch correction',
          ),
        );

        expect(res.id, 'c1');
        expect(res.reason, 'Approved punch correction');
      },
    );
  });
}
