// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(navigationRepository)
final navigationRepositoryProvider = NavigationRepositoryProvider._();

final class NavigationRepositoryProvider
    extends
        $FunctionalProvider<
          NavigationRepository,
          NavigationRepository,
          NavigationRepository
        >
    with $Provider<NavigationRepository> {
  NavigationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NavigationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NavigationRepository create(Ref ref) {
    return navigationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationRepository>(value),
    );
  }
}

String _$navigationRepositoryHash() =>
    r'191d5538cc31bd5ae5875f03d37524a080da3bcb';
