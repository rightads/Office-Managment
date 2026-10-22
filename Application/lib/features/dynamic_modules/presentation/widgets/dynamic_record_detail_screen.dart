import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/dynamic_modules/application/dynamic_module_controller.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_field_renderer.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_record_form_screen.dart';

/// Screen displaying record details, field groups, status transitions, comments, attachments and activity timeline.
class DynamicRecordDetailScreen extends ConsumerStatefulWidget {
  const DynamicRecordDetailScreen({
    required this.definition,
    required this.recordId,
    super.key,
  });

  final DynamicModuleDefinition definition;
  final String recordId;

  @override
  ConsumerState<DynamicRecordDetailScreen> createState() =>
      _DynamicRecordDetailScreenState();
}

class _DynamicRecordDetailScreenState
    extends ConsumerState<DynamicRecordDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _commentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleStatusTransition(
    DynamicModuleTransition transition,
  ) async {
    final noteCtrl = TextEditingController();
    final l10n = context.l10n;
    final statusName =
        transition.toStatusLabel ?? transition.toStatusCode ?? '';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.dynamicModuleTransitionTitle(statusName)),
        content: TextField(
          controller: noteCtrl,
          decoration: InputDecoration(
            labelText: l10n.dynamicModuleTransitionNoteLabel,
          ),
          maxLines: 2,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.commonConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await ref
          .read(
            dynamicRecordDetailControllerProvider(
              widget.definition.code,
              widget.recordId,
            ).notifier,
          )
          .changeStatus(
            transition.toStatusId,
            note: noteCtrl.text.trim().isNotEmpty ? noteCtrl.text.trim() : null,
          );
      if (mounted) {
        if (success) {
          AppSnackbar.showSuccess(context, 'Status updated');
        } else {
          AppSnackbar.showError(context, 'Failed to update status');
        }
      }
    }
  }

  Future<void> _handleAddComment() async {
    final text = _commentCtrl.text.trim();
    if (text.isEmpty) return;

    final success = await ref
        .read(
          dynamicRecordDetailControllerProvider(
            widget.definition.code,
            widget.recordId,
          ).notifier,
        )
        .addComment(text);

    if (mounted) {
      if (success) {
        _commentCtrl.clear();
        AppSnackbar.showSuccess(context, 'Comment added');
      } else {
        AppSnackbar.showError(context, 'Failed to add comment');
      }
    }
  }

  Future<void> _handleDelete() async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Delete ${widget.definition.recordLabelSingular}?',
      message: 'This will remove the record. Are you sure?',
      confirmLabel: 'Delete',
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    final success = await ref
        .read(
          dynamicRecordDetailControllerProvider(
            widget.definition.code,
            widget.recordId,
          ).notifier,
        )
        .deleteRecord();

    if (mounted) {
      if (success) {
        AppSnackbar.showSuccess(context, 'Record deleted');
        Navigator.of(context).pop(true);
      } else {
        AppSnackbar.showError(context, 'Failed to delete record');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    final state = ref.watch(
      dynamicRecordDetailControllerProvider(
        widget.definition.code,
        widget.recordId,
      ),
    );

    final canManage = ref.can('modules.manage');
    final canEdit =
        canManage ||
        ref.can('module.${widget.definition.code}.edit_all') ||
        ref.can('module.${widget.definition.code}.edit_own');
    final canDelete =
        canManage || ref.can('module.${widget.definition.code}.delete');

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.definition.recordLabelSingular)),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: LoadingSkeletonList(itemCount: 4),
        ),
      );
    }

    if (state.failure != null || state.detail == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.definition.recordLabelSingular)),
        body: ErrorState(
          message: state.failure?.message ?? 'Record not found',
          onRetry: () => ref
              .read(
                dynamicRecordDetailControllerProvider(
                  widget.definition.code,
                  widget.recordId,
                ).notifier,
              )
              .load(),
        ),
      );
    }

    final detail = state.detail!;
    final status = detail.status;
    final statusColor =
        DynamicColorParser.tryParseHex(status?.color) ?? colorScheme.primary;

    // Group fields by section
    final Map<String, List<DynamicModuleField>> sections = {};
    for (final f in widget.definition.fields.where((f) => f.isActive)) {
      final sec = (f.section != null && f.section!.trim().isNotEmpty)
          ? f.section!.trim()
          : 'General Information';
      sections.putIfAbsent(sec, () => []).add(f);
    }
    for (final list in sections.values) {
      list.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }

    final recordNumber = detail.id.length >= 8
        ? detail.id.substring(0, 8)
        : detail.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.dynamicModuleRecordNumberTitle(
            widget.definition.recordLabelSingular,
            recordNumber,
          ),
        ),
        actions: <Widget>[
          if (canEdit)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit',
              onPressed: () async {
                final changed = await Navigator.of(context).push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (ctx) => DynamicRecordFormScreen(
                      definition: widget.definition,
                      initialRecord: DynamicRecordModel(
                        id: detail.id,
                        moduleId: detail.moduleId,
                        data: detail.data,
                        statusId: detail.statusId,
                        status: detail.status,
                        createdBy: detail.createdBy,
                        creatorName: detail.creatorName,
                        assignedTo: detail.assignedTo,
                        assigneeName: detail.assigneeName,
                        clientId: detail.clientId,
                        clientName: detail.clientName,
                        dueAt: detail.dueAt,
                        createdAt: detail.createdAt,
                        updatedAt: detail.updatedAt,
                        allowedTransitions: detail.allowedTransitions,
                      ),
                    ),
                  ),
                );
                if (changed == true) {
                  ref
                      .read(
                        dynamicRecordDetailControllerProvider(
                          widget.definition.code,
                          widget.recordId,
                        ).notifier,
                      )
                      .load();
                  ref.invalidate(
                    dynamicRecordListControllerProvider(widget.definition.code),
                  );
                  ref.invalidate(moduleSummaryProvider(widget.definition.code));
                }
              },
            ),
          if (canDelete)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Delete',
              onPressed: _handleDelete,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: l10n.dynamicModuleOverviewTab),
            Tab(text: l10n.dynamicModuleCommentsTab),
            Tab(text: l10n.dynamicModuleTimelineTab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          // 1. Overview Tab: Status card, Transitions, Sections & Fields
          ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              // Status & Transitions card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            l10n.dynamicModuleCurrentStatus,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (status != null)
                            Chip(
                              label: Text(status.label),
                              backgroundColor: statusColor.withValues(
                                alpha: 0.12,
                              ),
                              side: BorderSide(
                                color: statusColor.withValues(alpha: 0.4),
                              ),
                              labelStyle: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                      if (detail.allowedTransitions.isNotEmpty) ...<Widget>[
                        const Divider(height: 16),
                        Text(
                          l10n.dynamicModuleMoveStatusTo,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: detail.allowedTransitions.map((t) {
                            final tColor =
                                DynamicColorParser.tryParseHex(
                                  t.toStatusColor,
                                ) ??
                                colorScheme.primary;
                            return ActionChip(
                              avatar: Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: tColor,
                              ),
                              label: Text(
                                t.toStatusLabel ??
                                    t.toStatusCode ??
                                    'Transition',
                              ),
                              labelStyle: TextStyle(
                                color: tColor,
                                fontWeight: FontWeight.bold,
                              ),
                              side: BorderSide(
                                color: tColor.withValues(alpha: 0.4),
                              ),
                              backgroundColor: tColor.withValues(alpha: 0.08),
                              onPressed: state.isActionInProgress
                                  ? null
                                  : () => _handleStatusTransition(t),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Sections
              ...sections.entries.map((secEntry) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          secEntry.key,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const Divider(height: 16),
                        ...secEntry.value.map((f) {
                          final val = detail.data[f.key];
                          return DynamicFieldRenderer(field: f, value: val);
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),

          // 2. Comments Tab
          Column(
            children: <Widget>[
              Expanded(
                child: detail.comments.isEmpty
                    ? Center(
                        child: Text(
                          l10n.dynamicModuleNoComments,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.outline,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: detail.comments.length,
                        separatorBuilder: (_, _) => const Divider(height: 16),
                        itemBuilder: (ctx, idx) {
                          final c = detail.comments[idx];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    c.userName ?? 'User',
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    _formatTimestamp(c.createdAt),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                c.comment,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          );
                        },
                      ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      top: BorderSide(color: colorScheme.outlineVariant),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _commentCtrl,
                          decoration: InputDecoration(
                            hintText: l10n.dynamicModuleAddCommentHint,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                          ),
                          minLines: 1,
                          maxLines: 3,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        color: colorScheme.primary,
                        onPressed: state.isActionInProgress
                            ? null
                            : _handleAddComment,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. Activity Timeline Tab
          detail.activities.isEmpty
              ? Center(
                  child: Text(
                    l10n.dynamicModuleNoActivities,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: detail.activities.length,
                  separatorBuilder: (_, _) => const Divider(height: 16),
                  itemBuilder: (ctx, idx) {
                    final act = detail.activities[idx];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.history,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${act.userName ?? "User"} ${act.action}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (act.details != null &&
                                  act.details!.isNotEmpty) ...<Widget>[
                                const SizedBox(height: 4),
                                Text(
                                  act.details.toString(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 4),
                              Text(
                                _formatTimestamp(act.createdAt),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
