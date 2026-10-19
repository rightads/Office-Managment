import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Strongly-typed Android Notification Channel Configuration.
///
/// Avoids scattered string literals across the codebase and centralizes all
/// Android channel identifiers, display names, descriptions, and importance levels.
class NotificationChannelConfig {
  const NotificationChannelConfig({
    required this.id,
    required this.name,
    required this.description,
    this.importance = Importance.high,
    this.playSound = true,
    this.enableVibration = true,
    this.showBadge = true,
  });

  final String id;
  final String name;
  final String description;
  final Importance importance;
  final bool playSound;
  final bool enableVibration;
  final bool showBadge;

  /// Default notification channel for general updates.
  static const NotificationChannelConfig general = NotificationChannelConfig(
    id: 'right_ads_general',
    name: 'General Notifications',
    description: 'General system announcements, alerts, and account activity.',
  );

  /// Channel for task assignment, status updates, and comments.
  static const NotificationChannelConfig tasks = NotificationChannelConfig(
    id: 'right_ads_tasks',
    name: 'Tasks & Workflow',
    description:
        'Task assignments, status transitions, comments, and reminders.',
  );

  /// Channel for leave applications, approvals, and attendance notices.
  static const NotificationChannelConfig leaves = NotificationChannelConfig(
    id: 'right_ads_leaves',
    name: 'Leaves & Attendance',
    description:
        'Leave approvals, rejections, cancellation notices, and holiday alerts.',
  );

  /// Channel for company and department announcements.
  static const NotificationChannelConfig announcements =
      NotificationChannelConfig(
        id: 'right_ads_announcements',
        name: 'Announcements',
        description:
            'Company-wide and department bulletin board announcements.',
      );

  /// All Android notification channels to initialize at app startup.
  static const List<NotificationChannelConfig> allChannels =
      <NotificationChannelConfig>[
        general,
        tasks,
        leaves,
        announcements,
      ];

  /// Resolves the best matching channel based on notification type or channel ID.
  static NotificationChannelConfig resolve(String? typeOrChannel) {
    if (typeOrChannel == null) return general;
    final normalized = typeOrChannel.toLowerCase().trim();

    if (normalized.contains('task')) {
      return tasks;
    }
    if (normalized.contains('leave') ||
        normalized.contains('holiday') ||
        normalized.contains('attendance')) {
      return leaves;
    }
    if (normalized.contains('announcement')) {
      return announcements;
    }
    for (final channel in allChannels) {
      if (channel.id == normalized) {
        return channel;
      }
    }
    return general;
  }

  /// Converts this configuration to an Android Notification Channel.
  AndroidNotificationChannel toAndroidNotificationChannel() {
    return AndroidNotificationChannel(
      id,
      name,
      description: description,
      importance: importance,
      playSound: playSound,
      enableVibration: enableVibration,
      showBadge: showBadge,
    );
  }
}
