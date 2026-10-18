import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/core/services/location_service.dart';
import 'package:right_ads/features/attendance/application/attendance_controller.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';
import 'package:right_ads/features/attendance/presentation/attendance_screen.dart';

class _FakeTodayAttendanceController extends TodayAttendanceController {
  _FakeTodayAttendanceController(this._initialState);

  final TodayAttendanceState _initialState;

  @override
  TodayAttendanceState build() => _initialState;

  @override
  Future<void> loadTodayAndPolicy({bool silent = false}) async {}

  @override
  Future<LocationAcquisitionResult> refreshLocation({
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
  }) async {
    return _initialState.locationResult ??
        const LocationSuccess(
          latitude: 19.0760,
          longitude: 72.8777,
          accuracyMeters: 10,
          isMockLocation: false,
        );
  }
}

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  _FakeRuntimeAppConfigController(this._config);

  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;
}

void main() {
  const testAppConfig = AppConfig(
    environment: AppEnvironment.dev,
    apiBaseUrl: 'http://localhost:8000/api/v1',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    sendTimeout: Duration(seconds: 5),
  );

  const sampleOffice = OfficeLocationModel(
    id: 'office-1',
    name: 'Right Ads Mumbai HQ',
    latitude: 19.0760,
    longitude: 72.8777,
    radiusMeters: 150,
  );

  const samplePolicy = EffectiveAttendancePolicyModel(
    id: 'policy-1',
    name: 'Creative Agency Shift',
    graceMinutes: 10,
    allowedLocations: <OfficeLocationModel>[sampleOffice],
  );

  final checkedInTodayRecord = AttendanceRecordModel(
    id: 'rec-today-1',
    employeeId: 'emp-1',
    attendanceDate: '2026-10-18',
    checkInAt: DateTime.utc(2026, 10, 18, 4),
    status: 'LATE',
    statusLabel: 'Late Arrival (Server)',
    statusColor: '#D97706',
    remarks: 'Traffic delay at Worli',
  );

  final sampleMonthlyData = MonthlyAttendanceData(
    year: 2026,
    month: 10,
    calendar: AttendanceCalendarModel(
      year: 2026,
      month: 10,
      totalWorkingDays: 22,
      totalPresentDays: 18,
      totalAbsentDays: 1,
      totalHalfDays: 1,
      totalLeaveDays: 2,
      totalHolidays: 1,
      days: <AttendanceCalendarDayModel>[
        AttendanceCalendarDayModel(
          date: '2026-10-01',
          status: 'PRESENT',
          statusLabel: 'On Time',
          statusColor: '#16A34A',
          checkInAt: DateTime.utc(2026, 10, 1, 3, 55),
          checkOutAt: DateTime.utc(2026, 10, 1, 13, 5),
          workHours: 9.17,
        ),
        const AttendanceCalendarDayModel(
          date: '2026-10-02',
          status: 'HOLIDAY',
          statusLabel: 'Public Holiday',
          statusColor: '#2563EB',
          holidayName: 'Gandhi Jayanti',
        ),
      ],
    ),
    monthlyReport: EmployeeMonthlyReportModel(
      employeeId: 'emp-1',
      employeeCode: 'EMP-001',
      fullName: 'Aarav Sharma',
      year: 2026,
      month: 10,
      workingDays: 22,
      presentDays: 18,
      lateDays: 2,
      halfDays: 1,
      absentDays: 1,
      leaveDays: 2,
      holidayDays: 1,
      weekOffDays: 4,
      totalHoursWorked: 158.5,
      averageHoursPerDay: 8.8,
      attendancePercentage: 84.1,
      dailyRecords: <DailyAttendanceRecordModel>[
        DailyAttendanceRecordModel(
          date: '2026-10-01',
          status: 'PRESENT',
          statusLabel: 'On Time',
          statusColor: '#16A34A',
          checkInAt: DateTime.utc(2026, 10, 1, 3, 55),
          checkOutAt: DateTime.utc(2026, 10, 1, 13, 5),
          workHours: 9.17,
          correctionApplied: true,
          remarks: 'Approved shift adjustment',
        ),
        const DailyAttendanceRecordModel(
          date: '2026-10-02',
          status: 'HOLIDAY',
          statusLabel: 'Public Holiday',
          statusColor: '#2563EB',
          holidayName: 'Gandhi Jayanti',
        ),
      ],
    ),
  );

  const sampleYearlyReport = EmployeeYearlyReportModel(
    employeeId: 'emp-1',
    employeeCode: 'EMP-001',
    fullName: 'Aarav Sharma',
    year: 2026,
    annualWorkingDays: 250,
    annualPresentDays: 228,
    annualAbsentDays: 4,
    annualLeaveDays: 14,
    annualTotalHours: 1840,
    annualAttendancePercentage: 91.2,
    months: <MonthSummaryItemModel>[
      MonthSummaryItemModel(
        month: 10,
        monthName: 'October',
        workingDays: 22,
        presentDays: 18,
        lateDays: 2,
        halfDays: 1,
        absentDays: 1,
        leaveDays: 2,
        holidayDays: 1,
        totalHoursWorked: 158.5,
        attendancePercentage: 84.1,
      ),
    ],
  );

  Widget buildTestApp({
    required TodayAttendanceState todayState,
    AttendanceViewTab initialTab = AttendanceViewTab.today,
  }) {
    return ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(testAppConfig),
        runtimeAppConfigControllerProvider.overrideWith(
          () => _FakeRuntimeAppConfigController(const RuntimeAppConfig()),
        ),
        todayAttendanceControllerProvider.overrideWith(
          () => _FakeTodayAttendanceController(todayState),
        ),
        monthlyAttendanceProvider(month: 10, year: 2026).overrideWith(
          (ref) async => sampleMonthlyData,
        ),
        yearlyAttendanceProvider(year: 2026).overrideWith(
          (ref) async => sampleYearlyReport,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: AttendanceScreen(
            initialTab: initialTab,
            enableLiveTimer: false,
          ),
        ),
      ),
    );
  }

  group('AttendanceScreen Widget Tests', () {
    testWidgets(
      'renders Today card with server status_label, policy details, geofence distance, and Check Out CTA when checked in',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(600, 960));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        final state = TodayAttendanceState(
          isLoading: false,
          policy: samplePolicy,
          todayRecord: checkedInTodayRecord,
          locationResult: const LocationSuccess(
            latitude: 19.0761,
            longitude: 72.8778,
            accuracyMeters: 8,
            isMockLocation: false,
          ),
          geofenceEvaluation: const GeofenceEvaluation(
            isWithinGeofence: true,
            nearestOffice: sampleOffice,
            distanceMeters: 24,
          ),
        );

        await tester.pumpWidget(buildTestApp(todayState: state));
        await tester.pumpAndSettle();

        // Verifies server-provided status_label is rendered verbatim
        expect(find.text('Late Arrival (Server)'), findsOneWidget);
        // Verifies effective attendance policy name & shift window
        expect(find.text('Creative Agency Shift'), findsOneWidget);
        expect(find.text('09:30:00 – 18:30:00'), findsOneWidget);
        expect(find.text('Office Geofence Required'), findsOneWidget);
        // Verifies distance in meters to nearest allowed office
        expect(
          find.textContaining('24 m from Right Ads Mumbai HQ'),
          findsOneWidget,
        );
        // Verifies Check Out button is shown when checked in
        expect(
          find.byKey(const Key('attendance_check_out_cta')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders Monthly Calendar day cells from API and opens Day Detail sheet on tap',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(600, 960));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        const state = TodayAttendanceState(
          isLoading: false,
          policy: samplePolicy,
        );

        await tester.pumpWidget(
          buildTestApp(
            todayState: state,
            initialTab: AttendanceViewTab.monthly,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('On Time'), findsOneWidget);
        expect(find.text('Public Holiday'), findsOneWidget);

        // Tap day 2026-10-01 to open AttendanceDayDetailSheet
        await tester.tap(find.byKey(const Key('calendar_day_2026-10-01')));
        await tester.pumpAndSettle();

        expect(
          find.text('Attendance Details — 2026-10-01'),
          findsOneWidget,
        );
        expect(find.text('Correction Applied'), findsOneWidget);
        expect(find.text('Approved shift adjustment'), findsOneWidget);
      },
    );

    testWidgets(
      'renders Yearly Summary breakdown and jumps to Monthly Calendar when a month is tapped',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(600, 960));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        const state = TodayAttendanceState(
          isLoading: false,
          policy: samplePolicy,
        );

        await tester.pumpWidget(
          buildTestApp(
            todayState: state,
            initialTab: AttendanceViewTab.yearly,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Annual Overview (2026)'), findsOneWidget);
        expect(find.text('October'), findsOneWidget);
        expect(find.text('91.2%'), findsOneWidget);

        await tester.tap(find.byKey(const Key('yearly_month_row_10')));
        await tester.pumpAndSettle();

        // Switched to Monthly Calendar tab for October 2026
        expect(find.text('October 2026'), findsOneWidget);
      },
    );
  });
}
