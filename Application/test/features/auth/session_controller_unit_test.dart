import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/auth/biometric_service.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/notifications/notification_service.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/auth/domain/repositories/auth_repository.dart';

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({
    this.hasSession = false,
    this.userToReturn,
    this.userFailure,
  });

  bool hasSession;
  AuthUser? userToReturn;
  AppFailure? userFailure;
  int logoutCalls = 0;
  int logoutAllCalls = 0;
  AppFailure? changePasswordFailure;

  @override
  Future<bool> hasStoredSession() async => hasSession;

  @override
  Future<(AuthUser?, AppFailure?)> getCurrentUser() async =>
      (userToReturn, userFailure);

  @override
  Future<(AuthUser?, AppFailure?)> login({
    required String email,
    required String password,
  }) async => (userToReturn, userFailure);

  @override
  Future<AppFailure?> logout() async {
    logoutCalls++;
    hasSession = false;
    return null;
  }

  @override
  Future<AppFailure?> logoutAll() async {
    logoutAllCalls++;
    hasSession = false;
    return null;
  }

  @override
  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async => changePasswordFailure;

  @override
  Future<AppFailure?> forgotPassword({required String email}) async => null;

  @override
  Future<AppFailure?> resetPassword({
    required String token,
    required String newPassword,
  }) async => null;
}

class _FakeBiometricService implements BiometricService {
  _FakeBiometricService({
    this.enabled = false,
    this.hardware = false,
  }) : authSuccess = true;

  bool enabled;
  bool hardware;
  bool authSuccess;

  @override
  Future<bool> authenticate({required String localizedReason}) async =>
      authSuccess;

  @override
  bool isEnabledByUser() => enabled;

  @override
  Future<bool> isHardwareAvailable() async => hardware;

  @override
  Future<void> setEnabledByUser({required bool enabled}) async {
    this.enabled = enabled;
  }
}

class _FakeNotificationService extends Fake implements NotificationService {
  int unregisterCalls = 0;

  @override
  Future<void> unregisterDeviceToken() async {
    unregisterCalls++;
  }
}

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  @override
  RuntimeAppConfig build() => const RuntimeAppConfig();

  @override
  Future<(RuntimeAppConfig, AppFailure?)> refreshFromServer() async =>
      (const RuntimeAppConfig(), null);
}

Future<void> _pumpEvents({int times = 20}) async {
  for (var i = 0; i < times; i++) {
    await pumpEventQueue();
  }
}

void main() {
  const testUser = AuthUser(
    id: 'u-123',
    employeeCode: 'EMP123',
    fullName: 'Jane Doe',
    email: 'test@rightads.agency',
    roleLabel: 'Software Engineer',
    permissions: [PermissionCodes.attendanceCheckIn],
    mustChangePassword: false,
  );

  const testConfig = AppConfig(
    environment: AppEnvironment.dev,
    apiBaseUrl: 'http://10.0.2.2:8000/api/v1',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    sendTimeout: Duration(seconds: 5),
  );

  group('SessionController Unit Tests', () {
    test('Bootstraps unauthenticated when no stored session', () async {
      final fakeRepo = _FakeAuthRepository();
      final container = ProviderContainer(
        overrides: [
          appConfigProvider.overrideWithValue(testConfig),
          runtimeAppConfigControllerProvider.overrideWith(
            _FakeRuntimeAppConfigController.new,
          ),
          authRepositoryProvider.overrideWithValue(fakeRepo),
          biometricServiceProvider.overrideWithValue(_FakeBiometricService()),
          notificationServiceProvider.overrideWithValue(
            _FakeNotificationService(),
          ),
        ],
      );
      final sub = container.listen(sessionControllerProvider, (_, _) {});
      addTearDown(() {
        sub.close();
        container.dispose();
      });

      final state = container.read(sessionControllerProvider);
      expect(state, isA<AuthLoading>());

      await _pumpEvents();

      final updatedState = container.read(sessionControllerProvider);
      expect(updatedState, isA<AuthUnauthenticated>());
      expect(
        container
            .read(userPermissionsControllerProvider)
            .can(PermissionCodes.attendanceCheckIn),
        isFalse,
      );
    });

    test(
      'Bootstraps authenticated and populates permissions when valid session exists',
      () async {
        final fakeRepo = _FakeAuthRepository(
          hasSession: true,
          userToReturn: testUser,
        );
        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(testConfig),
            runtimeAppConfigControllerProvider.overrideWith(
              _FakeRuntimeAppConfigController.new,
            ),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(_FakeBiometricService()),
            notificationServiceProvider.overrideWithValue(
              _FakeNotificationService(),
            ),
          ],
        );
        final sub = container.listen(sessionControllerProvider, (_, _) {});
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        await _pumpEvents();

        final state = container.read(sessionControllerProvider);
        expect(state, isA<AuthAuthenticated>());
        final auth = state as AuthAuthenticated;
        expect(auth.user.id, 'u-123');
        expect(auth.isBiometricLocked, isFalse);
        expect(
          container
              .read(userPermissionsControllerProvider)
              .can(PermissionCodes.attendanceCheckIn),
          isTrue,
        );
      },
    );

    test(
      'Bootstraps with biometric lock if enabled and hardware available',
      () async {
        final fakeRepo = _FakeAuthRepository(
          hasSession: true,
          userToReturn: testUser,
        );
        final fakeBiometric = _FakeBiometricService(
          enabled: true,
          hardware: true,
        );
        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(testConfig),
            runtimeAppConfigControllerProvider.overrideWith(
              _FakeRuntimeAppConfigController.new,
            ),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(fakeBiometric),
            notificationServiceProvider.overrideWithValue(
              _FakeNotificationService(),
            ),
          ],
        );
        final sub = container.listen(sessionControllerProvider, (_, _) {});
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        await _pumpEvents();

        final initialAuthState = container.read(sessionControllerProvider);
        expect(initialAuthState, isA<AuthAuthenticated>());
        expect(
          (initialAuthState as AuthAuthenticated).isBiometricLocked,
          isTrue,
        );

        // Unlock with biometrics
        final unlocked = await container
            .read(sessionControllerProvider.notifier)
            .unlockWithBiometrics(localizedReason: 'Test unlock');
        expect(unlocked, isTrue);

        final unlockedAuthState = container.read(sessionControllerProvider);
        expect(unlockedAuthState, isA<AuthAuthenticated>());
        expect(
          (unlockedAuthState as AuthAuthenticated).isBiometricLocked,
          isFalse,
        );
      },
    );

    test(
      'Handles token reuse failure on bootstrap with proper expiry reason',
      () async {
        final fakeRepo = _FakeAuthRepository(
          hasSession: true,
          userFailure: const AppFailure.unauthorized(
            message: 'Token reuse',
            isTokenReuse: true,
          ),
        );
        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(testConfig),
            runtimeAppConfigControllerProvider.overrideWith(
              _FakeRuntimeAppConfigController.new,
            ),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(_FakeBiometricService()),
            notificationServiceProvider.overrideWithValue(
              _FakeNotificationService(),
            ),
          ],
        );
        final sub = container.listen(sessionControllerProvider, (_, _) {});
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        await _pumpEvents();

        final state = container.read(sessionControllerProvider);
        expect(state, isA<AuthUnauthenticated>());
        expect(
          (state as AuthUnauthenticated).expiryReason,
          SessionExpiryReason.tokenReuse,
        );
        expect(fakeRepo.logoutCalls, 1);
      },
    );

    test('logoutAll unregisters push token and revokes all sessions', () async {
      final fakeRepo = _FakeAuthRepository(
        hasSession: true,
        userToReturn: testUser,
      );
      final fakeNotifications = _FakeNotificationService();
      final container = ProviderContainer(
        overrides: [
          appConfigProvider.overrideWithValue(testConfig),
          runtimeAppConfigControllerProvider.overrideWith(
            _FakeRuntimeAppConfigController.new,
          ),
          authRepositoryProvider.overrideWithValue(fakeRepo),
          biometricServiceProvider.overrideWithValue(_FakeBiometricService()),
          notificationServiceProvider.overrideWithValue(fakeNotifications),
        ],
      );
      final sub = container.listen(sessionControllerProvider, (_, _) {});
      addTearDown(() {
        sub.close();
        container.dispose();
      });

      await _pumpEvents();
      expect(
        container.read(sessionControllerProvider),
        isA<AuthAuthenticated>(),
      );

      await container.read(sessionControllerProvider.notifier).logoutAll();

      expect(fakeRepo.logoutAllCalls, 1);
      expect(fakeNotifications.unregisterCalls, 1);
      expect(
        container.read(sessionControllerProvider),
        isA<AuthUnauthenticated>(),
      );
      expect(
        container
            .read(userPermissionsControllerProvider)
            .can(PermissionCodes.attendanceCheckIn),
        isFalse,
      );
    });

    test(
      'changePassword falls back to local user update if getCurrentUser fails',
      () async {
        final fakeRepo = _FakeAuthRepository(
          hasSession: true,
          userToReturn: testUser.copyWith(mustChangePassword: true),
        );
        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(testConfig),
            runtimeAppConfigControllerProvider.overrideWith(
              _FakeRuntimeAppConfigController.new,
            ),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(_FakeBiometricService()),
            notificationServiceProvider.overrideWithValue(
              _FakeNotificationService(),
            ),
          ],
        );
        final sub = container.listen(sessionControllerProvider, (_, _) {});
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        await _pumpEvents();
        expect(
          container.read(sessionControllerProvider),
          isA<AuthMustChangePassword>(),
        );

        // Make getCurrentUser return an error on subsequent call
        fakeRepo.userToReturn = null;
        fakeRepo.userFailure = const AppFailure.server(message: 'Error');

        final failure = await container
            .read(sessionControllerProvider.notifier)
            .changePassword(
              currentPassword: 'old',
              newPassword: 'new',
            );

        expect(failure, isNull);
        final state = container.read(sessionControllerProvider);
        expect(state, isA<AuthAuthenticated>());
        expect((state as AuthAuthenticated).user.mustChangePassword, isFalse);
      },
    );
  });
}
