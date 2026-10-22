// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_admin_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(superAdminRepository)
final superAdminRepositoryProvider = SuperAdminRepositoryProvider._();

final class SuperAdminRepositoryProvider
    extends
        $FunctionalProvider<
          SuperAdminRepository,
          SuperAdminRepository,
          SuperAdminRepository
        >
    with $Provider<SuperAdminRepository> {
  SuperAdminRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'superAdminRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$superAdminRepositoryHash();

  @$internal
  @override
  $ProviderElement<SuperAdminRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SuperAdminRepository create(Ref ref) {
    return superAdminRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SuperAdminRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SuperAdminRepository>(value),
    );
  }
}

String _$superAdminRepositoryHash() =>
    r'41c17daa2aa325d339346221f974d21c8e468ccc';
