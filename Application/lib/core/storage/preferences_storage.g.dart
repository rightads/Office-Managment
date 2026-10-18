// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'98be78790dd2ceeeb5e352c616e69a82f80b9801';

@ProviderFor(preferencesStorageService)
final preferencesStorageServiceProvider = PreferencesStorageServiceProvider._();

final class PreferencesStorageServiceProvider
    extends
        $FunctionalProvider<
          PreferencesStorageService,
          PreferencesStorageService,
          PreferencesStorageService
        >
    with $Provider<PreferencesStorageService> {
  PreferencesStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesStorageServiceHash();

  @$internal
  @override
  $ProviderElement<PreferencesStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreferencesStorageService create(Ref ref) {
    return preferencesStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferencesStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferencesStorageService>(value),
    );
  }
}

String _$preferencesStorageServiceHash() =>
    r'e3ca5f903e85bdc35409b38af0c4972b29a934f8';
