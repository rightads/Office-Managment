import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/features/admin_operations/application/admin_operations_controllers.dart';
import 'package:right_ads/features/admin_operations/domain/admin_operations_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';

class AdminWorkReportsReviewScreen extends ConsumerWidget {
  const AdminWorkReportsReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(adminWorkReportsReviewControllerProvider);
    final controller = ref.read(
      adminWorkReportsReviewControllerProvider.notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminWorkReportsReviewTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadData,
          ),
        ],
      ),
      body: _buildBody(context, ref, state, controller, l10n),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AdminWorkReportsReviewState state,
    AdminWorkReportsReviewController controller,
    AppLocalizations l10n,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.errorMessage!,
              style: const TextStyle(color: AppColors.error),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: controller.loadData,
              child: Text(l10n.adminClose),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.loadData,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildDateSelector(context, state, controller),
          const SizedBox(height: 12),
          if (state.missingReports != null &&
              state.missingReports!.missingCount > 0) ...[
            _buildMissingBanner(state.missingReports!, l10n),
            const SizedBox(height: 16),
          ],
          if (state.reports.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.adminNoItemsFound),
              ),
            )
          else
            ...state.reports.map(
              (r) => _buildReportCard(context, r, controller, l10n),
            ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context,
    AdminWorkReportsReviewState state,
    AdminWorkReportsReviewController controller,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.selectedDate,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(state.selectedDate),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  controller.setDate(date.toIso8601String().split('T').first);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissingBanner(
    MissingWorkReportListResponse missing,
    AppLocalizations l10n,
  ) {
    return Card(
      color: AppColors.error.withAlpha(20),
      child: ExpansionTile(
        leading: const Icon(Icons.warning, color: AppColors.error),
        title: Text(
          l10n.adminMissingReports(missing.missingCount),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.error,
          ),
        ),
        children: missing.users.map((u) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                u.fullName.isNotEmpty ? u.fullName[0].toUpperCase() : '?',
              ),
            ),
            title: Text(u.fullName),
            subtitle: Text('${u.employeeCode} • ${u.departmentName ?? '-'}'),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context,
    WorkReportModel report,
    AdminWorkReportsReviewController controller,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  report.reportDate.toIso8601String().split('T').first,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    report.status,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.adminTotalMinsHrs(
                report.totalMinutes,
                (report.totalMinutes / 60).toStringAsFixed(1),
              ),
              style: const TextStyle(color: Colors.grey),
            ),
            if (report.reviewNote != null && report.reviewNote!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                l10n.adminFeedbackPrefix(report.reviewNote!),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
            const Divider(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.rate_review, size: 18),
                label: Text(l10n.adminReviewReport),
                onPressed: () =>
                    _openReviewDialog(context, report, controller, l10n),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openReviewDialog(
    BuildContext context,
    WorkReportModel report,
    AdminWorkReportsReviewController controller,
    AppLocalizations l10n,
  ) async {
    final noteCtrl = TextEditingController(text: report.reviewNote ?? '');
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminReviewReport),
        content: TextField(
          controller: noteCtrl,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: l10n.adminReviewFeedback,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.adminCancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (noteCtrl.text.trim().isNotEmpty) {
                Navigator.pop(ctx, true);
              }
            },
            child: Text(l10n.adminMarkReviewed),
          ),
        ],
      ),
    );

    if (res == true) {
      final success = await controller.submitReview(
        report.id,
        reviewNote: noteCtrl.text.trim(),
      );
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminReportReviewedSuccess)),
        );
      }
    }
  }
}
