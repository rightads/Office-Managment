import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/notifications/notification_service.dart';
import 'package:right_ads/core/utils/app_logger.dart';
import 'package:right_ads/features/communication/data/communication_repository.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeCommunicationRepository implements CommunicationRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<(DeviceTokenResponseModel?, AppFailure?)> registerDeviceToken(
    DeviceTokenRegisterPayload payload,
  ) async {
    return (
      DeviceTokenResponseModel(
        id: 'tok-1',
        deviceId: payload.deviceId,
        platform: payload.platform,
        createdAt: DateTime.now(),
      ),
      null,
    );
  }

  @override
  Future<AppFailure?> unregisterDeviceToken(String deviceId) async {
    return null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationService Tests (Mocked Messaging)', () {
    late _FakeCommunicationRepository fakeRepo;
    late SharedPreferences prefs;
    late AppLogger logger;
    late NotificationService service;
    String? navigatedRoute;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      fakeRepo = _FakeCommunicationRepository();
      logger = AppLogger();
      navigatedRoute = null;

      service = NotificationService(
        repository: fakeRepo,
        prefs: prefs,
        logger: logger,
        onNavigate: (route) {
          navigatedRoute = route;
        },
      );
    });

    test('getDeviceId generates and persists a UUID', () {
      final id1 = service.getDeviceId();
      expect(id1, isNotEmpty);

      // Subsequent call returns same cached/persisted ID
      final id2 = service.getDeviceId();
      expect(id2, equals(id1));
    });

    test('platformName returns android or valid platform string', () {
      expect(service.platformName, isNotEmpty);
      expect(['android', 'ios', 'web'], contains(service.platformName));
    });

    test(
      'registerDeviceToken registers device payload with repository',
      () async {
        await service.registerDeviceToken(
          fcmTokenOverride: 'manual-test-token',
        );

        expect(
          prefs.getString('fcm_last_registered_token'),
          'manual-test-token',
        );
      },
    );

    test('unregisterDeviceToken removes token and calls repository', () async {
      await prefs.setString('fcm_last_registered_token', 'manual-test-token');

      await service.unregisterDeviceToken();

      expect(prefs.getString('fcm_last_registered_token'), isNull);
    });

    test('notification payload navigation routes to task deep link', () {
      service.onNavigate?.call('/tasks/task-abc-123');

      expect(navigatedRoute, '/tasks/task-abc-123');
    });
  });
}
