import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import '../../../core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';

class MasterDataHubItem {
  const MasterDataHubItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
    required this.permission,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String path;
  final String permission;
}

class MasterDataHubScreen extends ConsumerWidget {
  const MasterDataHubScreen({super.key});

  static const List<MasterDataHubItem> catalogs = [
    MasterDataHubItem(
      title: 'Departments',
      subtitle: 'Manage agency organizational departments',
      icon: Icons.business,
      path: '/departments',
      permission: PermissionCodes.userRead,
    ),
    MasterDataHubItem(
      title: 'Clients',
      subtitle: 'Manage client companies and key contacts',
      icon: Icons.people_outline,
      path: '/clients',
      permission: PermissionCodes.clientViewAll,
    ),
    MasterDataHubItem(
      title: 'Projects',
      subtitle: 'Client engagements, start and end schedules',
      icon: Icons.work_outline,
      path: '/projects',
      permission: PermissionCodes.projectViewAll,
    ),
    MasterDataHubItem(
      title: 'Office Locations',
      subtitle: 'Geofenced physical offices & allowable check-in radii',
      icon: Icons.pin_drop,
      path: '/office-locations',
      permission: PermissionCodes.attendanceManagePolicy,
    ),
    MasterDataHubItem(
      title: 'Attendance Policies',
      subtitle: 'Shifts, grace periods, geofence & selfie requirements',
      icon: Icons.timer,
      path: '/attendance-policies',
      permission: PermissionCodes.attendanceManagePolicy,
    ),
    MasterDataHubItem(
      title: 'Attendance Statuses',
      subtitle: 'System attendance statuses and color indicators',
      icon: Icons.fact_check,
      path: '/attendance-statuses',
      permission: PermissionCodes.attendanceManagePolicy,
    ),
    MasterDataHubItem(
      title: 'Leave Types',
      subtitle: 'Paid/unpaid quotas and carry-forward allocations',
      icon: Icons.flight_takeoff,
      path: '/leave-types',
      permission: PermissionCodes.leaveManageTypes,
    ),
    MasterDataHubItem(
      title: 'Holidays',
      subtitle: 'Annual public and optional organizational holidays',
      icon: Icons.celebration,
      path: '/holidays',
      permission: PermissionCodes.attendanceManagePolicy,
    ),
    MasterDataHubItem(
      title: 'Task Statuses',
      subtitle: 'Kanban columns, terminal flags and stage colors',
      icon: Icons.checklist,
      path: '/task-statuses',
      permission: PermissionCodes.taskViewAll,
    ),
    MasterDataHubItem(
      title: 'Task Priorities',
      subtitle: 'Priority tiers, SLA weights and badge colors',
      icon: Icons.flag,
      path: '/task-priorities',
      permission: PermissionCodes.taskViewAll,
    ),
    MasterDataHubItem(
      title: 'Task Status Transitions',
      subtitle: 'Allowed state flow transitions and role guards',
      icon: Icons.alt_route,
      path: '/task-status-transitions',
      permission: PermissionCodes.taskViewAll,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    // Filter catalogs based on current user permissions
    final accessible = catalogs.where((c) => ref.can(c.permission)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminMasterDataTitle),
      ),
      body: accessible.isEmpty
          ? Center(child: Text(l10n.adminNoItemsFound))
          : isDesktop
          ? GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: accessible.length,
              itemBuilder: (context, idx) {
                final item = accessible[idx];
                return _buildCard(context, item);
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: accessible.length,
              itemBuilder: (context, idx) {
                final item = accessible[idx];
                return _buildCard(context, item);
              },
            ),
    );
  }

  Widget _buildCard(BuildContext context, MasterDataHubItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(item.icon),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push(
            RoutePaths.adminMasterDataCrud,
            extra: {
              'title': item.title,
              'basePath': item.path,
            },
          );
        },
      ),
    );
  }
}
