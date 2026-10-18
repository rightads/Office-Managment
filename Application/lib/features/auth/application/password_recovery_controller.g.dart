// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_recovery_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PasswordRecoveryController)
final passwordRecoveryControllerProvider =
    PasswordRecoveryControllerProvider._();

final class PasswordRecoveryControllerProvider
    extends $NotifierProvider<PasswordRecoveryController, bool> {
  PasswordRecoveryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordRecoveryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordRecoveryControllerHash();

  @$internal
  @override
  PasswordRecoveryController create() => PasswordRecoveryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$passwordRecoveryControllerHash() =>
    r'874bc2bb32a3a8f6b56107dc95590c294faea588';

abstract class _$PasswordRecoveryController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
