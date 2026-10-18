import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/auth/data/models/auth_dtos.dart';

part 'auth_user.freezed.dart';

/// Domain entity representing the authenticated employee.
///
/// Note: [roleLabel] is strictly for display in the UI header/profile;
/// access control must use [permissions] via `PermissionCodes` and `ref.can`.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String employeeCode,
    required String fullName,
    required String email,
    required String roleLabel,
    required List<String> permissions,
    required bool mustChangePassword,
    String? phone,
    String? designation,
    String? departmentId,
  }) = _AuthUser;

  factory AuthUser.fromDto(UserProfileResponseDto dto) {
    return AuthUser(
      id: dto.id,
      employeeCode: dto.employeeCode,
      fullName: dto.fullName,
      email: dto.email,
      roleLabel: dto.role,
      permissions: List<String>.unmodifiable(dto.permissions),
      mustChangePassword: dto.mustChangePassword,
      phone: dto.phone,
      designation: dto.designation,
      departmentId: dto.departmentId,
    );
  }
}
