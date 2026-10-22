import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/work_reports/application/work_report_controller.dart';
import 'package:right_ads/features/work_reports/application/work_report_reminder_service.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_card.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_item_row.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_lock_banner.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_time_budget_card.dart';

/// Screen presenting the user's daily work reports with Today/Editor and History tabs.
class WorkReportsScreen extends ConsumerStatefulWidget {
  const WorkReportsScreen({this.initialDate, super.key});

  final DateTime? initialDate;

  @override
  ConsumerState<WorkReportsScreen> createState() => _WorkReportsScreenState();
}

class _WorkReportsScreenState extends ConsumerState<WorkReportsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _summaryController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _summaryController = TextEditingController();

    // Trigger local daily reminder check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(ref.read(workReportReminderSyncProvider.future));
      if (widget.initialDate != null) {
        ref
            .read(selectedWorkReportDateProvider.notifier)
            .select(WorkReportRules.toIsoDate(widget.initialDate!));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context,
    DateTime currentDate,
    int editableWindowDays,
  ) async {
    final formatters = ref.read(appFormattersProvider);
    final today = formatters.todayDate();
    final firstDate = today.subtract(Duration(days: editableWindowDays));

    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate.isAfter(today) ? today : currentDate,
      firstDate: firstDate.isAfter(today) ? today : firstDate,
      lastDate: today, // Future dates strictly blocked
    );

    if (picked != null && picked != currentDate) {
      ref
          .read(selectedWorkReportDateProvider.notifier)
          .select(WorkReportRules.toIsoDate(picked));
    }
  }

  Future<void> _submitReport(
    BuildContext context,
    String activeDateKey,
    WorkReportEditorState editorState,
  ) async {
    final l10n = context.l10n;
    final notifier = ref.read(
      workReportEditorControllerProvider(activeDateKey).notifier,
    );

    if (editorState.items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.workReportAtLeastOneItem)));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.workReportSubmitConfirmTitle),
        content: Text(l10n.workReportSubmitConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.workReportSubmit),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final success = await notifier.submit();
    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.workReportSubmitted)));
      ref
        ..invalidate(workReportHistoryControllerProvider)
        ..invalidate(todayWorkReportProvider);
      unawaited(ref.read(workReportReminderSyncProvider.future));
    } else {
      final err = ref
          .read(workReportEditorControllerProvider(activeDateKey))
          .value
          ?.serverError;
      if (err != null && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err)));
      }
    }
  }

  Future<void> _saveDraft(BuildContext context, String activeDateKey) async {
    final l10n = context.l10n;
    final notifier = ref.read(
      workReportEditorControllerProvider(activeDateKey).notifier,
    );

    final success = await notifier.save();
    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.workReportDraftSaved)));
      ref.invalidate(workReportHistoryControllerProvider);
    } else {
      final err = ref
          .read(workReportEditorControllerProvider(activeDateKey))
          .value
          ?.serverError;
      if (err != null && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final formatters = ref.watch(appFormattersProvider);
    final rules = ref.watch(workReportRulesProvider);
    final today = ref.watch(workReportTodayProvider);

    final selectedDateKey = ref.watch(selectedWorkReportDateProvider);
    final activeDateKey = selectedDateKey ?? WorkReportRules.toIsoDate(today);

    final editorAsync = ref.watch(
      workReportEditorControllerProvider(activeDateKey),
    );
    final editorNotifier = ref.read(
      workReportEditorControllerProvider(activeDateKey).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.workReportsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.workReportsTabToday),
            Tab(text: l10n.workReportsTabHistory),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Today / Editor Tab
          editorAsync.when(
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
                      workReportEditorControllerProvider(activeDateKey),
                    ),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
            data: (editorState) {
              if (_summaryController.text != editorState.summary) {
                _summaryController.text = editorState.summary;
              }

              final canEdit = rules.canEdit(
                date: editorState.date,
                today: today,
                existingStatus: editorState.report?.status,
              );
              final lock = rules.lockReason(
                date: editorState.date,
                today: today,
                existingStatus: editorState.report?.status,
              );

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(
                    workReportEditorControllerProvider(activeDateKey),
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date picker header row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: AppSpacing.iconMd,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                formatters.formatDate(editorState.date),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.edit_calendar, size: 16),
                            label: Text(l10n.workReportSelectDate),
                            onPressed: () => _pickDate(
                              context,
                              editorState.date,
                              rules.editableWindowDays,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Lock warning banner
                      if (!canEdit) ...[
                        WorkReportLockBanner(
                          lockReason: lock,
                          editableWindowDays: rules.editableWindowDays,
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],

                      // Time budget card
                      WorkReportTimeBudgetCard(
                        totalMinutes: editorState.totalMinutes,
                        maxMinutes: rules.maxMinutesPerDay,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Report summary input
                      TextFormField(
                        controller: _summaryController,
                        enabled: canEdit,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: l10n.workReportSummaryLabel,
                          hintText: l10n.workReportSummaryHint,
                          alignLabelWithHint: true,
                        ),
                        onChanged: editorNotifier.setSummary,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Activities section header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.workReportActivitiesTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (canEdit)
                            TextButton.icon(
                              icon: const Icon(Icons.add, size: 18),
                              label: Text(l10n.workReportAddActivity),
                              onPressed: editorNotifier.addItem,
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),

                      // Activity rows list
                      ...editorState.items.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final item = entry.value;
                        return WorkReportItemRow(
                          key: ValueKey(item.localId),
                          item: item,
                          index: idx,
                          isReadOnly: !canEdit,
                          onChanged: (updated) => editorNotifier.updateDraftRow(
                            item.localId,
                            updated,
                          ),
                          onDelete: editorState.items.length > 1 && canEdit
                              ? () => editorNotifier.removeItem(item.localId)
                              : null,
                        );
                      }),
                      const SizedBox(height: AppSpacing.lg),

                      // Bottom action buttons
                      if (canEdit) ...[
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: editorState.isBusy
                                    ? null
                                    : () => _saveDraft(context, activeDateKey),
                                child: editorState.isSaving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(l10n.workReportSaveDraft),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: FilledButton(
                                onPressed: editorState.isBusy
                                    ? null
                                    : () => _submitReport(
                                        context,
                                        activeDateKey,
                                        editorState,
                                      ),
                                child: editorState.isSubmitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(l10n.workReportSubmit),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          // Tab 2: History Tab
          Consumer(
            builder: (context, ref, _) {
              final historyAsync = ref.watch(
                workReportHistoryControllerProvider,
              );

              return historyAsync.when(
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
                          workReportHistoryControllerProvider,
                        ),
                        child: Text(l10n.commonRetry),
                      ),
                    ],
                  ),
                ),
                data: (historyState) {
                  if (historyState.items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: AppSpacing.iconXl,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            l10n.workReportEmptyHistoryTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.workReportEmptyHistorySubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(workReportHistoryControllerProvider);
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                      ),
                      itemCount: historyState.items.length,
                      itemBuilder: (context, index) {
                        final report = historyState.items[index];
                        return WorkReportCard(
                          report: report,
                          onTap: () {
                            unawaited(
                              context.push(
                                '${RoutePaths.workReports}/${report.id}',
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
