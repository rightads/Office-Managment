// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_detail_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmployeeDetailState {

 EmployeeItem? get employee; bool get isLoading; bool get isActionLoading; String? get errorMessage; String? get actionSuccessMessage;
/// Create a copy of EmployeeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeDetailStateCopyWith<EmployeeDetailState> get copyWith => _$EmployeeDetailStateCopyWithImpl<EmployeeDetailState>(this as EmployeeDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeDetailState&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.actionSuccessMessage, actionSuccessMessage) || other.actionSuccessMessage == actionSuccessMessage));
}


@override
int get hashCode => Object.hash(runtimeType,employee,isLoading,isActionLoading,errorMessage,actionSuccessMessage);

@override
String toString() {
  return 'EmployeeDetailState(employee: $employee, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage, actionSuccessMessage: $actionSuccessMessage)';
}


}

/// @nodoc
abstract mixin class $EmployeeDetailStateCopyWith<$Res>  {
  factory $EmployeeDetailStateCopyWith(EmployeeDetailState value, $Res Function(EmployeeDetailState) _then) = _$EmployeeDetailStateCopyWithImpl;
@useResult
$Res call({
 EmployeeItem? employee, bool isLoading, bool isActionLoading, String? errorMessage, String? actionSuccessMessage
});


$EmployeeItemCopyWith<$Res>? get employee;

}
/// @nodoc
class _$EmployeeDetailStateCopyWithImpl<$Res>
    implements $EmployeeDetailStateCopyWith<$Res> {
  _$EmployeeDetailStateCopyWithImpl(this._self, this._then);

  final EmployeeDetailState _self;
  final $Res Function(EmployeeDetailState) _then;

/// Create a copy of EmployeeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employee = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,Object? actionSuccessMessage = freezed,}) {
  return _then(EmployeeDetailState(
employee: freezed == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as EmployeeItem?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionSuccessMessage: freezed == actionSuccessMessage ? _self.actionSuccessMessage : actionSuccessMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EmployeeDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeItemCopyWith<$Res>? get employee {
    if (_self.employee == null) {
    return null;
  }

  return $EmployeeItemCopyWith<$Res>(_self.employee!, (value) {
    return _then(_self.copyWith(employee: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmployeeDetailState].
extension EmployeeDetailStatePatterns on EmployeeDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeDetailState value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EmployeeItem? employee,  bool isLoading,  bool isActionLoading,  String? errorMessage,  String? actionSuccessMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeDetailState() when $default != null:
return $default(_that.employee,_that.isLoading,_that.isActionLoading,_that.errorMessage,_that.actionSuccessMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EmployeeItem? employee,  bool isLoading,  bool isActionLoading,  String? errorMessage,  String? actionSuccessMessage)  $default,) {final _that = this;
switch (_that) {
case _EmployeeDetailState():
return $default(_that.employee,_that.isLoading,_that.isActionLoading,_that.errorMessage,_that.actionSuccessMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EmployeeItem? employee,  bool isLoading,  bool isActionLoading,  String? errorMessage,  String? actionSuccessMessage)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeDetailState() when $default != null:
return $default(_that.employee,_that.isLoading,_that.isActionLoading,_that.errorMessage,_that.actionSuccessMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EmployeeDetailState implements EmployeeDetailState {
  const _EmployeeDetailState({this.employee, this.isLoading = true, this.isActionLoading = false, this.errorMessage, this.actionSuccessMessage});
  

@override final  EmployeeItem? employee;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String? errorMessage;
@override final  String? actionSuccessMessage;

/// Create a copy of EmployeeDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeDetailStateCopyWith<_EmployeeDetailState> get copyWith => __$EmployeeDetailStateCopyWithImpl<_EmployeeDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeDetailState&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.actionSuccessMessage, actionSuccessMessage) || other.actionSuccessMessage == actionSuccessMessage));
}


@override
int get hashCode => Object.hash(runtimeType,employee,isLoading,isActionLoading,errorMessage,actionSuccessMessage);

@override
String toString() {
  return 'EmployeeDetailState(employee: $employee, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage, actionSuccessMessage: $actionSuccessMessage)';
}


}

/// @nodoc
abstract mixin class _$EmployeeDetailStateCopyWith<$Res> implements $EmployeeDetailStateCopyWith<$Res> {
  factory _$EmployeeDetailStateCopyWith(_EmployeeDetailState value, $Res Function(_EmployeeDetailState) _then) = __$EmployeeDetailStateCopyWithImpl;
@override @useResult
$Res call({
 EmployeeItem? employee, bool isLoading, bool isActionLoading, String? errorMessage, String? actionSuccessMessage
});


@override $EmployeeItemCopyWith<$Res>? get employee;

}
/// @nodoc
class __$EmployeeDetailStateCopyWithImpl<$Res>
    implements _$EmployeeDetailStateCopyWith<$Res> {
  __$EmployeeDetailStateCopyWithImpl(this._self, this._then);

  final _EmployeeDetailState _self;
  final $Res Function(_EmployeeDetailState) _then;

/// Create a copy of EmployeeDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employee = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,Object? actionSuccessMessage = freezed,}) {
  return _then(_EmployeeDetailState(
employee: freezed == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as EmployeeItem?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionSuccessMessage: freezed == actionSuccessMessage ? _self.actionSuccessMessage : actionSuccessMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EmployeeDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeItemCopyWith<$Res>? get employee {
    if (_self.employee == null) {
    return null;
  }

  return $EmployeeItemCopyWith<$Res>(_self.employee!, (value) {
    return _then(_self.copyWith(employee: value));
  });
}
}

// dart format on
