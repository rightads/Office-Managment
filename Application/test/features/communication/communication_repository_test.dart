import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/communication/data/communication_repository.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';

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
  group('CommunicationRepository Tests', () {
    late Dio dio;
    late CommunicationRepository repository;
    RequestOptions? capturedOptions;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test.com/api/v1'));
      repository = CommunicationRepository(dio: dio);
      capturedOptions = null;
    });

    test('registerDeviceToken sends POST /notifications/devices', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseData = {
          'id': 'device-entry-1',
          'device_id': 'unique-device-123',
          'platform': 'android',
          'created_at': '2026-10-19T10:00:00Z',
        };
        return ResponseBody.fromString(
          jsonEncode(responseData),
          201,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      const payload = DeviceTokenRegisterPayload(
        fcmToken: 'mock-fcm-token-123456789',
        deviceId: 'unique-device-123',
        platform: 'android',
      );

      final (res, failure) = await repository.registerDeviceToken(payload);

      expect(failure, isNull);
      expect(res, isNotNull);
      expect(res!.deviceId, 'unique-device-123');
      expect(res.platform, 'android');
      expect(capturedOptions?.method, 'POST');
      expect(capturedOptions?.path, '/notifications/devices');
    });

    test(
      'unregisterDeviceToken sends DELETE /notifications/devices/{id}',
      () async {
        dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
          capturedOptions = options;
          return ResponseBody.fromString('', 204);
        });

        final failure = await repository.unregisterDeviceToken(
          'unique-device-123',
        );

        expect(failure, isNull);
        expect(capturedOptions?.method, 'DELETE');
        expect(
          capturedOptions?.path,
          '/notifications/devices/unique-device-123',
        );
      },
    );

    test(
      'getNotifications passes query params and parses page response',
      () async {
        dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
          capturedOptions = options;
          final responseData = {
            'items': [
              {
                'id': 'notif-1',
                'title': 'Task Assigned',
                'body': 'You have been assigned Task #101',
                'type': 'task_assigned',
                'data': {'task_id': 't-101'},
                'is_read': false,
                'created_at': '2026-10-19T09:30:00Z',
              },
            ],
            'total': 1,
            'page': 2,
            'page_size': 10,
            'total_pages': 1,
          };
          return ResponseBody.fromString(
            jsonEncode(responseData),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          );
        });

        final (res, failure) = await repository.getNotifications(
          page: 2,
          pageSize: 10,
          unreadOnly: true,
        );

        expect(failure, isNull);
        expect(res, isNotNull);
        expect(res!.items.length, 1);
        expect(res.items.first.title, 'Task Assigned');
        expect(res.items.first.isRead, isFalse);
        expect(capturedOptions?.queryParameters['page'], 2);
        expect(capturedOptions?.queryParameters['page_size'], 10);
        expect(capturedOptions?.queryParameters['unread_only'], isTrue);
      },
    );

    test('getUnreadNotificationCount parses unread_count', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        return ResponseBody.fromString(
          jsonEncode({'unread_count': 5}),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (count, failure) = await repository.getUnreadNotificationCount();

      expect(failure, isNull);
      expect(count, 5);
      expect(capturedOptions?.path, '/notifications/unread-count');
    });

    test(
      'markNotificationAsRead sends PATCH /notifications/{id}/read',
      () async {
        dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
          capturedOptions = options;
          final responseData = {
            'id': 'notif-1',
            'title': 'Task Assigned',
            'body': 'You have been assigned Task #101',
            'type': 'task_assigned',
            'data': {'task_id': 't-101'},
            'is_read': true,
            'created_at': '2026-10-19T09:30:00Z',
          };
          return ResponseBody.fromString(
            jsonEncode(responseData),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          );
        });

        final (item, failure) = await repository.markNotificationAsRead(
          'notif-1',
        );

        expect(failure, isNull);
        expect(item, isNotNull);
        expect(item!.isRead, isTrue);
        expect(capturedOptions?.method, 'PATCH');
        expect(capturedOptions?.path, '/notifications/notif-1/read');
      },
    );

    test(
      'markAllNotificationsAsRead sends POST /notifications/read-all',
      () async {
        dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
          capturedOptions = options;
          return ResponseBody.fromString(
            jsonEncode({'message': 'Marked 4 notifications as read.'}),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          );
        });

        final (msg, failure) = await repository.markAllNotificationsAsRead();

        expect(failure, isNull);
        expect(msg, 'Marked 4 notifications as read.');
        expect(capturedOptions?.method, 'POST');
        expect(capturedOptions?.path, '/notifications/read-all');
      },
    );

    test('getAnnouncements parses active announcements list', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseData = [
          {
            'id': 'ann-1',
            'title': 'Office Diwali Celebration',
            'body': 'Celebration scheduled for Friday 4 PM.',
            'target_department_id': null,
            'target_department_name': null,
            'creator': {
              'id': 'user-admin',
              'employee_code': 'EMP001',
              'full_name': 'HR Admin',
              'email': 'hr@rightads.com',
            },
            'expires_at': '2026-11-01T00:00:00Z',
            'is_active': true,
            'created_at': '2026-10-19T08:00:00Z',
          },
        ];
        return ResponseBody.fromString(
          jsonEncode(responseData),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (items, failure) = await repository.getAnnouncements();

      expect(failure, isNull);
      expect(items, isNotNull);
      expect(items!.length, 1);
      expect(items.first.title, 'Office Diwali Celebration');
      expect(items.first.isCompanyWide, isTrue);
      expect(capturedOptions?.path, '/announcements');
    });

    test('getAnnouncementDetail parses single announcement', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final responseData = {
          'id': 'ann-1',
          'title': 'Office Diwali Celebration',
          'body': 'Celebration scheduled for Friday 4 PM.',
          'target_department_id': 'dept-sales',
          'target_department_name': 'Tele Sales',
          'creator': {
            'id': 'user-admin',
            'employee_code': 'EMP001',
            'full_name': 'HR Admin',
            'email': 'hr@rightads.com',
          },
          'expires_at': '2026-11-01T00:00:00Z',
          'is_active': true,
          'created_at': '2026-10-19T08:00:00Z',
        };
        return ResponseBody.fromString(
          jsonEncode(responseData),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (item, failure) = await repository.getAnnouncementDetail('ann-1');

      expect(failure, isNull);
      expect(item, isNotNull);
      expect(item!.targetDepartmentName, 'Tele Sales');
      expect(item.isCompanyWide, isFalse);
      expect(capturedOptions?.path, '/announcements/ann-1');
    });
  });
}
