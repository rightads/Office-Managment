import 'package:dio/dio.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/network/interceptors/auth_header_interceptor.dart';
import 'package:right_ads/core/network/interceptors/redacting_log_interceptor.dart';
import 'package:right_ads/core/network/interceptors/request_id_interceptor.dart';
import 'package:right_ads/core/network/interceptors/token_refresh_interceptor.dart';
import 'package:right_ads/core/storage/device_identity_service.dart';
import 'package:right_ads/core/storage/secure_storage.dart';
import 'package:right_ads/core/utils/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Callback registry allowing `SessionController` to subscribe to forced
/// session expiry events emitted by [TokenRefreshInterceptor] without
/// creating a circular provider dependency.
class SessionExpiryNotifier {
  SessionExpiredCallback? _listener;

  // Registry callback assignment method.
  // ignore: use_setters_to_change_properties
  void register(SessionExpiredCallback listener) {
    _listener = listener;
  }

  void notify({required bool isTokenReuse}) {
    _listener?.call(isTokenReuse: isTokenReuse);
  }
}

@Riverpod(keepAlive: true)
SessionExpiryNotifier sessionExpiryNotifier(Ref ref) {
  return SessionExpiryNotifier();
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final deviceIdentity = ref.watch(deviceIdentityServiceProvider);
  final logger = ref.watch(appLoggerProvider);
  final expiryNotifier = ref.watch(sessionExpiryProvider);

  final baseOptions = BaseOptions(
    baseUrl: config.apiBaseUrl,
    connectTimeout: config.connectTimeout,
    receiveTimeout: config.receiveTimeout,
    sendTimeout: config.sendTimeout,
    headers: const <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  // Separate un-intercepted Dio instance used strictly for `/auth/refresh`
  // and retrying requests after rotation.
  final refreshDio = Dio(baseOptions)
    ..interceptors.addAll(<Interceptor>[
      const RequestIdInterceptor(),
      RedactingLogInterceptor(logger),
    ]);

  final client = Dio(baseOptions);
  client.interceptors.addAll(<Interceptor>[
    const RequestIdInterceptor(),
    AuthHeaderInterceptor(secureStorage),
    TokenRefreshInterceptor(
      secureStorage: secureStorage,
      refreshDio: refreshDio,
      getDeviceId: deviceIdentity.getOrCreateDeviceId,
      onSessionExpired: expiryNotifier.notify,
    ),
    RedactingLogInterceptor(logger),
  ]);

  return client;
}
