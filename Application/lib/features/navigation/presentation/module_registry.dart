import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/admin/presentation/employee_list_screen.dart';
import 'package:right_ads/features/admin_attendance/presentation/admin_attendance_dashboard_screen.dart';
import 'package:right_ads/features/admin_operations/presentation/admin_operations_hub_screen.dart';
import 'package:right_ads/features/attendance/presentation/attendance_screen.dart';
import 'package:right_ads/features/communication/presentation/announcements_screen.dart';
import 'package:right_ads/features/communication/presentation/notifications_screen.dart';
import 'package:right_ads/features/dynamic_modules/presentation/dynamic_module_screen.dart';
import 'package:right_ads/features/leaves/presentation/leaves_screen.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:right_ads/features/navigation/presentation/module_icon_mapper.dart';
import 'package:right_ads/features/profile/presentation/profile_screen.dart';
import 'package:right_ads/features/super_admin/presentation/super_admin_console_hub_screen.dart';
import 'package:right_ads/features/tasks/presentation/tasks_screen.dart';
import 'package:right_ads/features/work_reports/presentation/work_reports_screen.dart';

typedef ModuleWidgetBuilder =
    Widget Function(
      BuildContext context,
      AppModuleItem module,
    );

class ModuleRegistryEntry {
  const ModuleRegistryEntry({
    required this.routeKey,
    required this.isSupported,
    required this.builder,
  });

  final String routeKey;
  final bool isSupported;
  final ModuleWidgetBuilder builder;
}

/// Registry mapping server-sent `route_key` strings to feature builders.
///
/// Unknown `route_key` values resolve to [UnknownModuleView] ("Update the app
/// to use this module"), never throwing or crashing.
abstract final class ModuleRegistry {
  static final Map<String, ModuleWidgetBuilder> _registeredBuilders =
      <String, ModuleWidgetBuilder>{
        'attendance': (context, module) => const AttendanceScreen(),
        'tasks': (context, module) => const TasksScreen(),
        'leave': (context, module) => const LeavesScreen(),
        'leaves': (context, module) => const LeavesScreen(),
        'holidays': (context, module) =>
            const LeavesScreen(initialTab: LeavesInitialTab.holidays),
        'work_reports': (context, module) => const WorkReportsScreen(),
        'announcements': (context, module) =>
            const AnnouncementsScreen(isRootNavigation: true),
        'notifications': (context, module) => const NotificationsScreen(),
        'profile': (context, module) => const ProfileScreen(),
        'admin_employees': (context, module) => const EmployeeListScreen(),
        'admin_attendance': (context, module) =>
            const AdminAttendanceDashboardScreen(),
        'admin_operations': (context, module) =>
            const AdminOperationsHubScreen(),
        'super_admin': (context, module) =>
            const SuperAdminConsoleHubScreen(),
      };

  static bool isKnownRouteKey(String routeKey) {
    final normalized = routeKey.trim().toLowerCase();
    return _registeredBuilders.containsKey(normalized);
  }

  static ModuleRegistryEntry resolve(String routeKey, {bool isBase = true}) {
    final normalized = routeKey.trim().toLowerCase();
    final builder = _registeredBuilders[normalized];
    if (builder != null) {
      return ModuleRegistryEntry(
        routeKey: normalized,
        isSupported: true,
        builder: builder,
      );
    }
    if (normalized.startsWith('dynamic_') ||
        normalized.startsWith('custom_') ||
        normalized == 'leads' ||
        normalized == 'tickets' ||
        normalized == 'invoices' ||
        (!isBase && !normalized.contains('_route_v'))) {
      return ModuleRegistryEntry(
        routeKey: normalized,
        isSupported: true,
        builder: (context, module) => DynamicModuleScreen(
          moduleCode: module.code,
          initialLabel: module.label,
        ),
      );
    }
    return ModuleRegistryEntry(
      routeKey: normalized,
      isSupported: false,
      builder: (context, module) => UnknownModuleView(module: module),
    );
  }
}

class BaseModulePlaceholderView extends StatelessWidget {
  const BaseModulePlaceholderView({
    required this.module,
    super.key,
  });

  final AppModuleItem module;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
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
                children: <Widget>[
                  Icon(
                    ModuleIconMapper.resolveSelectedIcon(module.iconKey),
                    size: AppSpacing.xxl,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    module.label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    module.description ??
                        l10n.navModuleReadyPlaceholder(module.label),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UnknownModuleView extends StatelessWidget {
  const UnknownModuleView({
    required this.module,
    super.key,
  });

  final AppModuleItem module;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
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
                children: <Widget>[
                  Icon(
                    Icons.system_update_outlined,
                    size: AppSpacing.xxl,
                    color: colorScheme.tertiary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    module.label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.navUnknownModuleMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
