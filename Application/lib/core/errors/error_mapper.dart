import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';

/// Maps [DioException] and backend `StandardErrorResponse` /
/// `HTTPValidationError` payloads into the unified [AppFailure] hierarchy.
abstract final class ErrorMapper {
  static AppFailure mapException(Object error) {
    if (error is AppFailure) return error;
    if (error is! DioException) {
      return AppFailure.unknown(message: error.toString(), cause: error);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return AppFailure.network(
          message: _extractMessage(error.response?.data),
        );
      case DioExceptionType.cancel:
        return const AppFailure.network();
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        if (error.response == null) {
          return const AppFailure.network();
        }
        return _mapStatusCode(
          statusCode: error.response?.statusCode,
          data: error.response?.data,
          cause: error,
        );
      case DioExceptionType.badResponse:
        return _mapStatusCode(
          statusCode: error.response?.statusCode,
          data: error.response?.data,
          cause: error,
        );
    }
  }

  static AppFailure _mapStatusCode({
    required int? statusCode,
    required Object? data,
    required Object cause,
  }) {
    final message = _extractMessage(data);
    final errorCode = _extractErrorCode(data);
    final fieldErrors = _extractFieldErrors(data);

    switch (statusCode) {
      case 401:
        final isReuse = _isTokenReuse(message: message, errorCode: errorCode);
        return AppFailure.unauthorized(
          message: message,
          errorCode: errorCode,
          isTokenReuse: isReuse,
        );
      case 403:
        return AppFailure.forbidden(
          message: message,
          errorCode: errorCode,
        );
      case 404:
        return AppFailure.notFound(
          message: message,
          errorCode: errorCode,
        );
      case 409:
        return AppFailure.conflict(
          message: message,
          errorCode: errorCode,
        );
      case 400:
      case 422:
        return AppFailure.validation(
          message: message,
          errorCode: errorCode,
          fieldErrors: fieldErrors,
        );
      default:
        if (statusCode != null && statusCode >= 500) {
          return AppFailure.server(
            message: message,
            statusCode: statusCode,
            errorCode: errorCode,
          );
        }
        return AppFailure.unknown(message: message, cause: cause);
    }
  }

  static bool _isTokenReuse({String? message, String? errorCode}) {
    final lowerMsg = (message ?? '').toLowerCase();
    final lowerCode = (errorCode ?? '').toLowerCase();
    return lowerMsg.contains('reuse') || lowerCode.contains('reuse');
  }

  static String? _extractMessage(Object? data) {
    if (data is Map<String, dynamic>) {
      final errorObj = data['error'];
      if (errorObj is Map<String, dynamic>) {
        final msg = errorObj['message'];
        if (msg is String && msg.trim().isNotEmpty) {
          return msg.trim();
        }
      }
      final topMsg = data['message'];
      if (topMsg is String && topMsg.trim().isNotEmpty) {
        return topMsg.trim();
      }
      final detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail.trim();
      }
    }
    return null;
  }

  static String? _extractErrorCode(Object? data) {
    if (data is Map<String, dynamic>) {
      final errorObj = data['error'];
      if (errorObj is Map<String, dynamic>) {
        final code = errorObj['code'];
        if (code is String && code.trim().isNotEmpty) {
          return code.trim();
        }
      }
    }
    return null;
  }

  static Map<String, List<String>> _extractFieldErrors(Object? data) {
    final result = <String, List<String>>{};
    if (data is! Map<String, dynamic>) return result;

    List<dynamic>? rawDetails;
    final errorObj = data['error'];
    if (errorObj is Map<String, dynamic> && errorObj['details'] is List) {
      rawDetails = errorObj['details'] as List<dynamic>;
    } else if (data['detail'] is List) {
      rawDetails = data['detail'] as List<dynamic>;
    }

    if (rawDetails == null) return result;

    for (final item in rawDetails) {
      if (item is! Map<String, dynamic>) continue;
      final msg = item['msg']?.toString().trim();
      if (msg == null || msg.isEmpty) continue;

      var fieldKey = 'general';
      final loc = item['loc'];
      if (loc is List && loc.isNotEmpty) {
        fieldKey = loc.last.toString();
      }
      result.putIfAbsent(fieldKey, () => <String>[]).add(msg);
    }

    return result;
  }
}
