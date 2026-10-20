import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';

/// Progress visualizer comparing total logged minutes against the runtime-configured daily maximum.
class WorkReportTimeBudgetCard extends StatelessWidget {
  const WorkReportTimeBudgetCard({
    required this.totalMinutes,
    required this.maxMinutes,
    super.key,
  });

  final int totalMinutes;
  final int maxMinutes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final totalDuration = WorkReportRules.splitDuration(totalMinutes);
    final maxDuration = WorkReportRules.splitDuration(maxMinutes);

    final formattedTotal = l10n.workReportHoursMinutes(
      totalDuration.hours,
      totalDuration.minutes,
    );
    final formattedMax = l10n.workReportHoursMinutes(
      maxDuration.hours,
      maxDuration.minutes,
    );

    final fraction = maxMinutes <= 0
        ? 0.0
        : (totalMinutes / maxMinutes).clamp(0.0, 1.0);
    final isExceeded = totalMinutes > maxMinutes;
    final progressColor = isExceeded
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    return Card(
      elevation: AppElevation.none,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: isExceeded
              ? theme.colorScheme.error.withValues(alpha: 0.5)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
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
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: AppSpacing.iconMd,
                      color: progressColor,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      l10n.workReportTotalTime(formattedTotal),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isExceeded ? theme.colorScheme.error : null,
                      ),
                    ),
                  ],
                ),
                Text(
                  l10n.workReportMaxTime(formattedMax),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 8,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),
            if (isExceeded) ...[
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: AppSpacing.iconSm,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Expanded(
                    child: Text(
                      l10n.workReportTimeBudgetExceeded(formattedMax),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
