import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/leaves/application/leave_controller.dart';
import 'package:right_ads/features/leaves/presentation/widgets/cancel_leave_dialog.dart';

class LeaveDetailScreen extends ConsumerWidget {
  const LeaveDetailScreen({
    required this.leaveId,
    super.key,
  });

  final String leaveId;

  Color _getStatusColor(String status, ColorScheme colorScheme) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'rejected':
        return colorScheme.error;
      case 'cancelled':
      default:
        return colorScheme.outline;
    }
  }

  String _getStatusLabel(String status, AppLocalizations l10n) {
    switch (status.toLowerCase()) {
      case 'approved':
        return l10n.leavesFilterApproved;
      case 'pending':
        return l10n.leavesFilterPending;
      case 'rejected':
        return l10n.leavesFilterRejected;
      case 'cancelled':
        return l10n.leavesFilterCancelled;
      default:
        return status.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final detailAsync = ref.watch(leaveDetailControllerProvider(leaveId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.leaveDetailTitle),
      ),
      body: detailAsync.when(
        data: (leave) {
          final formatters = ref.watch(appFormattersProvider);
          final statusColor = _getStatusColor(leave.status, theme.colorScheme);
          final fromDateStr = formatters.formatDate(leave.fromDate);
          final toDateStr = formatters.formatDate(leave.toDate);
          final dateRangeStr = leave.isHalfDay || leave.fromDate == leave.toDate
              ? fromDateStr
              : '$fromDateStr — $toDateStr';

          final daysStr = leave.totalDays % 1 == 0
              ? leave.totalDays.toInt().toString()
              : leave.totalDays.toStringAsFixed(1);

          final durationLabel = leave.isHalfDay
              ? l10n.leaveHalfDayFormat(
                  daysStr,
                  leave.halfDaySession == 'second_half'
                      ? l10n.leaveHalfDaySessionSecondHalf
                      : l10n.leaveHalfDaySessionFirstHalf,
                )
              : l10n.leaveTotalDaysCount(daysStr);

          final canCancel =
              leave.status.toLowerCase() == 'pending' ||
              leave.status.toLowerCase() == 'approved';

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(leaveDetailControllerProvider(leaveId));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Overview Card
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      side: BorderSide(
                        color: theme.colorScheme.outlineVariant.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  leave.leaveTypeName,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xxs,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.pill,
                                  ),
                                  border: Border.all(
                                    color: statusColor.withValues(alpha: 0.5),
                                  ),
                                ),
                                child: Text(
                                  _getStatusLabel(leave.status, l10n),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _buildDetailRow(
                            icon: Icons.calendar_today_outlined,
                            label: l10n.leaveApplyDateRangeLabel,
                            value: dateRangeStr,
                            theme: theme,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _buildDetailRow(
                            icon: Icons.timelapse_outlined,
                            label: l10n.leaveDetailStatusLabel,
                            value: durationLabel,
                            theme: theme,
                            valueColor: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _buildDetailRow(
                            icon: Icons.person_outline,
                            label: l10n.leaveDetailEmployeeLabel,
                            value:
                                '${leave.userFullName} (${leave.employeeCode})',
                            theme: theme,
                          ),
                          if (leave.departmentName != null) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildDetailRow(
                              icon: Icons.business_outlined,
                              label: 'Department',
                              value: leave.departmentName!,
                              theme: theme,
                            ),
                          ],
                          const SizedBox(height: AppSpacing.sm),
                          _buildDetailRow(
                            icon: Icons.access_time,
                            label: l10n.leaveDetailAppliedOnLabel,
                            value: formatters.formatDateTime(
                              leave.createdAt,
                            ),
                            theme: theme,
                          ),
                          if (leave.reviewerName != null) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildDetailRow(
                              icon: Icons.verified_user_outlined,
                              label: l10n.leaveDetailReviewedByLabel,
                              value: leave.reviewerName!,
                              theme: theme,
                            ),
                          ],
                          if (leave.reviewedAt != null) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildDetailRow(
                              icon: Icons.done_all,
                              label: l10n.leaveDetailReviewedOnLabel,
                              value: formatters.formatDateTime(
                                leave.reviewedAt!,
                              ),
                              theme: theme,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Reason Card
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      side: BorderSide(
                        color: theme.colorScheme.outlineVariant.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.leaveCardReasonLabel,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            leave.reason,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Review Note Card (if present)
                  if (leave.reviewNote != null &&
                      leave.reviewNote!.trim().isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    Card(
                      elevation: 0,
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        side: BorderSide(
                          color: statusColor.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.leaveCardReviewNoteLabel,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              leave.reviewNote!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (canCancel) ...[
                    const SizedBox(height: AppSpacing.xl),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(color: theme.colorScheme.error),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                      ),
                      onPressed: () async {
                        final result = await CancelLeaveDialog.show(
                          context,
                          request: leave,
                        );
                        if (result != null && result.confirmed) {
                          final success = await ref
                              .read(
                                leaveDetailControllerProvider(leaveId).notifier,
                              )
                              .cancel(reason: result.reason);

                          if (success && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.leaveCancelSuccess),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.cancel_outlined),
                      label: Text(
                        leave.status.toLowerCase() == 'approved'
                            ? l10n.leaveCardCancelApprovedAction
                            : l10n.leaveCardCancelAction,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            err.toString(),
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
