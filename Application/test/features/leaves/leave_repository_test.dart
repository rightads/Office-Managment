import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/leaves/data/leave_repository.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';

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
  group('LeaveRepository Tests', () {
    late Dio dio;
    late LeaveRepository repository;
    RequestOptions? capturedOptions;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test.com/api/v1'));
      repository = LeaveRepository(dio: dio);
      capturedOptions = null;
    });

    test('getMyBalances parses balances and passes year query parameter', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseList = [
          {
            'id': 'bal-1',
            'user_id': 'u-1',
            'leave_type_id': 'lt-1',
            'leave_type_name': 'Casual Leave',
            'year': 2026,
            'allocated': 12.0,
            'carried_forward': 2.0,
            'used': 4.0,
            'available': 10.0,
          },
          {
            'id': 'bal-2',
            'user_id': 'u-1',
            'leave_type_id': 'lt-2',
            'leave_type_name': 'Sick Leave',
            'year': 2026,
            'allocated': 10.0,
            'carried_forward': 0.0,
            'used': 1.0,
            'available': 9.0,
          },
        ];

        return ResponseBody.fromString(
          jsonEncode(responseList),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (balances, failure) = await repository.getMyBalances(year: 2026);

      expect(failure, isNull);
      expect(balances, isNotNull);
      expect(balances!.length, 2);
      expect(balances.first.leaveTypeName, 'Casual Leave');
      expect(balances.first.available, 10.0);
      expect(capturedOptions?.queryParameters['year'], 2026);
    });

    test('getLeaveTypes parses list of leave types', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseList = [
          {
            'id': 'lt-1',
            'name': 'Casual Leave',
            'annual_quota': 12,
            'is_paid': true,
            'carry_forward': true,
            'max_carry_forward': 5,
            'is_active': true,
          },
        ];

        return ResponseBody.fromString(
          jsonEncode(responseList),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (types, failure) = await repository.getLeaveTypes();

      expect(failure, isNull);
      expect(types, isNotNull);
      expect(types!.first.name, 'Casual Leave');
      expect(types.first.annualQuota, 12);
      expect(types.first.isPaid, isTrue);
    });

    test('getMyRequests parses paginated items and passes query filters', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'items': [
            {
              'id': 'lr-1',
              'user_id': 'u-1',
              'user_full_name': 'John Doe',
              'employee_code': 'EMP001',
              'leave_type_id': 'lt-1',
              'leave_type_name': 'Casual Leave',
              'from_date': '2026-10-20T00:00:00.000Z',
              'to_date': '2026-10-21T00:00:00.000Z',
              'is_half_day': false,
              'total_days': 2.0,
              'reason': 'Family vacation trip',
              'status': 'pending',
              'created_at': '2026-10-18T10:00:00.000Z',
            },
          ],
          'total': 1,
          'page': 1,
          'size': 20,
          'pages': 1,
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (result, failure) = await repository.getMyRequests(
        status: 'pending',
        year: 2026,
        page: 1,
        size: 20,
      );

      expect(failure, isNull);
      expect(result, isNotNull);
      expect(result!.items.length, 1);
      expect(result.items.first.id, 'lr-1');
      expect(result.items.first.status, 'pending');
      expect(capturedOptions?.queryParameters['status'], 'pending');
      expect(capturedOptions?.queryParameters['year'], 2026);
    });

    test('getLeaveById fetches single leave details', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'lr-123',
          'user_id': 'u-1',
          'user_full_name': 'John Doe',
          'employee_code': 'EMP001',
          'leave_type_id': 'lt-1',
          'leave_type_name': 'Casual Leave',
          'from_date': '2026-10-20T00:00:00.000Z',
          'to_date': '2026-10-20T00:00:00.000Z',
          'is_half_day': true,
          'half_day_session': 'first_half',
          'total_days': 0.5,
          'reason': 'Personal appointment',
          'status': 'approved',
          'reviewed_by': 'u-boss',
          'reviewer_name': 'Boss Smith',
          'review_note': 'Approved. Enjoy!',
          'reviewed_at': '2026-10-19T09:00:00.000Z',
          'created_at': '2026-10-18T10:00:00.000Z',
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (leave, failure) = await repository.getLeaveById('lr-123');

      expect(failure, isNull);
      expect(leave, isNotNull);
      expect(leave!.id, 'lr-123');
      expect(leave.isHalfDay, isTrue);
      expect(leave.halfDaySession, 'first_half');
      expect(leave.reviewerName, 'Boss Smith');
    });

    test('previewLeave posts payload and returns working day calculation', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'from_date': '2026-10-20T00:00:00.000Z',
          'to_date': '2026-10-22T00:00:00.000Z',
          'is_half_day': false,
          'working_days': 3.0,
          'is_valid': true,
          'available_balance': 10.0,
          'has_overlap': false,
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      const payload = LeavePreviewPayload(
        leaveTypeId: 'lt-1',
        fromDate: '2026-10-20',
        toDate: '2026-10-22',
      );

      final (preview, failure) = await repository.previewLeave(payload);

      expect(failure, isNull);
      expect(preview, isNotNull);
      expect(preview!.workingDays, 3.0);
      expect(preview.isValid, isTrue);
      expect(preview.hasOverlap, isFalse);
    });

    test('applyLeave submits application and returns created LeaveRequestModel', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'lr-new',
          'user_id': 'u-1',
          'user_full_name': 'John Doe',
          'employee_code': 'EMP001',
          'leave_type_id': 'lt-1',
          'leave_type_name': 'Casual Leave',
          'from_date': '2026-10-20T00:00:00.000Z',
          'to_date': '2026-10-22T00:00:00.000Z',
          'is_half_day': false,
          'total_days': 3.0,
          'reason': 'Family event',
          'status': 'pending',
          'created_at': '2026-10-18T10:00:00.000Z',
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      const payload = LeaveApplyPayload(
        leaveTypeId: 'lt-1',
        fromDate: '2026-10-20',
        toDate: '2026-10-22',
        reason: 'Family event',
      );

      final (created, failure) = await repository.applyLeave(payload);

      expect(failure, isNull);
      expect(created, isNotNull);
      expect(created!.id, 'lr-new');
      expect(created.status, 'pending');
    });

    test('cancelPendingLeave posts to cancel endpoint', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'lr-1',
          'user_id': 'u-1',
          'user_full_name': 'John Doe',
          'employee_code': 'EMP001',
          'leave_type_id': 'lt-1',
          'leave_type_name': 'Casual Leave',
          'from_date': '2026-10-20T00:00:00.000Z',
          'to_date': '2026-10-21T00:00:00.000Z',
          'is_half_day': false,
          'total_days': 2.0,
          'reason': 'Vacation trip',
          'status': 'cancelled',
          'created_at': '2026-10-18T10:00:00.000Z',
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (cancelled, failure) = await repository.cancelPendingLeave('lr-1');

      expect(failure, isNull);
      expect(cancelled, isNotNull);
      expect(cancelled!.status, 'cancelled');
    });

    test('cancelApprovedLeave sends reason query parameter', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'id': 'lr-1',
          'user_id': 'u-1',
          'user_full_name': 'John Doe',
          'employee_code': 'EMP001',
          'leave_type_id': 'lt-1',
          'leave_type_name': 'Casual Leave',
          'from_date': '2026-10-20T00:00:00.000Z',
          'to_date': '2026-10-21T00:00:00.000Z',
          'is_half_day': false,
          'total_days': 2.0,
          'reason': 'Trip was postponed',
          'status': 'cancelled',
          'created_at': '2026-10-18T10:00:00.000Z',
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (cancelled, failure) = await repository.cancelApprovedLeave(
        'lr-1',
        reason: 'Trip was postponed',
      );

      expect(failure, isNull);
      expect(cancelled, isNotNull);
      expect(cancelled!.status, 'cancelled');
      expect(capturedOptions?.queryParameters['reason'], 'Trip was postponed');
    });

    test('getHolidays parses holiday page response', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseMap = {
          'items': [
            {
              'id': 'hol-1',
              'name': 'Republic Day',
              'date': '2026-01-26T00:00:00.000Z',
              'year': 2026,
              'is_optional': false,
            },
            {
              'id': 'hol-2',
              'name': 'Optional Festival',
              'date': '2026-03-15T00:00:00.000Z',
              'year': 2026,
              'is_optional': true,
            },
          ],
          'total': 2,
          'page': 1,
          'page_size': 50,
        };

        return ResponseBody.fromString(
          jsonEncode(responseMap),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (page, failure) = await repository.getHolidays(year: 2026);

      expect(failure, isNull);
      expect(page, isNotNull);
      expect(page!.items.length, 2);
      expect(page.items.first.name, 'Republic Day');
      expect(page.items.last.isOptional, isTrue);
      expect(capturedOptions?.queryParameters['year'], 2026);
    });

    test('maps 404 error correctly using ErrorMapper', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        return ResponseBody.fromString(
          jsonEncode({
            'error': {
              'code': 'NOT_FOUND',
              'message': 'Leave application not found',
            },
          }),
          404,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (leave, failure) = await repository.getLeaveById('missing-id');

      expect(leave, isNull);
      expect(failure, isNotNull);
      expect(failure!.message, 'Leave application not found');
    });
  });
}
