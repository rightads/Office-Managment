import 'package:dio/dio.dart';
import 'package:right_ads/core/utils/app_logger.dart';

/// Logs HTTP requests, responses, and errors while redacting sensitive
/// headers and body fields so secrets never appear in logs.
class RedactingLogInterceptor extends Interceptor {
  const RedactingLogInterceptor(this._logger);

  final AppLogger _logger;

  static const Set<String> _redactedKeys = <String>{
    'authorization',
    'password',
    'current_password',
    'new_password',
    'access_token',
    'refresh_token',
    'token',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final safeHeaders = sanitizeMap(options.headers);
    final safeData = sanitizeValue(options.data);
    _logger.debug(
      '--> ${options.method} ${options.uri}\nHeaders: $safeHeaders\nBody: $safeData',
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final safeData = sanitizeValue(response.data);
    _logger.debug(
      '<-- ${response.statusCode} ${response.requestOptions.uri}\nBody: $safeData',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final safeData = sanitizeValue(err.response?.data);
    _logger.warning(
      '<-- ERROR ${err.response?.statusCode ?? err.type.name} ${err.requestOptions.uri}\nBody: $safeData',
    );
    handler.next(err);
  }

  static Map<String, Object?> sanitizeMap(Map<dynamic, dynamic> raw) {
    final result = <String, Object?>{};
    for (final entry in raw.entries) {
      final keyStr = entry.key.toString();
      if (_redactedKeys.contains(keyStr.toLowerCase())) {
        result[keyStr] = '[REDACTED]';
      } else {
        result[keyStr] = sanitizeValue(entry.value);
      }
    }
    return result;
  }

  static Object? sanitizeValue(Object? value) {
    if (value is Map) {
      return sanitizeMap(value);
    }
    if (value is List) {
      return value.map(sanitizeValue).toList();
    }
    return value;
  }
}
