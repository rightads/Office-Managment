// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_report_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportEmployeeItem {

 String get id;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'full_name') String get fullName; String get email;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'department_name') String? get departmentName; String? get designation;
/// Create a copy of ReportEmployeeItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportEmployeeItemCopyWith<ReportEmployeeItem> get copyWith => _$ReportEmployeeItemCopyWithImpl<ReportEmployeeItem>(this as ReportEmployeeItem, _$identity);

  /// Serializes this ReportEmployeeItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportEmployeeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,avatarUrl,departmentName,designation);

@override
String toString() {
  return 'ReportEmployeeItem(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, departmentName: $departmentName, designation: $designation)';
}


}

/// @nodoc
abstract mixin class $ReportEmployeeItemCopyWith<$Res>  {
  factory $ReportEmployeeItemCopyWith(ReportEmployeeItem value, $Res Function(ReportEmployeeItem) _then) = _$ReportEmployeeItemCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'department_name') String? departmentName, String? designation
});




}
/// @nodoc
class _$ReportEmployeeItemCopyWithImpl<$Res>
    implements $ReportEmployeeItemCopyWith<$Res> {
  _$ReportEmployeeItemCopyWithImpl(this._self, this._then);

  final ReportEmployeeItem _self;
  final $Res Function(ReportEmployeeItem) _then;

/// Create a copy of ReportEmployeeItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? avatarUrl = freezed,Object? departmentName = freezed,Object? designation = freezed,}) {
  return _then(ReportEmployeeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportEmployeeItem].
extension ReportEmployeeItemPatterns on ReportEmployeeItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportEmployeeItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportEmployeeItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportEmployeeItem value)  $default,){
final _that = this;
switch (_that) {
case _ReportEmployeeItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportEmployeeItem value)?  $default,){
final _that = this;
switch (_that) {
case _ReportEmployeeItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'department_name')  String? departmentName,  String? designation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportEmployeeItem() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.avatarUrl,_that.departmentName,_that.designation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'department_name')  String? departmentName,  String? designation)  $default,) {final _that = this;
switch (_that) {
case _ReportEmployeeItem():
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.avatarUrl,_that.departmentName,_that.designation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'department_name')  String? departmentName,  String? designation)?  $default,) {final _that = this;
switch (_that) {
case _ReportEmployeeItem() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.avatarUrl,_that.departmentName,_that.designation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportEmployeeItem implements ReportEmployeeItem {
  const _ReportEmployeeItem({required this.id, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'full_name') required this.fullName, required this.email, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'department_name') this.departmentName, this.designation});
  factory _ReportEmployeeItem.fromJson(Map<String, dynamic> json) => _$ReportEmployeeItemFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String email;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override final  String? designation;

/// Create a copy of ReportEmployeeItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportEmployeeItemCopyWith<_ReportEmployeeItem> get copyWith => __$ReportEmployeeItemCopyWithImpl<_ReportEmployeeItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportEmployeeItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportEmployeeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,avatarUrl,departmentName,designation);

@override
String toString() {
  return 'ReportEmployeeItem(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, departmentName: $departmentName, designation: $designation)';
}


}

/// @nodoc
abstract mixin class _$ReportEmployeeItemCopyWith<$Res> implements $ReportEmployeeItemCopyWith<$Res> {
  factory _$ReportEmployeeItemCopyWith(_ReportEmployeeItem value, $Res Function(_ReportEmployeeItem) _then) = __$ReportEmployeeItemCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'department_name') String? departmentName, String? designation
});




}
/// @nodoc
class __$ReportEmployeeItemCopyWithImpl<$Res>
    implements _$ReportEmployeeItemCopyWith<$Res> {
  __$ReportEmployeeItemCopyWithImpl(this._self, this._then);

  final _ReportEmployeeItem _self;
  final $Res Function(_ReportEmployeeItem) _then;

/// Create a copy of ReportEmployeeItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? avatarUrl = freezed,Object? departmentName = freezed,Object? designation = freezed,}) {
  return _then(_ReportEmployeeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AttendanceSummaryStatusCount {

@JsonKey(name: 'status_id') String get statusId;@JsonKey(name: 'status_name') String get statusName;@JsonKey(name: 'status_code') String get statusCode;@JsonKey(name: 'badge_color') String get badgeColor; int get count; List<ReportEmployeeItem> get employees;
/// Create a copy of AttendanceSummaryStatusCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceSummaryStatusCountCopyWith<AttendanceSummaryStatusCount> get copyWith => _$AttendanceSummaryStatusCountCopyWithImpl<AttendanceSummaryStatusCount>(this as AttendanceSummaryStatusCount, _$identity);

  /// Serializes this AttendanceSummaryStatusCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceSummaryStatusCount&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.statusName, statusName) || other.statusName == statusName)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.badgeColor, badgeColor) || other.badgeColor == badgeColor)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.employees, employees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusId,statusName,statusCode,badgeColor,count,const DeepCollectionEquality().hash(employees));

@override
String toString() {
  return 'AttendanceSummaryStatusCount(statusId: $statusId, statusName: $statusName, statusCode: $statusCode, badgeColor: $badgeColor, count: $count, employees: $employees)';
}


}

/// @nodoc
abstract mixin class $AttendanceSummaryStatusCountCopyWith<$Res>  {
  factory $AttendanceSummaryStatusCountCopyWith(AttendanceSummaryStatusCount value, $Res Function(AttendanceSummaryStatusCount) _then) = _$AttendanceSummaryStatusCountCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'status_id') String statusId,@JsonKey(name: 'status_name') String statusName,@JsonKey(name: 'status_code') String statusCode,@JsonKey(name: 'badge_color') String badgeColor, int count, List<ReportEmployeeItem> employees
});




}
/// @nodoc
class _$AttendanceSummaryStatusCountCopyWithImpl<$Res>
    implements $AttendanceSummaryStatusCountCopyWith<$Res> {
  _$AttendanceSummaryStatusCountCopyWithImpl(this._self, this._then);

  final AttendanceSummaryStatusCount _self;
  final $Res Function(AttendanceSummaryStatusCount) _then;

/// Create a copy of AttendanceSummaryStatusCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusId = null,Object? statusName = null,Object? statusCode = null,Object? badgeColor = null,Object? count = null,Object? employees = null,}) {
  return _then(AttendanceSummaryStatusCount(
statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String,statusName: null == statusName ? _self.statusName : statusName // ignore: cast_nullable_to_non_nullable
as String,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as String,badgeColor: null == badgeColor ? _self.badgeColor : badgeColor // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,employees: null == employees ? _self.employees : employees // ignore: cast_nullable_to_non_nullable
as List<ReportEmployeeItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceSummaryStatusCount].
extension AttendanceSummaryStatusCountPatterns on AttendanceSummaryStatusCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceSummaryStatusCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceSummaryStatusCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceSummaryStatusCount value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceSummaryStatusCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceSummaryStatusCount value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceSummaryStatusCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'status_id')  String statusId, @JsonKey(name: 'status_name')  String statusName, @JsonKey(name: 'status_code')  String statusCode, @JsonKey(name: 'badge_color')  String badgeColor,  int count,  List<ReportEmployeeItem> employees)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceSummaryStatusCount() when $default != null:
return $default(_that.statusId,_that.statusName,_that.statusCode,_that.badgeColor,_that.count,_that.employees);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'status_id')  String statusId, @JsonKey(name: 'status_name')  String statusName, @JsonKey(name: 'status_code')  String statusCode, @JsonKey(name: 'badge_color')  String badgeColor,  int count,  List<ReportEmployeeItem> employees)  $default,) {final _that = this;
switch (_that) {
case _AttendanceSummaryStatusCount():
return $default(_that.statusId,_that.statusName,_that.statusCode,_that.badgeColor,_that.count,_that.employees);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'status_id')  String statusId, @JsonKey(name: 'status_name')  String statusName, @JsonKey(name: 'status_code')  String statusCode, @JsonKey(name: 'badge_color')  String badgeColor,  int count,  List<ReportEmployeeItem> employees)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceSummaryStatusCount() when $default != null:
return $default(_that.statusId,_that.statusName,_that.statusCode,_that.badgeColor,_that.count,_that.employees);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceSummaryStatusCount implements AttendanceSummaryStatusCount {
  const _AttendanceSummaryStatusCount({@JsonKey(name: 'status_id') required this.statusId, @JsonKey(name: 'status_name') required this.statusName, @JsonKey(name: 'status_code') required this.statusCode, @JsonKey(name: 'badge_color') required this.badgeColor, required this.count,  List<ReportEmployeeItem> employees = const <ReportEmployeeItem>[]}): _employees = employees;
  factory _AttendanceSummaryStatusCount.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryStatusCountFromJson(json);

@override@JsonKey(name: 'status_id') final  String statusId;
@override@JsonKey(name: 'status_name') final  String statusName;
@override@JsonKey(name: 'status_code') final  String statusCode;
@override@JsonKey(name: 'badge_color') final  String badgeColor;
@override final  int count;
 final  List<ReportEmployeeItem> _employees;
@override@JsonKey() List<ReportEmployeeItem> get employees {
  if (_employees is EqualUnmodifiableListView) return _employees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employees);
}


/// Create a copy of AttendanceSummaryStatusCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceSummaryStatusCountCopyWith<_AttendanceSummaryStatusCount> get copyWith => __$AttendanceSummaryStatusCountCopyWithImpl<_AttendanceSummaryStatusCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceSummaryStatusCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceSummaryStatusCount&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.statusName, statusName) || other.statusName == statusName)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.badgeColor, badgeColor) || other.badgeColor == badgeColor)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._employees, _employees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusId,statusName,statusCode,badgeColor,count,const DeepCollectionEquality().hash(_employees));

@override
String toString() {
  return 'AttendanceSummaryStatusCount(statusId: $statusId, statusName: $statusName, statusCode: $statusCode, badgeColor: $badgeColor, count: $count, employees: $employees)';
}


}

/// @nodoc
abstract mixin class _$AttendanceSummaryStatusCountCopyWith<$Res> implements $AttendanceSummaryStatusCountCopyWith<$Res> {
  factory _$AttendanceSummaryStatusCountCopyWith(_AttendanceSummaryStatusCount value, $Res Function(_AttendanceSummaryStatusCount) _then) = __$AttendanceSummaryStatusCountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'status_id') String statusId,@JsonKey(name: 'status_name') String statusName,@JsonKey(name: 'status_code') String statusCode,@JsonKey(name: 'badge_color') String badgeColor, int count, List<ReportEmployeeItem> employees
});




}
/// @nodoc
class __$AttendanceSummaryStatusCountCopyWithImpl<$Res>
    implements _$AttendanceSummaryStatusCountCopyWith<$Res> {
  __$AttendanceSummaryStatusCountCopyWithImpl(this._self, this._then);

  final _AttendanceSummaryStatusCount _self;
  final $Res Function(_AttendanceSummaryStatusCount) _then;

/// Create a copy of AttendanceSummaryStatusCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusId = null,Object? statusName = null,Object? statusCode = null,Object? badgeColor = null,Object? count = null,Object? employees = null,}) {
  return _then(_AttendanceSummaryStatusCount(
statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String,statusName: null == statusName ? _self.statusName : statusName // ignore: cast_nullable_to_non_nullable
as String,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as String,badgeColor: null == badgeColor ? _self.badgeColor : badgeColor // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,employees: null == employees ? _self._employees : employees // ignore: cast_nullable_to_non_nullable
as List<ReportEmployeeItem>,
  ));
}


}


/// @nodoc
mixin _$AttendanceTodayReportResponse {

 String get date;@JsonKey(name: 'total_active_employees') int get totalActiveEmployees;@JsonKey(name: 'present_count') int get presentCount;@JsonKey(name: 'absent_count') int get absentCount;@JsonKey(name: 'late_count') int get lateCount;@JsonKey(name: 'half_day_count') int get halfDayCount;@JsonKey(name: 'on_leave_count') int get onLeaveCount;@JsonKey(name: 'status_breakdown') List<AttendanceSummaryStatusCount> get statusBreakdown;
/// Create a copy of AttendanceTodayReportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceTodayReportResponseCopyWith<AttendanceTodayReportResponse> get copyWith => _$AttendanceTodayReportResponseCopyWithImpl<AttendanceTodayReportResponse>(this as AttendanceTodayReportResponse, _$identity);

  /// Serializes this AttendanceTodayReportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceTodayReportResponse&&(identical(other.date, date) || other.date == date)&&(identical(other.totalActiveEmployees, totalActiveEmployees) || other.totalActiveEmployees == totalActiveEmployees)&&(identical(other.presentCount, presentCount) || other.presentCount == presentCount)&&(identical(other.absentCount, absentCount) || other.absentCount == absentCount)&&(identical(other.lateCount, lateCount) || other.lateCount == lateCount)&&(identical(other.halfDayCount, halfDayCount) || other.halfDayCount == halfDayCount)&&(identical(other.onLeaveCount, onLeaveCount) || other.onLeaveCount == onLeaveCount)&&const DeepCollectionEquality().equals(other.statusBreakdown, statusBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totalActiveEmployees,presentCount,absentCount,lateCount,halfDayCount,onLeaveCount,const DeepCollectionEquality().hash(statusBreakdown));

@override
String toString() {
  return 'AttendanceTodayReportResponse(date: $date, totalActiveEmployees: $totalActiveEmployees, presentCount: $presentCount, absentCount: $absentCount, lateCount: $lateCount, halfDayCount: $halfDayCount, onLeaveCount: $onLeaveCount, statusBreakdown: $statusBreakdown)';
}


}

/// @nodoc
abstract mixin class $AttendanceTodayReportResponseCopyWith<$Res>  {
  factory $AttendanceTodayReportResponseCopyWith(AttendanceTodayReportResponse value, $Res Function(AttendanceTodayReportResponse) _then) = _$AttendanceTodayReportResponseCopyWithImpl;
@useResult
$Res call({
 String date,@JsonKey(name: 'total_active_employees') int totalActiveEmployees,@JsonKey(name: 'present_count') int presentCount,@JsonKey(name: 'absent_count') int absentCount,@JsonKey(name: 'late_count') int lateCount,@JsonKey(name: 'half_day_count') int halfDayCount,@JsonKey(name: 'on_leave_count') int onLeaveCount,@JsonKey(name: 'status_breakdown') List<AttendanceSummaryStatusCount> statusBreakdown
});




}
/// @nodoc
class _$AttendanceTodayReportResponseCopyWithImpl<$Res>
    implements $AttendanceTodayReportResponseCopyWith<$Res> {
  _$AttendanceTodayReportResponseCopyWithImpl(this._self, this._then);

  final AttendanceTodayReportResponse _self;
  final $Res Function(AttendanceTodayReportResponse) _then;

/// Create a copy of AttendanceTodayReportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totalActiveEmployees = null,Object? presentCount = null,Object? absentCount = null,Object? lateCount = null,Object? halfDayCount = null,Object? onLeaveCount = null,Object? statusBreakdown = null,}) {
  return _then(AttendanceTodayReportResponse(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,totalActiveEmployees: null == totalActiveEmployees ? _self.totalActiveEmployees : totalActiveEmployees // ignore: cast_nullable_to_non_nullable
as int,presentCount: null == presentCount ? _self.presentCount : presentCount // ignore: cast_nullable_to_non_nullable
as int,absentCount: null == absentCount ? _self.absentCount : absentCount // ignore: cast_nullable_to_non_nullable
as int,lateCount: null == lateCount ? _self.lateCount : lateCount // ignore: cast_nullable_to_non_nullable
as int,halfDayCount: null == halfDayCount ? _self.halfDayCount : halfDayCount // ignore: cast_nullable_to_non_nullable
as int,onLeaveCount: null == onLeaveCount ? _self.onLeaveCount : onLeaveCount // ignore: cast_nullable_to_non_nullable
as int,statusBreakdown: null == statusBreakdown ? _self.statusBreakdown : statusBreakdown // ignore: cast_nullable_to_non_nullable
as List<AttendanceSummaryStatusCount>,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceTodayReportResponse].
extension AttendanceTodayReportResponsePatterns on AttendanceTodayReportResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceTodayReportResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceTodayReportResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceTodayReportResponse value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceTodayReportResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceTodayReportResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceTodayReportResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date, @JsonKey(name: 'total_active_employees')  int totalActiveEmployees, @JsonKey(name: 'present_count')  int presentCount, @JsonKey(name: 'absent_count')  int absentCount, @JsonKey(name: 'late_count')  int lateCount, @JsonKey(name: 'half_day_count')  int halfDayCount, @JsonKey(name: 'on_leave_count')  int onLeaveCount, @JsonKey(name: 'status_breakdown')  List<AttendanceSummaryStatusCount> statusBreakdown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceTodayReportResponse() when $default != null:
return $default(_that.date,_that.totalActiveEmployees,_that.presentCount,_that.absentCount,_that.lateCount,_that.halfDayCount,_that.onLeaveCount,_that.statusBreakdown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date, @JsonKey(name: 'total_active_employees')  int totalActiveEmployees, @JsonKey(name: 'present_count')  int presentCount, @JsonKey(name: 'absent_count')  int absentCount, @JsonKey(name: 'late_count')  int lateCount, @JsonKey(name: 'half_day_count')  int halfDayCount, @JsonKey(name: 'on_leave_count')  int onLeaveCount, @JsonKey(name: 'status_breakdown')  List<AttendanceSummaryStatusCount> statusBreakdown)  $default,) {final _that = this;
switch (_that) {
case _AttendanceTodayReportResponse():
return $default(_that.date,_that.totalActiveEmployees,_that.presentCount,_that.absentCount,_that.lateCount,_that.halfDayCount,_that.onLeaveCount,_that.statusBreakdown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date, @JsonKey(name: 'total_active_employees')  int totalActiveEmployees, @JsonKey(name: 'present_count')  int presentCount, @JsonKey(name: 'absent_count')  int absentCount, @JsonKey(name: 'late_count')  int lateCount, @JsonKey(name: 'half_day_count')  int halfDayCount, @JsonKey(name: 'on_leave_count')  int onLeaveCount, @JsonKey(name: 'status_breakdown')  List<AttendanceSummaryStatusCount> statusBreakdown)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceTodayReportResponse() when $default != null:
return $default(_that.date,_that.totalActiveEmployees,_that.presentCount,_that.absentCount,_that.lateCount,_that.halfDayCount,_that.onLeaveCount,_that.statusBreakdown);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceTodayReportResponse implements AttendanceTodayReportResponse {
  const _AttendanceTodayReportResponse({required this.date, @JsonKey(name: 'total_active_employees') required this.totalActiveEmployees, @JsonKey(name: 'present_count') required this.presentCount, @JsonKey(name: 'absent_count') required this.absentCount, @JsonKey(name: 'late_count') required this.lateCount, @JsonKey(name: 'half_day_count') required this.halfDayCount, @JsonKey(name: 'on_leave_count') required this.onLeaveCount, @JsonKey(name: 'status_breakdown')  List<AttendanceSummaryStatusCount> statusBreakdown = const <AttendanceSummaryStatusCount>[]}): _statusBreakdown = statusBreakdown;
  factory _AttendanceTodayReportResponse.fromJson(Map<String, dynamic> json) => _$AttendanceTodayReportResponseFromJson(json);

@override final  String date;
@override@JsonKey(name: 'total_active_employees') final  int totalActiveEmployees;
@override@JsonKey(name: 'present_count') final  int presentCount;
@override@JsonKey(name: 'absent_count') final  int absentCount;
@override@JsonKey(name: 'late_count') final  int lateCount;
@override@JsonKey(name: 'half_day_count') final  int halfDayCount;
@override@JsonKey(name: 'on_leave_count') final  int onLeaveCount;
 final  List<AttendanceSummaryStatusCount> _statusBreakdown;
@override@JsonKey(name: 'status_breakdown') List<AttendanceSummaryStatusCount> get statusBreakdown {
  if (_statusBreakdown is EqualUnmodifiableListView) return _statusBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusBreakdown);
}


/// Create a copy of AttendanceTodayReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceTodayReportResponseCopyWith<_AttendanceTodayReportResponse> get copyWith => __$AttendanceTodayReportResponseCopyWithImpl<_AttendanceTodayReportResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceTodayReportResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceTodayReportResponse&&(identical(other.date, date) || other.date == date)&&(identical(other.totalActiveEmployees, totalActiveEmployees) || other.totalActiveEmployees == totalActiveEmployees)&&(identical(other.presentCount, presentCount) || other.presentCount == presentCount)&&(identical(other.absentCount, absentCount) || other.absentCount == absentCount)&&(identical(other.lateCount, lateCount) || other.lateCount == lateCount)&&(identical(other.halfDayCount, halfDayCount) || other.halfDayCount == halfDayCount)&&(identical(other.onLeaveCount, onLeaveCount) || other.onLeaveCount == onLeaveCount)&&const DeepCollectionEquality().equals(other._statusBreakdown, _statusBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totalActiveEmployees,presentCount,absentCount,lateCount,halfDayCount,onLeaveCount,const DeepCollectionEquality().hash(_statusBreakdown));

@override
String toString() {
  return 'AttendanceTodayReportResponse(date: $date, totalActiveEmployees: $totalActiveEmployees, presentCount: $presentCount, absentCount: $absentCount, lateCount: $lateCount, halfDayCount: $halfDayCount, onLeaveCount: $onLeaveCount, statusBreakdown: $statusBreakdown)';
}


}

/// @nodoc
abstract mixin class _$AttendanceTodayReportResponseCopyWith<$Res> implements $AttendanceTodayReportResponseCopyWith<$Res> {
  factory _$AttendanceTodayReportResponseCopyWith(_AttendanceTodayReportResponse value, $Res Function(_AttendanceTodayReportResponse) _then) = __$AttendanceTodayReportResponseCopyWithImpl;
@override @useResult
$Res call({
 String date,@JsonKey(name: 'total_active_employees') int totalActiveEmployees,@JsonKey(name: 'present_count') int presentCount,@JsonKey(name: 'absent_count') int absentCount,@JsonKey(name: 'late_count') int lateCount,@JsonKey(name: 'half_day_count') int halfDayCount,@JsonKey(name: 'on_leave_count') int onLeaveCount,@JsonKey(name: 'status_breakdown') List<AttendanceSummaryStatusCount> statusBreakdown
});




}
/// @nodoc
class __$AttendanceTodayReportResponseCopyWithImpl<$Res>
    implements _$AttendanceTodayReportResponseCopyWith<$Res> {
  __$AttendanceTodayReportResponseCopyWithImpl(this._self, this._then);

  final _AttendanceTodayReportResponse _self;
  final $Res Function(_AttendanceTodayReportResponse) _then;

/// Create a copy of AttendanceTodayReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? totalActiveEmployees = null,Object? presentCount = null,Object? absentCount = null,Object? lateCount = null,Object? halfDayCount = null,Object? onLeaveCount = null,Object? statusBreakdown = null,}) {
  return _then(_AttendanceTodayReportResponse(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,totalActiveEmployees: null == totalActiveEmployees ? _self.totalActiveEmployees : totalActiveEmployees // ignore: cast_nullable_to_non_nullable
as int,presentCount: null == presentCount ? _self.presentCount : presentCount // ignore: cast_nullable_to_non_nullable
as int,absentCount: null == absentCount ? _self.absentCount : absentCount // ignore: cast_nullable_to_non_nullable
as int,lateCount: null == lateCount ? _self.lateCount : lateCount // ignore: cast_nullable_to_non_nullable
as int,halfDayCount: null == halfDayCount ? _self.halfDayCount : halfDayCount // ignore: cast_nullable_to_non_nullable
as int,onLeaveCount: null == onLeaveCount ? _self.onLeaveCount : onLeaveCount // ignore: cast_nullable_to_non_nullable
as int,statusBreakdown: null == statusBreakdown ? _self._statusBreakdown : statusBreakdown // ignore: cast_nullable_to_non_nullable
as List<AttendanceSummaryStatusCount>,
  ));
}


}


/// @nodoc
mixin _$AttendanceDayDetail {

 String get date;@JsonKey(name: 'day_of_week') String get dayOfWeek;@JsonKey(name: 'is_working_day') bool get isWorkingDay;@JsonKey(name: 'is_holiday') bool get isHoliday;@JsonKey(name: 'holiday_name') String? get holidayName;@JsonKey(name: 'status_name') String? get statusName;@JsonKey(name: 'status_code') String? get statusCode;@JsonKey(name: 'badge_color') String? get badgeColor;@JsonKey(name: 'first_check_in') String? get firstCheckIn;@JsonKey(name: 'last_check_out') String? get lastCheckOut;@JsonKey(name: 'total_hours_worked') double get totalHoursWorked;@JsonKey(name: 'overtime_hours') double get overtimeHours;@JsonKey(name: 'is_late') bool get isLate;@JsonKey(name: 'is_half_day') bool get isHalfDay;@JsonKey(name: 'correction_applied') bool get correctionApplied;
/// Create a copy of AttendanceDayDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceDayDetailCopyWith<AttendanceDayDetail> get copyWith => _$AttendanceDayDetailCopyWithImpl<AttendanceDayDetail>(this as AttendanceDayDetail, _$identity);

  /// Serializes this AttendanceDayDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceDayDetail&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isWorkingDay, isWorkingDay) || other.isWorkingDay == isWorkingDay)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.holidayName, holidayName) || other.holidayName == holidayName)&&(identical(other.statusName, statusName) || other.statusName == statusName)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.badgeColor, badgeColor) || other.badgeColor == badgeColor)&&(identical(other.firstCheckIn, firstCheckIn) || other.firstCheckIn == firstCheckIn)&&(identical(other.lastCheckOut, lastCheckOut) || other.lastCheckOut == lastCheckOut)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.overtimeHours, overtimeHours) || other.overtimeHours == overtimeHours)&&(identical(other.isLate, isLate) || other.isLate == isLate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.correctionApplied, correctionApplied) || other.correctionApplied == correctionApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dayOfWeek,isWorkingDay,isHoliday,holidayName,statusName,statusCode,badgeColor,firstCheckIn,lastCheckOut,totalHoursWorked,overtimeHours,isLate,isHalfDay,correctionApplied);

@override
String toString() {
  return 'AttendanceDayDetail(date: $date, dayOfWeek: $dayOfWeek, isWorkingDay: $isWorkingDay, isHoliday: $isHoliday, holidayName: $holidayName, statusName: $statusName, statusCode: $statusCode, badgeColor: $badgeColor, firstCheckIn: $firstCheckIn, lastCheckOut: $lastCheckOut, totalHoursWorked: $totalHoursWorked, overtimeHours: $overtimeHours, isLate: $isLate, isHalfDay: $isHalfDay, correctionApplied: $correctionApplied)';
}


}

/// @nodoc
abstract mixin class $AttendanceDayDetailCopyWith<$Res>  {
  factory $AttendanceDayDetailCopyWith(AttendanceDayDetail value, $Res Function(AttendanceDayDetail) _then) = _$AttendanceDayDetailCopyWithImpl;
@useResult
$Res call({
 String date,@JsonKey(name: 'day_of_week') String dayOfWeek,@JsonKey(name: 'is_working_day') bool isWorkingDay,@JsonKey(name: 'is_holiday') bool isHoliday,@JsonKey(name: 'holiday_name') String? holidayName,@JsonKey(name: 'status_name') String? statusName,@JsonKey(name: 'status_code') String? statusCode,@JsonKey(name: 'badge_color') String? badgeColor,@JsonKey(name: 'first_check_in') String? firstCheckIn,@JsonKey(name: 'last_check_out') String? lastCheckOut,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'overtime_hours') double overtimeHours,@JsonKey(name: 'is_late') bool isLate,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'correction_applied') bool correctionApplied
});




}
/// @nodoc
class _$AttendanceDayDetailCopyWithImpl<$Res>
    implements $AttendanceDayDetailCopyWith<$Res> {
  _$AttendanceDayDetailCopyWithImpl(this._self, this._then);

  final AttendanceDayDetail _self;
  final $Res Function(AttendanceDayDetail) _then;

/// Create a copy of AttendanceDayDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? dayOfWeek = null,Object? isWorkingDay = null,Object? isHoliday = null,Object? holidayName = freezed,Object? statusName = freezed,Object? statusCode = freezed,Object? badgeColor = freezed,Object? firstCheckIn = freezed,Object? lastCheckOut = freezed,Object? totalHoursWorked = null,Object? overtimeHours = null,Object? isLate = null,Object? isHalfDay = null,Object? correctionApplied = null,}) {
  return _then(AttendanceDayDetail(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,isWorkingDay: null == isWorkingDay ? _self.isWorkingDay : isWorkingDay // ignore: cast_nullable_to_non_nullable
as bool,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,holidayName: freezed == holidayName ? _self.holidayName : holidayName // ignore: cast_nullable_to_non_nullable
as String?,statusName: freezed == statusName ? _self.statusName : statusName // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as String?,badgeColor: freezed == badgeColor ? _self.badgeColor : badgeColor // ignore: cast_nullable_to_non_nullable
as String?,firstCheckIn: freezed == firstCheckIn ? _self.firstCheckIn : firstCheckIn // ignore: cast_nullable_to_non_nullable
as String?,lastCheckOut: freezed == lastCheckOut ? _self.lastCheckOut : lastCheckOut // ignore: cast_nullable_to_non_nullable
as String?,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,overtimeHours: null == overtimeHours ? _self.overtimeHours : overtimeHours // ignore: cast_nullable_to_non_nullable
as double,isLate: null == isLate ? _self.isLate : isLate // ignore: cast_nullable_to_non_nullable
as bool,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,correctionApplied: null == correctionApplied ? _self.correctionApplied : correctionApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceDayDetail].
extension AttendanceDayDetailPatterns on AttendanceDayDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceDayDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceDayDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceDayDetail value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceDayDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceDayDetail value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceDayDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date, @JsonKey(name: 'day_of_week')  String dayOfWeek, @JsonKey(name: 'is_working_day')  bool isWorkingDay, @JsonKey(name: 'is_holiday')  bool isHoliday, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'status_name')  String? statusName, @JsonKey(name: 'status_code')  String? statusCode, @JsonKey(name: 'badge_color')  String? badgeColor, @JsonKey(name: 'first_check_in')  String? firstCheckIn, @JsonKey(name: 'last_check_out')  String? lastCheckOut, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'overtime_hours')  double overtimeHours, @JsonKey(name: 'is_late')  bool isLate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'correction_applied')  bool correctionApplied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceDayDetail() when $default != null:
return $default(_that.date,_that.dayOfWeek,_that.isWorkingDay,_that.isHoliday,_that.holidayName,_that.statusName,_that.statusCode,_that.badgeColor,_that.firstCheckIn,_that.lastCheckOut,_that.totalHoursWorked,_that.overtimeHours,_that.isLate,_that.isHalfDay,_that.correctionApplied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date, @JsonKey(name: 'day_of_week')  String dayOfWeek, @JsonKey(name: 'is_working_day')  bool isWorkingDay, @JsonKey(name: 'is_holiday')  bool isHoliday, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'status_name')  String? statusName, @JsonKey(name: 'status_code')  String? statusCode, @JsonKey(name: 'badge_color')  String? badgeColor, @JsonKey(name: 'first_check_in')  String? firstCheckIn, @JsonKey(name: 'last_check_out')  String? lastCheckOut, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'overtime_hours')  double overtimeHours, @JsonKey(name: 'is_late')  bool isLate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'correction_applied')  bool correctionApplied)  $default,) {final _that = this;
switch (_that) {
case _AttendanceDayDetail():
return $default(_that.date,_that.dayOfWeek,_that.isWorkingDay,_that.isHoliday,_that.holidayName,_that.statusName,_that.statusCode,_that.badgeColor,_that.firstCheckIn,_that.lastCheckOut,_that.totalHoursWorked,_that.overtimeHours,_that.isLate,_that.isHalfDay,_that.correctionApplied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date, @JsonKey(name: 'day_of_week')  String dayOfWeek, @JsonKey(name: 'is_working_day')  bool isWorkingDay, @JsonKey(name: 'is_holiday')  bool isHoliday, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'status_name')  String? statusName, @JsonKey(name: 'status_code')  String? statusCode, @JsonKey(name: 'badge_color')  String? badgeColor, @JsonKey(name: 'first_check_in')  String? firstCheckIn, @JsonKey(name: 'last_check_out')  String? lastCheckOut, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'overtime_hours')  double overtimeHours, @JsonKey(name: 'is_late')  bool isLate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'correction_applied')  bool correctionApplied)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceDayDetail() when $default != null:
return $default(_that.date,_that.dayOfWeek,_that.isWorkingDay,_that.isHoliday,_that.holidayName,_that.statusName,_that.statusCode,_that.badgeColor,_that.firstCheckIn,_that.lastCheckOut,_that.totalHoursWorked,_that.overtimeHours,_that.isLate,_that.isHalfDay,_that.correctionApplied);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceDayDetail implements AttendanceDayDetail {
  const _AttendanceDayDetail({required this.date, @JsonKey(name: 'day_of_week') required this.dayOfWeek, @JsonKey(name: 'is_working_day') required this.isWorkingDay, @JsonKey(name: 'is_holiday') required this.isHoliday, @JsonKey(name: 'holiday_name') this.holidayName, @JsonKey(name: 'status_name') this.statusName, @JsonKey(name: 'status_code') this.statusCode, @JsonKey(name: 'badge_color') this.badgeColor, @JsonKey(name: 'first_check_in') this.firstCheckIn, @JsonKey(name: 'last_check_out') this.lastCheckOut, @JsonKey(name: 'total_hours_worked') this.totalHoursWorked = 0.0, @JsonKey(name: 'overtime_hours') this.overtimeHours = 0.0, @JsonKey(name: 'is_late') this.isLate = false, @JsonKey(name: 'is_half_day') this.isHalfDay = false, @JsonKey(name: 'correction_applied') this.correctionApplied = false});
  factory _AttendanceDayDetail.fromJson(Map<String, dynamic> json) => _$AttendanceDayDetailFromJson(json);

@override final  String date;
@override@JsonKey(name: 'day_of_week') final  String dayOfWeek;
@override@JsonKey(name: 'is_working_day') final  bool isWorkingDay;
@override@JsonKey(name: 'is_holiday') final  bool isHoliday;
@override@JsonKey(name: 'holiday_name') final  String? holidayName;
@override@JsonKey(name: 'status_name') final  String? statusName;
@override@JsonKey(name: 'status_code') final  String? statusCode;
@override@JsonKey(name: 'badge_color') final  String? badgeColor;
@override@JsonKey(name: 'first_check_in') final  String? firstCheckIn;
@override@JsonKey(name: 'last_check_out') final  String? lastCheckOut;
@override@JsonKey(name: 'total_hours_worked') final  double totalHoursWorked;
@override@JsonKey(name: 'overtime_hours') final  double overtimeHours;
@override@JsonKey(name: 'is_late') final  bool isLate;
@override@JsonKey(name: 'is_half_day') final  bool isHalfDay;
@override@JsonKey(name: 'correction_applied') final  bool correctionApplied;

/// Create a copy of AttendanceDayDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceDayDetailCopyWith<_AttendanceDayDetail> get copyWith => __$AttendanceDayDetailCopyWithImpl<_AttendanceDayDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceDayDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceDayDetail&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isWorkingDay, isWorkingDay) || other.isWorkingDay == isWorkingDay)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.holidayName, holidayName) || other.holidayName == holidayName)&&(identical(other.statusName, statusName) || other.statusName == statusName)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.badgeColor, badgeColor) || other.badgeColor == badgeColor)&&(identical(other.firstCheckIn, firstCheckIn) || other.firstCheckIn == firstCheckIn)&&(identical(other.lastCheckOut, lastCheckOut) || other.lastCheckOut == lastCheckOut)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.overtimeHours, overtimeHours) || other.overtimeHours == overtimeHours)&&(identical(other.isLate, isLate) || other.isLate == isLate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.correctionApplied, correctionApplied) || other.correctionApplied == correctionApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dayOfWeek,isWorkingDay,isHoliday,holidayName,statusName,statusCode,badgeColor,firstCheckIn,lastCheckOut,totalHoursWorked,overtimeHours,isLate,isHalfDay,correctionApplied);

@override
String toString() {
  return 'AttendanceDayDetail(date: $date, dayOfWeek: $dayOfWeek, isWorkingDay: $isWorkingDay, isHoliday: $isHoliday, holidayName: $holidayName, statusName: $statusName, statusCode: $statusCode, badgeColor: $badgeColor, firstCheckIn: $firstCheckIn, lastCheckOut: $lastCheckOut, totalHoursWorked: $totalHoursWorked, overtimeHours: $overtimeHours, isLate: $isLate, isHalfDay: $isHalfDay, correctionApplied: $correctionApplied)';
}


}

/// @nodoc
abstract mixin class _$AttendanceDayDetailCopyWith<$Res> implements $AttendanceDayDetailCopyWith<$Res> {
  factory _$AttendanceDayDetailCopyWith(_AttendanceDayDetail value, $Res Function(_AttendanceDayDetail) _then) = __$AttendanceDayDetailCopyWithImpl;
@override @useResult
$Res call({
 String date,@JsonKey(name: 'day_of_week') String dayOfWeek,@JsonKey(name: 'is_working_day') bool isWorkingDay,@JsonKey(name: 'is_holiday') bool isHoliday,@JsonKey(name: 'holiday_name') String? holidayName,@JsonKey(name: 'status_name') String? statusName,@JsonKey(name: 'status_code') String? statusCode,@JsonKey(name: 'badge_color') String? badgeColor,@JsonKey(name: 'first_check_in') String? firstCheckIn,@JsonKey(name: 'last_check_out') String? lastCheckOut,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'overtime_hours') double overtimeHours,@JsonKey(name: 'is_late') bool isLate,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'correction_applied') bool correctionApplied
});




}
/// @nodoc
class __$AttendanceDayDetailCopyWithImpl<$Res>
    implements _$AttendanceDayDetailCopyWith<$Res> {
  __$AttendanceDayDetailCopyWithImpl(this._self, this._then);

  final _AttendanceDayDetail _self;
  final $Res Function(_AttendanceDayDetail) _then;

/// Create a copy of AttendanceDayDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dayOfWeek = null,Object? isWorkingDay = null,Object? isHoliday = null,Object? holidayName = freezed,Object? statusName = freezed,Object? statusCode = freezed,Object? badgeColor = freezed,Object? firstCheckIn = freezed,Object? lastCheckOut = freezed,Object? totalHoursWorked = null,Object? overtimeHours = null,Object? isLate = null,Object? isHalfDay = null,Object? correctionApplied = null,}) {
  return _then(_AttendanceDayDetail(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,isWorkingDay: null == isWorkingDay ? _self.isWorkingDay : isWorkingDay // ignore: cast_nullable_to_non_nullable
as bool,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,holidayName: freezed == holidayName ? _self.holidayName : holidayName // ignore: cast_nullable_to_non_nullable
as String?,statusName: freezed == statusName ? _self.statusName : statusName // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as String?,badgeColor: freezed == badgeColor ? _self.badgeColor : badgeColor // ignore: cast_nullable_to_non_nullable
as String?,firstCheckIn: freezed == firstCheckIn ? _self.firstCheckIn : firstCheckIn // ignore: cast_nullable_to_non_nullable
as String?,lastCheckOut: freezed == lastCheckOut ? _self.lastCheckOut : lastCheckOut // ignore: cast_nullable_to_non_nullable
as String?,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,overtimeHours: null == overtimeHours ? _self.overtimeHours : overtimeHours // ignore: cast_nullable_to_non_nullable
as double,isLate: null == isLate ? _self.isLate : isLate // ignore: cast_nullable_to_non_nullable
as bool,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,correctionApplied: null == correctionApplied ? _self.correctionApplied : correctionApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EmployeeMonthlyReportResponse {

@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'department_name') String? get departmentName; String? get designation; int get month; int get year;@JsonKey(name: 'total_days') int get totalDays;@JsonKey(name: 'working_days') int get workingDays;@JsonKey(name: 'present_days') int get presentDays;@JsonKey(name: 'absent_days') int get absentDays;@JsonKey(name: 'half_days') int get halfDays;@JsonKey(name: 'late_days') int get lateDays;@JsonKey(name: 'leave_days') int get leaveDays;@JsonKey(name: 'holiday_days') int get holidayDays;@JsonKey(name: 'week_off_days') int get weekOffDays;@JsonKey(name: 'total_hours_worked') double get totalHoursWorked;@JsonKey(name: 'average_hours_per_day') double get averageHoursPerDay;@JsonKey(name: 'attendance_percentage') double get attendancePercentage;@JsonKey(name: 'daily_records') List<AttendanceDayDetail> get dailyRecords;
/// Create a copy of EmployeeMonthlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeMonthlyReportResponseCopyWith<EmployeeMonthlyReportResponse> get copyWith => _$EmployeeMonthlyReportResponseCopyWithImpl<EmployeeMonthlyReportResponse>(this as EmployeeMonthlyReportResponse, _$identity);

  /// Serializes this EmployeeMonthlyReportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeMonthlyReportResponse&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.weekOffDays, weekOffDays) || other.weekOffDays == weekOffDays)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.averageHoursPerDay, averageHoursPerDay) || other.averageHoursPerDay == averageHoursPerDay)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&const DeepCollectionEquality().equals(other.dailyRecords, dailyRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,employeeId,employeeName,employeeCode,departmentName,designation,month,year,totalDays,workingDays,presentDays,absentDays,halfDays,lateDays,leaveDays,holidayDays,weekOffDays,totalHoursWorked,averageHoursPerDay,attendancePercentage,const DeepCollectionEquality().hash(dailyRecords)]);

@override
String toString() {
  return 'EmployeeMonthlyReportResponse(employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, departmentName: $departmentName, designation: $designation, month: $month, year: $year, totalDays: $totalDays, workingDays: $workingDays, presentDays: $presentDays, absentDays: $absentDays, halfDays: $halfDays, lateDays: $lateDays, leaveDays: $leaveDays, holidayDays: $holidayDays, weekOffDays: $weekOffDays, totalHoursWorked: $totalHoursWorked, averageHoursPerDay: $averageHoursPerDay, attendancePercentage: $attendancePercentage, dailyRecords: $dailyRecords)';
}


}

/// @nodoc
abstract mixin class $EmployeeMonthlyReportResponseCopyWith<$Res>  {
  factory $EmployeeMonthlyReportResponseCopyWith(EmployeeMonthlyReportResponse value, $Res Function(EmployeeMonthlyReportResponse) _then) = _$EmployeeMonthlyReportResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'department_name') String? departmentName, String? designation, int month, int year,@JsonKey(name: 'total_days') int totalDays,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'week_off_days') int weekOffDays,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'average_hours_per_day') double averageHoursPerDay,@JsonKey(name: 'attendance_percentage') double attendancePercentage,@JsonKey(name: 'daily_records') List<AttendanceDayDetail> dailyRecords
});




}
/// @nodoc
class _$EmployeeMonthlyReportResponseCopyWithImpl<$Res>
    implements $EmployeeMonthlyReportResponseCopyWith<$Res> {
  _$EmployeeMonthlyReportResponseCopyWithImpl(this._self, this._then);

  final EmployeeMonthlyReportResponse _self;
  final $Res Function(EmployeeMonthlyReportResponse) _then;

/// Create a copy of EmployeeMonthlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? employeeName = null,Object? employeeCode = null,Object? departmentName = freezed,Object? designation = freezed,Object? month = null,Object? year = null,Object? totalDays = null,Object? workingDays = null,Object? presentDays = null,Object? absentDays = null,Object? halfDays = null,Object? lateDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? weekOffDays = null,Object? totalHoursWorked = null,Object? averageHoursPerDay = null,Object? attendancePercentage = null,Object? dailyRecords = null,}) {
  return _then(EmployeeMonthlyReportResponse(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,weekOffDays: null == weekOffDays ? _self.weekOffDays : weekOffDays // ignore: cast_nullable_to_non_nullable
as int,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,averageHoursPerDay: null == averageHoursPerDay ? _self.averageHoursPerDay : averageHoursPerDay // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,dailyRecords: null == dailyRecords ? _self.dailyRecords : dailyRecords // ignore: cast_nullable_to_non_nullable
as List<AttendanceDayDetail>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeMonthlyReportResponse].
extension EmployeeMonthlyReportResponsePatterns on EmployeeMonthlyReportResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeMonthlyReportResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeMonthlyReportResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeMonthlyReportResponse value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeMonthlyReportResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeMonthlyReportResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeMonthlyReportResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  String? designation,  int month,  int year, @JsonKey(name: 'total_days')  int totalDays, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'week_off_days')  int weekOffDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'average_hours_per_day')  double averageHoursPerDay, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'daily_records')  List<AttendanceDayDetail> dailyRecords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeMonthlyReportResponse() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.designation,_that.month,_that.year,_that.totalDays,_that.workingDays,_that.presentDays,_that.absentDays,_that.halfDays,_that.lateDays,_that.leaveDays,_that.holidayDays,_that.weekOffDays,_that.totalHoursWorked,_that.averageHoursPerDay,_that.attendancePercentage,_that.dailyRecords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  String? designation,  int month,  int year, @JsonKey(name: 'total_days')  int totalDays, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'week_off_days')  int weekOffDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'average_hours_per_day')  double averageHoursPerDay, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'daily_records')  List<AttendanceDayDetail> dailyRecords)  $default,) {final _that = this;
switch (_that) {
case _EmployeeMonthlyReportResponse():
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.designation,_that.month,_that.year,_that.totalDays,_that.workingDays,_that.presentDays,_that.absentDays,_that.halfDays,_that.lateDays,_that.leaveDays,_that.holidayDays,_that.weekOffDays,_that.totalHoursWorked,_that.averageHoursPerDay,_that.attendancePercentage,_that.dailyRecords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  String? designation,  int month,  int year, @JsonKey(name: 'total_days')  int totalDays, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'week_off_days')  int weekOffDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'average_hours_per_day')  double averageHoursPerDay, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'daily_records')  List<AttendanceDayDetail> dailyRecords)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeMonthlyReportResponse() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.designation,_that.month,_that.year,_that.totalDays,_that.workingDays,_that.presentDays,_that.absentDays,_that.halfDays,_that.lateDays,_that.leaveDays,_that.holidayDays,_that.weekOffDays,_that.totalHoursWorked,_that.averageHoursPerDay,_that.attendancePercentage,_that.dailyRecords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeMonthlyReportResponse implements EmployeeMonthlyReportResponse {
  const _EmployeeMonthlyReportResponse({@JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'department_name') this.departmentName, this.designation, required this.month, required this.year, @JsonKey(name: 'total_days') required this.totalDays, @JsonKey(name: 'working_days') required this.workingDays, @JsonKey(name: 'present_days') required this.presentDays, @JsonKey(name: 'absent_days') required this.absentDays, @JsonKey(name: 'half_days') required this.halfDays, @JsonKey(name: 'late_days') required this.lateDays, @JsonKey(name: 'leave_days') required this.leaveDays, @JsonKey(name: 'holiday_days') required this.holidayDays, @JsonKey(name: 'week_off_days') required this.weekOffDays, @JsonKey(name: 'total_hours_worked') required this.totalHoursWorked, @JsonKey(name: 'average_hours_per_day') required this.averageHoursPerDay, @JsonKey(name: 'attendance_percentage') required this.attendancePercentage, @JsonKey(name: 'daily_records')  List<AttendanceDayDetail> dailyRecords = const <AttendanceDayDetail>[]}): _dailyRecords = dailyRecords;
  factory _EmployeeMonthlyReportResponse.fromJson(Map<String, dynamic> json) => _$EmployeeMonthlyReportResponseFromJson(json);

@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override final  String? designation;
@override final  int month;
@override final  int year;
@override@JsonKey(name: 'total_days') final  int totalDays;
@override@JsonKey(name: 'working_days') final  int workingDays;
@override@JsonKey(name: 'present_days') final  int presentDays;
@override@JsonKey(name: 'absent_days') final  int absentDays;
@override@JsonKey(name: 'half_days') final  int halfDays;
@override@JsonKey(name: 'late_days') final  int lateDays;
@override@JsonKey(name: 'leave_days') final  int leaveDays;
@override@JsonKey(name: 'holiday_days') final  int holidayDays;
@override@JsonKey(name: 'week_off_days') final  int weekOffDays;
@override@JsonKey(name: 'total_hours_worked') final  double totalHoursWorked;
@override@JsonKey(name: 'average_hours_per_day') final  double averageHoursPerDay;
@override@JsonKey(name: 'attendance_percentage') final  double attendancePercentage;
 final  List<AttendanceDayDetail> _dailyRecords;
@override@JsonKey(name: 'daily_records') List<AttendanceDayDetail> get dailyRecords {
  if (_dailyRecords is EqualUnmodifiableListView) return _dailyRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyRecords);
}


/// Create a copy of EmployeeMonthlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeMonthlyReportResponseCopyWith<_EmployeeMonthlyReportResponse> get copyWith => __$EmployeeMonthlyReportResponseCopyWithImpl<_EmployeeMonthlyReportResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeMonthlyReportResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeMonthlyReportResponse&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.weekOffDays, weekOffDays) || other.weekOffDays == weekOffDays)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.averageHoursPerDay, averageHoursPerDay) || other.averageHoursPerDay == averageHoursPerDay)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&const DeepCollectionEquality().equals(other._dailyRecords, _dailyRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,employeeId,employeeName,employeeCode,departmentName,designation,month,year,totalDays,workingDays,presentDays,absentDays,halfDays,lateDays,leaveDays,holidayDays,weekOffDays,totalHoursWorked,averageHoursPerDay,attendancePercentage,const DeepCollectionEquality().hash(_dailyRecords)]);

@override
String toString() {
  return 'EmployeeMonthlyReportResponse(employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, departmentName: $departmentName, designation: $designation, month: $month, year: $year, totalDays: $totalDays, workingDays: $workingDays, presentDays: $presentDays, absentDays: $absentDays, halfDays: $halfDays, lateDays: $lateDays, leaveDays: $leaveDays, holidayDays: $holidayDays, weekOffDays: $weekOffDays, totalHoursWorked: $totalHoursWorked, averageHoursPerDay: $averageHoursPerDay, attendancePercentage: $attendancePercentage, dailyRecords: $dailyRecords)';
}


}

/// @nodoc
abstract mixin class _$EmployeeMonthlyReportResponseCopyWith<$Res> implements $EmployeeMonthlyReportResponseCopyWith<$Res> {
  factory _$EmployeeMonthlyReportResponseCopyWith(_EmployeeMonthlyReportResponse value, $Res Function(_EmployeeMonthlyReportResponse) _then) = __$EmployeeMonthlyReportResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'department_name') String? departmentName, String? designation, int month, int year,@JsonKey(name: 'total_days') int totalDays,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'week_off_days') int weekOffDays,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'average_hours_per_day') double averageHoursPerDay,@JsonKey(name: 'attendance_percentage') double attendancePercentage,@JsonKey(name: 'daily_records') List<AttendanceDayDetail> dailyRecords
});




}
/// @nodoc
class __$EmployeeMonthlyReportResponseCopyWithImpl<$Res>
    implements _$EmployeeMonthlyReportResponseCopyWith<$Res> {
  __$EmployeeMonthlyReportResponseCopyWithImpl(this._self, this._then);

  final _EmployeeMonthlyReportResponse _self;
  final $Res Function(_EmployeeMonthlyReportResponse) _then;

/// Create a copy of EmployeeMonthlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeName = null,Object? employeeCode = null,Object? departmentName = freezed,Object? designation = freezed,Object? month = null,Object? year = null,Object? totalDays = null,Object? workingDays = null,Object? presentDays = null,Object? absentDays = null,Object? halfDays = null,Object? lateDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? weekOffDays = null,Object? totalHoursWorked = null,Object? averageHoursPerDay = null,Object? attendancePercentage = null,Object? dailyRecords = null,}) {
  return _then(_EmployeeMonthlyReportResponse(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,weekOffDays: null == weekOffDays ? _self.weekOffDays : weekOffDays // ignore: cast_nullable_to_non_nullable
as int,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,averageHoursPerDay: null == averageHoursPerDay ? _self.averageHoursPerDay : averageHoursPerDay // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,dailyRecords: null == dailyRecords ? _self._dailyRecords : dailyRecords // ignore: cast_nullable_to_non_nullable
as List<AttendanceDayDetail>,
  ));
}


}


/// @nodoc
mixin _$MonthSummaryItem {

 int get month;@JsonKey(name: 'month_name') String get monthName;@JsonKey(name: 'working_days') int get workingDays;@JsonKey(name: 'present_days') int get presentDays;@JsonKey(name: 'absent_days') int get absentDays;@JsonKey(name: 'half_days') int get halfDays;@JsonKey(name: 'late_days') int get lateDays;@JsonKey(name: 'leave_days') int get leaveDays;@JsonKey(name: 'holiday_days') int get holidayDays;@JsonKey(name: 'attendance_percentage') double get attendancePercentage;@JsonKey(name: 'total_hours_worked') double get totalHoursWorked;
/// Create a copy of MonthSummaryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthSummaryItemCopyWith<MonthSummaryItem> get copyWith => _$MonthSummaryItemCopyWithImpl<MonthSummaryItem>(this as MonthSummaryItem, _$identity);

  /// Serializes this MonthSummaryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummaryItem&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,monthName,workingDays,presentDays,absentDays,halfDays,lateDays,leaveDays,holidayDays,attendancePercentage,totalHoursWorked);

@override
String toString() {
  return 'MonthSummaryItem(month: $month, monthName: $monthName, workingDays: $workingDays, presentDays: $presentDays, absentDays: $absentDays, halfDays: $halfDays, lateDays: $lateDays, leaveDays: $leaveDays, holidayDays: $holidayDays, attendancePercentage: $attendancePercentage, totalHoursWorked: $totalHoursWorked)';
}


}

/// @nodoc
abstract mixin class $MonthSummaryItemCopyWith<$Res>  {
  factory $MonthSummaryItemCopyWith(MonthSummaryItem value, $Res Function(MonthSummaryItem) _then) = _$MonthSummaryItemCopyWithImpl;
@useResult
$Res call({
 int month,@JsonKey(name: 'month_name') String monthName,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'attendance_percentage') double attendancePercentage,@JsonKey(name: 'total_hours_worked') double totalHoursWorked
});




}
/// @nodoc
class _$MonthSummaryItemCopyWithImpl<$Res>
    implements $MonthSummaryItemCopyWith<$Res> {
  _$MonthSummaryItemCopyWithImpl(this._self, this._then);

  final MonthSummaryItem _self;
  final $Res Function(MonthSummaryItem) _then;

/// Create a copy of MonthSummaryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? monthName = null,Object? workingDays = null,Object? presentDays = null,Object? absentDays = null,Object? halfDays = null,Object? lateDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? attendancePercentage = null,Object? totalHoursWorked = null,}) {
  return _then(MonthSummaryItem(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,monthName: null == monthName ? _self.monthName : monthName // ignore: cast_nullable_to_non_nullable
as String,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthSummaryItem].
extension MonthSummaryItemPatterns on MonthSummaryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthSummaryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthSummaryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthSummaryItem value)  $default,){
final _that = this;
switch (_that) {
case _MonthSummaryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthSummaryItem value)?  $default,){
final _that = this;
switch (_that) {
case _MonthSummaryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int month, @JsonKey(name: 'month_name')  String monthName, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthSummaryItem() when $default != null:
return $default(_that.month,_that.monthName,_that.workingDays,_that.presentDays,_that.absentDays,_that.halfDays,_that.lateDays,_that.leaveDays,_that.holidayDays,_that.attendancePercentage,_that.totalHoursWorked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int month, @JsonKey(name: 'month_name')  String monthName, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked)  $default,) {final _that = this;
switch (_that) {
case _MonthSummaryItem():
return $default(_that.month,_that.monthName,_that.workingDays,_that.presentDays,_that.absentDays,_that.halfDays,_that.lateDays,_that.leaveDays,_that.holidayDays,_that.attendancePercentage,_that.totalHoursWorked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int month, @JsonKey(name: 'month_name')  String monthName, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked)?  $default,) {final _that = this;
switch (_that) {
case _MonthSummaryItem() when $default != null:
return $default(_that.month,_that.monthName,_that.workingDays,_that.presentDays,_that.absentDays,_that.halfDays,_that.lateDays,_that.leaveDays,_that.holidayDays,_that.attendancePercentage,_that.totalHoursWorked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthSummaryItem implements MonthSummaryItem {
  const _MonthSummaryItem({required this.month, @JsonKey(name: 'month_name') required this.monthName, @JsonKey(name: 'working_days') required this.workingDays, @JsonKey(name: 'present_days') required this.presentDays, @JsonKey(name: 'absent_days') required this.absentDays, @JsonKey(name: 'half_days') required this.halfDays, @JsonKey(name: 'late_days') required this.lateDays, @JsonKey(name: 'leave_days') required this.leaveDays, @JsonKey(name: 'holiday_days') required this.holidayDays, @JsonKey(name: 'attendance_percentage') required this.attendancePercentage, @JsonKey(name: 'total_hours_worked') required this.totalHoursWorked});
  factory _MonthSummaryItem.fromJson(Map<String, dynamic> json) => _$MonthSummaryItemFromJson(json);

@override final  int month;
@override@JsonKey(name: 'month_name') final  String monthName;
@override@JsonKey(name: 'working_days') final  int workingDays;
@override@JsonKey(name: 'present_days') final  int presentDays;
@override@JsonKey(name: 'absent_days') final  int absentDays;
@override@JsonKey(name: 'half_days') final  int halfDays;
@override@JsonKey(name: 'late_days') final  int lateDays;
@override@JsonKey(name: 'leave_days') final  int leaveDays;
@override@JsonKey(name: 'holiday_days') final  int holidayDays;
@override@JsonKey(name: 'attendance_percentage') final  double attendancePercentage;
@override@JsonKey(name: 'total_hours_worked') final  double totalHoursWorked;

/// Create a copy of MonthSummaryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthSummaryItemCopyWith<_MonthSummaryItem> get copyWith => __$MonthSummaryItemCopyWithImpl<_MonthSummaryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthSummaryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthSummaryItem&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,monthName,workingDays,presentDays,absentDays,halfDays,lateDays,leaveDays,holidayDays,attendancePercentage,totalHoursWorked);

@override
String toString() {
  return 'MonthSummaryItem(month: $month, monthName: $monthName, workingDays: $workingDays, presentDays: $presentDays, absentDays: $absentDays, halfDays: $halfDays, lateDays: $lateDays, leaveDays: $leaveDays, holidayDays: $holidayDays, attendancePercentage: $attendancePercentage, totalHoursWorked: $totalHoursWorked)';
}


}

/// @nodoc
abstract mixin class _$MonthSummaryItemCopyWith<$Res> implements $MonthSummaryItemCopyWith<$Res> {
  factory _$MonthSummaryItemCopyWith(_MonthSummaryItem value, $Res Function(_MonthSummaryItem) _then) = __$MonthSummaryItemCopyWithImpl;
@override @useResult
$Res call({
 int month,@JsonKey(name: 'month_name') String monthName,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'attendance_percentage') double attendancePercentage,@JsonKey(name: 'total_hours_worked') double totalHoursWorked
});




}
/// @nodoc
class __$MonthSummaryItemCopyWithImpl<$Res>
    implements _$MonthSummaryItemCopyWith<$Res> {
  __$MonthSummaryItemCopyWithImpl(this._self, this._then);

  final _MonthSummaryItem _self;
  final $Res Function(_MonthSummaryItem) _then;

/// Create a copy of MonthSummaryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? monthName = null,Object? workingDays = null,Object? presentDays = null,Object? absentDays = null,Object? halfDays = null,Object? lateDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? attendancePercentage = null,Object? totalHoursWorked = null,}) {
  return _then(_MonthSummaryItem(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,monthName: null == monthName ? _self.monthName : monthName // ignore: cast_nullable_to_non_nullable
as String,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EmployeeYearlyReportResponse {

@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'department_name') String? get departmentName; int get year;@JsonKey(name: 'annual_working_days') int get annualWorkingDays;@JsonKey(name: 'annual_present_days') int get annualPresentDays;@JsonKey(name: 'annual_absent_days') int get annualAbsentDays;@JsonKey(name: 'annual_leave_days') int get annualLeaveDays;@JsonKey(name: 'annual_total_hours') double get annualTotalHours;@JsonKey(name: 'annual_attendance_percentage') double get annualAttendancePercentage; List<MonthSummaryItem> get months;
/// Create a copy of EmployeeYearlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeYearlyReportResponseCopyWith<EmployeeYearlyReportResponse> get copyWith => _$EmployeeYearlyReportResponseCopyWithImpl<EmployeeYearlyReportResponse>(this as EmployeeYearlyReportResponse, _$identity);

  /// Serializes this EmployeeYearlyReportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeYearlyReportResponse&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.year, year) || other.year == year)&&(identical(other.annualWorkingDays, annualWorkingDays) || other.annualWorkingDays == annualWorkingDays)&&(identical(other.annualPresentDays, annualPresentDays) || other.annualPresentDays == annualPresentDays)&&(identical(other.annualAbsentDays, annualAbsentDays) || other.annualAbsentDays == annualAbsentDays)&&(identical(other.annualLeaveDays, annualLeaveDays) || other.annualLeaveDays == annualLeaveDays)&&(identical(other.annualTotalHours, annualTotalHours) || other.annualTotalHours == annualTotalHours)&&(identical(other.annualAttendancePercentage, annualAttendancePercentage) || other.annualAttendancePercentage == annualAttendancePercentage)&&const DeepCollectionEquality().equals(other.months, months));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,employeeCode,departmentName,year,annualWorkingDays,annualPresentDays,annualAbsentDays,annualLeaveDays,annualTotalHours,annualAttendancePercentage,const DeepCollectionEquality().hash(months));

@override
String toString() {
  return 'EmployeeYearlyReportResponse(employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, departmentName: $departmentName, year: $year, annualWorkingDays: $annualWorkingDays, annualPresentDays: $annualPresentDays, annualAbsentDays: $annualAbsentDays, annualLeaveDays: $annualLeaveDays, annualTotalHours: $annualTotalHours, annualAttendancePercentage: $annualAttendancePercentage, months: $months)';
}


}

/// @nodoc
abstract mixin class $EmployeeYearlyReportResponseCopyWith<$Res>  {
  factory $EmployeeYearlyReportResponseCopyWith(EmployeeYearlyReportResponse value, $Res Function(EmployeeYearlyReportResponse) _then) = _$EmployeeYearlyReportResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'department_name') String? departmentName, int year,@JsonKey(name: 'annual_working_days') int annualWorkingDays,@JsonKey(name: 'annual_present_days') int annualPresentDays,@JsonKey(name: 'annual_absent_days') int annualAbsentDays,@JsonKey(name: 'annual_leave_days') int annualLeaveDays,@JsonKey(name: 'annual_total_hours') double annualTotalHours,@JsonKey(name: 'annual_attendance_percentage') double annualAttendancePercentage, List<MonthSummaryItem> months
});




}
/// @nodoc
class _$EmployeeYearlyReportResponseCopyWithImpl<$Res>
    implements $EmployeeYearlyReportResponseCopyWith<$Res> {
  _$EmployeeYearlyReportResponseCopyWithImpl(this._self, this._then);

  final EmployeeYearlyReportResponse _self;
  final $Res Function(EmployeeYearlyReportResponse) _then;

/// Create a copy of EmployeeYearlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? employeeName = null,Object? employeeCode = null,Object? departmentName = freezed,Object? year = null,Object? annualWorkingDays = null,Object? annualPresentDays = null,Object? annualAbsentDays = null,Object? annualLeaveDays = null,Object? annualTotalHours = null,Object? annualAttendancePercentage = null,Object? months = null,}) {
  return _then(EmployeeYearlyReportResponse(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,annualWorkingDays: null == annualWorkingDays ? _self.annualWorkingDays : annualWorkingDays // ignore: cast_nullable_to_non_nullable
as int,annualPresentDays: null == annualPresentDays ? _self.annualPresentDays : annualPresentDays // ignore: cast_nullable_to_non_nullable
as int,annualAbsentDays: null == annualAbsentDays ? _self.annualAbsentDays : annualAbsentDays // ignore: cast_nullable_to_non_nullable
as int,annualLeaveDays: null == annualLeaveDays ? _self.annualLeaveDays : annualLeaveDays // ignore: cast_nullable_to_non_nullable
as int,annualTotalHours: null == annualTotalHours ? _self.annualTotalHours : annualTotalHours // ignore: cast_nullable_to_non_nullable
as double,annualAttendancePercentage: null == annualAttendancePercentage ? _self.annualAttendancePercentage : annualAttendancePercentage // ignore: cast_nullable_to_non_nullable
as double,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as List<MonthSummaryItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeYearlyReportResponse].
extension EmployeeYearlyReportResponsePatterns on EmployeeYearlyReportResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeYearlyReportResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeYearlyReportResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeYearlyReportResponse value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeYearlyReportResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeYearlyReportResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeYearlyReportResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  int year, @JsonKey(name: 'annual_working_days')  int annualWorkingDays, @JsonKey(name: 'annual_present_days')  int annualPresentDays, @JsonKey(name: 'annual_absent_days')  int annualAbsentDays, @JsonKey(name: 'annual_leave_days')  int annualLeaveDays, @JsonKey(name: 'annual_total_hours')  double annualTotalHours, @JsonKey(name: 'annual_attendance_percentage')  double annualAttendancePercentage,  List<MonthSummaryItem> months)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeYearlyReportResponse() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.year,_that.annualWorkingDays,_that.annualPresentDays,_that.annualAbsentDays,_that.annualLeaveDays,_that.annualTotalHours,_that.annualAttendancePercentage,_that.months);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  int year, @JsonKey(name: 'annual_working_days')  int annualWorkingDays, @JsonKey(name: 'annual_present_days')  int annualPresentDays, @JsonKey(name: 'annual_absent_days')  int annualAbsentDays, @JsonKey(name: 'annual_leave_days')  int annualLeaveDays, @JsonKey(name: 'annual_total_hours')  double annualTotalHours, @JsonKey(name: 'annual_attendance_percentage')  double annualAttendancePercentage,  List<MonthSummaryItem> months)  $default,) {final _that = this;
switch (_that) {
case _EmployeeYearlyReportResponse():
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.year,_that.annualWorkingDays,_that.annualPresentDays,_that.annualAbsentDays,_that.annualLeaveDays,_that.annualTotalHours,_that.annualAttendancePercentage,_that.months);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  int year, @JsonKey(name: 'annual_working_days')  int annualWorkingDays, @JsonKey(name: 'annual_present_days')  int annualPresentDays, @JsonKey(name: 'annual_absent_days')  int annualAbsentDays, @JsonKey(name: 'annual_leave_days')  int annualLeaveDays, @JsonKey(name: 'annual_total_hours')  double annualTotalHours, @JsonKey(name: 'annual_attendance_percentage')  double annualAttendancePercentage,  List<MonthSummaryItem> months)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeYearlyReportResponse() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.year,_that.annualWorkingDays,_that.annualPresentDays,_that.annualAbsentDays,_that.annualLeaveDays,_that.annualTotalHours,_that.annualAttendancePercentage,_that.months);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeYearlyReportResponse implements EmployeeYearlyReportResponse {
  const _EmployeeYearlyReportResponse({@JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'department_name') this.departmentName, required this.year, @JsonKey(name: 'annual_working_days') required this.annualWorkingDays, @JsonKey(name: 'annual_present_days') required this.annualPresentDays, @JsonKey(name: 'annual_absent_days') required this.annualAbsentDays, @JsonKey(name: 'annual_leave_days') required this.annualLeaveDays, @JsonKey(name: 'annual_total_hours') required this.annualTotalHours, @JsonKey(name: 'annual_attendance_percentage') required this.annualAttendancePercentage,  List<MonthSummaryItem> months = const <MonthSummaryItem>[]}): _months = months;
  factory _EmployeeYearlyReportResponse.fromJson(Map<String, dynamic> json) => _$EmployeeYearlyReportResponseFromJson(json);

@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override final  int year;
@override@JsonKey(name: 'annual_working_days') final  int annualWorkingDays;
@override@JsonKey(name: 'annual_present_days') final  int annualPresentDays;
@override@JsonKey(name: 'annual_absent_days') final  int annualAbsentDays;
@override@JsonKey(name: 'annual_leave_days') final  int annualLeaveDays;
@override@JsonKey(name: 'annual_total_hours') final  double annualTotalHours;
@override@JsonKey(name: 'annual_attendance_percentage') final  double annualAttendancePercentage;
 final  List<MonthSummaryItem> _months;
@override@JsonKey() List<MonthSummaryItem> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}


/// Create a copy of EmployeeYearlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeYearlyReportResponseCopyWith<_EmployeeYearlyReportResponse> get copyWith => __$EmployeeYearlyReportResponseCopyWithImpl<_EmployeeYearlyReportResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeYearlyReportResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeYearlyReportResponse&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.year, year) || other.year == year)&&(identical(other.annualWorkingDays, annualWorkingDays) || other.annualWorkingDays == annualWorkingDays)&&(identical(other.annualPresentDays, annualPresentDays) || other.annualPresentDays == annualPresentDays)&&(identical(other.annualAbsentDays, annualAbsentDays) || other.annualAbsentDays == annualAbsentDays)&&(identical(other.annualLeaveDays, annualLeaveDays) || other.annualLeaveDays == annualLeaveDays)&&(identical(other.annualTotalHours, annualTotalHours) || other.annualTotalHours == annualTotalHours)&&(identical(other.annualAttendancePercentage, annualAttendancePercentage) || other.annualAttendancePercentage == annualAttendancePercentage)&&const DeepCollectionEquality().equals(other._months, _months));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,employeeCode,departmentName,year,annualWorkingDays,annualPresentDays,annualAbsentDays,annualLeaveDays,annualTotalHours,annualAttendancePercentage,const DeepCollectionEquality().hash(_months));

@override
String toString() {
  return 'EmployeeYearlyReportResponse(employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, departmentName: $departmentName, year: $year, annualWorkingDays: $annualWorkingDays, annualPresentDays: $annualPresentDays, annualAbsentDays: $annualAbsentDays, annualLeaveDays: $annualLeaveDays, annualTotalHours: $annualTotalHours, annualAttendancePercentage: $annualAttendancePercentage, months: $months)';
}


}

/// @nodoc
abstract mixin class _$EmployeeYearlyReportResponseCopyWith<$Res> implements $EmployeeYearlyReportResponseCopyWith<$Res> {
  factory _$EmployeeYearlyReportResponseCopyWith(_EmployeeYearlyReportResponse value, $Res Function(_EmployeeYearlyReportResponse) _then) = __$EmployeeYearlyReportResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'department_name') String? departmentName, int year,@JsonKey(name: 'annual_working_days') int annualWorkingDays,@JsonKey(name: 'annual_present_days') int annualPresentDays,@JsonKey(name: 'annual_absent_days') int annualAbsentDays,@JsonKey(name: 'annual_leave_days') int annualLeaveDays,@JsonKey(name: 'annual_total_hours') double annualTotalHours,@JsonKey(name: 'annual_attendance_percentage') double annualAttendancePercentage, List<MonthSummaryItem> months
});




}
/// @nodoc
class __$EmployeeYearlyReportResponseCopyWithImpl<$Res>
    implements _$EmployeeYearlyReportResponseCopyWith<$Res> {
  __$EmployeeYearlyReportResponseCopyWithImpl(this._self, this._then);

  final _EmployeeYearlyReportResponse _self;
  final $Res Function(_EmployeeYearlyReportResponse) _then;

/// Create a copy of EmployeeYearlyReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeName = null,Object? employeeCode = null,Object? departmentName = freezed,Object? year = null,Object? annualWorkingDays = null,Object? annualPresentDays = null,Object? annualAbsentDays = null,Object? annualLeaveDays = null,Object? annualTotalHours = null,Object? annualAttendancePercentage = null,Object? months = null,}) {
  return _then(_EmployeeYearlyReportResponse(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,annualWorkingDays: null == annualWorkingDays ? _self.annualWorkingDays : annualWorkingDays // ignore: cast_nullable_to_non_nullable
as int,annualPresentDays: null == annualPresentDays ? _self.annualPresentDays : annualPresentDays // ignore: cast_nullable_to_non_nullable
as int,annualAbsentDays: null == annualAbsentDays ? _self.annualAbsentDays : annualAbsentDays // ignore: cast_nullable_to_non_nullable
as int,annualLeaveDays: null == annualLeaveDays ? _self.annualLeaveDays : annualLeaveDays // ignore: cast_nullable_to_non_nullable
as int,annualTotalHours: null == annualTotalHours ? _self.annualTotalHours : annualTotalHours // ignore: cast_nullable_to_non_nullable
as double,annualAttendancePercentage: null == annualAttendancePercentage ? _self.annualAttendancePercentage : annualAttendancePercentage // ignore: cast_nullable_to_non_nullable
as double,months: null == months ? _self._months : months // ignore: cast_nullable_to_non_nullable
as List<MonthSummaryItem>,
  ));
}


}


/// @nodoc
mixin _$MonthlyOverviewEmployeeRow {

@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'department_name') String? get departmentName; String? get designation; Map<String, String> get days;@JsonKey(name: 'present_count') int get presentCount;@JsonKey(name: 'absent_count') int get absentCount;@JsonKey(name: 'half_day_count') int get halfDayCount;@JsonKey(name: 'late_count') int get lateCount;@JsonKey(name: 'leave_count') int get leaveCount;@JsonKey(name: 'holiday_count') int get holidayCount;@JsonKey(name: 'week_off_count') int get weekOffCount;@JsonKey(name: 'total_hours') double get totalHours;@JsonKey(name: 'attendance_percentage') double get attendancePercentage;
/// Create a copy of MonthlyOverviewEmployeeRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyOverviewEmployeeRowCopyWith<MonthlyOverviewEmployeeRow> get copyWith => _$MonthlyOverviewEmployeeRowCopyWithImpl<MonthlyOverviewEmployeeRow>(this as MonthlyOverviewEmployeeRow, _$identity);

  /// Serializes this MonthlyOverviewEmployeeRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyOverviewEmployeeRow&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation)&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.presentCount, presentCount) || other.presentCount == presentCount)&&(identical(other.absentCount, absentCount) || other.absentCount == absentCount)&&(identical(other.halfDayCount, halfDayCount) || other.halfDayCount == halfDayCount)&&(identical(other.lateCount, lateCount) || other.lateCount == lateCount)&&(identical(other.leaveCount, leaveCount) || other.leaveCount == leaveCount)&&(identical(other.holidayCount, holidayCount) || other.holidayCount == holidayCount)&&(identical(other.weekOffCount, weekOffCount) || other.weekOffCount == weekOffCount)&&(identical(other.totalHours, totalHours) || other.totalHours == totalHours)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,employeeCode,departmentName,designation,const DeepCollectionEquality().hash(days),presentCount,absentCount,halfDayCount,lateCount,leaveCount,holidayCount,weekOffCount,totalHours,attendancePercentage);

@override
String toString() {
  return 'MonthlyOverviewEmployeeRow(employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, departmentName: $departmentName, designation: $designation, days: $days, presentCount: $presentCount, absentCount: $absentCount, halfDayCount: $halfDayCount, lateCount: $lateCount, leaveCount: $leaveCount, holidayCount: $holidayCount, weekOffCount: $weekOffCount, totalHours: $totalHours, attendancePercentage: $attendancePercentage)';
}


}

/// @nodoc
abstract mixin class $MonthlyOverviewEmployeeRowCopyWith<$Res>  {
  factory $MonthlyOverviewEmployeeRowCopyWith(MonthlyOverviewEmployeeRow value, $Res Function(MonthlyOverviewEmployeeRow) _then) = _$MonthlyOverviewEmployeeRowCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'department_name') String? departmentName, String? designation, Map<String, String> days,@JsonKey(name: 'present_count') int presentCount,@JsonKey(name: 'absent_count') int absentCount,@JsonKey(name: 'half_day_count') int halfDayCount,@JsonKey(name: 'late_count') int lateCount,@JsonKey(name: 'leave_count') int leaveCount,@JsonKey(name: 'holiday_count') int holidayCount,@JsonKey(name: 'week_off_count') int weekOffCount,@JsonKey(name: 'total_hours') double totalHours,@JsonKey(name: 'attendance_percentage') double attendancePercentage
});




}
/// @nodoc
class _$MonthlyOverviewEmployeeRowCopyWithImpl<$Res>
    implements $MonthlyOverviewEmployeeRowCopyWith<$Res> {
  _$MonthlyOverviewEmployeeRowCopyWithImpl(this._self, this._then);

  final MonthlyOverviewEmployeeRow _self;
  final $Res Function(MonthlyOverviewEmployeeRow) _then;

/// Create a copy of MonthlyOverviewEmployeeRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? employeeName = null,Object? employeeCode = null,Object? departmentName = freezed,Object? designation = freezed,Object? days = null,Object? presentCount = null,Object? absentCount = null,Object? halfDayCount = null,Object? lateCount = null,Object? leaveCount = null,Object? holidayCount = null,Object? weekOffCount = null,Object? totalHours = null,Object? attendancePercentage = null,}) {
  return _then(MonthlyOverviewEmployeeRow(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as Map<String, String>,presentCount: null == presentCount ? _self.presentCount : presentCount // ignore: cast_nullable_to_non_nullable
as int,absentCount: null == absentCount ? _self.absentCount : absentCount // ignore: cast_nullable_to_non_nullable
as int,halfDayCount: null == halfDayCount ? _self.halfDayCount : halfDayCount // ignore: cast_nullable_to_non_nullable
as int,lateCount: null == lateCount ? _self.lateCount : lateCount // ignore: cast_nullable_to_non_nullable
as int,leaveCount: null == leaveCount ? _self.leaveCount : leaveCount // ignore: cast_nullable_to_non_nullable
as int,holidayCount: null == holidayCount ? _self.holidayCount : holidayCount // ignore: cast_nullable_to_non_nullable
as int,weekOffCount: null == weekOffCount ? _self.weekOffCount : weekOffCount // ignore: cast_nullable_to_non_nullable
as int,totalHours: null == totalHours ? _self.totalHours : totalHours // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyOverviewEmployeeRow].
extension MonthlyOverviewEmployeeRowPatterns on MonthlyOverviewEmployeeRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyOverviewEmployeeRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyOverviewEmployeeRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyOverviewEmployeeRow value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyOverviewEmployeeRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyOverviewEmployeeRow value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyOverviewEmployeeRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  String? designation,  Map<String, String> days, @JsonKey(name: 'present_count')  int presentCount, @JsonKey(name: 'absent_count')  int absentCount, @JsonKey(name: 'half_day_count')  int halfDayCount, @JsonKey(name: 'late_count')  int lateCount, @JsonKey(name: 'leave_count')  int leaveCount, @JsonKey(name: 'holiday_count')  int holidayCount, @JsonKey(name: 'week_off_count')  int weekOffCount, @JsonKey(name: 'total_hours')  double totalHours, @JsonKey(name: 'attendance_percentage')  double attendancePercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyOverviewEmployeeRow() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.designation,_that.days,_that.presentCount,_that.absentCount,_that.halfDayCount,_that.lateCount,_that.leaveCount,_that.holidayCount,_that.weekOffCount,_that.totalHours,_that.attendancePercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  String? designation,  Map<String, String> days, @JsonKey(name: 'present_count')  int presentCount, @JsonKey(name: 'absent_count')  int absentCount, @JsonKey(name: 'half_day_count')  int halfDayCount, @JsonKey(name: 'late_count')  int lateCount, @JsonKey(name: 'leave_count')  int leaveCount, @JsonKey(name: 'holiday_count')  int holidayCount, @JsonKey(name: 'week_off_count')  int weekOffCount, @JsonKey(name: 'total_hours')  double totalHours, @JsonKey(name: 'attendance_percentage')  double attendancePercentage)  $default,) {final _that = this;
switch (_that) {
case _MonthlyOverviewEmployeeRow():
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.designation,_that.days,_that.presentCount,_that.absentCount,_that.halfDayCount,_that.lateCount,_that.leaveCount,_that.holidayCount,_that.weekOffCount,_that.totalHours,_that.attendancePercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'department_name')  String? departmentName,  String? designation,  Map<String, String> days, @JsonKey(name: 'present_count')  int presentCount, @JsonKey(name: 'absent_count')  int absentCount, @JsonKey(name: 'half_day_count')  int halfDayCount, @JsonKey(name: 'late_count')  int lateCount, @JsonKey(name: 'leave_count')  int leaveCount, @JsonKey(name: 'holiday_count')  int holidayCount, @JsonKey(name: 'week_off_count')  int weekOffCount, @JsonKey(name: 'total_hours')  double totalHours, @JsonKey(name: 'attendance_percentage')  double attendancePercentage)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyOverviewEmployeeRow() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.employeeCode,_that.departmentName,_that.designation,_that.days,_that.presentCount,_that.absentCount,_that.halfDayCount,_that.lateCount,_that.leaveCount,_that.holidayCount,_that.weekOffCount,_that.totalHours,_that.attendancePercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyOverviewEmployeeRow implements MonthlyOverviewEmployeeRow {
  const _MonthlyOverviewEmployeeRow({@JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'department_name') this.departmentName, this.designation,  Map<String, String> days = const <String, String>{}, @JsonKey(name: 'present_count') this.presentCount = 0, @JsonKey(name: 'absent_count') this.absentCount = 0, @JsonKey(name: 'half_day_count') this.halfDayCount = 0, @JsonKey(name: 'late_count') this.lateCount = 0, @JsonKey(name: 'leave_count') this.leaveCount = 0, @JsonKey(name: 'holiday_count') this.holidayCount = 0, @JsonKey(name: 'week_off_count') this.weekOffCount = 0, @JsonKey(name: 'total_hours') this.totalHours = 0.0, @JsonKey(name: 'attendance_percentage') this.attendancePercentage = 0.0}): _days = days;
  factory _MonthlyOverviewEmployeeRow.fromJson(Map<String, dynamic> json) => _$MonthlyOverviewEmployeeRowFromJson(json);

@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override final  String? designation;
 final  Map<String, String> _days;
@override@JsonKey() Map<String, String> get days {
  if (_days is EqualUnmodifiableMapView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_days);
}

@override@JsonKey(name: 'present_count') final  int presentCount;
@override@JsonKey(name: 'absent_count') final  int absentCount;
@override@JsonKey(name: 'half_day_count') final  int halfDayCount;
@override@JsonKey(name: 'late_count') final  int lateCount;
@override@JsonKey(name: 'leave_count') final  int leaveCount;
@override@JsonKey(name: 'holiday_count') final  int holidayCount;
@override@JsonKey(name: 'week_off_count') final  int weekOffCount;
@override@JsonKey(name: 'total_hours') final  double totalHours;
@override@JsonKey(name: 'attendance_percentage') final  double attendancePercentage;

/// Create a copy of MonthlyOverviewEmployeeRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyOverviewEmployeeRowCopyWith<_MonthlyOverviewEmployeeRow> get copyWith => __$MonthlyOverviewEmployeeRowCopyWithImpl<_MonthlyOverviewEmployeeRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyOverviewEmployeeRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyOverviewEmployeeRow&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation)&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.presentCount, presentCount) || other.presentCount == presentCount)&&(identical(other.absentCount, absentCount) || other.absentCount == absentCount)&&(identical(other.halfDayCount, halfDayCount) || other.halfDayCount == halfDayCount)&&(identical(other.lateCount, lateCount) || other.lateCount == lateCount)&&(identical(other.leaveCount, leaveCount) || other.leaveCount == leaveCount)&&(identical(other.holidayCount, holidayCount) || other.holidayCount == holidayCount)&&(identical(other.weekOffCount, weekOffCount) || other.weekOffCount == weekOffCount)&&(identical(other.totalHours, totalHours) || other.totalHours == totalHours)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,employeeCode,departmentName,designation,const DeepCollectionEquality().hash(_days),presentCount,absentCount,halfDayCount,lateCount,leaveCount,holidayCount,weekOffCount,totalHours,attendancePercentage);

@override
String toString() {
  return 'MonthlyOverviewEmployeeRow(employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, departmentName: $departmentName, designation: $designation, days: $days, presentCount: $presentCount, absentCount: $absentCount, halfDayCount: $halfDayCount, lateCount: $lateCount, leaveCount: $leaveCount, holidayCount: $holidayCount, weekOffCount: $weekOffCount, totalHours: $totalHours, attendancePercentage: $attendancePercentage)';
}


}

/// @nodoc
abstract mixin class _$MonthlyOverviewEmployeeRowCopyWith<$Res> implements $MonthlyOverviewEmployeeRowCopyWith<$Res> {
  factory _$MonthlyOverviewEmployeeRowCopyWith(_MonthlyOverviewEmployeeRow value, $Res Function(_MonthlyOverviewEmployeeRow) _then) = __$MonthlyOverviewEmployeeRowCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'department_name') String? departmentName, String? designation, Map<String, String> days,@JsonKey(name: 'present_count') int presentCount,@JsonKey(name: 'absent_count') int absentCount,@JsonKey(name: 'half_day_count') int halfDayCount,@JsonKey(name: 'late_count') int lateCount,@JsonKey(name: 'leave_count') int leaveCount,@JsonKey(name: 'holiday_count') int holidayCount,@JsonKey(name: 'week_off_count') int weekOffCount,@JsonKey(name: 'total_hours') double totalHours,@JsonKey(name: 'attendance_percentage') double attendancePercentage
});




}
/// @nodoc
class __$MonthlyOverviewEmployeeRowCopyWithImpl<$Res>
    implements _$MonthlyOverviewEmployeeRowCopyWith<$Res> {
  __$MonthlyOverviewEmployeeRowCopyWithImpl(this._self, this._then);

  final _MonthlyOverviewEmployeeRow _self;
  final $Res Function(_MonthlyOverviewEmployeeRow) _then;

/// Create a copy of MonthlyOverviewEmployeeRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeName = null,Object? employeeCode = null,Object? departmentName = freezed,Object? designation = freezed,Object? days = null,Object? presentCount = null,Object? absentCount = null,Object? halfDayCount = null,Object? lateCount = null,Object? leaveCount = null,Object? holidayCount = null,Object? weekOffCount = null,Object? totalHours = null,Object? attendancePercentage = null,}) {
  return _then(_MonthlyOverviewEmployeeRow(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as Map<String, String>,presentCount: null == presentCount ? _self.presentCount : presentCount // ignore: cast_nullable_to_non_nullable
as int,absentCount: null == absentCount ? _self.absentCount : absentCount // ignore: cast_nullable_to_non_nullable
as int,halfDayCount: null == halfDayCount ? _self.halfDayCount : halfDayCount // ignore: cast_nullable_to_non_nullable
as int,lateCount: null == lateCount ? _self.lateCount : lateCount // ignore: cast_nullable_to_non_nullable
as int,leaveCount: null == leaveCount ? _self.leaveCount : leaveCount // ignore: cast_nullable_to_non_nullable
as int,holidayCount: null == holidayCount ? _self.holidayCount : holidayCount // ignore: cast_nullable_to_non_nullable
as int,weekOffCount: null == weekOffCount ? _self.weekOffCount : weekOffCount // ignore: cast_nullable_to_non_nullable
as int,totalHours: null == totalHours ? _self.totalHours : totalHours // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MonthlyOverviewResponse {

 int get month; int get year;@JsonKey(name: 'total_employees') int get totalEmployees;@JsonKey(name: 'department_id') String? get departmentId; List<MonthlyOverviewEmployeeRow> get rows;
/// Create a copy of MonthlyOverviewResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyOverviewResponseCopyWith<MonthlyOverviewResponse> get copyWith => _$MonthlyOverviewResponseCopyWithImpl<MonthlyOverviewResponse>(this as MonthlyOverviewResponse, _$identity);

  /// Serializes this MonthlyOverviewResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyOverviewResponse&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.totalEmployees, totalEmployees) || other.totalEmployees == totalEmployees)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,year,totalEmployees,departmentId,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'MonthlyOverviewResponse(month: $month, year: $year, totalEmployees: $totalEmployees, departmentId: $departmentId, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $MonthlyOverviewResponseCopyWith<$Res>  {
  factory $MonthlyOverviewResponseCopyWith(MonthlyOverviewResponse value, $Res Function(MonthlyOverviewResponse) _then) = _$MonthlyOverviewResponseCopyWithImpl;
@useResult
$Res call({
 int month, int year,@JsonKey(name: 'total_employees') int totalEmployees,@JsonKey(name: 'department_id') String? departmentId, List<MonthlyOverviewEmployeeRow> rows
});




}
/// @nodoc
class _$MonthlyOverviewResponseCopyWithImpl<$Res>
    implements $MonthlyOverviewResponseCopyWith<$Res> {
  _$MonthlyOverviewResponseCopyWithImpl(this._self, this._then);

  final MonthlyOverviewResponse _self;
  final $Res Function(MonthlyOverviewResponse) _then;

/// Create a copy of MonthlyOverviewResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? year = null,Object? totalEmployees = null,Object? departmentId = freezed,Object? rows = null,}) {
  return _then(MonthlyOverviewResponse(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,totalEmployees: null == totalEmployees ? _self.totalEmployees : totalEmployees // ignore: cast_nullable_to_non_nullable
as int,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<MonthlyOverviewEmployeeRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyOverviewResponse].
extension MonthlyOverviewResponsePatterns on MonthlyOverviewResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyOverviewResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyOverviewResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyOverviewResponse value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyOverviewResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyOverviewResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyOverviewResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int month,  int year, @JsonKey(name: 'total_employees')  int totalEmployees, @JsonKey(name: 'department_id')  String? departmentId,  List<MonthlyOverviewEmployeeRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyOverviewResponse() when $default != null:
return $default(_that.month,_that.year,_that.totalEmployees,_that.departmentId,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int month,  int year, @JsonKey(name: 'total_employees')  int totalEmployees, @JsonKey(name: 'department_id')  String? departmentId,  List<MonthlyOverviewEmployeeRow> rows)  $default,) {final _that = this;
switch (_that) {
case _MonthlyOverviewResponse():
return $default(_that.month,_that.year,_that.totalEmployees,_that.departmentId,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int month,  int year, @JsonKey(name: 'total_employees')  int totalEmployees, @JsonKey(name: 'department_id')  String? departmentId,  List<MonthlyOverviewEmployeeRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyOverviewResponse() when $default != null:
return $default(_that.month,_that.year,_that.totalEmployees,_that.departmentId,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyOverviewResponse implements MonthlyOverviewResponse {
  const _MonthlyOverviewResponse({required this.month, required this.year, @JsonKey(name: 'total_employees') required this.totalEmployees, @JsonKey(name: 'department_id') this.departmentId,  List<MonthlyOverviewEmployeeRow> rows = const <MonthlyOverviewEmployeeRow>[]}): _rows = rows;
  factory _MonthlyOverviewResponse.fromJson(Map<String, dynamic> json) => _$MonthlyOverviewResponseFromJson(json);

@override final  int month;
@override final  int year;
@override@JsonKey(name: 'total_employees') final  int totalEmployees;
@override@JsonKey(name: 'department_id') final  String? departmentId;
 final  List<MonthlyOverviewEmployeeRow> _rows;
@override@JsonKey() List<MonthlyOverviewEmployeeRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of MonthlyOverviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyOverviewResponseCopyWith<_MonthlyOverviewResponse> get copyWith => __$MonthlyOverviewResponseCopyWithImpl<_MonthlyOverviewResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyOverviewResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyOverviewResponse&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.totalEmployees, totalEmployees) || other.totalEmployees == totalEmployees)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,year,totalEmployees,departmentId,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'MonthlyOverviewResponse(month: $month, year: $year, totalEmployees: $totalEmployees, departmentId: $departmentId, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$MonthlyOverviewResponseCopyWith<$Res> implements $MonthlyOverviewResponseCopyWith<$Res> {
  factory _$MonthlyOverviewResponseCopyWith(_MonthlyOverviewResponse value, $Res Function(_MonthlyOverviewResponse) _then) = __$MonthlyOverviewResponseCopyWithImpl;
@override @useResult
$Res call({
 int month, int year,@JsonKey(name: 'total_employees') int totalEmployees,@JsonKey(name: 'department_id') String? departmentId, List<MonthlyOverviewEmployeeRow> rows
});




}
/// @nodoc
class __$MonthlyOverviewResponseCopyWithImpl<$Res>
    implements _$MonthlyOverviewResponseCopyWith<$Res> {
  __$MonthlyOverviewResponseCopyWithImpl(this._self, this._then);

  final _MonthlyOverviewResponse _self;
  final $Res Function(_MonthlyOverviewResponse) _then;

/// Create a copy of MonthlyOverviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,Object? totalEmployees = null,Object? departmentId = freezed,Object? rows = null,}) {
  return _then(_MonthlyOverviewResponse(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,totalEmployees: null == totalEmployees ? _self.totalEmployees : totalEmployees // ignore: cast_nullable_to_non_nullable
as int,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<MonthlyOverviewEmployeeRow>,
  ));
}


}


/// @nodoc
mixin _$AttendanceCorrectionRequest {

 String get reason;@JsonKey(name: 'check_in_at') String? get checkInAt;@JsonKey(name: 'check_out_at') String? get checkOutAt;@JsonKey(name: 'status_id') String? get statusId; String? get remarks;
/// Create a copy of AttendanceCorrectionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCorrectionRequestCopyWith<AttendanceCorrectionRequest> get copyWith => _$AttendanceCorrectionRequestCopyWithImpl<AttendanceCorrectionRequest>(this as AttendanceCorrectionRequest, _$identity);

  /// Serializes this AttendanceCorrectionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCorrectionRequest&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.remarks, remarks) || other.remarks == remarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,checkInAt,checkOutAt,statusId,remarks);

@override
String toString() {
  return 'AttendanceCorrectionRequest(reason: $reason, checkInAt: $checkInAt, checkOutAt: $checkOutAt, statusId: $statusId, remarks: $remarks)';
}


}

/// @nodoc
abstract mixin class $AttendanceCorrectionRequestCopyWith<$Res>  {
  factory $AttendanceCorrectionRequestCopyWith(AttendanceCorrectionRequest value, $Res Function(AttendanceCorrectionRequest) _then) = _$AttendanceCorrectionRequestCopyWithImpl;
@useResult
$Res call({
 String reason,@JsonKey(name: 'check_in_at') String? checkInAt,@JsonKey(name: 'check_out_at') String? checkOutAt,@JsonKey(name: 'status_id') String? statusId, String? remarks
});




}
/// @nodoc
class _$AttendanceCorrectionRequestCopyWithImpl<$Res>
    implements $AttendanceCorrectionRequestCopyWith<$Res> {
  _$AttendanceCorrectionRequestCopyWithImpl(this._self, this._then);

  final AttendanceCorrectionRequest _self;
  final $Res Function(AttendanceCorrectionRequest) _then;

/// Create a copy of AttendanceCorrectionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? statusId = freezed,Object? remarks = freezed,}) {
  return _then(AttendanceCorrectionRequest(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as String?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as String?,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceCorrectionRequest].
extension AttendanceCorrectionRequestPatterns on AttendanceCorrectionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceCorrectionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceCorrectionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceCorrectionRequest value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceCorrectionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceCorrectionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceCorrectionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reason, @JsonKey(name: 'check_in_at')  String? checkInAt, @JsonKey(name: 'check_out_at')  String? checkOutAt, @JsonKey(name: 'status_id')  String? statusId,  String? remarks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceCorrectionRequest() when $default != null:
return $default(_that.reason,_that.checkInAt,_that.checkOutAt,_that.statusId,_that.remarks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reason, @JsonKey(name: 'check_in_at')  String? checkInAt, @JsonKey(name: 'check_out_at')  String? checkOutAt, @JsonKey(name: 'status_id')  String? statusId,  String? remarks)  $default,) {final _that = this;
switch (_that) {
case _AttendanceCorrectionRequest():
return $default(_that.reason,_that.checkInAt,_that.checkOutAt,_that.statusId,_that.remarks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reason, @JsonKey(name: 'check_in_at')  String? checkInAt, @JsonKey(name: 'check_out_at')  String? checkOutAt, @JsonKey(name: 'status_id')  String? statusId,  String? remarks)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceCorrectionRequest() when $default != null:
return $default(_that.reason,_that.checkInAt,_that.checkOutAt,_that.statusId,_that.remarks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceCorrectionRequest implements AttendanceCorrectionRequest {
  const _AttendanceCorrectionRequest({required this.reason, @JsonKey(name: 'check_in_at') this.checkInAt, @JsonKey(name: 'check_out_at') this.checkOutAt, @JsonKey(name: 'status_id') this.statusId, this.remarks});
  factory _AttendanceCorrectionRequest.fromJson(Map<String, dynamic> json) => _$AttendanceCorrectionRequestFromJson(json);

@override final  String reason;
@override@JsonKey(name: 'check_in_at') final  String? checkInAt;
@override@JsonKey(name: 'check_out_at') final  String? checkOutAt;
@override@JsonKey(name: 'status_id') final  String? statusId;
@override final  String? remarks;

/// Create a copy of AttendanceCorrectionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCorrectionRequestCopyWith<_AttendanceCorrectionRequest> get copyWith => __$AttendanceCorrectionRequestCopyWithImpl<_AttendanceCorrectionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceCorrectionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceCorrectionRequest&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.remarks, remarks) || other.remarks == remarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,checkInAt,checkOutAt,statusId,remarks);

@override
String toString() {
  return 'AttendanceCorrectionRequest(reason: $reason, checkInAt: $checkInAt, checkOutAt: $checkOutAt, statusId: $statusId, remarks: $remarks)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCorrectionRequestCopyWith<$Res> implements $AttendanceCorrectionRequestCopyWith<$Res> {
  factory _$AttendanceCorrectionRequestCopyWith(_AttendanceCorrectionRequest value, $Res Function(_AttendanceCorrectionRequest) _then) = __$AttendanceCorrectionRequestCopyWithImpl;
@override @useResult
$Res call({
 String reason,@JsonKey(name: 'check_in_at') String? checkInAt,@JsonKey(name: 'check_out_at') String? checkOutAt,@JsonKey(name: 'status_id') String? statusId, String? remarks
});




}
/// @nodoc
class __$AttendanceCorrectionRequestCopyWithImpl<$Res>
    implements _$AttendanceCorrectionRequestCopyWith<$Res> {
  __$AttendanceCorrectionRequestCopyWithImpl(this._self, this._then);

  final _AttendanceCorrectionRequest _self;
  final $Res Function(_AttendanceCorrectionRequest) _then;

/// Create a copy of AttendanceCorrectionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? statusId = freezed,Object? remarks = freezed,}) {
  return _then(_AttendanceCorrectionRequest(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as String?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as String?,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AttendanceCorrectionResponse {

 String get id;@JsonKey(name: 'attendance_id') String get attendanceId;@JsonKey(name: 'changed_by') String get changedBy;@JsonKey(name: 'old_value') Map<String, dynamic> get oldValue;@JsonKey(name: 'new_value') Map<String, dynamic> get newValue; String get reason; String get status;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of AttendanceCorrectionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCorrectionResponseCopyWith<AttendanceCorrectionResponse> get copyWith => _$AttendanceCorrectionResponseCopyWithImpl<AttendanceCorrectionResponse>(this as AttendanceCorrectionResponse, _$identity);

  /// Serializes this AttendanceCorrectionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCorrectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId)&&(identical(other.changedBy, changedBy) || other.changedBy == changedBy)&&const DeepCollectionEquality().equals(other.oldValue, oldValue)&&const DeepCollectionEquality().equals(other.newValue, newValue)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attendanceId,changedBy,const DeepCollectionEquality().hash(oldValue),const DeepCollectionEquality().hash(newValue),reason,status,createdAt);

@override
String toString() {
  return 'AttendanceCorrectionResponse(id: $id, attendanceId: $attendanceId, changedBy: $changedBy, oldValue: $oldValue, newValue: $newValue, reason: $reason, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AttendanceCorrectionResponseCopyWith<$Res>  {
  factory $AttendanceCorrectionResponseCopyWith(AttendanceCorrectionResponse value, $Res Function(AttendanceCorrectionResponse) _then) = _$AttendanceCorrectionResponseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'changed_by') String changedBy,@JsonKey(name: 'old_value') Map<String, dynamic> oldValue,@JsonKey(name: 'new_value') Map<String, dynamic> newValue, String reason, String status,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$AttendanceCorrectionResponseCopyWithImpl<$Res>
    implements $AttendanceCorrectionResponseCopyWith<$Res> {
  _$AttendanceCorrectionResponseCopyWithImpl(this._self, this._then);

  final AttendanceCorrectionResponse _self;
  final $Res Function(AttendanceCorrectionResponse) _then;

/// Create a copy of AttendanceCorrectionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? attendanceId = null,Object? changedBy = null,Object? oldValue = null,Object? newValue = null,Object? reason = null,Object? status = null,Object? createdAt = null,}) {
  return _then(AttendanceCorrectionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,changedBy: null == changedBy ? _self.changedBy : changedBy // ignore: cast_nullable_to_non_nullable
as String,oldValue: null == oldValue ? _self.oldValue : oldValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,newValue: null == newValue ? _self.newValue : newValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceCorrectionResponse].
extension AttendanceCorrectionResponsePatterns on AttendanceCorrectionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceCorrectionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceCorrectionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceCorrectionResponse value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceCorrectionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceCorrectionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceCorrectionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'changed_by')  String changedBy, @JsonKey(name: 'old_value')  Map<String, dynamic> oldValue, @JsonKey(name: 'new_value')  Map<String, dynamic> newValue,  String reason,  String status, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceCorrectionResponse() when $default != null:
return $default(_that.id,_that.attendanceId,_that.changedBy,_that.oldValue,_that.newValue,_that.reason,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'changed_by')  String changedBy, @JsonKey(name: 'old_value')  Map<String, dynamic> oldValue, @JsonKey(name: 'new_value')  Map<String, dynamic> newValue,  String reason,  String status, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _AttendanceCorrectionResponse():
return $default(_that.id,_that.attendanceId,_that.changedBy,_that.oldValue,_that.newValue,_that.reason,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'changed_by')  String changedBy, @JsonKey(name: 'old_value')  Map<String, dynamic> oldValue, @JsonKey(name: 'new_value')  Map<String, dynamic> newValue,  String reason,  String status, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceCorrectionResponse() when $default != null:
return $default(_that.id,_that.attendanceId,_that.changedBy,_that.oldValue,_that.newValue,_that.reason,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceCorrectionResponse implements AttendanceCorrectionResponse {
  const _AttendanceCorrectionResponse({required this.id, @JsonKey(name: 'attendance_id') required this.attendanceId, @JsonKey(name: 'changed_by') required this.changedBy, @JsonKey(name: 'old_value')  Map<String, dynamic> oldValue = const <String, dynamic>{}, @JsonKey(name: 'new_value')  Map<String, dynamic> newValue = const <String, dynamic>{}, required this.reason, required this.status, @JsonKey(name: 'created_at') required this.createdAt}): _oldValue = oldValue,_newValue = newValue;
  factory _AttendanceCorrectionResponse.fromJson(Map<String, dynamic> json) => _$AttendanceCorrectionResponseFromJson(json);

@override final  String id;
@override@JsonKey(name: 'attendance_id') final  String attendanceId;
@override@JsonKey(name: 'changed_by') final  String changedBy;
 final  Map<String, dynamic> _oldValue;
@override@JsonKey(name: 'old_value') Map<String, dynamic> get oldValue {
  if (_oldValue is EqualUnmodifiableMapView) return _oldValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_oldValue);
}

 final  Map<String, dynamic> _newValue;
@override@JsonKey(name: 'new_value') Map<String, dynamic> get newValue {
  if (_newValue is EqualUnmodifiableMapView) return _newValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_newValue);
}

@override final  String reason;
@override final  String status;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of AttendanceCorrectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCorrectionResponseCopyWith<_AttendanceCorrectionResponse> get copyWith => __$AttendanceCorrectionResponseCopyWithImpl<_AttendanceCorrectionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceCorrectionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceCorrectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId)&&(identical(other.changedBy, changedBy) || other.changedBy == changedBy)&&const DeepCollectionEquality().equals(other._oldValue, _oldValue)&&const DeepCollectionEquality().equals(other._newValue, _newValue)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attendanceId,changedBy,const DeepCollectionEquality().hash(_oldValue),const DeepCollectionEquality().hash(_newValue),reason,status,createdAt);

@override
String toString() {
  return 'AttendanceCorrectionResponse(id: $id, attendanceId: $attendanceId, changedBy: $changedBy, oldValue: $oldValue, newValue: $newValue, reason: $reason, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCorrectionResponseCopyWith<$Res> implements $AttendanceCorrectionResponseCopyWith<$Res> {
  factory _$AttendanceCorrectionResponseCopyWith(_AttendanceCorrectionResponse value, $Res Function(_AttendanceCorrectionResponse) _then) = __$AttendanceCorrectionResponseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'changed_by') String changedBy,@JsonKey(name: 'old_value') Map<String, dynamic> oldValue,@JsonKey(name: 'new_value') Map<String, dynamic> newValue, String reason, String status,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$AttendanceCorrectionResponseCopyWithImpl<$Res>
    implements _$AttendanceCorrectionResponseCopyWith<$Res> {
  __$AttendanceCorrectionResponseCopyWithImpl(this._self, this._then);

  final _AttendanceCorrectionResponse _self;
  final $Res Function(_AttendanceCorrectionResponse) _then;

/// Create a copy of AttendanceCorrectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attendanceId = null,Object? changedBy = null,Object? oldValue = null,Object? newValue = null,Object? reason = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_AttendanceCorrectionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,changedBy: null == changedBy ? _self.changedBy : changedBy // ignore: cast_nullable_to_non_nullable
as String,oldValue: null == oldValue ? _self._oldValue : oldValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,newValue: null == newValue ? _self._newValue : newValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
