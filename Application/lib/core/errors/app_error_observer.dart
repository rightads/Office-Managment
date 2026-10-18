import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/utils/app_logger.dart';

final class AppErrorObserver extends ProviderObserver {
  AppErrorObserver(this._logger);

  final AppLogger _logger;

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    _logger.error(
      'Provider ${context.provider.name ?? context.provider.runtimeType} failed',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
