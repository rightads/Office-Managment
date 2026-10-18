import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/services/device_info_service.dart';
import 'package:right_ads/core/services/photo_picker_service.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/features/profile/application/password_policy_validator.dart';
import 'package:right_ads/features/profile/application/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakePhotoPickerService extends PhotoPickerService {
  _FakePhotoPickerService(this._nextFile);

  final PickedPhotoFile? _nextFile;

  @override
  Future<PickedPhotoFile?> pickCompressedPhoto(ImageSource source) async {
    return _nextFile;
  }
}

class _FakeDeviceInfoService implements DeviceInfoService {
  @override
  Future<DeviceMetadata> readDeviceMetadata() async {
    return const DeviceMetadata(
      deviceId: 'android_pixel8_test123',
      platformName: 'Android',
      modelName: 'Google Pixel 8',
      osVersion: 'Android 15 (SDK 35)',
    );
  }
}

void main() {
  group('Prompt 05 - Profile, Validation & Error Mapping Unit Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      prefs = await SharedPreferences.getInstance();
    });

    test(
      'PasswordPolicyValidator evaluates dynamically against PasswordPolicySummary',
      () {
        const policy = PasswordPolicySummary(
          minLength: 10,
        );

        final shortViolations = PasswordPolicyValidator.evaluate(
          'Ab1!',
          policy,
        );
        expect(shortViolations, contains(PasswordPolicyViolation.tooShort));
        expect(PasswordPolicyValidator.isValid('Ab1!', policy), isFalse);

        final missingSpecial = PasswordPolicyValidator.evaluate(
          'Abcdefgh12',
          policy,
        );
        expect(
          missingSpecial,
          equals(<PasswordPolicyViolation>[
            PasswordPolicyViolation.missingSpecial,
          ]),
        );

        expect(
          PasswordPolicyValidator.isValid('Abcdefgh1!', policy),
          isTrue,
        );
      },
    );

    test(
      'PhotoPickerService.validatePickedPhoto enforces maxUploadMb and allowedUploadMimeTypes from RuntimeAppConfig',
      () {
        const config = RuntimeAppConfig(
          maxUploadMb: 2,
          allowedUploadMimeTypes: <String>['image/jpeg', 'image/png'],
        );

        const validFile = PickedPhotoFile(
          fileName: 'avatar.jpg',
          mimeType: 'image/jpeg',
          sizeBytes: 512 * 1024,
          pathOrUri: '/uploads/avatars/avatar.jpg',
        );
        expect(
          PhotoPickerService.validatePickedPhoto(validFile, config),
          isNull,
        );

        const oversizedFile = PickedPhotoFile(
          fileName: 'huge.png',
          mimeType: 'image/png',
          sizeBytes: 3 * 1024 * 1024,
          pathOrUri: '/uploads/avatars/huge.png',
        );
        expect(
          PhotoPickerService.validatePickedPhoto(oversizedFile, config),
          equals(PhotoValidationError.exceedsMaxSize),
        );

        const wrongMimeFile = PickedPhotoFile(
          fileName: 'document.pdf',
          mimeType: 'application/pdf',
          sizeBytes: 100 * 1024,
          pathOrUri: '/uploads/avatars/document.pdf',
        );
        expect(
          PhotoPickerService.validatePickedPhoto(wrongMimeFile, config),
          equals(PhotoValidationError.unsupportedMimeType),
        );
      },
    );

    test(
      'ProfileController loads /employees/me, updates self-editable fields, and maps 422 field errors',
      () async {
        var shouldReturn422OnPatch = false;
        var shouldReturn422OnChangePassword = false;

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
                      'id': '11111111-1111-1111-1111-111111111111',
                      'employee_code': 'EMP-0042',
                      'email': 'ananya@rightads.in',
                      'full_name': 'Ananya Sharma',
                      'phone_number': '+91 9876543210',
                      'designation': 'Senior SEO Strategist',
                      'avatar_url': '/uploads/avatars/initial.jpg',
                      'is_active': true,
                      'must_change_password': false,
                      'joining_date': '2025-04-01',
                      'department_id': '22222222-2222-2222-2222-222222222222',
                      'department_name': 'Digital Growth',
                      'role_id': '33333333-3333-3333-3333-333333333333',
                      'role_name': 'SEO',
                      'attendance_policy_name': 'Standard Agency Shift',
                      'manager_id': '44444444-4444-4444-4444-444444444444',
                      'manager_name': 'Vikram Mehta',
                      'created_at': '2025-04-01T09:00:00Z',
                      'permissions': <String>[
                        'attendance.check_in',
                        'attendance.view_own',
                        'task.view_assigned',
                      ],
                    },
                  ),
                );
                return;
              }

              if (options.path.endsWith(ApiEndpoints.employeesMe) &&
                  options.method == 'PATCH') {
                if (shouldReturn422OnPatch) {
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
                              'msg': 'String should have at most 20 characters',
                              'type': 'string_too_long',
                            },
                          ],
                        },
                      ),
                    ),
                  );
                  return;
                }

                final body = options.data as Map<String, dynamic>;
                handler.resolve(
                  Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: 200,
                    data: <String, dynamic>{
                      'id': '11111111-1111-1111-1111-111111111111',
                      'employee_code': 'EMP-0042',
                      'email': 'ananya@rightads.in',
                      'full_name': 'Ananya Sharma',
                      'phone_number': body['phone_number'] ?? '+91 9876543210',
                      'designation': 'Senior SEO Strategist',
                      'avatar_url':
                          body['avatar_url'] ?? '/uploads/avatars/initial.jpg',
                      'is_active': true,
                      'must_change_password': false,
                      'joining_date': '2025-04-01',
                      'department_name': 'Digital Growth',
                      'role_id': '33333333-3333-3333-3333-333333333333',
                      'role_name': 'SEO',
                      'manager_name': 'Vikram Mehta',
                      'created_at': '2025-04-01T09:00:00Z',
                    },
                  ),
                );
                return;
              }

              if (options.path.endsWith(ApiEndpoints.authChangePassword) &&
                  options.method == 'POST') {
                if (shouldReturn422OnChangePassword) {
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
                              'msg': 'Current password is incorrect',
                              'type': 'value_error',
                            },
                            <String, dynamic>{
                              'loc': <Object>['body', 'new_password'],
                              'msg':
                                  'New password must differ from current password',
                              'type': 'value_error',
                            },
                          ],
                        },
                      ),
                    ),
                  );
                  return;
                }

                handler.resolve(
                  Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: 200,
                    data: <String, dynamic>{
                      'message': 'Password updated successfully.',
                    },
                  ),
                );
                return;
              }
            },
          ),
        );

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            dioProvider.overrideWithValue(dio),
            deviceInfoServiceProvider.overrideWithValue(
              _FakeDeviceInfoService(),
            ),
            photoPickerServiceProvider.overrideWithValue(
              _FakePhotoPickerService(
                const PickedPhotoFile(
                  fileName: 'new_avatar.png',
                  mimeType: 'image/png',
                  sizeBytes: 256 * 1024,
                  pathOrUri: '/uploads/avatars/new_avatar.png',
                ),
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        // 1. Load profile
        await container.read(profileControllerProvider.notifier).loadProfile();
        final loadedState = container.read(profileControllerProvider);
        expect(loadedState.profile, isNotNull);
        expect(loadedState.profile!.employeeCode, equals('EMP-0042'));
        expect(loadedState.profile!.fullName, equals('Ananya Sharma'));
        expect(loadedState.profile!.roleName, equals('SEO'));
        expect(loadedState.profile!.departmentName, equals('Digital Growth'));
        expect(
          loadedState.profile!.designation,
          equals('Senior SEO Strategist'),
        );
        expect(loadedState.profile!.managerName, equals('Vikram Mehta'));
        expect(loadedState.profile!.joiningDate, equals('2025-04-01'));
        expect(
          loadedState.deviceMetadata?.deviceId,
          equals('android_pixel8_test123'),
        );
        expect(
          container
              .read(userPermissionsControllerProvider)
              .can('task.view_assigned'),
          isTrue,
        );

        // 2. Successful self-edit update
        final saveFailure = await container
            .read(profileControllerProvider.notifier)
            .updateSelfProfile(phoneNumber: '+91 9988776655');
        expect(saveFailure, isNull);
        expect(
          container.read(profileControllerProvider).profile!.phoneNumber,
          equals('+91 9988776655'),
        );

        // 3. Pick and upload photo
        final photoSaved = await container
            .read(profileControllerProvider.notifier)
            .pickAndUploadPhoto(ImageSource.gallery);
        expect(photoSaved, isTrue);
        expect(
          container.read(profileControllerProvider).profile!.avatarUrl,
          equals('/uploads/avatars/new_avatar.png'),
        );

        // 4. 422 field error mapping on PATCH /employees/me
        shouldReturn422OnPatch = true;
        final validationFailure = await container
            .read(profileControllerProvider.notifier)
            .updateSelfProfile(phoneNumber: 'invalid-too-long-phone-number');
        expect(validationFailure, isA<ValidationFailure>());
        expect(
          container
              .read(profileControllerProvider)
              .profileFieldError('phone_number'),
          equals('String should have at most 20 characters'),
        );

        // 5. 422 field error mapping on POST /auth/change-password
        shouldReturn422OnChangePassword = true;
        final pwFailure = await container
            .read(profileControllerProvider.notifier)
            .changePassword(
              currentPassword: 'WrongPassword1!',
              newPassword: 'WrongPassword1!',
            );
        expect(pwFailure, isA<ValidationFailure>());
        final pwState = container.read(profileControllerProvider);
        expect(
          pwState.passwordFieldError('current_password'),
          equals('Current password is incorrect'),
        );
        expect(
          pwState.passwordFieldError('new_password'),
          equals('New password must differ from current password'),
        );
      },
    );
  });
}
