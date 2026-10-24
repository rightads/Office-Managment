import 'dart:async';

import 'package:right_ads/core/auth/biometric_service.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/notifications/notification_service.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_controller.g.dart';

@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  AuthState build() {
    ref.watch(sessionExpiryProvider).register(
      ({required isTokenReuse}) {
        handleSessionExpired(
          reason: isTokenReuse
              ? SessionExpiryReason.tokenReuse
              : SessionExpiryReason.expired,
        );
      },
    );

    unawaited(Future<void>.microtask(_bootstrapSession));
    return const AuthState.loading();
  }

  Future<void> _bootstrapSession() async {
    unawaited(
      ref.read(runtimeAppConfigControllerProvider.notifier).refreshFromServer(),
    );

    final repo = ref.read(authRepositoryProvider);
    final hasSession = await repo.hasStoredSession();
    if (!hasSession) {
      _clearPermissions();
      state = const AuthState.unauthenticated();
      return;
    }

    final (user, failure) = await repo.getCurrentUser();
    if (user == null || failure != null) {
      if (failure is UnauthorizedFailure) {
        await repo.logout();
        _clearPermissions();
        state = AuthState.unauthenticated(
          expiryReason: failure.isTokenReuse
              ? SessionExpiryReason.tokenReuse
              : SessionExpiryReason.expired,
        );
        return;
      }
      _clearPermissions();
      state = const AuthState.unauthenticated();
      return;
    }

    final biometricSvc = ref.read(biometricServiceProvider);
    final lockWithBiometrics =
        biometricSvc.isEnabledByUser() &&
        await biometricSvc.isHardwareAvailable();

    _applyAuthenticatedUser(user, isBiometricLocked: lockWithBiometrics);
  }

  Future<AppFailure?> login({
    required String email,
    required String password,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    final (user, failure) = await repo.login(
      email: email,
      password: password,
    );

    if (failure != null || user == null) {
      return failure ?? const AppFailure.unknown();
    }

    _applyAuthenticatedUser(user, isBiometricLocked: false);
    return null;
  }

  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    final failure = await repo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    if (failure != null) {
      return failure;
    }

    // Refresh user profile from `/auth/me` so `must_change_password: false` is confirmed.
    final (updatedUser, meFailure) = await repo.getCurrentUser();
    if (updatedUser != null && meFailure == null) {
      _applyAuthenticatedUser(updatedUser, isBiometricLocked: false);
    } else {
      final current = state;
      if (current is AuthMustChangePassword) {
        _applyAuthenticatedUser(
          current.user.copyWith(mustChangePassword: false),
          isBiometricLocked: false,
        );
      }
    }
    return null;
  }

  Future<bool> unlockWithBiometrics({required String localizedReason}) async {
    final current = state;
    if (current is! AuthAuthenticated || !current.isBiometricLocked) {
      return true;
    }

    final success = await ref
        .read(biometricServiceProvider)
        .authenticate(localizedReason: localizedReason);
    if (success) {
      state = current.copyWith(isBiometricLocked: false);
    }
    return success;
  }

  Future<void> logout() async {
    try {
      await ref.read(notificationServiceProvider).unregisterDeviceToken();
    } on Object catch (_) {}
    await ref.read(authRepositoryProvider).logout();
    _clearPermissions();
    state = const AuthState.unauthenticated();
  }

  Future<AppFailure?> logoutAll() async {
    try {
      await ref.read(notificationServiceProvider).unregisterDeviceToken();
    } on Object catch (_) {}
    final failure = await ref.read(authRepositoryProvider).logoutAll();
    _clearPermissions();
    state = const AuthState.unauthenticated();
    return failure;
  }

  void handleSessionExpired({
    SessionExpiryReason reason = SessionExpiryReason.expired,
  }) {
    try {
      unawaited(ref.read(notificationServiceProvider).unregisterDeviceToken());
    } on Object catch (_) {}
    _clearPermissions();
    state = AuthState.unauthenticated(expiryReason: reason);
  }

  void _applyAuthenticatedUser(
    AuthUser user, {
    required bool isBiometricLocked,
  }) {
    ref
        .read(userPermissionsControllerProvider.notifier)
        .setPermissions(user.permissions);

    if (user.mustChangePassword) {
      state = AuthState.mustChangePassword(user: user);
    } else {
      state = AuthState.authenticated(
        user: user,
        isBiometricLocked: isBiometricLocked,
      );
      unawaited(
        ref.read(navigationControllerProvider.notifier).loadInitialNavigation(),
      );
    }
  }

  void _clearPermissions() {
    ref.read(userPermissionsControllerProvider.notifier).clear();
    unawaited(ref.read(navigationControllerProvider.notifier).clear());
  }

  /// Development & Demo bypass to preview Admin View or Employee View
  /// without requiring a live backend or database.
  void loginAsDevDemo({required bool isAdmin}) {
    final permissions = isAdmin
        ? PermissionCodes.all
        : const <String>[
            PermissionCodes.attendanceCheckIn,
            PermissionCodes.attendanceViewOwn,
            PermissionCodes.taskViewAssigned,
            PermissionCodes.taskUpdate,
            PermissionCodes.leaveApply,
            PermissionCodes.leaveViewOwn,
            PermissionCodes.announcementView,
            PermissionCodes.workReportsSubmitOwn,
          ];

    final user = AuthUser(
      id: isAdmin ? 'demo-admin-id' : 'demo-employee-id',
      employeeCode: isAdmin ? 'ADM-001' : 'EMP-042',
      fullName: isAdmin ? 'Demo Admin' : 'Demo Employee',
      email: isAdmin ? 'admin@rightads.com' : 'employee@rightads.com',
      roleLabel: isAdmin ? 'Administrator' : 'Employee',
      permissions: permissions,
      mustChangePassword: false,
      designation: isAdmin
          ? 'Senior Operations & HR Admin'
          : 'Client Relations Executive',
      phone: '+91 98765 43210',
    );

    ref
        .read(userPermissionsControllerProvider.notifier)
        .setPermissions(permissions);

    final modules = isAdmin
        ? const <AppModuleItem>[
            AppModuleItem(
              id: 'mod-attendance',
              code: 'attendance',
              label: 'Attendance',
              iconKey: 'attendance',
              routeKey: 'attendance',
              sortOrder: 10,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-tasks',
              code: 'tasks',
              label: 'Tasks',
              iconKey: 'tasks',
              routeKey: 'tasks',
              sortOrder: 20,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-leave',
              code: 'leave',
              label: 'Leave',
              iconKey: 'leave',
              routeKey: 'leave',
              sortOrder: 30,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-reports',
              code: 'work_reports',
              label: 'Work Reports',
              iconKey: 'work_reports',
              routeKey: 'work_reports',
              sortOrder: 40,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-employees',
              code: 'admin_employees',
              label: 'Employees',
              iconKey: 'users',
              routeKey: 'admin_employees',
              sortOrder: 50,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-admin-ops',
              code: 'admin_operations',
              label: 'Operations',
              iconKey: 'roles',
              routeKey: 'admin_operations',
              sortOrder: 60,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-profile',
              code: 'profile',
              label: 'Profile',
              iconKey: 'profile',
              routeKey: 'profile',
              sortOrder: 70,
              isBase: true,
            ),
          ]
        : const <AppModuleItem>[
            AppModuleItem(
              id: 'mod-attendance',
              code: 'attendance',
              label: 'Attendance',
              iconKey: 'attendance',
              routeKey: 'attendance',
              sortOrder: 10,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-tasks',
              code: 'tasks',
              label: 'Tasks',
              iconKey: 'tasks',
              routeKey: 'tasks',
              sortOrder: 20,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-leave',
              code: 'leave',
              label: 'Leave',
              iconKey: 'leave',
              routeKey: 'leave',
              sortOrder: 30,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-reports',
              code: 'work_reports',
              label: 'Work Reports',
              iconKey: 'work_reports',
              routeKey: 'work_reports',
              sortOrder: 40,
              isBase: true,
            ),
            AppModuleItem(
              id: 'mod-profile',
              code: 'profile',
              label: 'Profile',
              iconKey: 'profile',
              routeKey: 'profile',
              sortOrder: 50,
              isBase: true,
            ),
          ];

    final navData = UserNavigationData(
      modules: modules,
      permissions: permissions,
      roleName: isAdmin ? 'admin' : 'employee',
      roleLabel: isAdmin ? 'Administrator' : 'Employee',
      departmentName: isAdmin ? 'Operations & HQ' : 'Sales & Marketing',
    );

    ref.read(navigationControllerProvider.notifier).setNavigationData(navData);

    state = AuthState.authenticated(user: user);
  }
}
