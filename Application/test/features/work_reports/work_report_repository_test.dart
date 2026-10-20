import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/work_reports/data/work_report_repository.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';

class _FakeHttpClientAdapter implements HttpClientAdapter {
  _FakeHttpClientAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('WorkReportRepository Tests', () {
    late Dio dio;
    late WorkReportRepository repository;
    RequestOptions? capturedOptions;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test.com/api/v1'));
      repository = WorkReportRepository(dio: dio);
    });

    test('getByDate returns report when found (200 OK)', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'wr-101',
          'report_date': '2026-10-20T00:00:00Z',
          'status': 'draft',
          'summary': 'Developed work report feature',
          'total_minutes': 180,
          'items': [
            {
              'id': 'wri-1',
              'description': 'Designed presentation widgets',
              'minutes_spent': 180,
              'project_name': 'Right Ads App',
            },
          ],
        };
        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (report, failure) = await repository.getByDate(
        DateTime(2026, 10, 20),
      );

      expect(failure, isNull);
      expect(report, isNotNull);
      expect(report?.id, 'wr-101');
      expect(report?.summary, 'Developed work report feature');
      expect(report?.totalMinutes, 180);
      expect(report?.items.length, 1);
      expect(capturedOptions?.path, contains('/work-reports/by-date/2026-10-20'));
    });

    test('getByDate returns null without failure when 404 (no report yet)', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        return ResponseBody.fromString(
          jsonEncode({'detail': 'Not found'}),
          404,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (report, failure) = await repository.getByDate(
        DateTime(2026, 10, 20),
      );

      expect(failure, isNull);
      expect(report, isNull);
    });

    test('getById returns single report detail', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'wr-999',
          'report_date': '2026-10-19T00:00:00Z',
          'status': 'submitted',
          'summary': 'Tested backend endpoints',
          'total_minutes': 240,
          'items': [],
        };
        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (report, failure) = await repository.getById('wr-999');

      expect(failure, isNull);
      expect(report, isNotNull);
      expect(report?.id, 'wr-999');
      expect(report?.status, 'submitted');
      expect(capturedOptions?.path, contains('/work-reports/wr-999'));
    });

    test('getMyReports handles paginated list and status filter', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'items': [
            {
              'id': 'wr-1',
              'report_date': '2026-10-20T00:00:00Z',
              'status': 'draft',
              'summary': 'Day 1',
              'total_minutes': 60,
              'items': [],
            },
            {
              'id': 'wr-2',
              'report_date': '2026-10-19T00:00:00Z',
              'status': 'reviewed',
              'summary': 'Day 2',
              'total_minutes': 120,
              'items': [],
            },
          ],
          'total': 2,
          'page': 1,
          'page_size': 20,
          'total_pages': 1,
        };
        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (page, failure) = await repository.getMyReports(
        status: 'draft',
        page: 1,
        pageSize: 20,
      );

      expect(failure, isNull);
      expect(page, isNotNull);
      expect(page?.items.length, 2);
      expect(capturedOptions?.queryParameters['status'], 'draft');
      expect(capturedOptions?.queryParameters['page'], 1);
      expect(capturedOptions?.queryParameters['page_size'], 20);
    });

    test('createOrSaveDraft posts payload and returns created report', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'wr-new',
          'report_date': '2026-10-20T00:00:00Z',
          'status': 'draft',
          'summary': 'Created new report',
          'total_minutes': 90,
          'items': [
            {
              'id': 'wri-new-1',
              'description': 'First activity',
              'minutes_spent': 90,
            },
          ],
        };
        return ResponseBody.fromString(
          jsonEncode(responseMap),
          201,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      const payload = WorkReportCreatePayload(
        reportDate: '2026-10-20',
        summary: 'Created new report',
        items: [
          WorkReportItemPayload(
            description: 'First activity',
            minutesSpent: 90,
          ),
        ],
      );

      final (report, failure) = await repository.createOrSaveDraft(payload);

      expect(failure, isNull);
      expect(report, isNotNull);
      expect(report?.id, 'wr-new');
      expect(capturedOptions?.method, 'POST');
      expect(capturedOptions?.data, isA<Map<String, dynamic>>());
      final sentData = capturedOptions?.data as Map<String, dynamic>;
      expect(sentData['report_date'], '2026-10-20');
      expect(sentData['summary'], 'Created new report');
    });

    test('updateReport puts updated items and summary', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'wr-existing',
          'report_date': '2026-10-20T00:00:00Z',
          'status': 'draft',
          'summary': 'Updated summary',
          'total_minutes': 120,
          'items': [],
        };
        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      const payload = WorkReportUpdatePayload(
        summary: 'Updated summary',
        items: [],
      );

      final (report, failure) = await repository.updateReport(
        'wr-existing',
        payload,
      );

      expect(failure, isNull);
      expect(report, isNotNull);
      expect(report?.summary, 'Updated summary');
      expect(capturedOptions?.method, 'PUT');
      expect(capturedOptions?.path, contains('/work-reports/wr-existing'));
    });

    test('submitReport posts to submit endpoint and transitions to submitted', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'wr-sub',
          'report_date': '2026-10-20T00:00:00Z',
          'status': 'submitted',
          'summary': 'Ready for review',
          'total_minutes': 120,
          'items': [],
        };
        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (report, failure) = await repository.submitReport('wr-sub');

      expect(failure, isNull);
      expect(report, isNotNull);
      expect(report?.status, 'submitted');
      expect(capturedOptions?.method, 'POST');
      expect(capturedOptions?.path, contains('/work-reports/wr-sub/submit'));
    });
  });
}
