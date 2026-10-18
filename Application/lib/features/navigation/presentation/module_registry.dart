import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/attendance/presentation/attendance_screen.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:right_ads/features/navigation/presentation/module_icon_mapper.dart';
import 'package:right_ads/features/profile/presentation/profile_screen.dart';

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
        'tasks': (context, module) => BaseModulePlaceholderView(module: module),
        'leave': (context, module) => BaseModulePlaceholderView(module: module),
        'work_reports': (context, module) =>
            BaseModulePlaceholderView(module: module),
        'announcements': (context, module) =>
            BaseModulePlaceholderView(module: module),
        'notifications': (context, module) =>
            BaseModulePlaceholderView(module: module),
        'profile': (context, module) => const ProfileScreen(),
      };

  static bool isKnownRouteKey(String routeKey) {
    final normalized = routeKey.trim().toLowerCase();
    return _registeredBuilders.containsKey(normalized);
  }

  static ModuleRegistryEntry resolve(String routeKey) {
    final normalized = routeKey.trim().toLowerCase();
    final builder = _registeredBuilders[normalized];
    if (builder != null) {
      return ModuleRegistryEntry(
        routeKey: normalized,
        isSupported: true,
        builder: builder,
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
