// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthLoading value)?  loading,TResult Function( AuthUnauthenticated value)?  unauthenticated,TResult Function( AuthMustChangePassword value)?  mustChangePassword,TResult Function( AuthAuthenticated value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading(_that);case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthMustChangePassword() when mustChangePassword != null:
return mustChangePassword(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthLoading value)  loading,required TResult Function( AuthUnauthenticated value)  unauthenticated,required TResult Function( AuthMustChangePassword value)  mustChangePassword,required TResult Function( AuthAuthenticated value)  authenticated,}){
final _that = this;
switch (_that) {
case AuthLoading():
return loading(_that);case AuthUnauthenticated():
return unauthenticated(_that);case AuthMustChangePassword():
return mustChangePassword(_that);case AuthAuthenticated():
return authenticated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthLoading value)?  loading,TResult? Function( AuthUnauthenticated value)?  unauthenticated,TResult? Function( AuthMustChangePassword value)?  mustChangePassword,TResult? Function( AuthAuthenticated value)?  authenticated,}){
final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading(_that);case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthMustChangePassword() when mustChangePassword != null:
return mustChangePassword(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( SessionExpiryReason? expiryReason)?  unauthenticated,TResult Function( AuthUser user)?  mustChangePassword,TResult Function( AuthUser user,  bool isBiometricLocked)?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading();case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.expiryReason);case AuthMustChangePassword() when mustChangePassword != null:
return mustChangePassword(_that.user);case AuthAuthenticated() when authenticated != null:
return authenticated(_that.user,_that.isBiometricLocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( SessionExpiryReason? expiryReason)  unauthenticated,required TResult Function( AuthUser user)  mustChangePassword,required TResult Function( AuthUser user,  bool isBiometricLocked)  authenticated,}) {final _that = this;
switch (_that) {
case AuthLoading():
return loading();case AuthUnauthenticated():
return unauthenticated(_that.expiryReason);case AuthMustChangePassword():
return mustChangePassword(_that.user);case AuthAuthenticated():
return authenticated(_that.user,_that.isBiometricLocked);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( SessionExpiryReason? expiryReason)?  unauthenticated,TResult? Function( AuthUser user)?  mustChangePassword,TResult? Function( AuthUser user,  bool isBiometricLocked)?  authenticated,}) {final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading();case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.expiryReason);case AuthMustChangePassword() when mustChangePassword != null:
return mustChangePassword(_that.user);case AuthAuthenticated() when authenticated != null:
return authenticated(_that.user,_that.isBiometricLocked);case _:
  return null;

}
}

}

/// @nodoc


class AuthLoading implements AuthState {
  const AuthLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class AuthUnauthenticated implements AuthState {
  const AuthUnauthenticated({this.expiryReason});
  

 final  SessionExpiryReason? expiryReason;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUnauthenticatedCopyWith<AuthUnauthenticated> get copyWith => _$AuthUnauthenticatedCopyWithImpl<AuthUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUnauthenticated&&(identical(other.expiryReason, expiryReason) || other.expiryReason == expiryReason));
}


@override
int get hashCode => Object.hash(runtimeType,expiryReason);

@override
String toString() {
  return 'AuthState.unauthenticated(expiryReason: $expiryReason)';
}


}

/// @nodoc
abstract mixin class $AuthUnauthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthUnauthenticatedCopyWith(AuthUnauthenticated value, $Res Function(AuthUnauthenticated) _then) = _$AuthUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 SessionExpiryReason? expiryReason
});




}
/// @nodoc
class _$AuthUnauthenticatedCopyWithImpl<$Res>
    implements $AuthUnauthenticatedCopyWith<$Res> {
  _$AuthUnauthenticatedCopyWithImpl(this._self, this._then);

  final AuthUnauthenticated _self;
  final $Res Function(AuthUnauthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expiryReason = freezed,}) {
  return _then(AuthUnauthenticated(
expiryReason: freezed == expiryReason ? _self.expiryReason : expiryReason // ignore: cast_nullable_to_non_nullable
as SessionExpiryReason?,
  ));
}


}

/// @nodoc


class AuthMustChangePassword implements AuthState {
  const AuthMustChangePassword({required this.user});
  

 final  AuthUser user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthMustChangePasswordCopyWith<AuthMustChangePassword> get copyWith => _$AuthMustChangePasswordCopyWithImpl<AuthMustChangePassword>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthMustChangePassword&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.mustChangePassword(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthMustChangePasswordCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthMustChangePasswordCopyWith(AuthMustChangePassword value, $Res Function(AuthMustChangePassword) _then) = _$AuthMustChangePasswordCopyWithImpl;
@useResult
$Res call({
 AuthUser user
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthMustChangePasswordCopyWithImpl<$Res>
    implements $AuthMustChangePasswordCopyWith<$Res> {
  _$AuthMustChangePasswordCopyWithImpl(this._self, this._then);

  final AuthMustChangePassword _self;
  final $Res Function(AuthMustChangePassword) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthMustChangePassword(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class AuthAuthenticated implements AuthState {
  const AuthAuthenticated({required this.user, this.isBiometricLocked = false});
  

 final  AuthUser user;
@JsonKey() final  bool isBiometricLocked;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthAuthenticatedCopyWith<AuthAuthenticated> get copyWith => _$AuthAuthenticatedCopyWithImpl<AuthAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAuthenticated&&(identical(other.user, user) || other.user == user)&&(identical(other.isBiometricLocked, isBiometricLocked) || other.isBiometricLocked == isBiometricLocked));
}


@override
int get hashCode => Object.hash(runtimeType,user,isBiometricLocked);

@override
String toString() {
  return 'AuthState.authenticated(user: $user, isBiometricLocked: $isBiometricLocked)';
}


}

/// @nodoc
abstract mixin class $AuthAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthAuthenticatedCopyWith(AuthAuthenticated value, $Res Function(AuthAuthenticated) _then) = _$AuthAuthenticatedCopyWithImpl;
@useResult
$Res call({
 AuthUser user, bool isBiometricLocked
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthAuthenticatedCopyWithImpl<$Res>
    implements $AuthAuthenticatedCopyWith<$Res> {
  _$AuthAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthAuthenticated _self;
  final $Res Function(AuthAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? isBiometricLocked = null,}) {
  return _then(AuthAuthenticated(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,isBiometricLocked: null == isBiometricLocked ? _self.isBiometricLocked : isBiometricLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
