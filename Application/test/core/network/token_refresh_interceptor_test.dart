import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/interceptors/auth_header_interceptor.dart';
import 'package:right_ads/core/network/interceptors/redacting_log_interceptor.dart';
import 'package:right_ads/core/network/interceptors/request_id_interceptor.dart';
import 'package:right_ads/core/network/interceptors/token_refresh_interceptor.dart';
import 'package:right_ads/core/storage/secure_storage.dart';

class _InMemorySecureStorage extends SecureStorageService {
  _InMemorySecureStorage() : super(const FlutterSecureStorage());

  String? _accessToken;
  String? _refreshToken;
  String? _deviceId;

  @override
  Future<void> writeAccessToken(String token) async => _accessToken = token;

  @override
  Future<String?> readAccessToken() async => _accessToken;

  @override
  Future<void> writeRefreshToken(String token) async => _refreshToken = token;

  @override
  Future<String?> readRefreshToken() async => _refreshToken;

  @override
  Future<void> writeDeviceId(String deviceId) async => _deviceId = deviceId;

  @override
  Future<String?> readDeviceId() async => _deviceId;

  @override
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
  }
}

class _FakeHttpClientAdapter implements HttpClientAdapter {
  _FakeHttpClientAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _jsonResponse(int statusCode, Map<String, dynamic> body) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: <String, List<String>>{
      Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    },
  );
}

void main() {
  group('TokenRefreshInterceptor & Interceptors', () {
    test(
      '3 concurrent 401 responses trigger exactly 1 /auth/refresh call and retry all 3 requests with rotated tokens',
      () async {
        final storage = _InMemorySecureStorage();
        await storage.writeAccessToken('expired-access-token');
        await storage.writeRefreshToken('initial-refresh-token');

        var refreshCallCount = 0;
        final observedAuthHeaders = <String>[];

        Future<ResponseBody> handleRequest(RequestOptions options) async {
          if (options.path.endsWith(ApiEndpoints.authRefresh)) {
            refreshCallCount++;
            await Future<void>.delayed(const Duration(milliseconds: 40));
            return _jsonResponse(200, <String, dynamic>{
              'success': true,
              'data': <String, dynamic>{
                'access_token': 'rotated-access-token',
                'refresh_token': 'rotated-refresh-token',
                'token_type': 'bearer',
              },
            });
          }

          final authHeader = options.headers['Authorization']?.toString() ?? '';
          observedAuthHeaders.add(authHeader);
          if (authHeader == 'Bearer expired-access-token') {
            return _jsonResponse(401, <String, dynamic>{
              'success': false,
              'error': <String, dynamic>{
                'code': 'UNAUTHORIZED',
                'message': 'Token has expired',
              },
            });
          }

          return _jsonResponse(200, <String, dynamic>{
            'success': true,
            'data': <String, dynamic>{'endpoint': options.path},
          });
        }

        final refreshDio = Dio(
          BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/v1'),
        )..httpClientAdapter = _FakeHttpClientAdapter(handleRequest);

        final clientDio = Dio(
          BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/v1'),
        )..httpClientAdapter = _FakeHttpClientAdapter(handleRequest);

        var sessionExpiredCount = 0;
        clientDio.interceptors.addAll(<Interceptor>[
          const RequestIdInterceptor(),
          AuthHeaderInterceptor(storage),
          TokenRefreshInterceptor(
            secureStorage: storage,
            refreshDio: refreshDio,
            getDeviceId: () async => 'device-123',
            onSessionExpired: ({required isTokenReuse}) {
              sessionExpiredCount++;
            },
          ),
        ]);

        final responses = await Future.wait(<Future<Response<dynamic>>>[
          clientDio.get<Map<String, dynamic>>('/auth/me'),
          clientDio.get<Map<String, dynamic>>('/tasks/my'),
          clientDio.get<Map<String, dynamic>>('/notifications'),
        ]);

        expect(refreshCallCount, 1);
        expect(sessionExpiredCount, 0);
        for (final response in responses) {
          expect(response.statusCode, 200);
          expect(
            response.requestOptions.headers['X-Request-ID'],
            isNotNull,
          );
        }
        expect(await storage.readAccessToken(), 'rotated-access-token');
        expect(await storage.readRefreshToken(), 'rotated-refresh-token');
        expect(
          observedAuthHeaders.where((h) => h == 'Bearer rotated-access-token'),
          hasLength(3),
        );
      },
    );

    test(
      'Refresh-token reuse detection clears tokens and invokes onSessionExpired(isTokenReuse: true)',
      () async {
        final storage = _InMemorySecureStorage();
        await storage.writeAccessToken('expired-access-token');
        await storage.writeRefreshToken('reused-refresh-token');

        Future<ResponseBody> handleRequest(RequestOptions options) async {
          if (options.path.endsWith(ApiEndpoints.authRefresh)) {
            return _jsonResponse(401, <String, dynamic>{
              'success': false,
              'error': <String, dynamic>{
                'code': 'UNAUTHORIZED',
                'message':
                    'Revoked refresh token reuse detected. All active sessions have been terminated.',
              },
            });
          }
          return _jsonResponse(401, <String, dynamic>{
            'success': false,
            'error': <String, dynamic>{
              'code': 'UNAUTHORIZED',
              'message': 'Token has expired',
            },
          });
        }

        final refreshDio = Dio(
          BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/v1'),
        )..httpClientAdapter = _FakeHttpClientAdapter(handleRequest);

        final clientDio = Dio(
          BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/v1'),
        )..httpClientAdapter = _FakeHttpClientAdapter(handleRequest);

        bool? observedTokenReuse;
        clientDio.interceptors.addAll(<Interceptor>[
          AuthHeaderInterceptor(storage),
          TokenRefreshInterceptor(
            secureStorage: storage,
            refreshDio: refreshDio,
            getDeviceId: () async => 'device-123',
            onSessionExpired: ({required isTokenReuse}) {
              observedTokenReuse = isTokenReuse;
            },
          ),
        ]);

        await expectLater(
          clientDio.get<Map<String, dynamic>>(ApiEndpoints.authMe),
          throwsA(isA<DioException>()),
        );

        expect(observedTokenReuse, isTrue);
        expect(await storage.readAccessToken(), isNull);
        expect(await storage.readRefreshToken(), isNull);
      },
    );

    test('RedactingLogInterceptor masks sensitive headers and body fields', () {
      final sanitizedHeaders = RedactingLogInterceptor.sanitizeMap(
        <String, dynamic>{
          'Authorization': 'Bearer super-secret-jwt',
          'X-Request-ID': 'req-123',
        },
      );
      expect(sanitizedHeaders['Authorization'], '[REDACTED]');
      expect(sanitizedHeaders['X-Request-ID'], 'req-123');

      final sanitizedBody =
          RedactingLogInterceptor.sanitizeValue(<String, dynamic>{
                'email': 'employee@rightads.example',
                'password': 'PlaintextPassword!',
                'data': <String, dynamic>{
                  'access_token': 'jwt-access',
                  'refresh_token': 'jwt-refresh',
                  'new_password': 'NewPassword123!',
                },
              })!
              as Map<String, Object?>;

      expect(sanitizedBody['email'], 'employee@rightads.example');
      expect(sanitizedBody['password'], '[REDACTED]');
      final nested = sanitizedBody['data']! as Map<String, Object?>;
      expect(nested['access_token'], '[REDACTED]');
      expect(nested['refresh_token'], '[REDACTED]');
      expect(nested['new_password'], '[REDACTED]');
    });
  });
}
