import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/network/connectivity_provider.dart';
import 'package:right_ads/core/services/location_service.dart';
import 'package:right_ads/core/storage/device_identity_service.dart';
import 'package:right_ads/features/attendance/application/attendance_controller.dart';
import 'package:right_ads/features/attendance/data/attendance_repository.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';

class _FakeLocationService extends LocationService {
  _FakeLocationService(this.nextResult);

  LocationAcquisitionResult nextResult;

  @override
  Future<LocationAcquisitionResult> acquirePosition({
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
    bool enforceAccuracy = true,
  }) async {
    return nextResult;
  }
}

class _FakeDeviceIdentityService implements DeviceIdentityService {
  _FakeDeviceIdentityService(this.deviceId);

  final String deviceId;

  @override
  Future<String> getOrCreateDeviceId() async => deviceId;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeAttendanceRepository extends AttendanceRepository {
  _FakeAttendanceRepository({
    required this.policy,
    this.checkInRecord,
    this.checkInFailure,
  }) : super(dio: Dio());

  EffectiveAttendancePolicyModel policy;
  AttendanceRecordModel? checkInRecord;
  AppFailure? checkInFailure;
  CheckInRequestPayload? lastCheckInPayload;

  @override
  Future<(EffectiveAttendancePolicyModel?, AppFailure?)>
  fetchEffectivePolicy() async {
    return (policy, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> fetchTodayAttendance() async {
    return (null, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> checkIn(
    CheckInRequestPayload payload,
  ) async {
    lastCheckInPayload = payload;
    if (checkInFailure != null) {
      return (null, checkInFailure);
    }
    return (checkInRecord, null);
  }

  CheckOutRequestPayload? lastCheckOutPayload;
  AttendanceRecordModel? checkOutRecord;
  AppFailure? checkOutFailure;

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> checkOut(
    CheckOutRequestPayload payload,
  ) async {
    lastCheckOutPayload = payload;
    if (checkOutFailure != null) {
      return (null, checkOutFailure);
    }
    return (checkOutRecord, null);
  }

  AttendanceCalendarModel? mockCalendar;
  EmployeeMonthlyReportModel? mockMonthlyReport;

  @override
  Future<(AttendanceCalendarModel?, AppFailure?)> fetchMyCalendar({
    required int month,
    required int year,
  }) async => (mockCalendar, null);

  @override
  Future<(EmployeeMonthlyReportModel?, AppFailure?)> fetchMonthlyReport({
    required String employeeId,
    required int month,
    required int year,
  }) async => (mockMonthlyReport, null);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const hqOffice = OfficeLocationModel(
    id: 'office-hq-1',
    name: 'Right Ads HQ',
    latitude: 19.0760,
    longitude: 72.8777,
  );

  const strictPolicy = EffectiveAttendancePolicyModel(
    id: 'policy-strict-1',
    name: 'Standard HQ Shift',
    allowedLocations: <OfficeLocationModel>[hqOffice],
  );

  const flexiblePolicy = EffectiveAttendancePolicyModel(
    id: 'policy-flex-1',
    name: 'Field Sales Shift',
    requireGeofence: false,
  );

  final sampleCheckedInRecord = AttendanceRecordModel(
    id: 'att-1',
    employeeId: 'emp-1',
    attendanceDate: '2026-10-18',
    checkInAt: DateTime.utc(2026, 10, 18, 4),
    status: 'PRESENT',
    statusLabel: 'Present',
    statusColor: '#16A34A',
    deviceId: 'bound-device-001',
  );

  group('LocationService & Geofence Evaluation', () {
    test('calculates Haversine distance and evaluates office radius', () {
      const service = LocationService();

      // ~35 meters away from Right Ads HQ (19.0760, 72.8777)
      final insideEval = service.evaluateGeofence(
        latitude: 19.0762,
        longitude: 72.8779,
        allowedLocations: const <OfficeLocationModel>[hqOffice],
      );
      expect(insideEval.isWithinGeofence, isTrue);
      expect(insideEval.nearestOffice?.name, 'Right Ads HQ');
      expect(insideEval.distanceMeters, lessThan(100));

      // ~1.5 km away from Right Ads HQ
      final outsideEval = service.evaluateGeofence(
        latitude: 19.0900,
        longitude: 72.8900,
        allowedLocations: const <OfficeLocationModel>[hqOffice],
      );
      expect(outsideEval.isWithinGeofence, isFalse);
      expect(outsideEval.nearestOffice?.name, 'Right Ads HQ');
      expect(outsideEval.distanceMeters, greaterThan(1000));
    });
  });

  group('TodayAttendanceController Policy-Driven Check-In & Check-Out', () {
    test(
      'blocks check-in when policy.requireSelfie is true and selfie is missing',
      () async {
        final fakeRepo = _FakeAttendanceRepository(
          policy: strictPolicy.copyWith(requireSelfie: true),
        );
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 19.0760,
            longitude: 72.8777,
            accuracyMeters: 10,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        container.read(todayAttendanceControllerProvider);
        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();

        final outcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkIn();

        expect(outcome, isA<AttendanceActionSelfieRequired>());
        expect(fakeRepo.lastCheckInPayload, isNull);
      },
    );

    test(
      'blocks check-in when mock location is detected or outside geofence',
      () async {
        final fakeRepo = _FakeAttendanceRepository(
          policy: strictPolicy.copyWith(requireSelfie: false),
        );
        final fakeLocation = _FakeLocationService(
          const LocationMockDetected(latitude: 19.0760, longitude: 72.8777),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();

        // 1. Mock location blocked
        final mockOutcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkIn();
        expect(mockOutcome, isA<AttendanceActionLocationProblem>());
        expect(
          (mockOutcome as AttendanceActionLocationProblem).locationResult,
          isA<LocationMockDetected>(),
        );

        // 2. Outside geofence blocked when policy.requireGeofence == true
        fakeLocation.nextResult = const LocationSuccess(
          latitude: 19.0950,
          longitude: 72.8950,
          accuracyMeters: 12,
          isMockLocation: false,
        );
        final outsideOutcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkIn();
        expect(outsideOutcome, isA<AttendanceActionOutsideGeofence>());
        expect(fakeRepo.lastCheckInPayload, isNull);
      },
    );

    test(
      'succeeds when policy requirements are met and never sends a client timestamp',
      () async {
        final fakeRepo = _FakeAttendanceRepository(
          policy: flexiblePolicy,
          checkInRecord: sampleCheckedInRecord,
        );
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 28.6139,
            longitude: 77.2090,
            accuracyMeters: 15,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();

        final outcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkIn();

        expect(outcome, isA<AttendanceActionSuccess>());
        final payload = fakeRepo.lastCheckInPayload!;
        final json = payload.toJson();
        expect(json['device_id'], 'bound-device-001');
        expect(json['latitude'], 28.6139);
        expect(json['longitude'], 77.2090);
        expect(json['is_mock_location'], isFalse);
        expect(json.containsKey('timestamp'), isFalse);
        expect(json.containsKey('check_in_at'), isFalse);
      },
    );

    test(
      'maps 403 Forbidden device mismatch to AttendanceActionDeviceMismatch',
      () async {
        final fakeRepo = _FakeAttendanceRepository(
          policy: flexiblePolicy,
          checkInFailure: const AppFailure.forbidden(
            message:
                'Device ID mismatch: attendance must be marked from your registered device.',
          ),
        );
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 19.0760,
            longitude: 72.8777,
            accuracyMeters: 8,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('wrong-device-999'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();

        final outcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkIn();

        expect(outcome, isA<AttendanceActionDeviceMismatch>());
      },
    );

    test(
      'executes check-out successfully without sending client timestamps',
      () async {
        final fakeRepo =
            _FakeAttendanceRepository(
                policy: flexiblePolicy,
              )
              ..checkOutRecord = sampleCheckedInRecord.copyWith(
                checkOutAt: DateTime.utc(2026, 10, 18, 13),
                workHours: 9,
              );
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 19.0760,
            longitude: 72.8777,
            accuracyMeters: 5,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();
        final outcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkOut(remarks: 'Day done');

        expect(outcome, isA<AttendanceActionSuccess>());
        final payload = fakeRepo.lastCheckOutPayload!;
        final json = payload.toJson();
        expect(json['device_id'], 'bound-device-001');
        expect(json['remarks'], 'Day done');
        expect(json.containsKey('timestamp'), isFalse);
        expect(json.containsKey('check_out_at'), isFalse);
      },
    );

    test('rejects check-out outside geofence when required', () async {
      final fakeRepo = _FakeAttendanceRepository(policy: strictPolicy);
      final fakeLocation = _FakeLocationService(
        const LocationSuccess(
          latitude: 12.9716, // Bangalore instead of Mumbai HQ
          longitude: 77.5946,
          accuracyMeters: 5,
          isMockLocation: false,
        ),
      );

      final container = ProviderContainer(
        overrides: [
          attendanceRepositoryProvider.overrideWithValue(fakeRepo),
          locationServiceProvider.overrideWithValue(fakeLocation),
          deviceIdentityServiceProvider.overrideWithValue(
            _FakeDeviceIdentityService('bound-device-001'),
          ),
          connectivityChangesProvider.overrideWith(
            (ref) => Stream.value([ConnectivityResult.wifi]),
          ),
        ],
      );
      addTearDown(container.dispose);

      final connSub = container.listen(connectivityChangesProvider, (_, _) {});
      addTearDown(connSub.close);
      for (var i = 0; i < 5; i++) {
        await pumpEventQueue();
      }
      await container
          .read(todayAttendanceControllerProvider.notifier)
          .loadTodayAndPolicy();
      final outcome = await container
          .read(todayAttendanceControllerProvider.notifier)
          .checkOut();
      expect(outcome, isA<AttendanceActionOutsideGeofence>());
    });

    test(
      'MonthlyAttendanceData calculates percentage and mergedDays accurately',
      () {
        const calendar = AttendanceCalendarModel(
          year: 2026,
          month: 10,
          totalWorkingDays: 20,
          totalPresentDays: 18,
          totalHalfDays: 2,
          totalHolidays: 2,
          days: [
            AttendanceCalendarDayModel(
              date: '2026-10-01',
              status: 'PRESENT',
              statusLabel: 'Present',
              statusColor: '#10B981',
              workHours: 8,
            ),
          ],
        );

        const monthlyData = MonthlyAttendanceData(
          year: 2026,
          month: 10,
          calendar: calendar,
        );

        expect(monthlyData.workingDays, 20);
        expect(monthlyData.attendancePercentage, 95.0);
        expect(monthlyData.mergedDays.length, 1);
        expect(monthlyData.mergedDays.first.status, 'PRESENT');
      },
    );
    test(
      'rejects check-in when offline (AttendanceActionOfflineProhibited)',
      () async {
        final fakeRepo = _FakeAttendanceRepository(policy: strictPolicy);
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 19.0760,
            longitude: 72.8777,
            accuracyMeters: 5,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.none]),
            ),
          ],
        );
        addTearDown(container.dispose);

        final connSub = container.listen(
          connectivityChangesProvider,
          (_, _) {},
        );
        addTearDown(connSub.close);
        for (var i = 0; i < 5; i++) {
          await pumpEventQueue();
        }
        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();
        final outcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkIn();
        expect(outcome, isA<AttendanceActionOfflineProhibited>());
      },
    );

    test(
      'rejects check-out when offline (AttendanceActionOfflineProhibited)',
      () async {
        final fakeRepo = _FakeAttendanceRepository(policy: strictPolicy);
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 19.0760,
            longitude: 72.8777,
            accuracyMeters: 5,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.none]),
            ),
          ],
        );
        addTearDown(container.dispose);

        final connSub = container.listen(
          connectivityChangesProvider,
          (_, _) {},
        );
        addTearDown(connSub.close);
        for (var i = 0; i < 5; i++) {
          await pumpEventQueue();
        }
        await container
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy();
        final outcome = await container
            .read(todayAttendanceControllerProvider.notifier)
            .checkOut();
        expect(outcome, isA<AttendanceActionOfflineProhibited>());
      },
    );

    test(
      'refreshLocation updates locationResult and evaluates geofence',
      () async {
        final fakeRepo = _FakeAttendanceRepository(policy: strictPolicy);
        final fakeLocation = _FakeLocationService(
          const LocationSuccess(
            latitude: 19.0760,
            longitude: 72.8777,
            accuracyMeters: 5,
            isMockLocation: false,
          ),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(fakeRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService('bound-device-001'),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        final notifier = container.read(
          todayAttendanceControllerProvider.notifier,
        );
        await notifier.loadTodayAndPolicy();

        final result = await notifier.refreshLocation();
        expect(result, isA<LocationSuccess>());

        final state = container.read(todayAttendanceControllerProvider);
        expect(state.geofenceEvaluation?.isWithinGeofence, isTrue);

        // Now with disabled location
        fakeLocation.nextResult = const LocationServiceDisabled();
        final disabledResult = await notifier.refreshLocation();
        expect(disabledResult, isA<LocationServiceDisabled>());
      },
    );

    test('checkIn maps device mismatch and conflict errors', () async {
      final fakeRepo = _FakeAttendanceRepository(
        policy: strictPolicy,
        checkInFailure: const AppFailure.forbidden(
          message: 'Device ID mismatch',
        ),
      );
      final fakeLocation = _FakeLocationService(
        const LocationSuccess(
          latitude: 19.0760,
          longitude: 72.8777,
          accuracyMeters: 5,
          isMockLocation: false,
        ),
      );

      final container = ProviderContainer(
        overrides: [
          attendanceRepositoryProvider.overrideWithValue(fakeRepo),
          locationServiceProvider.overrideWithValue(fakeLocation),
          deviceIdentityServiceProvider.overrideWithValue(
            _FakeDeviceIdentityService('wrong-device'),
          ),
          connectivityChangesProvider.overrideWith(
            (ref) => Stream.value([ConnectivityResult.wifi]),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        todayAttendanceControllerProvider.notifier,
      );
      await notifier.loadTodayAndPolicy();

      final outcome = await notifier.checkIn();
      expect(outcome, isA<AttendanceActionDeviceMismatch>());

      // Test already checked in
      fakeRepo.checkInFailure = const AppFailure.conflict(
        message: 'Already checked in today',
      );
      final conflictOutcome = await notifier.checkIn();
      expect(conflictOutcome, isA<AttendanceActionAlreadyCheckedIn>());
    });
  });
}
