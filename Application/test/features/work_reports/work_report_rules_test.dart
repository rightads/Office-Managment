import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';

void main() {
  group('WorkReportRules Tests', () {
    const defaultRules = WorkReportRules(
      maxMinutesPerDay: 960, // 16 hours
      editableWindowDays: 7,
      allowEditUntilReviewed: false,
    );

    final today = DateTime(2026, 10, 20);

    test(
      'toIsoDate and tryParseIsoDate behave symmetrically and reject invalid',
      () {
        final date = DateTime(2026, 10, 20);
        final iso = WorkReportRules.toIsoDate(date);
        expect(iso, '2026-10-20');

        final parsed = WorkReportRules.tryParseIsoDate('2026-10-20');
        expect(parsed, DateTime(2026, 10, 20));

        expect(WorkReportRules.tryParseIsoDate('not-a-date'), isNull);
        expect(WorkReportRules.tryParseIsoDate('2026-02-31'), isNull);
        expect(WorkReportRules.tryParseIsoDate('2026-13-01'), isNull);
      },
    );

    test('daysBetween correctly handles calendar days', () {
      final d1 = DateTime(2026, 10, 15);
      final d2 = DateTime(2026, 10, 20);
      expect(WorkReportRules.daysBetween(d1, d2), 5);
      expect(WorkReportRules.daysBetween(d2, d1), -5);
      expect(WorkReportRules.daysBetween(d1, d1), 0);
    });

    test('isFutureDate correctly detects future and past dates', () {
      expect(defaultRules.isFutureDate(DateTime(2026, 10, 21), today), isTrue);
      expect(defaultRules.isFutureDate(DateTime(2026, 10, 20), today), isFalse);
      expect(defaultRules.isFutureDate(DateTime(2026, 10, 19), today), isFalse);
    });

    test(
      'isWithinEditableWindow enforces dynamic window and blocks future dates',
      () {
        // Within window (up to 7 days back)
        expect(
          defaultRules.isWithinEditableWindow(DateTime(2026, 10, 20), today),
          isTrue,
        );
        expect(
          defaultRules.isWithinEditableWindow(DateTime(2026, 10, 13), today),
          isTrue,
        );

        // Outside window (8 days back)
        expect(
          defaultRules.isWithinEditableWindow(DateTime(2026, 10, 12), today),
          isFalse,
        );

        // Future dates are never within editable window
        expect(
          defaultRules.isWithinEditableWindow(DateTime(2026, 10, 21), today),
          isFalse,
        );
      },
    );

    test('earliestEditableDate calculates cutoff boundary', () {
      final earliest = defaultRules.earliestEditableDate(today);
      expect(earliest, DateTime(2026, 10, 13));
    });

    group('lockReason and canEdit', () {
      test('locks future dates with futureDate reason', () {
        final future = DateTime(2026, 10, 21);
        expect(
          defaultRules.lockReason(date: future, today: today),
          WorkReportLockReason.futureDate,
        );
        expect(defaultRules.canEdit(date: future, today: today), isFalse);
      });

      test('locks dates outside editable window', () {
        final expired = DateTime(2026, 10, 10);
        expect(
          defaultRules.lockReason(date: expired, today: today),
          WorkReportLockReason.outsideEditableWindow,
        );
        expect(defaultRules.canEdit(date: expired, today: today), isFalse);
      });

      test('locks reviewed reports regardless of date', () {
        expect(
          defaultRules.lockReason(
            date: today,
            today: today,
            existingStatus: WorkReportStatus.reviewed,
          ),
          WorkReportLockReason.reviewed,
        );
        expect(
          defaultRules.canEdit(
            date: today,
            today: today,
            existingStatus: WorkReportStatus.reviewed,
          ),
          isFalse,
        );
      });

      test('locks submitted reports when allowEditUntilReviewed is false', () {
        expect(
          defaultRules.lockReason(
            date: today,
            today: today,
            existingStatus: WorkReportStatus.submitted,
          ),
          WorkReportLockReason.submitted,
        );
        expect(
          defaultRules.canEdit(
            date: today,
            today: today,
            existingStatus: WorkReportStatus.submitted,
          ),
          isFalse,
        );
      });

      test(
        'permits editing submitted reports when allowEditUntilReviewed is true',
        () {
          const permissiveRules = WorkReportRules(
            maxMinutesPerDay: 960,
            editableWindowDays: 7,
            allowEditUntilReviewed: true,
          );
          expect(
            permissiveRules.lockReason(
              date: today,
              today: today,
              existingStatus: WorkReportStatus.submitted,
            ),
            isNull,
          );
          expect(
            permissiveRules.canEdit(
              date: today,
              today: today,
              existingStatus: WorkReportStatus.submitted,
            ),
            isTrue,
          );
        },
      );

      test('permits editing new or draft reports within window', () {
        expect(
          defaultRules.lockReason(
            date: today,
            today: today,
            existingStatus: WorkReportStatus.draft,
          ),
          isNull,
        );
        expect(
          defaultRules.canEdit(
            date: today,
            today: today,
            existingStatus: null,
          ),
          isTrue,
        );
      });
    });

    group('Time budget helpers', () {
      test(
        'exceedsMax and remainingMinutes evaluate against maxMinutesPerDay',
        () {
          expect(defaultRules.exceedsMax(960), isFalse);
          expect(defaultRules.exceedsMax(961), isTrue);
          expect(defaultRules.exceedsMax(500), isFalse);

          expect(defaultRules.remainingMinutes(500), 460);
          expect(defaultRules.remainingMinutes(960), 0);
          expect(defaultRules.remainingMinutes(1000), -40);
        },
      );

      test('usageFraction clamps accurately between 0.0 and 1.0', () {
        expect(defaultRules.usageFraction(0), 0.0);
        expect(defaultRules.usageFraction(480), 0.5);
        expect(defaultRules.usageFraction(960), 1.0);
        expect(defaultRules.usageFraction(1500), 1.0);
      });

      test('splitDuration divides total minutes into hours and minutes', () {
        final d1 = WorkReportRules.splitDuration(0);
        expect(d1.hours, 0);
        expect(d1.minutes, 0);

        final d2 = WorkReportRules.splitDuration(65);
        expect(d2.hours, 1);
        expect(d2.minutes, 5);

        final d3 = WorkReportRules.splitDuration(480);
        expect(d3.hours, 8);
        expect(d3.minutes, 0);
      });

      test('parseReminderTime parses HH:mm and rejects malformed formats', () {
        final r1 = WorkReportRules.parseReminderTime('18:30');
        expect(r1, isNotNull);
        expect(r1?.hour, 18);
        expect(r1?.minute, 30);

        final r2 = WorkReportRules.parseReminderTime('09:05:00');
        expect(r2, isNotNull);
        expect(r2?.hour, 9);
        expect(r2?.minute, 5);

        expect(WorkReportRules.parseReminderTime('25:00'), isNull);
        expect(WorkReportRules.parseReminderTime('12:65'), isNull);
        expect(WorkReportRules.parseReminderTime('invalid'), isNull);
        expect(WorkReportRules.parseReminderTime(''), isNull);
      });
    });

    test(
      'fromConfig reads runtime app config properties with zero hardcoding',
      () {
        const config = RuntimeAppConfig(
          workReportMaxMinutesPerDay: 480,
          workReportEditableWindowDays: 14,
          workReportAllowEditUntilReviewed: true,
        );
        final rules = WorkReportRules.fromConfig(config);
        expect(rules.maxMinutesPerDay, 480);
        expect(rules.editableWindowDays, 14);
        expect(rules.allowEditUntilReviewed, isTrue);
      },
    );
  });
}
