// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_cache_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localCacheService)
final localCacheServiceProvider = LocalCacheServiceProvider._();

final class LocalCacheServiceProvider
    extends
        $FunctionalProvider<
          LocalCacheService,
          LocalCacheService,
          LocalCacheService
        >
    with $Provider<LocalCacheService> {
  LocalCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localCacheServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localCacheServiceHash();

  @$internal
  @override
  $ProviderElement<LocalCacheService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalCacheService create(Ref ref) {
    return localCacheService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalCacheService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalCacheService>(value),
    );
  }
}

String _$localCacheServiceHash() => r'42a565ddb4159db504bb5d05e719fdb8f7f27787';
