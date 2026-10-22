import 'package:flutter/material.dart';

import 'package:right_ads/core/l10n/l10n.dart';

class AttendanceExportDialog extends StatefulWidget {
  const AttendanceExportDialog({this.departmentId, super.key});

  final String? departmentId;

  @override
  State<AttendanceExportDialog> createState() => _AttendanceExportDialogState();
}

class _AttendanceExportDialogState extends State<AttendanceExportDialog> {
  String _selectedReportType = 'monthly_summary';
  String _selectedFormat = 'xlsx';
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.adminAttendanceExport),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedReportType,
              decoration: InputDecoration(
                labelText: l10n.adminAttendanceExportType,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'monthly_summary',
                  child: Text(l10n.adminAttendanceMonthlySummary),
                ),
                DropdownMenuItem(
                  value: 'yearly_summary',
                  child: Text(l10n.adminAttendanceYearlySummary),
                ),
                DropdownMenuItem(
                  value: 'detailed_logs',
                  child: Text(l10n.adminAttendanceDetailedLogs),
                ),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _selectedReportType = v);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedFormat,
              decoration: InputDecoration(
                labelText: l10n.adminAttendanceExportFormat,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'xlsx',
                  child: Text(l10n.adminAttendanceFormatExcel),
                ),
                DropdownMenuItem(
                  value: 'pdf',
                  child: Text(l10n.adminAttendanceFormatPdf),
                ),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _selectedFormat = v);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.adminCancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, <String, dynamic>{
              'reportType': _selectedReportType,
              'format': _selectedFormat,
              'month': _selectedMonth,
              'year': _selectedYear,
              'departmentId': widget.departmentId,
            });
          },
          child: Text(l10n.adminAttendanceExport),
        ),
      ],
    );
  }
}
