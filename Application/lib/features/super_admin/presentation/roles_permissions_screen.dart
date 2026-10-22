import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/features/super_admin/application/super_admin_controllers.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';

class RolesPermissionsScreen extends ConsumerWidget {
  const RolesPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(superAdminRolesControllerProvider);
    final controller = ref.read(superAdminRolesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.superAdminRolesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadRolesAndPermissions,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _openRoleEditor(context, null, state.permissions, controller),
        child: const Icon(Icons.add),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.roles.length,
              itemBuilder: (context, index) {
                final role = state.roles[index];
                final primaryColor = Theme.of(context).colorScheme.primary;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: role.isSystem
                          ? primaryColor.withValues(alpha: 0.15)
                          : Colors.grey.withValues(alpha: 0.15),
                      child: Icon(
                        role.isSystem
                            ? Icons.verified_user
                            : Icons.person_outline,
                        color: role.isSystem ? primaryColor : Colors.grey,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          role.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (role.isSystem ? primaryColor : Colors.grey)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            role.isSystem
                                ? l10n.superAdminSystemRole
                                : l10n.superAdminCustomRole,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: role.isSystem ? primaryColor : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '${role.description ?? ''}\n${l10n.superAdminUsersCount(role.userCount)}',
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.superAdminPermissionsMatrix,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: role.permissions.map((p) {
                                return Chip(
                                  label: Text(
                                    p.code,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                );
                              }).toList(),
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: const Icon(Icons.edit, size: 16),
                                  label: Text(l10n.superAdminEditRole),
                                  onPressed: () => _openRoleEditor(
                                    context,
                                    role,
                                    state.permissions,
                                    controller,
                                  ),
                                ),
                                if (!role.isSystem) ...[
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      l10n.superAdminDeleteRole,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      final ok = await ConfirmDialog.show(
                                        context,
                                        title: l10n.superAdminDeleteRole,
                                        message: role.name,
                                        confirmLabel: l10n.superAdminDeleteRole,
                                        isDestructive: true,
                                      );
                                      if (ok) {
                                        await controller.deleteRole(role.id);
                                      }
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _openRoleEditor(
    BuildContext context,
    RoleDetailModel? role,
    List<PermissionModel> allPermissions,
    SuperAdminRolesController controller,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _RoleEditorDialog(
        initialRole: role,
        allPermissions: allPermissions,
        onSave: (name, description, permissionIds) async {
          final success = await controller.saveRole(
            roleId: role?.id,
            name: name,
            description: description,
            permissionIds: permissionIds,
          );
          if (success && context.mounted) {
            Navigator.pop(ctx);
          }
        },
      ),
    );
  }
}

class _RoleEditorDialog extends StatefulWidget {
  const _RoleEditorDialog({
    this.initialRole,
    required this.allPermissions,
    required this.onSave,
  });

  final RoleDetailModel? initialRole;
  final List<PermissionModel> allPermissions;
  final Future<void> Function(
    String name,
    String? description,
    List<String> permissionIds,
  )
  onSave;

  @override
  State<_RoleEditorDialog> createState() => _RoleEditorDialogState();
}

class _RoleEditorDialogState extends State<_RoleEditorDialog> {
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late Set<String> _selectedPermissionIds;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialRole?.name ?? '');
    _descCtrl = TextEditingController(
      text: widget.initialRole?.description ?? '',
    );
    _selectedPermissionIds =
        widget.initialRole?.permissions.map((p) => p.id).toSet() ?? {};
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(
        widget.initialRole == null
            ? l10n.superAdminCreateRole
            : l10n.superAdminEditRole,
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: l10n.superAdminRoleName,
                controller: _nameCtrl,
                readOnly: widget.initialRole?.isSystem ?? false,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: l10n.superAdminRoleDescription,
                controller: _descCtrl,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.superAdminPermissionsMatrix,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.allPermissions.length,
                  itemBuilder: (ctx, idx) {
                    final perm = widget.allPermissions[idx];
                    final isChecked = _selectedPermissionIds.contains(perm.id);
                    return CheckboxListTile(
                      title: Text(
                        perm.code,
                        style: const TextStyle(fontSize: 13),
                      ),
                      subtitle: Text(
                        perm.description,
                        style: const TextStyle(fontSize: 11),
                      ),
                      value: isChecked,
                      dense: true,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _selectedPermissionIds.add(perm.id);
                          } else {
                            _selectedPermissionIds.remove(perm.id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.adminCancel),
        ),
        ElevatedButton(
          onPressed: _isSaving
              ? null
              : () async {
                  setState(() => _isSaving = true);
                  await widget.onSave(
                    _nameCtrl.text.trim(),
                    _descCtrl.text.trim().isEmpty
                        ? null
                        : _descCtrl.text.trim(),
                    _selectedPermissionIds.toList(),
                  );
                  if (mounted) setState(() => _isSaving = false);
                },
          child: Text(l10n.superAdminSaveRole),
        ),
      ],
    );
  }
}
