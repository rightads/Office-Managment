import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/app.dart';
import 'package:right_ads/core/auth/biometric_service.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/widgets/config_error_app.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/auth/domain/repositories/auth_repository.dart';

class _AuthenticatedTestRepo implements AuthRepository {
  const _AuthenticatedTestRepo();

  @override
  Future<bool> hasStoredSession() async => true;

  @override
  Future<(AuthUser?, AppFailure?)> getCurrentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return (
      const AuthUser(
        id: 'u-1',
        employeeCode: 'EMP-1',
        fullName: 'Test Employee',
        email: 'test@rightads.example',
        roleLabel: 'Employee',
        permissions: <String>[],
        mustChangePassword: false,
      ),
      null,
    );
  }

  @override
  Future<(AuthUser?, AppFailure?)> login({
    required String email,
    required String password,
  }) async => getCurrentUser();

  @override
  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async => null;

  @override
  Future<AppFailure?> forgotPassword({required String email}) async => null;

  @override
  Future<AppFailure?> resetPassword({
    required String token,
    required String newPassword,
  }) async => null;

  @override
  Future<void> logout() async {}

  @override
  Future<AppFailure?> logoutAll() async => null;
}

class _DisabledBiometricService implements BiometricService {
  const _DisabledBiometricService();

  @override
  Future<bool> authenticate({required String localizedReason}) async => true;

  @override
  bool isEnabledByUser() => false;

  @override
  Future<bool> isHardwareAvailable() async => false;

  @override
  Future<void> setEnabledByUser({required bool enabled}) async {}
}

void main() {
  group('Bootstrap & Initial Screens', () {
    testWidgets(
      'RightAdsApp shows SplashScreen then navigates to PlaceholderHomeScreen when session is valid',
      (tester) async {
        const testConfig = AppConfig(
          environment: AppEnvironment.dev,
          apiBaseUrl: 'http://10.0.2.2:8000/api/v1',
          connectTimeout: Duration(seconds: 15),
          receiveTimeout: Duration(seconds: 30),
          sendTimeout: Duration(seconds: 15),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appConfigProvider.overrideWithValue(testConfig),
              authRepositoryProvider.overrideWithValue(
                const _AuthenticatedTestRepo(),
              ),
              biometricServiceProvider.overrideWithValue(
                const _DisabledBiometricService(),
              ),
            ],
            child: const RightAdsApp(),
          ),
        );

        await tester.pump();
        expect(find.text('Initializing workspace...'), findsOneWidget);

        await tester.pumpAndSettle();
        expect(find.text('Right Ads Workspace Ready'), findsOneWidget);
        expect(find.text('Environment: DEV'), findsOneWidget);
        expect(
          find.text('API Base URL: http://10.0.2.2:8000/api/v1'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'ConfigErrorApp displays missing configuration keys when validation fails',
      (tester) async {
        const invalidResult = AppConfigInvalid(
          invalidKeys: <String>[
            AppConfigEnvKeys.environment,
            AppConfigEnvKeys.apiBaseUrl,
          ],
        );

        await tester.pumpWidget(
          const ConfigErrorApp(validationError: invalidResult),
        );
        await tester.pumpAndSettle();

        expect(find.text('Configuration Error'), findsOneWidget);
        expect(find.text(AppConfigEnvKeys.environment), findsOneWidget);
        expect(find.text(AppConfigEnvKeys.apiBaseUrl), findsOneWidget);
      },
    );
  });
}
