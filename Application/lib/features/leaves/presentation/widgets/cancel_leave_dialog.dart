import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';

class CancelLeaveDialog extends StatefulWidget {
  const CancelLeaveDialog({
    required this.request,
    super.key,
  });

  final LeaveRequestModel request;

  static Future<({bool confirmed, String? reason})?> show(
    BuildContext context, {
    required LeaveRequestModel request,
  }) {
    return showDialog<({bool confirmed, String? reason})>(
      context: context,
      builder: (ctx) => CancelLeaveDialog(request: request),
    );
  }

  @override
  State<CancelLeaveDialog> createState() => _CancelLeaveDialogState();
}

class _CancelLeaveDialogState extends State<CancelLeaveDialog> {
  late final TextEditingController _reasonController;
  bool get isApproved => widget.request.status.toLowerCase() == 'approved';

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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(l10n.leaveCancelConfirmTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isApproved
                  ? l10n.leaveCancelApprovedConfirmMessage
                  : l10n.leaveCancelConfirmMessage,
              style: theme.textTheme.bodyMedium,
            ),
            if (isApproved) ...[
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _reasonController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: l10n.leaveCancelReasonLabel,
                  hintText: l10n.leaveCancelReasonHint,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          onPressed: () {
            Navigator.of(context).pop((
              confirmed: true,
              reason: _reasonController.text.trim().isEmpty
                  ? null
                  : _reasonController.text.trim(),
            ));
          },
          child: Text(
            isApproved
                ? l10n.leaveCardCancelApprovedAction
                : l10n.leaveCardCancelAction,
          ),
        ),
      ],
    );
  }
}
