import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/notifications/notification_channel_config.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/core/utils/app_logger.dart';
import 'package:right_ads/features/work_reports/application/work_report_controller.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

part 'work_report_reminder_service.g.dart';

/// Service responsible for scheduling or canceling local daily reminders
/// for work report submission based on dynamic runtime config.
class WorkReportReminderService {
  WorkReportReminderService({
    required this.logger,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin();

  final AppLogger logger;
  final FlutterLocalNotificationsPlugin _localNotifications;

  static const int reminderNotificationId = 9101;

  /// Syncs daily reminder: cancels if today's report is already submitted/reviewed,
  /// otherwise schedules a recurring daily notification at [reminderTime].
  Future<void> syncReminder({
    required String reminderTime,
    required tz.Location location,
    required bool isTodaySubmitted,
    String? title,
    String? body,
  }) async {
    if (isTodaySubmitted) {
      await cancelDailyReminder();
      logger.info(
        'Work report for today is submitted; cancelled reminder notification.',
      );
      return;
    }

    await scheduleDailyReminder(
      reminderTime: reminderTime,
      location: location,
      title: title,
      body: body,
    );
  }

  /// Schedules a repeating local daily reminder at [reminderTime] ('HH:mm').
  Future<void> scheduleDailyReminder({
    required String reminderTime,
    required tz.Location location,
    String? title,
    String? body,
  }) async {
    try {
      final parsed = WorkReportRules.parseReminderTime(reminderTime);
      final hour = parsed?.hour ?? 18;
      final minute = parsed?.minute ?? 0;
      final now = tz.TZDateTime.now(location);
      var scheduledDate = tz.TZDateTime(
        location,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      const channel = NotificationChannelConfig.tasks;
      final androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: channel.importance,
        priority: Priority.high,
        playSound: channel.playSound,
        enableVibration: channel.enableVibration,
      );

      const darwinDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
      );

      final payload = jsonEncode({
        'type': 'work_report',
        'route': RoutePaths.workReports,
      });

      await _localNotifications.zonedSchedule(
        id: reminderNotificationId,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        title: title ?? 'Daily Work Report Reminder',
        body: body ?? "Don't forget to submit your daily work report for today!",
        payload: payload,
      );

      logger.info(
        'Daily work report reminder scheduled for $reminderTime (${scheduledDate.toIso8601String()})',
      );
    } on Object catch (e, st) {
      logger.warning(
        'Failed to schedule work report daily reminder: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Cancels the scheduled daily reminder notification.
  Future<void> cancelDailyReminder() async {
    try {
      await _localNotifications.cancel(id: reminderNotificationId);
    } on Object catch (e) {
      logger.warning('Failed to cancel work report reminder notification: $e');
    }
  }
}

@riverpod
WorkReportReminderService workReportReminderService(Ref ref) {
  final logger = ref.watch(appLoggerProvider);
  return WorkReportReminderService(logger: logger);
}

@riverpod
Future<void> workReportReminderSync(Ref ref) async {
  final service = ref.watch(workReportReminderServiceProvider);
  final runtimeConfig = ref.watch(runtimeAppConfigControllerProvider);
  final todayReportAsync = ref.watch(todayWorkReportProvider);
  final formatters = ref.watch(appFormattersProvider);

  final reminderTime = runtimeConfig.workReportReminderTime;
  final location = formatters.location;

  final isSubmitted = todayReportAsync.maybeWhen(
    data: (report) =>
        report != null &&
        (report.status == 'submitted' || report.status == 'reviewed'),
    orElse: () => false,
  );

  await service.syncReminder(
    reminderTime: reminderTime,
    location: location,
    isTodaySubmitted: isSubmitted,
  );
}
