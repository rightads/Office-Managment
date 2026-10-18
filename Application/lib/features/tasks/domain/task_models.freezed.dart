// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserBriefModel {

 String get id;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'full_name') String get fullName; String get email;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of UserBriefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<UserBriefModel> get copyWith => _$UserBriefModelCopyWithImpl<UserBriefModel>(this as UserBriefModel, _$identity);

  /// Serializes this UserBriefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserBriefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,avatarUrl);

@override
String toString() {
  return 'UserBriefModel(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $UserBriefModelCopyWith<$Res>  {
  factory $UserBriefModelCopyWith(UserBriefModel value, $Res Function(UserBriefModel) _then) = _$UserBriefModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$UserBriefModelCopyWithImpl<$Res>
    implements $UserBriefModelCopyWith<$Res> {
  _$UserBriefModelCopyWithImpl(this._self, this._then);

  final UserBriefModel _self;
  final $Res Function(UserBriefModel) _then;

/// Create a copy of UserBriefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? avatarUrl = freezed,}) {
  return _then(UserBriefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserBriefModel].
extension UserBriefModelPatterns on UserBriefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserBriefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserBriefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserBriefModel value)  $default,){
final _that = this;
switch (_that) {
case _UserBriefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserBriefModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserBriefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserBriefModel() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _UserBriefModel():
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserBriefModel() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserBriefModel implements UserBriefModel {
  const _UserBriefModel({required this.id, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'full_name') required this.fullName, required this.email, @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _UserBriefModel.fromJson(Map<String, dynamic> json) => _$UserBriefModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String email;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of UserBriefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserBriefModelCopyWith<_UserBriefModel> get copyWith => __$UserBriefModelCopyWithImpl<_UserBriefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserBriefModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserBriefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,avatarUrl);

@override
String toString() {
  return 'UserBriefModel(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$UserBriefModelCopyWith<$Res> implements $UserBriefModelCopyWith<$Res> {
  factory _$UserBriefModelCopyWith(_UserBriefModel value, $Res Function(_UserBriefModel) _then) = __$UserBriefModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$UserBriefModelCopyWithImpl<$Res>
    implements _$UserBriefModelCopyWith<$Res> {
  __$UserBriefModelCopyWithImpl(this._self, this._then);

  final _UserBriefModel _self;
  final $Res Function(_UserBriefModel) _then;

/// Create a copy of UserBriefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? avatarUrl = freezed,}) {
  return _then(_UserBriefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TaskStatusModel {

 String get id; String get code; String get label; int get order;@JsonKey(name: 'is_terminal') bool get isTerminal; String get color;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of TaskStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskStatusModelCopyWith<TaskStatusModel> get copyWith => _$TaskStatusModelCopyWithImpl<TaskStatusModel>(this as TaskStatusModel, _$identity);

  /// Serializes this TaskStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskStatusModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.order, order) || other.order == order)&&(identical(other.isTerminal, isTerminal) || other.isTerminal == isTerminal)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,order,isTerminal,color,isActive);

@override
String toString() {
  return 'TaskStatusModel(id: $id, code: $code, label: $label, order: $order, isTerminal: $isTerminal, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $TaskStatusModelCopyWith<$Res>  {
  factory $TaskStatusModelCopyWith(TaskStatusModel value, $Res Function(TaskStatusModel) _then) = _$TaskStatusModelCopyWithImpl;
@useResult
$Res call({
 String id, String code, String label, int order,@JsonKey(name: 'is_terminal') bool isTerminal, String color,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$TaskStatusModelCopyWithImpl<$Res>
    implements $TaskStatusModelCopyWith<$Res> {
  _$TaskStatusModelCopyWithImpl(this._self, this._then);

  final TaskStatusModel _self;
  final $Res Function(TaskStatusModel) _then;

/// Create a copy of TaskStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? label = null,Object? order = null,Object? isTerminal = null,Object? color = null,Object? isActive = null,}) {
  return _then(TaskStatusModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,isTerminal: null == isTerminal ? _self.isTerminal : isTerminal // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskStatusModel].
extension TaskStatusModelPatterns on TaskStatusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskStatusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskStatusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskStatusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String label,  int order, @JsonKey(name: 'is_terminal')  bool isTerminal,  String color, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskStatusModel() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.order,_that.isTerminal,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String label,  int order, @JsonKey(name: 'is_terminal')  bool isTerminal,  String color, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _TaskStatusModel():
return $default(_that.id,_that.code,_that.label,_that.order,_that.isTerminal,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String label,  int order, @JsonKey(name: 'is_terminal')  bool isTerminal,  String color, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _TaskStatusModel() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.order,_that.isTerminal,_that.color,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskStatusModel implements TaskStatusModel {
  const _TaskStatusModel({required this.id, required this.code, required this.label, required this.order, @JsonKey(name: 'is_terminal') required this.isTerminal, required this.color, @JsonKey(name: 'is_active') this.isActive = true});
  factory _TaskStatusModel.fromJson(Map<String, dynamic> json) => _$TaskStatusModelFromJson(json);

@override final  String id;
@override final  String code;
@override final  String label;
@override final  int order;
@override@JsonKey(name: 'is_terminal') final  bool isTerminal;
@override final  String color;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of TaskStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskStatusModelCopyWith<_TaskStatusModel> get copyWith => __$TaskStatusModelCopyWithImpl<_TaskStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskStatusModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.order, order) || other.order == order)&&(identical(other.isTerminal, isTerminal) || other.isTerminal == isTerminal)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,order,isTerminal,color,isActive);

@override
String toString() {
  return 'TaskStatusModel(id: $id, code: $code, label: $label, order: $order, isTerminal: $isTerminal, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$TaskStatusModelCopyWith<$Res> implements $TaskStatusModelCopyWith<$Res> {
  factory _$TaskStatusModelCopyWith(_TaskStatusModel value, $Res Function(_TaskStatusModel) _then) = __$TaskStatusModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String label, int order,@JsonKey(name: 'is_terminal') bool isTerminal, String color,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$TaskStatusModelCopyWithImpl<$Res>
    implements _$TaskStatusModelCopyWith<$Res> {
  __$TaskStatusModelCopyWithImpl(this._self, this._then);

  final _TaskStatusModel _self;
  final $Res Function(_TaskStatusModel) _then;

/// Create a copy of TaskStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? label = null,Object? order = null,Object? isTerminal = null,Object? color = null,Object? isActive = null,}) {
  return _then(_TaskStatusModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,isTerminal: null == isTerminal ? _self.isTerminal : isTerminal // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TaskPriorityModel {

 String get id; String get code; String get label; int get weight; String get color;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of TaskPriorityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskPriorityModelCopyWith<TaskPriorityModel> get copyWith => _$TaskPriorityModelCopyWithImpl<TaskPriorityModel>(this as TaskPriorityModel, _$identity);

  /// Serializes this TaskPriorityModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskPriorityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,weight,color,isActive);

@override
String toString() {
  return 'TaskPriorityModel(id: $id, code: $code, label: $label, weight: $weight, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $TaskPriorityModelCopyWith<$Res>  {
  factory $TaskPriorityModelCopyWith(TaskPriorityModel value, $Res Function(TaskPriorityModel) _then) = _$TaskPriorityModelCopyWithImpl;
@useResult
$Res call({
 String id, String code, String label, int weight, String color,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$TaskPriorityModelCopyWithImpl<$Res>
    implements $TaskPriorityModelCopyWith<$Res> {
  _$TaskPriorityModelCopyWithImpl(this._self, this._then);

  final TaskPriorityModel _self;
  final $Res Function(TaskPriorityModel) _then;

/// Create a copy of TaskPriorityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? label = null,Object? weight = null,Object? color = null,Object? isActive = null,}) {
  return _then(TaskPriorityModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskPriorityModel].
extension TaskPriorityModelPatterns on TaskPriorityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskPriorityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskPriorityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskPriorityModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskPriorityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskPriorityModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskPriorityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String label,  int weight,  String color, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskPriorityModel() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.weight,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String label,  int weight,  String color, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _TaskPriorityModel():
return $default(_that.id,_that.code,_that.label,_that.weight,_that.color,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String label,  int weight,  String color, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _TaskPriorityModel() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.weight,_that.color,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskPriorityModel implements TaskPriorityModel {
  const _TaskPriorityModel({required this.id, required this.code, required this.label, required this.weight, required this.color, @JsonKey(name: 'is_active') this.isActive = true});
  factory _TaskPriorityModel.fromJson(Map<String, dynamic> json) => _$TaskPriorityModelFromJson(json);

@override final  String id;
@override final  String code;
@override final  String label;
@override final  int weight;
@override final  String color;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of TaskPriorityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskPriorityModelCopyWith<_TaskPriorityModel> get copyWith => __$TaskPriorityModelCopyWithImpl<_TaskPriorityModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskPriorityModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskPriorityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.color, color) || other.color == color)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,weight,color,isActive);

@override
String toString() {
  return 'TaskPriorityModel(id: $id, code: $code, label: $label, weight: $weight, color: $color, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$TaskPriorityModelCopyWith<$Res> implements $TaskPriorityModelCopyWith<$Res> {
  factory _$TaskPriorityModelCopyWith(_TaskPriorityModel value, $Res Function(_TaskPriorityModel) _then) = __$TaskPriorityModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String label, int weight, String color,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$TaskPriorityModelCopyWithImpl<$Res>
    implements _$TaskPriorityModelCopyWith<$Res> {
  __$TaskPriorityModelCopyWithImpl(this._self, this._then);

  final _TaskPriorityModel _self;
  final $Res Function(_TaskPriorityModel) _then;

/// Create a copy of TaskPriorityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? label = null,Object? weight = null,Object? color = null,Object? isActive = null,}) {
  return _then(_TaskPriorityModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TaskStatusTransitionModel {

 String get id;@JsonKey(name: 'from_status_id') String get fromStatusId;@JsonKey(name: 'to_status_id') String get toStatusId;@JsonKey(name: 'required_permission') String? get requiredPermission;
/// Create a copy of TaskStatusTransitionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskStatusTransitionModelCopyWith<TaskStatusTransitionModel> get copyWith => _$TaskStatusTransitionModelCopyWithImpl<TaskStatusTransitionModel>(this as TaskStatusTransitionModel, _$identity);

  /// Serializes this TaskStatusTransitionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskStatusTransitionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromStatusId, fromStatusId) || other.fromStatusId == fromStatusId)&&(identical(other.toStatusId, toStatusId) || other.toStatusId == toStatusId)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromStatusId,toStatusId,requiredPermission);

@override
String toString() {
  return 'TaskStatusTransitionModel(id: $id, fromStatusId: $fromStatusId, toStatusId: $toStatusId, requiredPermission: $requiredPermission)';
}


}

/// @nodoc
abstract mixin class $TaskStatusTransitionModelCopyWith<$Res>  {
  factory $TaskStatusTransitionModelCopyWith(TaskStatusTransitionModel value, $Res Function(TaskStatusTransitionModel) _then) = _$TaskStatusTransitionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'from_status_id') String fromStatusId,@JsonKey(name: 'to_status_id') String toStatusId,@JsonKey(name: 'required_permission') String? requiredPermission
});




}
/// @nodoc
class _$TaskStatusTransitionModelCopyWithImpl<$Res>
    implements $TaskStatusTransitionModelCopyWith<$Res> {
  _$TaskStatusTransitionModelCopyWithImpl(this._self, this._then);

  final TaskStatusTransitionModel _self;
  final $Res Function(TaskStatusTransitionModel) _then;

/// Create a copy of TaskStatusTransitionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromStatusId = null,Object? toStatusId = null,Object? requiredPermission = freezed,}) {
  return _then(TaskStatusTransitionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromStatusId: null == fromStatusId ? _self.fromStatusId : fromStatusId // ignore: cast_nullable_to_non_nullable
as String,toStatusId: null == toStatusId ? _self.toStatusId : toStatusId // ignore: cast_nullable_to_non_nullable
as String,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskStatusTransitionModel].
extension TaskStatusTransitionModelPatterns on TaskStatusTransitionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskStatusTransitionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskStatusTransitionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskStatusTransitionModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskStatusTransitionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskStatusTransitionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskStatusTransitionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'from_status_id')  String fromStatusId, @JsonKey(name: 'to_status_id')  String toStatusId, @JsonKey(name: 'required_permission')  String? requiredPermission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskStatusTransitionModel() when $default != null:
return $default(_that.id,_that.fromStatusId,_that.toStatusId,_that.requiredPermission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'from_status_id')  String fromStatusId, @JsonKey(name: 'to_status_id')  String toStatusId, @JsonKey(name: 'required_permission')  String? requiredPermission)  $default,) {final _that = this;
switch (_that) {
case _TaskStatusTransitionModel():
return $default(_that.id,_that.fromStatusId,_that.toStatusId,_that.requiredPermission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'from_status_id')  String fromStatusId, @JsonKey(name: 'to_status_id')  String toStatusId, @JsonKey(name: 'required_permission')  String? requiredPermission)?  $default,) {final _that = this;
switch (_that) {
case _TaskStatusTransitionModel() when $default != null:
return $default(_that.id,_that.fromStatusId,_that.toStatusId,_that.requiredPermission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskStatusTransitionModel implements TaskStatusTransitionModel {
  const _TaskStatusTransitionModel({required this.id, @JsonKey(name: 'from_status_id') required this.fromStatusId, @JsonKey(name: 'to_status_id') required this.toStatusId, @JsonKey(name: 'required_permission') this.requiredPermission});
  factory _TaskStatusTransitionModel.fromJson(Map<String, dynamic> json) => _$TaskStatusTransitionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'from_status_id') final  String fromStatusId;
@override@JsonKey(name: 'to_status_id') final  String toStatusId;
@override@JsonKey(name: 'required_permission') final  String? requiredPermission;

/// Create a copy of TaskStatusTransitionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskStatusTransitionModelCopyWith<_TaskStatusTransitionModel> get copyWith => __$TaskStatusTransitionModelCopyWithImpl<_TaskStatusTransitionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskStatusTransitionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskStatusTransitionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromStatusId, fromStatusId) || other.fromStatusId == fromStatusId)&&(identical(other.toStatusId, toStatusId) || other.toStatusId == toStatusId)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromStatusId,toStatusId,requiredPermission);

@override
String toString() {
  return 'TaskStatusTransitionModel(id: $id, fromStatusId: $fromStatusId, toStatusId: $toStatusId, requiredPermission: $requiredPermission)';
}


}

/// @nodoc
abstract mixin class _$TaskStatusTransitionModelCopyWith<$Res> implements $TaskStatusTransitionModelCopyWith<$Res> {
  factory _$TaskStatusTransitionModelCopyWith(_TaskStatusTransitionModel value, $Res Function(_TaskStatusTransitionModel) _then) = __$TaskStatusTransitionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'from_status_id') String fromStatusId,@JsonKey(name: 'to_status_id') String toStatusId,@JsonKey(name: 'required_permission') String? requiredPermission
});




}
/// @nodoc
class __$TaskStatusTransitionModelCopyWithImpl<$Res>
    implements _$TaskStatusTransitionModelCopyWith<$Res> {
  __$TaskStatusTransitionModelCopyWithImpl(this._self, this._then);

  final _TaskStatusTransitionModel _self;
  final $Res Function(_TaskStatusTransitionModel) _then;

/// Create a copy of TaskStatusTransitionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromStatusId = null,Object? toStatusId = null,Object? requiredPermission = freezed,}) {
  return _then(_TaskStatusTransitionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromStatusId: null == fromStatusId ? _self.fromStatusId : fromStatusId // ignore: cast_nullable_to_non_nullable
as String,toStatusId: null == toStatusId ? _self.toStatusId : toStatusId // ignore: cast_nullable_to_non_nullable
as String,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TaskItemModel {

 String get id; String get title; TaskPriorityModel get priority; TaskStatusModel get status; UserBriefModel get assigner;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; String? get description;@JsonKey(name: 'department_id') String? get departmentId;@JsonKey(name: 'department_name') String? get departmentName;@JsonKey(name: 'client_id') String? get clientId;@JsonKey(name: 'client_name') String? get clientName;@JsonKey(name: 'project_id') String? get projectId;@JsonKey(name: 'project_name') String? get projectName; List<UserBriefModel> get assignees;@JsonKey(name: 'due_at') DateTime? get dueAt;@JsonKey(name: 'completed_at') DateTime? get completedAt;@JsonKey(name: 'is_overdue') bool get isOverdue;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'comments_count') int get commentsCount;@JsonKey(name: 'attachments_count') int get attachmentsCount;
/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskItemModelCopyWith<TaskItemModel> get copyWith => _$TaskItemModelCopyWithImpl<TaskItemModel>(this as TaskItemModel, _$identity);

  /// Serializes this TaskItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.assigner, assigner) || other.assigner == assigner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&const DeepCollectionEquality().equals(other.assignees, assignees)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.attachmentsCount, attachmentsCount) || other.attachmentsCount == attachmentsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,priority,status,assigner,createdAt,updatedAt,description,departmentId,departmentName,clientId,clientName,projectId,projectName,const DeepCollectionEquality().hash(assignees),dueAt,completedAt,isOverdue,isActive,commentsCount,attachmentsCount]);

@override
String toString() {
  return 'TaskItemModel(id: $id, title: $title, priority: $priority, status: $status, assigner: $assigner, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, departmentId: $departmentId, departmentName: $departmentName, clientId: $clientId, clientName: $clientName, projectId: $projectId, projectName: $projectName, assignees: $assignees, dueAt: $dueAt, completedAt: $completedAt, isOverdue: $isOverdue, isActive: $isActive, commentsCount: $commentsCount, attachmentsCount: $attachmentsCount)';
}


}

/// @nodoc
abstract mixin class $TaskItemModelCopyWith<$Res>  {
  factory $TaskItemModelCopyWith(TaskItemModel value, $Res Function(TaskItemModel) _then) = _$TaskItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, TaskPriorityModel priority, TaskStatusModel status, UserBriefModel assigner,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, String? description,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'project_id') String? projectId,@JsonKey(name: 'project_name') String? projectName, List<UserBriefModel> assignees,@JsonKey(name: 'due_at') DateTime? dueAt,@JsonKey(name: 'completed_at') DateTime? completedAt,@JsonKey(name: 'is_overdue') bool isOverdue,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'comments_count') int commentsCount,@JsonKey(name: 'attachments_count') int attachmentsCount
});


$TaskPriorityModelCopyWith<$Res> get priority;$TaskStatusModelCopyWith<$Res> get status;$UserBriefModelCopyWith<$Res> get assigner;

}
/// @nodoc
class _$TaskItemModelCopyWithImpl<$Res>
    implements $TaskItemModelCopyWith<$Res> {
  _$TaskItemModelCopyWithImpl(this._self, this._then);

  final TaskItemModel _self;
  final $Res Function(TaskItemModel) _then;

/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? priority = null,Object? status = null,Object? assigner = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? projectId = freezed,Object? projectName = freezed,Object? assignees = null,Object? dueAt = freezed,Object? completedAt = freezed,Object? isOverdue = null,Object? isActive = null,Object? commentsCount = null,Object? attachmentsCount = null,}) {
  return _then(TaskItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriorityModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatusModel,assigner: null == assigner ? _self.assigner : assigner // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,assignees: null == assignees ? _self.assignees : assignees // ignore: cast_nullable_to_non_nullable
as List<UserBriefModel>,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,attachmentsCount: null == attachmentsCount ? _self.attachmentsCount : attachmentsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskPriorityModelCopyWith<$Res> get priority {
  
  return $TaskPriorityModelCopyWith<$Res>(_self.priority, (value) {
    return _then(_self.copyWith(priority: value));
  });
}/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskStatusModelCopyWith<$Res> get status {
  
  return $TaskStatusModelCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get assigner {
  
  return $UserBriefModelCopyWith<$Res>(_self.assigner, (value) {
    return _then(_self.copyWith(assigner: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskItemModel].
extension TaskItemModelPatterns on TaskItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskItemModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  TaskPriorityModel priority,  TaskStatusModel status,  UserBriefModel assigner, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  String? description, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName,  List<UserBriefModel> assignees, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'is_overdue')  bool isOverdue, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'comments_count')  int commentsCount, @JsonKey(name: 'attachments_count')  int attachmentsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskItemModel() when $default != null:
return $default(_that.id,_that.title,_that.priority,_that.status,_that.assigner,_that.createdAt,_that.updatedAt,_that.description,_that.departmentId,_that.departmentName,_that.clientId,_that.clientName,_that.projectId,_that.projectName,_that.assignees,_that.dueAt,_that.completedAt,_that.isOverdue,_that.isActive,_that.commentsCount,_that.attachmentsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  TaskPriorityModel priority,  TaskStatusModel status,  UserBriefModel assigner, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  String? description, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName,  List<UserBriefModel> assignees, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'is_overdue')  bool isOverdue, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'comments_count')  int commentsCount, @JsonKey(name: 'attachments_count')  int attachmentsCount)  $default,) {final _that = this;
switch (_that) {
case _TaskItemModel():
return $default(_that.id,_that.title,_that.priority,_that.status,_that.assigner,_that.createdAt,_that.updatedAt,_that.description,_that.departmentId,_that.departmentName,_that.clientId,_that.clientName,_that.projectId,_that.projectName,_that.assignees,_that.dueAt,_that.completedAt,_that.isOverdue,_that.isActive,_that.commentsCount,_that.attachmentsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  TaskPriorityModel priority,  TaskStatusModel status,  UserBriefModel assigner, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  String? description, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName,  List<UserBriefModel> assignees, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'is_overdue')  bool isOverdue, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'comments_count')  int commentsCount, @JsonKey(name: 'attachments_count')  int attachmentsCount)?  $default,) {final _that = this;
switch (_that) {
case _TaskItemModel() when $default != null:
return $default(_that.id,_that.title,_that.priority,_that.status,_that.assigner,_that.createdAt,_that.updatedAt,_that.description,_that.departmentId,_that.departmentName,_that.clientId,_that.clientName,_that.projectId,_that.projectName,_that.assignees,_that.dueAt,_that.completedAt,_that.isOverdue,_that.isActive,_that.commentsCount,_that.attachmentsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskItemModel implements TaskItemModel {
  const _TaskItemModel({required this.id, required this.title, required this.priority, required this.status, required this.assigner, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, this.description, @JsonKey(name: 'department_id') this.departmentId, @JsonKey(name: 'department_name') this.departmentName, @JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'client_name') this.clientName, @JsonKey(name: 'project_id') this.projectId, @JsonKey(name: 'project_name') this.projectName,  List<UserBriefModel> assignees = const <UserBriefModel>[], @JsonKey(name: 'due_at') this.dueAt, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'is_overdue') this.isOverdue = false, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'comments_count') this.commentsCount = 0, @JsonKey(name: 'attachments_count') this.attachmentsCount = 0}): _assignees = assignees;
  factory _TaskItemModel.fromJson(Map<String, dynamic> json) => _$TaskItemModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  TaskPriorityModel priority;
@override final  TaskStatusModel status;
@override final  UserBriefModel assigner;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override final  String? description;
@override@JsonKey(name: 'department_id') final  String? departmentId;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override@JsonKey(name: 'client_id') final  String? clientId;
@override@JsonKey(name: 'client_name') final  String? clientName;
@override@JsonKey(name: 'project_id') final  String? projectId;
@override@JsonKey(name: 'project_name') final  String? projectName;
 final  List<UserBriefModel> _assignees;
@override@JsonKey() List<UserBriefModel> get assignees {
  if (_assignees is EqualUnmodifiableListView) return _assignees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignees);
}

@override@JsonKey(name: 'due_at') final  DateTime? dueAt;
@override@JsonKey(name: 'completed_at') final  DateTime? completedAt;
@override@JsonKey(name: 'is_overdue') final  bool isOverdue;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'comments_count') final  int commentsCount;
@override@JsonKey(name: 'attachments_count') final  int attachmentsCount;

/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskItemModelCopyWith<_TaskItemModel> get copyWith => __$TaskItemModelCopyWithImpl<_TaskItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.assigner, assigner) || other.assigner == assigner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&const DeepCollectionEquality().equals(other._assignees, _assignees)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.attachmentsCount, attachmentsCount) || other.attachmentsCount == attachmentsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,priority,status,assigner,createdAt,updatedAt,description,departmentId,departmentName,clientId,clientName,projectId,projectName,const DeepCollectionEquality().hash(_assignees),dueAt,completedAt,isOverdue,isActive,commentsCount,attachmentsCount]);

@override
String toString() {
  return 'TaskItemModel(id: $id, title: $title, priority: $priority, status: $status, assigner: $assigner, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, departmentId: $departmentId, departmentName: $departmentName, clientId: $clientId, clientName: $clientName, projectId: $projectId, projectName: $projectName, assignees: $assignees, dueAt: $dueAt, completedAt: $completedAt, isOverdue: $isOverdue, isActive: $isActive, commentsCount: $commentsCount, attachmentsCount: $attachmentsCount)';
}


}

/// @nodoc
abstract mixin class _$TaskItemModelCopyWith<$Res> implements $TaskItemModelCopyWith<$Res> {
  factory _$TaskItemModelCopyWith(_TaskItemModel value, $Res Function(_TaskItemModel) _then) = __$TaskItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, TaskPriorityModel priority, TaskStatusModel status, UserBriefModel assigner,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, String? description,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'project_id') String? projectId,@JsonKey(name: 'project_name') String? projectName, List<UserBriefModel> assignees,@JsonKey(name: 'due_at') DateTime? dueAt,@JsonKey(name: 'completed_at') DateTime? completedAt,@JsonKey(name: 'is_overdue') bool isOverdue,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'comments_count') int commentsCount,@JsonKey(name: 'attachments_count') int attachmentsCount
});


@override $TaskPriorityModelCopyWith<$Res> get priority;@override $TaskStatusModelCopyWith<$Res> get status;@override $UserBriefModelCopyWith<$Res> get assigner;

}
/// @nodoc
class __$TaskItemModelCopyWithImpl<$Res>
    implements _$TaskItemModelCopyWith<$Res> {
  __$TaskItemModelCopyWithImpl(this._self, this._then);

  final _TaskItemModel _self;
  final $Res Function(_TaskItemModel) _then;

/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? priority = null,Object? status = null,Object? assigner = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? projectId = freezed,Object? projectName = freezed,Object? assignees = null,Object? dueAt = freezed,Object? completedAt = freezed,Object? isOverdue = null,Object? isActive = null,Object? commentsCount = null,Object? attachmentsCount = null,}) {
  return _then(_TaskItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriorityModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatusModel,assigner: null == assigner ? _self.assigner : assigner // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,assignees: null == assignees ? _self._assignees : assignees // ignore: cast_nullable_to_non_nullable
as List<UserBriefModel>,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,attachmentsCount: null == attachmentsCount ? _self.attachmentsCount : attachmentsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskPriorityModelCopyWith<$Res> get priority {
  
  return $TaskPriorityModelCopyWith<$Res>(_self.priority, (value) {
    return _then(_self.copyWith(priority: value));
  });
}/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskStatusModelCopyWith<$Res> get status {
  
  return $TaskStatusModelCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TaskItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get assigner {
  
  return $UserBriefModelCopyWith<$Res>(_self.assigner, (value) {
    return _then(_self.copyWith(assigner: value));
  });
}
}


/// @nodoc
mixin _$TaskPageResponse {

 List<TaskItemModel> get items; int get total; int get page;@JsonKey(name: 'page_size') int get pageSize; int get pages;
/// Create a copy of TaskPageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskPageResponseCopyWith<TaskPageResponse> get copyWith => _$TaskPageResponseCopyWithImpl<TaskPageResponse>(this as TaskPageResponse, _$identity);

  /// Serializes this TaskPageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskPageResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,pageSize,pages);

@override
String toString() {
  return 'TaskPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $TaskPageResponseCopyWith<$Res>  {
  factory $TaskPageResponseCopyWith(TaskPageResponse value, $Res Function(TaskPageResponse) _then) = _$TaskPageResponseCopyWithImpl;
@useResult
$Res call({
 List<TaskItemModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize, int pages
});




}
/// @nodoc
class _$TaskPageResponseCopyWithImpl<$Res>
    implements $TaskPageResponseCopyWith<$Res> {
  _$TaskPageResponseCopyWithImpl(this._self, this._then);

  final TaskPageResponse _self;
  final $Res Function(TaskPageResponse) _then;

/// Create a copy of TaskPageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? pages = null,}) {
  return _then(TaskPageResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TaskItemModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskPageResponse].
extension TaskPageResponsePatterns on TaskPageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskPageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskPageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskPageResponse value)  $default,){
final _that = this;
switch (_that) {
case _TaskPageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskPageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TaskPageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TaskItemModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize,  int pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TaskItemModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize,  int pages)  $default,) {final _that = this;
switch (_that) {
case _TaskPageResponse():
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TaskItemModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize,  int pages)?  $default,) {final _that = this;
switch (_that) {
case _TaskPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskPageResponse implements TaskPageResponse {
  const _TaskPageResponse({required  List<TaskItemModel> items, required this.total, required this.page, @JsonKey(name: 'page_size') required this.pageSize, this.pages = 1}): _items = items;
  factory _TaskPageResponse.fromJson(Map<String, dynamic> json) => _$TaskPageResponseFromJson(json);

 final  List<TaskItemModel> _items;
@override List<TaskItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override final  int page;
@override@JsonKey(name: 'page_size') final  int pageSize;
@override@JsonKey() final  int pages;

/// Create a copy of TaskPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskPageResponseCopyWith<_TaskPageResponse> get copyWith => __$TaskPageResponseCopyWithImpl<_TaskPageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskPageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskPageResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,pageSize,pages);

@override
String toString() {
  return 'TaskPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$TaskPageResponseCopyWith<$Res> implements $TaskPageResponseCopyWith<$Res> {
  factory _$TaskPageResponseCopyWith(_TaskPageResponse value, $Res Function(_TaskPageResponse) _then) = __$TaskPageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TaskItemModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize, int pages
});




}
/// @nodoc
class __$TaskPageResponseCopyWithImpl<$Res>
    implements _$TaskPageResponseCopyWith<$Res> {
  __$TaskPageResponseCopyWithImpl(this._self, this._then);

  final _TaskPageResponse _self;
  final $Res Function(_TaskPageResponse) _then;

/// Create a copy of TaskPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? pages = null,}) {
  return _then(_TaskPageResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TaskItemModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TaskCommentModel {

 String get id;@JsonKey(name: 'task_id') String get taskId; UserBriefModel get author; String get comment;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of TaskCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCommentModelCopyWith<TaskCommentModel> get copyWith => _$TaskCommentModelCopyWithImpl<TaskCommentModel>(this as TaskCommentModel, _$identity);

  /// Serializes this TaskCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.author, author) || other.author == author)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,author,comment,createdAt);

@override
String toString() {
  return 'TaskCommentModel(id: $id, taskId: $taskId, author: $author, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TaskCommentModelCopyWith<$Res>  {
  factory $TaskCommentModelCopyWith(TaskCommentModel value, $Res Function(TaskCommentModel) _then) = _$TaskCommentModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId, UserBriefModel author, String comment,@JsonKey(name: 'created_at') DateTime createdAt
});


$UserBriefModelCopyWith<$Res> get author;

}
/// @nodoc
class _$TaskCommentModelCopyWithImpl<$Res>
    implements $TaskCommentModelCopyWith<$Res> {
  _$TaskCommentModelCopyWithImpl(this._self, this._then);

  final TaskCommentModel _self;
  final $Res Function(TaskCommentModel) _then;

/// Create a copy of TaskCommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? author = null,Object? comment = null,Object? createdAt = null,}) {
  return _then(TaskCommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as UserBriefModel,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of TaskCommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get author {
  
  return $UserBriefModelCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskCommentModel].
extension TaskCommentModelPatterns on TaskCommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskCommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskCommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskCommentModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskCommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskCommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskCommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId,  UserBriefModel author,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskCommentModel() when $default != null:
return $default(_that.id,_that.taskId,_that.author,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId,  UserBriefModel author,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TaskCommentModel():
return $default(_that.id,_that.taskId,_that.author,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'task_id')  String taskId,  UserBriefModel author,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskCommentModel() when $default != null:
return $default(_that.id,_that.taskId,_that.author,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskCommentModel implements TaskCommentModel {
  const _TaskCommentModel({required this.id, @JsonKey(name: 'task_id') required this.taskId, required this.author, required this.comment, @JsonKey(name: 'created_at') required this.createdAt});
  factory _TaskCommentModel.fromJson(Map<String, dynamic> json) => _$TaskCommentModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'task_id') final  String taskId;
@override final  UserBriefModel author;
@override final  String comment;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of TaskCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCommentModelCopyWith<_TaskCommentModel> get copyWith => __$TaskCommentModelCopyWithImpl<_TaskCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.author, author) || other.author == author)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,author,comment,createdAt);

@override
String toString() {
  return 'TaskCommentModel(id: $id, taskId: $taskId, author: $author, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCommentModelCopyWith<$Res> implements $TaskCommentModelCopyWith<$Res> {
  factory _$TaskCommentModelCopyWith(_TaskCommentModel value, $Res Function(_TaskCommentModel) _then) = __$TaskCommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId, UserBriefModel author, String comment,@JsonKey(name: 'created_at') DateTime createdAt
});


@override $UserBriefModelCopyWith<$Res> get author;

}
/// @nodoc
class __$TaskCommentModelCopyWithImpl<$Res>
    implements _$TaskCommentModelCopyWith<$Res> {
  __$TaskCommentModelCopyWithImpl(this._self, this._then);

  final _TaskCommentModel _self;
  final $Res Function(_TaskCommentModel) _then;

/// Create a copy of TaskCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? author = null,Object? comment = null,Object? createdAt = null,}) {
  return _then(_TaskCommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as UserBriefModel,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of TaskCommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get author {
  
  return $UserBriefModelCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$TaskAttachmentModel {

 String get id;@JsonKey(name: 'task_id') String get taskId;@JsonKey(name: 'file_name') String get fileName;@JsonKey(name: 'file_size_bytes') int get fileSizeBytes;@JsonKey(name: 'mime_type') String get mimeType;@JsonKey(name: 'download_url') String get downloadUrl; UserBriefModel get uploader;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of TaskAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskAttachmentModelCopyWith<TaskAttachmentModel> get copyWith => _$TaskAttachmentModelCopyWithImpl<TaskAttachmentModel>(this as TaskAttachmentModel, _$identity);

  /// Serializes this TaskAttachmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskAttachmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.uploader, uploader) || other.uploader == uploader)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,fileName,fileSizeBytes,mimeType,downloadUrl,uploader,createdAt);

@override
String toString() {
  return 'TaskAttachmentModel(id: $id, taskId: $taskId, fileName: $fileName, fileSizeBytes: $fileSizeBytes, mimeType: $mimeType, downloadUrl: $downloadUrl, uploader: $uploader, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TaskAttachmentModelCopyWith<$Res>  {
  factory $TaskAttachmentModelCopyWith(TaskAttachmentModel value, $Res Function(TaskAttachmentModel) _then) = _$TaskAttachmentModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_size_bytes') int fileSizeBytes,@JsonKey(name: 'mime_type') String mimeType,@JsonKey(name: 'download_url') String downloadUrl, UserBriefModel uploader,@JsonKey(name: 'created_at') DateTime createdAt
});


$UserBriefModelCopyWith<$Res> get uploader;

}
/// @nodoc
class _$TaskAttachmentModelCopyWithImpl<$Res>
    implements $TaskAttachmentModelCopyWith<$Res> {
  _$TaskAttachmentModelCopyWithImpl(this._self, this._then);

  final TaskAttachmentModel _self;
  final $Res Function(TaskAttachmentModel) _then;

/// Create a copy of TaskAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? fileName = null,Object? fileSizeBytes = null,Object? mimeType = null,Object? downloadUrl = null,Object? uploader = null,Object? createdAt = null,}) {
  return _then(TaskAttachmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,uploader: null == uploader ? _self.uploader : uploader // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of TaskAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get uploader {
  
  return $UserBriefModelCopyWith<$Res>(_self.uploader, (value) {
    return _then(_self.copyWith(uploader: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskAttachmentModel].
extension TaskAttachmentModelPatterns on TaskAttachmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskAttachmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskAttachmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskAttachmentModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskAttachmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskAttachmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskAttachmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size_bytes')  int fileSizeBytes, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'download_url')  String downloadUrl,  UserBriefModel uploader, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskAttachmentModel() when $default != null:
return $default(_that.id,_that.taskId,_that.fileName,_that.fileSizeBytes,_that.mimeType,_that.downloadUrl,_that.uploader,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size_bytes')  int fileSizeBytes, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'download_url')  String downloadUrl,  UserBriefModel uploader, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TaskAttachmentModel():
return $default(_that.id,_that.taskId,_that.fileName,_that.fileSizeBytes,_that.mimeType,_that.downloadUrl,_that.uploader,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size_bytes')  int fileSizeBytes, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'download_url')  String downloadUrl,  UserBriefModel uploader, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskAttachmentModel() when $default != null:
return $default(_that.id,_that.taskId,_that.fileName,_that.fileSizeBytes,_that.mimeType,_that.downloadUrl,_that.uploader,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskAttachmentModel implements TaskAttachmentModel {
  const _TaskAttachmentModel({required this.id, @JsonKey(name: 'task_id') required this.taskId, @JsonKey(name: 'file_name') required this.fileName, @JsonKey(name: 'file_size_bytes') required this.fileSizeBytes, @JsonKey(name: 'mime_type') required this.mimeType, @JsonKey(name: 'download_url') required this.downloadUrl, required this.uploader, @JsonKey(name: 'created_at') required this.createdAt});
  factory _TaskAttachmentModel.fromJson(Map<String, dynamic> json) => _$TaskAttachmentModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'task_id') final  String taskId;
@override@JsonKey(name: 'file_name') final  String fileName;
@override@JsonKey(name: 'file_size_bytes') final  int fileSizeBytes;
@override@JsonKey(name: 'mime_type') final  String mimeType;
@override@JsonKey(name: 'download_url') final  String downloadUrl;
@override final  UserBriefModel uploader;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of TaskAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskAttachmentModelCopyWith<_TaskAttachmentModel> get copyWith => __$TaskAttachmentModelCopyWithImpl<_TaskAttachmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskAttachmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskAttachmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.uploader, uploader) || other.uploader == uploader)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,fileName,fileSizeBytes,mimeType,downloadUrl,uploader,createdAt);

@override
String toString() {
  return 'TaskAttachmentModel(id: $id, taskId: $taskId, fileName: $fileName, fileSizeBytes: $fileSizeBytes, mimeType: $mimeType, downloadUrl: $downloadUrl, uploader: $uploader, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TaskAttachmentModelCopyWith<$Res> implements $TaskAttachmentModelCopyWith<$Res> {
  factory _$TaskAttachmentModelCopyWith(_TaskAttachmentModel value, $Res Function(_TaskAttachmentModel) _then) = __$TaskAttachmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_size_bytes') int fileSizeBytes,@JsonKey(name: 'mime_type') String mimeType,@JsonKey(name: 'download_url') String downloadUrl, UserBriefModel uploader,@JsonKey(name: 'created_at') DateTime createdAt
});


@override $UserBriefModelCopyWith<$Res> get uploader;

}
/// @nodoc
class __$TaskAttachmentModelCopyWithImpl<$Res>
    implements _$TaskAttachmentModelCopyWith<$Res> {
  __$TaskAttachmentModelCopyWithImpl(this._self, this._then);

  final _TaskAttachmentModel _self;
  final $Res Function(_TaskAttachmentModel) _then;

/// Create a copy of TaskAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? fileName = null,Object? fileSizeBytes = null,Object? mimeType = null,Object? downloadUrl = null,Object? uploader = null,Object? createdAt = null,}) {
  return _then(_TaskAttachmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,uploader: null == uploader ? _self.uploader : uploader // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of TaskAttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get uploader {
  
  return $UserBriefModelCopyWith<$Res>(_self.uploader, (value) {
    return _then(_self.copyWith(uploader: value));
  });
}
}


/// @nodoc
mixin _$TaskActivityModel {

 String get id;@JsonKey(name: 'task_id') String get taskId; String get action; UserBriefModel get actor;@JsonKey(name: 'created_at') DateTime get createdAt; Map<String, dynamic> get details;
/// Create a copy of TaskActivityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskActivityModelCopyWith<TaskActivityModel> get copyWith => _$TaskActivityModelCopyWithImpl<TaskActivityModel>(this as TaskActivityModel, _$identity);

  /// Serializes this TaskActivityModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskActivityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.action, action) || other.action == action)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.details, details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,action,actor,createdAt,const DeepCollectionEquality().hash(details));

@override
String toString() {
  return 'TaskActivityModel(id: $id, taskId: $taskId, action: $action, actor: $actor, createdAt: $createdAt, details: $details)';
}


}

/// @nodoc
abstract mixin class $TaskActivityModelCopyWith<$Res>  {
  factory $TaskActivityModelCopyWith(TaskActivityModel value, $Res Function(TaskActivityModel) _then) = _$TaskActivityModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId, String action, UserBriefModel actor,@JsonKey(name: 'created_at') DateTime createdAt, Map<String, dynamic> details
});


$UserBriefModelCopyWith<$Res> get actor;

}
/// @nodoc
class _$TaskActivityModelCopyWithImpl<$Res>
    implements $TaskActivityModelCopyWith<$Res> {
  _$TaskActivityModelCopyWithImpl(this._self, this._then);

  final TaskActivityModel _self;
  final $Res Function(TaskActivityModel) _then;

/// Create a copy of TaskActivityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? action = null,Object? actor = null,Object? createdAt = null,Object? details = null,}) {
  return _then(TaskActivityModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of TaskActivityModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get actor {
  
  return $UserBriefModelCopyWith<$Res>(_self.actor, (value) {
    return _then(_self.copyWith(actor: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskActivityModel].
extension TaskActivityModelPatterns on TaskActivityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskActivityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskActivityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskActivityModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskActivityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskActivityModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskActivityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId,  String action,  UserBriefModel actor, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic> details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskActivityModel() when $default != null:
return $default(_that.id,_that.taskId,_that.action,_that.actor,_that.createdAt,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId,  String action,  UserBriefModel actor, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic> details)  $default,) {final _that = this;
switch (_that) {
case _TaskActivityModel():
return $default(_that.id,_that.taskId,_that.action,_that.actor,_that.createdAt,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'task_id')  String taskId,  String action,  UserBriefModel actor, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic> details)?  $default,) {final _that = this;
switch (_that) {
case _TaskActivityModel() when $default != null:
return $default(_that.id,_that.taskId,_that.action,_that.actor,_that.createdAt,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskActivityModel implements TaskActivityModel {
  const _TaskActivityModel({required this.id, @JsonKey(name: 'task_id') required this.taskId, required this.action, required this.actor, @JsonKey(name: 'created_at') required this.createdAt,  Map<String, dynamic> details = const <String, dynamic>{}}): _details = details;
  factory _TaskActivityModel.fromJson(Map<String, dynamic> json) => _$TaskActivityModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'task_id') final  String taskId;
@override final  String action;
@override final  UserBriefModel actor;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
 final  Map<String, dynamic> _details;
@override@JsonKey() Map<String, dynamic> get details {
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_details);
}


/// Create a copy of TaskActivityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskActivityModelCopyWith<_TaskActivityModel> get copyWith => __$TaskActivityModelCopyWithImpl<_TaskActivityModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskActivityModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskActivityModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.action, action) || other.action == action)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._details, _details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,action,actor,createdAt,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'TaskActivityModel(id: $id, taskId: $taskId, action: $action, actor: $actor, createdAt: $createdAt, details: $details)';
}


}

/// @nodoc
abstract mixin class _$TaskActivityModelCopyWith<$Res> implements $TaskActivityModelCopyWith<$Res> {
  factory _$TaskActivityModelCopyWith(_TaskActivityModel value, $Res Function(_TaskActivityModel) _then) = __$TaskActivityModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId, String action, UserBriefModel actor,@JsonKey(name: 'created_at') DateTime createdAt, Map<String, dynamic> details
});


@override $UserBriefModelCopyWith<$Res> get actor;

}
/// @nodoc
class __$TaskActivityModelCopyWithImpl<$Res>
    implements _$TaskActivityModelCopyWith<$Res> {
  __$TaskActivityModelCopyWithImpl(this._self, this._then);

  final _TaskActivityModel _self;
  final $Res Function(_TaskActivityModel) _then;

/// Create a copy of TaskActivityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? action = null,Object? actor = null,Object? createdAt = null,Object? details = null,}) {
  return _then(_TaskActivityModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,details: null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of TaskActivityModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get actor {
  
  return $UserBriefModelCopyWith<$Res>(_self.actor, (value) {
    return _then(_self.copyWith(actor: value));
  });
}
}


/// @nodoc
mixin _$DepartmentModel {

 String get id; String get name; String? get description;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of DepartmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentModelCopyWith<DepartmentModel> get copyWith => _$DepartmentModelCopyWithImpl<DepartmentModel>(this as DepartmentModel, _$identity);

  /// Serializes this DepartmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isActive);

@override
String toString() {
  return 'DepartmentModel(id: $id, name: $name, description: $description, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $DepartmentModelCopyWith<$Res>  {
  factory $DepartmentModelCopyWith(DepartmentModel value, $Res Function(DepartmentModel) _then) = _$DepartmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$DepartmentModelCopyWithImpl<$Res>
    implements $DepartmentModelCopyWith<$Res> {
  _$DepartmentModelCopyWithImpl(this._self, this._then);

  final DepartmentModel _self;
  final $Res Function(DepartmentModel) _then;

/// Create a copy of DepartmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? isActive = null,}) {
  return _then(DepartmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DepartmentModel].
extension DepartmentModelPatterns on DepartmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepartmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepartmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepartmentModel value)  $default,){
final _that = this;
switch (_that) {
case _DepartmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepartmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _DepartmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DepartmentModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _DepartmentModel():
return $default(_that.id,_that.name,_that.description,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _DepartmentModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DepartmentModel implements DepartmentModel {
  const _DepartmentModel({required this.id, required this.name, this.description, @JsonKey(name: 'is_active') this.isActive = true});
  factory _DepartmentModel.fromJson(Map<String, dynamic> json) => _$DepartmentModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of DepartmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentModelCopyWith<_DepartmentModel> get copyWith => __$DepartmentModelCopyWithImpl<_DepartmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isActive);

@override
String toString() {
  return 'DepartmentModel(id: $id, name: $name, description: $description, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$DepartmentModelCopyWith<$Res> implements $DepartmentModelCopyWith<$Res> {
  factory _$DepartmentModelCopyWith(_DepartmentModel value, $Res Function(_DepartmentModel) _then) = __$DepartmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$DepartmentModelCopyWithImpl<$Res>
    implements _$DepartmentModelCopyWith<$Res> {
  __$DepartmentModelCopyWithImpl(this._self, this._then);

  final _DepartmentModel _self;
  final $Res Function(_DepartmentModel) _then;

/// Create a copy of DepartmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? isActive = null,}) {
  return _then(_DepartmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClientBriefModel {

 String get id; String get name;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of ClientBriefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientBriefModelCopyWith<ClientBriefModel> get copyWith => _$ClientBriefModelCopyWithImpl<ClientBriefModel>(this as ClientBriefModel, _$identity);

  /// Serializes this ClientBriefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientBriefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isActive);

@override
String toString() {
  return 'ClientBriefModel(id: $id, name: $name, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ClientBriefModelCopyWith<$Res>  {
  factory $ClientBriefModelCopyWith(ClientBriefModel value, $Res Function(ClientBriefModel) _then) = _$ClientBriefModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$ClientBriefModelCopyWithImpl<$Res>
    implements $ClientBriefModelCopyWith<$Res> {
  _$ClientBriefModelCopyWithImpl(this._self, this._then);

  final ClientBriefModel _self;
  final $Res Function(ClientBriefModel) _then;

/// Create a copy of ClientBriefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isActive = null,}) {
  return _then(ClientBriefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientBriefModel].
extension ClientBriefModelPatterns on ClientBriefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientBriefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientBriefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientBriefModel value)  $default,){
final _that = this;
switch (_that) {
case _ClientBriefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientBriefModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClientBriefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientBriefModel() when $default != null:
return $default(_that.id,_that.name,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ClientBriefModel():
return $default(_that.id,_that.name,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ClientBriefModel() when $default != null:
return $default(_that.id,_that.name,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientBriefModel implements ClientBriefModel {
  const _ClientBriefModel({required this.id, required this.name, @JsonKey(name: 'is_active') this.isActive = true});
  factory _ClientBriefModel.fromJson(Map<String, dynamic> json) => _$ClientBriefModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of ClientBriefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientBriefModelCopyWith<_ClientBriefModel> get copyWith => __$ClientBriefModelCopyWithImpl<_ClientBriefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientBriefModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientBriefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isActive);

@override
String toString() {
  return 'ClientBriefModel(id: $id, name: $name, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ClientBriefModelCopyWith<$Res> implements $ClientBriefModelCopyWith<$Res> {
  factory _$ClientBriefModelCopyWith(_ClientBriefModel value, $Res Function(_ClientBriefModel) _then) = __$ClientBriefModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$ClientBriefModelCopyWithImpl<$Res>
    implements _$ClientBriefModelCopyWith<$Res> {
  __$ClientBriefModelCopyWithImpl(this._self, this._then);

  final _ClientBriefModel _self;
  final $Res Function(_ClientBriefModel) _then;

/// Create a copy of ClientBriefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isActive = null,}) {
  return _then(_ClientBriefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ProjectBriefModel {

 String get id; String get name;@JsonKey(name: 'client_id') String get clientId;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of ProjectBriefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectBriefModelCopyWith<ProjectBriefModel> get copyWith => _$ProjectBriefModelCopyWithImpl<ProjectBriefModel>(this as ProjectBriefModel, _$identity);

  /// Serializes this ProjectBriefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectBriefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,clientId,isActive);

@override
String toString() {
  return 'ProjectBriefModel(id: $id, name: $name, clientId: $clientId, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ProjectBriefModelCopyWith<$Res>  {
  factory $ProjectBriefModelCopyWith(ProjectBriefModel value, $Res Function(ProjectBriefModel) _then) = _$ProjectBriefModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'client_id') String clientId,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$ProjectBriefModelCopyWithImpl<$Res>
    implements $ProjectBriefModelCopyWith<$Res> {
  _$ProjectBriefModelCopyWithImpl(this._self, this._then);

  final ProjectBriefModel _self;
  final $Res Function(ProjectBriefModel) _then;

/// Create a copy of ProjectBriefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? clientId = null,Object? isActive = null,}) {
  return _then(ProjectBriefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectBriefModel].
extension ProjectBriefModelPatterns on ProjectBriefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectBriefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectBriefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectBriefModel value)  $default,){
final _that = this;
switch (_that) {
case _ProjectBriefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectBriefModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectBriefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'client_id')  String clientId, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectBriefModel() when $default != null:
return $default(_that.id,_that.name,_that.clientId,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'client_id')  String clientId, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ProjectBriefModel():
return $default(_that.id,_that.name,_that.clientId,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'client_id')  String clientId, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ProjectBriefModel() when $default != null:
return $default(_that.id,_that.name,_that.clientId,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectBriefModel implements ProjectBriefModel {
  const _ProjectBriefModel({required this.id, required this.name, @JsonKey(name: 'client_id') required this.clientId, @JsonKey(name: 'is_active') this.isActive = true});
  factory _ProjectBriefModel.fromJson(Map<String, dynamic> json) => _$ProjectBriefModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'client_id') final  String clientId;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of ProjectBriefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectBriefModelCopyWith<_ProjectBriefModel> get copyWith => __$ProjectBriefModelCopyWithImpl<_ProjectBriefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectBriefModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectBriefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,clientId,isActive);

@override
String toString() {
  return 'ProjectBriefModel(id: $id, name: $name, clientId: $clientId, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ProjectBriefModelCopyWith<$Res> implements $ProjectBriefModelCopyWith<$Res> {
  factory _$ProjectBriefModelCopyWith(_ProjectBriefModel value, $Res Function(_ProjectBriefModel) _then) = __$ProjectBriefModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'client_id') String clientId,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$ProjectBriefModelCopyWithImpl<$Res>
    implements _$ProjectBriefModelCopyWith<$Res> {
  __$ProjectBriefModelCopyWithImpl(this._self, this._then);

  final _ProjectBriefModel _self;
  final $Res Function(_ProjectBriefModel) _then;

/// Create a copy of ProjectBriefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? clientId = null,Object? isActive = null,}) {
  return _then(_ProjectBriefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TaskFilterState {

 String? get statusId; String? get priorityId; String? get departmentId; String? get clientId; String? get projectId; bool? get isOverdue; DateTime? get dueFrom; DateTime? get dueTo; String? get search; String get sortBy; bool get sortDesc;
/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFilterStateCopyWith<TaskFilterState> get copyWith => _$TaskFilterStateCopyWithImpl<TaskFilterState>(this as TaskFilterState, _$identity);

  /// Serializes this TaskFilterState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFilterState&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.priorityId, priorityId) || other.priorityId == priorityId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.dueFrom, dueFrom) || other.dueFrom == dueFrom)&&(identical(other.dueTo, dueTo) || other.dueTo == dueTo)&&(identical(other.search, search) || other.search == search)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortDesc, sortDesc) || other.sortDesc == sortDesc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusId,priorityId,departmentId,clientId,projectId,isOverdue,dueFrom,dueTo,search,sortBy,sortDesc);

@override
String toString() {
  return 'TaskFilterState(statusId: $statusId, priorityId: $priorityId, departmentId: $departmentId, clientId: $clientId, projectId: $projectId, isOverdue: $isOverdue, dueFrom: $dueFrom, dueTo: $dueTo, search: $search, sortBy: $sortBy, sortDesc: $sortDesc)';
}


}

/// @nodoc
abstract mixin class $TaskFilterStateCopyWith<$Res>  {
  factory $TaskFilterStateCopyWith(TaskFilterState value, $Res Function(TaskFilterState) _then) = _$TaskFilterStateCopyWithImpl;
@useResult
$Res call({
 String? statusId, String? priorityId, String? departmentId, String? clientId, String? projectId, bool? isOverdue, DateTime? dueFrom, DateTime? dueTo, String? search, String sortBy, bool sortDesc
});




}
/// @nodoc
class _$TaskFilterStateCopyWithImpl<$Res>
    implements $TaskFilterStateCopyWith<$Res> {
  _$TaskFilterStateCopyWithImpl(this._self, this._then);

  final TaskFilterState _self;
  final $Res Function(TaskFilterState) _then;

/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusId = freezed,Object? priorityId = freezed,Object? departmentId = freezed,Object? clientId = freezed,Object? projectId = freezed,Object? isOverdue = freezed,Object? dueFrom = freezed,Object? dueTo = freezed,Object? search = freezed,Object? sortBy = null,Object? sortDesc = null,}) {
  return _then(TaskFilterState(
statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,priorityId: freezed == priorityId ? _self.priorityId : priorityId // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,isOverdue: freezed == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool?,dueFrom: freezed == dueFrom ? _self.dueFrom : dueFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dueTo: freezed == dueTo ? _self.dueTo : dueTo // ignore: cast_nullable_to_non_nullable
as DateTime?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,sortDesc: null == sortDesc ? _self.sortDesc : sortDesc // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskFilterState].
extension TaskFilterStatePatterns on TaskFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskFilterState value)  $default,){
final _that = this;
switch (_that) {
case _TaskFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? statusId,  String? priorityId,  String? departmentId,  String? clientId,  String? projectId,  bool? isOverdue,  DateTime? dueFrom,  DateTime? dueTo,  String? search,  String sortBy,  bool sortDesc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
return $default(_that.statusId,_that.priorityId,_that.departmentId,_that.clientId,_that.projectId,_that.isOverdue,_that.dueFrom,_that.dueTo,_that.search,_that.sortBy,_that.sortDesc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? statusId,  String? priorityId,  String? departmentId,  String? clientId,  String? projectId,  bool? isOverdue,  DateTime? dueFrom,  DateTime? dueTo,  String? search,  String sortBy,  bool sortDesc)  $default,) {final _that = this;
switch (_that) {
case _TaskFilterState():
return $default(_that.statusId,_that.priorityId,_that.departmentId,_that.clientId,_that.projectId,_that.isOverdue,_that.dueFrom,_that.dueTo,_that.search,_that.sortBy,_that.sortDesc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? statusId,  String? priorityId,  String? departmentId,  String? clientId,  String? projectId,  bool? isOverdue,  DateTime? dueFrom,  DateTime? dueTo,  String? search,  String sortBy,  bool sortDesc)?  $default,) {final _that = this;
switch (_that) {
case _TaskFilterState() when $default != null:
return $default(_that.statusId,_that.priorityId,_that.departmentId,_that.clientId,_that.projectId,_that.isOverdue,_that.dueFrom,_that.dueTo,_that.search,_that.sortBy,_that.sortDesc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskFilterState implements TaskFilterState {
  const _TaskFilterState({this.statusId, this.priorityId, this.departmentId, this.clientId, this.projectId, this.isOverdue, this.dueFrom, this.dueTo, this.search, this.sortBy = 'created_at', this.sortDesc = true});
  factory _TaskFilterState.fromJson(Map<String, dynamic> json) => _$TaskFilterStateFromJson(json);

@override final  String? statusId;
@override final  String? priorityId;
@override final  String? departmentId;
@override final  String? clientId;
@override final  String? projectId;
@override final  bool? isOverdue;
@override final  DateTime? dueFrom;
@override final  DateTime? dueTo;
@override final  String? search;
@override@JsonKey() final  String sortBy;
@override@JsonKey() final  bool sortDesc;

/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskFilterStateCopyWith<_TaskFilterState> get copyWith => __$TaskFilterStateCopyWithImpl<_TaskFilterState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskFilterStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskFilterState&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.priorityId, priorityId) || other.priorityId == priorityId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.dueFrom, dueFrom) || other.dueFrom == dueFrom)&&(identical(other.dueTo, dueTo) || other.dueTo == dueTo)&&(identical(other.search, search) || other.search == search)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortDesc, sortDesc) || other.sortDesc == sortDesc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusId,priorityId,departmentId,clientId,projectId,isOverdue,dueFrom,dueTo,search,sortBy,sortDesc);

@override
String toString() {
  return 'TaskFilterState(statusId: $statusId, priorityId: $priorityId, departmentId: $departmentId, clientId: $clientId, projectId: $projectId, isOverdue: $isOverdue, dueFrom: $dueFrom, dueTo: $dueTo, search: $search, sortBy: $sortBy, sortDesc: $sortDesc)';
}


}

/// @nodoc
abstract mixin class _$TaskFilterStateCopyWith<$Res> implements $TaskFilterStateCopyWith<$Res> {
  factory _$TaskFilterStateCopyWith(_TaskFilterState value, $Res Function(_TaskFilterState) _then) = __$TaskFilterStateCopyWithImpl;
@override @useResult
$Res call({
 String? statusId, String? priorityId, String? departmentId, String? clientId, String? projectId, bool? isOverdue, DateTime? dueFrom, DateTime? dueTo, String? search, String sortBy, bool sortDesc
});




}
/// @nodoc
class __$TaskFilterStateCopyWithImpl<$Res>
    implements _$TaskFilterStateCopyWith<$Res> {
  __$TaskFilterStateCopyWithImpl(this._self, this._then);

  final _TaskFilterState _self;
  final $Res Function(_TaskFilterState) _then;

/// Create a copy of TaskFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusId = freezed,Object? priorityId = freezed,Object? departmentId = freezed,Object? clientId = freezed,Object? projectId = freezed,Object? isOverdue = freezed,Object? dueFrom = freezed,Object? dueTo = freezed,Object? search = freezed,Object? sortBy = null,Object? sortDesc = null,}) {
  return _then(_TaskFilterState(
statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,priorityId: freezed == priorityId ? _self.priorityId : priorityId // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,isOverdue: freezed == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool?,dueFrom: freezed == dueFrom ? _self.dueFrom : dueFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dueTo: freezed == dueTo ? _self.dueTo : dueTo // ignore: cast_nullable_to_non_nullable
as DateTime?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,sortDesc: null == sortDesc ? _self.sortDesc : sortDesc // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
