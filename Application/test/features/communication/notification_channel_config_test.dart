import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/notifications/notification_channel_config.dart';

void main() {
  group('NotificationChannelConfig Tests', () {
    test('allChannels contains all defined structured channels', () {
      expect(NotificationChannelConfig.allChannels.length, 4);
      expect(
        NotificationChannelConfig.allChannels,
        containsAll(<NotificationChannelConfig>[
          NotificationChannelConfig.general,
          NotificationChannelConfig.tasks,
          NotificationChannelConfig.leaves,
          NotificationChannelConfig.announcements,
        ]),
      );
    });

    test('resolve correctly maps channel types to config', () {
      expect(
        NotificationChannelConfig.resolve('task_assigned'),
        NotificationChannelConfig.tasks,
      );
      expect(
        NotificationChannelConfig.resolve('TASK_COMMENT'),
        NotificationChannelConfig.tasks,
      );
      expect(
        NotificationChannelConfig.resolve('leave_approved'),
        NotificationChannelConfig.leaves,
      );
      expect(
        NotificationChannelConfig.resolve('holiday_notice'),
        NotificationChannelConfig.leaves,
      );
      expect(
        NotificationChannelConfig.resolve('attendance_alert'),
        NotificationChannelConfig.leaves,
      );
      expect(
        NotificationChannelConfig.resolve('announcement_bulletin'),
        NotificationChannelConfig.announcements,
      );
      expect(
        NotificationChannelConfig.resolve(null),
        NotificationChannelConfig.general,
      );
      expect(
        NotificationChannelConfig.resolve('random_unknown_type'),
        NotificationChannelConfig.general,
      );
    });

    test('toAndroidNotificationChannel creates valid Android channel', () {
      final channel = NotificationChannelConfig.tasks
          .toAndroidNotificationChannel();
      expect(channel.id, 'right_ads_tasks');
      expect(channel.name, 'Tasks & Workflow');
      expect(channel.importance, Importance.high);
      expect(channel.playSound, isTrue);
      expect(channel.enableVibration, isTrue);
    });
  });
}
