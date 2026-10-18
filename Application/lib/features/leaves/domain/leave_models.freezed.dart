// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveTypeModel {

 String get id; String get name;@JsonKey(name: 'annual_quota') int get annualQuota;@JsonKey(name: 'is_paid') bool get isPaid;@JsonKey(name: 'carry_forward') bool get carryForward;@JsonKey(name: 'max_carry_forward') int get maxCarryForward;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveTypeModelCopyWith<LeaveTypeModel> get copyWith => _$LeaveTypeModelCopyWithImpl<LeaveTypeModel>(this as LeaveTypeModel, _$identity);

  /// Serializes this LeaveTypeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveTypeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.annualQuota, annualQuota) || other.annualQuota == annualQuota)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.carryForward, carryForward) || other.carryForward == carryForward)&&(identical(other.maxCarryForward, maxCarryForward) || other.maxCarryForward == maxCarryForward)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,annualQuota,isPaid,carryForward,maxCarryForward,isActive);

@override
String toString() {
  return 'LeaveTypeModel(id: $id, name: $name, annualQuota: $annualQuota, isPaid: $isPaid, carryForward: $carryForward, maxCarryForward: $maxCarryForward, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $LeaveTypeModelCopyWith<$Res>  {
  factory $LeaveTypeModelCopyWith(LeaveTypeModel value, $Res Function(LeaveTypeModel) _then) = _$LeaveTypeModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'annual_quota') int annualQuota,@JsonKey(name: 'is_paid') bool isPaid,@JsonKey(name: 'carry_forward') bool carryForward,@JsonKey(name: 'max_carry_forward') int maxCarryForward,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$LeaveTypeModelCopyWithImpl<$Res>
    implements $LeaveTypeModelCopyWith<$Res> {
  _$LeaveTypeModelCopyWithImpl(this._self, this._then);

  final LeaveTypeModel _self;
  final $Res Function(LeaveTypeModel) _then;

/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? annualQuota = null,Object? isPaid = null,Object? carryForward = null,Object? maxCarryForward = null,Object? isActive = null,}) {
  return _then(LeaveTypeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,annualQuota: null == annualQuota ? _self.annualQuota : annualQuota // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,carryForward: null == carryForward ? _self.carryForward : carryForward // ignore: cast_nullable_to_non_nullable
as bool,maxCarryForward: null == maxCarryForward ? _self.maxCarryForward : maxCarryForward // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveTypeModel].
extension LeaveTypeModelPatterns on LeaveTypeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveTypeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveTypeModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveTypeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveTypeModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'annual_quota')  int annualQuota, @JsonKey(name: 'is_paid')  bool isPaid, @JsonKey(name: 'carry_forward')  bool carryForward, @JsonKey(name: 'max_carry_forward')  int maxCarryForward, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
return $default(_that.id,_that.name,_that.annualQuota,_that.isPaid,_that.carryForward,_that.maxCarryForward,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'annual_quota')  int annualQuota, @JsonKey(name: 'is_paid')  bool isPaid, @JsonKey(name: 'carry_forward')  bool carryForward, @JsonKey(name: 'max_carry_forward')  int maxCarryForward, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _LeaveTypeModel():
return $default(_that.id,_that.name,_that.annualQuota,_that.isPaid,_that.carryForward,_that.maxCarryForward,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'annual_quota')  int annualQuota, @JsonKey(name: 'is_paid')  bool isPaid, @JsonKey(name: 'carry_forward')  bool carryForward, @JsonKey(name: 'max_carry_forward')  int maxCarryForward, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
return $default(_that.id,_that.name,_that.annualQuota,_that.isPaid,_that.carryForward,_that.maxCarryForward,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveTypeModel implements LeaveTypeModel {
  const _LeaveTypeModel({required this.id, required this.name, @JsonKey(name: 'annual_quota') required this.annualQuota, @JsonKey(name: 'is_paid') required this.isPaid, @JsonKey(name: 'carry_forward') required this.carryForward, @JsonKey(name: 'max_carry_forward') required this.maxCarryForward, @JsonKey(name: 'is_active') this.isActive = true});
  factory _LeaveTypeModel.fromJson(Map<String, dynamic> json) => _$LeaveTypeModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'annual_quota') final  int annualQuota;
@override@JsonKey(name: 'is_paid') final  bool isPaid;
@override@JsonKey(name: 'carry_forward') final  bool carryForward;
@override@JsonKey(name: 'max_carry_forward') final  int maxCarryForward;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveTypeModelCopyWith<_LeaveTypeModel> get copyWith => __$LeaveTypeModelCopyWithImpl<_LeaveTypeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveTypeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveTypeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.annualQuota, annualQuota) || other.annualQuota == annualQuota)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.carryForward, carryForward) || other.carryForward == carryForward)&&(identical(other.maxCarryForward, maxCarryForward) || other.maxCarryForward == maxCarryForward)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,annualQuota,isPaid,carryForward,maxCarryForward,isActive);

@override
String toString() {
  return 'LeaveTypeModel(id: $id, name: $name, annualQuota: $annualQuota, isPaid: $isPaid, carryForward: $carryForward, maxCarryForward: $maxCarryForward, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$LeaveTypeModelCopyWith<$Res> implements $LeaveTypeModelCopyWith<$Res> {
  factory _$LeaveTypeModelCopyWith(_LeaveTypeModel value, $Res Function(_LeaveTypeModel) _then) = __$LeaveTypeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'annual_quota') int annualQuota,@JsonKey(name: 'is_paid') bool isPaid,@JsonKey(name: 'carry_forward') bool carryForward,@JsonKey(name: 'max_carry_forward') int maxCarryForward,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$LeaveTypeModelCopyWithImpl<$Res>
    implements _$LeaveTypeModelCopyWith<$Res> {
  __$LeaveTypeModelCopyWithImpl(this._self, this._then);

  final _LeaveTypeModel _self;
  final $Res Function(_LeaveTypeModel) _then;

/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? annualQuota = null,Object? isPaid = null,Object? carryForward = null,Object? maxCarryForward = null,Object? isActive = null,}) {
  return _then(_LeaveTypeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,annualQuota: null == annualQuota ? _self.annualQuota : annualQuota // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,carryForward: null == carryForward ? _self.carryForward : carryForward // ignore: cast_nullable_to_non_nullable
as bool,maxCarryForward: null == maxCarryForward ? _self.maxCarryForward : maxCarryForward // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LeaveBalanceModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'leave_type_id') String get leaveTypeId;@JsonKey(name: 'leave_type_name') String get leaveTypeName; int get year; double get allocated;@JsonKey(name: 'carried_forward') double get carriedForward; double get used; double get available;
/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith => _$LeaveBalanceModelCopyWithImpl<LeaveBalanceModel>(this as LeaveBalanceModel, _$identity);

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName)&&(identical(other.year, year) || other.year == year)&&(identical(other.allocated, allocated) || other.allocated == allocated)&&(identical(other.carriedForward, carriedForward) || other.carriedForward == carriedForward)&&(identical(other.used, used) || other.used == used)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,leaveTypeId,leaveTypeName,year,allocated,carriedForward,used,available);

@override
String toString() {
  return 'LeaveBalanceModel(id: $id, userId: $userId, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, year: $year, allocated: $allocated, carriedForward: $carriedForward, used: $used, available: $available)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceModelCopyWith<$Res>  {
  factory $LeaveBalanceModelCopyWith(LeaveBalanceModel value, $Res Function(LeaveBalanceModel) _then) = _$LeaveBalanceModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'leave_type_id') String leaveTypeId,@JsonKey(name: 'leave_type_name') String leaveTypeName, int year, double allocated,@JsonKey(name: 'carried_forward') double carriedForward, double used, double available
});




}
/// @nodoc
class _$LeaveBalanceModelCopyWithImpl<$Res>
    implements $LeaveBalanceModelCopyWith<$Res> {
  _$LeaveBalanceModelCopyWithImpl(this._self, this._then);

  final LeaveBalanceModel _self;
  final $Res Function(LeaveBalanceModel) _then;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? leaveTypeId = null,Object? leaveTypeName = null,Object? year = null,Object? allocated = null,Object? carriedForward = null,Object? used = null,Object? available = null,}) {
  return _then(LeaveBalanceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,leaveTypeId: null == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,allocated: null == allocated ? _self.allocated : allocated // ignore: cast_nullable_to_non_nullable
as double,carriedForward: null == carriedForward ? _self.carriedForward : carriedForward // ignore: cast_nullable_to_non_nullable
as double,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveBalanceModel].
extension LeaveBalanceModelPatterns on LeaveBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'leave_type_name')  String leaveTypeName,  int year,  double allocated, @JsonKey(name: 'carried_forward')  double carriedForward,  double used,  double available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.id,_that.userId,_that.leaveTypeId,_that.leaveTypeName,_that.year,_that.allocated,_that.carriedForward,_that.used,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'leave_type_name')  String leaveTypeName,  int year,  double allocated, @JsonKey(name: 'carried_forward')  double carriedForward,  double used,  double available)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel():
return $default(_that.id,_that.userId,_that.leaveTypeId,_that.leaveTypeName,_that.year,_that.allocated,_that.carriedForward,_that.used,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'leave_type_name')  String leaveTypeName,  int year,  double allocated, @JsonKey(name: 'carried_forward')  double carriedForward,  double used,  double available)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.id,_that.userId,_that.leaveTypeId,_that.leaveTypeName,_that.year,_that.allocated,_that.carriedForward,_that.used,_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveBalanceModel implements LeaveBalanceModel {
  const _LeaveBalanceModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'leave_type_id') required this.leaveTypeId, @JsonKey(name: 'leave_type_name') required this.leaveTypeName, required this.year, required this.allocated, @JsonKey(name: 'carried_forward') required this.carriedForward, required this.used, required this.available});
  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'leave_type_id') final  String leaveTypeId;
@override@JsonKey(name: 'leave_type_name') final  String leaveTypeName;
@override final  int year;
@override final  double allocated;
@override@JsonKey(name: 'carried_forward') final  double carriedForward;
@override final  double used;
@override final  double available;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceModelCopyWith<_LeaveBalanceModel> get copyWith => __$LeaveBalanceModelCopyWithImpl<_LeaveBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName)&&(identical(other.year, year) || other.year == year)&&(identical(other.allocated, allocated) || other.allocated == allocated)&&(identical(other.carriedForward, carriedForward) || other.carriedForward == carriedForward)&&(identical(other.used, used) || other.used == used)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,leaveTypeId,leaveTypeName,year,allocated,carriedForward,used,available);

@override
String toString() {
  return 'LeaveBalanceModel(id: $id, userId: $userId, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, year: $year, allocated: $allocated, carriedForward: $carriedForward, used: $used, available: $available)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceModelCopyWith<$Res> implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$LeaveBalanceModelCopyWith(_LeaveBalanceModel value, $Res Function(_LeaveBalanceModel) _then) = __$LeaveBalanceModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'leave_type_id') String leaveTypeId,@JsonKey(name: 'leave_type_name') String leaveTypeName, int year, double allocated,@JsonKey(name: 'carried_forward') double carriedForward, double used, double available
});




}
/// @nodoc
class __$LeaveBalanceModelCopyWithImpl<$Res>
    implements _$LeaveBalanceModelCopyWith<$Res> {
  __$LeaveBalanceModelCopyWithImpl(this._self, this._then);

  final _LeaveBalanceModel _self;
  final $Res Function(_LeaveBalanceModel) _then;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? leaveTypeId = null,Object? leaveTypeName = null,Object? year = null,Object? allocated = null,Object? carriedForward = null,Object? used = null,Object? available = null,}) {
  return _then(_LeaveBalanceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,leaveTypeId: null == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,allocated: null == allocated ? _self.allocated : allocated // ignore: cast_nullable_to_non_nullable
as double,carriedForward: null == carriedForward ? _self.carriedForward : carriedForward // ignore: cast_nullable_to_non_nullable
as double,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$LeaveRequestModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_full_name') String get userFullName;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'leave_type_id') String get leaveTypeId;@JsonKey(name: 'leave_type_name') String get leaveTypeName;@JsonKey(name: 'from_date') DateTime get fromDate;@JsonKey(name: 'to_date') DateTime get toDate;@JsonKey(name: 'is_half_day') bool get isHalfDay;@JsonKey(name: 'total_days') double get totalDays; String get reason; String get status;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'department_name') String? get departmentName;@JsonKey(name: 'half_day_session') String? get halfDaySession;@JsonKey(name: 'reviewed_by') String? get reviewedBy;@JsonKey(name: 'reviewer_name') String? get reviewerName;@JsonKey(name: 'reviewed_at') DateTime? get reviewedAt;@JsonKey(name: 'review_note') String? get reviewNote;
/// Create a copy of LeaveRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveRequestModelCopyWith<LeaveRequestModel> get copyWith => _$LeaveRequestModelCopyWithImpl<LeaveRequestModel>(this as LeaveRequestModel, _$identity);

  /// Serializes this LeaveRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userFullName,employeeCode,leaveTypeId,leaveTypeName,fromDate,toDate,isHalfDay,totalDays,reason,status,createdAt,departmentName,halfDaySession,reviewedBy,reviewerName,reviewedAt,reviewNote]);

@override
String toString() {
  return 'LeaveRequestModel(id: $id, userId: $userId, userFullName: $userFullName, employeeCode: $employeeCode, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, totalDays: $totalDays, reason: $reason, status: $status, createdAt: $createdAt, departmentName: $departmentName, halfDaySession: $halfDaySession, reviewedBy: $reviewedBy, reviewerName: $reviewerName, reviewedAt: $reviewedAt, reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class $LeaveRequestModelCopyWith<$Res>  {
  factory $LeaveRequestModelCopyWith(LeaveRequestModel value, $Res Function(LeaveRequestModel) _then) = _$LeaveRequestModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_full_name') String userFullName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'leave_type_id') String leaveTypeId,@JsonKey(name: 'leave_type_name') String leaveTypeName,@JsonKey(name: 'from_date') DateTime fromDate,@JsonKey(name: 'to_date') DateTime toDate,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'total_days') double totalDays, String reason, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'half_day_session') String? halfDaySession,@JsonKey(name: 'reviewed_by') String? reviewedBy,@JsonKey(name: 'reviewer_name') String? reviewerName,@JsonKey(name: 'reviewed_at') DateTime? reviewedAt,@JsonKey(name: 'review_note') String? reviewNote
});




}
/// @nodoc
class _$LeaveRequestModelCopyWithImpl<$Res>
    implements $LeaveRequestModelCopyWith<$Res> {
  _$LeaveRequestModelCopyWithImpl(this._self, this._then);

  final LeaveRequestModel _self;
  final $Res Function(LeaveRequestModel) _then;

/// Create a copy of LeaveRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? employeeCode = null,Object? leaveTypeId = null,Object? leaveTypeName = null,Object? fromDate = null,Object? toDate = null,Object? isHalfDay = null,Object? totalDays = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? departmentName = freezed,Object? halfDaySession = freezed,Object? reviewedBy = freezed,Object? reviewerName = freezed,Object? reviewedAt = freezed,Object? reviewNote = freezed,}) {
  return _then(LeaveRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,leaveTypeId: null == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewNote: freezed == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveRequestModel].
extension LeaveRequestModelPatterns on LeaveRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_full_name')  String userFullName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'leave_type_name')  String leaveTypeName, @JsonKey(name: 'from_date')  DateTime fromDate, @JsonKey(name: 'to_date')  DateTime toDate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'total_days')  double totalDays,  String reason,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'half_day_session')  String? halfDaySession, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewer_name')  String? reviewerName, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt, @JsonKey(name: 'review_note')  String? reviewNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveRequestModel() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.employeeCode,_that.leaveTypeId,_that.leaveTypeName,_that.fromDate,_that.toDate,_that.isHalfDay,_that.totalDays,_that.reason,_that.status,_that.createdAt,_that.departmentName,_that.halfDaySession,_that.reviewedBy,_that.reviewerName,_that.reviewedAt,_that.reviewNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_full_name')  String userFullName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'leave_type_name')  String leaveTypeName, @JsonKey(name: 'from_date')  DateTime fromDate, @JsonKey(name: 'to_date')  DateTime toDate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'total_days')  double totalDays,  String reason,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'half_day_session')  String? halfDaySession, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewer_name')  String? reviewerName, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt, @JsonKey(name: 'review_note')  String? reviewNote)  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestModel():
return $default(_that.id,_that.userId,_that.userFullName,_that.employeeCode,_that.leaveTypeId,_that.leaveTypeName,_that.fromDate,_that.toDate,_that.isHalfDay,_that.totalDays,_that.reason,_that.status,_that.createdAt,_that.departmentName,_that.halfDaySession,_that.reviewedBy,_that.reviewerName,_that.reviewedAt,_that.reviewNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_full_name')  String userFullName, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'leave_type_name')  String leaveTypeName, @JsonKey(name: 'from_date')  DateTime fromDate, @JsonKey(name: 'to_date')  DateTime toDate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'total_days')  double totalDays,  String reason,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'half_day_session')  String? halfDaySession, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewer_name')  String? reviewerName, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt, @JsonKey(name: 'review_note')  String? reviewNote)?  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestModel() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.employeeCode,_that.leaveTypeId,_that.leaveTypeName,_that.fromDate,_that.toDate,_that.isHalfDay,_that.totalDays,_that.reason,_that.status,_that.createdAt,_that.departmentName,_that.halfDaySession,_that.reviewedBy,_that.reviewerName,_that.reviewedAt,_that.reviewNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveRequestModel implements LeaveRequestModel {
  const _LeaveRequestModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_full_name') required this.userFullName, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'leave_type_id') required this.leaveTypeId, @JsonKey(name: 'leave_type_name') required this.leaveTypeName, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, @JsonKey(name: 'is_half_day') required this.isHalfDay, @JsonKey(name: 'total_days') required this.totalDays, required this.reason, required this.status, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'department_name') this.departmentName, @JsonKey(name: 'half_day_session') this.halfDaySession, @JsonKey(name: 'reviewed_by') this.reviewedBy, @JsonKey(name: 'reviewer_name') this.reviewerName, @JsonKey(name: 'reviewed_at') this.reviewedAt, @JsonKey(name: 'review_note') this.reviewNote});
  factory _LeaveRequestModel.fromJson(Map<String, dynamic> json) => _$LeaveRequestModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_full_name') final  String userFullName;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'leave_type_id') final  String leaveTypeId;
@override@JsonKey(name: 'leave_type_name') final  String leaveTypeName;
@override@JsonKey(name: 'from_date') final  DateTime fromDate;
@override@JsonKey(name: 'to_date') final  DateTime toDate;
@override@JsonKey(name: 'is_half_day') final  bool isHalfDay;
@override@JsonKey(name: 'total_days') final  double totalDays;
@override final  String reason;
@override final  String status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override@JsonKey(name: 'half_day_session') final  String? halfDaySession;
@override@JsonKey(name: 'reviewed_by') final  String? reviewedBy;
@override@JsonKey(name: 'reviewer_name') final  String? reviewerName;
@override@JsonKey(name: 'reviewed_at') final  DateTime? reviewedAt;
@override@JsonKey(name: 'review_note') final  String? reviewNote;

/// Create a copy of LeaveRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveRequestModelCopyWith<_LeaveRequestModel> get copyWith => __$LeaveRequestModelCopyWithImpl<_LeaveRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userFullName,employeeCode,leaveTypeId,leaveTypeName,fromDate,toDate,isHalfDay,totalDays,reason,status,createdAt,departmentName,halfDaySession,reviewedBy,reviewerName,reviewedAt,reviewNote]);

@override
String toString() {
  return 'LeaveRequestModel(id: $id, userId: $userId, userFullName: $userFullName, employeeCode: $employeeCode, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, totalDays: $totalDays, reason: $reason, status: $status, createdAt: $createdAt, departmentName: $departmentName, halfDaySession: $halfDaySession, reviewedBy: $reviewedBy, reviewerName: $reviewerName, reviewedAt: $reviewedAt, reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class _$LeaveRequestModelCopyWith<$Res> implements $LeaveRequestModelCopyWith<$Res> {
  factory _$LeaveRequestModelCopyWith(_LeaveRequestModel value, $Res Function(_LeaveRequestModel) _then) = __$LeaveRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_full_name') String userFullName,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'leave_type_id') String leaveTypeId,@JsonKey(name: 'leave_type_name') String leaveTypeName,@JsonKey(name: 'from_date') DateTime fromDate,@JsonKey(name: 'to_date') DateTime toDate,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'total_days') double totalDays, String reason, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'half_day_session') String? halfDaySession,@JsonKey(name: 'reviewed_by') String? reviewedBy,@JsonKey(name: 'reviewer_name') String? reviewerName,@JsonKey(name: 'reviewed_at') DateTime? reviewedAt,@JsonKey(name: 'review_note') String? reviewNote
});




}
/// @nodoc
class __$LeaveRequestModelCopyWithImpl<$Res>
    implements _$LeaveRequestModelCopyWith<$Res> {
  __$LeaveRequestModelCopyWithImpl(this._self, this._then);

  final _LeaveRequestModel _self;
  final $Res Function(_LeaveRequestModel) _then;

/// Create a copy of LeaveRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? employeeCode = null,Object? leaveTypeId = null,Object? leaveTypeName = null,Object? fromDate = null,Object? toDate = null,Object? isHalfDay = null,Object? totalDays = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? departmentName = freezed,Object? halfDaySession = freezed,Object? reviewedBy = freezed,Object? reviewerName = freezed,Object? reviewedAt = freezed,Object? reviewNote = freezed,}) {
  return _then(_LeaveRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,leaveTypeId: null == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewNote: freezed == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LeaveRequestListResponse {

 List<LeaveRequestModel> get items; int get total; int get page; int get size; int get pages;
/// Create a copy of LeaveRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveRequestListResponseCopyWith<LeaveRequestListResponse> get copyWith => _$LeaveRequestListResponseCopyWithImpl<LeaveRequestListResponse>(this as LeaveRequestListResponse, _$identity);

  /// Serializes this LeaveRequestListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveRequestListResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,size,pages);

@override
String toString() {
  return 'LeaveRequestListResponse(items: $items, total: $total, page: $page, size: $size, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $LeaveRequestListResponseCopyWith<$Res>  {
  factory $LeaveRequestListResponseCopyWith(LeaveRequestListResponse value, $Res Function(LeaveRequestListResponse) _then) = _$LeaveRequestListResponseCopyWithImpl;
@useResult
$Res call({
 List<LeaveRequestModel> items, int total, int page, int size, int pages
});




}
/// @nodoc
class _$LeaveRequestListResponseCopyWithImpl<$Res>
    implements $LeaveRequestListResponseCopyWith<$Res> {
  _$LeaveRequestListResponseCopyWithImpl(this._self, this._then);

  final LeaveRequestListResponse _self;
  final $Res Function(LeaveRequestListResponse) _then;

/// Create a copy of LeaveRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? size = null,Object? pages = null,}) {
  return _then(LeaveRequestListResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LeaveRequestModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveRequestListResponse].
extension LeaveRequestListResponsePatterns on LeaveRequestListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveRequestListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveRequestListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveRequestListResponse value)  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveRequestListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaveRequestModel> items,  int total,  int page,  int size,  int pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveRequestListResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.size,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaveRequestModel> items,  int total,  int page,  int size,  int pages)  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestListResponse():
return $default(_that.items,_that.total,_that.page,_that.size,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaveRequestModel> items,  int total,  int page,  int size,  int pages)?  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestListResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.size,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveRequestListResponse implements LeaveRequestListResponse {
  const _LeaveRequestListResponse({required  List<LeaveRequestModel> items, required this.total, required this.page, required this.size, required this.pages}): _items = items;
  factory _LeaveRequestListResponse.fromJson(Map<String, dynamic> json) => _$LeaveRequestListResponseFromJson(json);

 final  List<LeaveRequestModel> _items;
@override List<LeaveRequestModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override final  int page;
@override final  int size;
@override final  int pages;

/// Create a copy of LeaveRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveRequestListResponseCopyWith<_LeaveRequestListResponse> get copyWith => __$LeaveRequestListResponseCopyWithImpl<_LeaveRequestListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveRequestListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveRequestListResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,size,pages);

@override
String toString() {
  return 'LeaveRequestListResponse(items: $items, total: $total, page: $page, size: $size, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$LeaveRequestListResponseCopyWith<$Res> implements $LeaveRequestListResponseCopyWith<$Res> {
  factory _$LeaveRequestListResponseCopyWith(_LeaveRequestListResponse value, $Res Function(_LeaveRequestListResponse) _then) = __$LeaveRequestListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<LeaveRequestModel> items, int total, int page, int size, int pages
});




}
/// @nodoc
class __$LeaveRequestListResponseCopyWithImpl<$Res>
    implements _$LeaveRequestListResponseCopyWith<$Res> {
  __$LeaveRequestListResponseCopyWithImpl(this._self, this._then);

  final _LeaveRequestListResponse _self;
  final $Res Function(_LeaveRequestListResponse) _then;

/// Create a copy of LeaveRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? size = null,Object? pages = null,}) {
  return _then(_LeaveRequestListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LeaveRequestModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LeaveApplyPayload {

@JsonKey(name: 'leave_type_id') String get leaveTypeId;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate; String get reason;@JsonKey(name: 'is_half_day') bool get isHalfDay;@JsonKey(name: 'half_day_session') String? get halfDaySession;
/// Create a copy of LeaveApplyPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveApplyPayloadCopyWith<LeaveApplyPayload> get copyWith => _$LeaveApplyPayloadCopyWithImpl<LeaveApplyPayload>(this as LeaveApplyPayload, _$identity);

  /// Serializes this LeaveApplyPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveApplyPayload&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leaveTypeId,fromDate,toDate,reason,isHalfDay,halfDaySession);

@override
String toString() {
  return 'LeaveApplyPayload(leaveTypeId: $leaveTypeId, fromDate: $fromDate, toDate: $toDate, reason: $reason, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession)';
}


}

/// @nodoc
abstract mixin class $LeaveApplyPayloadCopyWith<$Res>  {
  factory $LeaveApplyPayloadCopyWith(LeaveApplyPayload value, $Res Function(LeaveApplyPayload) _then) = _$LeaveApplyPayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leave_type_id') String leaveTypeId,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String reason,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'half_day_session') String? halfDaySession
});




}
/// @nodoc
class _$LeaveApplyPayloadCopyWithImpl<$Res>
    implements $LeaveApplyPayloadCopyWith<$Res> {
  _$LeaveApplyPayloadCopyWithImpl(this._self, this._then);

  final LeaveApplyPayload _self;
  final $Res Function(LeaveApplyPayload) _then;

/// Create a copy of LeaveApplyPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveTypeId = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? isHalfDay = null,Object? halfDaySession = freezed,}) {
  return _then(LeaveApplyPayload(
leaveTypeId: null == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveApplyPayload].
extension LeaveApplyPayloadPatterns on LeaveApplyPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveApplyPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveApplyPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveApplyPayload value)  $default,){
final _that = this;
switch (_that) {
case _LeaveApplyPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveApplyPayload value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveApplyPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String reason, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'half_day_session')  String? halfDaySession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveApplyPayload() when $default != null:
return $default(_that.leaveTypeId,_that.fromDate,_that.toDate,_that.reason,_that.isHalfDay,_that.halfDaySession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String reason, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'half_day_session')  String? halfDaySession)  $default,) {final _that = this;
switch (_that) {
case _LeaveApplyPayload():
return $default(_that.leaveTypeId,_that.fromDate,_that.toDate,_that.reason,_that.isHalfDay,_that.halfDaySession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'leave_type_id')  String leaveTypeId, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String reason, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'half_day_session')  String? halfDaySession)?  $default,) {final _that = this;
switch (_that) {
case _LeaveApplyPayload() when $default != null:
return $default(_that.leaveTypeId,_that.fromDate,_that.toDate,_that.reason,_that.isHalfDay,_that.halfDaySession);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveApplyPayload implements LeaveApplyPayload {
  const _LeaveApplyPayload({@JsonKey(name: 'leave_type_id') required this.leaveTypeId, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, required this.reason, @JsonKey(name: 'is_half_day') this.isHalfDay = false, @JsonKey(name: 'half_day_session') this.halfDaySession});
  factory _LeaveApplyPayload.fromJson(Map<String, dynamic> json) => _$LeaveApplyPayloadFromJson(json);

@override@JsonKey(name: 'leave_type_id') final  String leaveTypeId;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override final  String reason;
@override@JsonKey(name: 'is_half_day') final  bool isHalfDay;
@override@JsonKey(name: 'half_day_session') final  String? halfDaySession;

/// Create a copy of LeaveApplyPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveApplyPayloadCopyWith<_LeaveApplyPayload> get copyWith => __$LeaveApplyPayloadCopyWithImpl<_LeaveApplyPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveApplyPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveApplyPayload&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leaveTypeId,fromDate,toDate,reason,isHalfDay,halfDaySession);

@override
String toString() {
  return 'LeaveApplyPayload(leaveTypeId: $leaveTypeId, fromDate: $fromDate, toDate: $toDate, reason: $reason, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession)';
}


}

/// @nodoc
abstract mixin class _$LeaveApplyPayloadCopyWith<$Res> implements $LeaveApplyPayloadCopyWith<$Res> {
  factory _$LeaveApplyPayloadCopyWith(_LeaveApplyPayload value, $Res Function(_LeaveApplyPayload) _then) = __$LeaveApplyPayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leave_type_id') String leaveTypeId,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String reason,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'half_day_session') String? halfDaySession
});




}
/// @nodoc
class __$LeaveApplyPayloadCopyWithImpl<$Res>
    implements _$LeaveApplyPayloadCopyWith<$Res> {
  __$LeaveApplyPayloadCopyWithImpl(this._self, this._then);

  final _LeaveApplyPayload _self;
  final $Res Function(_LeaveApplyPayload) _then;

/// Create a copy of LeaveApplyPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveTypeId = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? isHalfDay = null,Object? halfDaySession = freezed,}) {
  return _then(_LeaveApplyPayload(
leaveTypeId: null == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LeavePreviewPayload {

@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate;@JsonKey(name: 'leave_type_id') String? get leaveTypeId;@JsonKey(name: 'is_half_day') bool get isHalfDay;@JsonKey(name: 'half_day_session') String? get halfDaySession;
/// Create a copy of LeavePreviewPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeavePreviewPayloadCopyWith<LeavePreviewPayload> get copyWith => _$LeavePreviewPayloadCopyWithImpl<LeavePreviewPayload>(this as LeavePreviewPayload, _$identity);

  /// Serializes this LeavePreviewPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeavePreviewPayload&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate,leaveTypeId,isHalfDay,halfDaySession);

@override
String toString() {
  return 'LeavePreviewPayload(fromDate: $fromDate, toDate: $toDate, leaveTypeId: $leaveTypeId, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession)';
}


}

/// @nodoc
abstract mixin class $LeavePreviewPayloadCopyWith<$Res>  {
  factory $LeavePreviewPayloadCopyWith(LeavePreviewPayload value, $Res Function(LeavePreviewPayload) _then) = _$LeavePreviewPayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate,@JsonKey(name: 'leave_type_id') String? leaveTypeId,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'half_day_session') String? halfDaySession
});




}
/// @nodoc
class _$LeavePreviewPayloadCopyWithImpl<$Res>
    implements $LeavePreviewPayloadCopyWith<$Res> {
  _$LeavePreviewPayloadCopyWithImpl(this._self, this._then);

  final LeavePreviewPayload _self;
  final $Res Function(LeavePreviewPayload) _then;

/// Create a copy of LeavePreviewPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromDate = null,Object? toDate = null,Object? leaveTypeId = freezed,Object? isHalfDay = null,Object? halfDaySession = freezed,}) {
  return _then(LeavePreviewPayload(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,leaveTypeId: freezed == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String?,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeavePreviewPayload].
extension LeavePreviewPayloadPatterns on LeavePreviewPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeavePreviewPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeavePreviewPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeavePreviewPayload value)  $default,){
final _that = this;
switch (_that) {
case _LeavePreviewPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeavePreviewPayload value)?  $default,){
final _that = this;
switch (_that) {
case _LeavePreviewPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'leave_type_id')  String? leaveTypeId, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'half_day_session')  String? halfDaySession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeavePreviewPayload() when $default != null:
return $default(_that.fromDate,_that.toDate,_that.leaveTypeId,_that.isHalfDay,_that.halfDaySession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'leave_type_id')  String? leaveTypeId, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'half_day_session')  String? halfDaySession)  $default,) {final _that = this;
switch (_that) {
case _LeavePreviewPayload():
return $default(_that.fromDate,_that.toDate,_that.leaveTypeId,_that.isHalfDay,_that.halfDaySession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'leave_type_id')  String? leaveTypeId, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'half_day_session')  String? halfDaySession)?  $default,) {final _that = this;
switch (_that) {
case _LeavePreviewPayload() when $default != null:
return $default(_that.fromDate,_that.toDate,_that.leaveTypeId,_that.isHalfDay,_that.halfDaySession);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeavePreviewPayload implements LeavePreviewPayload {
  const _LeavePreviewPayload({@JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, @JsonKey(name: 'leave_type_id') this.leaveTypeId, @JsonKey(name: 'is_half_day') this.isHalfDay = false, @JsonKey(name: 'half_day_session') this.halfDaySession});
  factory _LeavePreviewPayload.fromJson(Map<String, dynamic> json) => _$LeavePreviewPayloadFromJson(json);

@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override@JsonKey(name: 'leave_type_id') final  String? leaveTypeId;
@override@JsonKey(name: 'is_half_day') final  bool isHalfDay;
@override@JsonKey(name: 'half_day_session') final  String? halfDaySession;

/// Create a copy of LeavePreviewPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeavePreviewPayloadCopyWith<_LeavePreviewPayload> get copyWith => __$LeavePreviewPayloadCopyWithImpl<_LeavePreviewPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeavePreviewPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeavePreviewPayload&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate,leaveTypeId,isHalfDay,halfDaySession);

@override
String toString() {
  return 'LeavePreviewPayload(fromDate: $fromDate, toDate: $toDate, leaveTypeId: $leaveTypeId, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession)';
}


}

/// @nodoc
abstract mixin class _$LeavePreviewPayloadCopyWith<$Res> implements $LeavePreviewPayloadCopyWith<$Res> {
  factory _$LeavePreviewPayloadCopyWith(_LeavePreviewPayload value, $Res Function(_LeavePreviewPayload) _then) = __$LeavePreviewPayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate,@JsonKey(name: 'leave_type_id') String? leaveTypeId,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'half_day_session') String? halfDaySession
});




}
/// @nodoc
class __$LeavePreviewPayloadCopyWithImpl<$Res>
    implements _$LeavePreviewPayloadCopyWith<$Res> {
  __$LeavePreviewPayloadCopyWithImpl(this._self, this._then);

  final _LeavePreviewPayload _self;
  final $Res Function(_LeavePreviewPayload) _then;

/// Create a copy of LeavePreviewPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromDate = null,Object? toDate = null,Object? leaveTypeId = freezed,Object? isHalfDay = null,Object? halfDaySession = freezed,}) {
  return _then(_LeavePreviewPayload(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,leaveTypeId: freezed == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String?,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LeavePreviewResponse {

@JsonKey(name: 'from_date') DateTime get fromDate;@JsonKey(name: 'to_date') DateTime get toDate;@JsonKey(name: 'is_half_day') bool get isHalfDay;@JsonKey(name: 'working_days') double get workingDays;@JsonKey(name: 'is_valid') bool get isValid;@JsonKey(name: 'half_day_session') String? get halfDaySession;@JsonKey(name: 'validation_error') String? get validationError;@JsonKey(name: 'available_balance') double? get availableBalance;@JsonKey(name: 'has_overlap') bool get hasOverlap;@JsonKey(name: 'overlapping_request_id') String? get overlappingRequestId;
/// Create a copy of LeavePreviewResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeavePreviewResponseCopyWith<LeavePreviewResponse> get copyWith => _$LeavePreviewResponseCopyWithImpl<LeavePreviewResponse>(this as LeavePreviewResponse, _$identity);

  /// Serializes this LeavePreviewResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeavePreviewResponse&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.hasOverlap, hasOverlap) || other.hasOverlap == hasOverlap)&&(identical(other.overlappingRequestId, overlappingRequestId) || other.overlappingRequestId == overlappingRequestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate,isHalfDay,workingDays,isValid,halfDaySession,validationError,availableBalance,hasOverlap,overlappingRequestId);

@override
String toString() {
  return 'LeavePreviewResponse(fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, workingDays: $workingDays, isValid: $isValid, halfDaySession: $halfDaySession, validationError: $validationError, availableBalance: $availableBalance, hasOverlap: $hasOverlap, overlappingRequestId: $overlappingRequestId)';
}


}

/// @nodoc
abstract mixin class $LeavePreviewResponseCopyWith<$Res>  {
  factory $LeavePreviewResponseCopyWith(LeavePreviewResponse value, $Res Function(LeavePreviewResponse) _then) = _$LeavePreviewResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'from_date') DateTime fromDate,@JsonKey(name: 'to_date') DateTime toDate,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'working_days') double workingDays,@JsonKey(name: 'is_valid') bool isValid,@JsonKey(name: 'half_day_session') String? halfDaySession,@JsonKey(name: 'validation_error') String? validationError,@JsonKey(name: 'available_balance') double? availableBalance,@JsonKey(name: 'has_overlap') bool hasOverlap,@JsonKey(name: 'overlapping_request_id') String? overlappingRequestId
});




}
/// @nodoc
class _$LeavePreviewResponseCopyWithImpl<$Res>
    implements $LeavePreviewResponseCopyWith<$Res> {
  _$LeavePreviewResponseCopyWithImpl(this._self, this._then);

  final LeavePreviewResponse _self;
  final $Res Function(LeavePreviewResponse) _then;

/// Create a copy of LeavePreviewResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromDate = null,Object? toDate = null,Object? isHalfDay = null,Object? workingDays = null,Object? isValid = null,Object? halfDaySession = freezed,Object? validationError = freezed,Object? availableBalance = freezed,Object? hasOverlap = null,Object? overlappingRequestId = freezed,}) {
  return _then(LeavePreviewResponse(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as double,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double?,hasOverlap: null == hasOverlap ? _self.hasOverlap : hasOverlap // ignore: cast_nullable_to_non_nullable
as bool,overlappingRequestId: freezed == overlappingRequestId ? _self.overlappingRequestId : overlappingRequestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeavePreviewResponse].
extension LeavePreviewResponsePatterns on LeavePreviewResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeavePreviewResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeavePreviewResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeavePreviewResponse value)  $default,){
final _that = this;
switch (_that) {
case _LeavePreviewResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeavePreviewResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LeavePreviewResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_date')  DateTime fromDate, @JsonKey(name: 'to_date')  DateTime toDate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'working_days')  double workingDays, @JsonKey(name: 'is_valid')  bool isValid, @JsonKey(name: 'half_day_session')  String? halfDaySession, @JsonKey(name: 'validation_error')  String? validationError, @JsonKey(name: 'available_balance')  double? availableBalance, @JsonKey(name: 'has_overlap')  bool hasOverlap, @JsonKey(name: 'overlapping_request_id')  String? overlappingRequestId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeavePreviewResponse() when $default != null:
return $default(_that.fromDate,_that.toDate,_that.isHalfDay,_that.workingDays,_that.isValid,_that.halfDaySession,_that.validationError,_that.availableBalance,_that.hasOverlap,_that.overlappingRequestId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_date')  DateTime fromDate, @JsonKey(name: 'to_date')  DateTime toDate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'working_days')  double workingDays, @JsonKey(name: 'is_valid')  bool isValid, @JsonKey(name: 'half_day_session')  String? halfDaySession, @JsonKey(name: 'validation_error')  String? validationError, @JsonKey(name: 'available_balance')  double? availableBalance, @JsonKey(name: 'has_overlap')  bool hasOverlap, @JsonKey(name: 'overlapping_request_id')  String? overlappingRequestId)  $default,) {final _that = this;
switch (_that) {
case _LeavePreviewResponse():
return $default(_that.fromDate,_that.toDate,_that.isHalfDay,_that.workingDays,_that.isValid,_that.halfDaySession,_that.validationError,_that.availableBalance,_that.hasOverlap,_that.overlappingRequestId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'from_date')  DateTime fromDate, @JsonKey(name: 'to_date')  DateTime toDate, @JsonKey(name: 'is_half_day')  bool isHalfDay, @JsonKey(name: 'working_days')  double workingDays, @JsonKey(name: 'is_valid')  bool isValid, @JsonKey(name: 'half_day_session')  String? halfDaySession, @JsonKey(name: 'validation_error')  String? validationError, @JsonKey(name: 'available_balance')  double? availableBalance, @JsonKey(name: 'has_overlap')  bool hasOverlap, @JsonKey(name: 'overlapping_request_id')  String? overlappingRequestId)?  $default,) {final _that = this;
switch (_that) {
case _LeavePreviewResponse() when $default != null:
return $default(_that.fromDate,_that.toDate,_that.isHalfDay,_that.workingDays,_that.isValid,_that.halfDaySession,_that.validationError,_that.availableBalance,_that.hasOverlap,_that.overlappingRequestId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeavePreviewResponse implements LeavePreviewResponse {
  const _LeavePreviewResponse({@JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, @JsonKey(name: 'is_half_day') required this.isHalfDay, @JsonKey(name: 'working_days') required this.workingDays, @JsonKey(name: 'is_valid') required this.isValid, @JsonKey(name: 'half_day_session') this.halfDaySession, @JsonKey(name: 'validation_error') this.validationError, @JsonKey(name: 'available_balance') this.availableBalance, @JsonKey(name: 'has_overlap') this.hasOverlap = false, @JsonKey(name: 'overlapping_request_id') this.overlappingRequestId});
  factory _LeavePreviewResponse.fromJson(Map<String, dynamic> json) => _$LeavePreviewResponseFromJson(json);

@override@JsonKey(name: 'from_date') final  DateTime fromDate;
@override@JsonKey(name: 'to_date') final  DateTime toDate;
@override@JsonKey(name: 'is_half_day') final  bool isHalfDay;
@override@JsonKey(name: 'working_days') final  double workingDays;
@override@JsonKey(name: 'is_valid') final  bool isValid;
@override@JsonKey(name: 'half_day_session') final  String? halfDaySession;
@override@JsonKey(name: 'validation_error') final  String? validationError;
@override@JsonKey(name: 'available_balance') final  double? availableBalance;
@override@JsonKey(name: 'has_overlap') final  bool hasOverlap;
@override@JsonKey(name: 'overlapping_request_id') final  String? overlappingRequestId;

/// Create a copy of LeavePreviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeavePreviewResponseCopyWith<_LeavePreviewResponse> get copyWith => __$LeavePreviewResponseCopyWithImpl<_LeavePreviewResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeavePreviewResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeavePreviewResponse&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.hasOverlap, hasOverlap) || other.hasOverlap == hasOverlap)&&(identical(other.overlappingRequestId, overlappingRequestId) || other.overlappingRequestId == overlappingRequestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate,isHalfDay,workingDays,isValid,halfDaySession,validationError,availableBalance,hasOverlap,overlappingRequestId);

@override
String toString() {
  return 'LeavePreviewResponse(fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, workingDays: $workingDays, isValid: $isValid, halfDaySession: $halfDaySession, validationError: $validationError, availableBalance: $availableBalance, hasOverlap: $hasOverlap, overlappingRequestId: $overlappingRequestId)';
}


}

/// @nodoc
abstract mixin class _$LeavePreviewResponseCopyWith<$Res> implements $LeavePreviewResponseCopyWith<$Res> {
  factory _$LeavePreviewResponseCopyWith(_LeavePreviewResponse value, $Res Function(_LeavePreviewResponse) _then) = __$LeavePreviewResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'from_date') DateTime fromDate,@JsonKey(name: 'to_date') DateTime toDate,@JsonKey(name: 'is_half_day') bool isHalfDay,@JsonKey(name: 'working_days') double workingDays,@JsonKey(name: 'is_valid') bool isValid,@JsonKey(name: 'half_day_session') String? halfDaySession,@JsonKey(name: 'validation_error') String? validationError,@JsonKey(name: 'available_balance') double? availableBalance,@JsonKey(name: 'has_overlap') bool hasOverlap,@JsonKey(name: 'overlapping_request_id') String? overlappingRequestId
});




}
/// @nodoc
class __$LeavePreviewResponseCopyWithImpl<$Res>
    implements _$LeavePreviewResponseCopyWith<$Res> {
  __$LeavePreviewResponseCopyWithImpl(this._self, this._then);

  final _LeavePreviewResponse _self;
  final $Res Function(_LeavePreviewResponse) _then;

/// Create a copy of LeavePreviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromDate = null,Object? toDate = null,Object? isHalfDay = null,Object? workingDays = null,Object? isValid = null,Object? halfDaySession = freezed,Object? validationError = freezed,Object? availableBalance = freezed,Object? hasOverlap = null,Object? overlappingRequestId = freezed,}) {
  return _then(_LeavePreviewResponse(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as double,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: freezed == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double?,hasOverlap: null == hasOverlap ? _self.hasOverlap : hasOverlap // ignore: cast_nullable_to_non_nullable
as bool,overlappingRequestId: freezed == overlappingRequestId ? _self.overlappingRequestId : overlappingRequestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HolidayModel {

 String get id; String get name; DateTime get date; int get year;@JsonKey(name: 'is_optional') bool get isOptional;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayModelCopyWith<HolidayModel> get copyWith => _$HolidayModelCopyWithImpl<HolidayModel>(this as HolidayModel, _$identity);

  /// Serializes this HolidayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.year, year) || other.year == year)&&(identical(other.isOptional, isOptional) || other.isOptional == isOptional)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,date,year,isOptional,createdAt);

@override
String toString() {
  return 'HolidayModel(id: $id, name: $name, date: $date, year: $year, isOptional: $isOptional, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HolidayModelCopyWith<$Res>  {
  factory $HolidayModelCopyWith(HolidayModel value, $Res Function(HolidayModel) _then) = _$HolidayModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime date, int year,@JsonKey(name: 'is_optional') bool isOptional,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$HolidayModelCopyWithImpl<$Res>
    implements $HolidayModelCopyWith<$Res> {
  _$HolidayModelCopyWithImpl(this._self, this._then);

  final HolidayModel _self;
  final $Res Function(HolidayModel) _then;

/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? date = null,Object? year = null,Object? isOptional = null,Object? createdAt = freezed,}) {
  return _then(HolidayModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,isOptional: null == isOptional ? _self.isOptional : isOptional // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HolidayModel].
extension HolidayModelPatterns on HolidayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayModel value)  $default,){
final _that = this;
switch (_that) {
case _HolidayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayModel value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime date,  int year, @JsonKey(name: 'is_optional')  bool isOptional, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.year,_that.isOptional,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime date,  int year, @JsonKey(name: 'is_optional')  bool isOptional, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _HolidayModel():
return $default(_that.id,_that.name,_that.date,_that.year,_that.isOptional,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime date,  int year, @JsonKey(name: 'is_optional')  bool isOptional, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.year,_that.isOptional,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HolidayModel implements HolidayModel {
  const _HolidayModel({required this.id, required this.name, required this.date, required this.year, @JsonKey(name: 'is_optional') this.isOptional = false, @JsonKey(name: 'created_at') this.createdAt});
  factory _HolidayModel.fromJson(Map<String, dynamic> json) => _$HolidayModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  DateTime date;
@override final  int year;
@override@JsonKey(name: 'is_optional') final  bool isOptional;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayModelCopyWith<_HolidayModel> get copyWith => __$HolidayModelCopyWithImpl<_HolidayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.year, year) || other.year == year)&&(identical(other.isOptional, isOptional) || other.isOptional == isOptional)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,date,year,isOptional,createdAt);

@override
String toString() {
  return 'HolidayModel(id: $id, name: $name, date: $date, year: $year, isOptional: $isOptional, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HolidayModelCopyWith<$Res> implements $HolidayModelCopyWith<$Res> {
  factory _$HolidayModelCopyWith(_HolidayModel value, $Res Function(_HolidayModel) _then) = __$HolidayModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime date, int year,@JsonKey(name: 'is_optional') bool isOptional,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$HolidayModelCopyWithImpl<$Res>
    implements _$HolidayModelCopyWith<$Res> {
  __$HolidayModelCopyWithImpl(this._self, this._then);

  final _HolidayModel _self;
  final $Res Function(_HolidayModel) _then;

/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? date = null,Object? year = null,Object? isOptional = null,Object? createdAt = freezed,}) {
  return _then(_HolidayModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,isOptional: null == isOptional ? _self.isOptional : isOptional // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$HolidayPageResponse {

 List<HolidayModel> get items; int get total; int get page;@JsonKey(name: 'page_size') int get pageSize;
/// Create a copy of HolidayPageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayPageResponseCopyWith<HolidayPageResponse> get copyWith => _$HolidayPageResponseCopyWithImpl<HolidayPageResponse>(this as HolidayPageResponse, _$identity);

  /// Serializes this HolidayPageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayPageResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,pageSize);

@override
String toString() {
  return 'HolidayPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $HolidayPageResponseCopyWith<$Res>  {
  factory $HolidayPageResponseCopyWith(HolidayPageResponse value, $Res Function(HolidayPageResponse) _then) = _$HolidayPageResponseCopyWithImpl;
@useResult
$Res call({
 List<HolidayModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize
});




}
/// @nodoc
class _$HolidayPageResponseCopyWithImpl<$Res>
    implements $HolidayPageResponseCopyWith<$Res> {
  _$HolidayPageResponseCopyWithImpl(this._self, this._then);

  final HolidayPageResponse _self;
  final $Res Function(HolidayPageResponse) _then;

/// Create a copy of HolidayPageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,}) {
  return _then(HolidayPageResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HolidayModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HolidayPageResponse].
extension HolidayPageResponsePatterns on HolidayPageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayPageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayPageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayPageResponse value)  $default,){
final _that = this;
switch (_that) {
case _HolidayPageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayPageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayPageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HolidayModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HolidayModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _HolidayPageResponse():
return $default(_that.items,_that.total,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HolidayModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _HolidayPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HolidayPageResponse implements HolidayPageResponse {
  const _HolidayPageResponse({required  List<HolidayModel> items, required this.total, required this.page, @JsonKey(name: 'page_size') required this.pageSize}): _items = items;
  factory _HolidayPageResponse.fromJson(Map<String, dynamic> json) => _$HolidayPageResponseFromJson(json);

 final  List<HolidayModel> _items;
@override List<HolidayModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override final  int page;
@override@JsonKey(name: 'page_size') final  int pageSize;

/// Create a copy of HolidayPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayPageResponseCopyWith<_HolidayPageResponse> get copyWith => __$HolidayPageResponseCopyWithImpl<_HolidayPageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayPageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayPageResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,pageSize);

@override
String toString() {
  return 'HolidayPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$HolidayPageResponseCopyWith<$Res> implements $HolidayPageResponseCopyWith<$Res> {
  factory _$HolidayPageResponseCopyWith(_HolidayPageResponse value, $Res Function(_HolidayPageResponse) _then) = __$HolidayPageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<HolidayModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize
});




}
/// @nodoc
class __$HolidayPageResponseCopyWithImpl<$Res>
    implements _$HolidayPageResponseCopyWith<$Res> {
  __$HolidayPageResponseCopyWithImpl(this._self, this._then);

  final _HolidayPageResponse _self;
  final $Res Function(_HolidayPageResponse) _then;

/// Create a copy of HolidayPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_HolidayPageResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HolidayModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
