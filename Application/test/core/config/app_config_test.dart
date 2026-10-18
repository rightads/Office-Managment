import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_environment.dart';

void main() {
  group('AppConfigValidationResult.fromRawValues', () {
    test('returns AppConfigValid when all required values are valid', () {
      final result = AppConfigValidationResult.fromRawValues(
        rawEnvironment: 'dev',
        rawApiBaseUrl: 'http://10.0.2.2:8000/api/v1',
        rawConnectTimeoutMs: '15000',
        rawReceiveTimeoutMs: '30000',
        rawSendTimeoutMs: '15000',
        rawSentryDsn: 'https://public@sentry.example.com/1',
        expectedFlavor: AppEnvironment.dev,
      );

      expect(result, isA<AppConfigValid>());
      final valid = result as AppConfigValid;
      expect(valid.config.environment, AppEnvironment.dev);
      expect(valid.config.apiBaseUrl, 'http://10.0.2.2:8000/api/v1');
      expect(
        valid.config.connectTimeout,
        const Duration(milliseconds: 15000),
      );
      expect(
        valid.config.receiveTimeout,
        const Duration(milliseconds: 30000),
      );
      expect(
        valid.config.sendTimeout,
        const Duration(milliseconds: 15000),
      );
      expect(valid.config.sentryDsn, 'https://public@sentry.example.com/1');
    });

    test('sets sentryDsn to null when rawSentryDsn is empty', () {
      final result = AppConfigValidationResult.fromRawValues(
        rawEnvironment: 'prod',
        rawApiBaseUrl: 'https://api.rightads.example.com/api/v1',
        rawConnectTimeoutMs: '10000',
        rawReceiveTimeoutMs: '20000',
        rawSendTimeoutMs: '10000',
        expectedFlavor: AppEnvironment.prod,
      );

      expect(result, isA<AppConfigValid>());
      final valid = result as AppConfigValid;
      expect(valid.config.sentryDsn, isNull);
    });

    test(
      'returns AppConfigInvalid when required keys are missing or invalid',
      () {
        final result = AppConfigValidationResult.fromRawValues(
          rawEnvironment: 'unknown_env',
          rawApiBaseUrl: 'not-a-valid-url',
          rawConnectTimeoutMs: '-5',
          rawReceiveTimeoutMs: 'abc',
          rawSendTimeoutMs: '0',
        );

        expect(result, isA<AppConfigInvalid>());
        final invalid = result as AppConfigInvalid;
        expect(
          invalid.invalidKeys,
          containsAll(<String>[
            AppConfigEnvKeys.environment,
            AppConfigEnvKeys.apiBaseUrl,
            AppConfigEnvKeys.connectTimeoutMs,
            AppConfigEnvKeys.receiveTimeoutMs,
            AppConfigEnvKeys.sendTimeoutMs,
          ]),
        );
      },
    );

    test(
      'returns AppConfigInvalid when environment mismatches expectedFlavor',
      () {
        final result = AppConfigValidationResult.fromRawValues(
          rawEnvironment: 'staging',
          rawApiBaseUrl: 'https://staging.rightads.example.com/api/v1',
          rawConnectTimeoutMs: '15000',
          rawReceiveTimeoutMs: '30000',
          rawSendTimeoutMs: '15000',
          expectedFlavor: AppEnvironment.prod,
        );

        expect(result, isA<AppConfigInvalid>());
        final invalid = result as AppConfigInvalid;
        expect(
          invalid.invalidKeys.single,
          contains('expected prod, got staging'),
        );
      },
    );
  });
}
