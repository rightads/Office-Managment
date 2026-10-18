import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/core/widgets/status_chip.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

/// Modal dialog/sheet allowing the employee to transition a task's status
/// along server-governed DB transition paths.
class TaskStatusTransitionDialog extends StatefulWidget {
  const TaskStatusTransitionDialog({
    required this.task,
    required this.allowedStatuses,
    required this.onConfirmTransition,
    super.key,
  });

  final TaskItemModel task;
  final List<TaskStatusModel> allowedStatuses;
  final Future<void> Function(String toStatusId, String? remarks)
  onConfirmTransition;

  static Future<void> show({
    required BuildContext context,
    required TaskItemModel task,
    required List<TaskStatusModel> allowedStatuses,
    required Future<void> Function(String toStatusId, String? remarks)
    onConfirmTransition,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskStatusTransitionDialog(
        task: task,
        allowedStatuses: allowedStatuses,
        onConfirmTransition: onConfirmTransition,
      ),
    );
  }

  @override
  State<TaskStatusTransitionDialog> createState() =>
      _TaskStatusTransitionDialogState();
}

class _TaskStatusTransitionDialogState
    extends State<TaskStatusTransitionDialog> {
  TaskStatusModel? _selectedStatus;
  final _remarksController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.allowedStatuses.isNotEmpty) {
      _selectedStatus = widget.allowedStatuses.first;
    }
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _handleConfirm() async {
    final target = _selectedStatus;
    if (target == null) return;

    final l10n = context.l10n;

    // Show confirmation dialog before executing transition
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.taskTransitionConfirmTitle,
      message: l10n.taskTransitionConfirmMessage(
        widget.task.status.label,
        target.label,
      ),
      confirmLabel: l10n.taskTransitionConfirmAction,
      isDestructive: target.isTerminal,
    );

    if (!confirmed || !mounted) return;

    setState(() => _isSubmitting = true);
    try {
      await widget.onConfirmTransition(
        target.id,
        _remarksController.text.trim().isEmpty
            ? null
            : _remarksController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg + viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header
          Row(
            children: <Widget>[
              Text(
                l10n.taskTransitionSheetTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Current Status
          Row(
            children: <Widget>[
              Text(
                l10n.taskCurrentStatusLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusChip(
                label: widget.task.status.label,
                hexColor: widget.task.status.color,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Select Target Status
          Text(
            l10n.taskSelectTargetStatusLabel,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          if (widget.allowedStatuses.isEmpty) ...<Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Text(
                l10n.taskNoTransitionsAvailable,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
          ] else ...<Widget>[
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: <Widget>[
                for (final st in widget.allowedStatuses)
                  ChoiceChip(
                    label: StatusChip(
                      label: st.label,
                      hexColor: st.color,
                    ),
                    selected: _selectedStatus?.id == st.id,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedStatus = st);
                      }
                    },
                  ),
              ],
            ),
          ],

          const SizedBox(height: AppSpacing.lg),

          // Optional Remarks Field
          TextField(
            controller: _remarksController,
            maxLines: 3,
            maxLength: 500,
            decoration: InputDecoration(
              labelText: l10n.taskTransitionRemarksLabel,
              hintText: l10n.taskTransitionRemarksHint,
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: _isSubmitting
                    ? null
                    : () => Navigator.of(context).pop(),
                child: Text(l10n.commonCancel),
              ),
              const SizedBox(width: AppSpacing.sm),
              FilledButton(
                onPressed:
                    (_selectedStatus == null ||
                        _isSubmitting ||
                        widget.allowedStatuses.isEmpty)
                    ? null
                    : _handleConfirm,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.taskTransitionSubmitButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
