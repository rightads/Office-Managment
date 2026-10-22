import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/features/admin/application/employee_detail_controller.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';

class EmployeeDetailScreen extends ConsumerWidget {
  const EmployeeDetailScreen({required this.employeeId, super.key});

  final String employeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(employeeDetailControllerProvider(employeeId));
    final controller = ref.read(
      employeeDetailControllerProvider(employeeId).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(state.employee?.fullName ?? l10n.adminEmployeesTitle),
        actions: [
          if (ref.can(PermissionCodes.userUpdate) && state.employee != null)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: l10n.adminEditEmployee,
              onPressed: () => context.push(
                RoutePaths.adminEmployeeEdit(employeeId),
                extra: state.employee,
              ),
            ),
        ],
      ),
      body: _buildBody(context, ref, state, controller, l10n),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    EmployeeDetailState state,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.error),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => controller.loadEmployee(employeeId),
                child: Text(l10n.adminClose),
              ),
            ],
          ),
        ),
      );
    }

    final emp = state.employee;
    if (emp == null) {
      return Center(child: Text(l10n.adminNoItemsFound));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileHeader(emp, l10n),
          const SizedBox(height: 16),
          _buildInfoCard(emp, l10n),
          const SizedBox(height: 20),
          _buildActionSection(context, ref, emp, controller, l10n),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(EmployeeItem emp, AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              child: Text(
                emp.fullName.isNotEmpty ? emp.fullName[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emp.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${emp.employeeCode} • ${emp.designation ?? '-'}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        emp.isActive ? Icons.check_circle : Icons.cancel,
                        color: emp.isActive
                            ? AppColors.success
                            : AppColors.error,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        emp.isActive
                            ? l10n.adminStatusActive
                            : l10n.adminStatusInactive,
                        style: TextStyle(
                          color: emp.isActive
                              ? AppColors.success
                              : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(EmployeeItem emp, AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailRow(l10n.adminEmail, emp.email),
            _buildDetailRow(l10n.adminPhone, emp.phoneNumber ?? '-'),
            _buildDetailRow(l10n.adminRole, emp.roleName ?? '-'),
            _buildDetailRow(l10n.adminDepartment, emp.departmentName ?? '-'),
            _buildDetailRow(l10n.adminManager, emp.managerName ?? '-'),
            _buildDetailRow(
              l10n.adminAttendancePolicy,
              emp.attendancePolicyName ?? '-',
            ),
            _buildDetailRow(l10n.adminJoiningDate, emp.joiningDate ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildActionSection(
    BuildContext context,
    WidgetRef ref,
    EmployeeItem emp,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (ref.can(PermissionCodes.userManageRoles)) ...[
          ElevatedButton.icon(
            icon: const Icon(Icons.admin_panel_settings),
            label: Text(l10n.adminChangeRole),
            onPressed: () =>
                _showRoleDialog(context, ref, emp, controller, l10n),
          ),
          const SizedBox(height: 8),
        ],
        if (ref.can(PermissionCodes.userUpdate)) ...[
          OutlinedButton.icon(
            icon: const Icon(Icons.lock_reset),
            label: Text(l10n.adminResetPassword),
            onPressed: () =>
                _showResetPasswordDialog(context, emp, controller, l10n),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.phonelink_erase),
            label: Text(l10n.adminResetDevice),
            onPressed: () => _resetDevice(context, emp, controller, l10n),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.schedule),
            label: Text(l10n.adminAssignPolicy),
            onPressed: () =>
                _showPolicyDialog(context, ref, emp, controller, l10n),
          ),
          const SizedBox(height: 8),
        ],
        if (ref.can(PermissionCodes.userDelete)) ...[
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: emp.isActive
                  ? AppColors.error
                  : AppColors.success,
            ),
            icon: Icon(emp.isActive ? Icons.block : Icons.check),
            label: Text(
              emp.isActive ? l10n.adminDeactivate : l10n.adminActivate,
            ),
            onPressed: () => _toggleActive(context, emp, controller, l10n),
          ),
        ],
      ],
    );
  }

  Future<void> _toggleActive(
    BuildContext context,
    EmployeeItem emp,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(emp.isActive ? l10n.adminDeactivate : l10n.adminActivate),
        content: Text(
          emp.isActive
              ? l10n.adminDeactivateConfirm
              : l10n.adminActivateConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.adminCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (emp.isActive) {
        await controller.deactivate(emp.id);
      } else {
        await controller.activate(emp.id);
      }
    }
  }

  Future<void> _resetDevice(
    BuildContext context,
    EmployeeItem emp,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) async {
    final success = await controller.resetDevice(emp.id);
    if (context.mounted && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminDeviceResetSuccess)),
      );
    }
  }

  Future<void> _showResetPasswordDialog(
    BuildContext context,
    EmployeeItem emp,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) async {
    final passCtrl = TextEditingController();
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminResetPassword),
        content: TextField(
          controller: passCtrl,
          decoration: InputDecoration(
            labelText: l10n.adminTemporaryPassword,
            hintText: l10n.adminLeaveEmptyAuto,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.adminCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminConfirm),
          ),
        ],
      ),
    );

    if (res == true) {
      final success = await controller.resetPassword(
        emp.id,
        newPassword: passCtrl.text.trim().isEmpty ? null : passCtrl.text.trim(),
      );
      if (context.mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminPasswordResetSuccess)),
        );
      }
    }
  }

  Future<void> _showRoleDialog(
    BuildContext context,
    WidgetRef ref,
    EmployeeItem emp,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) async {
    final repo = ref.read(adminRepositoryProvider);
    final roles = await repo.getRoles();
    if (!context.mounted) return;

    String? selectedRoleId = emp.roleId;
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.adminChangeRole),
          content: DropdownButton<String>(
            isExpanded: true,
            value: selectedRoleId,
            items: roles
                .map((r) => DropdownMenuItem(value: r.id, child: Text(r.name)))
                .toList(),
            onChanged: (val) => setState(() => selectedRoleId = val),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.adminCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.adminConfirm),
            ),
          ],
        ),
      ),
    );

    if (res == true && selectedRoleId != null) {
      await controller.assignRole(emp.id, selectedRoleId!);
    }
  }

  Future<void> _showPolicyDialog(
    BuildContext context,
    WidgetRef ref,
    EmployeeItem emp,
    EmployeeDetailController controller,
    AppLocalizations l10n,
  ) async {
    final repo = ref.read(adminRepositoryProvider);
    final policies = await repo.getMasterDataList('/attendance-policies');
    if (!context.mounted) return;

    var selectedPolicyId = emp.attendancePolicyId;
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.adminAssignPolicy),
          content: DropdownButton<String?>(
            isExpanded: true,
            value: selectedPolicyId,
            items: [
              DropdownMenuItem<String?>(
                child: Text(l10n.adminFilterAll),
              ),
              ...policies.map(
                (p) => DropdownMenuItem<String?>(
                  value: p.id,
                  child: Text(p.name ?? p.id),
                ),
              ),
            ],
            onChanged: (val) => setState(() => selectedPolicyId = val),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.adminCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.adminConfirm),
            ),
          ],
        ),
      ),
    );

    if (res == true) {
      await controller.assignPolicy(emp.id, selectedPolicyId);
    }
  }
}
