import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

/// Renders a single audit activity history event in the task timeline.
class TaskActivityTile extends StatelessWidget {
  const TaskActivityTile({
    required this.activity,
    this.isLast = false,
    super.key,
  });

  final TaskActivityModel activity;
  final bool isLast;

  String _formatActionDescription() {
    final details = activity.details;
    final action = activity.action.toUpperCase();

    if (action.contains('STATUS') || action.contains('TRANSITION')) {
      final from = details['from_status'] ?? details['old_status'];
      final to = details['to_status'] ?? details['new_status'];
      final remarks = details['remarks'];
      final base = (from != null && to != null)
          ? 'Changed status from $from to $to'
          : 'Updated task status';
      return remarks != null ? '$base ("$remarks")' : base;
    }

    if (action.contains('ASSIGN')) {
      final assignees = details['assignees'] ?? details['new_assignees'];
      if (assignees is List) {
        return 'Updated assignees (${assignees.length} assigned)';
      }
      return 'Assigned task';
    }

    if (action.contains('COMMENT')) {
      return 'Posted a comment';
    }

    if (action.contains('ATTACHMENT')) {
      final filename = details['file_name'] ?? 'file';
      return 'Uploaded attachment: $filename';
    }

    if (action.contains('CREATE')) {
      return 'Created this task';
    }

    return activity.action;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formattedTime = DateFormat(
      'd MMM y, h:mm a',
    ).format(activity.createdAt.toLocal());

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Timeline indicator line + Avatar
          Column(
            children: <Widget>[
              AvatarWithInitials(
                name: activity.actor.fullName,
                imageUrl: activity.actor.avatarUrl,
                size: 28,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          activity.actor.fullName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatActionDescription(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
