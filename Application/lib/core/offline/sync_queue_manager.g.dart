// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncQueueManager)
final syncQueueManagerProvider = SyncQueueManagerProvider._();

final class SyncQueueManagerProvider
    extends
        $FunctionalProvider<
          SyncQueueManager,
          SyncQueueManager,
          SyncQueueManager
        >
    with $Provider<SyncQueueManager> {
  SyncQueueManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncQueueManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncQueueManagerHash();

  @$internal
  @override
  $ProviderElement<SyncQueueManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncQueueManager create(Ref ref) {
    return syncQueueManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncQueueManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncQueueManager>(value),
    );
  }
}

String _$syncQueueManagerHash() => r'051d91462599566c3d9395daf0707d25707814ad';
