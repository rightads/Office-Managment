import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/utils/app_formatters.dart';

void main() {
  group('AppFormatters', () {
    test('converts UTC timestamp to Asia/Kolkata (+05:30) accurately', () {
      final formatters = AppFormatters(
        timezoneName: 'Asia/Kolkata',
        localeCode: 'en_IN',
        currencyCode: 'INR',
      );

      // 2026-10-18 14:00:00 UTC -> 2026-10-18 19:30:00 IST
      final utcTime = DateTime.utc(2026, 10, 18, 14);
      final display = formatters.toDisplayDateTime(utcTime);

      expect(display.year, 2026);
      expect(display.month, 10);
      expect(display.day, 18);
      expect(display.hour, 19);
      expect(display.minute, 30);
      expect(formatters.formatDate(utcTime), '18 Oct 2026');
    });

    test('falls back safely to UTC when timezone identifier is unknown', () {
      final formatters = AppFormatters(
        timezoneName: 'Invalid/Timezone',
        localeCode: 'en_US',
        currencyCode: 'USD',
      );

      final utcTime = DateTime.utc(2026, 10, 18, 14, 15);
      final display = formatters.toDisplayDateTime(utcTime);

      expect(display.hour, 14);
      expect(display.minute, 15);
    });

    test(
      'formats date ranges, numbers, and currencies according to config',
      () {
        final formatters = AppFormatters(
          timezoneName: 'UTC',
          localeCode: 'en_US',
          currencyCode: 'USD',
        );

        final range = DateTimeRange(
          start: DateTime.utc(2026),
          end: DateTime.utc(2026, 1, 15),
        );

        expect(formatters.formatDateRange(range), '01 Jan 2026 - 15 Jan 2026');
        expect(formatters.formatNumber(1234567), '1,234,567');
        expect(formatters.formatCurrency(2500.5), r'$2,500.50');
      },
    );
  });
}
