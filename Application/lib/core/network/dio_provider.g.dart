// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sessionExpiryNotifier)
final sessionExpiryProvider = SessionExpiryNotifierProvider._();

final class SessionExpiryNotifierProvider
    extends
        $FunctionalProvider<
          SessionExpiryNotifier,
          SessionExpiryNotifier,
          SessionExpiryNotifier
        >
    with $Provider<SessionExpiryNotifier> {
  SessionExpiryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionExpiryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionExpiryNotifierHash();

  @$internal
  @override
  $ProviderElement<SessionExpiryNotifier> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionExpiryNotifier create(Ref ref) {
    return sessionExpiryNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionExpiryNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionExpiryNotifier>(value),
    );
  }
}

String _$sessionExpiryNotifierHash() =>
    r'12ef0fc7e1c4cfad203b381a06e83e3f19255a01';

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'b6c3d14dfc37619f1b7d021bde750b9c6dcf062a';
