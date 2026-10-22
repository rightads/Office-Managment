import 'dart:async';
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

class _SpyLocationService extends Fake implements LocationService {
  bool acquireCalled = false;

  @override
  Future<LocationAcquisitionResult> acquirePosition({
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
    bool enforceAccuracy = true,
  }) async {
    acquireCalled = true;
    return const LocationSuccess(
      latitude: 19.0760,
      longitude: 72.8777,
      accuracyMeters: 5,
      isMockLocation: false,
    );
  }
}

class _SpyAttendanceRepository extends AttendanceRepository {
  _SpyAttendanceRepository() : super(dio: Dio());

  bool checkInCalled = false;
  bool checkOutCalled = false;

  @override
  Future<(EffectiveAttendancePolicyModel?, AppFailure?)>
  fetchEffectivePolicy() async {
    return (
      const EffectiveAttendancePolicyModel(
        id: 'policy-1',
        name: 'Standard Shift',
        requireGeofence: false,
      ),
      null,
    );
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> fetchTodayAttendance() async {
    return (null, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> checkIn(
    CheckInRequestPayload payload,
  ) async {
    checkInCalled = true;
    return (null, null);
  }

  @override
  Future<(AttendanceRecordModel?, AppFailure?)> checkOut(
    CheckOutRequestPayload payload,
  ) async {
    checkOutCalled = true;
    return (null, null);
  }
}

class _DummyDeviceIdentityService implements DeviceIdentityService {
  @override
  Future<String> getOrCreateDeviceId() async => 'dummy-device';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test(
    'checkIn returns AttendanceActionOfflineProhibited and does NOT contact GPS or API when offline',
    () async {
      final spyRepo = _SpyAttendanceRepository();
      final spyLoc = _SpyLocationService();
      final streamController =
          StreamController<List<ConnectivityResult>>.broadcast();
      addTearDown(streamController.close);

      final container = ProviderContainer(
        overrides: [
          attendanceRepositoryProvider.overrideWithValue(spyRepo),
          locationServiceProvider.overrideWithValue(spyLoc),
          deviceIdentityServiceProvider.overrideWithValue(
            _DummyDeviceIdentityService(),
          ),
          connectivityChangesProvider.overrideWith(
            (ref) => streamController.stream,
          ),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(connectivityChangesProvider, (_, _) {});
      addTearDown(sub.close);

      streamController.add([ConnectivityResult.none]);
      await pumpEventQueue();

      // Load policy first
      await container
          .read(todayAttendanceControllerProvider.notifier)
          .loadTodayAndPolicy();

      // Trigger checkIn while offline
      final outcome = await container
          .read(todayAttendanceControllerProvider.notifier)
          .checkIn();

      expect(outcome, isA<AttendanceActionOfflineProhibited>());
      expect(
        spyLoc.acquireCalled,
        isFalse,
        reason: 'GPS should not be acquired when offline',
      );
      expect(
        spyRepo.checkInCalled,
        isFalse,
        reason: 'Check-in API should not be called when offline',
      );
    },
  );

  test(
    'checkOut returns AttendanceActionOfflineProhibited and does NOT contact GPS or API when offline',
    () async {
      final spyRepo = _SpyAttendanceRepository();
      final spyLoc = _SpyLocationService();
      final streamController =
          StreamController<List<ConnectivityResult>>.broadcast();
      addTearDown(streamController.close);

      final container = ProviderContainer(
        overrides: [
          attendanceRepositoryProvider.overrideWithValue(spyRepo),
          locationServiceProvider.overrideWithValue(spyLoc),
          deviceIdentityServiceProvider.overrideWithValue(
            _DummyDeviceIdentityService(),
          ),
          connectivityChangesProvider.overrideWith(
            (ref) => streamController.stream,
          ),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(connectivityChangesProvider, (_, _) {});
      addTearDown(sub.close);

      streamController.add([ConnectivityResult.none]);
      await pumpEventQueue();

      await container
          .read(todayAttendanceControllerProvider.notifier)
          .loadTodayAndPolicy();

      final outcome = await container
          .read(todayAttendanceControllerProvider.notifier)
          .checkOut();

      expect(outcome, isA<AttendanceActionOfflineProhibited>());
      expect(
        spyLoc.acquireCalled,
        isFalse,
        reason: 'GPS should not be acquired when offline',
      );
      expect(
        spyRepo.checkOutCalled,
        isFalse,
        reason: 'Check-out API should not be called when offline',
      );
    },
  );
}
