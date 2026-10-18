// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmployeeProfile {

 String get id;@JsonKey(name: 'employee_code') String get employeeCode; String get email;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'role_id') String get roleId;@JsonKey(name: 'phone_number') String? get phoneNumber; String? get designation;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'must_change_password') bool get mustChangePassword;@JsonKey(name: 'joining_date') String? get joiningDate;@JsonKey(name: 'department_id') String? get departmentId;@JsonKey(name: 'department_name') String? get departmentName;@JsonKey(name: 'role_name') String? get roleName;@JsonKey(name: 'attendance_policy_id') String? get attendancePolicyId;@JsonKey(name: 'attendance_policy_name') String? get attendancePolicyName;@JsonKey(name: 'manager_id') String? get managerId;@JsonKey(name: 'manager_name') String? get managerName;@JsonKey(name: 'created_at') String? get createdAt; List<String> get permissions;
/// Create a copy of EmployeeProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeProfileCopyWith<EmployeeProfile> get copyWith => _$EmployeeProfileCopyWithImpl<EmployeeProfile>(this as EmployeeProfile, _$identity);

  /// Serializes this EmployeeProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.attendancePolicyName, attendancePolicyName) || other.attendancePolicyName == attendancePolicyName)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.managerName, managerName) || other.managerName == managerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.permissions, permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,employeeCode,email,fullName,roleId,phoneNumber,designation,avatarUrl,isActive,mustChangePassword,joiningDate,departmentId,departmentName,roleName,attendancePolicyId,attendancePolicyName,managerId,managerName,createdAt,const DeepCollectionEquality().hash(permissions)]);

@override
String toString() {
  return 'EmployeeProfile(id: $id, employeeCode: $employeeCode, email: $email, fullName: $fullName, roleId: $roleId, phoneNumber: $phoneNumber, designation: $designation, avatarUrl: $avatarUrl, isActive: $isActive, mustChangePassword: $mustChangePassword, joiningDate: $joiningDate, departmentId: $departmentId, departmentName: $departmentName, roleName: $roleName, attendancePolicyId: $attendancePolicyId, attendancePolicyName: $attendancePolicyName, managerId: $managerId, managerName: $managerName, createdAt: $createdAt, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class $EmployeeProfileCopyWith<$Res>  {
  factory $EmployeeProfileCopyWith(EmployeeProfile value, $Res Function(EmployeeProfile) _then) = _$EmployeeProfileCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode, String email,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'role_id') String roleId,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'must_change_password') bool mustChangePassword,@JsonKey(name: 'joining_date') String? joiningDate,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'role_name') String? roleName,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'attendance_policy_name') String? attendancePolicyName,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'manager_name') String? managerName,@JsonKey(name: 'created_at') String? createdAt, List<String> permissions
});




}
/// @nodoc
class _$EmployeeProfileCopyWithImpl<$Res>
    implements $EmployeeProfileCopyWith<$Res> {
  _$EmployeeProfileCopyWithImpl(this._self, this._then);

  final EmployeeProfile _self;
  final $Res Function(EmployeeProfile) _then;

/// Create a copy of EmployeeProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? email = null,Object? fullName = null,Object? roleId = null,Object? phoneNumber = freezed,Object? designation = freezed,Object? avatarUrl = freezed,Object? isActive = null,Object? mustChangePassword = null,Object? joiningDate = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? roleName = freezed,Object? attendancePolicyId = freezed,Object? attendancePolicyName = freezed,Object? managerId = freezed,Object? managerName = freezed,Object? createdAt = freezed,Object? permissions = null,}) {
  return _then(EmployeeProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,roleName: freezed == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyName: freezed == attendancePolicyName ? _self.attendancePolicyName : attendancePolicyName // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,managerName: freezed == managerName ? _self.managerName : managerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeProfile].
extension EmployeeProfilePatterns on EmployeeProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeProfile value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeProfile value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode,  String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'must_change_password')  bool mustChangePassword, @JsonKey(name: 'joining_date')  String? joiningDate, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'role_name')  String? roleName, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'attendance_policy_name')  String? attendancePolicyName, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'manager_name')  String? managerName, @JsonKey(name: 'created_at')  String? createdAt,  List<String> permissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeProfile() when $default != null:
return $default(_that.id,_that.employeeCode,_that.email,_that.fullName,_that.roleId,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.isActive,_that.mustChangePassword,_that.joiningDate,_that.departmentId,_that.departmentName,_that.roleName,_that.attendancePolicyId,_that.attendancePolicyName,_that.managerId,_that.managerName,_that.createdAt,_that.permissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode,  String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'must_change_password')  bool mustChangePassword, @JsonKey(name: 'joining_date')  String? joiningDate, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'role_name')  String? roleName, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'attendance_policy_name')  String? attendancePolicyName, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'manager_name')  String? managerName, @JsonKey(name: 'created_at')  String? createdAt,  List<String> permissions)  $default,) {final _that = this;
switch (_that) {
case _EmployeeProfile():
return $default(_that.id,_that.employeeCode,_that.email,_that.fullName,_that.roleId,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.isActive,_that.mustChangePassword,_that.joiningDate,_that.departmentId,_that.departmentName,_that.roleName,_that.attendancePolicyId,_that.attendancePolicyName,_that.managerId,_that.managerName,_that.createdAt,_that.permissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_code')  String employeeCode,  String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'must_change_password')  bool mustChangePassword, @JsonKey(name: 'joining_date')  String? joiningDate, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'role_name')  String? roleName, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'attendance_policy_name')  String? attendancePolicyName, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'manager_name')  String? managerName, @JsonKey(name: 'created_at')  String? createdAt,  List<String> permissions)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeProfile() when $default != null:
return $default(_that.id,_that.employeeCode,_that.email,_that.fullName,_that.roleId,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.isActive,_that.mustChangePassword,_that.joiningDate,_that.departmentId,_that.departmentName,_that.roleName,_that.attendancePolicyId,_that.attendancePolicyName,_that.managerId,_that.managerName,_that.createdAt,_that.permissions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeProfile implements EmployeeProfile {
  const _EmployeeProfile({required this.id, @JsonKey(name: 'employee_code') required this.employeeCode, required this.email, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'role_id') required this.roleId, @JsonKey(name: 'phone_number') this.phoneNumber, this.designation, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'must_change_password') this.mustChangePassword = false, @JsonKey(name: 'joining_date') this.joiningDate, @JsonKey(name: 'department_id') this.departmentId, @JsonKey(name: 'department_name') this.departmentName, @JsonKey(name: 'role_name') this.roleName, @JsonKey(name: 'attendance_policy_id') this.attendancePolicyId, @JsonKey(name: 'attendance_policy_name') this.attendancePolicyName, @JsonKey(name: 'manager_id') this.managerId, @JsonKey(name: 'manager_name') this.managerName, @JsonKey(name: 'created_at') this.createdAt,  List<String> permissions = const <String>[]}): _permissions = permissions;
  factory _EmployeeProfile.fromJson(Map<String, dynamic> json) => _$EmployeeProfileFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override final  String email;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'role_id') final  String roleId;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String? designation;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'must_change_password') final  bool mustChangePassword;
@override@JsonKey(name: 'joining_date') final  String? joiningDate;
@override@JsonKey(name: 'department_id') final  String? departmentId;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override@JsonKey(name: 'role_name') final  String? roleName;
@override@JsonKey(name: 'attendance_policy_id') final  String? attendancePolicyId;
@override@JsonKey(name: 'attendance_policy_name') final  String? attendancePolicyName;
@override@JsonKey(name: 'manager_id') final  String? managerId;
@override@JsonKey(name: 'manager_name') final  String? managerName;
@override@JsonKey(name: 'created_at') final  String? createdAt;
 final  List<String> _permissions;
@override@JsonKey() List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}


/// Create a copy of EmployeeProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeProfileCopyWith<_EmployeeProfile> get copyWith => __$EmployeeProfileCopyWithImpl<_EmployeeProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.attendancePolicyName, attendancePolicyName) || other.attendancePolicyName == attendancePolicyName)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.managerName, managerName) || other.managerName == managerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._permissions, _permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,employeeCode,email,fullName,roleId,phoneNumber,designation,avatarUrl,isActive,mustChangePassword,joiningDate,departmentId,departmentName,roleName,attendancePolicyId,attendancePolicyName,managerId,managerName,createdAt,const DeepCollectionEquality().hash(_permissions)]);

@override
String toString() {
  return 'EmployeeProfile(id: $id, employeeCode: $employeeCode, email: $email, fullName: $fullName, roleId: $roleId, phoneNumber: $phoneNumber, designation: $designation, avatarUrl: $avatarUrl, isActive: $isActive, mustChangePassword: $mustChangePassword, joiningDate: $joiningDate, departmentId: $departmentId, departmentName: $departmentName, roleName: $roleName, attendancePolicyId: $attendancePolicyId, attendancePolicyName: $attendancePolicyName, managerId: $managerId, managerName: $managerName, createdAt: $createdAt, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class _$EmployeeProfileCopyWith<$Res> implements $EmployeeProfileCopyWith<$Res> {
  factory _$EmployeeProfileCopyWith(_EmployeeProfile value, $Res Function(_EmployeeProfile) _then) = __$EmployeeProfileCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode, String email,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'role_id') String roleId,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'must_change_password') bool mustChangePassword,@JsonKey(name: 'joining_date') String? joiningDate,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'role_name') String? roleName,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'attendance_policy_name') String? attendancePolicyName,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'manager_name') String? managerName,@JsonKey(name: 'created_at') String? createdAt, List<String> permissions
});




}
/// @nodoc
class __$EmployeeProfileCopyWithImpl<$Res>
    implements _$EmployeeProfileCopyWith<$Res> {
  __$EmployeeProfileCopyWithImpl(this._self, this._then);

  final _EmployeeProfile _self;
  final $Res Function(_EmployeeProfile) _then;

/// Create a copy of EmployeeProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? email = null,Object? fullName = null,Object? roleId = null,Object? phoneNumber = freezed,Object? designation = freezed,Object? avatarUrl = freezed,Object? isActive = null,Object? mustChangePassword = null,Object? joiningDate = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? roleName = freezed,Object? attendancePolicyId = freezed,Object? attendancePolicyName = freezed,Object? managerId = freezed,Object? managerName = freezed,Object? createdAt = freezed,Object? permissions = null,}) {
  return _then(_EmployeeProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,roleName: freezed == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyName: freezed == attendancePolicyName ? _self.attendancePolicyName : attendancePolicyName // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,managerName: freezed == managerName ? _self.managerName : managerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EmployeeSelfUpdatePayload {

@JsonKey(name: 'phone_number', includeIfNull: false) String? get phoneNumber;@JsonKey(name: 'avatar_url', includeIfNull: false) String? get avatarUrl;
/// Create a copy of EmployeeSelfUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeSelfUpdatePayloadCopyWith<EmployeeSelfUpdatePayload> get copyWith => _$EmployeeSelfUpdatePayloadCopyWithImpl<EmployeeSelfUpdatePayload>(this as EmployeeSelfUpdatePayload, _$identity);

  /// Serializes this EmployeeSelfUpdatePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeSelfUpdatePayload&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,avatarUrl);

@override
String toString() {
  return 'EmployeeSelfUpdatePayload(phoneNumber: $phoneNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $EmployeeSelfUpdatePayloadCopyWith<$Res>  {
  factory $EmployeeSelfUpdatePayloadCopyWith(EmployeeSelfUpdatePayload value, $Res Function(EmployeeSelfUpdatePayload) _then) = _$EmployeeSelfUpdatePayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'phone_number', includeIfNull: false) String? phoneNumber,@JsonKey(name: 'avatar_url', includeIfNull: false) String? avatarUrl
});




}
/// @nodoc
class _$EmployeeSelfUpdatePayloadCopyWithImpl<$Res>
    implements $EmployeeSelfUpdatePayloadCopyWith<$Res> {
  _$EmployeeSelfUpdatePayloadCopyWithImpl(this._self, this._then);

  final EmployeeSelfUpdatePayload _self;
  final $Res Function(EmployeeSelfUpdatePayload) _then;

/// Create a copy of EmployeeSelfUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(EmployeeSelfUpdatePayload(
phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeSelfUpdatePayload].
extension EmployeeSelfUpdatePayloadPatterns on EmployeeSelfUpdatePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeSelfUpdatePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeSelfUpdatePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeSelfUpdatePayload value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeSelfUpdatePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeSelfUpdatePayload value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeSelfUpdatePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_number', includeIfNull: false)  String? phoneNumber, @JsonKey(name: 'avatar_url', includeIfNull: false)  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeSelfUpdatePayload() when $default != null:
return $default(_that.phoneNumber,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_number', includeIfNull: false)  String? phoneNumber, @JsonKey(name: 'avatar_url', includeIfNull: false)  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _EmployeeSelfUpdatePayload():
return $default(_that.phoneNumber,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'phone_number', includeIfNull: false)  String? phoneNumber, @JsonKey(name: 'avatar_url', includeIfNull: false)  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeSelfUpdatePayload() when $default != null:
return $default(_that.phoneNumber,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeSelfUpdatePayload implements EmployeeSelfUpdatePayload {
  const _EmployeeSelfUpdatePayload({@JsonKey(name: 'phone_number', includeIfNull: false) this.phoneNumber, @JsonKey(name: 'avatar_url', includeIfNull: false) this.avatarUrl});
  factory _EmployeeSelfUpdatePayload.fromJson(Map<String, dynamic> json) => _$EmployeeSelfUpdatePayloadFromJson(json);

@override@JsonKey(name: 'phone_number', includeIfNull: false) final  String? phoneNumber;
@override@JsonKey(name: 'avatar_url', includeIfNull: false) final  String? avatarUrl;

/// Create a copy of EmployeeSelfUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeSelfUpdatePayloadCopyWith<_EmployeeSelfUpdatePayload> get copyWith => __$EmployeeSelfUpdatePayloadCopyWithImpl<_EmployeeSelfUpdatePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeSelfUpdatePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeSelfUpdatePayload&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,avatarUrl);

@override
String toString() {
  return 'EmployeeSelfUpdatePayload(phoneNumber: $phoneNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$EmployeeSelfUpdatePayloadCopyWith<$Res> implements $EmployeeSelfUpdatePayloadCopyWith<$Res> {
  factory _$EmployeeSelfUpdatePayloadCopyWith(_EmployeeSelfUpdatePayload value, $Res Function(_EmployeeSelfUpdatePayload) _then) = __$EmployeeSelfUpdatePayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'phone_number', includeIfNull: false) String? phoneNumber,@JsonKey(name: 'avatar_url', includeIfNull: false) String? avatarUrl
});




}
/// @nodoc
class __$EmployeeSelfUpdatePayloadCopyWithImpl<$Res>
    implements _$EmployeeSelfUpdatePayloadCopyWith<$Res> {
  __$EmployeeSelfUpdatePayloadCopyWithImpl(this._self, this._then);

  final _EmployeeSelfUpdatePayload _self;
  final $Res Function(_EmployeeSelfUpdatePayload) _then;

/// Create a copy of EmployeeSelfUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(_EmployeeSelfUpdatePayload(
phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ProfileViewState {

 EmployeeProfile? get profile; bool get isLoading; bool get isSavingProfile; bool get isChangingPassword; bool get isBiometricSupported; bool get isBiometricEnabled; DeviceMetadata? get deviceMetadata; AppFailure? get failure; PhotoValidationError? get photoValidationError; Map<String, List<String>> get profileFieldErrors; Map<String, List<String>> get passwordFieldErrors;
/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileViewStateCopyWith<ProfileViewState> get copyWith => _$ProfileViewStateCopyWithImpl<ProfileViewState>(this as ProfileViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileViewState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSavingProfile, isSavingProfile) || other.isSavingProfile == isSavingProfile)&&(identical(other.isChangingPassword, isChangingPassword) || other.isChangingPassword == isChangingPassword)&&(identical(other.isBiometricSupported, isBiometricSupported) || other.isBiometricSupported == isBiometricSupported)&&(identical(other.isBiometricEnabled, isBiometricEnabled) || other.isBiometricEnabled == isBiometricEnabled)&&(identical(other.deviceMetadata, deviceMetadata) || other.deviceMetadata == deviceMetadata)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.photoValidationError, photoValidationError) || other.photoValidationError == photoValidationError)&&const DeepCollectionEquality().equals(other.profileFieldErrors, profileFieldErrors)&&const DeepCollectionEquality().equals(other.passwordFieldErrors, passwordFieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,profile,isLoading,isSavingProfile,isChangingPassword,isBiometricSupported,isBiometricEnabled,deviceMetadata,failure,photoValidationError,const DeepCollectionEquality().hash(profileFieldErrors),const DeepCollectionEquality().hash(passwordFieldErrors));

@override
String toString() {
  return 'ProfileViewState(profile: $profile, isLoading: $isLoading, isSavingProfile: $isSavingProfile, isChangingPassword: $isChangingPassword, isBiometricSupported: $isBiometricSupported, isBiometricEnabled: $isBiometricEnabled, deviceMetadata: $deviceMetadata, failure: $failure, photoValidationError: $photoValidationError, profileFieldErrors: $profileFieldErrors, passwordFieldErrors: $passwordFieldErrors)';
}


}

/// @nodoc
abstract mixin class $ProfileViewStateCopyWith<$Res>  {
  factory $ProfileViewStateCopyWith(ProfileViewState value, $Res Function(ProfileViewState) _then) = _$ProfileViewStateCopyWithImpl;
@useResult
$Res call({
 EmployeeProfile? profile, bool isLoading, bool isSavingProfile, bool isChangingPassword, bool isBiometricSupported, bool isBiometricEnabled, DeviceMetadata? deviceMetadata, AppFailure? failure, PhotoValidationError? photoValidationError, Map<String, List<String>> profileFieldErrors, Map<String, List<String>> passwordFieldErrors
});


$EmployeeProfileCopyWith<$Res>? get profile;$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ProfileViewStateCopyWithImpl<$Res>
    implements $ProfileViewStateCopyWith<$Res> {
  _$ProfileViewStateCopyWithImpl(this._self, this._then);

  final ProfileViewState _self;
  final $Res Function(ProfileViewState) _then;

/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? isLoading = null,Object? isSavingProfile = null,Object? isChangingPassword = null,Object? isBiometricSupported = null,Object? isBiometricEnabled = null,Object? deviceMetadata = freezed,Object? failure = freezed,Object? photoValidationError = freezed,Object? profileFieldErrors = null,Object? passwordFieldErrors = null,}) {
  return _then(ProfileViewState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as EmployeeProfile?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSavingProfile: null == isSavingProfile ? _self.isSavingProfile : isSavingProfile // ignore: cast_nullable_to_non_nullable
as bool,isChangingPassword: null == isChangingPassword ? _self.isChangingPassword : isChangingPassword // ignore: cast_nullable_to_non_nullable
as bool,isBiometricSupported: null == isBiometricSupported ? _self.isBiometricSupported : isBiometricSupported // ignore: cast_nullable_to_non_nullable
as bool,isBiometricEnabled: null == isBiometricEnabled ? _self.isBiometricEnabled : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
as bool,deviceMetadata: freezed == deviceMetadata ? _self.deviceMetadata : deviceMetadata // ignore: cast_nullable_to_non_nullable
as DeviceMetadata?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,photoValidationError: freezed == photoValidationError ? _self.photoValidationError : photoValidationError // ignore: cast_nullable_to_non_nullable
as PhotoValidationError?,profileFieldErrors: null == profileFieldErrors ? _self.profileFieldErrors : profileFieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,passwordFieldErrors: null == passwordFieldErrors ? _self.passwordFieldErrors : passwordFieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}
/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $EmployeeProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileViewState].
extension ProfileViewStatePatterns on ProfileViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileViewState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileViewState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EmployeeProfile? profile,  bool isLoading,  bool isSavingProfile,  bool isChangingPassword,  bool isBiometricSupported,  bool isBiometricEnabled,  DeviceMetadata? deviceMetadata,  AppFailure? failure,  PhotoValidationError? photoValidationError,  Map<String, List<String>> profileFieldErrors,  Map<String, List<String>> passwordFieldErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileViewState() when $default != null:
return $default(_that.profile,_that.isLoading,_that.isSavingProfile,_that.isChangingPassword,_that.isBiometricSupported,_that.isBiometricEnabled,_that.deviceMetadata,_that.failure,_that.photoValidationError,_that.profileFieldErrors,_that.passwordFieldErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EmployeeProfile? profile,  bool isLoading,  bool isSavingProfile,  bool isChangingPassword,  bool isBiometricSupported,  bool isBiometricEnabled,  DeviceMetadata? deviceMetadata,  AppFailure? failure,  PhotoValidationError? photoValidationError,  Map<String, List<String>> profileFieldErrors,  Map<String, List<String>> passwordFieldErrors)  $default,) {final _that = this;
switch (_that) {
case _ProfileViewState():
return $default(_that.profile,_that.isLoading,_that.isSavingProfile,_that.isChangingPassword,_that.isBiometricSupported,_that.isBiometricEnabled,_that.deviceMetadata,_that.failure,_that.photoValidationError,_that.profileFieldErrors,_that.passwordFieldErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EmployeeProfile? profile,  bool isLoading,  bool isSavingProfile,  bool isChangingPassword,  bool isBiometricSupported,  bool isBiometricEnabled,  DeviceMetadata? deviceMetadata,  AppFailure? failure,  PhotoValidationError? photoValidationError,  Map<String, List<String>> profileFieldErrors,  Map<String, List<String>> passwordFieldErrors)?  $default,) {final _that = this;
switch (_that) {
case _ProfileViewState() when $default != null:
return $default(_that.profile,_that.isLoading,_that.isSavingProfile,_that.isChangingPassword,_that.isBiometricSupported,_that.isBiometricEnabled,_that.deviceMetadata,_that.failure,_that.photoValidationError,_that.profileFieldErrors,_that.passwordFieldErrors);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileViewState extends ProfileViewState {
  const _ProfileViewState({this.profile, this.isLoading = false, this.isSavingProfile = false, this.isChangingPassword = false, this.isBiometricSupported = false, this.isBiometricEnabled = false, this.deviceMetadata, this.failure, this.photoValidationError,  Map<String, List<String>> profileFieldErrors = const <String, List<String>>{},  Map<String, List<String>> passwordFieldErrors = const <String, List<String>>{}}): _profileFieldErrors = profileFieldErrors,_passwordFieldErrors = passwordFieldErrors,super._();
  

@override final  EmployeeProfile? profile;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSavingProfile;
@override@JsonKey() final  bool isChangingPassword;
@override@JsonKey() final  bool isBiometricSupported;
@override@JsonKey() final  bool isBiometricEnabled;
@override final  DeviceMetadata? deviceMetadata;
@override final  AppFailure? failure;
@override final  PhotoValidationError? photoValidationError;
 final  Map<String, List<String>> _profileFieldErrors;
@override@JsonKey() Map<String, List<String>> get profileFieldErrors {
  if (_profileFieldErrors is EqualUnmodifiableMapView) return _profileFieldErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_profileFieldErrors);
}

 final  Map<String, List<String>> _passwordFieldErrors;
@override@JsonKey() Map<String, List<String>> get passwordFieldErrors {
  if (_passwordFieldErrors is EqualUnmodifiableMapView) return _passwordFieldErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_passwordFieldErrors);
}


/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileViewStateCopyWith<_ProfileViewState> get copyWith => __$ProfileViewStateCopyWithImpl<_ProfileViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileViewState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSavingProfile, isSavingProfile) || other.isSavingProfile == isSavingProfile)&&(identical(other.isChangingPassword, isChangingPassword) || other.isChangingPassword == isChangingPassword)&&(identical(other.isBiometricSupported, isBiometricSupported) || other.isBiometricSupported == isBiometricSupported)&&(identical(other.isBiometricEnabled, isBiometricEnabled) || other.isBiometricEnabled == isBiometricEnabled)&&(identical(other.deviceMetadata, deviceMetadata) || other.deviceMetadata == deviceMetadata)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.photoValidationError, photoValidationError) || other.photoValidationError == photoValidationError)&&const DeepCollectionEquality().equals(other._profileFieldErrors, _profileFieldErrors)&&const DeepCollectionEquality().equals(other._passwordFieldErrors, _passwordFieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,profile,isLoading,isSavingProfile,isChangingPassword,isBiometricSupported,isBiometricEnabled,deviceMetadata,failure,photoValidationError,const DeepCollectionEquality().hash(_profileFieldErrors),const DeepCollectionEquality().hash(_passwordFieldErrors));

@override
String toString() {
  return 'ProfileViewState(profile: $profile, isLoading: $isLoading, isSavingProfile: $isSavingProfile, isChangingPassword: $isChangingPassword, isBiometricSupported: $isBiometricSupported, isBiometricEnabled: $isBiometricEnabled, deviceMetadata: $deviceMetadata, failure: $failure, photoValidationError: $photoValidationError, profileFieldErrors: $profileFieldErrors, passwordFieldErrors: $passwordFieldErrors)';
}


}

/// @nodoc
abstract mixin class _$ProfileViewStateCopyWith<$Res> implements $ProfileViewStateCopyWith<$Res> {
  factory _$ProfileViewStateCopyWith(_ProfileViewState value, $Res Function(_ProfileViewState) _then) = __$ProfileViewStateCopyWithImpl;
@override @useResult
$Res call({
 EmployeeProfile? profile, bool isLoading, bool isSavingProfile, bool isChangingPassword, bool isBiometricSupported, bool isBiometricEnabled, DeviceMetadata? deviceMetadata, AppFailure? failure, PhotoValidationError? photoValidationError, Map<String, List<String>> profileFieldErrors, Map<String, List<String>> passwordFieldErrors
});


@override $EmployeeProfileCopyWith<$Res>? get profile;@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ProfileViewStateCopyWithImpl<$Res>
    implements _$ProfileViewStateCopyWith<$Res> {
  __$ProfileViewStateCopyWithImpl(this._self, this._then);

  final _ProfileViewState _self;
  final $Res Function(_ProfileViewState) _then;

/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? isLoading = null,Object? isSavingProfile = null,Object? isChangingPassword = null,Object? isBiometricSupported = null,Object? isBiometricEnabled = null,Object? deviceMetadata = freezed,Object? failure = freezed,Object? photoValidationError = freezed,Object? profileFieldErrors = null,Object? passwordFieldErrors = null,}) {
  return _then(_ProfileViewState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as EmployeeProfile?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSavingProfile: null == isSavingProfile ? _self.isSavingProfile : isSavingProfile // ignore: cast_nullable_to_non_nullable
as bool,isChangingPassword: null == isChangingPassword ? _self.isChangingPassword : isChangingPassword // ignore: cast_nullable_to_non_nullable
as bool,isBiometricSupported: null == isBiometricSupported ? _self.isBiometricSupported : isBiometricSupported // ignore: cast_nullable_to_non_nullable
as bool,isBiometricEnabled: null == isBiometricEnabled ? _self.isBiometricEnabled : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
as bool,deviceMetadata: freezed == deviceMetadata ? _self.deviceMetadata : deviceMetadata // ignore: cast_nullable_to_non_nullable
as DeviceMetadata?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,photoValidationError: freezed == photoValidationError ? _self.photoValidationError : photoValidationError // ignore: cast_nullable_to_non_nullable
as PhotoValidationError?,profileFieldErrors: null == profileFieldErrors ? _self._profileFieldErrors : profileFieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,passwordFieldErrors: null == passwordFieldErrors ? _self._passwordFieldErrors : passwordFieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}

/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $EmployeeProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ProfileViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
