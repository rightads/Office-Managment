// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_draft_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(offlineDraftRepository)
final offlineDraftRepositoryProvider = OfflineDraftRepositoryProvider._();

final class OfflineDraftRepositoryProvider
    extends
        $FunctionalProvider<
          OfflineDraftRepository,
          OfflineDraftRepository,
          OfflineDraftRepository
        >
    with $Provider<OfflineDraftRepository> {
  OfflineDraftRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineDraftRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineDraftRepositoryHash();

  @$internal
  @override
  $ProviderElement<OfflineDraftRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OfflineDraftRepository create(Ref ref) {
    return offlineDraftRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OfflineDraftRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OfflineDraftRepository>(value),
    );
  }
}

String _$offlineDraftRepositoryHash() =>
    r'12647758f14867ca889775ecd4c08ddcb15a2b00';
