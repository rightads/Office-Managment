// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequestDto {

 String get email; String get password;@JsonKey(name: 'device_id') String? get deviceId;
/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestDtoCopyWith<LoginRequestDto> get copyWith => _$LoginRequestDtoCopyWithImpl<LoginRequestDto>(this as LoginRequestDto, _$identity);

  /// Serializes this LoginRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,deviceId);

@override
String toString() {
  return 'LoginRequestDto(email: $email, password: $password, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $LoginRequestDtoCopyWith<$Res>  {
  factory $LoginRequestDtoCopyWith(LoginRequestDto value, $Res Function(LoginRequestDto) _then) = _$LoginRequestDtoCopyWithImpl;
@useResult
$Res call({
 String email, String password,@JsonKey(name: 'device_id') String? deviceId
});




}
/// @nodoc
class _$LoginRequestDtoCopyWithImpl<$Res>
    implements $LoginRequestDtoCopyWith<$Res> {
  _$LoginRequestDtoCopyWithImpl(this._self, this._then);

  final LoginRequestDto _self;
  final $Res Function(LoginRequestDto) _then;

/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? deviceId = freezed,}) {
  return _then(LoginRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequestDto].
extension LoginRequestDtoPatterns on LoginRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(name: 'device_id')  String? deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that.email,_that.password,_that.deviceId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(name: 'device_id')  String? deviceId)  $default,) {final _that = this;
switch (_that) {
case _LoginRequestDto():
return $default(_that.email,_that.password,_that.deviceId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password, @JsonKey(name: 'device_id')  String? deviceId)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that.email,_that.password,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequestDto implements LoginRequestDto {
  const _LoginRequestDto({required this.email, required this.password, @JsonKey(name: 'device_id') this.deviceId});
  factory _LoginRequestDto.fromJson(Map<String, dynamic> json) => _$LoginRequestDtoFromJson(json);

@override final  String email;
@override final  String password;
@override@JsonKey(name: 'device_id') final  String? deviceId;

/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestDtoCopyWith<_LoginRequestDto> get copyWith => __$LoginRequestDtoCopyWithImpl<_LoginRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,deviceId);

@override
String toString() {
  return 'LoginRequestDto(email: $email, password: $password, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestDtoCopyWith<$Res> implements $LoginRequestDtoCopyWith<$Res> {
  factory _$LoginRequestDtoCopyWith(_LoginRequestDto value, $Res Function(_LoginRequestDto) _then) = __$LoginRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String email, String password,@JsonKey(name: 'device_id') String? deviceId
});




}
/// @nodoc
class __$LoginRequestDtoCopyWithImpl<$Res>
    implements _$LoginRequestDtoCopyWith<$Res> {
  __$LoginRequestDtoCopyWithImpl(this._self, this._then);

  final _LoginRequestDto _self;
  final $Res Function(_LoginRequestDto) _then;

/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? deviceId = freezed,}) {
  return _then(_LoginRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TokenResponseDto {

@JsonKey(name: 'access_token') String get accessToken;@JsonKey(name: 'refresh_token') String get refreshToken;@JsonKey(name: 'expires_in_minutes') int get expiresInMinutes;@JsonKey(name: 'token_type') String get tokenType;
/// Create a copy of TokenResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenResponseDtoCopyWith<TokenResponseDto> get copyWith => _$TokenResponseDtoCopyWithImpl<TokenResponseDto>(this as TokenResponseDto, _$identity);

  /// Serializes this TokenResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenResponseDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresInMinutes, expiresInMinutes) || other.expiresInMinutes == expiresInMinutes)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,expiresInMinutes,tokenType);

@override
String toString() {
  return 'TokenResponseDto(accessToken: $accessToken, refreshToken: $refreshToken, expiresInMinutes: $expiresInMinutes, tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class $TokenResponseDtoCopyWith<$Res>  {
  factory $TokenResponseDtoCopyWith(TokenResponseDto value, $Res Function(TokenResponseDto) _then) = _$TokenResponseDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'expires_in_minutes') int expiresInMinutes,@JsonKey(name: 'token_type') String tokenType
});




}
/// @nodoc
class _$TokenResponseDtoCopyWithImpl<$Res>
    implements $TokenResponseDtoCopyWith<$Res> {
  _$TokenResponseDtoCopyWithImpl(this._self, this._then);

  final TokenResponseDto _self;
  final $Res Function(TokenResponseDto) _then;

/// Create a copy of TokenResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? expiresInMinutes = null,Object? tokenType = null,}) {
  return _then(TokenResponseDto(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresInMinutes: null == expiresInMinutes ? _self.expiresInMinutes : expiresInMinutes // ignore: cast_nullable_to_non_nullable
as int,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenResponseDto].
extension TokenResponseDtoPatterns on TokenResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _TokenResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _TokenResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'expires_in_minutes')  int expiresInMinutes, @JsonKey(name: 'token_type')  String tokenType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenResponseDto() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresInMinutes,_that.tokenType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'expires_in_minutes')  int expiresInMinutes, @JsonKey(name: 'token_type')  String tokenType)  $default,) {final _that = this;
switch (_that) {
case _TokenResponseDto():
return $default(_that.accessToken,_that.refreshToken,_that.expiresInMinutes,_that.tokenType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'expires_in_minutes')  int expiresInMinutes, @JsonKey(name: 'token_type')  String tokenType)?  $default,) {final _that = this;
switch (_that) {
case _TokenResponseDto() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresInMinutes,_that.tokenType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenResponseDto implements TokenResponseDto {
  const _TokenResponseDto({@JsonKey(name: 'access_token') required this.accessToken, @JsonKey(name: 'refresh_token') required this.refreshToken, @JsonKey(name: 'expires_in_minutes') required this.expiresInMinutes, @JsonKey(name: 'token_type') this.tokenType = 'bearer'});
  factory _TokenResponseDto.fromJson(Map<String, dynamic> json) => _$TokenResponseDtoFromJson(json);

@override@JsonKey(name: 'access_token') final  String accessToken;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;
@override@JsonKey(name: 'expires_in_minutes') final  int expiresInMinutes;
@override@JsonKey(name: 'token_type') final  String tokenType;

/// Create a copy of TokenResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenResponseDtoCopyWith<_TokenResponseDto> get copyWith => __$TokenResponseDtoCopyWithImpl<_TokenResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenResponseDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresInMinutes, expiresInMinutes) || other.expiresInMinutes == expiresInMinutes)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,expiresInMinutes,tokenType);

@override
String toString() {
  return 'TokenResponseDto(accessToken: $accessToken, refreshToken: $refreshToken, expiresInMinutes: $expiresInMinutes, tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class _$TokenResponseDtoCopyWith<$Res> implements $TokenResponseDtoCopyWith<$Res> {
  factory _$TokenResponseDtoCopyWith(_TokenResponseDto value, $Res Function(_TokenResponseDto) _then) = __$TokenResponseDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'expires_in_minutes') int expiresInMinutes,@JsonKey(name: 'token_type') String tokenType
});




}
/// @nodoc
class __$TokenResponseDtoCopyWithImpl<$Res>
    implements _$TokenResponseDtoCopyWith<$Res> {
  __$TokenResponseDtoCopyWithImpl(this._self, this._then);

  final _TokenResponseDto _self;
  final $Res Function(_TokenResponseDto) _then;

/// Create a copy of TokenResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? expiresInMinutes = null,Object? tokenType = null,}) {
  return _then(_TokenResponseDto(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresInMinutes: null == expiresInMinutes ? _self.expiresInMinutes : expiresInMinutes // ignore: cast_nullable_to_non_nullable
as int,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RefreshTokenRequestDto {

@JsonKey(name: 'refresh_token') String get refreshToken;@JsonKey(name: 'device_id') String? get deviceId;
/// Create a copy of RefreshTokenRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshTokenRequestDtoCopyWith<RefreshTokenRequestDto> get copyWith => _$RefreshTokenRequestDtoCopyWithImpl<RefreshTokenRequestDto>(this as RefreshTokenRequestDto, _$identity);

  /// Serializes this RefreshTokenRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTokenRequestDto&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken,deviceId);

@override
String toString() {
  return 'RefreshTokenRequestDto(refreshToken: $refreshToken, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $RefreshTokenRequestDtoCopyWith<$Res>  {
  factory $RefreshTokenRequestDtoCopyWith(RefreshTokenRequestDto value, $Res Function(RefreshTokenRequestDto) _then) = _$RefreshTokenRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'device_id') String? deviceId
});




}
/// @nodoc
class _$RefreshTokenRequestDtoCopyWithImpl<$Res>
    implements $RefreshTokenRequestDtoCopyWith<$Res> {
  _$RefreshTokenRequestDtoCopyWithImpl(this._self, this._then);

  final RefreshTokenRequestDto _self;
  final $Res Function(RefreshTokenRequestDto) _then;

/// Create a copy of RefreshTokenRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? refreshToken = null,Object? deviceId = freezed,}) {
  return _then(RefreshTokenRequestDto(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RefreshTokenRequestDto].
extension RefreshTokenRequestDtoPatterns on RefreshTokenRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshTokenRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshTokenRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshTokenRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshTokenRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'device_id')  String? deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshTokenRequestDto() when $default != null:
return $default(_that.refreshToken,_that.deviceId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'device_id')  String? deviceId)  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenRequestDto():
return $default(_that.refreshToken,_that.deviceId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'device_id')  String? deviceId)?  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenRequestDto() when $default != null:
return $default(_that.refreshToken,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshTokenRequestDto implements RefreshTokenRequestDto {
  const _RefreshTokenRequestDto({@JsonKey(name: 'refresh_token') required this.refreshToken, @JsonKey(name: 'device_id') this.deviceId});
  factory _RefreshTokenRequestDto.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestDtoFromJson(json);

@override@JsonKey(name: 'refresh_token') final  String refreshToken;
@override@JsonKey(name: 'device_id') final  String? deviceId;

/// Create a copy of RefreshTokenRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshTokenRequestDtoCopyWith<_RefreshTokenRequestDto> get copyWith => __$RefreshTokenRequestDtoCopyWithImpl<_RefreshTokenRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshTokenRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTokenRequestDto&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken,deviceId);

@override
String toString() {
  return 'RefreshTokenRequestDto(refreshToken: $refreshToken, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$RefreshTokenRequestDtoCopyWith<$Res> implements $RefreshTokenRequestDtoCopyWith<$Res> {
  factory _$RefreshTokenRequestDtoCopyWith(_RefreshTokenRequestDto value, $Res Function(_RefreshTokenRequestDto) _then) = __$RefreshTokenRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'device_id') String? deviceId
});




}
/// @nodoc
class __$RefreshTokenRequestDtoCopyWithImpl<$Res>
    implements _$RefreshTokenRequestDtoCopyWith<$Res> {
  __$RefreshTokenRequestDtoCopyWithImpl(this._self, this._then);

  final _RefreshTokenRequestDto _self;
  final $Res Function(_RefreshTokenRequestDto) _then;

/// Create a copy of RefreshTokenRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refreshToken = null,Object? deviceId = freezed,}) {
  return _then(_RefreshTokenRequestDto(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChangePasswordRequestDto {

@JsonKey(name: 'current_password') String get currentPassword;@JsonKey(name: 'new_password') String get newPassword;
/// Create a copy of ChangePasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordRequestDtoCopyWith<ChangePasswordRequestDto> get copyWith => _$ChangePasswordRequestDtoCopyWithImpl<ChangePasswordRequestDto>(this as ChangePasswordRequestDto, _$identity);

  /// Serializes this ChangePasswordRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordRequestDto&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordRequestDto(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordRequestDtoCopyWith<$Res>  {
  factory $ChangePasswordRequestDtoCopyWith(ChangePasswordRequestDto value, $Res Function(ChangePasswordRequestDto) _then) = _$ChangePasswordRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'current_password') String currentPassword,@JsonKey(name: 'new_password') String newPassword
});




}
/// @nodoc
class _$ChangePasswordRequestDtoCopyWithImpl<$Res>
    implements $ChangePasswordRequestDtoCopyWith<$Res> {
  _$ChangePasswordRequestDtoCopyWithImpl(this._self, this._then);

  final ChangePasswordRequestDto _self;
  final $Res Function(ChangePasswordRequestDto) _then;

/// Create a copy of ChangePasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(ChangePasswordRequestDto(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordRequestDto].
extension ChangePasswordRequestDtoPatterns on ChangePasswordRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_password')  String currentPassword, @JsonKey(name: 'new_password')  String newPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordRequestDto() when $default != null:
return $default(_that.currentPassword,_that.newPassword);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_password')  String currentPassword, @JsonKey(name: 'new_password')  String newPassword)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequestDto():
return $default(_that.currentPassword,_that.newPassword);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'current_password')  String currentPassword, @JsonKey(name: 'new_password')  String newPassword)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequestDto() when $default != null:
return $default(_that.currentPassword,_that.newPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePasswordRequestDto implements ChangePasswordRequestDto {
  const _ChangePasswordRequestDto({@JsonKey(name: 'current_password') required this.currentPassword, @JsonKey(name: 'new_password') required this.newPassword});
  factory _ChangePasswordRequestDto.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestDtoFromJson(json);

@override@JsonKey(name: 'current_password') final  String currentPassword;
@override@JsonKey(name: 'new_password') final  String newPassword;

/// Create a copy of ChangePasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordRequestDtoCopyWith<_ChangePasswordRequestDto> get copyWith => __$ChangePasswordRequestDtoCopyWithImpl<_ChangePasswordRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePasswordRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordRequestDto&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordRequestDto(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordRequestDtoCopyWith<$Res> implements $ChangePasswordRequestDtoCopyWith<$Res> {
  factory _$ChangePasswordRequestDtoCopyWith(_ChangePasswordRequestDto value, $Res Function(_ChangePasswordRequestDto) _then) = __$ChangePasswordRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'current_password') String currentPassword,@JsonKey(name: 'new_password') String newPassword
});




}
/// @nodoc
class __$ChangePasswordRequestDtoCopyWithImpl<$Res>
    implements _$ChangePasswordRequestDtoCopyWith<$Res> {
  __$ChangePasswordRequestDtoCopyWithImpl(this._self, this._then);

  final _ChangePasswordRequestDto _self;
  final $Res Function(_ChangePasswordRequestDto) _then;

/// Create a copy of ChangePasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_ChangePasswordRequestDto(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ForgotPasswordRequestDto {

 String get email;
/// Create a copy of ForgotPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordRequestDtoCopyWith<ForgotPasswordRequestDto> get copyWith => _$ForgotPasswordRequestDtoCopyWithImpl<ForgotPasswordRequestDto>(this as ForgotPasswordRequestDto, _$identity);

  /// Serializes this ForgotPasswordRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordRequestDto&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordRequestDto(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordRequestDtoCopyWith<$Res>  {
  factory $ForgotPasswordRequestDtoCopyWith(ForgotPasswordRequestDto value, $Res Function(ForgotPasswordRequestDto) _then) = _$ForgotPasswordRequestDtoCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordRequestDtoCopyWithImpl<$Res>
    implements $ForgotPasswordRequestDtoCopyWith<$Res> {
  _$ForgotPasswordRequestDtoCopyWithImpl(this._self, this._then);

  final ForgotPasswordRequestDto _self;
  final $Res Function(ForgotPasswordRequestDto) _then;

/// Create a copy of ForgotPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(ForgotPasswordRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForgotPasswordRequestDto].
extension ForgotPasswordRequestDtoPatterns on ForgotPasswordRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForgotPasswordRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForgotPasswordRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForgotPasswordRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForgotPasswordRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForgotPasswordRequestDto() when $default != null:
return $default(_that.email);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email)  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordRequestDto():
return $default(_that.email);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email)?  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordRequestDto() when $default != null:
return $default(_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForgotPasswordRequestDto implements ForgotPasswordRequestDto {
  const _ForgotPasswordRequestDto({required this.email});
  factory _ForgotPasswordRequestDto.fromJson(Map<String, dynamic> json) => _$ForgotPasswordRequestDtoFromJson(json);

@override final  String email;

/// Create a copy of ForgotPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordRequestDtoCopyWith<_ForgotPasswordRequestDto> get copyWith => __$ForgotPasswordRequestDtoCopyWithImpl<_ForgotPasswordRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForgotPasswordRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordRequestDto&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordRequestDto(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordRequestDtoCopyWith<$Res> implements $ForgotPasswordRequestDtoCopyWith<$Res> {
  factory _$ForgotPasswordRequestDtoCopyWith(_ForgotPasswordRequestDto value, $Res Function(_ForgotPasswordRequestDto) _then) = __$ForgotPasswordRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ForgotPasswordRequestDtoCopyWithImpl<$Res>
    implements _$ForgotPasswordRequestDtoCopyWith<$Res> {
  __$ForgotPasswordRequestDtoCopyWithImpl(this._self, this._then);

  final _ForgotPasswordRequestDto _self;
  final $Res Function(_ForgotPasswordRequestDto) _then;

/// Create a copy of ForgotPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ForgotPasswordRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ResetPasswordRequestDto {

 String get token;@JsonKey(name: 'new_password') String get newPassword;
/// Create a copy of ResetPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordRequestDtoCopyWith<ResetPasswordRequestDto> get copyWith => _$ResetPasswordRequestDtoCopyWithImpl<ResetPasswordRequestDto>(this as ResetPasswordRequestDto, _$identity);

  /// Serializes this ResetPasswordRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordRequestDto&&(identical(other.token, token) || other.token == token)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,newPassword);

@override
String toString() {
  return 'ResetPasswordRequestDto(token: $token, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordRequestDtoCopyWith<$Res>  {
  factory $ResetPasswordRequestDtoCopyWith(ResetPasswordRequestDto value, $Res Function(ResetPasswordRequestDto) _then) = _$ResetPasswordRequestDtoCopyWithImpl;
@useResult
$Res call({
 String token,@JsonKey(name: 'new_password') String newPassword
});




}
/// @nodoc
class _$ResetPasswordRequestDtoCopyWithImpl<$Res>
    implements $ResetPasswordRequestDtoCopyWith<$Res> {
  _$ResetPasswordRequestDtoCopyWithImpl(this._self, this._then);

  final ResetPasswordRequestDto _self;
  final $Res Function(ResetPasswordRequestDto) _then;

/// Create a copy of ResetPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? newPassword = null,}) {
  return _then(ResetPasswordRequestDto(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordRequestDto].
extension ResetPasswordRequestDtoPatterns on ResetPasswordRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPasswordRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPasswordRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPasswordRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPasswordRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token, @JsonKey(name: 'new_password')  String newPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPasswordRequestDto() when $default != null:
return $default(_that.token,_that.newPassword);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token, @JsonKey(name: 'new_password')  String newPassword)  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestDto():
return $default(_that.token,_that.newPassword);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token, @JsonKey(name: 'new_password')  String newPassword)?  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestDto() when $default != null:
return $default(_that.token,_that.newPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResetPasswordRequestDto implements ResetPasswordRequestDto {
  const _ResetPasswordRequestDto({required this.token, @JsonKey(name: 'new_password') required this.newPassword});
  factory _ResetPasswordRequestDto.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestDtoFromJson(json);

@override final  String token;
@override@JsonKey(name: 'new_password') final  String newPassword;

/// Create a copy of ResetPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordRequestDtoCopyWith<_ResetPasswordRequestDto> get copyWith => __$ResetPasswordRequestDtoCopyWithImpl<_ResetPasswordRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPasswordRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordRequestDto&&(identical(other.token, token) || other.token == token)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,newPassword);

@override
String toString() {
  return 'ResetPasswordRequestDto(token: $token, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordRequestDtoCopyWith<$Res> implements $ResetPasswordRequestDtoCopyWith<$Res> {
  factory _$ResetPasswordRequestDtoCopyWith(_ResetPasswordRequestDto value, $Res Function(_ResetPasswordRequestDto) _then) = __$ResetPasswordRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String token,@JsonKey(name: 'new_password') String newPassword
});




}
/// @nodoc
class __$ResetPasswordRequestDtoCopyWithImpl<$Res>
    implements _$ResetPasswordRequestDtoCopyWith<$Res> {
  __$ResetPasswordRequestDtoCopyWithImpl(this._self, this._then);

  final _ResetPasswordRequestDto _self;
  final $Res Function(_ResetPasswordRequestDto) _then;

/// Create a copy of ResetPasswordRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? newPassword = null,}) {
  return _then(_ResetPasswordRequestDto(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserProfileResponseDto {

 String get id;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'full_name') String get fullName; String get email; String get role; List<String> get permissions;@JsonKey(name: 'must_change_password') bool get mustChangePassword; String? get phone; String? get designation;@JsonKey(name: 'department_id') String? get departmentId;
/// Create a copy of UserProfileResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponseDtoCopyWith<UserProfileResponseDto> get copyWith => _$UserProfileResponseDtoCopyWithImpl<UserProfileResponseDto>(this as UserProfileResponseDto, _$identity);

  /// Serializes this UserProfileResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,role,const DeepCollectionEquality().hash(permissions),mustChangePassword,phone,designation,departmentId);

@override
String toString() {
  return 'UserProfileResponseDto(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, role: $role, permissions: $permissions, mustChangePassword: $mustChangePassword, phone: $phone, designation: $designation, departmentId: $departmentId)';
}


}

/// @nodoc
abstract mixin class $UserProfileResponseDtoCopyWith<$Res>  {
  factory $UserProfileResponseDtoCopyWith(UserProfileResponseDto value, $Res Function(UserProfileResponseDto) _then) = _$UserProfileResponseDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email, String role, List<String> permissions,@JsonKey(name: 'must_change_password') bool mustChangePassword, String? phone, String? designation,@JsonKey(name: 'department_id') String? departmentId
});




}
/// @nodoc
class _$UserProfileResponseDtoCopyWithImpl<$Res>
    implements $UserProfileResponseDtoCopyWith<$Res> {
  _$UserProfileResponseDtoCopyWithImpl(this._self, this._then);

  final UserProfileResponseDto _self;
  final $Res Function(UserProfileResponseDto) _then;

/// Create a copy of UserProfileResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? role = null,Object? permissions = null,Object? mustChangePassword = null,Object? phone = freezed,Object? designation = freezed,Object? departmentId = freezed,}) {
  return _then(UserProfileResponseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileResponseDto].
extension UserProfileResponseDtoPatterns on UserProfileResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email,  String role,  List<String> permissions, @JsonKey(name: 'must_change_password')  bool mustChangePassword,  String? phone,  String? designation, @JsonKey(name: 'department_id')  String? departmentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponseDto() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.role,_that.permissions,_that.mustChangePassword,_that.phone,_that.designation,_that.departmentId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email,  String role,  List<String> permissions, @JsonKey(name: 'must_change_password')  bool mustChangePassword,  String? phone,  String? designation, @JsonKey(name: 'department_id')  String? departmentId)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponseDto():
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.role,_that.permissions,_that.mustChangePassword,_that.phone,_that.designation,_that.departmentId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email,  String role,  List<String> permissions, @JsonKey(name: 'must_change_password')  bool mustChangePassword,  String? phone,  String? designation, @JsonKey(name: 'department_id')  String? departmentId)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponseDto() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.role,_that.permissions,_that.mustChangePassword,_that.phone,_that.designation,_that.departmentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponseDto implements UserProfileResponseDto {
  const _UserProfileResponseDto({required this.id, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'full_name') required this.fullName, required this.email, required this.role, required  List<String> permissions, @JsonKey(name: 'must_change_password') required this.mustChangePassword, this.phone, this.designation, @JsonKey(name: 'department_id') this.departmentId}): _permissions = permissions;
  factory _UserProfileResponseDto.fromJson(Map<String, dynamic> json) => _$UserProfileResponseDtoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String email;
@override final  String role;
 final  List<String> _permissions;
@override List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override@JsonKey(name: 'must_change_password') final  bool mustChangePassword;
@override final  String? phone;
@override final  String? designation;
@override@JsonKey(name: 'department_id') final  String? departmentId;

/// Create a copy of UserProfileResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileResponseDtoCopyWith<_UserProfileResponseDto> get copyWith => __$UserProfileResponseDtoCopyWithImpl<_UserProfileResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,role,const DeepCollectionEquality().hash(_permissions),mustChangePassword,phone,designation,departmentId);

@override
String toString() {
  return 'UserProfileResponseDto(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, role: $role, permissions: $permissions, mustChangePassword: $mustChangePassword, phone: $phone, designation: $designation, departmentId: $departmentId)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponseDtoCopyWith<$Res> implements $UserProfileResponseDtoCopyWith<$Res> {
  factory _$UserProfileResponseDtoCopyWith(_UserProfileResponseDto value, $Res Function(_UserProfileResponseDto) _then) = __$UserProfileResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email, String role, List<String> permissions,@JsonKey(name: 'must_change_password') bool mustChangePassword, String? phone, String? designation,@JsonKey(name: 'department_id') String? departmentId
});




}
/// @nodoc
class __$UserProfileResponseDtoCopyWithImpl<$Res>
    implements _$UserProfileResponseDtoCopyWith<$Res> {
  __$UserProfileResponseDtoCopyWithImpl(this._self, this._then);

  final _UserProfileResponseDto _self;
  final $Res Function(_UserProfileResponseDto) _then;

/// Create a copy of UserProfileResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? role = null,Object? permissions = null,Object? mustChangePassword = null,Object? phone = freezed,Object? designation = freezed,Object? departmentId = freezed,}) {
  return _then(_UserProfileResponseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
