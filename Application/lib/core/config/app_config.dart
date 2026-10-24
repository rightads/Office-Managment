import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/config/app_environment.dart';

part 'app_config.freezed.dart';

abstract final class AppConfigEnvKeys {
  static const String environment = 'ENVIRONMENT';
  static const String apiBaseUrl = 'API_BASE_URL';
  static const String connectTimeoutMs = 'CONNECT_TIMEOUT_MS';
  static const String receiveTimeoutMs = 'RECEIVE_TIMEOUT_MS';
  static const String sendTimeoutMs = 'SEND_TIMEOUT_MS';
  static const String sentryDsn = 'SENTRY_DSN';
}

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    required AppEnvironment environment,
    required String apiBaseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    String? sentryDsn,
  }) = _AppConfig;
}

sealed class AppConfigValidationResult {
  const AppConfigValidationResult();

  static AppConfigValidationResult fromEnvironment({
    AppEnvironment? expectedFlavor,
  }) {
    const rawEnvironment = String.fromEnvironment(AppConfigEnvKeys.environment);
    const rawApiBaseUrl = String.fromEnvironment(AppConfigEnvKeys.apiBaseUrl);
    const rawConnectTimeout = String.fromEnvironment(
      AppConfigEnvKeys.connectTimeoutMs,
    );
    const rawReceiveTimeout = String.fromEnvironment(
      AppConfigEnvKeys.receiveTimeoutMs,
    );
    const rawSendTimeout = String.fromEnvironment(
      AppConfigEnvKeys.sendTimeoutMs,
    );
    const rawSentryDsn = String.fromEnvironment(AppConfigEnvKeys.sentryDsn);

    // In debug mode, provide developer-friendly fallback defaults for plain `flutter run`
    final effectiveEnvironment = rawEnvironment.isNotEmpty
        ? rawEnvironment
        : (kDebugMode ? (expectedFlavor?.value ?? 'dev') : '');
    final effectiveApiBaseUrl = rawApiBaseUrl.isNotEmpty
        ? rawApiBaseUrl
        : (kDebugMode ? 'http://10.0.2.2:8000/api/v1' : '');
    final effectiveConnectTimeout = rawConnectTimeout.isNotEmpty
        ? rawConnectTimeout
        : (kDebugMode ? '15000' : '');
    final effectiveReceiveTimeout = rawReceiveTimeout.isNotEmpty
        ? rawReceiveTimeout
        : (kDebugMode ? '30000' : '');
    final effectiveSendTimeout = rawSendTimeout.isNotEmpty
        ? rawSendTimeout
        : (kDebugMode ? '15000' : '');

    return fromRawValues(
      rawEnvironment: effectiveEnvironment,
      rawApiBaseUrl: effectiveApiBaseUrl,
      rawConnectTimeoutMs: effectiveConnectTimeout,
      rawReceiveTimeoutMs: effectiveReceiveTimeout,
      rawSendTimeoutMs: effectiveSendTimeout,
      rawSentryDsn: rawSentryDsn,
      expectedFlavor: expectedFlavor,
    );
  }

  static AppConfigValidationResult fromRawValues({
    required String rawEnvironment,
    required String rawApiBaseUrl,
    required String rawConnectTimeoutMs,
    required String rawReceiveTimeoutMs,
    required String rawSendTimeoutMs,
    String? rawSentryDsn,
    AppEnvironment? expectedFlavor,
  }) {
    final invalidKeys = <String>[];

    final parsedEnv = AppEnvironment.tryParse(rawEnvironment);
    if (parsedEnv == null) {
      invalidKeys.add(AppConfigEnvKeys.environment);
    } else if (expectedFlavor != null && parsedEnv != expectedFlavor) {
      invalidKeys.add(
        '${AppConfigEnvKeys.environment} (expected ${expectedFlavor.value}, got ${parsedEnv.value})',
      );
    }

    final trimmedUrl = rawApiBaseUrl.trim();
    final parsedUri = Uri.tryParse(trimmedUrl);
    final isValidUri =
        trimmedUrl.isNotEmpty &&
        parsedUri != null &&
        (parsedUri.scheme == 'http' || parsedUri.scheme == 'https') &&
        parsedUri.host.isNotEmpty;
    if (!isValidUri) {
      invalidKeys.add(AppConfigEnvKeys.apiBaseUrl);
    }

    final connectMs = int.tryParse(rawConnectTimeoutMs.trim());
    if (connectMs == null || connectMs <= 0) {
      invalidKeys.add(AppConfigEnvKeys.connectTimeoutMs);
    }

    final receiveMs = int.tryParse(rawReceiveTimeoutMs.trim());
    if (receiveMs == null || receiveMs <= 0) {
      invalidKeys.add(AppConfigEnvKeys.receiveTimeoutMs);
    }

    final sendMs = int.tryParse(rawSendTimeoutMs.trim());
    if (sendMs == null || sendMs <= 0) {
      invalidKeys.add(AppConfigEnvKeys.sendTimeoutMs);
    }

    if (invalidKeys.isNotEmpty) {
      return AppConfigInvalid(invalidKeys: List.unmodifiable(invalidKeys));
    }

    final trimmedSentry = rawSentryDsn?.trim() ?? '';
    return AppConfigValid(
      config: AppConfig(
        environment: parsedEnv!,
        apiBaseUrl: trimmedUrl,
        connectTimeout: Duration(milliseconds: connectMs!),
        receiveTimeout: Duration(milliseconds: receiveMs!),
        sendTimeout: Duration(milliseconds: sendMs!),
        sentryDsn: trimmedSentry.isEmpty ? null : trimmedSentry,
      ),
    );
  }
}

final class AppConfigValid extends AppConfigValidationResult {
  const AppConfigValid({required this.config});

  final AppConfig config;
}

final class AppConfigInvalid extends AppConfigValidationResult {
  const AppConfigInvalid({required this.invalidKeys});

  final List<String> invalidKeys;
}
