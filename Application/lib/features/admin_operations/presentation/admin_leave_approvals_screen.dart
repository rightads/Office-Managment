import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/features/admin_operations/application/admin_operations_controllers.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';

class AdminLeaveApprovalsScreen extends ConsumerWidget {
  const AdminLeaveApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(adminLeaveApprovalsControllerProvider);
    final controller = ref.read(adminLeaveApprovalsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminLeaveApprovalsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadRequests,
          ),
        ],
      ),
      body: _buildBody(context, ref, state, controller, l10n),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AdminLeaveApprovalsState state,
    AdminLeaveApprovalsController controller,
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
              onPressed: controller.loadRequests,
              child: Text(l10n.adminClose),
            ),
          ],
        ),
      );
    }

    if (state.requests.isEmpty) {
      return Center(child: Text(l10n.adminNoItemsFound));
    }

    return RefreshIndicator(
      onRefresh: controller.loadRequests,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: state.requests.length,
        itemBuilder: (context, idx) {
          final item = state.requests[idx];
          return _buildLeaveCard(context, item, controller, l10n);
        },
      ),
    );
  }

  Widget _buildLeaveCard(
    BuildContext context,
    LeaveRequestModel item,
    AdminLeaveApprovalsController controller,
    AppLocalizations l10n,
  ) {
    final isPending = item.status.toUpperCase() == 'PENDING';

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
                  item.leaveTypeName,
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
                    color: isPending
                        ? AppColors.warning.withAlpha(30)
                        : AppColors.success.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      color: isPending ? AppColors.warning : AppColors.success,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.adminLeaveDaysCount(
                item.fromDate.toIso8601String().split('T').first,
                item.toDate.toIso8601String().split('T').first,
                item.totalDays.toInt(),
              ),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            if (item.reason.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(item.reason),
            ],
            if (isPending) ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                    ),
                    onPressed: () =>
                        _showRejectDialog(context, item, controller, l10n),
                    child: Text(l10n.adminReject),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () =>
                        _showApproveDialog(context, item, controller, l10n),
                    child: Text(l10n.adminApprove),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showApproveDialog(
    BuildContext context,
    LeaveRequestModel item,
    AdminLeaveApprovalsController controller,
    AppLocalizations l10n,
  ) async {
    final noteCtrl = TextEditingController();
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminApprove),
        content: TextField(
          controller: noteCtrl,
          decoration: InputDecoration(
            labelText: l10n.adminReviewNoteOptional,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.adminCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminApprove),
          ),
        ],
      ),
    );

    if (res == true) {
      final success = await controller.approve(
        item.id,
        reviewNote: noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim(),
      );
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminLeaveApprovedSuccess)),
        );
      }
    }
  }

  Future<void> _showRejectDialog(
    BuildContext context,
    LeaveRequestModel item,
    AdminLeaveApprovalsController controller,
    AppLocalizations l10n,
  ) async {
    final noteCtrl = TextEditingController();
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminReject),
        content: TextField(
          controller: noteCtrl,
          decoration: InputDecoration(
            labelText: l10n.adminRejectionReasonMandatory,
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
              if (noteCtrl.text.trim().length >= 3) {
                Navigator.pop(ctx, true);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.adminReject),
          ),
        ],
      ),
    );

    if (res == true) {
      final success = await controller.reject(
        item.id,
        reviewNote: noteCtrl.text.trim(),
      );
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminLeaveRejectedSuccess)),
        );
      }
    }
  }
}
