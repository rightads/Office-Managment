import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/app.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/errors/app_error_observer.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/core/utils/app_logger.dart';
import 'package:right_ads/core/widgets/config_error_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap({required AppEnvironment expectedFlavor}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = AppLogger();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.error(
      'Uncaught Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.error(
      'Uncaught asynchronous platform error',
      error: error,
      stackTrace: stack,
    );
    return true;
  };

  final validationResult = AppConfigValidationResult.fromEnvironment(
    expectedFlavor: expectedFlavor,
  );

  switch (validationResult) {
    case AppConfigInvalid():
      logger.error(
        'AppConfig validation failed for keys: ${validationResult.invalidKeys.join(', ')}',
      );
      runApp(ConfigErrorApp(validationError: validationResult));
    case AppConfigValid(:final config):
      final prefs = await SharedPreferences.getInstance();
      logger.info(
        'Bootstrapping Right Ads in ${config.environment.value} mode',
      );
      runApp(
        ProviderScope(
          observers: <ProviderObserver>[AppErrorObserver(logger)],
          overrides: [
            appConfigProvider.overrideWithValue(config),
            sharedPreferencesProvider.overrideWithValue(prefs),
            appLoggerProvider.overrideWithValue(logger),
          ],
          child: const RightAdsApp(),
        ),
      );
  }
}
