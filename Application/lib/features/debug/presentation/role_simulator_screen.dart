import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';

class RoleSimulatorPreset {
  const RoleSimulatorPreset({
    required this.name,
    required this.description,
    required this.permissions,
    required this.modules,
  });

  final String name;
  final String description;
  final List<String> permissions;
  final List<Map<String, dynamic>> modules;
}

/// Debug-only Role & Navigation Simulator allowing verification of role presets
/// and arbitrary /me/navigation JSON payloads.
class RoleSimulatorScreen extends ConsumerStatefulWidget {
  const RoleSimulatorScreen({super.key});

  @override
  ConsumerState<RoleSimulatorScreen> createState() =>
      _RoleSimulatorScreenState();
}

class _RoleSimulatorScreenState extends ConsumerState<RoleSimulatorScreen> {
  final TextEditingController _jsonController = TextEditingController();
  int? _selectedPresetIndex;

  static final List<RoleSimulatorPreset> presets = [
    RoleSimulatorPreset(
      name: 'Tele Sales',
      description:
          'Leads & Call Log, Follow-ups, Targets with Phone/WhatsApp actions',
      permissions: [
        PermissionCodes.attendanceCheckIn,
        PermissionCodes.attendanceViewOwn,
        PermissionCodes.taskViewAssigned,
        PermissionCodes.taskUpdate,
        PermissionCodes.leaveApply,
        PermissionCodes.leaveViewOwn,
        PermissionCodes.announcementView,
        PermissionCodes.workReportsSubmitOwn,
        'leads.view_own',
        'leads.create',
        'leads.edit_own',
      ],
      modules: [
        {
          'code': 'attendance',
          'label': 'Attendance',
          'icon_key': 'attendance',
          'route_key': 'attendance',
          'is_base': true,
          'sort_order': 10,
          'required_permission': PermissionCodes.attendanceViewOwn,
        },
        {
          'code': 'tasks',
          'label': 'Tasks',
          'icon_key': 'tasks',
          'route_key': 'tasks',
          'is_base': true,
          'sort_order': 20,
          'required_permission': PermissionCodes.taskViewAssigned,
        },
        {
          'code': 'leads',
          'label': 'Leads & Pipeline',
          'icon_key': 'leads',
          'route_key': 'leads',
          'is_base': false,
          'sort_order': 25,
          'required_permission': 'leads.view_own',
        },
        {
          'code': 'work_reports',
          'label': 'Daily Work Report',
          'icon_key': 'work_reports',
          'route_key': 'work_reports',
          'is_base': true,
          'sort_order': 30,
          'required_permission': PermissionCodes.workReportsSubmitOwn,
        },
      ],
    ),
    RoleSimulatorPreset(
      name: 'Accounts',
      description:
          'Invoices, Payments, Expenses/Reimbursements, and Currency Totals',
      permissions: [
        PermissionCodes.attendanceCheckIn,
        PermissionCodes.attendanceViewOwn,
        PermissionCodes.taskViewAssigned,
        PermissionCodes.leaveApply,
        PermissionCodes.leaveViewOwn,
        PermissionCodes.announcementView,
        PermissionCodes.workReportsSubmitOwn,
        'invoices.view_all',
        'invoices.create',
        'invoices.edit_all',
      ],
      modules: [
        {
          'code': 'attendance',
          'label': 'Attendance',
          'icon_key': 'attendance',
          'route_key': 'attendance',
          'is_base': true,
          'sort_order': 10,
          'required_permission': PermissionCodes.attendanceViewOwn,
        },
        {
          'code': 'invoices',
          'label': 'Invoices & Billing',
          'icon_key': 'receipt',
          'route_key': 'invoices',
          'is_base': false,
          'sort_order': 22,
          'required_permission': 'invoices.view_all',
        },
        {
          'code': 'work_reports',
          'label': 'Daily Work Report',
          'icon_key': 'work_reports',
          'route_key': 'work_reports',
          'is_base': true,
          'sort_order': 30,
          'required_permission': PermissionCodes.workReportsSubmitOwn,
        },
      ],
    ),
    RoleSimulatorPreset(
      name: 'CSD (Customer Service)',
      description: 'Customer Tickets, Complaints, Feedback',
      permissions: [
        PermissionCodes.attendanceCheckIn,
        PermissionCodes.attendanceViewOwn,
        PermissionCodes.taskViewAssigned,
        PermissionCodes.leaveApply,
        PermissionCodes.leaveViewOwn,
        PermissionCodes.announcementView,
        PermissionCodes.workReportsSubmitOwn,
        'tickets.view_all',
        'tickets.create',
        'tickets.update',
      ],
      modules: [
        {
          'code': 'attendance',
          'label': 'Attendance',
          'icon_key': 'attendance',
          'route_key': 'attendance',
          'is_base': true,
          'sort_order': 10,
          'required_permission': PermissionCodes.attendanceViewOwn,
        },
        {
          'code': 'tickets',
          'label': 'Support Tickets',
          'icon_key': 'chat',
          'route_key': 'tickets',
          'is_base': false,
          'sort_order': 22,
          'required_permission': 'tickets.view_all',
        },
      ],
    ),
    RoleSimulatorPreset(
      name: 'Admin',
      description: 'System Administrative Oversight and Operations',
      permissions: [
        PermissionCodes.userRead,
        PermissionCodes.userCreate,
        PermissionCodes.attendanceViewAll,
        PermissionCodes.leaveViewAll,
        PermissionCodes.taskViewAll,
        PermissionCodes.announcementCreate,
        PermissionCodes.workReportsViewAll,
        PermissionCodes.workReportsReview,
      ],
      modules: [
        {
          'code': 'attendance',
          'label': 'Attendance',
          'icon_key': 'attendance',
          'route_key': 'attendance',
          'is_base': true,
          'sort_order': 10,
        },
        {
          'code': 'tasks',
          'label': 'Tasks',
          'icon_key': 'tasks',
          'route_key': 'tasks',
          'is_base': true,
          'sort_order': 20,
        },
        {
          'code': 'leave',
          'label': 'Leave',
          'icon_key': 'leave',
          'route_key': 'leave',
          'is_base': true,
          'sort_order': 30,
        },
        {
          'code': 'work_reports',
          'label': 'Daily Work Report',
          'icon_key': 'work_reports',
          'route_key': 'work_reports',
          'is_base': true,
          'sort_order': 40,
        },
      ],
    ),
  ];

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  void _applyPreset(int index) {
    setState(() => _selectedPresetIndex = index);
    final preset = presets[index];
    final payload = {
      'modules': preset.modules,
      'permissions': preset.permissions,
    };
    _jsonController.text = const JsonEncoder.withIndent('  ').convert(payload);
  }

  void _applyNavigation() {
    final l10n = context.l10n;
    try {
      final jsonMap =
          jsonDecode(_jsonController.text.trim()) as Map<String, dynamic>;
      final rawModules = jsonMap['modules'] as List<dynamic>? ?? [];
      final permissions =
          (jsonMap['permissions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          <String>[];

      final items = rawModules.map((m) {
        final map = m as Map<String, dynamic>;
        return AppModuleItem(
          id: map['id']?.toString() ?? map['code'].toString(),
          code: map['code'].toString(),
          label: map['label'].toString(),
          iconKey: map['icon_key']?.toString() ?? 'dashboard',
          routeKey: map['route_key']?.toString() ?? map['code'].toString(),
          sortOrder: (map['sort_order'] as num?)?.toInt() ?? 0,
          requiredPermission: map['required_permission']?.toString(),
          isBase: map['is_base'] as bool? ?? false,
          isActive: map['is_active'] as bool? ?? true,
          showOnHome: map['show_on_home'] as bool? ?? true,
          description: map['description']?.toString(),
        );
      }).toList();

      final navData = UserNavigationData(
        modules: items,
        permissions: permissions,
      );

      ref
          .read(navigationControllerProvider.notifier)
          .setNavigationData(navData);

      AppSnackbar.showSuccess(context, l10n.roleSimulatorSuccess);
      context.go(RoutePaths.home);
    } catch (_) {
      AppSnackbar.showError(context, l10n.roleSimulatorInvalidJson);
    }
  }

  void _resetNavigation() {
    final l10n = context.l10n;
    ref
        .read(navigationControllerProvider.notifier)
        .refreshNavigation(force: true);
    AppSnackbar.showSuccess(context, l10n.roleSimulatorSuccess);
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.roleSimulatorTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.roleSimulatorDescription,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.roleSimulatorPresetsLabel,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(presets.length, (idx) {
                final isSelected = _selectedPresetIndex == idx;
                return ChoiceChip(
                  label: Text(presets[idx].name),
                  selected: isSelected,
                  onSelected: (_) => _applyPreset(idx),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.roleSimulatorPasteJsonLabel,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _jsonController,
              maxLines: 12,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '{\n  "modules": [...],\n  "permissions": [...]\n}',
              ),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: l10n.roleSimulatorApplyButton,
              icon: Icons.play_arrow,
              onPressed: _applyNavigation,
            ),
            const SizedBox(height: 8),
            AppButton(
              label: l10n.roleSimulatorResetButton,
              variant: AppButtonVariant.secondary,
              icon: Icons.restore,
              onPressed: _resetNavigation,
            ),
          ],
        ),
      ),
    );
  }
}
