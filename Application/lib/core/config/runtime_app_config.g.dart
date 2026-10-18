// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runtime_app_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RuntimeAppConfigController)
final runtimeAppConfigControllerProvider =
    RuntimeAppConfigControllerProvider._();

final class RuntimeAppConfigControllerProvider
    extends $NotifierProvider<RuntimeAppConfigController, RuntimeAppConfig> {
  RuntimeAppConfigControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runtimeAppConfigControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runtimeAppConfigControllerHash();

  @$internal
  @override
  RuntimeAppConfigController create() => RuntimeAppConfigController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuntimeAppConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuntimeAppConfig>(value),
    );
  }
}

String _$runtimeAppConfigControllerHash() =>
    r'cf89d2fdd3ff1bee2eaad35e29072980293d58c0';

abstract class _$RuntimeAppConfigController
    extends $Notifier<RuntimeAppConfig> {
  RuntimeAppConfig build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RuntimeAppConfig, RuntimeAppConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RuntimeAppConfig, RuntimeAppConfig>,
              RuntimeAppConfig,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
