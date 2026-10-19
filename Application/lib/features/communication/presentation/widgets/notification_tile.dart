import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';

/// List tile representing an in-app notification item in the inbox.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final NotificationItemModel notification;
  final VoidCallback onTap;

  IconData _resolveIcon(String type) {
    final normalized = type.toLowerCase();
    if (normalized.contains('task')) {
      return Icons.task_alt;
    }
    if (normalized.contains('leave') ||
        normalized.contains('holiday') ||
        normalized.contains('attendance')) {
      return Icons.event_note;
    }
    if (normalized.contains('announcement')) {
      return Icons.campaign;
    }
    return Icons.notifications_none_outlined;
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    }
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }
    if (difference.inDays == 1) {
      return 'Yesterday';
    }
    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }
    return DateFormat('MMM d, y').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = !notification.isRead;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xxs,
      ),
      elevation: isUnread ? 1.0 : 0.0,
      color: isUnread
          ? colorScheme.primaryContainer.withValues(alpha: 0.25)
          : colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isUnread
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Icon avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: isUnread
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                foregroundColor: isUnread
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                child: Icon(_resolveIcon(notification.type), size: 20),
              ),
              const SizedBox(width: AppSpacing.md),

              // Title, body and timestamp
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: isUnread
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          _formatRelativeTime(notification.createdAt),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      notification.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isUnread
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              if (isUnread) ...<Widget>[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
