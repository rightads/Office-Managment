import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'security_service.g.dart';

/// Models client security attributes sent to the server for verification.
class DeviceSecurityContext {
  const DeviceSecurityContext({
    required this.isMockLocation,
    required this.deviceId,
    this.osVersion,
  });

  final bool isMockLocation;
  final String deviceId;
  final String? osVersion;

  Map<String, dynamic> toMap() => {
    'is_mock_location': isMockLocation,
    'device_id': deviceId,
    if (osVersion != null) 'os_version': osVersion,
  };
}

/// Service providing security utilities: clipboard hygiene, secure headers,
/// and client integrity telemetry (reported to server; server retains truth).
class SecurityService {
  const SecurityService();

  /// Safely clears clipboard after copying sensitive tokens or temporary credentials.
  Future<void> clearSensitiveClipboard() async {
    try {
      await Clipboard.setData(const ClipboardData(text: ''));
    } on Exception catch (_) {
      // Ignored if platform restricts clipboard access
    }
  }

  /// Evaluates whether location results contain mock indicators.
  bool isPositionMocked({required bool isMocked}) {
    return isMocked;
  }
}

@riverpod
SecurityService securityService(Ref ref) {
  return const SecurityService();
}
