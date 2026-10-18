import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/widgets/dev_gallery_screen.dart';
import 'package:right_ads/core/widgets/placeholder_home_screen.dart';
import 'package:right_ads/core/widgets/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: RoutePaths.splash,
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
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
