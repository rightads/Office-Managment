import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';

class LeaveRequestCard extends ConsumerWidget {
  const LeaveRequestCard({
    required this.request,
    this.onTap,
    this.onCancel,
    super.key,
  });

  final LeaveRequestModel request;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  bool get canCancel {
    final s = request.status.toLowerCase();
    return s == 'pending' || s == 'approved';
  }

  Color _getStatusColor(String status, ColorScheme colorScheme) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
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
    final formatters = ref.watch(appFormattersProvider);
    final statusColor = _getStatusColor(request.status, theme.colorScheme);

    final fromDateStr = formatters.formatDate(request.fromDate);
    final toDateStr = formatters.formatDate(request.toDate);
    final dateRangeStr = request.isHalfDay || request.fromDate == request.toDate
        ? fromDateStr
        : '$fromDateStr — $toDateStr';

    final daysStr = request.totalDays % 1 == 0
        ? request.totalDays.toInt().toString()
        : request.totalDays.toStringAsFixed(1);

    final durationLabel = request.isHalfDay
        ? l10n.leaveHalfDayFormat(
            daysStr,
            request.halfDaySession == 'second_half'
                ? l10n.leaveHalfDaySessionSecondHalf
                : l10n.leaveHalfDaySessionFirstHalf,
          )
        : l10n.leaveTotalDaysCount(daysStr);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      elevation: 0,
      color: theme.colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
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
                      request.leaveTypeName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      _getStatusLabel(request.status, l10n),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    dateRangeStr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                    ),
                    child: Text(
                      durationLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (request.reason.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  request.reason,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (request.reviewNote != null &&
                  request.reviewNote!.trim().isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border(
                      left: BorderSide(
                        color: statusColor,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    '${l10n.leaveCardReviewNoteLabel}: ${request.reviewNote}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
              if (canCancel && onCancel != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(color: theme.colorScheme.error),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: onCancel,
                      icon: const Icon(Icons.cancel_outlined, size: 14),
                      label: Text(
                        request.status.toLowerCase() == 'approved'
                            ? l10n.leaveCardCancelApprovedAction
                            : l10n.leaveCardCancelAction,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
