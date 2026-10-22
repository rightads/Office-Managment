import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';

class EmployeeFormScreen extends ConsumerStatefulWidget {
  const EmployeeFormScreen({this.initialEmployee, super.key});

  final EmployeeItem? initialEmployee;

  @override
  ConsumerState<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends ConsumerState<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _designationCtrl;
  late TextEditingController _joiningDateCtrl;

  String? _selectedRoleId;
  String? _selectedDepartmentId;
  String? _selectedPolicyId;
  String? _selectedManagerId;

  List<RoleItem> _roles = [];
  List<MasterDataItem> _departments = [];
  List<MasterDataItem> _policies = [];
  List<EmployeeItem> _managers = [];

  bool _isLoading = false;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final emp = widget.initialEmployee;
    _fullNameCtrl = TextEditingController(text: emp?.fullName ?? '');
    _emailCtrl = TextEditingController(text: emp?.email ?? '');
    _phoneCtrl = TextEditingController(text: emp?.phoneNumber ?? '');
    _designationCtrl = TextEditingController(text: emp?.designation ?? '');
    _joiningDateCtrl = TextEditingController(text: emp?.joiningDate ?? '');

    _selectedRoleId = emp?.roleId;
    _selectedDepartmentId = emp?.departmentId;
    _selectedPolicyId = emp?.attendancePolicyId;
    _selectedManagerId = emp?.managerId;

    _loadCatalogs();
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _designationCtrl.dispose();
    _joiningDateCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadCatalogs() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(adminRepositoryProvider);
      final roles = await repo.getRoles();
      final departments = await repo.getMasterDataList('/departments');
      final policies = await repo.getMasterDataList('/attendance-policies');
      final managers = await repo.getEmployees(pageSize: 100);

      setState(() {
        _roles = roles;
        _departments = departments;
        _policies = policies;
        _managers = managers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final repo = ref.read(adminRepositoryProvider);

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      if (widget.initialEmployee != null) {
        // Edit mode
        final payload = EmployeeUpdatePayload(
          fullName: _fullNameCtrl.text.trim(),
          phoneNumber: _phoneCtrl.text.trim().isEmpty
              ? null
              : _phoneCtrl.text.trim(),
          designation: _designationCtrl.text.trim().isEmpty
              ? null
              : _designationCtrl.text.trim(),
          departmentId: _selectedDepartmentId,
          attendancePolicyId: _selectedPolicyId,
          managerId: _selectedManagerId,
          joiningDate: _joiningDateCtrl.text.trim().isEmpty
              ? null
              : _joiningDateCtrl.text.trim(),
        );

        await repo.updateEmployee(widget.initialEmployee!.id, payload);
        if (mounted) Navigator.pop(context, true);
      } else {
        // Create mode
        if (_selectedRoleId == null) {
          setState(() {
            _isSaving = false;
            _errorMessage = 'Role is required';
          });
          return;
        }

        final payload = EmployeeCreatePayload(
          email: _emailCtrl.text.trim(),
          fullName: _fullNameCtrl.text.trim(),
          roleId: _selectedRoleId!,
          departmentId: _selectedDepartmentId,
          attendancePolicyId: _selectedPolicyId,
          managerId: _selectedManagerId,
          phoneNumber: _phoneCtrl.text.trim().isEmpty
              ? null
              : _phoneCtrl.text.trim(),
          designation: _designationCtrl.text.trim().isEmpty
              ? null
              : _designationCtrl.text.trim(),
          joiningDate: _joiningDateCtrl.text.trim().isEmpty
              ? null
              : _joiningDateCtrl.text.trim(),
        );

        final created = await repo.createEmployee(payload);
        if (mounted) {
          await _showCreatedCredentialsDialog(created, l10n);
          if (mounted) Navigator.pop(context, true);
        }
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _showCreatedCredentialsDialog(
    EmployeeItem emp,
    AppLocalizations l10n,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminEmployeeCreatedTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.adminEmployeeCreatedMessage),
            const SizedBox(height: 12),
            Text(
              '${l10n.adminEmployeeCode}: ${emp.employeeCode}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '${l10n.adminEmail}: ${emp.email}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.adminMustChangePassword,
              style: const TextStyle(color: Colors.orange, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.copy),
            label: Text(l10n.adminCopy),
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                  text: 'Code: ${emp.employeeCode}\nEmail: ${emp.email}',
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.adminCopiedToClipboard)),
              );
            },
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.adminClose),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEdit = widget.initialEmployee != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? l10n.adminEditEmployee : l10n.adminCreateEmployee),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_errorMessage != null) ...[
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                    ],
                    TextFormField(
                      controller: _fullNameCtrl,
                      decoration: InputDecoration(
                        labelText: l10n.adminFullName,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    if (!isEdit) ...[
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: l10n.adminEmail,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (v) => (v == null || !v.contains('@'))
                            ? 'Valid email required'
                            : null,
                      ),
                      const SizedBox(height: 12),
                    ],
                    TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: l10n.adminPhone,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _designationCtrl,
                      decoration: InputDecoration(
                        labelText: l10n.adminDesignation,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (!isEdit) ...[
                      DropdownButtonFormField<String>(
                        initialValue: _selectedRoleId,
                        decoration: InputDecoration(
                          labelText: l10n.adminRole,
                          border: const OutlineInputBorder(),
                        ),
                        items: _roles
                            .map(
                              (r) => DropdownMenuItem(
                                value: r.id,
                                child: Text(r.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedRoleId = v),
                        validator: (v) => v == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                    ],
                    DropdownButtonFormField<String?>(
                      initialValue: _selectedDepartmentId,
                      decoration: InputDecoration(
                        labelText: l10n.adminDepartment,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String?>(
                          child: Text(l10n.adminNoneOption),
                        ),
                        ..._departments.map(
                          (d) => DropdownMenuItem<String?>(
                            value: d.id,
                            child: Text(d.name ?? d.id),
                          ),
                        ),
                      ],
                      onChanged: (v) =>
                          setState(() => _selectedDepartmentId = v),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String?>(
                      initialValue: _selectedPolicyId,
                      decoration: InputDecoration(
                        labelText: l10n.adminAttendancePolicy,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String?>(
                          child: Text(l10n.adminNoneOption),
                        ),
                        ..._policies.map(
                          (p) => DropdownMenuItem<String?>(
                            value: p.id,
                            child: Text(p.name ?? p.id),
                          ),
                        ),
                      ],
                      onChanged: (v) => setState(() => _selectedPolicyId = v),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String?>(
                      initialValue: _selectedManagerId,
                      decoration: InputDecoration(
                        labelText: l10n.adminManager,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String?>(
                          child: Text(l10n.adminNoneOption),
                        ),
                        ..._managers.map(
                          (m) => DropdownMenuItem<String?>(
                            value: m.id,
                            child: Text(m.fullName),
                          ),
                        ),
                      ],
                      onChanged: (v) => setState(() => _selectedManagerId = v),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _joiningDateCtrl,
                      decoration: InputDecoration(
                        labelText: l10n.adminDateFormatHint(
                          l10n.adminJoiningDate,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isSaving ? null : _save,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _isSaving
                          ? const CircularProgressIndicator()
                          : Text(l10n.adminSave),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
