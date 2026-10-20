import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/work_reports/application/work_report_controller.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';

/// Screen presenting full read-only or editable breakdown for a specific work report by ID.
class WorkReportDetailScreen extends ConsumerWidget {
  const WorkReportDetailScreen({required this.reportId, super.key});

  final String reportId;

  Color _getStatusColor(String status, ColorScheme colorScheme) {
    switch (status.toLowerCase()) {
      case 'reviewed':
        return Colors.green;
      case 'submitted':
        return colorScheme.primary;
      case 'draft':
      default:
        return Colors.orange;
    }
  }

  String _getStatusLabel(String status, AppLocalizations l10n) {
    switch (status.toLowerCase()) {
      case 'reviewed':
        return l10n.workReportStatusReviewed;
      case 'submitted':
        return l10n.workReportStatusSubmitted;
      case 'draft':
      default:
        return l10n.workReportStatusDraft;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final formatters = ref.watch(appFormattersProvider);
    final rules = ref.watch(workReportRulesProvider);
    final reportAsync = ref.watch(workReportDetailProvider(reportId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.workReportDetailTitle),
        actions: [
          reportAsync.maybeWhen(
            data: (report) {
              final canEdit = rules.canEdit(
                date: report.reportDate,
                today: formatters.todayDate(),
                existingStatus: report.status,
              );
              if (!canEdit) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: l10n.workReportsTabToday,
                onPressed: () {
                  ref
                      .read(selectedWorkReportDateProvider.notifier)
                      .select(WorkReportRules.toIsoDate(report.reportDate));
                  context.go(RoutePaths.workReports);
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: reportAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.errorStateDefaultMessage,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              FilledButton(
                onPressed: () => ref.refresh(
                  workReportDetailProvider(reportId),
                ),
                child: Text(l10n.commonRetry),
              ),
            ],
          ),
        ),
        data: (report) {
          final statusColor = _getStatusColor(report.status, theme.colorScheme);
          final statusLabel = _getStatusLabel(report.status, l10n);
          final duration = WorkReportRules.splitDuration(
            report.totalMinutes,
          );
          final formattedTime = l10n.workReportHoursMinutes(
            duration.hours,
            duration.minutes,
          );
          final formattedDate = formatters.formatDate(report.reportDate);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top status and date header card
                Card(
                  elevation: AppElevation.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
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
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: AppSpacing.iconSm,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  formattedDate,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xxs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                                border: Border.all(
                                  color: statusColor.withValues(alpha: 0.5),
                                ),
                              ),
                              child: Text(
                                statusLabel,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: AppSpacing.iconSm,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Text(
                              l10n.workReportTotalTime(formattedTime),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Icon(
                              Icons.list_alt,
                              size: AppSpacing.iconSm,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Text(
                              l10n.workReportItemsCount(report.items.length),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Reviewer note banner (if reviewed or returned with feedback)
                if (report.reviewNote != null &&
                    report.reviewNote!.trim().isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiaryContainer.withValues(
                        alpha: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: theme.colorScheme.tertiary.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.rate_review_outlined,
                              size: AppSpacing.iconMd,
                              color: theme.colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              l10n.workReportReviewerNote,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          report.reviewNote!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onTertiaryContainer,
                          ),
                        ),
                        if (report.reviewerName != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.workReportReviewedBy(report.reviewerName!),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Summary card
                if (report.summary != null && report.summary!.isNotEmpty) ...[
                  Text(
                    l10n.workReportSummaryLabel,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Card(
                    elevation: AppElevation.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      side: BorderSide(
                        color: theme.colorScheme.outlineVariant.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(
                        report.summary!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Activities breakdown
                Text(
                  l10n.workReportActivitiesTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                ...report.items.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return _WorkReportDetailItemTile(
                    item: item,
                    index: idx,
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _WorkReportDetailItemTile extends StatelessWidget {
  const _WorkReportDetailItemTile({
    required this.item,
    required this.index,
  });

  final WorkReportItemModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final duration = WorkReportRules.splitDuration(item.minutesSpent);
    final formattedDuration = l10n.workReportHoursMinutes(
      duration.hours,
      duration.minutes,
    );
    final itemIndexLabel = '${index + 1}';

    return Card(
      elevation: AppElevation.none,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
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
                Text(
                  itemIndexLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  formattedDuration,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            if (item.projectName != null || item.clientName != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xxs,
                children: [
                  if (item.projectName != null)
                    Chip(
                      avatar: const Icon(Icons.business, size: 14),
                      label: Text(item.projectName!),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  if (item.clientName != null)
                    Chip(
                      avatar: const Icon(Icons.person, size: 14),
                      label: Text(item.clientName!),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.description,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
