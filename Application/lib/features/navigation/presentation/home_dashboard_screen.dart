import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:right_ads/features/navigation/presentation/module_icon_mapper.dart';
import 'package:right_ads/features/navigation/presentation/module_registry.dart';

class HomeDashboardView extends ConsumerWidget {
  const HomeDashboardView({
    required this.onSelectModule,
    super.key,
  });

  final ValueChanged<AppModuleItem> onSelectModule;

  Future<void> _confirmLogoutAll(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.authLogoutAllConfirmTitle,
      message: l10n.authLogoutAllConfirmMessage,
      confirmLabel: l10n.authLogoutAllButton,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final failure = await ref
        .read(sessionControllerProvider.notifier)
        .logoutAll();
    if (!context.mounted) return;
    if (failure != null) {
      AppSnackbar.showError(
        context,
        failure.message ?? l10n.errorStateDefaultMessage,
      );
    } else {
      AppSnackbar.showSuccess(context, l10n.authLogoutAllSuccess);
    }
  }

  void _openQuickModule(List<AppModuleItem> modules, String routeKey) {
    for (final mod in modules) {
      if (mod.routeKey.trim().toLowerCase() == routeKey) {
        onSelectModule(mod);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final config = ref.watch(appConfigProvider);
    final authState = ref.watch(sessionControllerProvider);
    final navState = ref.watch(navigationControllerProvider);
    final navData = navState.data;
    final modules = navData.modules;

    final userFullName = authState is AuthAuthenticated
        ? authState.user.fullName
        : '';
    final employeeCode = authState is AuthAuthenticated
        ? authState.user.employeeCode
        : '';
    final displayRoleLabel = navData.roleLabel.isNotEmpty
        ? navData.roleLabel
        : (authState is AuthAuthenticated ? authState.user.roleLabel : '');

    final homeBaseModules = modules
        .where((m) => m.isBase && m.showOnHome)
        .toList();
    final extraModules = modules
        .where((m) => !m.isBase || !ModuleRegistry.isKnownRouteKey(m.routeKey))
        .toList();

    return RefreshIndicator(
      onRefresh: () => ref
          .read(navigationControllerProvider.notifier)
          .refreshNavigation(force: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxWideContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // User Greeting & Role/Department Header Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AvatarWithInitials(
                              name: userFullName.isNotEmpty
                                  ? userFullName
                                  : l10n.appTitle,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    l10n.homePlaceholderTitle,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (userFullName.isNotEmpty) ...<Widget>[
                                    const SizedBox(height: AppSpacing.xxs),
                                    Text(
                                      l10n.authSignedInAs(
                                        userFullName,
                                        employeeCode,
                                      ),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.xs,
                          runSpacing: AppSpacing.xs,
                          children: <Widget>[
                            if (displayRoleLabel.isNotEmpty)
                              Chip(
                                visualDensity: VisualDensity.compact,
                                label: Text(displayRoleLabel),
                              ),
                            if (navData.departmentName != null &&
                                navData.departmentName!.isNotEmpty)
                              Chip(
                                visualDensity: VisualDensity.compact,
                                label: Text(navData.departmentName!),
                              ),
                            Chip(
                              visualDensity: VisualDensity.compact,
                              label: Text(
                                l10n.environmentLabel(
                                  config.environment.value.toUpperCase(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.apiEndpointLabel(config.apiBaseUrl),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Quick Summary Cards Section
                Text(
                  l10n.homeQuickOverviewSection,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide =
                        constraints.maxWidth >= AppBreakpoints.compactMaxWidth;
                    final cardWidth = isWide
                        ? (constraints.maxWidth - AppSpacing.md) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: <Widget>[
                        SizedBox(
                          width: cardWidth,
                          child: _QuickSummaryCard(
                            icon: Icons.access_time_filled,
                            title: l10n.homeCardAttendanceTitle,
                            subtitle: l10n.homeCardAttendanceSubtitle,
                            onTap: () =>
                                _openQuickModule(modules, 'attendance'),
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: _QuickSummaryCard(
                            icon: Icons.task_alt,
                            title: l10n.homeCardTasksTitle,
                            subtitle: l10n.homeCardTasksSubtitle,
                            onTap: () => _openQuickModule(modules, 'tasks'),
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: _QuickSummaryCard(
                            icon: Icons.event_note,
                            title: l10n.homeCardLeaveTitle,
                            subtitle: l10n.homeCardLeaveSubtitle,
                            onTap: () => _openQuickModule(modules, 'leave'),
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: _QuickSummaryCard(
                            icon: Icons.campaign,
                            title: l10n.homeCardAnnouncementsTitle,
                            subtitle: l10n.homeCardAnnouncementsSubtitle,
                            onTap: () =>
                                _openQuickModule(modules, 'announcements'),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                if (homeBaseModules.isNotEmpty) ...<Widget>[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.homeModulesSection,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _ModuleGrid(
                    modules: homeBaseModules,
                    onSelectModule: onSelectModule,
                  ),
                ],

                if (extraModules.isNotEmpty) ...<Widget>[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.homeExtraModulesSection,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _ModuleGrid(
                    modules: extraModules,
                    onSelectModule: onSelectModule,
                  ),
                ],

                const SizedBox(height: AppSpacing.xl),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: <Widget>[
                    AppButton(
                      label: l10n.authLogoutButton,
                      icon: Icons.logout,
                      variant: AppButtonVariant.secondary,
                      onPressed: () =>
                          ref.read(sessionControllerProvider.notifier).logout(),
                    ),
                    AppButton(
                      label: l10n.authLogoutAllButton,
                      icon: Icons.devices_other_outlined,
                      variant: AppButtonVariant.destructive,
                      onPressed: () => _confirmLogoutAll(context, ref),
                    ),
                    if (kDebugMode)
                      AppButton(
                        label: l10n.openDevGalleryButton,
                        icon: Icons.widgets_outlined,
                        variant: AppButtonVariant.tonal,
                        onPressed: () => context.push(RoutePaths.devGallery),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickSummaryCard extends StatelessWidget {
  const _QuickSummaryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  icon,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleGrid extends StatelessWidget {
  const _ModuleGrid({
    required this.modules,
    required this.onSelectModule,
  });

  final List<AppModuleItem> modules;
  final ValueChanged<AppModuleItem> onSelectModule;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= AppBreakpoints.compactMaxWidth;
        final tileWidth = isWide
            ? (constraints.maxWidth - AppSpacing.md) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: modules
              .map(
                (mod) => SizedBox(
                  width: tileWidth,
                  child: ModuleTileCard(
                    module: mod,
                    onTap: () => onSelectModule(mod),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class ModuleTileCard extends StatelessWidget {
  const ModuleTileCard({
    required this.module,
    required this.onTap,
    super.key,
  });

  final AppModuleItem module;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final entry = ModuleRegistry.resolve(module.routeKey);
    final isSupported = entry.isSupported;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              Icon(
                isSupported
                    ? ModuleIconMapper.resolveIcon(module.iconKey)
                    : Icons.system_update_outlined,
                color: isSupported ? colorScheme.primary : colorScheme.tertiary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      module.label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      isSupported
                          ? (module.description ??
                                l10n.navModuleReadyPlaceholder(module.label))
                          : l10n.navUnknownModuleMessage,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isSupported
                            ? colorScheme.onSurfaceVariant
                            : colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSupported ? Icons.chevron_right : Icons.info_outline,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
