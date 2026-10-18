import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/app.dart';
import 'package:right_ads/core/auth/biometric_service.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/auth/domain/repositories/auth_repository.dart';

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({
    this.storedSession = false,
    this.initialUser,
    this.loginResultUser,
  });

  bool storedSession;
  AuthUser? initialUser;
  AuthUser? loginResultUser;
  int logoutCallCount = 0;

  @override
  Future<bool> hasStoredSession() async => storedSession;

  @override
  Future<(AuthUser?, AppFailure?)> getCurrentUser() async {
    if (initialUser != null) {
      return (initialUser, null);
    }
    return (null, const AppFailure.unauthorized(message: 'Session expired'));
  }

  @override
  Future<(AuthUser?, AppFailure?)> login({
    required String email,
    required String password,
  }) async {
    storedSession = true;
    initialUser = loginResultUser;
    return (loginResultUser, null);
  }

  @override
  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (initialUser != null) {
      initialUser = initialUser!.copyWith(mustChangePassword: false);
    }
    return null;
  }

  @override
  Future<AppFailure?> forgotPassword({required String email}) async => null;

  @override
  Future<AppFailure?> resetPassword({
    required String token,
    required String newPassword,
  }) async => null;

  @override
  Future<void> logout() async {
    logoutCallCount++;
    storedSession = false;
    initialUser = null;
  }

  @override
  Future<AppFailure?> logoutAll() async {
    storedSession = false;
    initialUser = null;
    return null;
  }
}

class _FakeBiometricService implements BiometricService {
  const _FakeBiometricService();

  @override
  Future<bool> authenticate({required String localizedReason}) async => true;

  @override
  bool isEnabledByUser() => false;

  @override
  Future<bool> isHardwareAvailable() async => false;

  @override
  Future<void> setEnabledByUser({required bool enabled}) async {}
}

const _testConfig = AppConfig(
  environment: AppEnvironment.dev,
  apiBaseUrl: 'http://10.0.2.2:8000/api/v1',
  connectTimeout: Duration(seconds: 15),
  receiveTimeout: Duration(seconds: 30),
  sendTimeout: Duration(seconds: 15),
);

const _sampleUser = AuthUser(
  id: 'user-1',
  employeeCode: 'EMP001',
  fullName: 'Aarav Sharma',
  email: 'aarav@rightads.example',
  roleLabel: 'Employee',
  mustChangePassword: false,
  permissions: <String>[
    PermissionCodes.attendanceCheckIn,
    PermissionCodes.taskViewAssigned,
  ],
);

void main() {
  group('Authentication Flow & SessionController', () {
    testWidgets(
      'Unauthenticated bootstrap redirects from /splash to /login, then login navigates to / and populates permissions',
      (tester) async {
        final fakeRepo = _FakeAuthRepository(
          loginResultUser: _sampleUser,
        );

        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(_testConfig),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(
              const _FakeBiometricService(),
            ),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const RightAdsApp(),
          ),
        );

        await tester.pumpAndSettle();

        // Should now be on LoginScreen
        expect(find.text('Sign In to Right Ads'), findsOneWidget);

        // Enter credentials and submit
        await tester.enterText(
          find.bySemanticsLabel('Work Email'),
          'aarav@rightads.example',
        );
        await tester.enterText(
          find.bySemanticsLabel('Password'),
          'SecretPass123!',
        );
        await tester.tap(find.text('Sign In'));
        await tester.pumpAndSettle();

        // Should now be on PlaceholderHomeScreen with user info and permissions loaded
        expect(find.text('Right Ads Workspace Ready'), findsOneWidget);
        expect(
          find.text('Signed in as Aarav Sharma (EMP001)'),
          findsOneWidget,
        );
        final perms = container.read(userPermissionsControllerProvider);
        expect(perms.can(PermissionCodes.attendanceCheckIn), isTrue);
        expect(perms.can(PermissionCodes.taskViewAssigned), isTrue);
        expect(perms.can(PermissionCodes.systemManageSettings), isFalse);
      },
    );

    testWidgets(
      'Login with mustChangePassword=true forces /force-change-password until password is updated, and logout clears permissions',
      (tester) async {
        final forcedUser = _sampleUser.copyWith(mustChangePassword: true);
        final fakeRepo = _FakeAuthRepository(
          storedSession: true,
          initialUser: forcedUser,
        );

        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(_testConfig),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(
              const _FakeBiometricService(),
            ),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const RightAdsApp(),
          ),
        );
        await tester.pumpAndSettle();

        // Should be redirected to ForceChangePasswordScreen
        expect(find.text('Password Update Required'), findsWidgets);

        await tester.enterText(
          find.bySemanticsLabel('Current / Temporary Password'),
          'TempPass123',
        );
        await tester.enterText(
          find.bySemanticsLabel('New Password'),
          'UpdatedPass123!',
        );
        await tester.enterText(
          find.bySemanticsLabel('Confirm New Password'),
          'UpdatedPass123!',
        );

        await tester.tap(find.text('Update Password'));
        await tester.pumpAndSettle();

        // After changing password, user is redirected to Home
        expect(find.text('Right Ads Workspace Ready'), findsOneWidget);

        // Now trigger logout via SessionController
        await container.read(sessionControllerProvider.notifier).logout();
        await tester.pumpAndSettle();

        expect(find.text('Sign In to Right Ads'), findsOneWidget);
        expect(
          container
              .read(userPermissionsControllerProvider)
              .can(PermissionCodes.attendanceCheckIn),
          isFalse,
        );
      },
    );

    testWidgets(
      'Token reuse session expiry shows security warning banner on LoginScreen',
      (tester) async {
        final fakeRepo = _FakeAuthRepository();

        final container = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(_testConfig),
            authRepositoryProvider.overrideWithValue(fakeRepo),
            biometricServiceProvider.overrideWithValue(
              const _FakeBiometricService(),
            ),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const RightAdsApp(),
          ),
        );
        await tester.pumpAndSettle();

        container
            .read(sessionControllerProvider.notifier)
            .handleSessionExpired(reason: SessionExpiryReason.tokenReuse);
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Security alert: session token reuse detected. All sessions were revoked. Please sign in again.',
          ),
          findsOneWidget,
        );
      },
    );
  });
}
