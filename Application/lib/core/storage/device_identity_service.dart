import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:right_ads/core/storage/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'device_identity_service.g.dart';

/// Generates and persists a stable device identifier in [SecureStorageService]
/// for session binding and attendance device verification.
class DeviceIdentityService {
  DeviceIdentityService({
    required this._secureStorage,
    DeviceInfoPlugin? deviceInfo,
    Uuid? uuid,
  }) : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
       _uuid = uuid ?? const Uuid();

  final SecureStorageService _secureStorage;
  final DeviceInfoPlugin _deviceInfo;
  final Uuid _uuid;

  String? _cachedDeviceId;

  Future<String> getOrCreateDeviceId() async {
    if (_cachedDeviceId != null && _cachedDeviceId!.isNotEmpty) {
      return _cachedDeviceId!;
    }

    final existing = await _secureStorage.readDeviceId();
    if (existing != null && existing.trim().isNotEmpty) {
      _cachedDeviceId = existing.trim();
      return _cachedDeviceId!;
    }

    final prefix = await _resolvePlatformPrefix();
    final generated = '${prefix}_${_uuid.v4()}';
    await _secureStorage.writeDeviceId(generated);
    _cachedDeviceId = generated;
    return generated;
  }

  Future<String> _resolvePlatformPrefix() async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        return 'web_${webInfo.browserName.name}';
      }
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final androidInfo = await _deviceInfo.androidInfo;
          return 'android_${androidInfo.model.replaceAll(RegExp('[^a-zA-Z0-9]'), '')}';
        case TargetPlatform.iOS:
          final iosInfo = await _deviceInfo.iosInfo;
          return 'ios_${iosInfo.utsname.machine.replaceAll(RegExp('[^a-zA-Z0-9]'), '')}';
        case TargetPlatform.windows:
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.fuchsia:
          return defaultTargetPlatform.name;
      }
    } on Object {
      return 'device';
    }
  }
}

@Riverpod(keepAlive: true)
DeviceIdentityService deviceIdentityService(Ref ref) {
  return DeviceIdentityService(
    secureStorage: ref.watch(secureStorageServiceProvider),
  );
}
