// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmployeeProfile _$EmployeeProfileFromJson(Map<String, dynamic> json) =>
    _EmployeeProfile(
      id: json['id'] as String,
      employeeCode: json['employee_code'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      roleId: json['role_id'] as String,
      phoneNumber: json['phone_number'] as String?,
      designation: json['designation'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      mustChangePassword: json['must_change_password'] as bool? ?? false,
      joiningDate: json['joining_date'] as String?,
      departmentId: json['department_id'] as String?,
      departmentName: json['department_name'] as String?,
      roleName: json['role_name'] as String?,
      attendancePolicyId: json['attendance_policy_id'] as String?,
      attendancePolicyName: json['attendance_policy_name'] as String?,
      managerId: json['manager_id'] as String?,
      managerName: json['manager_name'] as String?,
      createdAt: json['created_at'] as String?,
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$EmployeeProfileToJson(_EmployeeProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_code': instance.employeeCode,
      'email': instance.email,
      'full_name': instance.fullName,
      'role_id': instance.roleId,
      'phone_number': instance.phoneNumber,
      'designation': instance.designation,
      'avatar_url': instance.avatarUrl,
      'is_active': instance.isActive,
      'must_change_password': instance.mustChangePassword,
      'joining_date': instance.joiningDate,
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'role_name': instance.roleName,
      'attendance_policy_id': instance.attendancePolicyId,
      'attendance_policy_name': instance.attendancePolicyName,
      'manager_id': instance.managerId,
      'manager_name': instance.managerName,
      'created_at': instance.createdAt,
      'permissions': instance.permissions,
    };

_EmployeeSelfUpdatePayload _$EmployeeSelfUpdatePayloadFromJson(
  Map<String, dynamic> json,
) => _EmployeeSelfUpdatePayload(
  phoneNumber: json['phone_number'] as String?,
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$EmployeeSelfUpdatePayloadToJson(
  _EmployeeSelfUpdatePayload instance,
) => <String, dynamic>{
  'phone_number': ?instance.phoneNumber,
  'avatar_url': ?instance.avatarUrl,
};
