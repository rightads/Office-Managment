import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/status_chip.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

/// Card rendering an employee task summary with dynamic status and priority chips,
/// overdue alerts, assignee avatars, and project/client context.
class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    required this.task,
    required this.onTap,
    super.key,
  });

  final TaskItemModel task;
  final VoidCallback onTap;

  bool get _isEffectiveOverdue {
    if (task.isOverdue) return true;
    if (task.status.isTerminal) return false;
    final due = task.dueAt;
    if (due == null) return false;
    return due.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isOverdue = _isEffectiveOverdue;

    final semanticLabel =
        '${task.title}, ${task.status.label}, ${task.priority.label}';

    return Semantics(
      container: true,
      button: true,
      label: semanticLabel,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(
            color: isOverdue
                ? colorScheme.error.withValues(alpha: 0.8)
                : colorScheme.outlineVariant.withValues(alpha: 0.6),
            width: isOverdue ? 1.5 : 1.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header row: Status chip, Priority chip, Overdue pill
                Row(
                  children: <Widget>[
                    StatusChip(
                      label: task.status.label,
                      hexColor: task.status.color,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    StatusChip(
                      label: task.priority.label,
                      hexColor: task.priority.color,
                    ),
                    const Spacer(),
                    if (isOverdue) ...<Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(AppRadius.xs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 14,
                              color: colorScheme.onErrorContainer,
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Text(
                              l10n.taskOverdueLabel,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onErrorContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),

                // Title
                Text(
                  task.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Description preview if available
                if (task.description != null &&
                    task.description!.trim().isNotEmpty) ...<Widget>[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    task.description!.trim(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                const SizedBox(height: AppSpacing.sm),

                // Context Tags: Project / Client / Department
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xxs,
                  children: <Widget>[
                    if (task.projectName != null &&
                        task.projectName!.isNotEmpty)
                      _ContextTag(
                        icon: Icons.folder_outlined,
                        label: task.projectName!,
                      ),
                    if (task.clientName != null && task.clientName!.isNotEmpty)
                      _ContextTag(
                        icon: Icons.business_outlined,
                        label: task.clientName!,
                      ),
                    if (task.departmentName != null &&
                        task.departmentName!.isNotEmpty)
                      _ContextTag(
                        icon: Icons.domain_outlined,
                        label: task.departmentName!,
                      ),
                  ],
                ),

                const Divider(height: AppSpacing.lg),

                // Footer row: Assignees, Due Date, Comments/Attachments counters
                Row(
                  children: <Widget>[
                    // Assignees avatars stack
                    if (task.assignees.isNotEmpty) ...<Widget>[
                      _AssigneesAvatarStack(assignees: task.assignees),
                      const SizedBox(width: AppSpacing.sm),
                    ],

                    // Due date
                    if (task.dueAt != null) ...<Widget>[
                      Icon(
                        Icons.event_outlined,
                        size: 14,
                        color: isOverdue
                            ? colorScheme.error
                            : colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Text(
                        DateFormat('d MMM y').format(task.dueAt!.toLocal()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isOverdue
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isOverdue
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],

                    const Spacer(),

                    // Attachments counter
                    if (task.attachmentsCount > 0) ...<Widget>[
                      Icon(
                        Icons.attach_file,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${task.attachmentsCount}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],

                    // Comments counter
                    if (task.commentsCount > 0) ...<Widget>[
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${task.commentsCount}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContextTag extends StatelessWidget {
  const _ContextTag({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 12,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.xxs),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssigneesAvatarStack extends StatelessWidget {
  const _AssigneesAvatarStack({required this.assignees});

  final List<UserBriefModel> assignees;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final displayed = assignees.take(3).toList();
    final remaining = assignees.length - displayed.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < displayed.length; i++)
          Align(
            widthFactor: 0.75,
            child: AvatarWithInitials(
              name: displayed[i].fullName,
              imageUrl: displayed[i].avatarUrl,
              size: 24,
            ),
          ),
        if (remaining > 0)
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.xs),
            child: Text(
              l10n.taskRemainingAssigneesCount(remaining),
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
