import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin_operations/data/admin_operations_repository.dart';
import 'package:right_ads/features/admin_operations/domain/admin_operations_models.dart';

class _FakeDioAdapter implements HttpClientAdapter {
  _FakeDioAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('AdminOperationsRepository Tests', () {
    late Dio dio;
    late AdminOperationsRepository repo;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test.com'));
      repo = AdminOperationsRepository(dio);
    });

    test('getTaskReportsSummary returns TaskSummaryReportsResponse', () async {
      dio.httpClientAdapter = _FakeDioAdapter((options) async {
        expect(options.path, '/tasks/reports/summary');
        return ResponseBody.fromString(
          '''{
            "total_tasks": 10,
            "completed_tasks": 8,
            "pending_tasks": 2,
            "overdue_tasks": 2,
            "on_time_completion_rate": 80.0,
            "by_employee": [],
            "by_department": [],
            "by_client": []
          }''',
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final result = await repo.getTaskReportsSummary();
      expect(result.totalTasks, 10);
      expect(result.overdueTasks, 2);
    });

    test('assignTask sends POST to /tasks/{id}/assign', () async {
      dio.httpClientAdapter = _FakeDioAdapter((options) async {
        expect(options.path, '/tasks/task-1/assign');
        expect(options.method, 'POST');
        return ResponseBody.fromString(
          '{"success": true}',
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      await expectLater(
        repo.assignTask('task-1', ['usr-1']),
        completes,
      );
    });

    test('approveLeave and rejectLeave hit correct endpoints', () async {
      dio.httpClientAdapter = _FakeDioAdapter((options) async {
        if (options.path.contains('approve')) {
          expect(options.path, '/leaves/lv-1/approve');
        } else if (options.path.contains('reject')) {
          expect(options.path, '/leaves/lv-2/reject');
        }
        return ResponseBody.fromString(
          '{"success": true}',
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      await repo.approveLeave('lv-1', reviewNote: 'Ok');
      await repo.rejectLeave('lv-2', reviewNote: 'Denied');
    });

    test('getMissingWorkReports fetches missing submissions', () async {
      dio.httpClientAdapter = _FakeDioAdapter((options) async {
        expect(options.path, '/work-reports/missing');
        expect(options.queryParameters['date'], '2026-10-22');
        return ResponseBody.fromString(
          '''{
            "report_date": "2026-10-22",
            "missing_count": 0,
            "users": []
          }''',
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final result = await repo.getMissingWorkReports(date: '2026-10-22');
      expect(result.missingCount, 0);
    });
  });
}
