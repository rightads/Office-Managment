import 'dart:async';

import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/navigation/data/navigation_repository.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_controller.g.dart';

@Riverpod(keepAlive: true)
class NavigationController extends _$NavigationController {
  @override
  NavigationState build() {
    final repo = ref.watch(navigationRepositoryProvider);
    final cached = repo.readCachedNavigation();
    if (cached != null) {
      if (cached.permissions.isNotEmpty) {
        unawaited(
          Future<void>.microtask(() {
            ref
                .read(userPermissionsControllerProvider.notifier)
                .setPermissions(cached.permissions);
          }),
        );
      }
      return NavigationState(
        data: cached,
        isFromOfflineCache: true,
      );
    }
    return const NavigationState();
  }

  /// Replaces navigation data directly (useful for widget tests and immediate
  /// state transitions).
  void setNavigationData(
    UserNavigationData data, {
    DateTime? refreshedAt,
    bool isFromOfflineCache = false,
  }) {
    ref
        .read(userPermissionsControllerProvider.notifier)
        .setPermissions(data.permissions);
    state = NavigationState(
      data: data,
      lastRefreshedAt: refreshedAt ?? DateTime.now().toUtc(),
      isFromOfflineCache: isFromOfflineCache,
    );
  }

  /// Loads `/app/config` and `/me/navigation` concurrently after login or
  /// authenticated session bootstrap.
  Future<void> loadInitialNavigation({DateTime? now}) async {
    state = state.copyWith(isLoading: true, error: null);

    unawaited(
      ref.read(runtimeAppConfigControllerProvider.notifier).refreshFromServer(),
    );

    await refreshNavigation(force: true, now: now);
  }

  /// Fetches `/me/navigation` and updates both [NavigationState] and
  /// [UserPermissionsController].
  Future<void> refreshNavigation({
    bool force = false,
    DateTime? now,
  }) async {
    final effectiveNow = (now ?? DateTime.now()).toUtc();
    if (!force && state.lastRefreshedAt != null) {
      final intervalMinutes = ref
          .read(runtimeAppConfigControllerProvider)
          .navigationRefreshIntervalMinutes;
      final elapsedMinutes = effectiveNow
          .difference(state.lastRefreshedAt!)
          .inMinutes;
      if (elapsedMinutes < intervalMinutes) {
        return;
      }
    }

    state = state.copyWith(isLoading: true, error: null);
    final repo = ref.read(navigationRepositoryProvider);
    final (navData, failure, isFromCache) = await repo.fetchNavigation();

    if (navData != null) {
      ref
          .read(userPermissionsControllerProvider.notifier)
          .setPermissions(navData.permissions);
      state = NavigationState(
        data: navData,
        error: isFromCache ? null : failure,
        lastRefreshedAt: isFromCache ? state.lastRefreshedAt : effectiveNow,
        isFromOfflineCache: isFromCache,
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      error: failure,
    );
  }

  /// Called when the application returns to the foreground. Refetches
  /// `/me/navigation` if at least `N` minutes (`navigationRefreshIntervalMinutes`
  /// from `/app/config`) have elapsed since [NavigationState.lastRefreshedAt].
  Future<void> onAppResumed({DateTime? now}) async {
    await refreshNavigation(now: now);
  }

  Future<void> clear() async {
    await ref.read(navigationRepositoryProvider).clearCachedNavigation();
    state = const NavigationState();
  }
}
