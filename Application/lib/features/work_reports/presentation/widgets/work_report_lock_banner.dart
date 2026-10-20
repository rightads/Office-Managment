import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';

/// Banner shown when a work report is locked against edits.
class WorkReportLockBanner extends StatelessWidget {
  const WorkReportLockBanner({
    required this.editableWindowDays,
    this.lockReason,
    this.lockReasonString,
    super.key,
  });

  final WorkReportLockReason? lockReason;
  final String? lockReasonString;
  final int editableWindowDays;

  String _formatReason(BuildContext context) {
    final l10n = context.l10n;
    if (lockReason != null) {
      switch (lockReason!) {
        case WorkReportLockReason.futureDate:
          return l10n.workReportLockReasonFuture;
        case WorkReportLockReason.outsideEditableWindow:
          return l10n.workReportLockReasonWindow(editableWindowDays);
        case WorkReportLockReason.submitted:
          return l10n.workReportLockReasonSubmitted;
        case WorkReportLockReason.reviewed:
          return l10n.workReportLockReasonReviewed;
      }
    }
    final raw = (lockReasonString ?? '').toLowerCase();
    if (raw.contains('future')) {
      return l10n.workReportLockReasonFuture;
    }
    if (raw.contains('window') || raw.contains('expired')) {
      return l10n.workReportLockReasonWindow(editableWindowDays);
    }
    if (raw.contains('submit')) {
      return l10n.workReportLockReasonSubmitted;
    }
    if (raw.contains('review')) {
      return l10n.workReportLockReasonReviewed;
    }
    return lockReasonString ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final reasonText = _formatReason(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline,
            size: AppSpacing.iconMd,
            color: theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.workReportLockedBanner(reasonText),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
