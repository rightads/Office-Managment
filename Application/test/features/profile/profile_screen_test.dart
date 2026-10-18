import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:right_ads/core/auth/biometric_service.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/services/device_info_service.dart';
import 'package:right_ads/core/services/photo_picker_service.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/features/profile/presentation/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _StubBiometricService implements BiometricService {
  bool _enabled = false;

  @override
  Future<bool> authenticate({required String localizedReason}) async => true;

  @override
  bool isEnabledByUser() => _enabled;

  @override
  Future<bool> isHardwareAvailable() async => true;

  @override
  Future<void> setEnabledByUser({required bool enabled}) async {
    _enabled = enabled;
  }
}

class _OversizedPhotoPickerService extends PhotoPickerService {
  @override
  Future<PickedPhotoFile?> pickCompressedPhoto(ImageSource source) async {
    return const PickedPhotoFile(
      fileName: 'oversized.jpg',
      mimeType: 'image/jpeg',
      sizeBytes: 15 * 1024 * 1024, // 15 MB > 5 MB limit
      pathOrUri: '/uploads/avatars/oversized.jpg',
    );
  }
}

class _StubDeviceInfoService implements DeviceInfoService {
  @override
  Future<DeviceMetadata> readDeviceMetadata() async {
    return const DeviceMetadata(
      deviceId: 'ios_iphone16_98765',
      platformName: 'iOS',
      modelName: 'iPhone17,1',
      osVersion: 'iOS 18.2',
    );
  }
}

class _CustomRuntimeAppConfigController extends RuntimeAppConfigController {
  @override
  RuntimeAppConfig build() {
    return const RuntimeAppConfig(
      maxUploadMb: 5,
      allowedUploadMimeTypes: <String>['image/jpeg', 'image/png'],
      passwordPolicy: PasswordPolicySummary(
        minLength: 10,
      ),
    );
  }
}

void main() {
  group('Prompt 05 - ProfileScreen & ChangePasswordBottomSheet Widget Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      prefs = await SharedPreferences.getInstance();
    });

    Dio buildMockDio({
      bool return422OnPatch = false,
      bool return422OnChangePassword = false,
    }) {
      final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/v1'));
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (options.path.endsWith(ApiEndpoints.employeesMe) &&
                options.method == 'GET') {
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: <String, dynamic>{
                    'id': 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
                    'employee_code': 'EMP-0108',
                    'email': 'rohan@rightads.in',
                    'full_name': 'Rohan Kulkarni',
                    'phone_number': '+91 9123456789',
                    'designation': 'Lead Graphic Designer',
                    'avatar_url': null,
                    'is_active': true,
                    'must_change_password': false,
                    'joining_date': '2024-08-15',
                    'department_name': 'Creative Studio',
                    'role_id': 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
                    'role_name': 'Graphic Designer',
                    'attendance_policy_name': 'Creative Shift',
                    'manager_name': 'Neha Kapoor',
                    'created_at': '2024-08-15T10:00:00Z',
                    'permissions': <String>['task.view_assigned'],
                  },
                ),
              );
              return;
            }

            if (options.path.endsWith(ApiEndpoints.employeesMe) &&
                options.method == 'PATCH') {
              if (return422OnPatch) {
                handler.reject(
                  DioException(
                    requestOptions: options,
                    type: DioExceptionType.badResponse,
                    response: Response<Map<String, dynamic>>(
                      requestOptions: options,
                      statusCode: 422,
                      data: <String, dynamic>{
                        'detail': <Map<String, dynamic>>[
                          <String, dynamic>{
                            'loc': <Object>['body', 'phone_number'],
                            'msg': 'Invalid phone number format from server',
                            'type': 'value_error',
                          },
                        ],
                      },
                    ),
                  ),
                );
                return;
              }
            }

            if (options.path.endsWith(ApiEndpoints.authChangePassword) &&
                options.method == 'POST') {
              if (return422OnChangePassword) {
                handler.reject(
                  DioException(
                    requestOptions: options,
                    type: DioExceptionType.badResponse,
                    response: Response<Map<String, dynamic>>(
                      requestOptions: options,
                      statusCode: 422,
                      data: <String, dynamic>{
                        'detail': <Map<String, dynamic>>[
                          <String, dynamic>{
                            'loc': <Object>['body', 'current_password'],
                            'msg': 'Current password does not match records',
                            'type': 'value_error',
                          },
                        ],
                      },
                    ),
                  ),
                );
                return;
              }
            }
          },
        ),
      );
      return dio;
    }

    Widget buildTestSubject({
      required Dio dio,
    }) {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          dioProvider.overrideWithValue(dio),
          appConfigProvider.overrideWithValue(
            const AppConfig(
              environment: AppEnvironment.dev,
              apiBaseUrl: 'http://localhost:8000/api/v1',
              connectTimeout: Duration(seconds: 5),
              receiveTimeout: Duration(seconds: 5),
              sendTimeout: Duration(seconds: 5),
            ),
          ),
          runtimeAppConfigControllerProvider.overrideWith(
            _CustomRuntimeAppConfigController.new,
          ),
          deviceInfoServiceProvider.overrideWithValue(_StubDeviceInfoService()),
          biometricServiceProvider.overrideWithValue(_StubBiometricService()),
          photoPickerServiceProvider.overrideWithValue(
            _OversizedPhotoPickerService(),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: ProfileScreen()),
        ),
      );
    }

    testWidgets(
      'Renders employee profile details, validates photo size against app config, and maps 422 phone error',
      (tester) async {
        final dio = buildMockDio(return422OnPatch: true);
        await tester.pumpWidget(buildTestSubject(dio: dio));
        await tester.pumpAndSettle();

        // Verify read-only organization fields from API
        expect(find.text('Rohan Kulkarni'), findsAtLeastNWidgets(1));
        expect(find.text('EMP-0108'), findsAtLeastNWidgets(1));
        expect(find.text('Graphic Designer'), findsAtLeastNWidgets(1));
        expect(find.text('Creative Studio'), findsAtLeastNWidgets(1));
        expect(find.text('Lead Graphic Designer'), findsOneWidget);
        expect(find.text('Neha Kapoor'), findsOneWidget);
        expect(find.text('15 Aug 2024'), findsOneWidget);

        // Verify upload limit hint from RuntimeAppConfig (5 MB)
        expect(
          find.text('Allowed: image/jpeg, image/png • Max 5 MB'),
          findsOneWidget,
        );

        // Trigger photo picker -> oversized photo rejected by RuntimeAppConfig (5 MB)
        await tester.tap(
          find.byKey(const ValueKey<String>('profile_change_photo_btn')),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const ValueKey<String>('photo_source_gallery')),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Selected photo exceeds the 5 MB maximum upload size.'),
          findsOneWidget,
        );

        // Scroll to Save Profile button and submit -> 422 error mapped onto phone field
        final saveBtn = find.byKey(
          const ValueKey<String>('profile_save_button'),
        );
        await tester.ensureVisible(saveBtn);
        await tester.pumpAndSettle();
        await tester.tap(saveBtn);
        await tester.pumpAndSettle();

        expect(
          find.text('Invalid phone number format from server'),
          findsOneWidget,
        );

        // Verify Device Info & App Version
        await tester.ensureVisible(find.text('ios_iphone16_98765'));
        await tester.pumpAndSettle();
        expect(find.text('ios_iphone16_98765'), findsOneWidget);
        expect(find.text('1.0.0 (dev)'), findsOneWidget);
      },
    );

    testWidgets(
      'ChangePasswordBottomSheet displays dynamic policy hints from app config and maps 422 field errors',
      (tester) async {
        final dio = buildMockDio(return422OnChangePassword: true);
        await tester.pumpWidget(buildTestSubject(dio: dio));
        await tester.pumpAndSettle();

        final changePwBtn = find.byKey(
          const ValueKey<String>('profile_change_password_button'),
        );
        await tester.ensureVisible(changePwBtn);
        await tester.pumpAndSettle();
        await tester.tap(changePwBtn);
        await tester.pumpAndSettle();

        // Verify dynamic minLength (10) from RuntimeAppConfig.passwordPolicy
        expect(find.text('At least 10 characters'), findsOneWidget);

        // Enter current password and valid new password, then submit to trigger 422 mapping
        await tester.enterText(
          find.byKey(const ValueKey<String>('change_password_current_field')),
          'OldValidPass12!',
        );
        await tester.enterText(
          find.byKey(const ValueKey<String>('change_password_new_field')),
          'NewValidPass12!',
        );
        await tester.enterText(
          find.byKey(const ValueKey<String>('change_password_confirm_field')),
          'NewValidPass12!',
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(const ValueKey<String>('change_password_submit_button')),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Current password does not match records'),
          findsOneWidget,
        );
      },
    );
  });
}
