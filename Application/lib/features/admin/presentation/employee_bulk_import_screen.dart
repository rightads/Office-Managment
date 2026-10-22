import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import '../application/bulk_import_controller.dart';
import '../domain/admin_models.dart';

class EmployeeBulkImportScreen extends ConsumerWidget {
  const EmployeeBulkImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(bulkImportControllerProvider);
    final controller = ref.read(bulkImportControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminBulkImport),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 48,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.selectedFileName ?? 'No CSV file selected',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.folder_open),
                      label: Text(l10n.adminPickCsv),
                      onPressed: () async {
                        final result = await FilePicker.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['csv'],
                          
                        );
                        if (result.isNotEmpty) {
                          final file = result.first;
                          final bytes = await file.xFile.readAsBytes(); {
                            controller.setSelectedFile(
                              fileName: file.name,
                              bytes: bytes,
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: Text(l10n.adminDryRun),
              value: state.dryRun,
              onChanged: (val) => controller.setDryRun(value: val ?? false),
            ),
            const SizedBox(height: 16),
            if (state.errorMessage != null) ...[
              Text(
                state.errorMessage!,
                style: const TextStyle(color: AppColors.error),
              ),
              const SizedBox(height: 12),
            ],
            ElevatedButton(
              onPressed: state.isUploading || state.selectedFileBytes == null
                  ? null
                  : controller.upload,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: state.isUploading
                  ? const CircularProgressIndicator()
                  : Text(l10n.adminUploadCsv),
            ),
            if (state.report != null) ...[
              const SizedBox(height: 24),
              _buildReport(state.report!, l10n),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReport(BulkImportReport report, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: report.failedRows == 0
              ? AppColors.success.withAlpha(30)
              : AppColors.warning.withAlpha(30),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.adminImportSummary(
                report.successfulImports,
                report.failedRows,
                report.totalRows,
              ),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (report.errors.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            l10n.adminImportErrors,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...report.errors.map(
            (err) => Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                ),
                title: Text(l10n.adminRowErrorTitle(err.row, err.field)),
                subtitle: Text(
                  '${err.error}${err.value != null ? ' (Value: ${err.value})' : ''}',
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
