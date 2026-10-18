import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/storage/device_identity_service.dart';
import 'package:right_ads/core/storage/secure_storage.dart';
import 'package:right_ads/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:right_ads/features/auth/data/models/auth_dtos.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._secureStorage,
    required this._deviceIdentity,
  });

  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorage;
  final DeviceIdentityService _deviceIdentity;

  @override
  Future<bool> hasStoredSession() async {
    final access = await _secureStorage.readAccessToken();
    final refresh = await _secureStorage.readRefreshToken();
    return (access != null && access.isNotEmpty) ||
        (refresh != null && refresh.isNotEmpty);
  }

  @override
  Future<(AuthUser?, AppFailure?)> getCurrentUser() async {
    try {
      final profileDto = await _remoteDataSource.getMyProfile();
      return (AuthUser.fromDto(profileDto), null);
    } on Object catch (e) {
      return (null, ErrorMapper.mapException(e));
    }
  }

  @override
  Future<(AuthUser?, AppFailure?)> login({
    required String email,
    required String password,
  }) async {
    try {
      final deviceId = await _deviceIdentity.getOrCreateDeviceId();
      final tokenDto = await _remoteDataSource.login(
        LoginRequestDto(
          email: email.trim(),
          password: password,
          deviceId: deviceId,
        ),
      );

      await _secureStorage.writeAccessToken(tokenDto.accessToken);
      await _secureStorage.writeRefreshToken(tokenDto.refreshToken);

      final profileDto = await _remoteDataSource.getMyProfile();
      return (AuthUser.fromDto(profileDto), null);
    } on Object catch (e) {
      await _secureStorage.clearTokens();
      return (null, ErrorMapper.mapException(e));
    }
  }

  @override
  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        ChangePasswordRequestDto(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      return null;
    } on Object catch (e) {
      return ErrorMapper.mapException(e);
    }
  }

  @override
  Future<AppFailure?> forgotPassword({required String email}) async {
    try {
      await _remoteDataSource.forgotPassword(
        ForgotPasswordRequestDto(email: email.trim()),
      );
      return null;
    } on Object catch (e) {
      return ErrorMapper.mapException(e);
    }
  }

  @override
  Future<AppFailure?> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        ResetPasswordRequestDto(
          token: token.trim(),
          newPassword: newPassword,
        ),
      );
      return null;
    } on Object catch (e) {
      return ErrorMapper.mapException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _secureStorage.readRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        final deviceId = await _deviceIdentity.getOrCreateDeviceId();
        await _remoteDataSource.logout(
          RefreshTokenRequestDto(
            refreshToken: refreshToken,
            deviceId: deviceId,
          ),
        );
      }
    } on Object {
      // Always clear local tokens even if server revocation fails due to network.
    } finally {
      await _secureStorage.clearTokens();
    }
  }

  @override
  Future<AppFailure?> logoutAll() async {
    try {
      await _remoteDataSource.logoutAll();
      await _secureStorage.clearTokens();
      return null;
    } on Object catch (e) {
      await _secureStorage.clearTokens();
      return ErrorMapper.mapException(e);
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    secureStorage: ref.watch(secureStorageServiceProvider),
    deviceIdentity: ref.watch(deviceIdentityServiceProvider),
  );
}
