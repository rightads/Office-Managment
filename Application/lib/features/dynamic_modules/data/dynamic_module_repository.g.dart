// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_module_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dynamicModuleRepository)
final dynamicModuleRepositoryProvider = DynamicModuleRepositoryProvider._();

final class DynamicModuleRepositoryProvider
    extends
        $FunctionalProvider<
          DynamicModuleRepository,
          DynamicModuleRepository,
          DynamicModuleRepository
        >
    with $Provider<DynamicModuleRepository> {
  DynamicModuleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dynamicModuleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dynamicModuleRepositoryHash();

  @$internal
  @override
  $ProviderElement<DynamicModuleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DynamicModuleRepository create(Ref ref) {
    return dynamicModuleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DynamicModuleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DynamicModuleRepository>(value),
    );
  }
}

String _$dynamicModuleRepositoryHash() =>
    r'7844191e284e0a08c1be8a29a4b720c557627772';
