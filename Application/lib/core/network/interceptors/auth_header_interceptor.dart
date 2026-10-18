import 'package:dio/dio.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/storage/secure_storage.dart';

class AuthHeaderInterceptor extends Interceptor {
  const AuthHeaderInterceptor(this._secureStorage);

  final SecureStorageService _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!ApiEndpoints.isPublicPath(options.path)) {
      final accessToken = await _secureStorage.readAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }
}
