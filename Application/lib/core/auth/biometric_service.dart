import 'package:local_auth/local_auth.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'biometric_service.g.dart';

/// Optional local biometric unlock wrapper around [LocalAuthentication].
///
/// Toggled by user preference; never replaces server JWT authentication.
class BiometricService {
  BiometricService({
    required this._preferencesStorage,
    LocalAuthentication? localAuth,
  }) : _localAuth = localAuth ?? LocalAuthentication();

  final PreferencesStorageService _preferencesStorage;
  final LocalAuthentication _localAuth;

  bool isEnabledByUser() {
    try {
      return _preferencesStorage.readBiometricEnabled();
    } on Object {
      return false;
    }
  }

  Future<void> setEnabledByUser({required bool enabled}) async {
    try {
      await _preferencesStorage.writeBiometricEnabled(enabled: enabled);
    } on Object {
      // Non-fatal in test environments where SharedPreferences is not initialized.
    }
  }

  Future<bool> isHardwareAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      return canCheck || isSupported;
    } on Object {
      return false;
    }
  }

  Future<bool> authenticate({required String localizedReason}) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
      );
    } on Object {
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
BiometricService biometricService(Ref ref) {
  return BiometricService(
    preferencesStorage: ref.watch(preferencesStorageServiceProvider),
  );
}
