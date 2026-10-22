import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:right_ads/core/constants/storage_keys.dart';
import 'package:right_ads/core/network/connectivity_provider.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sync_queue_manager.g.dart';

/// Models a queued sync action to be replayed upon reconnection.
class QueuedSyncAction {
  const QueuedSyncAction({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
  });

  factory QueuedSyncAction.fromJson(Map<String, dynamic> json) {
    return QueuedSyncAction(
      id: json['id'] as String,
      endpoint: json['endpoint'] as String,
      method: json['method'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      retryCount: json['retry_count'] as int? ?? 0,
    );
  }

  final String id;
  final String endpoint;
  final String method;
  final Map<String, dynamic>? payload;
  final DateTime createdAt;
  final int retryCount;

  QueuedSyncAction copyWith({int? retryCount}) => QueuedSyncAction(
    id: id,
    endpoint: endpoint,
    method: method,
    payload: payload,
    createdAt: createdAt,
    retryCount: retryCount ?? this.retryCount,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'endpoint': endpoint,
    'method': method,
    'payload': payload,
    'created_at': createdAt.toIso8601String(),
    'retry_count': retryCount,
  };
}

/// Manages safe background synchronization of non-attendance offline actions.
class SyncQueueManager {
  SyncQueueManager({
    required this.prefs,
    required this.dio,
  });

  final SharedPreferences prefs;
  final Dio dio;
  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  List<QueuedSyncAction> getQueue() {
    final raw = prefs.getString(StorageKeys.offlineSyncQueue);
    if (raw == null || raw.isEmpty) return <QueuedSyncAction>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => QueuedSyncAction.fromJson(e as Map<String, dynamic>))
          .toList();
    } on FormatException catch (_) {
      return <QueuedSyncAction>[];
    }
  }

  Future<void> enqueue(QueuedSyncAction action) async {
    final queue = getQueue()..add(action);
    await _saveQueue(queue);
  }

  Future<void> _saveQueue(List<QueuedSyncAction> queue) async {
    await prefs.setString(
      StorageKeys.offlineSyncQueue,
      jsonEncode(queue.map((a) => a.toJson()).toList()),
    );
  }

  /// Flushes all pending actions sequentially.
  /// If a conflict (409) occurs, the server version is preserved and item is popped.
  Future<int> flushQueue() async {
    if (_isSyncing) return 0;
    _isSyncing = true;
    var syncedCount = 0;

    try {
      final queue = getQueue();
      if (queue.isEmpty) {
        _isSyncing = false;
        return 0;
      }

      final remaining = <QueuedSyncAction>[];

      for (final action in queue) {
        try {
          if (action.method.toUpperCase() == 'POST') {
            await dio.post<dynamic>(action.endpoint, data: action.payload);
          } else if (action.method.toUpperCase() == 'PATCH') {
            await dio.patch<dynamic>(action.endpoint, data: action.payload);
          } else if (action.method.toUpperCase() == 'PUT') {
            await dio.put<dynamic>(action.endpoint, data: action.payload);
          } else if (action.method.toUpperCase() == 'DELETE') {
            await dio.delete<dynamic>(action.endpoint);
          }
          syncedCount++;
        } on DioException catch (dioErr) {
          final statusCode = dioErr.response?.statusCode;
          // Conflict (409) or bad request / validation failure (422) means server rejects -> drop item safely
          if (statusCode == 409 || statusCode == 422 || statusCode == 400) {
            continue;
          }
          // Network errors or 5xx -> retain in queue with backoff increment
          if (action.retryCount < 5) {
            remaining.add(action.copyWith(retryCount: action.retryCount + 1));
          }
        } on Exception catch (_) {
          if (action.retryCount < 5) {
            remaining.add(action.copyWith(retryCount: action.retryCount + 1));
          }
        }
      }

      await _saveQueue(remaining);
      return syncedCount;
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> clearQueue() async {
    await prefs.remove(StorageKeys.offlineSyncQueue);
  }
}

@riverpod
SyncQueueManager syncQueueManager(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final dio = ref.watch(dioProvider);
  final manager = SyncQueueManager(prefs: prefs, dio: dio);

  // Automatically attempt flush when network becomes available
  ref.listen<AsyncValue<List<ConnectivityResult>>>(
    connectivityChangesProvider,
    (previous, next) {
      final isOnline = next.maybeWhen(
        data: (results) =>
            results.isNotEmpty &&
            results.any((r) => r != ConnectivityResult.none),
        orElse: () => false,
      );
      if (isOnline) {
        unawaited(manager.flushQueue());
      }
    },
  );

  return manager;
}
