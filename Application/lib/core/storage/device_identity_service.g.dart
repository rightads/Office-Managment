// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_identity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceIdentityService)
final deviceIdentityServiceProvider = DeviceIdentityServiceProvider._();

final class DeviceIdentityServiceProvider
    extends
        $FunctionalProvider<
          DeviceIdentityService,
          DeviceIdentityService,
          DeviceIdentityService
        >
    with $Provider<DeviceIdentityService> {
  DeviceIdentityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceIdentityServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceIdentityServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceIdentityService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceIdentityService create(Ref ref) {
    return deviceIdentityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceIdentityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceIdentityService>(value),
    );
  }
}

String _$deviceIdentityServiceHash() =>
    r'd97c8da1e56fa7c088fabac003e530e1aa71f26f';
