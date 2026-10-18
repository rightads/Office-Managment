// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavigationController)
final navigationControllerProvider = NavigationControllerProvider._();

final class NavigationControllerProvider
    extends $NotifierProvider<NavigationController, NavigationState> {
  NavigationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationControllerHash();

  @$internal
  @override
  NavigationController create() => NavigationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationState>(value),
    );
  }
}

String _$navigationControllerHash() =>
    r'0be9c80a0bcb5396613f7b7e4f037f07dd41318f';

abstract class _$NavigationController extends $Notifier<NavigationState> {
  NavigationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NavigationState, NavigationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NavigationState, NavigationState>,
              NavigationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
