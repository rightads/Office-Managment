import 'dart:async';

import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/storage/secure_storage.dart';

typedef SessionExpiredCallback = void Function({required bool isTokenReuse});

/// Single-flight 401 refresh interceptor:
/// - Queues concurrent 401 responses behind a single `/auth/refresh` call.
/// - Supports token rotation by persisting both `access_token` and
///   `refresh_token` in [SecureStorageService].
/// - Retries queued requests once with the fresh access token.
/// - On refresh failure (or refresh-token reuse detection), clears tokens and
///   invokes `_onSessionExpired`.
class TokenRefreshInterceptor extends Interceptor {
  TokenRefreshInterceptor({
    required this._secureStorage,
    required this._refreshDio,
    required this._getDeviceId,
    this._onSessionExpired,
  });

  static const String _retriedExtraKey = 'right_ads_retried_after_refresh';

  final SecureStorageService _secureStorage;
  final Dio _refreshDio;
  final Future<String> Function() _getDeviceId;
  final SessionExpiredCallback? _onSessionExpired;

  Completer<String?>? _refreshCompleter;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final options = err.requestOptions;

    // Only intercept 401s on non-public endpoints that have not already been retried.
    if (statusCode != 401 ||
        ApiEndpoints.isPublicPath(options.path) ||
        options.extra[_retriedExtraKey] == true) {
      handler.next(err);
      return;
    }

    final newAccessToken = await _performSingleFlightRefresh();
    if (newAccessToken == null) {
      handler.next(err);
      return;
    }

    try {
      final retryOptions = options.copyWith(
        headers: <String, dynamic>{
          ...options.headers,
          'Authorization': 'Bearer $newAccessToken',
        },
        extra: <String, dynamic>{
          ...options.extra,
          _retriedExtraKey: true,
        },
      );
      final response = await _refreshDio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } on DioException catch (retryErr) {
      handler.next(retryErr);
    }
  }

  Future<String?> _performSingleFlightRefresh() async {
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    final completer = Completer<String?>();
    _refreshCompleter = completer;

    try {
      final refreshToken = await _secureStorage.readRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        await _handleRefreshFailure(isTokenReuse: false);
        completer.complete(null);
        return null;
      }

      final deviceId = await _getDeviceId();
      final response = await _refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.authRefresh,
        data: <String, dynamic>{
          'refresh_token': refreshToken,
          'device_id': deviceId,
        },
      );

      final body = response.data;
      final tokenData = body?['data'];
      if (tokenData is! Map<String, dynamic>) {
        await _handleRefreshFailure(isTokenReuse: false);
        completer.complete(null);
        return null;
      }

      final newAccess = tokenData['access_token'] as String?;
      final newRefresh = tokenData['refresh_token'] as String?;
      if (newAccess == null ||
          newAccess.isEmpty ||
          newRefresh == null ||
          newRefresh.isEmpty) {
        await _handleRefreshFailure(isTokenReuse: false);
        completer.complete(null);
        return null;
      }

      await _secureStorage.writeAccessToken(newAccess);
      await _secureStorage.writeRefreshToken(newRefresh);
      completer.complete(newAccess);
      return newAccess;
    } on DioException catch (e) {
      final mapped = ErrorMapper.mapException(e);
      final isReuse = mapped is UnauthorizedFailure && mapped.isTokenReuse;
      await _handleRefreshFailure(isTokenReuse: isReuse);
      completer.complete(null);
      return null;
    } on Object {
      await _handleRefreshFailure(isTokenReuse: false);
      completer.complete(null);
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _handleRefreshFailure({required bool isTokenReuse}) async {
    await _secureStorage.clearTokens();
    _onSessionExpired?.call(isTokenReuse: isTokenReuse);
  }
}
