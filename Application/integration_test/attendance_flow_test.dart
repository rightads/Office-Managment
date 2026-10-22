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

import 'test_helper.dart';

class _FakeLocationService extends LocationService {
  _FakeLocationService(this.currentResult);

  LocationAcquisitionResult currentResult;

  @override
  Future<LocationAcquisitionResult> acquirePosition({
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
    bool enforceAccuracy = true,
  }) async {
    return currentResult;
  }
}

class _FakeDeviceIdentityService implements DeviceIdentityService {
  @override
  Future<String> getOrCreateDeviceId() async => 'bound-device-001';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockAttendanceRepository extends AttendanceRepository {
  _MockAttendanceRepository({
    required this.policy,
  }) : initialTodayRecord = null,
       super(dio: Dio());

  EffectiveAttendancePolicyModel policy;
  AttendanceRecordModel? initialTodayRecord;
  CheckInRequestPayload? lastCheckInPayload;
  CheckOutRequestPayload? lastCheckOutPayload;

  @override
  Future<(EffectiveAttendancePolicyModel?, AppFailure?)>
  fetchEffectivePolicy() async {
    return (policy, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> fetchTodayAttendance() async {
    return (initialTodayRecord, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> checkIn(
    CheckInRequestPayload payload,
  ) async {
    lastCheckInPayload = payload;
    initialTodayRecord = AttendanceRecordModel(
      id: 'att-new-1',
      employeeId: 'emp-1',
      attendanceDate: '2026-10-22',
      checkInAt: DateTime.utc(2026, 10, 22, 4),
      status: 'PRESENT',
      statusLabel: 'Present',
      statusColor: '#16A34A',
      deviceId: payload.deviceId,
    );
    return (initialTodayRecord, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> checkOut(
    CheckOutRequestPayload payload,
  ) async {
    lastCheckOutPayload = payload;
    initialTodayRecord = initialTodayRecord?.copyWith(
      checkOutAt: DateTime.utc(2026, 10, 22, 13),
      workHours: 9,
    );
    return (initialTodayRecord, null);
  }
}

void main() {
  IntegrationTestHelper.ensureInitialized();

  const hqOffice = OfficeLocationModel(
    id: 'office-1',
    name: 'Right Ads HQ',
    latitude: 19.0760,
    longitude: 72.8777,
  );

  const strictPolicy = EffectiveAttendancePolicyModel(
    id: 'policy-1',
    name: 'HQ Creative Shift',
    allowedLocations: <OfficeLocationModel>[hqOffice],
  );

  group('Attendance End-to-End Integration Flow', () {
    testWidgets(
      'enforces mock location & geofence verification then executes check-in and check-out without client timestamps',
      (tester) async {
        final mockRepo = _MockAttendanceRepository(policy: strictPolicy);
        final fakeLocation = _FakeLocationService(
          const LocationMockDetected(latitude: 19.0760, longitude: 72.8777),
        );

        final container = ProviderContainer(
          overrides: [
            attendanceRepositoryProvider.overrideWithValue(mockRepo),
            locationServiceProvider.overrideWithValue(fakeLocation),
            deviceIdentityServiceProvider.overrideWithValue(
              _FakeDeviceIdentityService(),
            ),
            connectivityChangesProvider.overrideWith(
              (ref) => Stream.value([ConnectivityResult.wifi]),
            ),
          ],
        );
        addTearDown(container.dispose);

        final sub = container.listen(connectivityChangesProvider, (_, _) {});
        addTearDown(sub.close);

        final controller = container.read(
          todayAttendanceControllerProvider.notifier,
        );
        await controller.loadTodayAndPolicy();

        // 1. Mock location rejection
        final mockOutcome = await controller.checkIn();
        expect(mockOutcome, isA<AttendanceActionLocationProblem>());
        expect(mockRepo.lastCheckInPayload, isNull);

        // 2. Outside geofence rejection
        fakeLocation.currentResult = const LocationSuccess(
          latitude: 19.2000,
          longitude: 72.9500,
          accuracyMeters: 10,
          isMockLocation: false,
        );
        final outsideOutcome = await controller.checkIn();
        expect(outsideOutcome, isA<AttendanceActionOutsideGeofence>());
        expect(mockRepo.lastCheckInPayload, isNull);

        // 3. Valid location inside geofence -> Successful Check-In
        fakeLocation.currentResult = const LocationSuccess(
          latitude: 19.0761,
          longitude: 72.8778,
          accuracyMeters: 8,
          isMockLocation: false,
        );
        final checkInOutcome = await controller.checkIn();
        expect(checkInOutcome, isA<AttendanceActionSuccess>());
        expect(mockRepo.lastCheckInPayload, isNotNull);

        // Assert strictly NO client timestamp in payload (Rule 4)
        final payloadJson = mockRepo.lastCheckInPayload!.toJson();
        expect(payloadJson.containsKey('timestamp'), isFalse);
        expect(payloadJson.containsKey('check_in_at'), isFalse);
        expect(payloadJson['device_id'], 'bound-device-001');

        // 4. Verify check-out flow
        final checkOutOutcome = await controller.checkOut(
          remarks: 'Done for the day',
        );
        expect(checkOutOutcome, isA<AttendanceActionSuccess>());
        expect(mockRepo.lastCheckOutPayload, isNotNull);
        final checkOutJson = mockRepo.lastCheckOutPayload!.toJson();
        expect(checkOutJson.containsKey('timestamp'), isFalse);
        expect(checkOutJson.containsKey('check_out_at'), isFalse);
        expect(checkOutJson['remarks'], 'Done for the day');
      },
    );
  });
}
