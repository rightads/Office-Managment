import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/notifications/notification_payload_parser.dart';
import 'package:right_ads/core/router/route_paths.dart';

void main() {
  group('NotificationPayloadParser Tests', () {
    test(
      'resolves null or empty data to fallback notification inbox route',
      () {
        expect(
          NotificationPayloadParser.parse(null).targetPath,
          RoutePaths.notifications,
        );
        expect(
          NotificationPayloadParser.parse(<String, dynamic>{}).targetPath,
          RoutePaths.notifications,
        );
      },
    );

    test('respects direct route or path override when provided', () {
      final res1 = NotificationPayloadParser.parse({
        'route': '/custom/deep/link',
        'type': 'custom',
      });
      expect(res1.targetPath, '/custom/deep/link');

      final res2 = NotificationPayloadParser.parse({
        'path': '/profile',
      });
      expect(res2.targetPath, '/profile');
    });

    test(
      'resolves task types to task detail route when entity ID is present',
      () {
        final res = NotificationPayloadParser.parse({
          'type': 'task_assigned',
          'id': '123e4567-e89b-12d3-a456-426614174000',
        });
        expect(
          res.targetPath,
          '${RoutePaths.tasks}/123e4567-e89b-12d3-a456-426614174000',
        );
        expect(res.entityId, '123e4567-e89b-12d3-a456-426614174000');
      },
    );

    test('resolves task types without entity ID to tasks list route', () {
      final res = NotificationPayloadParser.parse({
        'type': 'TASK_REMINDER',
      });
      expect(res.targetPath, RoutePaths.tasks);
    });

    test(
      'resolves leave types to leave detail route when leave ID is present',
      () {
        final res = NotificationPayloadParser.parse({
          'type': 'leave_approved',
          'leave_id': 'leave-uuid-999',
        });
        expect(res.targetPath, '${RoutePaths.leaves}/leave-uuid-999');
      },
    );

    test('resolves leave types without ID to leaves list route', () {
      final res = NotificationPayloadParser.parse({
        'type': 'HOLIDAY_ANNOUNCEMENT',
      });
      expect(res.targetPath, RoutePaths.leaves);
    });

    test('resolves announcement types to announcement detail route', () {
      final res = NotificationPayloadParser.parse({
        'type': 'announcement_new',
        'announcement_id': 'ann-uuid-888',
      });
      expect(res.targetPath, '${RoutePaths.announcements}/ann-uuid-888');
    });

    test(
      'resolves announcement types without ID to announcements list route',
      () {
        final res = NotificationPayloadParser.parse({
          'type': 'ANNOUNCEMENT',
        });
        expect(res.targetPath, RoutePaths.announcements);
      },
    );

    test(
      'resolves unknown notification types to notifications inbox route',
      () {
        final res = NotificationPayloadParser.parse({
          'type': 'unknown_system_event',
          'id': 'some-id',
        });
        expect(res.targetPath, RoutePaths.notifications);
      },
    );
  });
}
