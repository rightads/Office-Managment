// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runtime_app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PasswordPolicySummary _$PasswordPolicySummaryFromJson(
  Map<String, dynamic> json,
) => _PasswordPolicySummary(
  minLength: (json['min_length'] as num?)?.toInt() ?? 8,
  requireUppercase: json['require_uppercase'] as bool? ?? true,
  requireLowercase: json['require_lowercase'] as bool? ?? true,
  requireDigit: json['require_digit'] as bool? ?? true,
  requireSpecial: json['require_special'] as bool? ?? true,
);

Map<String, dynamic> _$PasswordPolicySummaryToJson(
  _PasswordPolicySummary instance,
) => <String, dynamic>{
  'min_length': instance.minLength,
  'require_uppercase': instance.requireUppercase,
  'require_lowercase': instance.requireLowercase,
  'require_digit': instance.requireDigit,
  'require_special': instance.requireSpecial,
};

_RuntimeAppConfig _$RuntimeAppConfigFromJson(Map<String, dynamic> json) =>
    _RuntimeAppConfig(
      timezone: json['app_timezone'] as String? ?? 'UTC',
      localeCode: json['localeCode'] as String? ?? 'en_IN',
      currencyCode: json['currencyCode'] as String? ?? 'INR',
      defaultPageSize: (json['default_page_size'] as num?)?.toInt() ?? 20,
      maxPageSize: (json['max_page_size'] as num?)?.toInt() ?? 100,
      maxUploadMb: (json['max_upload_mb'] as num?)?.toInt() ?? 10,
      allowedUploadMimeTypes:
          (json['allowed_upload_mime_types'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['image/jpeg', 'image/png', 'application/pdf'],
      minSupportedAppVersion:
          json['min_supported_app_version'] as String? ?? '1.0.0',
      forceUpdate: json['force_update'] as bool? ?? false,
      navigationRefreshIntervalMinutes:
          (json['navigation_refresh_interval_minutes'] as num?)?.toInt() ?? 5,
      passwordPolicy: json['password_policy'] == null
          ? const PasswordPolicySummary()
          : PasswordPolicySummary.fromJson(
              json['password_policy'] as Map<String, dynamic>,
            ),
      featureFlags:
          json['feature_flags'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$RuntimeAppConfigToJson(_RuntimeAppConfig instance) =>
    <String, dynamic>{
      'app_timezone': instance.timezone,
      'localeCode': instance.localeCode,
      'currencyCode': instance.currencyCode,
      'default_page_size': instance.defaultPageSize,
      'max_page_size': instance.maxPageSize,
      'max_upload_mb': instance.maxUploadMb,
      'allowed_upload_mime_types': instance.allowedUploadMimeTypes,
      'min_supported_app_version': instance.minSupportedAppVersion,
      'force_update': instance.forceUpdate,
      'navigation_refresh_interval_minutes':
          instance.navigationRefreshIntervalMinutes,
      'password_policy': instance.passwordPolicy,
      'feature_flags': instance.featureFlags,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the current client semantic version string (e.g. `1.0.0`).

@ProviderFor(currentAppVersion)
final currentAppVersionProvider = CurrentAppVersionProvider._();

/// Provides the current client semantic version string (e.g. `1.0.0`).

final class CurrentAppVersionProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Provides the current client semantic version string (e.g. `1.0.0`).
  CurrentAppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAppVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAppVersionHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentAppVersion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentAppVersionHash() => r'84914e8f7f206d99c7062e3bec9a0bb2a9e57154';

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
    r'14539241be4fc8d144147d03968fd54750699aeb';

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
