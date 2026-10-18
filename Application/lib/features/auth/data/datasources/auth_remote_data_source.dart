import 'package:dio/dio.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/auth/data/models/auth_dtos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<TokenResponseDto> login(LoginRequestDto request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.authLogin,
      data: request.toJson(),
    );
    final data = _unwrapDataMap(response.data);
    return TokenResponseDto.fromJson(data);
  }

  Future<UserProfileResponseDto> getMyProfile() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.authMe,
    );
    final data = _unwrapDataMap(response.data);
    return UserProfileResponseDto.fromJson(data);
  }

  Future<void> logout(RefreshTokenRequestDto request) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.authLogout,
      data: request.toJson(),
    );
  }

  Future<void> logoutAll() async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.authLogoutAll,
    );
  }

  Future<void> changePassword(ChangePasswordRequestDto request) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.authChangePassword,
      data: request.toJson(),
    );
  }

  Future<void> forgotPassword(ForgotPasswordRequestDto request) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.authForgotPassword,
      data: request.toJson(),
    );
  }

  Future<void> resetPassword(ResetPasswordRequestDto request) async {
    await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.authResetPassword,
      data: request.toJson(),
    );
  }

  static Map<String, dynamic> _unwrapDataMap(Map<String, dynamic>? body) {
    final data = body?['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    throw const FormatException('Invalid StandardResponse envelope');
  }
}

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
}
