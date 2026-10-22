import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/auth/domain/repositories/auth_repository.dart';
import 'package:right_ads/features/auth/presentation/force_change_password_screen.dart';
import 'package:right_ads/features/auth/presentation/login_screen.dart';

import '../../integration_test/test_helper.dart';

class _MockAuthRepository implements AuthRepository {
  _MockAuthRepository({
    this.loginResultUser,
  }) : initialUser = null;

  AuthUser? initialUser;
  AuthUser? loginResultUser;
  bool passwordChanged = false;

  @override
  Future<bool> hasStoredSession() async => initialUser != null;

  @override
  Future<(AuthUser?, AppFailure?)> getCurrentUser() async {
    if (initialUser != null) {
      return (initialUser, null);
    }
    return (null, const AppFailure.unauthorized(message: 'No session'));
  }

  @override
  Future<(AuthUser?, AppFailure?)> login({
    required String email,
    required String password,
  }) async {
    initialUser = loginResultUser;
    return (loginResultUser, null);
  }

  @override
  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    passwordChanged = true;
    if (initialUser != null) {
      initialUser = initialUser!.copyWith(mustChangePassword: false);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    initialUser = null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const userWithMustChangePassword = AuthUser(
    id: 'emp-temp-1',
    employeeCode: 'EMP001',
    email: 'temp.user@rightads.com',
    fullName: 'Temp Employee',
    roleLabel: 'Graphic Designer',
    mustChangePassword: true,
    permissions: ['task.view_assigned'],
  );

  group('Auth & Password Change End-to-End Integration Flow', () {
    testWidgets(
      'completes login with temporary password then forces password change',
      (tester) async {
        final mockRepo = _MockAuthRepository(
          loginResultUser: userWithMustChangePassword,
        );

        // 1. Pump Login Screen
        await tester.pumpWidget(
          IntegrationTestHelper.createTestApp(
            child: const LoginScreen(),
            overrides: [
              authRepositoryProvider.overrideWithValue(mockRepo),
            ],
          ),
        );
        await IntegrationTestHelper.pumpAndSettle(tester);

        expect(find.byType(LoginScreen), findsOneWidget);
        expect(find.byType(AppTextField), findsNWidgets(2));

        // 2. Fill login credentials
        final emailField = find.byType(TextField).first;
        final passwordField = find.byType(TextField).last;
        final loginButton = find.byType(FilledButton);

        await tester.enterText(emailField, 'temp.user@rightads.com');
        await tester.enterText(passwordField, 'TemporaryPass123!');
        await tester.tap(loginButton);
        await IntegrationTestHelper.pumpAndSettle(tester);

        final element = tester.element(find.byType(LoginScreen));
        final l10n = element.l10n;
        expect(l10n.authLoginTitle, isNotEmpty);
        expect(mockRepo.initialUser?.mustChangePassword, isTrue);

        // 3. Pump Force Change Password Screen
        await tester.pumpWidget(
          IntegrationTestHelper.createTestApp(
            child: const ForceChangePasswordScreen(),
            overrides: [
              authRepositoryProvider.overrideWithValue(mockRepo),
            ],
          ),
        );
        await IntegrationTestHelper.pumpAndSettle(tester);

        expect(find.byType(ForceChangePasswordScreen), findsOneWidget);
        expect(find.byType(AppTextField), findsNWidgets(3));

        // 4. Fill password change form
        final textFields = find.byType(TextField);
        await tester.enterText(textFields.at(0), 'TemporaryPass123!');
        await tester.enterText(textFields.at(1), 'NewSecurePassword456!');
        await tester.enterText(textFields.at(2), 'NewSecurePassword456!');

        final submitButton = find.byType(FilledButton);
        await tester.ensureVisible(submitButton);
        await tester.tap(submitButton);
        await IntegrationTestHelper.pumpAndSettle(tester);

        // 5. Verify password successfully changed on repository and session
        expect(mockRepo.passwordChanged, isTrue);
        expect(mockRepo.initialUser?.mustChangePassword, isFalse);
      },
    );
  });
}
