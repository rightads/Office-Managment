import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/profile/domain/profile_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

/// Repository for employee self-service profile (`GET /api/v1/employees/me`
/// and `PATCH /api/v1/employees/me`).
class ProfileRepository {
  ProfileRepository({required this._dio});

  final Dio _dio;

  /// Fetches the current employee's full profile and resolved permissions.
  Future<(EmployeeProfile?, AppFailure?)> fetchMyProfile() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.employeesMe,
      );
      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (EmployeeProfile.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Updates the current employee's self-editable fields (`phone_number`,
  /// `avatar_url`).
  Future<(EmployeeProfile?, AppFailure?)> updateMyProfile(
    EmployeeSelfUpdatePayload payload,
  ) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.employeesMe,
        data: payload.toJson(),
      );
      final raw = response.data;
      if (raw != null) {
        final data = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (EmployeeProfile.fromJson(data), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(dio: ref.watch(dioProvider));
}
