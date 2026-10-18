// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthUser {

 String get id; String get employeeCode; String get fullName; String get email; String get roleLabel; List<String> get permissions; bool get mustChangePassword; String? get phone; String? get designation; String? get departmentId;
/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserCopyWith<AuthUser> get copyWith => _$AuthUserCopyWithImpl<AuthUser>(this as AuthUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUser&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId));
}


@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,roleLabel,const DeepCollectionEquality().hash(permissions),mustChangePassword,phone,designation,departmentId);

@override
String toString() {
  return 'AuthUser(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, roleLabel: $roleLabel, permissions: $permissions, mustChangePassword: $mustChangePassword, phone: $phone, designation: $designation, departmentId: $departmentId)';
}


}

/// @nodoc
abstract mixin class $AuthUserCopyWith<$Res>  {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) _then) = _$AuthUserCopyWithImpl;
@useResult
$Res call({
 String id, String employeeCode, String fullName, String email, String roleLabel, List<String> permissions, bool mustChangePassword, String? phone, String? designation, String? departmentId
});




}
/// @nodoc
class _$AuthUserCopyWithImpl<$Res>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._self, this._then);

  final AuthUser _self;
  final $Res Function(AuthUser) _then;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? roleLabel = null,Object? permissions = null,Object? mustChangePassword = null,Object? phone = freezed,Object? designation = freezed,Object? departmentId = freezed,}) {
  return _then(AuthUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthUser].
extension AuthUserPatterns on AuthUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthUser value)  $default,){
final _that = this;
switch (_that) {
case _AuthUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthUser value)?  $default,){
final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String employeeCode,  String fullName,  String email,  String roleLabel,  List<String> permissions,  bool mustChangePassword,  String? phone,  String? designation,  String? departmentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.roleLabel,_that.permissions,_that.mustChangePassword,_that.phone,_that.designation,_that.departmentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String employeeCode,  String fullName,  String email,  String roleLabel,  List<String> permissions,  bool mustChangePassword,  String? phone,  String? designation,  String? departmentId)  $default,) {final _that = this;
switch (_that) {
case _AuthUser():
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.roleLabel,_that.permissions,_that.mustChangePassword,_that.phone,_that.designation,_that.departmentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String employeeCode,  String fullName,  String email,  String roleLabel,  List<String> permissions,  bool mustChangePassword,  String? phone,  String? designation,  String? departmentId)?  $default,) {final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.roleLabel,_that.permissions,_that.mustChangePassword,_that.phone,_that.designation,_that.departmentId);case _:
  return null;

}
}

}

/// @nodoc


class _AuthUser implements AuthUser {
  const _AuthUser({required this.id, required this.employeeCode, required this.fullName, required this.email, required this.roleLabel, required  List<String> permissions, required this.mustChangePassword, this.phone, this.designation, this.departmentId}): _permissions = permissions;
  

@override final  String id;
@override final  String employeeCode;
@override final  String fullName;
@override final  String email;
@override final  String roleLabel;
 final  List<String> _permissions;
@override List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override final  bool mustChangePassword;
@override final  String? phone;
@override final  String? designation;
@override final  String? departmentId;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthUserCopyWith<_AuthUser> get copyWith => __$AuthUserCopyWithImpl<_AuthUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthUser&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId));
}


@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,roleLabel,const DeepCollectionEquality().hash(_permissions),mustChangePassword,phone,designation,departmentId);

@override
String toString() {
  return 'AuthUser(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, roleLabel: $roleLabel, permissions: $permissions, mustChangePassword: $mustChangePassword, phone: $phone, designation: $designation, departmentId: $departmentId)';
}


}

/// @nodoc
abstract mixin class _$AuthUserCopyWith<$Res> implements $AuthUserCopyWith<$Res> {
  factory _$AuthUserCopyWith(_AuthUser value, $Res Function(_AuthUser) _then) = __$AuthUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String employeeCode, String fullName, String email, String roleLabel, List<String> permissions, bool mustChangePassword, String? phone, String? designation, String? departmentId
});




}
/// @nodoc
class __$AuthUserCopyWithImpl<$Res>
    implements _$AuthUserCopyWith<$Res> {
  __$AuthUserCopyWithImpl(this._self, this._then);

  final _AuthUser _self;
  final $Res Function(_AuthUser) _then;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? roleLabel = null,Object? permissions = null,Object? mustChangePassword = null,Object? phone = freezed,Object? designation = freezed,Object? departmentId = freezed,}) {
  return _then(_AuthUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
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
