// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_attendance_controllers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminAttendanceTodayState {

 AttendanceTodayReportResponse? get data; bool get isLoading; String? get departmentId; String? get errorMessage;
/// Create a copy of AdminAttendanceTodayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAttendanceTodayStateCopyWith<AdminAttendanceTodayState> get copyWith => _$AdminAttendanceTodayStateCopyWithImpl<AdminAttendanceTodayState>(this as AdminAttendanceTodayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAttendanceTodayState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,departmentId,errorMessage);

@override
String toString() {
  return 'AdminAttendanceTodayState(data: $data, isLoading: $isLoading, departmentId: $departmentId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminAttendanceTodayStateCopyWith<$Res>  {
  factory $AdminAttendanceTodayStateCopyWith(AdminAttendanceTodayState value, $Res Function(AdminAttendanceTodayState) _then) = _$AdminAttendanceTodayStateCopyWithImpl;
@useResult
$Res call({
 AttendanceTodayReportResponse? data, bool isLoading, String? departmentId, String? errorMessage
});


$AttendanceTodayReportResponseCopyWith<$Res>? get data;

}
/// @nodoc
class _$AdminAttendanceTodayStateCopyWithImpl<$Res>
    implements $AdminAttendanceTodayStateCopyWith<$Res> {
  _$AdminAttendanceTodayStateCopyWithImpl(this._self, this._then);

  final AdminAttendanceTodayState _self;
  final $Res Function(AdminAttendanceTodayState) _then;

/// Create a copy of AdminAttendanceTodayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? isLoading = null,Object? departmentId = freezed,Object? errorMessage = freezed,}) {
  return _then(AdminAttendanceTodayState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AttendanceTodayReportResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminAttendanceTodayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceTodayReportResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AttendanceTodayReportResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminAttendanceTodayState].
extension AdminAttendanceTodayStatePatterns on AdminAttendanceTodayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminAttendanceTodayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminAttendanceTodayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminAttendanceTodayState value)  $default,){
final _that = this;
switch (_that) {
case _AdminAttendanceTodayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminAttendanceTodayState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminAttendanceTodayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AttendanceTodayReportResponse? data,  bool isLoading,  String? departmentId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminAttendanceTodayState() when $default != null:
return $default(_that.data,_that.isLoading,_that.departmentId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AttendanceTodayReportResponse? data,  bool isLoading,  String? departmentId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminAttendanceTodayState():
return $default(_that.data,_that.isLoading,_that.departmentId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AttendanceTodayReportResponse? data,  bool isLoading,  String? departmentId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminAttendanceTodayState() when $default != null:
return $default(_that.data,_that.isLoading,_that.departmentId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminAttendanceTodayState implements AdminAttendanceTodayState {
  const _AdminAttendanceTodayState({this.data, this.isLoading = true, this.departmentId, this.errorMessage});
  

@override final  AttendanceTodayReportResponse? data;
@override@JsonKey() final  bool isLoading;
@override final  String? departmentId;
@override final  String? errorMessage;

/// Create a copy of AdminAttendanceTodayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAttendanceTodayStateCopyWith<_AdminAttendanceTodayState> get copyWith => __$AdminAttendanceTodayStateCopyWithImpl<_AdminAttendanceTodayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAttendanceTodayState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,departmentId,errorMessage);

@override
String toString() {
  return 'AdminAttendanceTodayState(data: $data, isLoading: $isLoading, departmentId: $departmentId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminAttendanceTodayStateCopyWith<$Res> implements $AdminAttendanceTodayStateCopyWith<$Res> {
  factory _$AdminAttendanceTodayStateCopyWith(_AdminAttendanceTodayState value, $Res Function(_AdminAttendanceTodayState) _then) = __$AdminAttendanceTodayStateCopyWithImpl;
@override @useResult
$Res call({
 AttendanceTodayReportResponse? data, bool isLoading, String? departmentId, String? errorMessage
});


@override $AttendanceTodayReportResponseCopyWith<$Res>? get data;

}
/// @nodoc
class __$AdminAttendanceTodayStateCopyWithImpl<$Res>
    implements _$AdminAttendanceTodayStateCopyWith<$Res> {
  __$AdminAttendanceTodayStateCopyWithImpl(this._self, this._then);

  final _AdminAttendanceTodayState _self;
  final $Res Function(_AdminAttendanceTodayState) _then;

/// Create a copy of AdminAttendanceTodayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? isLoading = null,Object? departmentId = freezed,Object? errorMessage = freezed,}) {
  return _then(_AdminAttendanceTodayState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AttendanceTodayReportResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminAttendanceTodayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceTodayReportResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AttendanceTodayReportResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AdminMonthlyOverviewState {

 MonthlyOverviewResponse? get data; bool get isLoading; int get month; int get year; String? get departmentId; String? get errorMessage;
/// Create a copy of AdminMonthlyOverviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminMonthlyOverviewStateCopyWith<AdminMonthlyOverviewState> get copyWith => _$AdminMonthlyOverviewStateCopyWithImpl<AdminMonthlyOverviewState>(this as AdminMonthlyOverviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminMonthlyOverviewState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,month,year,departmentId,errorMessage);

@override
String toString() {
  return 'AdminMonthlyOverviewState(data: $data, isLoading: $isLoading, month: $month, year: $year, departmentId: $departmentId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminMonthlyOverviewStateCopyWith<$Res>  {
  factory $AdminMonthlyOverviewStateCopyWith(AdminMonthlyOverviewState value, $Res Function(AdminMonthlyOverviewState) _then) = _$AdminMonthlyOverviewStateCopyWithImpl;
@useResult
$Res call({
 MonthlyOverviewResponse? data, bool isLoading, int month, int year, String? departmentId, String? errorMessage
});


$MonthlyOverviewResponseCopyWith<$Res>? get data;

}
/// @nodoc
class _$AdminMonthlyOverviewStateCopyWithImpl<$Res>
    implements $AdminMonthlyOverviewStateCopyWith<$Res> {
  _$AdminMonthlyOverviewStateCopyWithImpl(this._self, this._then);

  final AdminMonthlyOverviewState _self;
  final $Res Function(AdminMonthlyOverviewState) _then;

/// Create a copy of AdminMonthlyOverviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? isLoading = null,Object? month = null,Object? year = null,Object? departmentId = freezed,Object? errorMessage = freezed,}) {
  return _then(AdminMonthlyOverviewState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MonthlyOverviewResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminMonthlyOverviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyOverviewResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MonthlyOverviewResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminMonthlyOverviewState].
extension AdminMonthlyOverviewStatePatterns on AdminMonthlyOverviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminMonthlyOverviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminMonthlyOverviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminMonthlyOverviewState value)  $default,){
final _that = this;
switch (_that) {
case _AdminMonthlyOverviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminMonthlyOverviewState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminMonthlyOverviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MonthlyOverviewResponse? data,  bool isLoading,  int month,  int year,  String? departmentId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminMonthlyOverviewState() when $default != null:
return $default(_that.data,_that.isLoading,_that.month,_that.year,_that.departmentId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MonthlyOverviewResponse? data,  bool isLoading,  int month,  int year,  String? departmentId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminMonthlyOverviewState():
return $default(_that.data,_that.isLoading,_that.month,_that.year,_that.departmentId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MonthlyOverviewResponse? data,  bool isLoading,  int month,  int year,  String? departmentId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminMonthlyOverviewState() when $default != null:
return $default(_that.data,_that.isLoading,_that.month,_that.year,_that.departmentId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminMonthlyOverviewState implements AdminMonthlyOverviewState {
  const _AdminMonthlyOverviewState({this.data, this.isLoading = true, required this.month, required this.year, this.departmentId, this.errorMessage});
  

@override final  MonthlyOverviewResponse? data;
@override@JsonKey() final  bool isLoading;
@override final  int month;
@override final  int year;
@override final  String? departmentId;
@override final  String? errorMessage;

/// Create a copy of AdminMonthlyOverviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminMonthlyOverviewStateCopyWith<_AdminMonthlyOverviewState> get copyWith => __$AdminMonthlyOverviewStateCopyWithImpl<_AdminMonthlyOverviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminMonthlyOverviewState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,month,year,departmentId,errorMessage);

@override
String toString() {
  return 'AdminMonthlyOverviewState(data: $data, isLoading: $isLoading, month: $month, year: $year, departmentId: $departmentId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminMonthlyOverviewStateCopyWith<$Res> implements $AdminMonthlyOverviewStateCopyWith<$Res> {
  factory _$AdminMonthlyOverviewStateCopyWith(_AdminMonthlyOverviewState value, $Res Function(_AdminMonthlyOverviewState) _then) = __$AdminMonthlyOverviewStateCopyWithImpl;
@override @useResult
$Res call({
 MonthlyOverviewResponse? data, bool isLoading, int month, int year, String? departmentId, String? errorMessage
});


@override $MonthlyOverviewResponseCopyWith<$Res>? get data;

}
/// @nodoc
class __$AdminMonthlyOverviewStateCopyWithImpl<$Res>
    implements _$AdminMonthlyOverviewStateCopyWith<$Res> {
  __$AdminMonthlyOverviewStateCopyWithImpl(this._self, this._then);

  final _AdminMonthlyOverviewState _self;
  final $Res Function(_AdminMonthlyOverviewState) _then;

/// Create a copy of AdminMonthlyOverviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? isLoading = null,Object? month = null,Object? year = null,Object? departmentId = freezed,Object? errorMessage = freezed,}) {
  return _then(_AdminMonthlyOverviewState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MonthlyOverviewResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminMonthlyOverviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyOverviewResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MonthlyOverviewResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AdminEmployeeMonthlyState {

 EmployeeMonthlyReportResponse? get data; bool get isLoading; int get month; int get year; String? get errorMessage;
/// Create a copy of AdminEmployeeMonthlyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminEmployeeMonthlyStateCopyWith<AdminEmployeeMonthlyState> get copyWith => _$AdminEmployeeMonthlyStateCopyWithImpl<AdminEmployeeMonthlyState>(this as AdminEmployeeMonthlyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminEmployeeMonthlyState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,month,year,errorMessage);

@override
String toString() {
  return 'AdminEmployeeMonthlyState(data: $data, isLoading: $isLoading, month: $month, year: $year, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminEmployeeMonthlyStateCopyWith<$Res>  {
  factory $AdminEmployeeMonthlyStateCopyWith(AdminEmployeeMonthlyState value, $Res Function(AdminEmployeeMonthlyState) _then) = _$AdminEmployeeMonthlyStateCopyWithImpl;
@useResult
$Res call({
 EmployeeMonthlyReportResponse? data, bool isLoading, int month, int year, String? errorMessage
});


$EmployeeMonthlyReportResponseCopyWith<$Res>? get data;

}
/// @nodoc
class _$AdminEmployeeMonthlyStateCopyWithImpl<$Res>
    implements $AdminEmployeeMonthlyStateCopyWith<$Res> {
  _$AdminEmployeeMonthlyStateCopyWithImpl(this._self, this._then);

  final AdminEmployeeMonthlyState _self;
  final $Res Function(AdminEmployeeMonthlyState) _then;

/// Create a copy of AdminEmployeeMonthlyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? isLoading = null,Object? month = null,Object? year = null,Object? errorMessage = freezed,}) {
  return _then(AdminEmployeeMonthlyState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as EmployeeMonthlyReportResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminEmployeeMonthlyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeMonthlyReportResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EmployeeMonthlyReportResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminEmployeeMonthlyState].
extension AdminEmployeeMonthlyStatePatterns on AdminEmployeeMonthlyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminEmployeeMonthlyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminEmployeeMonthlyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminEmployeeMonthlyState value)  $default,){
final _that = this;
switch (_that) {
case _AdminEmployeeMonthlyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminEmployeeMonthlyState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminEmployeeMonthlyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EmployeeMonthlyReportResponse? data,  bool isLoading,  int month,  int year,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminEmployeeMonthlyState() when $default != null:
return $default(_that.data,_that.isLoading,_that.month,_that.year,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EmployeeMonthlyReportResponse? data,  bool isLoading,  int month,  int year,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminEmployeeMonthlyState():
return $default(_that.data,_that.isLoading,_that.month,_that.year,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EmployeeMonthlyReportResponse? data,  bool isLoading,  int month,  int year,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminEmployeeMonthlyState() when $default != null:
return $default(_that.data,_that.isLoading,_that.month,_that.year,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminEmployeeMonthlyState implements AdminEmployeeMonthlyState {
  const _AdminEmployeeMonthlyState({this.data, this.isLoading = true, required this.month, required this.year, this.errorMessage});
  

@override final  EmployeeMonthlyReportResponse? data;
@override@JsonKey() final  bool isLoading;
@override final  int month;
@override final  int year;
@override final  String? errorMessage;

/// Create a copy of AdminEmployeeMonthlyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminEmployeeMonthlyStateCopyWith<_AdminEmployeeMonthlyState> get copyWith => __$AdminEmployeeMonthlyStateCopyWithImpl<_AdminEmployeeMonthlyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminEmployeeMonthlyState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,month,year,errorMessage);

@override
String toString() {
  return 'AdminEmployeeMonthlyState(data: $data, isLoading: $isLoading, month: $month, year: $year, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminEmployeeMonthlyStateCopyWith<$Res> implements $AdminEmployeeMonthlyStateCopyWith<$Res> {
  factory _$AdminEmployeeMonthlyStateCopyWith(_AdminEmployeeMonthlyState value, $Res Function(_AdminEmployeeMonthlyState) _then) = __$AdminEmployeeMonthlyStateCopyWithImpl;
@override @useResult
$Res call({
 EmployeeMonthlyReportResponse? data, bool isLoading, int month, int year, String? errorMessage
});


@override $EmployeeMonthlyReportResponseCopyWith<$Res>? get data;

}
/// @nodoc
class __$AdminEmployeeMonthlyStateCopyWithImpl<$Res>
    implements _$AdminEmployeeMonthlyStateCopyWith<$Res> {
  __$AdminEmployeeMonthlyStateCopyWithImpl(this._self, this._then);

  final _AdminEmployeeMonthlyState _self;
  final $Res Function(_AdminEmployeeMonthlyState) _then;

/// Create a copy of AdminEmployeeMonthlyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? isLoading = null,Object? month = null,Object? year = null,Object? errorMessage = freezed,}) {
  return _then(_AdminEmployeeMonthlyState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as EmployeeMonthlyReportResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminEmployeeMonthlyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeMonthlyReportResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EmployeeMonthlyReportResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AdminEmployeeYearlyState {

 EmployeeYearlyReportResponse? get data; bool get isLoading; int get year; String? get errorMessage;
/// Create a copy of AdminEmployeeYearlyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminEmployeeYearlyStateCopyWith<AdminEmployeeYearlyState> get copyWith => _$AdminEmployeeYearlyStateCopyWithImpl<AdminEmployeeYearlyState>(this as AdminEmployeeYearlyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminEmployeeYearlyState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.year, year) || other.year == year)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,year,errorMessage);

@override
String toString() {
  return 'AdminEmployeeYearlyState(data: $data, isLoading: $isLoading, year: $year, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminEmployeeYearlyStateCopyWith<$Res>  {
  factory $AdminEmployeeYearlyStateCopyWith(AdminEmployeeYearlyState value, $Res Function(AdminEmployeeYearlyState) _then) = _$AdminEmployeeYearlyStateCopyWithImpl;
@useResult
$Res call({
 EmployeeYearlyReportResponse? data, bool isLoading, int year, String? errorMessage
});


$EmployeeYearlyReportResponseCopyWith<$Res>? get data;

}
/// @nodoc
class _$AdminEmployeeYearlyStateCopyWithImpl<$Res>
    implements $AdminEmployeeYearlyStateCopyWith<$Res> {
  _$AdminEmployeeYearlyStateCopyWithImpl(this._self, this._then);

  final AdminEmployeeYearlyState _self;
  final $Res Function(AdminEmployeeYearlyState) _then;

/// Create a copy of AdminEmployeeYearlyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? isLoading = null,Object? year = null,Object? errorMessage = freezed,}) {
  return _then(AdminEmployeeYearlyState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as EmployeeYearlyReportResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminEmployeeYearlyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeYearlyReportResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EmployeeYearlyReportResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminEmployeeYearlyState].
extension AdminEmployeeYearlyStatePatterns on AdminEmployeeYearlyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminEmployeeYearlyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminEmployeeYearlyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminEmployeeYearlyState value)  $default,){
final _that = this;
switch (_that) {
case _AdminEmployeeYearlyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminEmployeeYearlyState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminEmployeeYearlyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EmployeeYearlyReportResponse? data,  bool isLoading,  int year,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminEmployeeYearlyState() when $default != null:
return $default(_that.data,_that.isLoading,_that.year,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EmployeeYearlyReportResponse? data,  bool isLoading,  int year,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminEmployeeYearlyState():
return $default(_that.data,_that.isLoading,_that.year,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EmployeeYearlyReportResponse? data,  bool isLoading,  int year,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminEmployeeYearlyState() when $default != null:
return $default(_that.data,_that.isLoading,_that.year,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminEmployeeYearlyState implements AdminEmployeeYearlyState {
  const _AdminEmployeeYearlyState({this.data, this.isLoading = true, required this.year, this.errorMessage});
  

@override final  EmployeeYearlyReportResponse? data;
@override@JsonKey() final  bool isLoading;
@override final  int year;
@override final  String? errorMessage;

/// Create a copy of AdminEmployeeYearlyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminEmployeeYearlyStateCopyWith<_AdminEmployeeYearlyState> get copyWith => __$AdminEmployeeYearlyStateCopyWithImpl<_AdminEmployeeYearlyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminEmployeeYearlyState&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.year, year) || other.year == year)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,isLoading,year,errorMessage);

@override
String toString() {
  return 'AdminEmployeeYearlyState(data: $data, isLoading: $isLoading, year: $year, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminEmployeeYearlyStateCopyWith<$Res> implements $AdminEmployeeYearlyStateCopyWith<$Res> {
  factory _$AdminEmployeeYearlyStateCopyWith(_AdminEmployeeYearlyState value, $Res Function(_AdminEmployeeYearlyState) _then) = __$AdminEmployeeYearlyStateCopyWithImpl;
@override @useResult
$Res call({
 EmployeeYearlyReportResponse? data, bool isLoading, int year, String? errorMessage
});


@override $EmployeeYearlyReportResponseCopyWith<$Res>? get data;

}
/// @nodoc
class __$AdminEmployeeYearlyStateCopyWithImpl<$Res>
    implements _$AdminEmployeeYearlyStateCopyWith<$Res> {
  __$AdminEmployeeYearlyStateCopyWithImpl(this._self, this._then);

  final _AdminEmployeeYearlyState _self;
  final $Res Function(_AdminEmployeeYearlyState) _then;

/// Create a copy of AdminEmployeeYearlyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? isLoading = null,Object? year = null,Object? errorMessage = freezed,}) {
  return _then(_AdminEmployeeYearlyState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as EmployeeYearlyReportResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminEmployeeYearlyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeYearlyReportResponseCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EmployeeYearlyReportResponseCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AttendanceCorrectionState {

 bool get isSubmitting; String? get errorMessage; String? get successMessage;
/// Create a copy of AttendanceCorrectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCorrectionStateCopyWith<AttendanceCorrectionState> get copyWith => _$AttendanceCorrectionStateCopyWithImpl<AttendanceCorrectionState>(this as AttendanceCorrectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCorrectionState&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isSubmitting,errorMessage,successMessage);

@override
String toString() {
  return 'AttendanceCorrectionState(isSubmitting: $isSubmitting, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $AttendanceCorrectionStateCopyWith<$Res>  {
  factory $AttendanceCorrectionStateCopyWith(AttendanceCorrectionState value, $Res Function(AttendanceCorrectionState) _then) = _$AttendanceCorrectionStateCopyWithImpl;
@useResult
$Res call({
 bool isSubmitting, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$AttendanceCorrectionStateCopyWithImpl<$Res>
    implements $AttendanceCorrectionStateCopyWith<$Res> {
  _$AttendanceCorrectionStateCopyWithImpl(this._self, this._then);

  final AttendanceCorrectionState _self;
  final $Res Function(AttendanceCorrectionState) _then;

/// Create a copy of AttendanceCorrectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubmitting = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(AttendanceCorrectionState(
isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceCorrectionState].
extension AttendanceCorrectionStatePatterns on AttendanceCorrectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceCorrectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceCorrectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceCorrectionState value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceCorrectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceCorrectionState value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceCorrectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubmitting,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceCorrectionState() when $default != null:
return $default(_that.isSubmitting,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubmitting,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _AttendanceCorrectionState():
return $default(_that.isSubmitting,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubmitting,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceCorrectionState() when $default != null:
return $default(_that.isSubmitting,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AttendanceCorrectionState implements AttendanceCorrectionState {
  const _AttendanceCorrectionState({this.isSubmitting = false, this.errorMessage, this.successMessage});
  

@override@JsonKey() final  bool isSubmitting;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of AttendanceCorrectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCorrectionStateCopyWith<_AttendanceCorrectionState> get copyWith => __$AttendanceCorrectionStateCopyWithImpl<_AttendanceCorrectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceCorrectionState&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isSubmitting,errorMessage,successMessage);

@override
String toString() {
  return 'AttendanceCorrectionState(isSubmitting: $isSubmitting, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCorrectionStateCopyWith<$Res> implements $AttendanceCorrectionStateCopyWith<$Res> {
  factory _$AttendanceCorrectionStateCopyWith(_AttendanceCorrectionState value, $Res Function(_AttendanceCorrectionState) _then) = __$AttendanceCorrectionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSubmitting, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$AttendanceCorrectionStateCopyWithImpl<$Res>
    implements _$AttendanceCorrectionStateCopyWith<$Res> {
  __$AttendanceCorrectionStateCopyWithImpl(this._self, this._then);

  final _AttendanceCorrectionState _self;
  final $Res Function(_AttendanceCorrectionState) _then;

/// Create a copy of AttendanceCorrectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubmitting = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_AttendanceCorrectionState(
isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
