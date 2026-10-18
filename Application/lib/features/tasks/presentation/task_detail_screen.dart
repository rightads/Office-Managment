import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/core/widgets/status_chip.dart';
import 'package:right_ads/features/tasks/application/task_detail_controller.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_activity_tile.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_attachment_picker_sheet.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_attachment_tile.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_comment_tile.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_status_transition_dialog.dart';

/// Detailed Task View providing complete task metadata, data-driven allowed
/// status transitions, activity timeline, comments, and file attachments.
class TaskDetailScreen extends ConsumerStatefulWidget {
  const TaskDetailScreen({
    required this.taskId,
    super.key,
  });

  final String taskId;

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _commentInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentInputController.dispose();
    super.dispose();
  }

  bool _isEffectiveOverdue(TaskItemModel task) {
    if (task.isOverdue) return true;
    if (task.status.isTerminal) return false;
    final due = task.dueAt;
    if (due == null) return false;
    return due.isBefore(DateTime.now());
  }

  Future<void> _handlePostComment() async {
    final text = _commentInputController.text.trim();
    if (text.isEmpty) return;

    final controller = ref.read(
      taskDetailControllerProvider(widget.taskId).notifier,
    );
    final success = await controller.addComment(text);
    if (success && mounted) {
      _commentInputController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  Future<void> _openStatusTransitionDialog(TaskItemModel task) async {
    final controller = ref.read(
      taskDetailControllerProvider(widget.taskId).notifier,
    );
    final allowedStatuses = controller.getAllowedTargetStatuses();

    await TaskStatusTransitionDialog.show(
      context: context,
      task: task,
      allowedStatuses: allowedStatuses,
      onConfirmTransition: (toStatusId, remarks) async {
        final l10n = context.l10n;
        final success = await controller.updateStatus(
          toStatusId: toStatusId,
          remarks: remarks,
        );

        if (!mounted) return;
        if (success) {
          AppSnackbar.showSuccess(
            context,
            l10n.taskStatusTransitionSuccess,
          );
        } else {
          final err = ref
              .read(taskDetailControllerProvider(widget.taskId))
              .errorMessage;
          AppSnackbar.showError(
            context,
            err ?? l10n.taskStatusTransitionFailed,
          );
        }
      },
    );
  }

  Future<void> _openAttachmentPicker() async {
    await TaskAttachmentPickerSheet.show(
      context: context,
      onFileSelected: (bytes, fileName, mimeType) async {
        final l10n = context.l10n;
        final controller = ref.read(
          taskDetailControllerProvider(widget.taskId).notifier,
        );
        final success = await controller.uploadAttachment(
          fileBytes: bytes,
          fileName: fileName,
          mimeType: mimeType,
        );

        if (!mounted) return;
        if (success) {
          AppSnackbar.showSuccess(
            context,
            l10n.taskAttachmentUploadSuccess,
          );
        } else {
          final err = ref
              .read(taskDetailControllerProvider(widget.taskId))
              .errorMessage;
          AppSnackbar.showError(
            context,
            err ?? l10n.taskAttachmentUploadFailed,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final state = ref.watch(taskDetailControllerProvider(widget.taskId));

    return state.task.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.taskDetailTitle)),
        body: const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: <Widget>[
              LoadingSkeleton(height: 120),
              SizedBox(height: AppSpacing.md),
              LoadingSkeleton(height: 200),
            ],
          ),
        ),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: Text(l10n.taskDetailTitle)),
        body: Center(
          child: ErrorState(
            message: state.errorMessage ?? l10n.taskDetailLoadError,
            onRetry: () => ref
                .read(taskDetailControllerProvider(widget.taskId).notifier)
                .load(),
          ),
        ),
      ),
      data: (task) {
        final isOverdue = _isEffectiveOverdue(task);
        final controller = ref.read(
          taskDetailControllerProvider(widget.taskId).notifier,
        );
        final allowedTransitions = controller.getAllowedTargetStatuses();
        final canChangeStatus =
            allowedTransitions.isNotEmpty && !state.isChangingStatus;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.taskDetailTitle),
            actions: <Widget>[
              if (canChangeStatus)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.swap_horiz, size: 18),
                    label: Text(l10n.taskChangeStatusButton),
                    onPressed: () => _openStatusTransitionDialog(task),
                  ),
                ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                indicatorColor: colorScheme.primary,
                tabs: <Widget>[
                  Tab(text: l10n.taskTabOverview),
                  Tab(
                    text: '${l10n.taskTabComments} (${task.commentsCount})',
                  ),
                  Tab(
                    text:
                        '${l10n.taskTabAttachments} (${task.attachmentsCount})',
                  ),
                  Tab(text: l10n.taskTabTimeline),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // Tab 1: Overview & Details
              _buildOverviewTab(task, isOverdue),

              // Tab 2: Comments & Add Comment
              _buildCommentsTab(state),

              // Tab 3: Attachments
              _buildAttachmentsTab(state),

              // Tab 4: Activity Audit Timeline
              _buildTimelineTab(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverviewTab(TaskItemModel task, bool isOverdue) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: <Widget>[
        // Overdue Warning Banner
        if (isOverdue) ...<Widget>[
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colorScheme.error),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.onErrorContainer,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.taskOverdueBannerMessage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // Status & Priority Badges
        Row(
          children: <Widget>[
            StatusChip(
              label: task.status.label,
              hexColor: task.status.color,
            ),
            const SizedBox(width: AppSpacing.sm),
            StatusChip(
              label: task.priority.label,
              hexColor: task.priority.color,
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Title
        SelectableText(
          task.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Description
        if (task.description != null &&
            task.description!.trim().isNotEmpty) ...<Widget>[
          Text(
            l10n.taskDescriptionLabel,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SelectableText(
            task.description!.trim(),
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Metadata Card: Project, Client, Department
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            side: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: <Widget>[
                if (task.projectName != null)
                  _DetailMetaRow(
                    icon: Icons.folder_outlined,
                    label: l10n.taskProjectLabel,
                    value: task.projectName!,
                  ),
                if (task.clientName != null) ...<Widget>[
                  const Divider(),
                  _DetailMetaRow(
                    icon: Icons.business_outlined,
                    label: l10n.taskClientLabel,
                    value: task.clientName!,
                  ),
                ],
                if (task.departmentName != null) ...<Widget>[
                  const Divider(),
                  _DetailMetaRow(
                    icon: Icons.domain_outlined,
                    label: l10n.taskDepartmentLabel,
                    value: task.departmentName!,
                  ),
                ],
                const Divider(),
                _DetailMetaRow(
                  icon: Icons.event_outlined,
                  label: l10n.taskDueDateLabel,
                  value: task.dueAt != null
                      ? DateFormat(
                          'EEEE, d MMMM y',
                        ).format(task.dueAt!.toLocal())
                      : l10n.taskNoDueDate,
                ),
                // Server-Stampted Completed Timestamp (client never sets locally)
                if (task.completedAt != null) ...<Widget>[
                  const Divider(),
                  _DetailMetaRow(
                    icon: Icons.check_circle_outline,
                    label: l10n.taskCompletedDateLabel,
                    value: DateFormat(
                      'EEEE, d MMMM y, h:mm a',
                    ).format(task.completedAt!.toLocal()),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Assigner Info
        Text(
          l10n.taskAssignerLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: AvatarWithInitials(
            name: task.assigner.fullName,
            imageUrl: task.assigner.avatarUrl,
          ),
          title: Text(task.assigner.fullName),
          subtitle: Text(
            '${task.assigner.employeeCode} • ${task.assigner.email}',
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Assignees Info
        Text(
          l10n.taskAssigneesLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (task.assignees.isEmpty) ...<Widget>[
          Text(
            l10n.taskNoAssignees,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ] else ...<Widget>[
          for (final a in task.assignees)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: AvatarWithInitials(
                name: a.fullName,
                imageUrl: a.avatarUrl,
              ),
              title: Text(a.fullName),
              subtitle: Text('${a.employeeCode} • ${a.email}'),
            ),
        ],
      ],
    );
  }

  Widget _buildCommentsTab(TaskDetailState state) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: <Widget>[
        // Comments List
        Expanded(
          child: state.comments.isEmpty
              ? Center(
                  child: Text(
                    l10n.taskNoCommentsYet,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return TaskCommentTile(comment: state.comments[index]);
                  },
                ),
        ),

        // Sticky Comment Input Bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentInputController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: l10n.taskAddCommentPlaceholder,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  icon: state.isPostingComment
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send),
                  tooltip: l10n.taskSendCommentTooltip,
                  onPressed: state.isPostingComment ? null : _handlePostComment,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentsTab(TaskDetailState state) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: <Widget>[
        // Add Attachment Action Bar
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              Text(
                '${state.attachments.length} ${l10n.taskTabAttachments}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                icon: const Icon(Icons.upload_file, size: 18),
                label: Text(l10n.taskUploadAttachmentButton),
                onPressed: state.isUploadingAttachment
                    ? null
                    : _openAttachmentPicker,
              ),
            ],
          ),
        ),

        // Upload progress indicator if active
        if (state.isUploadingAttachment) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LinearProgressIndicator(value: state.uploadProgress),
                const SizedBox(height: 4),
                Text(
                  l10n.taskUploadingAttachmentProgress,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ],

        // Attachments List
        Expanded(
          child: state.attachments.isEmpty
              ? Center(
                  child: Text(
                    l10n.taskNoAttachmentsYet,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  itemCount: state.attachments.length,
                  itemBuilder: (context, index) {
                    return TaskAttachmentTile(
                      attachment: state.attachments[index],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTimelineTab(TaskDetailState state) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (state.timeline.isEmpty) {
      return Center(
        child: Text(
          l10n.taskNoTimelineYet,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.timeline.length,
      itemBuilder: (context, index) {
        final activity = state.timeline[index];
        final isLast = index == state.timeline.length - 1;
        return TaskActivityTile(
          activity: activity,
          isLast: isLast,
        );
      },
    );
  }
}

class _DetailMetaRow extends StatelessWidget {
  const _DetailMetaRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
