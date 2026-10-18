import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/widgets/dev_gallery_screen.dart';
import 'package:right_ads/core/widgets/splash_screen.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/presentation/force_change_password_screen.dart';
import 'package:right_ads/features/auth/presentation/forgot_password_screen.dart';
import 'package:right_ads/features/auth/presentation/login_screen.dart';
import 'package:right_ads/features/auth/presentation/reset_password_screen.dart';
import 'package:right_ads/features/leaves/presentation/leave_detail_screen.dart';
import 'package:right_ads/features/leaves/presentation/leaves_screen.dart';
import 'package:right_ads/features/navigation/presentation/adaptive_shell_screen.dart';
import 'package:right_ads/features/navigation/presentation/forbidden_screen.dart';
import 'package:right_ads/features/navigation/presentation/force_update_screen.dart';
import 'package:right_ads/features/tasks/presentation/task_detail_screen.dart';
import 'package:right_ads/features/tasks/presentation/tasks_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refreshListenable = ValueNotifier<int>(0);
  ref
    ..listen<AuthState>(
      sessionControllerProvider,
      (_, _) => refreshListenable.value++,
    )
    ..listen<RuntimeAppConfig>(
      runtimeAppConfigControllerProvider,
      (_, _) => refreshListenable.value++,
    )
    ..onDispose(refreshListenable.dispose);

  const unauthenticatedAllowedPaths = <String>{
    RoutePaths.login,
    RoutePaths.forgotPassword,
    RoutePaths.resetPassword,
  };

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final authState = ref.read(sessionControllerProvider);
      final runtimeConfig = ref.read(runtimeAppConfigControllerProvider);
      final currentVersion = ref.read(currentAppVersionProvider);

      if (kDebugMode && location == RoutePaths.devGallery) {
        return null;
      }

      if (runtimeConfig.requiresForceUpdate(currentVersion)) {
        return location == RoutePaths.forceUpdate
            ? null
            : RoutePaths.forceUpdate;
      }

      if (location == RoutePaths.forceUpdate) {
        return RoutePaths.home;
      }

      return switch (authState) {
        AuthLoading() =>
          location == RoutePaths.splash ? null : RoutePaths.splash,
        AuthUnauthenticated() =>
          unauthenticatedAllowedPaths.contains(location)
              ? null
              : RoutePaths.login,
        AuthMustChangePassword() =>
          location == RoutePaths.forceChangePassword
              ? null
              : RoutePaths.forceChangePassword,
        AuthAuthenticated() =>
          (location == RoutePaths.splash ||
                  unauthenticatedAllowedPaths.contains(location) ||
                  location == RoutePaths.forceChangePassword)
              ? RoutePaths.home
              : null,
      };
    },
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.forceUpdate,
        builder: (context, state) => const ForceUpdateScreen(),
      ),
      GoRoute(
        path: RoutePaths.forbidden,
        builder: (context, state) => const ForbiddenScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.forceChangePassword,
        builder: (context, state) => const ForceChangePasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const AdaptiveShellScreen(),
      ),
      GoRoute(
        path: RoutePaths.tasks,
        builder: (context, state) => const TasksScreen(isRootNavigation: false),
      ),
      GoRoute(
        path: RoutePaths.taskDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return TaskDetailScreen(taskId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.leaves,
        builder: (context, state) => const LeavesScreen(),
      ),
      GoRoute(
        path: RoutePaths.leaveDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return LeaveDetailScreen(leaveId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.holidays,
        builder: (context, state) =>
            const LeavesScreen(initialTab: LeavesInitialTab.holidays),
      ),
      if (kDebugMode)
        GoRoute(
          path: RoutePaths.devGallery,
          builder: (context, state) => const DevGalleryScreen(),
        ),
    ],
  );
}
