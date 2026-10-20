import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

part 'app_formatters.g.dart';

bool _tzInitialized = false;

void ensureTimeZonesInitialized() {
  if (!_tzInitialized) {
    tz_data.initializeTimeZones();
    _tzInitialized = true;
  }
}

/// Date, time, number, and currency formatting helpers driven by the
/// timezone and locale from [RuntimeAppConfig] (`/app/config`).
///
/// All dates received from the backend API are UTC and are converted to the
/// configured display timezone before rendering.
class AppFormatters {
  AppFormatters({
    required this.timezoneName,
    required this.localeCode,
    required this.currencyCode,
  }) {
    ensureTimeZonesInitialized();
  }

  final String timezoneName;
  final String localeCode;
  final String currencyCode;

  tz.Location get _location {
    if (timezoneName.toUpperCase() == 'UTC') {
      return tz.UTC;
    }
    try {
      return tz.getLocation(timezoneName);
    } on Object {
      return tz.UTC;
    }
  }

  /// The configured display timezone as a `timezone` package location.
  tz.Location get location => _location;

  /// Today's calendar date (time stripped) in the configured display timezone.
  ///
  /// Mirrors the server's `get_local_today()` so client-side date rules
  /// (e.g. blocking future work-report dates) agree with the API.
  DateTime todayDate({DateTime? nowUtc}) {
    final now = tz.TZDateTime.from(
      (nowUtc ?? DateTime.now()).toUtc(),
      _location,
    );
    return DateTime(now.year, now.month, now.day);
  }

  /// Converts a [dateTime] (assumed UTC if not already marked UTC, or converted
  /// via `.toUtc()`) into the configured display timezone.
  tz.TZDateTime toDisplayDateTime(DateTime dateTime) {
    final utc = dateTime.isUtc
        ? dateTime
        : DateTime.utc(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            dateTime.hour,
            dateTime.minute,
            dateTime.second,
            dateTime.millisecond,
            dateTime.microsecond,
          );
    return tz.TZDateTime.from(utc, _location);
  }

  String _formatWithPattern(String pattern, DateTime date) {
    try {
      return DateFormat(pattern, localeCode).format(date);
    } on Object {
      return DateFormat(pattern, 'en_US').format(date);
    }
  }

  String formatDate(DateTime utcDateTime) {
    final display = toDisplayDateTime(utcDateTime);
    return _formatWithPattern('dd MMM yyyy', display);
  }

  String formatTime(DateTime utcDateTime) {
    final display = toDisplayDateTime(utcDateTime);
    return _formatWithPattern('hh:mm a', display);
  }

  String formatDateTime(DateTime utcDateTime) {
    final display = toDisplayDateTime(utcDateTime);
    return _formatWithPattern('dd MMM yyyy, hh:mm a', display);
  }

  String formatDateRange(DateTimeRange range) {
    final startDisplay = toDisplayDateTime(range.start);
    final endDisplay = toDisplayDateTime(range.end);
    return '${_formatWithPattern('dd MMM yyyy', startDisplay)} - ${_formatWithPattern('dd MMM yyyy', endDisplay)}';
  }

  String formatNumber(num value) {
    return NumberFormat.decimalPattern(localeCode).format(value);
  }

  String formatCompactNumber(num value) {
    return NumberFormat.compact(locale: localeCode).format(value);
  }

  String formatCurrency(num amount, {String? customCurrencyCode}) {
    final code = customCurrencyCode ?? currencyCode;
    return NumberFormat.simpleCurrency(
      locale: localeCode,
      name: code,
    ).format(amount);
  }
}

@riverpod
AppFormatters appFormatters(Ref ref) {
  final runtimeConfig = ref.watch(runtimeAppConfigControllerProvider);
  return AppFormatters(
    timezoneName: runtimeConfig.timezone,
    localeCode: runtimeConfig.localeCode,
    currencyCode: runtimeConfig.currencyCode,
  );
}
