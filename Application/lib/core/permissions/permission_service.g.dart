// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPermissionsController)
final userPermissionsControllerProvider = UserPermissionsControllerProvider._();

final class UserPermissionsControllerProvider
    extends $NotifierProvider<UserPermissionsController, PermissionSet> {
  UserPermissionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPermissionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPermissionsControllerHash();

  @$internal
  @override
  UserPermissionsController create() => UserPermissionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PermissionSet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PermissionSet>(value),
    );
  }
}

String _$userPermissionsControllerHash() =>
    r'c8acd552cc3a09f32592d6112dde9cdb14d0261a';

abstract class _$UserPermissionsController extends $Notifier<PermissionSet> {
  PermissionSet build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PermissionSet, PermissionSet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PermissionSet, PermissionSet>,
              PermissionSet,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(permissionService)
final permissionServiceProvider = PermissionServiceProvider._();

final class PermissionServiceProvider
    extends
        $FunctionalProvider<
          PermissionService,
          PermissionService,
          PermissionService
        >
    with $Provider<PermissionService> {
  PermissionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionServiceHash();

  @$internal
  @override
  $ProviderElement<PermissionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PermissionService create(Ref ref) {
    return permissionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PermissionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PermissionService>(value),
    );
  }
}

String _$permissionServiceHash() => r'9d4b6ce2f7641a5a805d9d90f009aff092fbf778';
