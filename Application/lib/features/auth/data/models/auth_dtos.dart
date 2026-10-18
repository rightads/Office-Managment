import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dtos.freezed.dart';
part 'auth_dtos.g.dart';

@freezed
abstract class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String email,
    required String password,
    @JsonKey(name: 'device_id') String? deviceId,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}

@freezed
abstract class TokenResponseDto with _$TokenResponseDto {
  const factory TokenResponseDto({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'expires_in_minutes') required int expiresInMinutes,
    @JsonKey(name: 'token_type') @Default('bearer') String tokenType,
  }) = _TokenResponseDto;

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDtoFromJson(json);
}

@freezed
abstract class RefreshTokenRequestDto with _$RefreshTokenRequestDto {
  const factory RefreshTokenRequestDto({
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'device_id') String? deviceId,
  }) = _RefreshTokenRequestDto;

  factory RefreshTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDtoFromJson(json);
}

@freezed
abstract class ChangePasswordRequestDto with _$ChangePasswordRequestDto {
  const factory ChangePasswordRequestDto({
    @JsonKey(name: 'current_password') required String currentPassword,
    @JsonKey(name: 'new_password') required String newPassword,
  }) = _ChangePasswordRequestDto;

  factory ChangePasswordRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestDtoFromJson(json);
}

@freezed
abstract class ForgotPasswordRequestDto with _$ForgotPasswordRequestDto {
  const factory ForgotPasswordRequestDto({
    required String email,
  }) = _ForgotPasswordRequestDto;

  factory ForgotPasswordRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestDtoFromJson(json);
}

@freezed
abstract class ResetPasswordRequestDto with _$ResetPasswordRequestDto {
  const factory ResetPasswordRequestDto({
    required String token,
    @JsonKey(name: 'new_password') required String newPassword,
  }) = _ResetPasswordRequestDto;

  factory ResetPasswordRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestDtoFromJson(json);
}

@freezed
abstract class UserProfileResponseDto with _$UserProfileResponseDto {
  const factory UserProfileResponseDto({
    required String id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    required String role,
    required List<String> permissions,
    @JsonKey(name: 'must_change_password') required bool mustChangePassword,
    String? phone,
    String? designation,
    @JsonKey(name: 'department_id') String? departmentId,
  }) = _UserProfileResponseDto;

  factory UserProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseDtoFromJson(json);
}
