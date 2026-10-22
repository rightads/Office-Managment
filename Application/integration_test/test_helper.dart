import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_theme.dart';

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  _FakeRuntimeAppConfigController(this._config);

  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;

  @override
  Future<(RuntimeAppConfig, AppFailure?)> refreshFromServer() async {
    return (_config, null);
  }
}

/// Reusable helper to initialize integration tests and pump app harnesses.
class IntegrationTestHelper {
  static void ensureInitialized() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  }

  static AppConfig mockAppConfig() {
    return const AppConfig(
      apiBaseUrl: 'http://10.0.2.2:8000',
      environment: AppEnvironment.dev,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      sendTimeout: Duration(seconds: 15),
    );
  }

  static Widget createTestApp({
    required Widget child,
    List<dynamic> overrides = const [],
  }) {
    return ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(mockAppConfig()),
        runtimeAppConfigControllerProvider.overrideWith(
          () => _FakeRuntimeAppConfigController(const RuntimeAppConfig()),
        ),
        ...overrides.cast(),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  static Future<void> pumpAndSettle(
    WidgetTester tester, {
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    await tester.pump();
    await tester.pump(duration);
    await tester.pumpAndSettle();
  }
}
