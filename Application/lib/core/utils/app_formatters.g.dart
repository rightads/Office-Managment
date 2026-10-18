// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_formatters.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appFormatters)
final appFormattersProvider = AppFormattersProvider._();

final class AppFormattersProvider
    extends $FunctionalProvider<AppFormatters, AppFormatters, AppFormatters>
    with $Provider<AppFormatters> {
  AppFormattersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appFormattersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appFormattersHash();

  @$internal
  @override
  $ProviderElement<AppFormatters> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppFormatters create(Ref ref) {
    return appFormatters(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppFormatters value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppFormatters>(value),
    );
  }
}

String _$appFormattersHash() => r'd55b90906323e189c4e0961d557c50f14c45814c';
