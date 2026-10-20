import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';

/// An editable or read-only card representing a single activity row within a daily work report.
class WorkReportItemRow extends StatefulWidget {
  const WorkReportItemRow({
    required this.item,
    required this.index,
    required this.isReadOnly,
    this.onChanged,
    this.onDelete,
    super.key,
  });

  final WorkReportItemDraft item;
  final int index;
  final bool isReadOnly;
  final ValueChanged<WorkReportItemDraft>? onChanged;
  final VoidCallback? onDelete;

  @override
  State<WorkReportItemRow> createState() => _WorkReportItemRowState();
}

class _WorkReportItemRowState extends State<WorkReportItemRow> {
  late final TextEditingController _descController;
  late final TextEditingController _minutesController;
  late final TextEditingController _projectController;
  late final TextEditingController _clientController;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.item.description);
    _minutesController = TextEditingController(
      text: widget.item.minutes != null && widget.item.minutes! > 0
          ? widget.item.minutes.toString()
          : '',
    );
    _projectController = TextEditingController(
      text: widget.item.projectName ?? '',
    );
    _clientController = TextEditingController(
      text: widget.item.clientName ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant WorkReportItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.description != widget.item.description &&
        _descController.text != widget.item.description) {
      _descController.text = widget.item.description;
    }
    if (oldWidget.item.minutes != widget.item.minutes) {
      final newText =
          widget.item.minutes != null && widget.item.minutes! > 0
              ? widget.item.minutes.toString()
              : '';
      if (_minutesController.text != newText) {
        _minutesController.text = newText;
      }
    }
    if (oldWidget.item.projectName != widget.item.projectName &&
        _projectController.text != (widget.item.projectName ?? '')) {
      _projectController.text = widget.item.projectName ?? '';
    }
    if (oldWidget.item.clientName != widget.item.clientName &&
        _clientController.text != (widget.item.clientName ?? '')) {
      _clientController.text = widget.item.clientName ?? '';
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    _minutesController.dispose();
    _projectController.dispose();
    _clientController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    if (widget.onChanged == null) return;
    final mins = int.tryParse(_minutesController.text.trim());
    final project = _projectController.text.trim();
    final client = _clientController.text.trim();

    widget.onChanged!(
      widget.item.copyWith(
        description: _descController.text,
        minutes: mins,
        projectName: project.isEmpty ? null : project,
        clientName: client.isEmpty ? null : client,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final itemNumber = '${widget.index + 1}';

    return Card(
      elevation: AppElevation.none,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
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
                  itemNumber,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (!widget.isReadOnly && widget.onDelete != null)
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: theme.colorScheme.error,
                      size: AppSpacing.iconMd,
                    ),
                    tooltip: l10n.workReportDeleteActivityConfirm,
                    onPressed: widget.onDelete,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _projectController,
                    enabled: !widget.isReadOnly,
                    decoration: InputDecoration(
                      labelText: l10n.workReportProjectLabel,
                      hintText: l10n.workReportSelectProject,
                      isDense: true,
                      prefixIcon: const Icon(Icons.business_outlined, size: 18),
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextFormField(
                    controller: _clientController,
                    enabled: !widget.isReadOnly,
                    decoration: InputDecoration(
                      labelText: l10n.workReportClientLabel,
                      hintText: l10n.workReportSelectClient,
                      isDense: true,
                      prefixIcon: const Icon(Icons.person_outline, size: 18),
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              controller: _descController,
              enabled: !widget.isReadOnly,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: l10n.workReportDescriptionLabel,
                hintText: l10n.workReportDescriptionHint,
                alignLabelWithHint: true,
              ),
              onChanged: (_) => _notifyChanged(),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: 160,
              child: TextFormField(
                controller: _minutesController,
                enabled: !widget.isReadOnly,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l10n.workReportMinutesLabel,
                  hintText: l10n.workReportMinutesHint,
                  isDense: true,
                  prefixIcon: const Icon(Icons.schedule, size: 18),
                ),
                onChanged: (_) => _notifyChanged(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
