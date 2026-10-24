import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/core/widgets/status_chip.dart';
import 'package:right_ads/features/attendance/application/attendance_controller.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/communication/application/announcements_controller.dart';
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
    final todayAttendance = ref.watch(todayAttendanceControllerProvider);
    final todayRecord = todayAttendance.todayRecord;
    final hasNewAnnounce = ref.watch(hasNewAnnouncementsProvider);
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
    final permissions = ref.watch(userPermissionsControllerProvider);
    final hasAdminPermissions = permissions.can(PermissionCodes.userRead) ||
        permissions.can(PermissionCodes.attendanceViewAll) ||
        displayRoleLabel.toLowerCase().contains('admin');

    final homeBaseModules = modules
        .where((m) => m.isBase && m.showOnHome)
        .toList();
    final extraModules = modules
        .where((m) => !m.isBase || !ModuleRegistry.isKnownRouteKey(m.routeKey))
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait<void>([
          ref
              .read(navigationControllerProvider.notifier)
              .refreshNavigation(force: true),
          ref
              .read(todayAttendanceControllerProvider.notifier)
              .loadTodayAndPolicy(silent: true),
        ]);
      },
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: Row(
                    children: <Widget>[
                      _QuickSummaryCard(
                        icon: Icons.access_time_filled,
                        title: l10n.homeCardAttendanceTitle,
                        subtitle: l10n.homeCardAttendanceSubtitle,
                        badge: todayRecord != null
                            ? StatusChip(
                                label: todayRecord.statusLabel,
                                hexColor: todayRecord.statusColor,
                              )
                            : null,
                        onTap: () => _openQuickModule(modules, 'attendance'),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _QuickSummaryCard(
                        icon: Icons.task_alt,
                        title: l10n.homeCardTasksTitle,
                        subtitle: l10n.homeCardTasksSubtitle,
                        onTap: () => _openQuickModule(modules, 'tasks'),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _QuickSummaryCard(
                        icon: Icons.event_note,
                        title: l10n.homeCardLeaveTitle,
                        subtitle: l10n.homeCardLeaveSubtitle,
                        onTap: () => _openQuickModule(modules, 'leave'),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _QuickSummaryCard(
                        icon: Icons.campaign,
                        title: l10n.homeCardAnnouncementsTitle,
                        subtitle: l10n.homeCardAnnouncementsSubtitle,
                        badge: hasNewAnnounce
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xs,
                                  vertical: AppSpacing.xxs,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.error,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.pill),
                                ),
                                child: Text(
                                  l10n.announcementsNewBadge,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onError,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              )
                            : null,
                        onTap: () =>
                            _openQuickModule(modules, 'announcements'),
                      ),
                    ],
                  ),
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

                if (hasAdminPermissions) ...<Widget>[
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.admin_panel_settings,
                        color: colorScheme.primary,
                        size: AppSpacing.iconMd,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Admin Management Hub',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    child: Row(
                      children: <Widget>[
                        _AdminActionCard(
                          label: 'Employees',
                          icon: Icons.people_outline,
                          onPressed: () =>
                              context.push(RoutePaths.adminEmployees),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _AdminActionCard(
                          label: 'Attendance & Matrix',
                          icon: Icons.table_chart_outlined,
                          onPressed: () =>
                              context.push(RoutePaths.adminAttendanceDashboard),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _AdminActionCard(
                          label: 'Operations Hub',
                          icon: Icons.fact_check_outlined,
                          onPressed: () =>
                              context.push(RoutePaths.adminOperationsHub),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _AdminActionCard(
                          label: 'Super Admin',
                          icon: Icons.shield_outlined,
                          onPressed: () =>
                              context.push(RoutePaths.superAdminHub),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _AdminActionCard(
                          label: 'Role Simulator',
                          icon: Icons.switch_account_outlined,
                          onPressed: () =>
                              context.push(RoutePaths.roleSimulator),
                        ),
                      ],
                    ),
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
    this.badge,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 140,
      height: 140,
      child: Card(
        elevation: AppElevation.low,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Icon(
                        icon,
                        size: AppSpacing.iconLg,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    if (badge != null)
                      Flexible(child: badge!)
                    else
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: AppSpacing.iconSm,
                        color:
                            colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Row(
        children: modules
            .map(
              (mod) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: ModuleTileCard(
                  module: mod,
                  onTap: () => onSelectModule(mod),
                ),
              ),
            )
            .toList(),
      ),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final entry = ModuleRegistry.resolve(
      module.routeKey,
      isBase: module.isBase,
    );
    final isSupported = entry.isSupported;

    return SizedBox(
      width: 120,
      height: 120,
      child: Card(
        elevation: AppElevation.low,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isSupported
                        ? colorScheme.secondaryContainer
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    isSupported
                        ? ModuleIconMapper.resolveIcon(module.iconKey)
                        : Icons.system_update_outlined,
                    size: AppSpacing.iconLg,
                    color: isSupported
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  module.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AdminActionCard extends StatelessWidget {
  const _AdminActionCard({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 120,
      height: 120,
      child: Card(
        elevation: AppElevation.low,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    icon,
                    size: AppSpacing.iconLg,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
