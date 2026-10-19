import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/leaves/application/leave_controller.dart';

class ApplyLeaveBottomSheet extends ConsumerStatefulWidget {
  const ApplyLeaveBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const ApplyLeaveBottomSheet(),
    );
  }

  @override
  ConsumerState<ApplyLeaveBottomSheet> createState() =>
      _ApplyLeaveBottomSheetState();
}

class _ApplyLeaveBottomSheetState extends ConsumerState<ApplyLeaveBottomSheet> {
  late final TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final state = ref.read(leaveApplyControllerProvider);
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1);
    final lastDate = DateTime(now.year + 2, 12, 31);

    final initialFrom = state.fromDate ?? now;
    final initialTo = state.toDate ?? now;

    final picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: DateTimeRange(start: initialFrom, end: initialTo),
    );

    if (picked != null) {
      ref
          .read(leaveApplyControllerProvider.notifier)
          .setDateRange(picked.start, picked.end);
    }
  }

  Future<void> _pickSingleDate(BuildContext context) async {
    final state = ref.read(leaveApplyControllerProvider);
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1);
    final lastDate = DateTime(now.year + 2, 12, 31);

    final initialDate = state.fromDate ?? now;

    final picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: initialDate,
    );

    if (picked != null) {
      ref
          .read(leaveApplyControllerProvider.notifier)
          .setDateRange(picked, picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final state = ref.watch(leaveApplyControllerProvider);
    final typesAsync = ref.watch(leaveTypesProvider);
    final controller = ref.read(leaveApplyControllerProvider.notifier);

    final dateFormat = DateFormat.yMMMd();

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppRadius.xl),
      ),
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
          top: AppSpacing.md,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.leaveApplyTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: AppSpacing.sm),

              // 1. Leave Category Picker
              typesAsync.when(
                data: (types) {
                  return DropdownButtonFormField<String>(
                    initialValue: state.leaveTypeId,
                    decoration: InputDecoration(
                      labelText: l10n.leaveApplyCategoryLabel,
                      hintText: l10n.leaveApplyCategoryHint,
                      errorText: state.fieldErrors['leave_type_id'],
                      border: const OutlineInputBorder(),
                    ),
                    items: types.map((type) {
                      return DropdownMenuItem<String>(
                        value: type.id,
                        child: Text(
                          '${type.name} (${type.isPaid ? 'Paid' : 'Unpaid'})',
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        controller.setLeaveType(val);
                      }
                    },
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (err, _) => Text(
                  err.toString(),
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // 2. Half Day Toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.leaveApplyHalfDayToggle),
                value: state.isHalfDay,
                onChanged: (val) => controller.toggleHalfDay(isHalfDay: val),
              ),

              if (state.isHalfDay) ...[
                const SizedBox(height: AppSpacing.xs),
                SegmentedButton<String>(
                  segments: [
                    ButtonSegment<String>(
                      value: 'first_half',
                      label: Text(l10n.leaveHalfDaySessionFirstHalf),
                    ),
                    ButtonSegment<String>(
                      value: 'second_half',
                      label: Text(l10n.leaveHalfDaySessionSecondHalf),
                    ),
                  ],
                  selected: {state.halfDaySession},
                  onSelectionChanged: (newSelection) {
                    controller.setHalfDaySession(newSelection.first);
                  },
                ),
              ],
              const SizedBox(height: AppSpacing.md),

              // 3. Date Selection
              InkWell(
                onTap: () async {
                  if (state.isHalfDay) {
                    await _pickSingleDate(context);
                  } else {
                    await _pickDateRange(context);
                  }
                },
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: state.isHalfDay
                        ? l10n.leaveApplySingleDateLabel
                        : l10n.leaveApplyDateRangeLabel,
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                  ),
                  child: Text(
                    state.isHalfDay
                        ? dateFormat.format(state.fromDate ?? DateTime.now())
                        : '${dateFormat.format(state.fromDate ?? DateTime.now())}  —  ${dateFormat.format(state.toDate ?? DateTime.now())}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // 4. Server-Calculated Live Preview & Working Days
              if (state.isPreviewLoading) ...[
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      l10n.leaveApplyCalculatingPreview,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
              ] else if (state.preview != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: state.preview!.isValid
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : theme.colorScheme.errorContainer.withValues(
                            alpha: 0.5,
                          ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: state.preview!.isValid
                          ? theme.colorScheme.primary.withValues(alpha: 0.3)
                          : theme.colorScheme.error,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            state.preview!.isValid
                                ? Icons.check_circle_outline
                                : Icons.warning_amber_rounded,
                            size: 18,
                            color: state.preview!.isValid
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            l10n.leaveApplyWorkingDaysCount(
                              state.preview!.workingDays % 1 == 0
                                  ? state.preview!.workingDays
                                        .toInt()
                                        .toString()
                                  : state.preview!.workingDays.toStringAsFixed(
                                      1,
                                    ),
                            ),
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: state.preview!.isValid
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                      if (state.preview!.validationError != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          state.preview!.validationError!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],

              // 5. Submission Global Error
              if (state.submissionError != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(
                    state.submissionError!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],

              // 6. Reason Field
              TextField(
                controller: _reasonController,
                maxLines: 3,
                maxLength: 500,
                decoration: InputDecoration(
                  labelText: l10n.leaveApplyReasonLabel,
                  hintText: l10n.leaveApplyReasonHint,
                  errorText: state.fieldErrors['reason'],
                  border: const OutlineInputBorder(),
                ),
                onChanged: controller.setReason,
              ),
              const SizedBox(height: AppSpacing.lg),

              // 7. Submit Button
              FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                onPressed:
                    state.isSubmitting ||
                        (state.preview != null && !state.preview!.isValid)
                    ? null
                    : () async {
                        final success = await controller.submit();
                        if (success && context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      },
                child: state.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.leaveApplySubmitButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
