import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_recovery_controller.g.dart';

@riverpod
class PasswordRecoveryController extends _$PasswordRecoveryController {
  @override
  bool build() => false;

  Future<AppFailure?> requestPasswordReset({required String email}) async {
    state = true;
    try {
      return await ref
          .read(authRepositoryProvider)
          .forgotPassword(email: email);
    } finally {
      state = false;
    }
  }

  Future<AppFailure?> confirmPasswordReset({
    required String token,
    required String newPassword,
  }) async {
    state = true;
    try {
      return await ref
          .read(authRepositoryProvider)
          .resetPassword(
            token: token,
            newPassword: newPassword,
          );
    } finally {
      state = false;
    }
  }
}
