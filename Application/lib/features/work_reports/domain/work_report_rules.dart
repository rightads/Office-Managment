import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';

/// Why a report cannot currently be edited (drives the read-only banner).
enum WorkReportLockReason {
  futureDate,
  outsideEditableWindow,
  submitted,
  reviewed,
}

/// Pure business rules for daily work reports.
///
/// Every limit is injected from the server (`/app/config`) via
/// [WorkReportRules.fromConfig]; nothing here is hardcoded.
class WorkReportRules {
  const WorkReportRules({
    required this.maxMinutesPerDay,
    required this.editableWindowDays,
    required this.allowEditUntilReviewed,
  });

  factory WorkReportRules.fromConfig(RuntimeAppConfig config) {
    return WorkReportRules(
      maxMinutesPerDay: config.workReportMaxMinutesPerDay,
      editableWindowDays: config.workReportEditableWindowDays,
      allowEditUntilReviewed: config.workReportAllowEditUntilReviewed,
    );
  }

  final int maxMinutesPerDay;
  final int editableWindowDays;
  final bool allowEditUntilReviewed;

  /// Strips the time component, keeping the calendar date.
  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  /// Formats a calendar date as the API's `yyyy-MM-dd`.
  static String toIsoDate(DateTime value) {
    final d = dateOnly(value);
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '${d.year.toString().padLeft(4, '0')}-$mm-$dd';
  }

  /// Parses an API `yyyy-MM-dd` date; returns `null` when malformed.
  static DateTime? tryParseIsoDate(String raw) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(raw.trim());
    if (match == null) return null;
    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);
    final parsed = DateTime(year, month, day);
    // Reject overflow such as 2026-02-31 which DateTime silently normalizes.
    if (parsed.year != year || parsed.month != month || parsed.day != day) {
      return null;
    }
    return parsed;
  }

  /// Whole calendar days from [from] to [to] (DST-safe).
  static int daysBetween(DateTime from, DateTime to) {
    final a = DateTime.utc(from.year, from.month, from.day);
    final b = DateTime.utc(to.year, to.month, to.day);
    return b.difference(a).inDays;
  }

  bool isFutureDate(DateTime date, DateTime today) =>
      daysBetween(today, date) > 0;

  bool isWithinEditableWindow(DateTime date, DateTime today) {
    if (isFutureDate(date, today)) return false;
    return daysBetween(date, today) <= editableWindowDays;
  }

  /// Oldest report date that can still be created/edited.
  DateTime earliestEditableDate(DateTime today) {
    final t = dateOnly(today);
    return DateTime(t.year, t.month, t.day - editableWindowDays);
  }

  /// Returns the reason editing is blocked, or `null` when editing is allowed.
  ///
  /// [existingStatus] is `null` when no report exists yet for [date].
  WorkReportLockReason? lockReason({
    required DateTime date,
    required DateTime today,
    String? existingStatus,
  }) {
    if (isFutureDate(date, today)) return WorkReportLockReason.futureDate;
    if (!isWithinEditableWindow(date, today)) {
      return WorkReportLockReason.outsideEditableWindow;
    }
    if (existingStatus == WorkReportStatus.reviewed) {
      return WorkReportLockReason.reviewed;
    }
    if (existingStatus == WorkReportStatus.submitted &&
        !allowEditUntilReviewed) {
      return WorkReportLockReason.submitted;
    }
    return null;
  }

  bool canEdit({
    required DateTime date,
    required DateTime today,
    String? existingStatus,
  }) =>
      lockReason(date: date, today: today, existingStatus: existingStatus) ==
      null;

  bool exceedsMax(int totalMinutes) => totalMinutes > maxMinutesPerDay;

  /// Minutes still available today (negative when over the limit).
  int remainingMinutes(int totalMinutes) => maxMinutesPerDay - totalMinutes;

  /// Progress of [totalMinutes] against the daily maximum, clamped to 0..1.
  double usageFraction(int totalMinutes) {
    if (maxMinutesPerDay <= 0) return 0;
    return (totalMinutes / maxMinutesPerDay).clamp(0.0, 1.0);
  }

  /// Splits [minutes] into whole hours and leftover minutes.
  static ({int hours, int minutes}) splitDuration(int minutes) {
    final safe = minutes < 0 ? 0 : minutes;
    return (hours: safe ~/ 60, minutes: safe % 60);
  }

  /// Parses the server's `HH:mm` (or `HH:mm:ss`) reminder time.
  ///
  /// Returns `null` for malformed or out-of-range values so callers can skip
  /// scheduling instead of guessing a time.
  static ({int hour, int minute})? parseReminderTime(String raw) {
    final match = RegExp(
      r'^(\d{1,2}):(\d{2})(?::\d{2})?$',
    ).firstMatch(raw.trim());
    if (match == null) return null;
    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    if (hour > 23 || minute > 59) return null;
    return (hour: hour, minute: minute);
  }
}
