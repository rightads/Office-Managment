import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

/// Sealed result for GPS position acquisition during attendance check-in/out.
sealed class LocationAcquisitionResult {
  const LocationAcquisitionResult();
}

/// Successfully acquired a valid GPS position.
final class LocationSuccess extends LocationAcquisitionResult {
  const LocationSuccess({
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
    required this.isMockLocation,
  });

  final double latitude;
  final double longitude;
  final double accuracyMeters;
  final bool isMockLocation;
}

/// Device location services (GPS) are turned off.
final class LocationServiceDisabled extends LocationAcquisitionResult {
  const LocationServiceDisabled();
}

/// Location permission was denied for this request.
final class LocationPermissionDenied extends LocationAcquisitionResult {
  const LocationPermissionDenied();
}

/// Location permission was permanently denied; user must open App Settings.
final class LocationPermissionDeniedForever extends LocationAcquisitionResult {
  const LocationPermissionDeniedForever();
}

/// Mock / spoofed GPS provider was detected on the device.
final class LocationMockDetected extends LocationAcquisitionResult {
  const LocationMockDetected({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

/// GPS horizontal accuracy is worse than the required threshold.
final class LocationPoorAccuracy extends LocationAcquisitionResult {
  const LocationPoorAccuracy({
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
    required this.maxAllowedMeters,
  });

  final double latitude;
  final double longitude;
  final double accuracyMeters;
  final double maxAllowedMeters;
}

/// Unexpected error while reading GPS position.
final class LocationError extends LocationAcquisitionResult {
  const LocationError(this.message);

  final String message;
}

/// Result of evaluating a user's coordinates against `policy.allowed_locations`.
class GeofenceEvaluation {
  const GeofenceEvaluation({
    required this.isWithinGeofence,
    this.nearestOffice,
    this.distanceMeters,
  });

  final bool isWithinGeofence;
  final OfficeLocationModel? nearestOffice;
  final double? distanceMeters;
}

/// Service abstracting GPS acquisition, permission handling, mock-location
/// detection, and Haversine geofence distance calculation.
class LocationService {
  const LocationService();

  static const double defaultMaxAccuracyMeters = 100;

  /// Acquires the current device location and validates permissions, mock
  /// status, and horizontal accuracy.
  Future<LocationAcquisitionResult> acquirePosition({
    double maxAccuracyMeters = defaultMaxAccuracyMeters,
    bool enforceAccuracy = true,
  }) async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const LocationServiceDisabled();
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const LocationPermissionDenied();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return const LocationPermissionDeniedForever();
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      if (position.isMocked) {
        return LocationMockDetected(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      }

      if (enforceAccuracy &&
          position.accuracy > 0 &&
          position.accuracy > maxAccuracyMeters) {
        return LocationPoorAccuracy(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracyMeters: position.accuracy,
          maxAllowedMeters: maxAccuracyMeters,
        );
      }

      return LocationSuccess(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracyMeters: position.accuracy,
        isMockLocation: position.isMocked,
      );
    } on Object catch (e) {
      return LocationError(e.toString());
    }
  }

  /// Opens the OS application settings screen (for permanently denied permissions).
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  /// Opens the OS location settings screen (when GPS is disabled).
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  /// Calculates the great-circle distance in meters between two WGS84
  /// coordinates using the Haversine formula (matching `app/utils/geofence.py`).
  double calculateDistanceMeters(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadiusMeters = 6371000.0;
    final phi1 = _degreesToRadians(lat1);
    final phi2 = _degreesToRadians(lat2);
    final deltaPhi = _degreesToRadians(lat2 - lat1);
    final deltaLambda = _degreesToRadians(lon2 - lon1);

    final sinDeltaPhi = math.sin(deltaPhi / 2.0);
    final sinDeltaLambda = math.sin(deltaLambda / 2.0);

    final a =
        (sinDeltaPhi * sinDeltaPhi) +
        math.cos(phi1) * math.cos(phi2) * (sinDeltaLambda * sinDeltaLambda);
    final c = 2.0 * math.atan2(math.sqrt(a), math.sqrt(1.0 - a));

    return earthRadiusMeters * c;
  }

  /// Evaluates [latitude] and [longitude] against active office locations in
  /// [allowedLocations], returning the nearest office, distance in meters,
  /// and whether the user is within any active office's radius.
  GeofenceEvaluation evaluateGeofence({
    required double latitude,
    required double longitude,
    required List<OfficeLocationModel> allowedLocations,
  }) {
    final activeLocations = allowedLocations
        .where((loc) => loc.isActive)
        .toList();
    if (activeLocations.isEmpty) {
      return const GeofenceEvaluation(isWithinGeofence: false);
    }

    OfficeLocationModel? nearest;
    double? minDistance;
    var withinAny = false;

    for (final office in activeLocations) {
      final distance = calculateDistanceMeters(
        latitude,
        longitude,
        office.latitude,
        office.longitude,
      );
      if (distance <= office.radiusMeters) {
        withinAny = true;
      }
      if (minDistance == null || distance < minDistance) {
        minDistance = distance;
        nearest = office;
      }
    }

    return GeofenceEvaluation(
      isWithinGeofence: withinAny,
      nearestOffice: nearest,
      distanceMeters: minDistance,
    );
  }

  double _degreesToRadians(double degrees) => degrees * (math.pi / 180.0);
}

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) {
  return const LocationService();
}
