import 'package:right_ads/core/router/route_paths.dart';

/// Resolved deep link destination from a push notification payload.
class NotificationDeepLink {
  const NotificationDeepLink({
    required this.targetPath,
    this.type,
    this.entityId,
  });

  final String targetPath;
  final String? type;
  final String? entityId;

  /// Default fallback destination when payload is unknown or invalid.
  static const NotificationDeepLink fallback = NotificationDeepLink(
    targetPath: RoutePaths.notifications,
  );
}

/// Centralized parser for incoming FCM or Local Notification `data` payloads.
///
/// Follows Prompt 09 rules:
/// - Resolves entity deep links (`/tasks/:id`, `/leaves/:id`, `/announcements/:id`)
/// - Unknown types open the notification list (`/notifications`).
abstract final class NotificationPayloadParser {
  /// Parses a key-value data map into a [NotificationDeepLink].
  static NotificationDeepLink parse(Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) {
      return NotificationDeepLink.fallback;
    }

    // Direct route override if supplied
    final directRoute = data['route'] as String? ?? data['path'] as String?;
    if (directRoute != null && directRoute.trim().isNotEmpty) {
      return NotificationDeepLink(
        targetPath: directRoute.trim(),
        type: data['type'] as String?,
        entityId: data['id'] as String? ?? data['entity_id'] as String?,
      );
    }

    final rawType = (data['type'] as String?)?.trim().toLowerCase();
    final entityId =
        (data['id'] as String? ??
                data['entity_id'] as String? ??
                data['task_id'] as String? ??
                data['leave_id'] as String? ??
                data['announcement_id'] as String?)
            ?.trim();

    if (rawType == null || rawType.isEmpty) {
      return NotificationDeepLink.fallback;
    }

    if (rawType.contains('task')) {
      if (entityId != null && entityId.isNotEmpty) {
        return NotificationDeepLink(
          targetPath: '${RoutePaths.tasks}/$entityId',
          type: rawType,
          entityId: entityId,
        );
      }
      return const NotificationDeepLink(
        targetPath: RoutePaths.tasks,
        type: 'tasks',
      );
    }

    if (rawType.contains('leave') || rawType.contains('holiday')) {
      if (entityId != null && entityId.isNotEmpty) {
        return NotificationDeepLink(
          targetPath: '${RoutePaths.leaves}/$entityId',
          type: rawType,
          entityId: entityId,
        );
      }
      return const NotificationDeepLink(
        targetPath: RoutePaths.leaves,
        type: 'leaves',
      );
    }

    if (rawType.contains('announcement')) {
      if (entityId != null && entityId.isNotEmpty) {
        return NotificationDeepLink(
          targetPath: '${RoutePaths.announcements}/$entityId',
          type: rawType,
          entityId: entityId,
        );
      }
      return const NotificationDeepLink(
        targetPath: RoutePaths.announcements,
        type: 'announcements',
      );
    }

    // Unknown types fallback to notification list
    return NotificationDeepLink(
      targetPath: RoutePaths.notifications,
      type: rawType,
      entityId: entityId,
    );
  }
}
