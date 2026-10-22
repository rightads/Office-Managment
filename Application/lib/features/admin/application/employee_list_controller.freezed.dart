// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_list_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmployeeListState {

 List<EmployeeItem> get employees; List<RoleItem> get roles; bool get isLoading; bool get isPaginating; bool get hasMore; int get currentPage; String? get search; String? get departmentId; String? get roleId; bool? get isActive; String? get errorMessage;
/// Create a copy of EmployeeListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeListStateCopyWith<EmployeeListState> get copyWith => _$EmployeeListStateCopyWithImpl<EmployeeListState>(this as EmployeeListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeListState&&const DeepCollectionEquality().equals(other.employees, employees)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.search, search) || other.search == search)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(employees),const DeepCollectionEquality().hash(roles),isLoading,isPaginating,hasMore,currentPage,search,departmentId,roleId,isActive,errorMessage);

@override
String toString() {
  return 'EmployeeListState(employees: $employees, roles: $roles, isLoading: $isLoading, isPaginating: $isPaginating, hasMore: $hasMore, currentPage: $currentPage, search: $search, departmentId: $departmentId, roleId: $roleId, isActive: $isActive, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $EmployeeListStateCopyWith<$Res>  {
  factory $EmployeeListStateCopyWith(EmployeeListState value, $Res Function(EmployeeListState) _then) = _$EmployeeListStateCopyWithImpl;
@useResult
$Res call({
 List<EmployeeItem> employees, List<RoleItem> roles, bool isLoading, bool isPaginating, bool hasMore, int currentPage, String? search, String? departmentId, String? roleId, bool? isActive, String? errorMessage
});




}
/// @nodoc
class _$EmployeeListStateCopyWithImpl<$Res>
    implements $EmployeeListStateCopyWith<$Res> {
  _$EmployeeListStateCopyWithImpl(this._self, this._then);

  final EmployeeListState _self;
  final $Res Function(EmployeeListState) _then;

/// Create a copy of EmployeeListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employees = null,Object? roles = null,Object? isLoading = null,Object? isPaginating = null,Object? hasMore = null,Object? currentPage = null,Object? search = freezed,Object? departmentId = freezed,Object? roleId = freezed,Object? isActive = freezed,Object? errorMessage = freezed,}) {
  return _then(EmployeeListState(
employees: null == employees ? _self.employees : employees // ignore: cast_nullable_to_non_nullable
as List<EmployeeItem>,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<RoleItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,roleId: freezed == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeListState].
extension EmployeeListStatePatterns on EmployeeListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeListState value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeListState value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EmployeeItem> employees,  List<RoleItem> roles,  bool isLoading,  bool isPaginating,  bool hasMore,  int currentPage,  String? search,  String? departmentId,  String? roleId,  bool? isActive,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeListState() when $default != null:
return $default(_that.employees,_that.roles,_that.isLoading,_that.isPaginating,_that.hasMore,_that.currentPage,_that.search,_that.departmentId,_that.roleId,_that.isActive,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EmployeeItem> employees,  List<RoleItem> roles,  bool isLoading,  bool isPaginating,  bool hasMore,  int currentPage,  String? search,  String? departmentId,  String? roleId,  bool? isActive,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _EmployeeListState():
return $default(_that.employees,_that.roles,_that.isLoading,_that.isPaginating,_that.hasMore,_that.currentPage,_that.search,_that.departmentId,_that.roleId,_that.isActive,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EmployeeItem> employees,  List<RoleItem> roles,  bool isLoading,  bool isPaginating,  bool hasMore,  int currentPage,  String? search,  String? departmentId,  String? roleId,  bool? isActive,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeListState() when $default != null:
return $default(_that.employees,_that.roles,_that.isLoading,_that.isPaginating,_that.hasMore,_that.currentPage,_that.search,_that.departmentId,_that.roleId,_that.isActive,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EmployeeListState implements EmployeeListState {
  const _EmployeeListState({ List<EmployeeItem> employees = const <EmployeeItem>[],  List<RoleItem> roles = const <RoleItem>[], this.isLoading = true, this.isPaginating = false, this.hasMore = false, this.currentPage = 1, this.search, this.departmentId, this.roleId, this.isActive, this.errorMessage}): _employees = employees,_roles = roles;
  

 final  List<EmployeeItem> _employees;
@override@JsonKey() List<EmployeeItem> get employees {
  if (_employees is EqualUnmodifiableListView) return _employees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employees);
}

 final  List<RoleItem> _roles;
@override@JsonKey() List<RoleItem> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isPaginating;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int currentPage;
@override final  String? search;
@override final  String? departmentId;
@override final  String? roleId;
@override final  bool? isActive;
@override final  String? errorMessage;

/// Create a copy of EmployeeListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeListStateCopyWith<_EmployeeListState> get copyWith => __$EmployeeListStateCopyWithImpl<_EmployeeListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeListState&&const DeepCollectionEquality().equals(other._employees, _employees)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.search, search) || other.search == search)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_employees),const DeepCollectionEquality().hash(_roles),isLoading,isPaginating,hasMore,currentPage,search,departmentId,roleId,isActive,errorMessage);

@override
String toString() {
  return 'EmployeeListState(employees: $employees, roles: $roles, isLoading: $isLoading, isPaginating: $isPaginating, hasMore: $hasMore, currentPage: $currentPage, search: $search, departmentId: $departmentId, roleId: $roleId, isActive: $isActive, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$EmployeeListStateCopyWith<$Res> implements $EmployeeListStateCopyWith<$Res> {
  factory _$EmployeeListStateCopyWith(_EmployeeListState value, $Res Function(_EmployeeListState) _then) = __$EmployeeListStateCopyWithImpl;
@override @useResult
$Res call({
 List<EmployeeItem> employees, List<RoleItem> roles, bool isLoading, bool isPaginating, bool hasMore, int currentPage, String? search, String? departmentId, String? roleId, bool? isActive, String? errorMessage
});




}
/// @nodoc
class __$EmployeeListStateCopyWithImpl<$Res>
    implements _$EmployeeListStateCopyWith<$Res> {
  __$EmployeeListStateCopyWithImpl(this._self, this._then);

  final _EmployeeListState _self;
  final $Res Function(_EmployeeListState) _then;

/// Create a copy of EmployeeListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employees = null,Object? roles = null,Object? isLoading = null,Object? isPaginating = null,Object? hasMore = null,Object? currentPage = null,Object? search = freezed,Object? departmentId = freezed,Object? roleId = freezed,Object? isActive = freezed,Object? errorMessage = freezed,}) {
  return _then(_EmployeeListState(
employees: null == employees ? _self._employees : employees // ignore: cast_nullable_to_non_nullable
as List<EmployeeItem>,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<RoleItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,roleId: freezed == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
