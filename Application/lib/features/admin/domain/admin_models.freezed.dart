// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmployeeItem {

 String get id;@JsonKey(name: 'employee_code') String get employeeCode; String get email;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'phone_number') String? get phoneNumber; String? get designation;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'must_change_password') bool get mustChangePassword;@JsonKey(name: 'joining_date') String? get joiningDate;@JsonKey(name: 'department_id') String? get departmentId;@JsonKey(name: 'department_name') String? get departmentName;@JsonKey(name: 'role_id') String get roleId;@JsonKey(name: 'role_name') String? get roleName;@JsonKey(name: 'attendance_policy_id') String? get attendancePolicyId;@JsonKey(name: 'attendance_policy_name') String? get attendancePolicyName;@JsonKey(name: 'manager_id') String? get managerId;@JsonKey(name: 'manager_name') String? get managerName;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of EmployeeItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeItemCopyWith<EmployeeItem> get copyWith => _$EmployeeItemCopyWithImpl<EmployeeItem>(this as EmployeeItem, _$identity);

  /// Serializes this EmployeeItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.attendancePolicyName, attendancePolicyName) || other.attendancePolicyName == attendancePolicyName)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.managerName, managerName) || other.managerName == managerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,employeeCode,email,fullName,phoneNumber,designation,avatarUrl,isActive,mustChangePassword,joiningDate,departmentId,departmentName,roleId,roleName,attendancePolicyId,attendancePolicyName,managerId,managerName,createdAt]);

@override
String toString() {
  return 'EmployeeItem(id: $id, employeeCode: $employeeCode, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, designation: $designation, avatarUrl: $avatarUrl, isActive: $isActive, mustChangePassword: $mustChangePassword, joiningDate: $joiningDate, departmentId: $departmentId, departmentName: $departmentName, roleId: $roleId, roleName: $roleName, attendancePolicyId: $attendancePolicyId, attendancePolicyName: $attendancePolicyName, managerId: $managerId, managerName: $managerName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EmployeeItemCopyWith<$Res>  {
  factory $EmployeeItemCopyWith(EmployeeItem value, $Res Function(EmployeeItem) _then) = _$EmployeeItemCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode, String email,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'must_change_password') bool mustChangePassword,@JsonKey(name: 'joining_date') String? joiningDate,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'role_id') String roleId,@JsonKey(name: 'role_name') String? roleName,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'attendance_policy_name') String? attendancePolicyName,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'manager_name') String? managerName,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$EmployeeItemCopyWithImpl<$Res>
    implements $EmployeeItemCopyWith<$Res> {
  _$EmployeeItemCopyWithImpl(this._self, this._then);

  final EmployeeItem _self;
  final $Res Function(EmployeeItem) _then;

/// Create a copy of EmployeeItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? email = null,Object? fullName = null,Object? phoneNumber = freezed,Object? designation = freezed,Object? avatarUrl = freezed,Object? isActive = null,Object? mustChangePassword = null,Object? joiningDate = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? roleId = null,Object? roleName = freezed,Object? attendancePolicyId = freezed,Object? attendancePolicyName = freezed,Object? managerId = freezed,Object? managerName = freezed,Object? createdAt = null,}) {
  return _then(EmployeeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,roleName: freezed == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyName: freezed == attendancePolicyName ? _self.attendancePolicyName : attendancePolicyName // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,managerName: freezed == managerName ? _self.managerName : managerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeItem].
extension EmployeeItemPatterns on EmployeeItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeItem value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeItem value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode,  String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'must_change_password')  bool mustChangePassword, @JsonKey(name: 'joining_date')  String? joiningDate, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'role_name')  String? roleName, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'attendance_policy_name')  String? attendancePolicyName, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'manager_name')  String? managerName, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeItem() when $default != null:
return $default(_that.id,_that.employeeCode,_that.email,_that.fullName,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.isActive,_that.mustChangePassword,_that.joiningDate,_that.departmentId,_that.departmentName,_that.roleId,_that.roleName,_that.attendancePolicyId,_that.attendancePolicyName,_that.managerId,_that.managerName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode,  String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'must_change_password')  bool mustChangePassword, @JsonKey(name: 'joining_date')  String? joiningDate, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'role_name')  String? roleName, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'attendance_policy_name')  String? attendancePolicyName, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'manager_name')  String? managerName, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _EmployeeItem():
return $default(_that.id,_that.employeeCode,_that.email,_that.fullName,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.isActive,_that.mustChangePassword,_that.joiningDate,_that.departmentId,_that.departmentName,_that.roleId,_that.roleName,_that.attendancePolicyId,_that.attendancePolicyName,_that.managerId,_that.managerName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_code')  String employeeCode,  String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'must_change_password')  bool mustChangePassword, @JsonKey(name: 'joining_date')  String? joiningDate, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'role_name')  String? roleName, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'attendance_policy_name')  String? attendancePolicyName, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'manager_name')  String? managerName, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeItem() when $default != null:
return $default(_that.id,_that.employeeCode,_that.email,_that.fullName,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.isActive,_that.mustChangePassword,_that.joiningDate,_that.departmentId,_that.departmentName,_that.roleId,_that.roleName,_that.attendancePolicyId,_that.attendancePolicyName,_that.managerId,_that.managerName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeItem implements EmployeeItem {
  const _EmployeeItem({required this.id, @JsonKey(name: 'employee_code') required this.employeeCode, required this.email, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'phone_number') this.phoneNumber, this.designation, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'is_active') required this.isActive, @JsonKey(name: 'must_change_password') required this.mustChangePassword, @JsonKey(name: 'joining_date') this.joiningDate, @JsonKey(name: 'department_id') this.departmentId, @JsonKey(name: 'department_name') this.departmentName, @JsonKey(name: 'role_id') required this.roleId, @JsonKey(name: 'role_name') this.roleName, @JsonKey(name: 'attendance_policy_id') this.attendancePolicyId, @JsonKey(name: 'attendance_policy_name') this.attendancePolicyName, @JsonKey(name: 'manager_id') this.managerId, @JsonKey(name: 'manager_name') this.managerName, @JsonKey(name: 'created_at') required this.createdAt});
  factory _EmployeeItem.fromJson(Map<String, dynamic> json) => _$EmployeeItemFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override final  String email;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String? designation;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'must_change_password') final  bool mustChangePassword;
@override@JsonKey(name: 'joining_date') final  String? joiningDate;
@override@JsonKey(name: 'department_id') final  String? departmentId;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override@JsonKey(name: 'role_id') final  String roleId;
@override@JsonKey(name: 'role_name') final  String? roleName;
@override@JsonKey(name: 'attendance_policy_id') final  String? attendancePolicyId;
@override@JsonKey(name: 'attendance_policy_name') final  String? attendancePolicyName;
@override@JsonKey(name: 'manager_id') final  String? managerId;
@override@JsonKey(name: 'manager_name') final  String? managerName;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of EmployeeItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeItemCopyWith<_EmployeeItem> get copyWith => __$EmployeeItemCopyWithImpl<_EmployeeItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.attendancePolicyName, attendancePolicyName) || other.attendancePolicyName == attendancePolicyName)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.managerName, managerName) || other.managerName == managerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,employeeCode,email,fullName,phoneNumber,designation,avatarUrl,isActive,mustChangePassword,joiningDate,departmentId,departmentName,roleId,roleName,attendancePolicyId,attendancePolicyName,managerId,managerName,createdAt]);

@override
String toString() {
  return 'EmployeeItem(id: $id, employeeCode: $employeeCode, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, designation: $designation, avatarUrl: $avatarUrl, isActive: $isActive, mustChangePassword: $mustChangePassword, joiningDate: $joiningDate, departmentId: $departmentId, departmentName: $departmentName, roleId: $roleId, roleName: $roleName, attendancePolicyId: $attendancePolicyId, attendancePolicyName: $attendancePolicyName, managerId: $managerId, managerName: $managerName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EmployeeItemCopyWith<$Res> implements $EmployeeItemCopyWith<$Res> {
  factory _$EmployeeItemCopyWith(_EmployeeItem value, $Res Function(_EmployeeItem) _then) = __$EmployeeItemCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode, String email,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'must_change_password') bool mustChangePassword,@JsonKey(name: 'joining_date') String? joiningDate,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'role_id') String roleId,@JsonKey(name: 'role_name') String? roleName,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'attendance_policy_name') String? attendancePolicyName,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'manager_name') String? managerName,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$EmployeeItemCopyWithImpl<$Res>
    implements _$EmployeeItemCopyWith<$Res> {
  __$EmployeeItemCopyWithImpl(this._self, this._then);

  final _EmployeeItem _self;
  final $Res Function(_EmployeeItem) _then;

/// Create a copy of EmployeeItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? email = null,Object? fullName = null,Object? phoneNumber = freezed,Object? designation = freezed,Object? avatarUrl = freezed,Object? isActive = null,Object? mustChangePassword = null,Object? joiningDate = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? roleId = null,Object? roleName = freezed,Object? attendancePolicyId = freezed,Object? attendancePolicyName = freezed,Object? managerId = freezed,Object? managerName = freezed,Object? createdAt = null,}) {
  return _then(_EmployeeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,roleName: freezed == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyName: freezed == attendancePolicyName ? _self.attendancePolicyName : attendancePolicyName // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,managerName: freezed == managerName ? _self.managerName : managerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EmployeeCreatePayload {

 String get email;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'role_id') String get roleId;@JsonKey(name: 'department_id') String? get departmentId;@JsonKey(name: 'attendance_policy_id') String? get attendancePolicyId;@JsonKey(name: 'manager_id') String? get managerId;@JsonKey(name: 'phone_number') String? get phoneNumber; String? get designation;@JsonKey(name: 'joining_date') String? get joiningDate;
/// Create a copy of EmployeeCreatePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeCreatePayloadCopyWith<EmployeeCreatePayload> get copyWith => _$EmployeeCreatePayloadCopyWithImpl<EmployeeCreatePayload>(this as EmployeeCreatePayload, _$identity);

  /// Serializes this EmployeeCreatePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeCreatePayload&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,fullName,roleId,departmentId,attendancePolicyId,managerId,phoneNumber,designation,joiningDate);

@override
String toString() {
  return 'EmployeeCreatePayload(email: $email, fullName: $fullName, roleId: $roleId, departmentId: $departmentId, attendancePolicyId: $attendancePolicyId, managerId: $managerId, phoneNumber: $phoneNumber, designation: $designation, joiningDate: $joiningDate)';
}


}

/// @nodoc
abstract mixin class $EmployeeCreatePayloadCopyWith<$Res>  {
  factory $EmployeeCreatePayloadCopyWith(EmployeeCreatePayload value, $Res Function(EmployeeCreatePayload) _then) = _$EmployeeCreatePayloadCopyWithImpl;
@useResult
$Res call({
 String email,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'role_id') String roleId,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'joining_date') String? joiningDate
});




}
/// @nodoc
class _$EmployeeCreatePayloadCopyWithImpl<$Res>
    implements $EmployeeCreatePayloadCopyWith<$Res> {
  _$EmployeeCreatePayloadCopyWithImpl(this._self, this._then);

  final EmployeeCreatePayload _self;
  final $Res Function(EmployeeCreatePayload) _then;

/// Create a copy of EmployeeCreatePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? fullName = null,Object? roleId = null,Object? departmentId = freezed,Object? attendancePolicyId = freezed,Object? managerId = freezed,Object? phoneNumber = freezed,Object? designation = freezed,Object? joiningDate = freezed,}) {
  return _then(EmployeeCreatePayload(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeCreatePayload].
extension EmployeeCreatePayloadPatterns on EmployeeCreatePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeCreatePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeCreatePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeCreatePayload value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeCreatePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeCreatePayload value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeCreatePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'joining_date')  String? joiningDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeCreatePayload() when $default != null:
return $default(_that.email,_that.fullName,_that.roleId,_that.departmentId,_that.attendancePolicyId,_that.managerId,_that.phoneNumber,_that.designation,_that.joiningDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'joining_date')  String? joiningDate)  $default,) {final _that = this;
switch (_that) {
case _EmployeeCreatePayload():
return $default(_that.email,_that.fullName,_that.roleId,_that.departmentId,_that.attendancePolicyId,_that.managerId,_that.phoneNumber,_that.designation,_that.joiningDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'role_id')  String roleId, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'joining_date')  String? joiningDate)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeCreatePayload() when $default != null:
return $default(_that.email,_that.fullName,_that.roleId,_that.departmentId,_that.attendancePolicyId,_that.managerId,_that.phoneNumber,_that.designation,_that.joiningDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeCreatePayload implements EmployeeCreatePayload {
  const _EmployeeCreatePayload({required this.email, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'role_id') required this.roleId, @JsonKey(name: 'department_id') this.departmentId, @JsonKey(name: 'attendance_policy_id') this.attendancePolicyId, @JsonKey(name: 'manager_id') this.managerId, @JsonKey(name: 'phone_number') this.phoneNumber, this.designation, @JsonKey(name: 'joining_date') this.joiningDate});
  factory _EmployeeCreatePayload.fromJson(Map<String, dynamic> json) => _$EmployeeCreatePayloadFromJson(json);

@override final  String email;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'role_id') final  String roleId;
@override@JsonKey(name: 'department_id') final  String? departmentId;
@override@JsonKey(name: 'attendance_policy_id') final  String? attendancePolicyId;
@override@JsonKey(name: 'manager_id') final  String? managerId;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String? designation;
@override@JsonKey(name: 'joining_date') final  String? joiningDate;

/// Create a copy of EmployeeCreatePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeCreatePayloadCopyWith<_EmployeeCreatePayload> get copyWith => __$EmployeeCreatePayloadCopyWithImpl<_EmployeeCreatePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeCreatePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeCreatePayload&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,fullName,roleId,departmentId,attendancePolicyId,managerId,phoneNumber,designation,joiningDate);

@override
String toString() {
  return 'EmployeeCreatePayload(email: $email, fullName: $fullName, roleId: $roleId, departmentId: $departmentId, attendancePolicyId: $attendancePolicyId, managerId: $managerId, phoneNumber: $phoneNumber, designation: $designation, joiningDate: $joiningDate)';
}


}

/// @nodoc
abstract mixin class _$EmployeeCreatePayloadCopyWith<$Res> implements $EmployeeCreatePayloadCopyWith<$Res> {
  factory _$EmployeeCreatePayloadCopyWith(_EmployeeCreatePayload value, $Res Function(_EmployeeCreatePayload) _then) = __$EmployeeCreatePayloadCopyWithImpl;
@override @useResult
$Res call({
 String email,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'role_id') String roleId,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'joining_date') String? joiningDate
});




}
/// @nodoc
class __$EmployeeCreatePayloadCopyWithImpl<$Res>
    implements _$EmployeeCreatePayloadCopyWith<$Res> {
  __$EmployeeCreatePayloadCopyWithImpl(this._self, this._then);

  final _EmployeeCreatePayload _self;
  final $Res Function(_EmployeeCreatePayload) _then;

/// Create a copy of EmployeeCreatePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? fullName = null,Object? roleId = null,Object? departmentId = freezed,Object? attendancePolicyId = freezed,Object? managerId = freezed,Object? phoneNumber = freezed,Object? designation = freezed,Object? joiningDate = freezed,}) {
  return _then(_EmployeeCreatePayload(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EmployeeUpdatePayload {

@JsonKey(name: 'full_name') String? get fullName;@JsonKey(name: 'department_id') String? get departmentId;@JsonKey(name: 'attendance_policy_id') String? get attendancePolicyId;@JsonKey(name: 'manager_id') String? get managerId;@JsonKey(name: 'phone_number') String? get phoneNumber; String? get designation;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'joining_date') String? get joiningDate;
/// Create a copy of EmployeeUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeUpdatePayloadCopyWith<EmployeeUpdatePayload> get copyWith => _$EmployeeUpdatePayloadCopyWithImpl<EmployeeUpdatePayload>(this as EmployeeUpdatePayload, _$identity);

  /// Serializes this EmployeeUpdatePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeUpdatePayload&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,departmentId,attendancePolicyId,managerId,phoneNumber,designation,avatarUrl,joiningDate);

@override
String toString() {
  return 'EmployeeUpdatePayload(fullName: $fullName, departmentId: $departmentId, attendancePolicyId: $attendancePolicyId, managerId: $managerId, phoneNumber: $phoneNumber, designation: $designation, avatarUrl: $avatarUrl, joiningDate: $joiningDate)';
}


}

/// @nodoc
abstract mixin class $EmployeeUpdatePayloadCopyWith<$Res>  {
  factory $EmployeeUpdatePayloadCopyWith(EmployeeUpdatePayload value, $Res Function(EmployeeUpdatePayload) _then) = _$EmployeeUpdatePayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'full_name') String? fullName,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'joining_date') String? joiningDate
});




}
/// @nodoc
class _$EmployeeUpdatePayloadCopyWithImpl<$Res>
    implements $EmployeeUpdatePayloadCopyWith<$Res> {
  _$EmployeeUpdatePayloadCopyWithImpl(this._self, this._then);

  final EmployeeUpdatePayload _self;
  final $Res Function(EmployeeUpdatePayload) _then;

/// Create a copy of EmployeeUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? departmentId = freezed,Object? attendancePolicyId = freezed,Object? managerId = freezed,Object? phoneNumber = freezed,Object? designation = freezed,Object? avatarUrl = freezed,Object? joiningDate = freezed,}) {
  return _then(EmployeeUpdatePayload(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeUpdatePayload].
extension EmployeeUpdatePayloadPatterns on EmployeeUpdatePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeUpdatePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeUpdatePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeUpdatePayload value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeUpdatePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeUpdatePayload value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeUpdatePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'full_name')  String? fullName, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'joining_date')  String? joiningDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeUpdatePayload() when $default != null:
return $default(_that.fullName,_that.departmentId,_that.attendancePolicyId,_that.managerId,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.joiningDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'full_name')  String? fullName, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'joining_date')  String? joiningDate)  $default,) {final _that = this;
switch (_that) {
case _EmployeeUpdatePayload():
return $default(_that.fullName,_that.departmentId,_that.attendancePolicyId,_that.managerId,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.joiningDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'full_name')  String? fullName, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'attendance_policy_id')  String? attendancePolicyId, @JsonKey(name: 'manager_id')  String? managerId, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? designation, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'joining_date')  String? joiningDate)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeUpdatePayload() when $default != null:
return $default(_that.fullName,_that.departmentId,_that.attendancePolicyId,_that.managerId,_that.phoneNumber,_that.designation,_that.avatarUrl,_that.joiningDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeUpdatePayload implements EmployeeUpdatePayload {
  const _EmployeeUpdatePayload({@JsonKey(name: 'full_name') this.fullName, @JsonKey(name: 'department_id') this.departmentId, @JsonKey(name: 'attendance_policy_id') this.attendancePolicyId, @JsonKey(name: 'manager_id') this.managerId, @JsonKey(name: 'phone_number') this.phoneNumber, this.designation, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'joining_date') this.joiningDate});
  factory _EmployeeUpdatePayload.fromJson(Map<String, dynamic> json) => _$EmployeeUpdatePayloadFromJson(json);

@override@JsonKey(name: 'full_name') final  String? fullName;
@override@JsonKey(name: 'department_id') final  String? departmentId;
@override@JsonKey(name: 'attendance_policy_id') final  String? attendancePolicyId;
@override@JsonKey(name: 'manager_id') final  String? managerId;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String? designation;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'joining_date') final  String? joiningDate;

/// Create a copy of EmployeeUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeUpdatePayloadCopyWith<_EmployeeUpdatePayload> get copyWith => __$EmployeeUpdatePayloadCopyWithImpl<_EmployeeUpdatePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeUpdatePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeUpdatePayload&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.attendancePolicyId, attendancePolicyId) || other.attendancePolicyId == attendancePolicyId)&&(identical(other.managerId, managerId) || other.managerId == managerId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.joiningDate, joiningDate) || other.joiningDate == joiningDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,departmentId,attendancePolicyId,managerId,phoneNumber,designation,avatarUrl,joiningDate);

@override
String toString() {
  return 'EmployeeUpdatePayload(fullName: $fullName, departmentId: $departmentId, attendancePolicyId: $attendancePolicyId, managerId: $managerId, phoneNumber: $phoneNumber, designation: $designation, avatarUrl: $avatarUrl, joiningDate: $joiningDate)';
}


}

/// @nodoc
abstract mixin class _$EmployeeUpdatePayloadCopyWith<$Res> implements $EmployeeUpdatePayloadCopyWith<$Res> {
  factory _$EmployeeUpdatePayloadCopyWith(_EmployeeUpdatePayload value, $Res Function(_EmployeeUpdatePayload) _then) = __$EmployeeUpdatePayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'full_name') String? fullName,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'attendance_policy_id') String? attendancePolicyId,@JsonKey(name: 'manager_id') String? managerId,@JsonKey(name: 'phone_number') String? phoneNumber, String? designation,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'joining_date') String? joiningDate
});




}
/// @nodoc
class __$EmployeeUpdatePayloadCopyWithImpl<$Res>
    implements _$EmployeeUpdatePayloadCopyWith<$Res> {
  __$EmployeeUpdatePayloadCopyWithImpl(this._self, this._then);

  final _EmployeeUpdatePayload _self;
  final $Res Function(_EmployeeUpdatePayload) _then;

/// Create a copy of EmployeeUpdatePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? departmentId = freezed,Object? attendancePolicyId = freezed,Object? managerId = freezed,Object? phoneNumber = freezed,Object? designation = freezed,Object? avatarUrl = freezed,Object? joiningDate = freezed,}) {
  return _then(_EmployeeUpdatePayload(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,attendancePolicyId: freezed == attendancePolicyId ? _self.attendancePolicyId : attendancePolicyId // ignore: cast_nullable_to_non_nullable
as String?,managerId: freezed == managerId ? _self.managerId : managerId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,joiningDate: freezed == joiningDate ? _self.joiningDate : joiningDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RoleItem {

 String get id; String get name; String? get description;@JsonKey(name: 'is_system') bool get isSystem;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of RoleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleItemCopyWith<RoleItem> get copyWith => _$RoleItemCopyWithImpl<RoleItem>(this as RoleItem, _$identity);

  /// Serializes this RoleItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isSystem,isActive,createdAt);

@override
String toString() {
  return 'RoleItem(id: $id, name: $name, description: $description, isSystem: $isSystem, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RoleItemCopyWith<$Res>  {
  factory $RoleItemCopyWith(RoleItem value, $Res Function(RoleItem) _then) = _$RoleItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'is_system') bool isSystem,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$RoleItemCopyWithImpl<$Res>
    implements $RoleItemCopyWith<$Res> {
  _$RoleItemCopyWithImpl(this._self, this._then);

  final RoleItem _self;
  final $Res Function(RoleItem) _then;

/// Create a copy of RoleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? isSystem = null,Object? isActive = null,Object? createdAt = null,}) {
  return _then(RoleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleItem].
extension RoleItemPatterns on RoleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleItem value)  $default,){
final _that = this;
switch (_that) {
case _RoleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleItem value)?  $default,){
final _that = this;
switch (_that) {
case _RoleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'is_system')  bool isSystem, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleItem() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isSystem,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'is_system')  bool isSystem, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _RoleItem():
return $default(_that.id,_that.name,_that.description,_that.isSystem,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(name: 'is_system')  bool isSystem, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RoleItem() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isSystem,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleItem implements RoleItem {
  const _RoleItem({required this.id, required this.name, this.description, @JsonKey(name: 'is_system') required this.isSystem, @JsonKey(name: 'is_active') required this.isActive, @JsonKey(name: 'created_at') required this.createdAt});
  factory _RoleItem.fromJson(Map<String, dynamic> json) => _$RoleItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'is_system') final  bool isSystem;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of RoleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleItemCopyWith<_RoleItem> get copyWith => __$RoleItemCopyWithImpl<_RoleItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isSystem,isActive,createdAt);

@override
String toString() {
  return 'RoleItem(id: $id, name: $name, description: $description, isSystem: $isSystem, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RoleItemCopyWith<$Res> implements $RoleItemCopyWith<$Res> {
  factory _$RoleItemCopyWith(_RoleItem value, $Res Function(_RoleItem) _then) = __$RoleItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'is_system') bool isSystem,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$RoleItemCopyWithImpl<$Res>
    implements _$RoleItemCopyWith<$Res> {
  __$RoleItemCopyWithImpl(this._self, this._then);

  final _RoleItem _self;
  final $Res Function(_RoleItem) _then;

/// Create a copy of RoleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? isSystem = null,Object? isActive = null,Object? createdAt = null,}) {
  return _then(_RoleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BulkImportRowError {

 int get row; String get field; String get error; String? get value;
/// Create a copy of BulkImportRowError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkImportRowErrorCopyWith<BulkImportRowError> get copyWith => _$BulkImportRowErrorCopyWithImpl<BulkImportRowError>(this as BulkImportRowError, _$identity);

  /// Serializes this BulkImportRowError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkImportRowError&&(identical(other.row, row) || other.row == row)&&(identical(other.field, field) || other.field == field)&&(identical(other.error, error) || other.error == error)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,row,field,error,value);

@override
String toString() {
  return 'BulkImportRowError(row: $row, field: $field, error: $error, value: $value)';
}


}

/// @nodoc
abstract mixin class $BulkImportRowErrorCopyWith<$Res>  {
  factory $BulkImportRowErrorCopyWith(BulkImportRowError value, $Res Function(BulkImportRowError) _then) = _$BulkImportRowErrorCopyWithImpl;
@useResult
$Res call({
 int row, String field, String error, String? value
});




}
/// @nodoc
class _$BulkImportRowErrorCopyWithImpl<$Res>
    implements $BulkImportRowErrorCopyWith<$Res> {
  _$BulkImportRowErrorCopyWithImpl(this._self, this._then);

  final BulkImportRowError _self;
  final $Res Function(BulkImportRowError) _then;

/// Create a copy of BulkImportRowError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? row = null,Object? field = null,Object? error = null,Object? value = freezed,}) {
  return _then(BulkImportRowError(
row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BulkImportRowError].
extension BulkImportRowErrorPatterns on BulkImportRowError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BulkImportRowError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BulkImportRowError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BulkImportRowError value)  $default,){
final _that = this;
switch (_that) {
case _BulkImportRowError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BulkImportRowError value)?  $default,){
final _that = this;
switch (_that) {
case _BulkImportRowError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int row,  String field,  String error,  String? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BulkImportRowError() when $default != null:
return $default(_that.row,_that.field,_that.error,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int row,  String field,  String error,  String? value)  $default,) {final _that = this;
switch (_that) {
case _BulkImportRowError():
return $default(_that.row,_that.field,_that.error,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int row,  String field,  String error,  String? value)?  $default,) {final _that = this;
switch (_that) {
case _BulkImportRowError() when $default != null:
return $default(_that.row,_that.field,_that.error,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BulkImportRowError implements BulkImportRowError {
  const _BulkImportRowError({required this.row, required this.field, required this.error, this.value});
  factory _BulkImportRowError.fromJson(Map<String, dynamic> json) => _$BulkImportRowErrorFromJson(json);

@override final  int row;
@override final  String field;
@override final  String error;
@override final  String? value;

/// Create a copy of BulkImportRowError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkImportRowErrorCopyWith<_BulkImportRowError> get copyWith => __$BulkImportRowErrorCopyWithImpl<_BulkImportRowError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BulkImportRowErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkImportRowError&&(identical(other.row, row) || other.row == row)&&(identical(other.field, field) || other.field == field)&&(identical(other.error, error) || other.error == error)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,row,field,error,value);

@override
String toString() {
  return 'BulkImportRowError(row: $row, field: $field, error: $error, value: $value)';
}


}

/// @nodoc
abstract mixin class _$BulkImportRowErrorCopyWith<$Res> implements $BulkImportRowErrorCopyWith<$Res> {
  factory _$BulkImportRowErrorCopyWith(_BulkImportRowError value, $Res Function(_BulkImportRowError) _then) = __$BulkImportRowErrorCopyWithImpl;
@override @useResult
$Res call({
 int row, String field, String error, String? value
});




}
/// @nodoc
class __$BulkImportRowErrorCopyWithImpl<$Res>
    implements _$BulkImportRowErrorCopyWith<$Res> {
  __$BulkImportRowErrorCopyWithImpl(this._self, this._then);

  final _BulkImportRowError _self;
  final $Res Function(_BulkImportRowError) _then;

/// Create a copy of BulkImportRowError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? row = null,Object? field = null,Object? error = null,Object? value = freezed,}) {
  return _then(_BulkImportRowError(
row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BulkImportReport {

@JsonKey(name: 'total_rows') int get totalRows;@JsonKey(name: 'successful_imports') int get successfulImports;@JsonKey(name: 'failed_rows') int get failedRows;@JsonKey(name: 'dry_run') bool get dryRun; List<BulkImportRowError> get errors;
/// Create a copy of BulkImportReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkImportReportCopyWith<BulkImportReport> get copyWith => _$BulkImportReportCopyWithImpl<BulkImportReport>(this as BulkImportReport, _$identity);

  /// Serializes this BulkImportReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkImportReport&&(identical(other.totalRows, totalRows) || other.totalRows == totalRows)&&(identical(other.successfulImports, successfulImports) || other.successfulImports == successfulImports)&&(identical(other.failedRows, failedRows) || other.failedRows == failedRows)&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRows,successfulImports,failedRows,dryRun,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'BulkImportReport(totalRows: $totalRows, successfulImports: $successfulImports, failedRows: $failedRows, dryRun: $dryRun, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $BulkImportReportCopyWith<$Res>  {
  factory $BulkImportReportCopyWith(BulkImportReport value, $Res Function(BulkImportReport) _then) = _$BulkImportReportCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_rows') int totalRows,@JsonKey(name: 'successful_imports') int successfulImports,@JsonKey(name: 'failed_rows') int failedRows,@JsonKey(name: 'dry_run') bool dryRun, List<BulkImportRowError> errors
});




}
/// @nodoc
class _$BulkImportReportCopyWithImpl<$Res>
    implements $BulkImportReportCopyWith<$Res> {
  _$BulkImportReportCopyWithImpl(this._self, this._then);

  final BulkImportReport _self;
  final $Res Function(BulkImportReport) _then;

/// Create a copy of BulkImportReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRows = null,Object? successfulImports = null,Object? failedRows = null,Object? dryRun = null,Object? errors = null,}) {
  return _then(BulkImportReport(
totalRows: null == totalRows ? _self.totalRows : totalRows // ignore: cast_nullable_to_non_nullable
as int,successfulImports: null == successfulImports ? _self.successfulImports : successfulImports // ignore: cast_nullable_to_non_nullable
as int,failedRows: null == failedRows ? _self.failedRows : failedRows // ignore: cast_nullable_to_non_nullable
as int,dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<BulkImportRowError>,
  ));
}

}


/// Adds pattern-matching-related methods to [BulkImportReport].
extension BulkImportReportPatterns on BulkImportReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BulkImportReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BulkImportReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BulkImportReport value)  $default,){
final _that = this;
switch (_that) {
case _BulkImportReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BulkImportReport value)?  $default,){
final _that = this;
switch (_that) {
case _BulkImportReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_rows')  int totalRows, @JsonKey(name: 'successful_imports')  int successfulImports, @JsonKey(name: 'failed_rows')  int failedRows, @JsonKey(name: 'dry_run')  bool dryRun,  List<BulkImportRowError> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BulkImportReport() when $default != null:
return $default(_that.totalRows,_that.successfulImports,_that.failedRows,_that.dryRun,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_rows')  int totalRows, @JsonKey(name: 'successful_imports')  int successfulImports, @JsonKey(name: 'failed_rows')  int failedRows, @JsonKey(name: 'dry_run')  bool dryRun,  List<BulkImportRowError> errors)  $default,) {final _that = this;
switch (_that) {
case _BulkImportReport():
return $default(_that.totalRows,_that.successfulImports,_that.failedRows,_that.dryRun,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_rows')  int totalRows, @JsonKey(name: 'successful_imports')  int successfulImports, @JsonKey(name: 'failed_rows')  int failedRows, @JsonKey(name: 'dry_run')  bool dryRun,  List<BulkImportRowError> errors)?  $default,) {final _that = this;
switch (_that) {
case _BulkImportReport() when $default != null:
return $default(_that.totalRows,_that.successfulImports,_that.failedRows,_that.dryRun,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BulkImportReport implements BulkImportReport {
  const _BulkImportReport({@JsonKey(name: 'total_rows') required this.totalRows, @JsonKey(name: 'successful_imports') required this.successfulImports, @JsonKey(name: 'failed_rows') required this.failedRows, @JsonKey(name: 'dry_run') required this.dryRun,  List<BulkImportRowError> errors = const <BulkImportRowError>[]}): _errors = errors;
  factory _BulkImportReport.fromJson(Map<String, dynamic> json) => _$BulkImportReportFromJson(json);

@override@JsonKey(name: 'total_rows') final  int totalRows;
@override@JsonKey(name: 'successful_imports') final  int successfulImports;
@override@JsonKey(name: 'failed_rows') final  int failedRows;
@override@JsonKey(name: 'dry_run') final  bool dryRun;
 final  List<BulkImportRowError> _errors;
@override@JsonKey() List<BulkImportRowError> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of BulkImportReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkImportReportCopyWith<_BulkImportReport> get copyWith => __$BulkImportReportCopyWithImpl<_BulkImportReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BulkImportReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkImportReport&&(identical(other.totalRows, totalRows) || other.totalRows == totalRows)&&(identical(other.successfulImports, successfulImports) || other.successfulImports == successfulImports)&&(identical(other.failedRows, failedRows) || other.failedRows == failedRows)&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRows,successfulImports,failedRows,dryRun,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'BulkImportReport(totalRows: $totalRows, successfulImports: $successfulImports, failedRows: $failedRows, dryRun: $dryRun, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$BulkImportReportCopyWith<$Res> implements $BulkImportReportCopyWith<$Res> {
  factory _$BulkImportReportCopyWith(_BulkImportReport value, $Res Function(_BulkImportReport) _then) = __$BulkImportReportCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_rows') int totalRows,@JsonKey(name: 'successful_imports') int successfulImports,@JsonKey(name: 'failed_rows') int failedRows,@JsonKey(name: 'dry_run') bool dryRun, List<BulkImportRowError> errors
});




}
/// @nodoc
class __$BulkImportReportCopyWithImpl<$Res>
    implements _$BulkImportReportCopyWith<$Res> {
  __$BulkImportReportCopyWithImpl(this._self, this._then);

  final _BulkImportReport _self;
  final $Res Function(_BulkImportReport) _then;

/// Create a copy of BulkImportReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRows = null,Object? successfulImports = null,Object? failedRows = null,Object? dryRun = null,Object? errors = null,}) {
  return _then(_BulkImportReport(
totalRows: null == totalRows ? _self.totalRows : totalRows // ignore: cast_nullable_to_non_nullable
as int,successfulImports: null == successfulImports ? _self.successfulImports : successfulImports // ignore: cast_nullable_to_non_nullable
as int,failedRows: null == failedRows ? _self.failedRows : failedRows // ignore: cast_nullable_to_non_nullable
as int,dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<BulkImportRowError>,
  ));
}


}


/// @nodoc
mixin _$MasterDataItem {

 String get id; String? get name; String? get label; String? get code; String? get description; String? get color; int? get order; int? get weight;@JsonKey(name: 'is_terminal') bool? get isTerminal;@JsonKey(name: 'annual_quota') double? get annualQuota;@JsonKey(name: 'is_paid') bool? get isPaid;@JsonKey(name: 'carry_forward') bool? get carryForward; String? get date; int? get year;@JsonKey(name: 'is_optional') bool? get isOptional; double? get latitude; double? get longitude;@JsonKey(name: 'radius_meters') double? get radiusMeters; String? get address;@JsonKey(name: 'client_id') String? get clientId;@JsonKey(name: 'contact_person') String? get contactPerson; String? get email; String? get phone;@JsonKey(name: 'shift_start') String? get shiftStart;@JsonKey(name: 'shift_end') String? get shiftEnd;@JsonKey(name: 'grace_minutes') int? get graceMinutes;@JsonKey(name: 'half_day_min_hours') double? get halfDayMinHours;@JsonKey(name: 'full_day_min_hours') double? get fullDayMinHours;@JsonKey(name: 'require_geofence') bool? get requireGeofence;@JsonKey(name: 'require_selfie') bool? get requireSelfie;@JsonKey(name: 'is_default') bool? get isDefault;@JsonKey(name: 'is_active') bool? get isActive;@JsonKey(name: 'from_status_id') String? get fromStatusId;@JsonKey(name: 'to_status_id') String? get toStatusId;@JsonKey(name: 'required_permission') String? get requiredPermission;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of MasterDataItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasterDataItemCopyWith<MasterDataItem> get copyWith => _$MasterDataItemCopyWithImpl<MasterDataItem>(this as MasterDataItem, _$identity);

  /// Serializes this MasterDataItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MasterDataItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.order, order) || other.order == order)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isTerminal, isTerminal) || other.isTerminal == isTerminal)&&(identical(other.annualQuota, annualQuota) || other.annualQuota == annualQuota)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.carryForward, carryForward) || other.carryForward == carryForward)&&(identical(other.date, date) || other.date == date)&&(identical(other.year, year) || other.year == year)&&(identical(other.isOptional, isOptional) || other.isOptional == isOptional)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.address, address) || other.address == address)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.contactPerson, contactPerson) || other.contactPerson == contactPerson)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.shiftStart, shiftStart) || other.shiftStart == shiftStart)&&(identical(other.shiftEnd, shiftEnd) || other.shiftEnd == shiftEnd)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.halfDayMinHours, halfDayMinHours) || other.halfDayMinHours == halfDayMinHours)&&(identical(other.fullDayMinHours, fullDayMinHours) || other.fullDayMinHours == fullDayMinHours)&&(identical(other.requireGeofence, requireGeofence) || other.requireGeofence == requireGeofence)&&(identical(other.requireSelfie, requireSelfie) || other.requireSelfie == requireSelfie)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.fromStatusId, fromStatusId) || other.fromStatusId == fromStatusId)&&(identical(other.toStatusId, toStatusId) || other.toStatusId == toStatusId)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,label,code,description,color,order,weight,isTerminal,annualQuota,isPaid,carryForward,date,year,isOptional,latitude,longitude,radiusMeters,address,clientId,contactPerson,email,phone,shiftStart,shiftEnd,graceMinutes,halfDayMinHours,fullDayMinHours,requireGeofence,requireSelfie,isDefault,isActive,fromStatusId,toStatusId,requiredPermission,createdAt]);

@override
String toString() {
  return 'MasterDataItem(id: $id, name: $name, label: $label, code: $code, description: $description, color: $color, order: $order, weight: $weight, isTerminal: $isTerminal, annualQuota: $annualQuota, isPaid: $isPaid, carryForward: $carryForward, date: $date, year: $year, isOptional: $isOptional, latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, address: $address, clientId: $clientId, contactPerson: $contactPerson, email: $email, phone: $phone, shiftStart: $shiftStart, shiftEnd: $shiftEnd, graceMinutes: $graceMinutes, halfDayMinHours: $halfDayMinHours, fullDayMinHours: $fullDayMinHours, requireGeofence: $requireGeofence, requireSelfie: $requireSelfie, isDefault: $isDefault, isActive: $isActive, fromStatusId: $fromStatusId, toStatusId: $toStatusId, requiredPermission: $requiredPermission, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MasterDataItemCopyWith<$Res>  {
  factory $MasterDataItemCopyWith(MasterDataItem value, $Res Function(MasterDataItem) _then) = _$MasterDataItemCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? label, String? code, String? description, String? color, int? order, int? weight,@JsonKey(name: 'is_terminal') bool? isTerminal,@JsonKey(name: 'annual_quota') double? annualQuota,@JsonKey(name: 'is_paid') bool? isPaid,@JsonKey(name: 'carry_forward') bool? carryForward, String? date, int? year,@JsonKey(name: 'is_optional') bool? isOptional, double? latitude, double? longitude,@JsonKey(name: 'radius_meters') double? radiusMeters, String? address,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'contact_person') String? contactPerson, String? email, String? phone,@JsonKey(name: 'shift_start') String? shiftStart,@JsonKey(name: 'shift_end') String? shiftEnd,@JsonKey(name: 'grace_minutes') int? graceMinutes,@JsonKey(name: 'half_day_min_hours') double? halfDayMinHours,@JsonKey(name: 'full_day_min_hours') double? fullDayMinHours,@JsonKey(name: 'require_geofence') bool? requireGeofence,@JsonKey(name: 'require_selfie') bool? requireSelfie,@JsonKey(name: 'is_default') bool? isDefault,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'from_status_id') String? fromStatusId,@JsonKey(name: 'to_status_id') String? toStatusId,@JsonKey(name: 'required_permission') String? requiredPermission,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$MasterDataItemCopyWithImpl<$Res>
    implements $MasterDataItemCopyWith<$Res> {
  _$MasterDataItemCopyWithImpl(this._self, this._then);

  final MasterDataItem _self;
  final $Res Function(MasterDataItem) _then;

/// Create a copy of MasterDataItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? label = freezed,Object? code = freezed,Object? description = freezed,Object? color = freezed,Object? order = freezed,Object? weight = freezed,Object? isTerminal = freezed,Object? annualQuota = freezed,Object? isPaid = freezed,Object? carryForward = freezed,Object? date = freezed,Object? year = freezed,Object? isOptional = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? radiusMeters = freezed,Object? address = freezed,Object? clientId = freezed,Object? contactPerson = freezed,Object? email = freezed,Object? phone = freezed,Object? shiftStart = freezed,Object? shiftEnd = freezed,Object? graceMinutes = freezed,Object? halfDayMinHours = freezed,Object? fullDayMinHours = freezed,Object? requireGeofence = freezed,Object? requireSelfie = freezed,Object? isDefault = freezed,Object? isActive = freezed,Object? fromStatusId = freezed,Object? toStatusId = freezed,Object? requiredPermission = freezed,Object? createdAt = freezed,}) {
  return _then(MasterDataItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,isTerminal: freezed == isTerminal ? _self.isTerminal : isTerminal // ignore: cast_nullable_to_non_nullable
as bool?,annualQuota: freezed == annualQuota ? _self.annualQuota : annualQuota // ignore: cast_nullable_to_non_nullable
as double?,isPaid: freezed == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool?,carryForward: freezed == carryForward ? _self.carryForward : carryForward // ignore: cast_nullable_to_non_nullable
as bool?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,isOptional: freezed == isOptional ? _self.isOptional : isOptional // ignore: cast_nullable_to_non_nullable
as bool?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,radiusMeters: freezed == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,contactPerson: freezed == contactPerson ? _self.contactPerson : contactPerson // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,shiftStart: freezed == shiftStart ? _self.shiftStart : shiftStart // ignore: cast_nullable_to_non_nullable
as String?,shiftEnd: freezed == shiftEnd ? _self.shiftEnd : shiftEnd // ignore: cast_nullable_to_non_nullable
as String?,graceMinutes: freezed == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int?,halfDayMinHours: freezed == halfDayMinHours ? _self.halfDayMinHours : halfDayMinHours // ignore: cast_nullable_to_non_nullable
as double?,fullDayMinHours: freezed == fullDayMinHours ? _self.fullDayMinHours : fullDayMinHours // ignore: cast_nullable_to_non_nullable
as double?,requireGeofence: freezed == requireGeofence ? _self.requireGeofence : requireGeofence // ignore: cast_nullable_to_non_nullable
as bool?,requireSelfie: freezed == requireSelfie ? _self.requireSelfie : requireSelfie // ignore: cast_nullable_to_non_nullable
as bool?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,fromStatusId: freezed == fromStatusId ? _self.fromStatusId : fromStatusId // ignore: cast_nullable_to_non_nullable
as String?,toStatusId: freezed == toStatusId ? _self.toStatusId : toStatusId // ignore: cast_nullable_to_non_nullable
as String?,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MasterDataItem].
extension MasterDataItemPatterns on MasterDataItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MasterDataItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MasterDataItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MasterDataItem value)  $default,){
final _that = this;
switch (_that) {
case _MasterDataItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MasterDataItem value)?  $default,){
final _that = this;
switch (_that) {
case _MasterDataItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? label,  String? code,  String? description,  String? color,  int? order,  int? weight, @JsonKey(name: 'is_terminal')  bool? isTerminal, @JsonKey(name: 'annual_quota')  double? annualQuota, @JsonKey(name: 'is_paid')  bool? isPaid, @JsonKey(name: 'carry_forward')  bool? carryForward,  String? date,  int? year, @JsonKey(name: 'is_optional')  bool? isOptional,  double? latitude,  double? longitude, @JsonKey(name: 'radius_meters')  double? radiusMeters,  String? address, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'contact_person')  String? contactPerson,  String? email,  String? phone, @JsonKey(name: 'shift_start')  String? shiftStart, @JsonKey(name: 'shift_end')  String? shiftEnd, @JsonKey(name: 'grace_minutes')  int? graceMinutes, @JsonKey(name: 'half_day_min_hours')  double? halfDayMinHours, @JsonKey(name: 'full_day_min_hours')  double? fullDayMinHours, @JsonKey(name: 'require_geofence')  bool? requireGeofence, @JsonKey(name: 'require_selfie')  bool? requireSelfie, @JsonKey(name: 'is_default')  bool? isDefault, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'from_status_id')  String? fromStatusId, @JsonKey(name: 'to_status_id')  String? toStatusId, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MasterDataItem() when $default != null:
return $default(_that.id,_that.name,_that.label,_that.code,_that.description,_that.color,_that.order,_that.weight,_that.isTerminal,_that.annualQuota,_that.isPaid,_that.carryForward,_that.date,_that.year,_that.isOptional,_that.latitude,_that.longitude,_that.radiusMeters,_that.address,_that.clientId,_that.contactPerson,_that.email,_that.phone,_that.shiftStart,_that.shiftEnd,_that.graceMinutes,_that.halfDayMinHours,_that.fullDayMinHours,_that.requireGeofence,_that.requireSelfie,_that.isDefault,_that.isActive,_that.fromStatusId,_that.toStatusId,_that.requiredPermission,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? label,  String? code,  String? description,  String? color,  int? order,  int? weight, @JsonKey(name: 'is_terminal')  bool? isTerminal, @JsonKey(name: 'annual_quota')  double? annualQuota, @JsonKey(name: 'is_paid')  bool? isPaid, @JsonKey(name: 'carry_forward')  bool? carryForward,  String? date,  int? year, @JsonKey(name: 'is_optional')  bool? isOptional,  double? latitude,  double? longitude, @JsonKey(name: 'radius_meters')  double? radiusMeters,  String? address, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'contact_person')  String? contactPerson,  String? email,  String? phone, @JsonKey(name: 'shift_start')  String? shiftStart, @JsonKey(name: 'shift_end')  String? shiftEnd, @JsonKey(name: 'grace_minutes')  int? graceMinutes, @JsonKey(name: 'half_day_min_hours')  double? halfDayMinHours, @JsonKey(name: 'full_day_min_hours')  double? fullDayMinHours, @JsonKey(name: 'require_geofence')  bool? requireGeofence, @JsonKey(name: 'require_selfie')  bool? requireSelfie, @JsonKey(name: 'is_default')  bool? isDefault, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'from_status_id')  String? fromStatusId, @JsonKey(name: 'to_status_id')  String? toStatusId, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MasterDataItem():
return $default(_that.id,_that.name,_that.label,_that.code,_that.description,_that.color,_that.order,_that.weight,_that.isTerminal,_that.annualQuota,_that.isPaid,_that.carryForward,_that.date,_that.year,_that.isOptional,_that.latitude,_that.longitude,_that.radiusMeters,_that.address,_that.clientId,_that.contactPerson,_that.email,_that.phone,_that.shiftStart,_that.shiftEnd,_that.graceMinutes,_that.halfDayMinHours,_that.fullDayMinHours,_that.requireGeofence,_that.requireSelfie,_that.isDefault,_that.isActive,_that.fromStatusId,_that.toStatusId,_that.requiredPermission,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? label,  String? code,  String? description,  String? color,  int? order,  int? weight, @JsonKey(name: 'is_terminal')  bool? isTerminal, @JsonKey(name: 'annual_quota')  double? annualQuota, @JsonKey(name: 'is_paid')  bool? isPaid, @JsonKey(name: 'carry_forward')  bool? carryForward,  String? date,  int? year, @JsonKey(name: 'is_optional')  bool? isOptional,  double? latitude,  double? longitude, @JsonKey(name: 'radius_meters')  double? radiusMeters,  String? address, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'contact_person')  String? contactPerson,  String? email,  String? phone, @JsonKey(name: 'shift_start')  String? shiftStart, @JsonKey(name: 'shift_end')  String? shiftEnd, @JsonKey(name: 'grace_minutes')  int? graceMinutes, @JsonKey(name: 'half_day_min_hours')  double? halfDayMinHours, @JsonKey(name: 'full_day_min_hours')  double? fullDayMinHours, @JsonKey(name: 'require_geofence')  bool? requireGeofence, @JsonKey(name: 'require_selfie')  bool? requireSelfie, @JsonKey(name: 'is_default')  bool? isDefault, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'from_status_id')  String? fromStatusId, @JsonKey(name: 'to_status_id')  String? toStatusId, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MasterDataItem() when $default != null:
return $default(_that.id,_that.name,_that.label,_that.code,_that.description,_that.color,_that.order,_that.weight,_that.isTerminal,_that.annualQuota,_that.isPaid,_that.carryForward,_that.date,_that.year,_that.isOptional,_that.latitude,_that.longitude,_that.radiusMeters,_that.address,_that.clientId,_that.contactPerson,_that.email,_that.phone,_that.shiftStart,_that.shiftEnd,_that.graceMinutes,_that.halfDayMinHours,_that.fullDayMinHours,_that.requireGeofence,_that.requireSelfie,_that.isDefault,_that.isActive,_that.fromStatusId,_that.toStatusId,_that.requiredPermission,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MasterDataItem implements MasterDataItem {
  const _MasterDataItem({required this.id, this.name, this.label, this.code, this.description, this.color, this.order, this.weight, @JsonKey(name: 'is_terminal') this.isTerminal, @JsonKey(name: 'annual_quota') this.annualQuota, @JsonKey(name: 'is_paid') this.isPaid, @JsonKey(name: 'carry_forward') this.carryForward, this.date, this.year, @JsonKey(name: 'is_optional') this.isOptional, this.latitude, this.longitude, @JsonKey(name: 'radius_meters') this.radiusMeters, this.address, @JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'contact_person') this.contactPerson, this.email, this.phone, @JsonKey(name: 'shift_start') this.shiftStart, @JsonKey(name: 'shift_end') this.shiftEnd, @JsonKey(name: 'grace_minutes') this.graceMinutes, @JsonKey(name: 'half_day_min_hours') this.halfDayMinHours, @JsonKey(name: 'full_day_min_hours') this.fullDayMinHours, @JsonKey(name: 'require_geofence') this.requireGeofence, @JsonKey(name: 'require_selfie') this.requireSelfie, @JsonKey(name: 'is_default') this.isDefault, @JsonKey(name: 'is_active') this.isActive, @JsonKey(name: 'from_status_id') this.fromStatusId, @JsonKey(name: 'to_status_id') this.toStatusId, @JsonKey(name: 'required_permission') this.requiredPermission, @JsonKey(name: 'created_at') this.createdAt});
  factory _MasterDataItem.fromJson(Map<String, dynamic> json) => _$MasterDataItemFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? label;
@override final  String? code;
@override final  String? description;
@override final  String? color;
@override final  int? order;
@override final  int? weight;
@override@JsonKey(name: 'is_terminal') final  bool? isTerminal;
@override@JsonKey(name: 'annual_quota') final  double? annualQuota;
@override@JsonKey(name: 'is_paid') final  bool? isPaid;
@override@JsonKey(name: 'carry_forward') final  bool? carryForward;
@override final  String? date;
@override final  int? year;
@override@JsonKey(name: 'is_optional') final  bool? isOptional;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'radius_meters') final  double? radiusMeters;
@override final  String? address;
@override@JsonKey(name: 'client_id') final  String? clientId;
@override@JsonKey(name: 'contact_person') final  String? contactPerson;
@override final  String? email;
@override final  String? phone;
@override@JsonKey(name: 'shift_start') final  String? shiftStart;
@override@JsonKey(name: 'shift_end') final  String? shiftEnd;
@override@JsonKey(name: 'grace_minutes') final  int? graceMinutes;
@override@JsonKey(name: 'half_day_min_hours') final  double? halfDayMinHours;
@override@JsonKey(name: 'full_day_min_hours') final  double? fullDayMinHours;
@override@JsonKey(name: 'require_geofence') final  bool? requireGeofence;
@override@JsonKey(name: 'require_selfie') final  bool? requireSelfie;
@override@JsonKey(name: 'is_default') final  bool? isDefault;
@override@JsonKey(name: 'is_active') final  bool? isActive;
@override@JsonKey(name: 'from_status_id') final  String? fromStatusId;
@override@JsonKey(name: 'to_status_id') final  String? toStatusId;
@override@JsonKey(name: 'required_permission') final  String? requiredPermission;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of MasterDataItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MasterDataItemCopyWith<_MasterDataItem> get copyWith => __$MasterDataItemCopyWithImpl<_MasterDataItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MasterDataItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MasterDataItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.order, order) || other.order == order)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isTerminal, isTerminal) || other.isTerminal == isTerminal)&&(identical(other.annualQuota, annualQuota) || other.annualQuota == annualQuota)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.carryForward, carryForward) || other.carryForward == carryForward)&&(identical(other.date, date) || other.date == date)&&(identical(other.year, year) || other.year == year)&&(identical(other.isOptional, isOptional) || other.isOptional == isOptional)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.address, address) || other.address == address)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.contactPerson, contactPerson) || other.contactPerson == contactPerson)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.shiftStart, shiftStart) || other.shiftStart == shiftStart)&&(identical(other.shiftEnd, shiftEnd) || other.shiftEnd == shiftEnd)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.halfDayMinHours, halfDayMinHours) || other.halfDayMinHours == halfDayMinHours)&&(identical(other.fullDayMinHours, fullDayMinHours) || other.fullDayMinHours == fullDayMinHours)&&(identical(other.requireGeofence, requireGeofence) || other.requireGeofence == requireGeofence)&&(identical(other.requireSelfie, requireSelfie) || other.requireSelfie == requireSelfie)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.fromStatusId, fromStatusId) || other.fromStatusId == fromStatusId)&&(identical(other.toStatusId, toStatusId) || other.toStatusId == toStatusId)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,label,code,description,color,order,weight,isTerminal,annualQuota,isPaid,carryForward,date,year,isOptional,latitude,longitude,radiusMeters,address,clientId,contactPerson,email,phone,shiftStart,shiftEnd,graceMinutes,halfDayMinHours,fullDayMinHours,requireGeofence,requireSelfie,isDefault,isActive,fromStatusId,toStatusId,requiredPermission,createdAt]);

@override
String toString() {
  return 'MasterDataItem(id: $id, name: $name, label: $label, code: $code, description: $description, color: $color, order: $order, weight: $weight, isTerminal: $isTerminal, annualQuota: $annualQuota, isPaid: $isPaid, carryForward: $carryForward, date: $date, year: $year, isOptional: $isOptional, latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, address: $address, clientId: $clientId, contactPerson: $contactPerson, email: $email, phone: $phone, shiftStart: $shiftStart, shiftEnd: $shiftEnd, graceMinutes: $graceMinutes, halfDayMinHours: $halfDayMinHours, fullDayMinHours: $fullDayMinHours, requireGeofence: $requireGeofence, requireSelfie: $requireSelfie, isDefault: $isDefault, isActive: $isActive, fromStatusId: $fromStatusId, toStatusId: $toStatusId, requiredPermission: $requiredPermission, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MasterDataItemCopyWith<$Res> implements $MasterDataItemCopyWith<$Res> {
  factory _$MasterDataItemCopyWith(_MasterDataItem value, $Res Function(_MasterDataItem) _then) = __$MasterDataItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? label, String? code, String? description, String? color, int? order, int? weight,@JsonKey(name: 'is_terminal') bool? isTerminal,@JsonKey(name: 'annual_quota') double? annualQuota,@JsonKey(name: 'is_paid') bool? isPaid,@JsonKey(name: 'carry_forward') bool? carryForward, String? date, int? year,@JsonKey(name: 'is_optional') bool? isOptional, double? latitude, double? longitude,@JsonKey(name: 'radius_meters') double? radiusMeters, String? address,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'contact_person') String? contactPerson, String? email, String? phone,@JsonKey(name: 'shift_start') String? shiftStart,@JsonKey(name: 'shift_end') String? shiftEnd,@JsonKey(name: 'grace_minutes') int? graceMinutes,@JsonKey(name: 'half_day_min_hours') double? halfDayMinHours,@JsonKey(name: 'full_day_min_hours') double? fullDayMinHours,@JsonKey(name: 'require_geofence') bool? requireGeofence,@JsonKey(name: 'require_selfie') bool? requireSelfie,@JsonKey(name: 'is_default') bool? isDefault,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'from_status_id') String? fromStatusId,@JsonKey(name: 'to_status_id') String? toStatusId,@JsonKey(name: 'required_permission') String? requiredPermission,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$MasterDataItemCopyWithImpl<$Res>
    implements _$MasterDataItemCopyWith<$Res> {
  __$MasterDataItemCopyWithImpl(this._self, this._then);

  final _MasterDataItem _self;
  final $Res Function(_MasterDataItem) _then;

/// Create a copy of MasterDataItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? label = freezed,Object? code = freezed,Object? description = freezed,Object? color = freezed,Object? order = freezed,Object? weight = freezed,Object? isTerminal = freezed,Object? annualQuota = freezed,Object? isPaid = freezed,Object? carryForward = freezed,Object? date = freezed,Object? year = freezed,Object? isOptional = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? radiusMeters = freezed,Object? address = freezed,Object? clientId = freezed,Object? contactPerson = freezed,Object? email = freezed,Object? phone = freezed,Object? shiftStart = freezed,Object? shiftEnd = freezed,Object? graceMinutes = freezed,Object? halfDayMinHours = freezed,Object? fullDayMinHours = freezed,Object? requireGeofence = freezed,Object? requireSelfie = freezed,Object? isDefault = freezed,Object? isActive = freezed,Object? fromStatusId = freezed,Object? toStatusId = freezed,Object? requiredPermission = freezed,Object? createdAt = freezed,}) {
  return _then(_MasterDataItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,isTerminal: freezed == isTerminal ? _self.isTerminal : isTerminal // ignore: cast_nullable_to_non_nullable
as bool?,annualQuota: freezed == annualQuota ? _self.annualQuota : annualQuota // ignore: cast_nullable_to_non_nullable
as double?,isPaid: freezed == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool?,carryForward: freezed == carryForward ? _self.carryForward : carryForward // ignore: cast_nullable_to_non_nullable
as bool?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,isOptional: freezed == isOptional ? _self.isOptional : isOptional // ignore: cast_nullable_to_non_nullable
as bool?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,radiusMeters: freezed == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,contactPerson: freezed == contactPerson ? _self.contactPerson : contactPerson // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,shiftStart: freezed == shiftStart ? _self.shiftStart : shiftStart // ignore: cast_nullable_to_non_nullable
as String?,shiftEnd: freezed == shiftEnd ? _self.shiftEnd : shiftEnd // ignore: cast_nullable_to_non_nullable
as String?,graceMinutes: freezed == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int?,halfDayMinHours: freezed == halfDayMinHours ? _self.halfDayMinHours : halfDayMinHours // ignore: cast_nullable_to_non_nullable
as double?,fullDayMinHours: freezed == fullDayMinHours ? _self.fullDayMinHours : fullDayMinHours // ignore: cast_nullable_to_non_nullable
as double?,requireGeofence: freezed == requireGeofence ? _self.requireGeofence : requireGeofence // ignore: cast_nullable_to_non_nullable
as bool?,requireSelfie: freezed == requireSelfie ? _self.requireSelfie : requireSelfie // ignore: cast_nullable_to_non_nullable
as bool?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,fromStatusId: freezed == fromStatusId ? _self.fromStatusId : fromStatusId // ignore: cast_nullable_to_non_nullable
as String?,toStatusId: freezed == toStatusId ? _self.toStatusId : toStatusId // ignore: cast_nullable_to_non_nullable
as String?,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
