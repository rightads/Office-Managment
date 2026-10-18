import 'package:image_picker/image_picker.dart';
import 'package:right_ads/core/auth/biometric_service.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/services/device_info_service.dart';
import 'package:right_ads/core/services/photo_picker_service.dart';
import 'package:right_ads/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:right_ads/features/profile/data/profile_repository.dart';
import 'package:right_ads/features/profile/domain/profile_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  ProfileViewState build() {
    return const ProfileViewState();
  }

  /// Loads `GET /api/v1/employees/me`, biometric hardware/preference state,
  /// and device metadata.
  Future<void> loadProfile() async {
    state = state.copyWith(
      isLoading: true,
      failure: null,
      photoValidationError: null,
      profileFieldErrors: const <String, List<String>>{},
    );

    final repo = ref.read(profileRepositoryProvider);
    final biometric = ref.read(biometricServiceProvider);
    final deviceInfo = ref.read(deviceInfoServiceProvider);

    final profileFuture = repo.fetchMyProfile();
    final bioSupportedFuture = biometric.isHardwareAvailable();
    final deviceMetaFuture = deviceInfo.readDeviceMetadata();

    final (profile, failure) = await profileFuture;
    final bioSupported = await bioSupportedFuture;
    final deviceMeta = await deviceMetaFuture;
    final bioEnabled = biometric.isEnabledByUser();

    if (!ref.mounted) return;

    if (profile != null) {
      if (profile.permissions.isNotEmpty) {
        ref
            .read(userPermissionsControllerProvider.notifier)
            .setPermissions(profile.permissions);
      }
      state = state.copyWith(
        profile: profile,
        isLoading: false,
        isBiometricSupported: bioSupported,
        isBiometricEnabled: bioEnabled,
        deviceMetadata: deviceMeta,
        failure: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isBiometricSupported: bioSupported,
        isBiometricEnabled: bioEnabled,
        deviceMetadata: deviceMeta,
        failure: failure ?? const AppFailure.unknown(),
      );
    }
  }

  /// Updates self-editable fields (`phone_number`, `avatar_url`) via
  /// `PATCH /api/v1/employees/me`. Maps 422 field errors onto
  /// `profileFieldErrors`.
  Future<AppFailure?> updateSelfProfile({
    String? phoneNumber,
    String? avatarUrl,
  }) async {
    state = state.copyWith(
      isSavingProfile: true,
      failure: null,
      photoValidationError: null,
      profileFieldErrors: const <String, List<String>>{},
    );

    final payload = EmployeeSelfUpdatePayload(
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
    );
    final (updated, failure) = await ref
        .read(profileRepositoryProvider)
        .updateMyProfile(payload);

    if (!ref.mounted) return failure;

    if (updated != null) {
      final merged = state.profile != null
          ? updated.copyWith(permissions: state.profile!.permissions)
          : updated;
      state = state.copyWith(
        profile: merged,
        isSavingProfile: false,
        failure: null,
        profileFieldErrors: const <String, List<String>>{},
      );
      return null;
    }

    final fieldErrors = switch (failure) {
      ValidationFailure(fieldErrors: final map) => map,
      _ => const <String, List<String>>{},
    };

    state = state.copyWith(
      isSavingProfile: false,
      failure: failure,
      profileFieldErrors: fieldErrors,
    );
    return failure;
  }

  /// Picks and compresses a photo from [source], validates size & MIME type
  /// against [RuntimeAppConfig], and submits `PATCH /api/v1/employees/me`.
  ///
  /// Returns `true` when a photo was picked, validated, and saved.
  Future<bool> pickAndUploadPhoto(ImageSource source) async {
    state = state.copyWith(
      photoValidationError: null,
      failure: null,
      profileFieldErrors: const <String, List<String>>{},
    );

    final picker = ref.read(photoPickerServiceProvider);
    final picked = await picker.pickCompressedPhoto(source);
    if (!ref.mounted || picked == null) {
      return false;
    }

    final appConfig = ref.read(runtimeAppConfigControllerProvider);
    final validationError = PhotoPickerService.validatePickedPhoto(
      picked,
      appConfig,
    );
    if (validationError != null) {
      state = state.copyWith(photoValidationError: validationError);
      return false;
    }

    final failure = await updateSelfProfile(
      phoneNumber: state.profile?.phoneNumber,
      avatarUrl: picked.pathOrUri,
    );
    return failure == null;
  }

  /// Changes the current user's password via `POST /api/v1/auth/change-password`
  /// and maps 422 field errors onto `passwordFieldErrors`.
  Future<AppFailure?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(
      isChangingPassword: true,
      failure: null,
      passwordFieldErrors: const <String, List<String>>{},
    );

    final failure = await ref
        .read(authRepositoryProvider)
        .changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );

    if (!ref.mounted) return failure;

    if (failure == null) {
      state = state.copyWith(
        isChangingPassword: false,
        passwordFieldErrors: const <String, List<String>>{},
      );
      return null;
    }

    final fieldErrors = switch (failure) {
      ValidationFailure(fieldErrors: final map) => map,
      _ => const <String, List<String>>{},
    };

    state = state.copyWith(
      isChangingPassword: false,
      failure: failure,
      passwordFieldErrors: fieldErrors,
    );
    return failure;
  }

  /// Clears transient password field errors when reopening or editing the
  /// change-password sheet.
  void clearPasswordFieldErrors() {
    if (state.passwordFieldErrors.isNotEmpty) {
      state = state.copyWith(
        passwordFieldErrors: const <String, List<String>>{},
      );
    }
  }

  /// Toggles biometric unlock preference.
  Future<bool> toggleBiometric({
    required bool enabled,
    required String localizedReason,
  }) async {
    final biometric = ref.read(biometricServiceProvider);
    if (enabled) {
      final authenticated = await biometric.authenticate(
        localizedReason: localizedReason,
      );
      if (!ref.mounted) return false;
      if (!authenticated) {
        return false;
      }
      await biometric.setEnabledByUser(enabled: true);
      if (!ref.mounted) return false;
      state = state.copyWith(isBiometricEnabled: true);
      return true;
    } else {
      await biometric.setEnabledByUser(enabled: false);
      if (!ref.mounted) return false;
      state = state.copyWith(isBiometricEnabled: false);
      return true;
    }
  }
}
