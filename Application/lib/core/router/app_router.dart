import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/widgets/dev_gallery_screen.dart';
import 'package:right_ads/core/widgets/placeholder_home_screen.dart';
import 'package:right_ads/core/widgets/splash_screen.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/presentation/force_change_password_screen.dart';
import 'package:right_ads/features/auth/presentation/forgot_password_screen.dart';
import 'package:right_ads/features/auth/presentation/login_screen.dart';
import 'package:right_ads/features/auth/presentation/reset_password_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final authNotifier = ValueNotifier<AuthState>(
    ref.read(sessionControllerProvider),
  );
  ref
    ..listen<AuthState>(
      sessionControllerProvider,
      (_, next) => authNotifier.value = next,
    )
    ..onDispose(authNotifier.dispose);

  const unauthenticatedAllowedPaths = <String>{
    RoutePaths.login,
    RoutePaths.forgotPassword,
    RoutePaths.resetPassword,
  };

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final authState = authNotifier.value;

      if (kDebugMode && location == RoutePaths.devGallery) {
        return null;
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
        builder: (context, state) => const PlaceholderHomeScreen(),
      ),
      if (kDebugMode)
        GoRoute(
          path: RoutePaths.devGallery,
          builder: (context, state) => const DevGalleryScreen(),
        ),
    ],
  );
}
