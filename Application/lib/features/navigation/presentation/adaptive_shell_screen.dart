import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/communication/application/notifications_controller.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:right_ads/features/navigation/presentation/forbidden_screen.dart';
import 'package:right_ads/features/navigation/presentation/home_dashboard_screen.dart';
import 'package:right_ads/features/navigation/presentation/module_icon_mapper.dart';
import 'package:right_ads/features/navigation/presentation/module_registry.dart';

class AdaptiveShellScreen extends ConsumerStatefulWidget {
  const AdaptiveShellScreen({super.key});

  @override
  ConsumerState<AdaptiveShellScreen> createState() =>
      _AdaptiveShellScreenState();
}

class _AdaptiveShellScreenState extends ConsumerState<AdaptiveShellScreen>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        ref
            .read(unreadNotificationCountControllerProvider.notifier)
            .loadCount(),
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(
        ref.read(navigationControllerProvider.notifier).onAppResumed(),
      );
      unawaited(
        ref
            .read(unreadNotificationCountControllerProvider.notifier)
            .loadCount(),
      );
    }
  }

  void _selectModule(AppModuleItem module, List<AppModuleItem> modules) {
    final idx = modules.indexWhere((m) => m.code == module.code);
    if (idx != -1) {
      setState(() {
        _selectedIndex = idx + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authState = ref.watch(sessionControllerProvider);
    final navState = ref.watch(navigationControllerProvider);
    final permissions = ref.watch(userPermissionsControllerProvider);
    final unreadCount = ref.watch(unreadNotificationCountControllerProvider);

    if (authState is AuthAuthenticated && authState.isBiometricLocked) {
      return AppScaffold(
        title: l10n.appTitle,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.maxContentWidth,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.fingerprint,
                          size: AppSpacing.xxl,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.authBiometricLockedTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.authBiometricLockedSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(
                          label: l10n.authBiometricUnlockButton,
                          icon: Icons.lock_open_outlined,
                          expanded: true,
                          onPressed: () => ref
                              .read(sessionControllerProvider.notifier)
                              .unlockWithBiometrics(
                                localizedReason: l10n.authBiometricReason,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          label: l10n.authLogoutButton,
                          icon: Icons.logout,
                          variant: AppButtonVariant.text,
                          expanded: true,
                          onPressed: () => ref
                              .read(sessionControllerProvider.notifier)
                              .logout(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final modules = navState.data.modules
        .where((m) => m.isActive)
        .toList(growable: false);

    final destinations = <AppNavDestination>[
      AppNavDestination(
        key: 'home',
        label: l10n.navHomeLabel,
        icon: ModuleIconMapper.resolveIcon('home'),
        selectedIcon: ModuleIconMapper.resolveSelectedIcon('home'),
      ),
      ...modules.map(
        (m) => AppNavDestination(
          key: m.code,
          label: m.label,
          icon: ModuleIconMapper.resolveIcon(m.iconKey),
          selectedIcon: ModuleIconMapper.resolveSelectedIcon(m.iconKey),
        ),
      ),
    ];

    final effectiveSelectedIndex = _selectedIndex.clamp(
      0,
      destinations.length - 1,
    );

    final currentTitle = effectiveSelectedIndex == 0
        ? l10n.appTitle
        : modules[effectiveSelectedIndex - 1].label;

    Widget bodyContent;
    if (effectiveSelectedIndex == 0) {
      bodyContent = HomeDashboardView(
        onSelectModule: (mod) => _selectModule(mod, modules),
      );
    } else if (navState.isLoading && modules.isEmpty) {
      bodyContent = const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: LoadingSkeletonList(itemCount: 4),
      );
    } else if (navState.error != null && modules.isEmpty) {
      bodyContent = ErrorState(
        message: navState.error!.message ?? l10n.errorStateDefaultMessage,
        onRetry: () => ref
            .read(navigationControllerProvider.notifier)
            .refreshNavigation(force: true),
      );
    } else {
      final selectedModule = modules[effectiveSelectedIndex - 1];
      final requiredPerm = selectedModule.requiredPermission;
      if (requiredPerm != null &&
          requiredPerm.isNotEmpty &&
          !permissions.can(requiredPerm)) {
        bodyContent = ForbiddenScreen(
          onBackHome: () => setState(() => _selectedIndex = 0),
        );
      } else {
        final entry = ModuleRegistry.resolve(selectedModule.routeKey);
        bodyContent = entry.builder(context, selectedModule);
      }
    }

    return AppScaffold(
      title: currentTitle,
      destinations: destinations,
      selectedIndex: effectiveSelectedIndex,
      onDestinationSelected: (idx) {
        setState(() {
          _selectedIndex = idx;
        });
      },
      actions: <Widget>[
        IconButton(
          icon: Badge.count(
            count: unreadCount,
            isLabelVisible: unreadCount > 0,
            child: const Icon(Icons.notifications_outlined),
          ),
          tooltip: l10n.notificationsTitle,
          onPressed: () => context.push(RoutePaths.notifications),
        ),
        AppButton(
          label: l10n.authLogoutButton,
          icon: Icons.logout,
          variant: AppButtonVariant.text,
          onPressed: () =>
              ref.read(sessionControllerProvider.notifier).logout(),
        ),
      ],
      body: SafeArea(child: bodyContent),
    );
  }
}
