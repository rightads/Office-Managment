// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    _LoginRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceId: json['device_id'] as String?,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(_LoginRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_id': instance.deviceId,
    };

_TokenResponseDto _$TokenResponseDtoFromJson(Map<String, dynamic> json) =>
    _TokenResponseDto(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresInMinutes: (json['expires_in_minutes'] as num).toInt(),
      tokenType: json['token_type'] as String? ?? 'bearer',
    );

Map<String, dynamic> _$TokenResponseDtoToJson(_TokenResponseDto instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in_minutes': instance.expiresInMinutes,
      'token_type': instance.tokenType,
    };

_RefreshTokenRequestDto _$RefreshTokenRequestDtoFromJson(
  Map<String, dynamic> json,
) => _RefreshTokenRequestDto(
  refreshToken: json['refresh_token'] as String,
  deviceId: json['device_id'] as String?,
);

Map<String, dynamic> _$RefreshTokenRequestDtoToJson(
  _RefreshTokenRequestDto instance,
) => <String, dynamic>{
  'refresh_token': instance.refreshToken,
  'device_id': instance.deviceId,
};

_ChangePasswordRequestDto _$ChangePasswordRequestDtoFromJson(
  Map<String, dynamic> json,
) => _ChangePasswordRequestDto(
  currentPassword: json['current_password'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestDtoToJson(
  _ChangePasswordRequestDto instance,
) => <String, dynamic>{
  'current_password': instance.currentPassword,
  'new_password': instance.newPassword,
};

_ForgotPasswordRequestDto _$ForgotPasswordRequestDtoFromJson(
  Map<String, dynamic> json,
) => _ForgotPasswordRequestDto(email: json['email'] as String);

Map<String, dynamic> _$ForgotPasswordRequestDtoToJson(
  _ForgotPasswordRequestDto instance,
) => <String, dynamic>{'email': instance.email};

_ResetPasswordRequestDto _$ResetPasswordRequestDtoFromJson(
  Map<String, dynamic> json,
) => _ResetPasswordRequestDto(
  token: json['token'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestDtoToJson(
  _ResetPasswordRequestDto instance,
) => <String, dynamic>{
  'token': instance.token,
  'new_password': instance.newPassword,
};

_UserProfileResponseDto _$UserProfileResponseDtoFromJson(
  Map<String, dynamic> json,
) => _UserProfileResponseDto(
  id: json['id'] as String,
  employeeCode: json['employee_code'] as String,
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  permissions: (json['permissions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  mustChangePassword: json['must_change_password'] as bool,
  phone: json['phone'] as String?,
  designation: json['designation'] as String?,
  departmentId: json['department_id'] as String?,
);

Map<String, dynamic> _$UserProfileResponseDtoToJson(
  _UserProfileResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'employee_code': instance.employeeCode,
  'full_name': instance.fullName,
  'email': instance.email,
  'role': instance.role,
  'permissions': instance.permissions,
  'must_change_password': instance.mustChangePassword,
  'phone': instance.phone,
  'designation': instance.designation,
  'department_id': instance.departmentId,
};
