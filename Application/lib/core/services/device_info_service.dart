import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:right_ads/core/storage/device_identity_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_service.g.dart';

/// Structured hardware and OS metadata displayed on the Profile & Account
/// screen ("device info").
@immutable
class DeviceMetadata {
  const DeviceMetadata({
    required this.deviceId,
    required this.platformName,
    required this.modelName,
    required this.osVersion,
  });

  final String deviceId;
  final String platformName;
  final String modelName;
  final String osVersion;
}

/// Service that collects the bound `device_id` and platform/OS information.
class DeviceInfoService {
  DeviceInfoService({
    required this._deviceIdentityService,
    DeviceInfoPlugin? deviceInfoPlugin,
  }) : _deviceInfo = deviceInfoPlugin ?? DeviceInfoPlugin();

  final DeviceIdentityService _deviceIdentityService;
  final DeviceInfoPlugin _deviceInfo;

  Future<DeviceMetadata> readDeviceMetadata() async {
    var deviceId = 'unknown';
    try {
      deviceId = await _deviceIdentityService.getOrCreateDeviceId();
    } on Object {
      deviceId = 'unknown';
    }

    try {
      if (kIsWeb) {
        final web = await _deviceInfo.webBrowserInfo;
        return DeviceMetadata(
          deviceId: deviceId,
          platformName: 'Web',
          modelName: web.browserName.name,
          osVersion: web.platform ?? 'Browser',
        );
      }
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final android = await _deviceInfo.androidInfo;
          final brand = android.manufacturer.trim();
          final model = android.model.trim();
          return DeviceMetadata(
            deviceId: deviceId,
            platformName: 'Android',
            modelName: brand.isNotEmpty ? '$brand $model' : model,
            osVersion:
                'Android ${android.version.release} (SDK ${android.version.sdkInt})',
          );
        case TargetPlatform.iOS:
          final ios = await _deviceInfo.iosInfo;
          return DeviceMetadata(
            deviceId: deviceId,
            platformName: 'iOS',
            modelName: ios.utsname.machine,
            osVersion: '${ios.systemName} ${ios.systemVersion}',
          );
        case TargetPlatform.windows:
          final win = await _deviceInfo.windowsInfo;
          return DeviceMetadata(
            deviceId: deviceId,
            platformName: 'Windows',
            modelName: win.computerName,
            osVersion:
                '${win.productName} (${win.majorVersion}.${win.minorVersion})',
          );
        case TargetPlatform.macOS:
          final mac = await _deviceInfo.macOsInfo;
          return DeviceMetadata(
            deviceId: deviceId,
            platformName: 'macOS',
            modelName: mac.model,
            osVersion: mac.osRelease,
          );
        case TargetPlatform.linux:
          final linux = await _deviceInfo.linuxInfo;
          return DeviceMetadata(
            deviceId: deviceId,
            platformName: 'Linux',
            modelName: linux.prettyName,
            osVersion: linux.version ?? 'Linux',
          );
        case TargetPlatform.fuchsia:
          return DeviceMetadata(
            deviceId: deviceId,
            platformName: 'Fuchsia',
            modelName: 'Fuchsia Device',
            osVersion: 'Fuchsia',
          );
      }
    } on Object {
      return DeviceMetadata(
        deviceId: deviceId,
        platformName: defaultTargetPlatform.name,
        modelName: defaultTargetPlatform.name,
        osVersion: 'Standard Runtime',
      );
    }
  }
}

@Riverpod(keepAlive: true)
DeviceInfoService deviceInfoService(Ref ref) {
  return DeviceInfoService(
    deviceIdentityService: ref.watch(deviceIdentityServiceProvider),
  );
}
