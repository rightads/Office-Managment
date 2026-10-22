import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/utils/app_logger.dart';
import 'package:right_ads/features/work_reports/application/work_report_reminder_service.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class _FakeLocalNotificationsPlugin implements FlutterLocalNotificationsPlugin {
  int scheduledCalls = 0;
  int cancelledCalls = 0;
  int? lastCancelledId;
  int? lastScheduledId;
  tz.TZDateTime? lastScheduledDate;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<void> zonedSchedule({
    required int id,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails notificationDetails,
    required AndroidScheduleMode androidScheduleMode,
    String? title,
    String? body,
    String? payload,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    scheduledCalls++;
    lastScheduledId = id;
    lastScheduledDate = scheduledDate;
  }

  @override
  Future<void> cancel({required int id, String? tag}) async {
    cancelledCalls++;
    lastCancelledId = id;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  tz_data.initializeTimeZones();

  group('WorkReportReminderService Tests', () {
    late _FakeLocalNotificationsPlugin fakeNotifications;
    late AppLogger logger;
    late WorkReportReminderService service;
    late tz.Location location;

    setUp(() {
      fakeNotifications = _FakeLocalNotificationsPlugin();
      logger = AppLogger();
      service = WorkReportReminderService(
        logger: logger,
        localNotifications: fakeNotifications,
      );
      location = tz.getLocation('Asia/Kolkata');
    });

    test(
      'syncReminder schedules notification when today report is NOT submitted',
      () async {
        await service.syncReminder(
          reminderTime: '18:30',
          location: location,
          isTodaySubmitted: false,
        );

        expect(fakeNotifications.scheduledCalls, 1);
        expect(
          fakeNotifications.lastScheduledId,
          WorkReportReminderService.reminderNotificationId,
        );
        expect(fakeNotifications.lastScheduledDate?.hour, 18);
        expect(fakeNotifications.lastScheduledDate?.minute, 30);
      },
    );

    test(
      'syncReminder cancels notification when today report IS submitted',
      () async {
        await service.syncReminder(
          reminderTime: '18:30',
          location: location,
          isTodaySubmitted: true,
        );

        expect(fakeNotifications.cancelledCalls, 1);
        expect(
          fakeNotifications.lastCancelledId,
          WorkReportReminderService.reminderNotificationId,
        );
        expect(fakeNotifications.scheduledCalls, 0);
      },
    );

    test('cancelDailyReminder calls notifications plugin cancel', () async {
      await service.cancelDailyReminder();

      expect(fakeNotifications.cancelledCalls, 1);
      expect(
        fakeNotifications.lastCancelledId,
        WorkReportReminderService.reminderNotificationId,
      );
    });
  });
}
