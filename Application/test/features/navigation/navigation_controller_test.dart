import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';
import 'package:right_ads/features/navigation/presentation/module_icon_mapper.dart';
import 'package:right_ads/features/navigation/presentation/module_registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('RuntimeAppConfig & NavigationController Unit Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      prefs = await SharedPreferences.getInstance();
    });

    test(
      'RuntimeAppConfig semantic version comparison and force-update gate',
      () {
        const config = RuntimeAppConfig(
          minSupportedAppVersion: '1.2.0',
        );
        expect(config.isBelowMinSupportedVersion('1.0.0'), isTrue);
        expect(config.isBelowMinSupportedVersion('1.1.9'), isTrue);
        expect(config.isBelowMinSupportedVersion('1.2.0'), isFalse);
        expect(config.isBelowMinSupportedVersion('1.3.0'), isFalse);
        expect(config.isBelowMinSupportedVersion('2.0.0'), isFalse);
        expect(config.requiresForceUpdate('1.1.0'), isTrue);
        expect(config.requiresForceUpdate('1.2.0'), isFalse);

        const forcedConfig = RuntimeAppConfig(
          forceUpdate: true,
        );
        expect(forcedConfig.requiresForceUpdate('1.0.0'), isTrue);
      },
    );

    test('ModuleIconMapper and ModuleRegistry handle unknown keys safely', () {
      expect(
        ModuleIconMapper.resolveIcon('attendance'),
        equals(Icons.access_time_outlined),
      );
      expect(
        ModuleIconMapper.resolveIcon('completely_unknown_icon_key'),
        equals(ModuleIconMapper.fallbackIcon),
      );

      final knownEntry = ModuleRegistry.resolve('attendance');
      expect(knownEntry.isSupported, isTrue);

      final unknownEntry = ModuleRegistry.resolve('future_quantum_module');
      expect(unknownEntry.isSupported, isFalse);
    });

    test(
      'loads /app/config and /me/navigation, caches for offline start, and hot-reloads after N minutes',
      () async {
        var navCallCount = 0;
        var shouldFailNetwork = false;

        final dio = Dio(BaseOptions(baseUrl: 'http://testserver/api/v1'));
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              if (options.path.endsWith(ApiEndpoints.appConfig)) {
                handler.resolve(
                  Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: 200,
                    data: <String, dynamic>{
                      'app_timezone': 'Asia/Kolkata',
                      'default_page_size': 15,
                      'max_page_size': 50,
                      'max_upload_mb': 8,
                      'allowed_upload_mime_types': <String>['image/png'],
                      'min_supported_app_version': '1.0.0',
                      'force_update': false,
                      'navigation_refresh_interval_minutes': 5,
                      'password_policy': <String, dynamic>{
                        'min_length': 10,
                        'require_uppercase': true,
                        'require_lowercase': true,
                        'require_digit': true,
                        'require_special': true,
                      },
                      'feature_flags': <String, dynamic>{
                        'biometric_unlock': true,
                      },
                    },
                  ),
                );
                return;
              }

              if (options.path.endsWith(ApiEndpoints.meNavigation)) {
                if (shouldFailNetwork) {
                  handler.reject(
                    DioException(
                      requestOptions: options,
                      type: DioExceptionType.connectionError,
                      message: 'Offline',
                    ),
                  );
                  return;
                }
                navCallCount++;
                handler.resolve(
                  Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: 200,
                    data: <String, dynamic>{
                      'modules': <Map<String, dynamic>>[
                        <String, dynamic>{
                          'id': '00000000-0000-0000-0000-000000000001',
                          'code': 'attendance',
                          'label': 'Attendance',
                          'icon_key': 'attendance',
                          'route_key': 'attendance',
                          'sort_order': 10,
                          'required_permission':
                              PermissionCodes.attendanceViewOwn,
                          'is_base': true,
                          'is_active': true,
                          'show_on_home': true,
                        },
                      ],
                      'permissions': <String>[
                        PermissionCodes.attendanceViewOwn,
                        if (navCallCount > 1) PermissionCodes.taskViewAssigned,
                      ],
                      'role_name': 'Tele sales',
                      'role_label': 'Tele sales',
                      'department_name': 'Sales',
                      'must_change_password': false,
                    },
                  ),
                );
                return;
              }
              handler.next(options);
            },
          ),
        );

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            dioProvider.overrideWithValue(dio),
          ],
        );
        addTearDown(container.dispose);

        final t0 = DateTime.utc(2026, 10, 18, 12);
        await container
            .read(navigationControllerProvider.notifier)
            .loadInitialNavigation(now: t0);

        final navState = container.read(navigationControllerProvider);
        expect(navState.data.modules.length, 1);
        expect(navState.data.modules.first.code, 'attendance');
        expect(navState.data.roleLabel, 'Tele sales');

        final permService = container.read(permissionServiceProvider);
        expect(permService.can(PermissionCodes.attendanceViewOwn), isTrue);
        expect(permService.can(PermissionCodes.taskViewAssigned), isFalse);

        // Foreground resume after 2 minutes (< 5 min interval) should NOT refetch
        await container
            .read(navigationControllerProvider.notifier)
            .onAppResumed(now: t0.add(const Duration(minutes: 2)));
        expect(navCallCount, 1);

        // Foreground resume after 6 minutes (>= 5 min interval) MUST refetch and hot-reload permissions
        await container
            .read(navigationControllerProvider.notifier)
            .onAppResumed(now: t0.add(const Duration(minutes: 6)));
        expect(navCallCount, 2);
        expect(
          container
              .read(permissionServiceProvider)
              .can(PermissionCodes.taskViewAssigned),
          isTrue,
        );

        // Simulate offline start in a fresh container — should hydrate from cached copy
        shouldFailNetwork = true;
        final offlineContainer = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            dioProvider.overrideWithValue(dio),
          ],
        );
        addTearDown(offlineContainer.dispose);

        final offlineNavState = offlineContainer.read(
          navigationControllerProvider,
        );
        expect(offlineNavState.isFromOfflineCache, isTrue);
        expect(offlineNavState.data.modules.length, 1);
        expect(offlineNavState.data.modules.first.code, 'attendance');
      },
    );
  });
}
