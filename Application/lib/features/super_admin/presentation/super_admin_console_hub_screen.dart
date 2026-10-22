import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';

class SuperAdminConsoleHubScreen extends ConsumerWidget {
  const SuperAdminConsoleHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final permissions = ref.watch(userPermissionsControllerProvider);

    final canManageRoles = permissions.can(PermissionCodes.userManageRoles);
    final canManageModules = permissions.can(PermissionCodes.modulesManage);
    final canManageSettings = permissions.can(
      PermissionCodes.systemManageSettings,
    );
    final canViewAudit = permissions.can(PermissionCodes.systemViewAuditLogs);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.superAdminTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (canManageRoles)
            _buildAdminTile(
              context: context,
              title: l10n.superAdminRolesTitle,
              subtitle: l10n.superAdminRolesSubtitle,
              icon: Icons.admin_panel_settings_outlined,
              color: Colors.indigo,
              onTap: () => context.push(RoutePaths.superAdminRoles),
            ),
          if (canManageModules) ...[
            _buildAdminTile(
              context: context,
              title: l10n.superAdminModulesTitle,
              subtitle: l10n.superAdminModulesSubtitle,
              icon: Icons.view_quilt_outlined,
              color: Colors.deepPurple,
              onTap: () => context.push(RoutePaths.superAdminModuleBuilder),
            ),
          ],
          if (canManageSettings) ...[
            _buildAdminTile(
              context: context,
              title: l10n.superAdminSettingsTitle,
              subtitle: l10n.superAdminSettingsSubtitle,
              icon: Icons.tune_outlined,
              color: Colors.teal,
              onTap: () => context.push(RoutePaths.superAdminSettings),
            ),
            _buildAdminTile(
              context: context,
              title: l10n.superAdminTemplatesTitle,
              subtitle: l10n.superAdminTemplatesSubtitle,
              icon: Icons.mark_email_unread_outlined,
              color: Colors.blueGrey,
              onTap: () => context.push(RoutePaths.superAdminTemplates),
            ),
          ],
          if (canViewAudit)
            _buildAdminTile(
              context: context,
              title: l10n.superAdminAuditTitle,
              subtitle: l10n.superAdminAuditSubtitle,
              icon: Icons.history_edu_outlined,
              color: Colors.brown,
              onTap: () => context.push(RoutePaths.superAdminAudit),
            ),
        ],
      ),
    );
  }

  Widget _buildAdminTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
