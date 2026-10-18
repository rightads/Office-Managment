import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<bool> hasStoredSession();

  Future<(AuthUser?, AppFailure?)> getCurrentUser();

  Future<(AuthUser?, AppFailure?)> login({
    required String email,
    required String password,
  });

  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<AppFailure?> forgotPassword({
    required String email,
  });

  Future<AppFailure?> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<void> logout();

  Future<AppFailure?> logoutAll();
}
