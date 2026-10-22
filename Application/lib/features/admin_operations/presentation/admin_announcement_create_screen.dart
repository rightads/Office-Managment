import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import '../data/admin_operations_repository.dart';
import '../domain/admin_operations_models.dart';

class AdminAnnouncementCreateScreen extends ConsumerStatefulWidget {
  const AdminAnnouncementCreateScreen({super.key});

  @override
  ConsumerState<AdminAnnouncementCreateScreen> createState() =>
      _AdminAnnouncementCreateScreenState();
}

class _AdminAnnouncementCreateScreenState
    extends ConsumerState<AdminAnnouncementCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();

  String? _selectedDepartmentId;
  List<MasterDataItem> _departments = [];
  bool _isLoadingDepts = false;
  bool _isPublishing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    _expiryCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadDepartments() async {
    setState(() => _isLoadingDepts = true);
    try {
      final repo = ref.read(adminRepositoryProvider);
      final depts = await repo.getMasterDataList('/departments');
      if (mounted) {
        setState(() {
          _departments = depts;
          _isLoadingDepts = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingDepts = false);
    }
  }

  Future<void> _publish() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);

    setState(() {
      _isPublishing = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      final req = AnnouncementCreateRequest(
        title: _titleCtrl.text.trim(),
        body: _bodyCtrl.text.trim(),
        targetDepartmentId: _selectedDepartmentId,
        expiresAt: _expiryCtrl.text.trim().isEmpty
            ? null
            : _expiryCtrl.text.trim(),
      );

      await repo.publishAnnouncement(req);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminAnnouncementPublished)),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isPublishing = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminPublishAnnouncementTitle),
      ),
      body: SingleChildScrollView(
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
                controller: _titleCtrl,
                decoration: InputDecoration(
                  labelText: l10n.adminItemName,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().length < 2) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bodyCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l10n.adminItemDescription,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().length < 5) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                value: _selectedDepartmentId,
                decoration: InputDecoration(
                  labelText: l10n.adminAnnouncementTarget,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text(l10n.adminAllDepartments),
                  ),
                  ..._departments.map(
                    (d) => DropdownMenuItem<String?>(
                      value: d.id,
                      child: Text(d.name ?? d.id),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _selectedDepartmentId = v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _expiryCtrl,
                decoration: InputDecoration(
                  labelText: l10n.adminExpiryDate,
                  hintText: l10n.adminAttendanceIsoTimeHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isPublishing ? null : _publish,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isPublishing
                    ? const CircularProgressIndicator()
                    : Text(l10n.adminPublish),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
