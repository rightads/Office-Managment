import 'package:flutter/material.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';

class AttendanceCorrectionDialog extends StatefulWidget {
  const AttendanceCorrectionDialog({
    required this.recordId,
    this.initialCheckIn,
    this.initialCheckOut,
    this.initialRemarks,
    super.key,
  });

  final String recordId;
  final String? initialCheckIn;
  final String? initialCheckOut;
  final String? initialRemarks;

  @override
  State<AttendanceCorrectionDialog> createState() =>
      _AttendanceCorrectionDialogState();
}

class _AttendanceCorrectionDialogState
    extends State<AttendanceCorrectionDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _reasonCtrl;
  late TextEditingController _checkInCtrl;
  late TextEditingController _checkOutCtrl;
  late TextEditingController _remarksCtrl;

  @override
  void initState() {
    super.initState();
    _reasonCtrl = TextEditingController();
    _checkInCtrl = TextEditingController(text: widget.initialCheckIn ?? '');
    _checkOutCtrl = TextEditingController(text: widget.initialCheckOut ?? '');
    _remarksCtrl = TextEditingController(text: widget.initialRemarks ?? '');
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    _checkInCtrl.dispose();
    _checkOutCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.adminAttendanceCorrectionTitle),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _reasonCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: l10n.adminAttendanceCorrectionReason,
                  hintText: l10n.adminAttendanceCorrectionReasonHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().length < 5) {
                    return 'At least 5 characters required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _checkInCtrl,
                decoration: InputDecoration(
                  labelText: l10n.adminAttendanceCheckInTime,
                  hintText: l10n.adminAttendanceIsoTimeHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _checkOutCtrl,
                decoration: InputDecoration(
                  labelText: l10n.adminAttendanceCheckOutTime,
                  hintText: l10n.adminAttendanceIsoTimeHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _remarksCtrl,
                decoration: InputDecoration(
                  labelText: l10n.adminAttendanceRemarks,
                  border: const OutlineInputBorder(),
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final req = AttendanceCorrectionRequest(
                reason: _reasonCtrl.text.trim(),
                checkInAt: _checkInCtrl.text.trim().isEmpty
                    ? null
                    : _checkInCtrl.text.trim(),
                checkOutAt: _checkOutCtrl.text.trim().isEmpty
                    ? null
                    : _checkOutCtrl.text.trim(),
                remarks: _remarksCtrl.text.trim().isEmpty
                    ? null
                    : _remarksCtrl.text.trim(),
              );
              Navigator.pop(context, req);
            }
          },
          child: Text(l10n.adminSave),
        ),
      ],
    );
  }
}
