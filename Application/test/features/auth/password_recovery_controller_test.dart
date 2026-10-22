import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/auth/application/password_recovery_controller.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/auth/domain/repositories/auth_repository.dart';

class _FakeAuthRepository implements AuthRepository {
  AppFailure? forgotPasswordFailure;
  AppFailure? resetPasswordFailure;
  bool forgotPasswordCalled = false;
  bool resetPasswordCalled = false;

  @override
  Future<AppFailure?> forgotPassword({required String email}) async {
    forgotPasswordCalled = true;
    return forgotPasswordFailure;
  }

  @override
  Future<AppFailure?> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    resetPasswordCalled = true;
    return resetPasswordFailure;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('PasswordRecoveryController Tests', () {
    test('requestPasswordReset delegates to auth repository', () async {
      final fakeRepo = _FakeAuthRepository();
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        passwordRecoveryControllerProvider.notifier,
      );
      final failure = await controller.requestPasswordReset(
        email: 'user@test.com',
      );
      expect(failure, isNull);
      expect(fakeRepo.forgotPasswordCalled, isTrue);
      expect(container.read(passwordRecoveryControllerProvider), isFalse);
    });

    test('confirmPasswordReset delegates to auth repository', () async {
      final fakeRepo = _FakeAuthRepository();
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        passwordRecoveryControllerProvider.notifier,
      );
      final failure = await controller.confirmPasswordReset(
        token: 'token-123',
        newPassword: 'NewPassword123!',
      );
      expect(failure, isNull);
      expect(fakeRepo.resetPasswordCalled, isTrue);
      expect(container.read(passwordRecoveryControllerProvider), isFalse);
    });
  });
}
