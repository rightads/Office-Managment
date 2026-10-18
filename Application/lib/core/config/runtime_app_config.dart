import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'runtime_app_config.freezed.dart';
part 'runtime_app_config.g.dart';

@freezed
abstract class PasswordPolicySummary with _$PasswordPolicySummary {
  const factory PasswordPolicySummary({
    @JsonKey(name: 'min_length') @Default(8) int minLength,
    @JsonKey(name: 'require_uppercase') @Default(true) bool requireUppercase,
    @JsonKey(name: 'require_lowercase') @Default(true) bool requireLowercase,
    @JsonKey(name: 'require_digit') @Default(true) bool requireDigit,
    @JsonKey(name: 'require_special') @Default(true) bool requireSpecial,
  }) = _PasswordPolicySummary;

  factory PasswordPolicySummary.fromJson(Map<String, dynamic> json) =>
      _$PasswordPolicySummaryFromJson(json);
}

/// Non-secret runtime configuration populated by `GET /api/v1/app/config`
/// and cached locally in [PreferencesStorageService] for offline startup.
@freezed
abstract class RuntimeAppConfig with _$RuntimeAppConfig {
  const factory RuntimeAppConfig({
    @JsonKey(name: 'app_timezone') @Default('UTC') String timezone,
    @Default('en_IN') String localeCode,
    @Default('INR') String currencyCode,
    @JsonKey(name: 'default_page_size') @Default(20) int defaultPageSize,
    @JsonKey(name: 'max_page_size') @Default(100) int maxPageSize,
    @JsonKey(name: 'max_upload_mb') @Default(10) int maxUploadMb,
    @JsonKey(name: 'allowed_upload_mime_types')
    @Default(<String>['image/jpeg', 'image/png', 'application/pdf'])
    List<String> allowedUploadMimeTypes,
    @JsonKey(name: 'min_supported_app_version')
    @Default('1.0.0')
    String minSupportedAppVersion,
    @JsonKey(name: 'force_update') @Default(false) bool forceUpdate,
    @JsonKey(name: 'navigation_refresh_interval_minutes')
    @Default(5)
    int navigationRefreshIntervalMinutes,
    @JsonKey(name: 'password_policy')
    @Default(PasswordPolicySummary())
    PasswordPolicySummary passwordPolicy,
    @JsonKey(name: 'feature_flags')
    @Default(<String, dynamic>{})
    Map<String, dynamic> featureFlags,
  }) = _RuntimeAppConfig;

  const RuntimeAppConfig._();

  factory RuntimeAppConfig.fromJson(Map<String, dynamic> json) =>
      _$RuntimeAppConfigFromJson(json);

  /// Compares [currentVersion] against [minSupportedAppVersion] using semantic
  /// version triplets (`major.minor.patch`).
  bool isBelowMinSupportedVersion(String currentVersion) {
    final currentParts = _parseSemVer(currentVersion);
    final minParts = _parseSemVer(minSupportedAppVersion);
    for (var i = 0; i < 3; i++) {
      if (currentParts[i] < minParts[i]) return true;
      if (currentParts[i] > minParts[i]) return false;
    }
    return false;
  }

  /// Returns `true` when the client must be blocked by the force-update gate.
  bool requiresForceUpdate(String currentVersion) {
    return forceUpdate || isBelowMinSupportedVersion(currentVersion);
  }

  static List<int> _parseSemVer(String raw) {
    final cleaned = raw.trim().split('+').first.split('-').first;
    final segments = cleaned.split('.');
    final result = <int>[0, 0, 0];
    for (var i = 0; i < 3 && i < segments.length; i++) {
      result[i] = int.tryParse(segments[i]) ?? 0;
    }
    return result;
  }
}

/// Provides the current client semantic version string (e.g. `1.0.0`).
@Riverpod(keepAlive: true)
String currentAppVersion(Ref ref) => const String.fromEnvironment(
  'APP_VERSION',
  defaultValue: '1.0.0',
);

@Riverpod(keepAlive: true)
class RuntimeAppConfigController extends _$RuntimeAppConfigController {
  @override
  RuntimeAppConfig build() {
    // Hydrate from last cached copy synchronously on cold start.
    try {
      final prefs = ref.watch(preferencesStorageServiceProvider);
      final cachedRaw = prefs.readCachedAppConfigJson();
      if (cachedRaw != null && cachedRaw.isNotEmpty) {
        final decoded = jsonDecode(cachedRaw);
        if (decoded is Map<String, dynamic>) {
          return RuntimeAppConfig.fromJson(decoded);
        }
      }
    } on Object {
      // If preferencesStorageServiceProvider is not overridden in a unit test
      // or cached JSON is malformed, fall back to safe defaults.
    }
    return const RuntimeAppConfig();
  }

  // Riverpod notifier state updates use methods rather than property setters.
  // ignore: use_setters_to_change_properties
  void updateConfig(RuntimeAppConfig next) {
    state = next;
  }

  /// Fetches `GET /api/v1/app/config`, updates state, and persists the last
  /// known good copy to [PreferencesStorageService] for offline startup.
  Future<(RuntimeAppConfig, AppFailure?)> refreshFromServer() async {
    final dio = ref.read(dioProvider);
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.appConfig,
      );
      final data = response.data;
      if (data != null) {
        final payload = data['data'] is Map<String, dynamic>
            ? data['data'] as Map<String, dynamic>
            : data;
        final parsed = RuntimeAppConfig.fromJson(payload);
        state = parsed;
        try {
          await ref
              .read(preferencesStorageServiceProvider)
              .writeCachedAppConfigJson(jsonEncode(payload));
        } on Object {
          // Ignore persistence errors in tests without SharedPreferences
        }
        return (parsed, null);
      }
      return (state, const AppFailure.unknown());
    } on Object catch (error) {
      final failure = ErrorMapper.mapException(error);
      return (state, failure);
    }
  }
}
