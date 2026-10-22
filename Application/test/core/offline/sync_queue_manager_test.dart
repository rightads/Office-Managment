import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/constants/storage_keys.dart';
import 'package:right_ads/core/offline/sync_queue_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeDio extends Fake implements Dio {
  final List<String> calls = [];
  int? forcedStatusCode;
  bool throwNetworkError = false;

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
    calls.add('POST $path: $data');
    if (throwNetworkError) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        type: DioExceptionType.connectionError,
      );
    }
    if (forcedStatusCode != null) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: forcedStatusCode,
        ),
      );
    }
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    calls.add('PATCH $path: $data');
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late _FakeDio fakeDio;
  late SyncQueueManager manager;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    fakeDio = _FakeDio();
    manager = SyncQueueManager(prefs: prefs, dio: fakeDio);
  });

  group('SyncQueueManager', () {
    test('enqueues actions and preserves them in queue', () async {
      expect(manager.getQueue(), isEmpty);

      final action = QueuedSyncAction(
        id: 'action-1',
        endpoint: '/api/v1/tasks/123/comments',
        method: 'POST',
        payload: {'content': 'Offline comment'},
        createdAt: DateTime.utc(2026, 10, 22, 10),
      );

      await manager.enqueue(action);

      final queue = manager.getQueue();
      expect(queue.length, 1);
      expect(queue.first.id, 'action-1');
      expect(queue.first.endpoint, '/api/v1/tasks/123/comments');
      expect(queue.first.method, 'POST');
      expect(queue.first.payload, {'content': 'Offline comment'});
      expect(queue.first.retryCount, 0);
    });

    test('flushes queue successfully and clears items', () async {
      await manager.enqueue(
        QueuedSyncAction(
          id: 'action-1',
          endpoint: '/api/v1/tasks/123/comments',
          method: 'POST',
          payload: {'content': 'Comment 1'},
          createdAt: DateTime.utc(2026, 10, 22, 10),
        ),
      );
      await manager.enqueue(
        QueuedSyncAction(
          id: 'action-2',
          endpoint: '/api/v1/tasks/123',
          method: 'PATCH',
          payload: {'status': 'IN_PROGRESS'},
          createdAt: DateTime.utc(2026, 10, 22, 10, 5),
        ),
      );

      final synced = await manager.flushQueue();

      expect(synced, 2);
      expect(fakeDio.calls.length, 2);
      expect(fakeDio.calls[0], contains('POST /api/v1/tasks/123/comments'));
      expect(fakeDio.calls[1], contains('PATCH /api/v1/tasks/123'));
      expect(manager.getQueue(), isEmpty);
    });

    test(
      'handles 409 Conflict by safely dropping action to preserve server state',
      () async {
        fakeDio.forcedStatusCode = 409;

        await manager.enqueue(
          QueuedSyncAction(
            id: 'action-conflict',
            endpoint: '/api/v1/records/456',
            method: 'POST',
            payload: {'field': 'outdated'},
            createdAt: DateTime.utc(2026, 10, 22, 10),
          ),
        );

        final synced = await manager.flushQueue();

        expect(synced, 0);
        expect(
          manager.getQueue(),
          isEmpty,
          reason: 'Conflicting item must be dropped, not retried forever',
        );
      },
    );

    test(
      'retains action and increments retryCount on network / 500 error',
      () async {
        fakeDio.forcedStatusCode = 500;

        await manager.enqueue(
          QueuedSyncAction(
            id: 'action-retry',
            endpoint: '/api/v1/records/789',
            method: 'POST',
            payload: {'field': 'val'},
            createdAt: DateTime.utc(2026, 10, 22, 10),
          ),
        );

        final synced = await manager.flushQueue();

        expect(synced, 0);
        final remaining = manager.getQueue();
        expect(remaining.length, 1);
        expect(remaining.first.id, 'action-retry');
        expect(remaining.first.retryCount, 1);
      },
    );

    test('clearQueue removes all stored actions', () async {
      await manager.enqueue(
        QueuedSyncAction(
          id: 'action-1',
          endpoint: '/test',
          method: 'POST',
          payload: null,
          createdAt: DateTime.utc(2026, 10, 22),
        ),
      );
      expect(manager.getQueue(), isNotEmpty);

      await manager.clearQueue();
      expect(manager.getQueue(), isEmpty);
      expect(prefs.containsKey(StorageKeys.offlineSyncQueue), isFalse);
    });
  });
}
