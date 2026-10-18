// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OfficeLocationModel {

 String get id; String get name; double get latitude; double get longitude; String? get address;@JsonKey(name: 'radius_meters') int get radiusMeters;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of OfficeLocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficeLocationModelCopyWith<OfficeLocationModel> get copyWith => _$OfficeLocationModelCopyWithImpl<OfficeLocationModel>(this as OfficeLocationModel, _$identity);

  /// Serializes this OfficeLocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfficeLocationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,latitude,longitude,address,radiusMeters,isActive);

@override
String toString() {
  return 'OfficeLocationModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, address: $address, radiusMeters: $radiusMeters, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $OfficeLocationModelCopyWith<$Res>  {
  factory $OfficeLocationModelCopyWith(OfficeLocationModel value, $Res Function(OfficeLocationModel) _then) = _$OfficeLocationModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, double latitude, double longitude, String? address,@JsonKey(name: 'radius_meters') int radiusMeters,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$OfficeLocationModelCopyWithImpl<$Res>
    implements $OfficeLocationModelCopyWith<$Res> {
  _$OfficeLocationModelCopyWithImpl(this._self, this._then);

  final OfficeLocationModel _self;
  final $Res Function(OfficeLocationModel) _then;

/// Create a copy of OfficeLocationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? address = freezed,Object? radiusMeters = null,Object? isActive = null,}) {
  return _then(OfficeLocationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OfficeLocationModel].
extension OfficeLocationModelPatterns on OfficeLocationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfficeLocationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfficeLocationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfficeLocationModel value)  $default,){
final _that = this;
switch (_that) {
case _OfficeLocationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfficeLocationModel value)?  $default,){
final _that = this;
switch (_that) {
case _OfficeLocationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double latitude,  double longitude,  String? address, @JsonKey(name: 'radius_meters')  int radiusMeters, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfficeLocationModel() when $default != null:
return $default(_that.id,_that.name,_that.latitude,_that.longitude,_that.address,_that.radiusMeters,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double latitude,  double longitude,  String? address, @JsonKey(name: 'radius_meters')  int radiusMeters, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _OfficeLocationModel():
return $default(_that.id,_that.name,_that.latitude,_that.longitude,_that.address,_that.radiusMeters,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double latitude,  double longitude,  String? address, @JsonKey(name: 'radius_meters')  int radiusMeters, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _OfficeLocationModel() when $default != null:
return $default(_that.id,_that.name,_that.latitude,_that.longitude,_that.address,_that.radiusMeters,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfficeLocationModel implements OfficeLocationModel {
  const _OfficeLocationModel({required this.id, required this.name, required this.latitude, required this.longitude, this.address, @JsonKey(name: 'radius_meters') this.radiusMeters = 100, @JsonKey(name: 'is_active') this.isActive = true});
  factory _OfficeLocationModel.fromJson(Map<String, dynamic> json) => _$OfficeLocationModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  double latitude;
@override final  double longitude;
@override final  String? address;
@override@JsonKey(name: 'radius_meters') final  int radiusMeters;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of OfficeLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfficeLocationModelCopyWith<_OfficeLocationModel> get copyWith => __$OfficeLocationModelCopyWithImpl<_OfficeLocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficeLocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfficeLocationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,latitude,longitude,address,radiusMeters,isActive);

@override
String toString() {
  return 'OfficeLocationModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, address: $address, radiusMeters: $radiusMeters, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$OfficeLocationModelCopyWith<$Res> implements $OfficeLocationModelCopyWith<$Res> {
  factory _$OfficeLocationModelCopyWith(_OfficeLocationModel value, $Res Function(_OfficeLocationModel) _then) = __$OfficeLocationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double latitude, double longitude, String? address,@JsonKey(name: 'radius_meters') int radiusMeters,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$OfficeLocationModelCopyWithImpl<$Res>
    implements _$OfficeLocationModelCopyWith<$Res> {
  __$OfficeLocationModelCopyWithImpl(this._self, this._then);

  final _OfficeLocationModel _self;
  final $Res Function(_OfficeLocationModel) _then;

/// Create a copy of OfficeLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? address = freezed,Object? radiusMeters = null,Object? isActive = null,}) {
  return _then(_OfficeLocationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EffectiveAttendancePolicyModel {

 String get id; String get name;@JsonKey(name: 'shift_start') String get shiftStart;@JsonKey(name: 'shift_end') String get shiftEnd;@JsonKey(name: 'grace_minutes') int get graceMinutes;@JsonKey(name: 'half_day_min_hours') double get halfDayMinHours;@JsonKey(name: 'full_day_min_hours') double get fullDayMinHours;@JsonKey(name: 'week_off_days') List<int> get weekOffDays;@JsonKey(name: 'require_geofence') bool get requireGeofence;@JsonKey(name: 'require_selfie') bool get requireSelfie;@JsonKey(name: 'allowed_locations') List<OfficeLocationModel> get allowedLocations;
/// Create a copy of EffectiveAttendancePolicyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectiveAttendancePolicyModelCopyWith<EffectiveAttendancePolicyModel> get copyWith => _$EffectiveAttendancePolicyModelCopyWithImpl<EffectiveAttendancePolicyModel>(this as EffectiveAttendancePolicyModel, _$identity);

  /// Serializes this EffectiveAttendancePolicyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectiveAttendancePolicyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shiftStart, shiftStart) || other.shiftStart == shiftStart)&&(identical(other.shiftEnd, shiftEnd) || other.shiftEnd == shiftEnd)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.halfDayMinHours, halfDayMinHours) || other.halfDayMinHours == halfDayMinHours)&&(identical(other.fullDayMinHours, fullDayMinHours) || other.fullDayMinHours == fullDayMinHours)&&const DeepCollectionEquality().equals(other.weekOffDays, weekOffDays)&&(identical(other.requireGeofence, requireGeofence) || other.requireGeofence == requireGeofence)&&(identical(other.requireSelfie, requireSelfie) || other.requireSelfie == requireSelfie)&&const DeepCollectionEquality().equals(other.allowedLocations, allowedLocations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shiftStart,shiftEnd,graceMinutes,halfDayMinHours,fullDayMinHours,const DeepCollectionEquality().hash(weekOffDays),requireGeofence,requireSelfie,const DeepCollectionEquality().hash(allowedLocations));

@override
String toString() {
  return 'EffectiveAttendancePolicyModel(id: $id, name: $name, shiftStart: $shiftStart, shiftEnd: $shiftEnd, graceMinutes: $graceMinutes, halfDayMinHours: $halfDayMinHours, fullDayMinHours: $fullDayMinHours, weekOffDays: $weekOffDays, requireGeofence: $requireGeofence, requireSelfie: $requireSelfie, allowedLocations: $allowedLocations)';
}


}

/// @nodoc
abstract mixin class $EffectiveAttendancePolicyModelCopyWith<$Res>  {
  factory $EffectiveAttendancePolicyModelCopyWith(EffectiveAttendancePolicyModel value, $Res Function(EffectiveAttendancePolicyModel) _then) = _$EffectiveAttendancePolicyModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'shift_start') String shiftStart,@JsonKey(name: 'shift_end') String shiftEnd,@JsonKey(name: 'grace_minutes') int graceMinutes,@JsonKey(name: 'half_day_min_hours') double halfDayMinHours,@JsonKey(name: 'full_day_min_hours') double fullDayMinHours,@JsonKey(name: 'week_off_days') List<int> weekOffDays,@JsonKey(name: 'require_geofence') bool requireGeofence,@JsonKey(name: 'require_selfie') bool requireSelfie,@JsonKey(name: 'allowed_locations') List<OfficeLocationModel> allowedLocations
});




}
/// @nodoc
class _$EffectiveAttendancePolicyModelCopyWithImpl<$Res>
    implements $EffectiveAttendancePolicyModelCopyWith<$Res> {
  _$EffectiveAttendancePolicyModelCopyWithImpl(this._self, this._then);

  final EffectiveAttendancePolicyModel _self;
  final $Res Function(EffectiveAttendancePolicyModel) _then;

/// Create a copy of EffectiveAttendancePolicyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shiftStart = null,Object? shiftEnd = null,Object? graceMinutes = null,Object? halfDayMinHours = null,Object? fullDayMinHours = null,Object? weekOffDays = null,Object? requireGeofence = null,Object? requireSelfie = null,Object? allowedLocations = null,}) {
  return _then(EffectiveAttendancePolicyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shiftStart: null == shiftStart ? _self.shiftStart : shiftStart // ignore: cast_nullable_to_non_nullable
as String,shiftEnd: null == shiftEnd ? _self.shiftEnd : shiftEnd // ignore: cast_nullable_to_non_nullable
as String,graceMinutes: null == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int,halfDayMinHours: null == halfDayMinHours ? _self.halfDayMinHours : halfDayMinHours // ignore: cast_nullable_to_non_nullable
as double,fullDayMinHours: null == fullDayMinHours ? _self.fullDayMinHours : fullDayMinHours // ignore: cast_nullable_to_non_nullable
as double,weekOffDays: null == weekOffDays ? _self.weekOffDays : weekOffDays // ignore: cast_nullable_to_non_nullable
as List<int>,requireGeofence: null == requireGeofence ? _self.requireGeofence : requireGeofence // ignore: cast_nullable_to_non_nullable
as bool,requireSelfie: null == requireSelfie ? _self.requireSelfie : requireSelfie // ignore: cast_nullable_to_non_nullable
as bool,allowedLocations: null == allowedLocations ? _self.allowedLocations : allowedLocations // ignore: cast_nullable_to_non_nullable
as List<OfficeLocationModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [EffectiveAttendancePolicyModel].
extension EffectiveAttendancePolicyModelPatterns on EffectiveAttendancePolicyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EffectiveAttendancePolicyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EffectiveAttendancePolicyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EffectiveAttendancePolicyModel value)  $default,){
final _that = this;
switch (_that) {
case _EffectiveAttendancePolicyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EffectiveAttendancePolicyModel value)?  $default,){
final _that = this;
switch (_that) {
case _EffectiveAttendancePolicyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'shift_start')  String shiftStart, @JsonKey(name: 'shift_end')  String shiftEnd, @JsonKey(name: 'grace_minutes')  int graceMinutes, @JsonKey(name: 'half_day_min_hours')  double halfDayMinHours, @JsonKey(name: 'full_day_min_hours')  double fullDayMinHours, @JsonKey(name: 'week_off_days')  List<int> weekOffDays, @JsonKey(name: 'require_geofence')  bool requireGeofence, @JsonKey(name: 'require_selfie')  bool requireSelfie, @JsonKey(name: 'allowed_locations')  List<OfficeLocationModel> allowedLocations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EffectiveAttendancePolicyModel() when $default != null:
return $default(_that.id,_that.name,_that.shiftStart,_that.shiftEnd,_that.graceMinutes,_that.halfDayMinHours,_that.fullDayMinHours,_that.weekOffDays,_that.requireGeofence,_that.requireSelfie,_that.allowedLocations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'shift_start')  String shiftStart, @JsonKey(name: 'shift_end')  String shiftEnd, @JsonKey(name: 'grace_minutes')  int graceMinutes, @JsonKey(name: 'half_day_min_hours')  double halfDayMinHours, @JsonKey(name: 'full_day_min_hours')  double fullDayMinHours, @JsonKey(name: 'week_off_days')  List<int> weekOffDays, @JsonKey(name: 'require_geofence')  bool requireGeofence, @JsonKey(name: 'require_selfie')  bool requireSelfie, @JsonKey(name: 'allowed_locations')  List<OfficeLocationModel> allowedLocations)  $default,) {final _that = this;
switch (_that) {
case _EffectiveAttendancePolicyModel():
return $default(_that.id,_that.name,_that.shiftStart,_that.shiftEnd,_that.graceMinutes,_that.halfDayMinHours,_that.fullDayMinHours,_that.weekOffDays,_that.requireGeofence,_that.requireSelfie,_that.allowedLocations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'shift_start')  String shiftStart, @JsonKey(name: 'shift_end')  String shiftEnd, @JsonKey(name: 'grace_minutes')  int graceMinutes, @JsonKey(name: 'half_day_min_hours')  double halfDayMinHours, @JsonKey(name: 'full_day_min_hours')  double fullDayMinHours, @JsonKey(name: 'week_off_days')  List<int> weekOffDays, @JsonKey(name: 'require_geofence')  bool requireGeofence, @JsonKey(name: 'require_selfie')  bool requireSelfie, @JsonKey(name: 'allowed_locations')  List<OfficeLocationModel> allowedLocations)?  $default,) {final _that = this;
switch (_that) {
case _EffectiveAttendancePolicyModel() when $default != null:
return $default(_that.id,_that.name,_that.shiftStart,_that.shiftEnd,_that.graceMinutes,_that.halfDayMinHours,_that.fullDayMinHours,_that.weekOffDays,_that.requireGeofence,_that.requireSelfie,_that.allowedLocations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EffectiveAttendancePolicyModel implements EffectiveAttendancePolicyModel {
  const _EffectiveAttendancePolicyModel({required this.id, required this.name, @JsonKey(name: 'shift_start') this.shiftStart = '09:30:00', @JsonKey(name: 'shift_end') this.shiftEnd = '18:30:00', @JsonKey(name: 'grace_minutes') this.graceMinutes = 15, @JsonKey(name: 'half_day_min_hours') this.halfDayMinHours = 4.0, @JsonKey(name: 'full_day_min_hours') this.fullDayMinHours = 8.0, @JsonKey(name: 'week_off_days')  List<int> weekOffDays = const <int>[6], @JsonKey(name: 'require_geofence') this.requireGeofence = true, @JsonKey(name: 'require_selfie') this.requireSelfie = false, @JsonKey(name: 'allowed_locations')  List<OfficeLocationModel> allowedLocations = const <OfficeLocationModel>[]}): _weekOffDays = weekOffDays,_allowedLocations = allowedLocations;
  factory _EffectiveAttendancePolicyModel.fromJson(Map<String, dynamic> json) => _$EffectiveAttendancePolicyModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'shift_start') final  String shiftStart;
@override@JsonKey(name: 'shift_end') final  String shiftEnd;
@override@JsonKey(name: 'grace_minutes') final  int graceMinutes;
@override@JsonKey(name: 'half_day_min_hours') final  double halfDayMinHours;
@override@JsonKey(name: 'full_day_min_hours') final  double fullDayMinHours;
 final  List<int> _weekOffDays;
@override@JsonKey(name: 'week_off_days') List<int> get weekOffDays {
  if (_weekOffDays is EqualUnmodifiableListView) return _weekOffDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekOffDays);
}

@override@JsonKey(name: 'require_geofence') final  bool requireGeofence;
@override@JsonKey(name: 'require_selfie') final  bool requireSelfie;
 final  List<OfficeLocationModel> _allowedLocations;
@override@JsonKey(name: 'allowed_locations') List<OfficeLocationModel> get allowedLocations {
  if (_allowedLocations is EqualUnmodifiableListView) return _allowedLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedLocations);
}


/// Create a copy of EffectiveAttendancePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EffectiveAttendancePolicyModelCopyWith<_EffectiveAttendancePolicyModel> get copyWith => __$EffectiveAttendancePolicyModelCopyWithImpl<_EffectiveAttendancePolicyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EffectiveAttendancePolicyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EffectiveAttendancePolicyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shiftStart, shiftStart) || other.shiftStart == shiftStart)&&(identical(other.shiftEnd, shiftEnd) || other.shiftEnd == shiftEnd)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.halfDayMinHours, halfDayMinHours) || other.halfDayMinHours == halfDayMinHours)&&(identical(other.fullDayMinHours, fullDayMinHours) || other.fullDayMinHours == fullDayMinHours)&&const DeepCollectionEquality().equals(other._weekOffDays, _weekOffDays)&&(identical(other.requireGeofence, requireGeofence) || other.requireGeofence == requireGeofence)&&(identical(other.requireSelfie, requireSelfie) || other.requireSelfie == requireSelfie)&&const DeepCollectionEquality().equals(other._allowedLocations, _allowedLocations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shiftStart,shiftEnd,graceMinutes,halfDayMinHours,fullDayMinHours,const DeepCollectionEquality().hash(_weekOffDays),requireGeofence,requireSelfie,const DeepCollectionEquality().hash(_allowedLocations));

@override
String toString() {
  return 'EffectiveAttendancePolicyModel(id: $id, name: $name, shiftStart: $shiftStart, shiftEnd: $shiftEnd, graceMinutes: $graceMinutes, halfDayMinHours: $halfDayMinHours, fullDayMinHours: $fullDayMinHours, weekOffDays: $weekOffDays, requireGeofence: $requireGeofence, requireSelfie: $requireSelfie, allowedLocations: $allowedLocations)';
}


}

/// @nodoc
abstract mixin class _$EffectiveAttendancePolicyModelCopyWith<$Res> implements $EffectiveAttendancePolicyModelCopyWith<$Res> {
  factory _$EffectiveAttendancePolicyModelCopyWith(_EffectiveAttendancePolicyModel value, $Res Function(_EffectiveAttendancePolicyModel) _then) = __$EffectiveAttendancePolicyModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'shift_start') String shiftStart,@JsonKey(name: 'shift_end') String shiftEnd,@JsonKey(name: 'grace_minutes') int graceMinutes,@JsonKey(name: 'half_day_min_hours') double halfDayMinHours,@JsonKey(name: 'full_day_min_hours') double fullDayMinHours,@JsonKey(name: 'week_off_days') List<int> weekOffDays,@JsonKey(name: 'require_geofence') bool requireGeofence,@JsonKey(name: 'require_selfie') bool requireSelfie,@JsonKey(name: 'allowed_locations') List<OfficeLocationModel> allowedLocations
});




}
/// @nodoc
class __$EffectiveAttendancePolicyModelCopyWithImpl<$Res>
    implements _$EffectiveAttendancePolicyModelCopyWith<$Res> {
  __$EffectiveAttendancePolicyModelCopyWithImpl(this._self, this._then);

  final _EffectiveAttendancePolicyModel _self;
  final $Res Function(_EffectiveAttendancePolicyModel) _then;

/// Create a copy of EffectiveAttendancePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shiftStart = null,Object? shiftEnd = null,Object? graceMinutes = null,Object? halfDayMinHours = null,Object? fullDayMinHours = null,Object? weekOffDays = null,Object? requireGeofence = null,Object? requireSelfie = null,Object? allowedLocations = null,}) {
  return _then(_EffectiveAttendancePolicyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shiftStart: null == shiftStart ? _self.shiftStart : shiftStart // ignore: cast_nullable_to_non_nullable
as String,shiftEnd: null == shiftEnd ? _self.shiftEnd : shiftEnd // ignore: cast_nullable_to_non_nullable
as String,graceMinutes: null == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int,halfDayMinHours: null == halfDayMinHours ? _self.halfDayMinHours : halfDayMinHours // ignore: cast_nullable_to_non_nullable
as double,fullDayMinHours: null == fullDayMinHours ? _self.fullDayMinHours : fullDayMinHours // ignore: cast_nullable_to_non_nullable
as double,weekOffDays: null == weekOffDays ? _self._weekOffDays : weekOffDays // ignore: cast_nullable_to_non_nullable
as List<int>,requireGeofence: null == requireGeofence ? _self.requireGeofence : requireGeofence // ignore: cast_nullable_to_non_nullable
as bool,requireSelfie: null == requireSelfie ? _self.requireSelfie : requireSelfie // ignore: cast_nullable_to_non_nullable
as bool,allowedLocations: null == allowedLocations ? _self._allowedLocations : allowedLocations // ignore: cast_nullable_to_non_nullable
as List<OfficeLocationModel>,
  ));
}


}


/// @nodoc
mixin _$AttendanceRecordModel {

 String get id;@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'attendance_date') String get attendanceDate; String get status;@JsonKey(name: 'status_label') String get statusLabel;@JsonKey(name: 'status_color') String get statusColor;@JsonKey(name: 'check_in_at') DateTime? get checkInAt;@JsonKey(name: 'check_out_at') DateTime? get checkOutAt;@JsonKey(name: 'check_in_lat') double? get checkInLat;@JsonKey(name: 'check_in_lng') double? get checkInLng;@JsonKey(name: 'check_out_lat') double? get checkOutLat;@JsonKey(name: 'check_out_lng') double? get checkOutLng;@JsonKey(name: 'device_id') String? get deviceId;@JsonKey(name: 'is_manual') bool get isManual;@JsonKey(name: 'work_hours') double? get workHours; String? get remarks;@JsonKey(name: 'selfie_url') String? get selfieUrl;
/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRecordModelCopyWith<AttendanceRecordModel> get copyWith => _$AttendanceRecordModelCopyWithImpl<AttendanceRecordModel>(this as AttendanceRecordModel, _$identity);

  /// Serializes this AttendanceRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.attendanceDate, attendanceDate) || other.attendanceDate == attendanceDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColor, statusColor) || other.statusColor == statusColor)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.checkInLat, checkInLat) || other.checkInLat == checkInLat)&&(identical(other.checkInLng, checkInLng) || other.checkInLng == checkInLng)&&(identical(other.checkOutLat, checkOutLat) || other.checkOutLat == checkOutLat)&&(identical(other.checkOutLng, checkOutLng) || other.checkOutLng == checkOutLng)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.workHours, workHours) || other.workHours == workHours)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeId,attendanceDate,status,statusLabel,statusColor,checkInAt,checkOutAt,checkInLat,checkInLng,checkOutLat,checkOutLng,deviceId,isManual,workHours,remarks,selfieUrl);

@override
String toString() {
  return 'AttendanceRecordModel(id: $id, employeeId: $employeeId, attendanceDate: $attendanceDate, status: $status, statusLabel: $statusLabel, statusColor: $statusColor, checkInAt: $checkInAt, checkOutAt: $checkOutAt, checkInLat: $checkInLat, checkInLng: $checkInLng, checkOutLat: $checkOutLat, checkOutLng: $checkOutLng, deviceId: $deviceId, isManual: $isManual, workHours: $workHours, remarks: $remarks, selfieUrl: $selfieUrl)';
}


}

/// @nodoc
abstract mixin class $AttendanceRecordModelCopyWith<$Res>  {
  factory $AttendanceRecordModelCopyWith(AttendanceRecordModel value, $Res Function(AttendanceRecordModel) _then) = _$AttendanceRecordModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'attendance_date') String attendanceDate, String status,@JsonKey(name: 'status_label') String statusLabel,@JsonKey(name: 'status_color') String statusColor,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'check_in_lat') double? checkInLat,@JsonKey(name: 'check_in_lng') double? checkInLng,@JsonKey(name: 'check_out_lat') double? checkOutLat,@JsonKey(name: 'check_out_lng') double? checkOutLng,@JsonKey(name: 'device_id') String? deviceId,@JsonKey(name: 'is_manual') bool isManual,@JsonKey(name: 'work_hours') double? workHours, String? remarks,@JsonKey(name: 'selfie_url') String? selfieUrl
});




}
/// @nodoc
class _$AttendanceRecordModelCopyWithImpl<$Res>
    implements $AttendanceRecordModelCopyWith<$Res> {
  _$AttendanceRecordModelCopyWithImpl(this._self, this._then);

  final AttendanceRecordModel _self;
  final $Res Function(AttendanceRecordModel) _then;

/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeId = null,Object? attendanceDate = null,Object? status = null,Object? statusLabel = null,Object? statusColor = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? checkInLat = freezed,Object? checkInLng = freezed,Object? checkOutLat = freezed,Object? checkOutLng = freezed,Object? deviceId = freezed,Object? isManual = null,Object? workHours = freezed,Object? remarks = freezed,Object? selfieUrl = freezed,}) {
  return _then(AttendanceRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,attendanceDate: null == attendanceDate ? _self.attendanceDate : attendanceDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColor: null == statusColor ? _self.statusColor : statusColor // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInLat: freezed == checkInLat ? _self.checkInLat : checkInLat // ignore: cast_nullable_to_non_nullable
as double?,checkInLng: freezed == checkInLng ? _self.checkInLng : checkInLng // ignore: cast_nullable_to_non_nullable
as double?,checkOutLat: freezed == checkOutLat ? _self.checkOutLat : checkOutLat // ignore: cast_nullable_to_non_nullable
as double?,checkOutLng: freezed == checkOutLng ? _self.checkOutLng : checkOutLng // ignore: cast_nullable_to_non_nullable
as double?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,workHours: freezed == workHours ? _self.workHours : workHours // ignore: cast_nullable_to_non_nullable
as double?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,selfieUrl: freezed == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceRecordModel].
extension AttendanceRecordModelPatterns on AttendanceRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'attendance_date')  String attendanceDate,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'check_in_lat')  double? checkInLat, @JsonKey(name: 'check_in_lng')  double? checkInLng, @JsonKey(name: 'check_out_lat')  double? checkOutLat, @JsonKey(name: 'check_out_lng')  double? checkOutLng, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'work_hours')  double? workHours,  String? remarks, @JsonKey(name: 'selfie_url')  String? selfieUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
return $default(_that.id,_that.employeeId,_that.attendanceDate,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.checkInLat,_that.checkInLng,_that.checkOutLat,_that.checkOutLng,_that.deviceId,_that.isManual,_that.workHours,_that.remarks,_that.selfieUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'attendance_date')  String attendanceDate,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'check_in_lat')  double? checkInLat, @JsonKey(name: 'check_in_lng')  double? checkInLng, @JsonKey(name: 'check_out_lat')  double? checkOutLat, @JsonKey(name: 'check_out_lng')  double? checkOutLng, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'work_hours')  double? workHours,  String? remarks, @JsonKey(name: 'selfie_url')  String? selfieUrl)  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecordModel():
return $default(_that.id,_that.employeeId,_that.attendanceDate,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.checkInLat,_that.checkInLng,_that.checkOutLat,_that.checkOutLng,_that.deviceId,_that.isManual,_that.workHours,_that.remarks,_that.selfieUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'attendance_date')  String attendanceDate,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'check_in_lat')  double? checkInLat, @JsonKey(name: 'check_in_lng')  double? checkInLng, @JsonKey(name: 'check_out_lat')  double? checkOutLat, @JsonKey(name: 'check_out_lng')  double? checkOutLng, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'work_hours')  double? workHours,  String? remarks, @JsonKey(name: 'selfie_url')  String? selfieUrl)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
return $default(_that.id,_that.employeeId,_that.attendanceDate,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.checkInLat,_that.checkInLng,_that.checkOutLat,_that.checkOutLng,_that.deviceId,_that.isManual,_that.workHours,_that.remarks,_that.selfieUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceRecordModel extends AttendanceRecordModel {
  const _AttendanceRecordModel({required this.id, @JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'attendance_date') required this.attendanceDate, required this.status, @JsonKey(name: 'status_label') required this.statusLabel, @JsonKey(name: 'status_color') required this.statusColor, @JsonKey(name: 'check_in_at') this.checkInAt, @JsonKey(name: 'check_out_at') this.checkOutAt, @JsonKey(name: 'check_in_lat') this.checkInLat, @JsonKey(name: 'check_in_lng') this.checkInLng, @JsonKey(name: 'check_out_lat') this.checkOutLat, @JsonKey(name: 'check_out_lng') this.checkOutLng, @JsonKey(name: 'device_id') this.deviceId, @JsonKey(name: 'is_manual') this.isManual = false, @JsonKey(name: 'work_hours') this.workHours, this.remarks, @JsonKey(name: 'selfie_url') this.selfieUrl}): super._();
  factory _AttendanceRecordModel.fromJson(Map<String, dynamic> json) => _$AttendanceRecordModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'attendance_date') final  String attendanceDate;
@override final  String status;
@override@JsonKey(name: 'status_label') final  String statusLabel;
@override@JsonKey(name: 'status_color') final  String statusColor;
@override@JsonKey(name: 'check_in_at') final  DateTime? checkInAt;
@override@JsonKey(name: 'check_out_at') final  DateTime? checkOutAt;
@override@JsonKey(name: 'check_in_lat') final  double? checkInLat;
@override@JsonKey(name: 'check_in_lng') final  double? checkInLng;
@override@JsonKey(name: 'check_out_lat') final  double? checkOutLat;
@override@JsonKey(name: 'check_out_lng') final  double? checkOutLng;
@override@JsonKey(name: 'device_id') final  String? deviceId;
@override@JsonKey(name: 'is_manual') final  bool isManual;
@override@JsonKey(name: 'work_hours') final  double? workHours;
@override final  String? remarks;
@override@JsonKey(name: 'selfie_url') final  String? selfieUrl;

/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceRecordModelCopyWith<_AttendanceRecordModel> get copyWith => __$AttendanceRecordModelCopyWithImpl<_AttendanceRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.attendanceDate, attendanceDate) || other.attendanceDate == attendanceDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColor, statusColor) || other.statusColor == statusColor)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.checkInLat, checkInLat) || other.checkInLat == checkInLat)&&(identical(other.checkInLng, checkInLng) || other.checkInLng == checkInLng)&&(identical(other.checkOutLat, checkOutLat) || other.checkOutLat == checkOutLat)&&(identical(other.checkOutLng, checkOutLng) || other.checkOutLng == checkOutLng)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.workHours, workHours) || other.workHours == workHours)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeId,attendanceDate,status,statusLabel,statusColor,checkInAt,checkOutAt,checkInLat,checkInLng,checkOutLat,checkOutLng,deviceId,isManual,workHours,remarks,selfieUrl);

@override
String toString() {
  return 'AttendanceRecordModel(id: $id, employeeId: $employeeId, attendanceDate: $attendanceDate, status: $status, statusLabel: $statusLabel, statusColor: $statusColor, checkInAt: $checkInAt, checkOutAt: $checkOutAt, checkInLat: $checkInLat, checkInLng: $checkInLng, checkOutLat: $checkOutLat, checkOutLng: $checkOutLng, deviceId: $deviceId, isManual: $isManual, workHours: $workHours, remarks: $remarks, selfieUrl: $selfieUrl)';
}


}

/// @nodoc
abstract mixin class _$AttendanceRecordModelCopyWith<$Res> implements $AttendanceRecordModelCopyWith<$Res> {
  factory _$AttendanceRecordModelCopyWith(_AttendanceRecordModel value, $Res Function(_AttendanceRecordModel) _then) = __$AttendanceRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'attendance_date') String attendanceDate, String status,@JsonKey(name: 'status_label') String statusLabel,@JsonKey(name: 'status_color') String statusColor,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'check_in_lat') double? checkInLat,@JsonKey(name: 'check_in_lng') double? checkInLng,@JsonKey(name: 'check_out_lat') double? checkOutLat,@JsonKey(name: 'check_out_lng') double? checkOutLng,@JsonKey(name: 'device_id') String? deviceId,@JsonKey(name: 'is_manual') bool isManual,@JsonKey(name: 'work_hours') double? workHours, String? remarks,@JsonKey(name: 'selfie_url') String? selfieUrl
});




}
/// @nodoc
class __$AttendanceRecordModelCopyWithImpl<$Res>
    implements _$AttendanceRecordModelCopyWith<$Res> {
  __$AttendanceRecordModelCopyWithImpl(this._self, this._then);

  final _AttendanceRecordModel _self;
  final $Res Function(_AttendanceRecordModel) _then;

/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeId = null,Object? attendanceDate = null,Object? status = null,Object? statusLabel = null,Object? statusColor = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? checkInLat = freezed,Object? checkInLng = freezed,Object? checkOutLat = freezed,Object? checkOutLng = freezed,Object? deviceId = freezed,Object? isManual = null,Object? workHours = freezed,Object? remarks = freezed,Object? selfieUrl = freezed,}) {
  return _then(_AttendanceRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,attendanceDate: null == attendanceDate ? _self.attendanceDate : attendanceDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColor: null == statusColor ? _self.statusColor : statusColor // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInLat: freezed == checkInLat ? _self.checkInLat : checkInLat // ignore: cast_nullable_to_non_nullable
as double?,checkInLng: freezed == checkInLng ? _self.checkInLng : checkInLng // ignore: cast_nullable_to_non_nullable
as double?,checkOutLat: freezed == checkOutLat ? _self.checkOutLat : checkOutLat // ignore: cast_nullable_to_non_nullable
as double?,checkOutLng: freezed == checkOutLng ? _self.checkOutLng : checkOutLng // ignore: cast_nullable_to_non_nullable
as double?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,workHours: freezed == workHours ? _self.workHours : workHours // ignore: cast_nullable_to_non_nullable
as double?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,selfieUrl: freezed == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CheckInRequestPayload {

 double get latitude; double get longitude;@JsonKey(name: 'device_id') String get deviceId;@JsonKey(name: 'is_mock_location') bool get isMockLocation;@JsonKey(name: 'selfie_url', includeIfNull: false) String? get selfieUrl;
/// Create a copy of CheckInRequestPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInRequestPayloadCopyWith<CheckInRequestPayload> get copyWith => _$CheckInRequestPayloadCopyWithImpl<CheckInRequestPayload>(this as CheckInRequestPayload, _$identity);

  /// Serializes this CheckInRequestPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInRequestPayload&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isMockLocation, isMockLocation) || other.isMockLocation == isMockLocation)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,deviceId,isMockLocation,selfieUrl);

@override
String toString() {
  return 'CheckInRequestPayload(latitude: $latitude, longitude: $longitude, deviceId: $deviceId, isMockLocation: $isMockLocation, selfieUrl: $selfieUrl)';
}


}

/// @nodoc
abstract mixin class $CheckInRequestPayloadCopyWith<$Res>  {
  factory $CheckInRequestPayloadCopyWith(CheckInRequestPayload value, $Res Function(CheckInRequestPayload) _then) = _$CheckInRequestPayloadCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'is_mock_location') bool isMockLocation,@JsonKey(name: 'selfie_url', includeIfNull: false) String? selfieUrl
});




}
/// @nodoc
class _$CheckInRequestPayloadCopyWithImpl<$Res>
    implements $CheckInRequestPayloadCopyWith<$Res> {
  _$CheckInRequestPayloadCopyWithImpl(this._self, this._then);

  final CheckInRequestPayload _self;
  final $Res Function(CheckInRequestPayload) _then;

/// Create a copy of CheckInRequestPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? deviceId = null,Object? isMockLocation = null,Object? selfieUrl = freezed,}) {
  return _then(CheckInRequestPayload(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,isMockLocation: null == isMockLocation ? _self.isMockLocation : isMockLocation // ignore: cast_nullable_to_non_nullable
as bool,selfieUrl: freezed == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckInRequestPayload].
extension CheckInRequestPayloadPatterns on CheckInRequestPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInRequestPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInRequestPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInRequestPayload value)  $default,){
final _that = this;
switch (_that) {
case _CheckInRequestPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInRequestPayload value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInRequestPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'is_mock_location')  bool isMockLocation, @JsonKey(name: 'selfie_url', includeIfNull: false)  String? selfieUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInRequestPayload() when $default != null:
return $default(_that.latitude,_that.longitude,_that.deviceId,_that.isMockLocation,_that.selfieUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'is_mock_location')  bool isMockLocation, @JsonKey(name: 'selfie_url', includeIfNull: false)  String? selfieUrl)  $default,) {final _that = this;
switch (_that) {
case _CheckInRequestPayload():
return $default(_that.latitude,_that.longitude,_that.deviceId,_that.isMockLocation,_that.selfieUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'is_mock_location')  bool isMockLocation, @JsonKey(name: 'selfie_url', includeIfNull: false)  String? selfieUrl)?  $default,) {final _that = this;
switch (_that) {
case _CheckInRequestPayload() when $default != null:
return $default(_that.latitude,_that.longitude,_that.deviceId,_that.isMockLocation,_that.selfieUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckInRequestPayload implements CheckInRequestPayload {
  const _CheckInRequestPayload({required this.latitude, required this.longitude, @JsonKey(name: 'device_id') required this.deviceId, @JsonKey(name: 'is_mock_location') this.isMockLocation = false, @JsonKey(name: 'selfie_url', includeIfNull: false) this.selfieUrl});
  factory _CheckInRequestPayload.fromJson(Map<String, dynamic> json) => _$CheckInRequestPayloadFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override@JsonKey(name: 'is_mock_location') final  bool isMockLocation;
@override@JsonKey(name: 'selfie_url', includeIfNull: false) final  String? selfieUrl;

/// Create a copy of CheckInRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInRequestPayloadCopyWith<_CheckInRequestPayload> get copyWith => __$CheckInRequestPayloadCopyWithImpl<_CheckInRequestPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckInRequestPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInRequestPayload&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isMockLocation, isMockLocation) || other.isMockLocation == isMockLocation)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,deviceId,isMockLocation,selfieUrl);

@override
String toString() {
  return 'CheckInRequestPayload(latitude: $latitude, longitude: $longitude, deviceId: $deviceId, isMockLocation: $isMockLocation, selfieUrl: $selfieUrl)';
}


}

/// @nodoc
abstract mixin class _$CheckInRequestPayloadCopyWith<$Res> implements $CheckInRequestPayloadCopyWith<$Res> {
  factory _$CheckInRequestPayloadCopyWith(_CheckInRequestPayload value, $Res Function(_CheckInRequestPayload) _then) = __$CheckInRequestPayloadCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'is_mock_location') bool isMockLocation,@JsonKey(name: 'selfie_url', includeIfNull: false) String? selfieUrl
});




}
/// @nodoc
class __$CheckInRequestPayloadCopyWithImpl<$Res>
    implements _$CheckInRequestPayloadCopyWith<$Res> {
  __$CheckInRequestPayloadCopyWithImpl(this._self, this._then);

  final _CheckInRequestPayload _self;
  final $Res Function(_CheckInRequestPayload) _then;

/// Create a copy of CheckInRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? deviceId = null,Object? isMockLocation = null,Object? selfieUrl = freezed,}) {
  return _then(_CheckInRequestPayload(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,isMockLocation: null == isMockLocation ? _self.isMockLocation : isMockLocation // ignore: cast_nullable_to_non_nullable
as bool,selfieUrl: freezed == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CheckOutRequestPayload {

 double get latitude; double get longitude;@JsonKey(name: 'device_id') String get deviceId;@JsonKey(name: 'is_mock_location') bool get isMockLocation;@JsonKey(includeIfNull: false) String? get remarks;
/// Create a copy of CheckOutRequestPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckOutRequestPayloadCopyWith<CheckOutRequestPayload> get copyWith => _$CheckOutRequestPayloadCopyWithImpl<CheckOutRequestPayload>(this as CheckOutRequestPayload, _$identity);

  /// Serializes this CheckOutRequestPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckOutRequestPayload&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isMockLocation, isMockLocation) || other.isMockLocation == isMockLocation)&&(identical(other.remarks, remarks) || other.remarks == remarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,deviceId,isMockLocation,remarks);

@override
String toString() {
  return 'CheckOutRequestPayload(latitude: $latitude, longitude: $longitude, deviceId: $deviceId, isMockLocation: $isMockLocation, remarks: $remarks)';
}


}

/// @nodoc
abstract mixin class $CheckOutRequestPayloadCopyWith<$Res>  {
  factory $CheckOutRequestPayloadCopyWith(CheckOutRequestPayload value, $Res Function(CheckOutRequestPayload) _then) = _$CheckOutRequestPayloadCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'is_mock_location') bool isMockLocation,@JsonKey(includeIfNull: false) String? remarks
});




}
/// @nodoc
class _$CheckOutRequestPayloadCopyWithImpl<$Res>
    implements $CheckOutRequestPayloadCopyWith<$Res> {
  _$CheckOutRequestPayloadCopyWithImpl(this._self, this._then);

  final CheckOutRequestPayload _self;
  final $Res Function(CheckOutRequestPayload) _then;

/// Create a copy of CheckOutRequestPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? deviceId = null,Object? isMockLocation = null,Object? remarks = freezed,}) {
  return _then(CheckOutRequestPayload(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,isMockLocation: null == isMockLocation ? _self.isMockLocation : isMockLocation // ignore: cast_nullable_to_non_nullable
as bool,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckOutRequestPayload].
extension CheckOutRequestPayloadPatterns on CheckOutRequestPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckOutRequestPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckOutRequestPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckOutRequestPayload value)  $default,){
final _that = this;
switch (_that) {
case _CheckOutRequestPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckOutRequestPayload value)?  $default,){
final _that = this;
switch (_that) {
case _CheckOutRequestPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'is_mock_location')  bool isMockLocation, @JsonKey(includeIfNull: false)  String? remarks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckOutRequestPayload() when $default != null:
return $default(_that.latitude,_that.longitude,_that.deviceId,_that.isMockLocation,_that.remarks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'is_mock_location')  bool isMockLocation, @JsonKey(includeIfNull: false)  String? remarks)  $default,) {final _that = this;
switch (_that) {
case _CheckOutRequestPayload():
return $default(_that.latitude,_that.longitude,_that.deviceId,_that.isMockLocation,_that.remarks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'is_mock_location')  bool isMockLocation, @JsonKey(includeIfNull: false)  String? remarks)?  $default,) {final _that = this;
switch (_that) {
case _CheckOutRequestPayload() when $default != null:
return $default(_that.latitude,_that.longitude,_that.deviceId,_that.isMockLocation,_that.remarks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckOutRequestPayload implements CheckOutRequestPayload {
  const _CheckOutRequestPayload({required this.latitude, required this.longitude, @JsonKey(name: 'device_id') required this.deviceId, @JsonKey(name: 'is_mock_location') this.isMockLocation = false, @JsonKey(includeIfNull: false) this.remarks});
  factory _CheckOutRequestPayload.fromJson(Map<String, dynamic> json) => _$CheckOutRequestPayloadFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override@JsonKey(name: 'is_mock_location') final  bool isMockLocation;
@override@JsonKey(includeIfNull: false) final  String? remarks;

/// Create a copy of CheckOutRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckOutRequestPayloadCopyWith<_CheckOutRequestPayload> get copyWith => __$CheckOutRequestPayloadCopyWithImpl<_CheckOutRequestPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckOutRequestPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckOutRequestPayload&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isMockLocation, isMockLocation) || other.isMockLocation == isMockLocation)&&(identical(other.remarks, remarks) || other.remarks == remarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,deviceId,isMockLocation,remarks);

@override
String toString() {
  return 'CheckOutRequestPayload(latitude: $latitude, longitude: $longitude, deviceId: $deviceId, isMockLocation: $isMockLocation, remarks: $remarks)';
}


}

/// @nodoc
abstract mixin class _$CheckOutRequestPayloadCopyWith<$Res> implements $CheckOutRequestPayloadCopyWith<$Res> {
  factory _$CheckOutRequestPayloadCopyWith(_CheckOutRequestPayload value, $Res Function(_CheckOutRequestPayload) _then) = __$CheckOutRequestPayloadCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'is_mock_location') bool isMockLocation,@JsonKey(includeIfNull: false) String? remarks
});




}
/// @nodoc
class __$CheckOutRequestPayloadCopyWithImpl<$Res>
    implements _$CheckOutRequestPayloadCopyWith<$Res> {
  __$CheckOutRequestPayloadCopyWithImpl(this._self, this._then);

  final _CheckOutRequestPayload _self;
  final $Res Function(_CheckOutRequestPayload) _then;

/// Create a copy of CheckOutRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? deviceId = null,Object? isMockLocation = null,Object? remarks = freezed,}) {
  return _then(_CheckOutRequestPayload(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,isMockLocation: null == isMockLocation ? _self.isMockLocation : isMockLocation // ignore: cast_nullable_to_non_nullable
as bool,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AttendanceCalendarDayModel {

 String get date; String get status;@JsonKey(name: 'status_label') String get statusLabel;@JsonKey(name: 'status_color') String get statusColor;@JsonKey(name: 'check_in_at') DateTime? get checkInAt;@JsonKey(name: 'check_out_at') DateTime? get checkOutAt;@JsonKey(name: 'work_hours') double? get workHours;@JsonKey(name: 'is_manual') bool get isManual;@JsonKey(name: 'holiday_name') String? get holidayName;@JsonKey(name: 'leave_type_name') String? get leaveTypeName;
/// Create a copy of AttendanceCalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCalendarDayModelCopyWith<AttendanceCalendarDayModel> get copyWith => _$AttendanceCalendarDayModelCopyWithImpl<AttendanceCalendarDayModel>(this as AttendanceCalendarDayModel, _$identity);

  /// Serializes this AttendanceCalendarDayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCalendarDayModel&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColor, statusColor) || other.statusColor == statusColor)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.workHours, workHours) || other.workHours == workHours)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.holidayName, holidayName) || other.holidayName == holidayName)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,status,statusLabel,statusColor,checkInAt,checkOutAt,workHours,isManual,holidayName,leaveTypeName);

@override
String toString() {
  return 'AttendanceCalendarDayModel(date: $date, status: $status, statusLabel: $statusLabel, statusColor: $statusColor, checkInAt: $checkInAt, checkOutAt: $checkOutAt, workHours: $workHours, isManual: $isManual, holidayName: $holidayName, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class $AttendanceCalendarDayModelCopyWith<$Res>  {
  factory $AttendanceCalendarDayModelCopyWith(AttendanceCalendarDayModel value, $Res Function(AttendanceCalendarDayModel) _then) = _$AttendanceCalendarDayModelCopyWithImpl;
@useResult
$Res call({
 String date, String status,@JsonKey(name: 'status_label') String statusLabel,@JsonKey(name: 'status_color') String statusColor,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'work_hours') double? workHours,@JsonKey(name: 'is_manual') bool isManual,@JsonKey(name: 'holiday_name') String? holidayName,@JsonKey(name: 'leave_type_name') String? leaveTypeName
});




}
/// @nodoc
class _$AttendanceCalendarDayModelCopyWithImpl<$Res>
    implements $AttendanceCalendarDayModelCopyWith<$Res> {
  _$AttendanceCalendarDayModelCopyWithImpl(this._self, this._then);

  final AttendanceCalendarDayModel _self;
  final $Res Function(AttendanceCalendarDayModel) _then;

/// Create a copy of AttendanceCalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? status = null,Object? statusLabel = null,Object? statusColor = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? workHours = freezed,Object? isManual = null,Object? holidayName = freezed,Object? leaveTypeName = freezed,}) {
  return _then(AttendanceCalendarDayModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColor: null == statusColor ? _self.statusColor : statusColor // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,workHours: freezed == workHours ? _self.workHours : workHours // ignore: cast_nullable_to_non_nullable
as double?,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,holidayName: freezed == holidayName ? _self.holidayName : holidayName // ignore: cast_nullable_to_non_nullable
as String?,leaveTypeName: freezed == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceCalendarDayModel].
extension AttendanceCalendarDayModelPatterns on AttendanceCalendarDayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceCalendarDayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceCalendarDayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceCalendarDayModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceCalendarDayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceCalendarDayModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceCalendarDayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'work_hours')  double? workHours, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'leave_type_name')  String? leaveTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceCalendarDayModel() when $default != null:
return $default(_that.date,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.workHours,_that.isManual,_that.holidayName,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'work_hours')  double? workHours, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'leave_type_name')  String? leaveTypeName)  $default,) {final _that = this;
switch (_that) {
case _AttendanceCalendarDayModel():
return $default(_that.date,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.workHours,_that.isManual,_that.holidayName,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'work_hours')  double? workHours, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'leave_type_name')  String? leaveTypeName)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceCalendarDayModel() when $default != null:
return $default(_that.date,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.workHours,_that.isManual,_that.holidayName,_that.leaveTypeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceCalendarDayModel implements AttendanceCalendarDayModel {
  const _AttendanceCalendarDayModel({required this.date, required this.status, @JsonKey(name: 'status_label') required this.statusLabel, @JsonKey(name: 'status_color') required this.statusColor, @JsonKey(name: 'check_in_at') this.checkInAt, @JsonKey(name: 'check_out_at') this.checkOutAt, @JsonKey(name: 'work_hours') this.workHours, @JsonKey(name: 'is_manual') this.isManual = false, @JsonKey(name: 'holiday_name') this.holidayName, @JsonKey(name: 'leave_type_name') this.leaveTypeName});
  factory _AttendanceCalendarDayModel.fromJson(Map<String, dynamic> json) => _$AttendanceCalendarDayModelFromJson(json);

@override final  String date;
@override final  String status;
@override@JsonKey(name: 'status_label') final  String statusLabel;
@override@JsonKey(name: 'status_color') final  String statusColor;
@override@JsonKey(name: 'check_in_at') final  DateTime? checkInAt;
@override@JsonKey(name: 'check_out_at') final  DateTime? checkOutAt;
@override@JsonKey(name: 'work_hours') final  double? workHours;
@override@JsonKey(name: 'is_manual') final  bool isManual;
@override@JsonKey(name: 'holiday_name') final  String? holidayName;
@override@JsonKey(name: 'leave_type_name') final  String? leaveTypeName;

/// Create a copy of AttendanceCalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCalendarDayModelCopyWith<_AttendanceCalendarDayModel> get copyWith => __$AttendanceCalendarDayModelCopyWithImpl<_AttendanceCalendarDayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceCalendarDayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceCalendarDayModel&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColor, statusColor) || other.statusColor == statusColor)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.workHours, workHours) || other.workHours == workHours)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.holidayName, holidayName) || other.holidayName == holidayName)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,status,statusLabel,statusColor,checkInAt,checkOutAt,workHours,isManual,holidayName,leaveTypeName);

@override
String toString() {
  return 'AttendanceCalendarDayModel(date: $date, status: $status, statusLabel: $statusLabel, statusColor: $statusColor, checkInAt: $checkInAt, checkOutAt: $checkOutAt, workHours: $workHours, isManual: $isManual, holidayName: $holidayName, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCalendarDayModelCopyWith<$Res> implements $AttendanceCalendarDayModelCopyWith<$Res> {
  factory _$AttendanceCalendarDayModelCopyWith(_AttendanceCalendarDayModel value, $Res Function(_AttendanceCalendarDayModel) _then) = __$AttendanceCalendarDayModelCopyWithImpl;
@override @useResult
$Res call({
 String date, String status,@JsonKey(name: 'status_label') String statusLabel,@JsonKey(name: 'status_color') String statusColor,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'work_hours') double? workHours,@JsonKey(name: 'is_manual') bool isManual,@JsonKey(name: 'holiday_name') String? holidayName,@JsonKey(name: 'leave_type_name') String? leaveTypeName
});




}
/// @nodoc
class __$AttendanceCalendarDayModelCopyWithImpl<$Res>
    implements _$AttendanceCalendarDayModelCopyWith<$Res> {
  __$AttendanceCalendarDayModelCopyWithImpl(this._self, this._then);

  final _AttendanceCalendarDayModel _self;
  final $Res Function(_AttendanceCalendarDayModel) _then;

/// Create a copy of AttendanceCalendarDayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? status = null,Object? statusLabel = null,Object? statusColor = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? workHours = freezed,Object? isManual = null,Object? holidayName = freezed,Object? leaveTypeName = freezed,}) {
  return _then(_AttendanceCalendarDayModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColor: null == statusColor ? _self.statusColor : statusColor // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,workHours: freezed == workHours ? _self.workHours : workHours // ignore: cast_nullable_to_non_nullable
as double?,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,holidayName: freezed == holidayName ? _self.holidayName : holidayName // ignore: cast_nullable_to_non_nullable
as String?,leaveTypeName: freezed == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AttendanceCalendarModel {

 int get year; int get month;@JsonKey(name: 'total_working_days') int get totalWorkingDays;@JsonKey(name: 'total_present_days') int get totalPresentDays;@JsonKey(name: 'total_absent_days') int get totalAbsentDays;@JsonKey(name: 'total_half_days') int get totalHalfDays;@JsonKey(name: 'total_leave_days') int get totalLeaveDays;@JsonKey(name: 'total_holidays') int get totalHolidays; List<AttendanceCalendarDayModel> get days;
/// Create a copy of AttendanceCalendarModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCalendarModelCopyWith<AttendanceCalendarModel> get copyWith => _$AttendanceCalendarModelCopyWithImpl<AttendanceCalendarModel>(this as AttendanceCalendarModel, _$identity);

  /// Serializes this AttendanceCalendarModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCalendarModel&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalWorkingDays, totalWorkingDays) || other.totalWorkingDays == totalWorkingDays)&&(identical(other.totalPresentDays, totalPresentDays) || other.totalPresentDays == totalPresentDays)&&(identical(other.totalAbsentDays, totalAbsentDays) || other.totalAbsentDays == totalAbsentDays)&&(identical(other.totalHalfDays, totalHalfDays) || other.totalHalfDays == totalHalfDays)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.totalHolidays, totalHolidays) || other.totalHolidays == totalHolidays)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,month,totalWorkingDays,totalPresentDays,totalAbsentDays,totalHalfDays,totalLeaveDays,totalHolidays,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'AttendanceCalendarModel(year: $year, month: $month, totalWorkingDays: $totalWorkingDays, totalPresentDays: $totalPresentDays, totalAbsentDays: $totalAbsentDays, totalHalfDays: $totalHalfDays, totalLeaveDays: $totalLeaveDays, totalHolidays: $totalHolidays, days: $days)';
}


}

/// @nodoc
abstract mixin class $AttendanceCalendarModelCopyWith<$Res>  {
  factory $AttendanceCalendarModelCopyWith(AttendanceCalendarModel value, $Res Function(AttendanceCalendarModel) _then) = _$AttendanceCalendarModelCopyWithImpl;
@useResult
$Res call({
 int year, int month,@JsonKey(name: 'total_working_days') int totalWorkingDays,@JsonKey(name: 'total_present_days') int totalPresentDays,@JsonKey(name: 'total_absent_days') int totalAbsentDays,@JsonKey(name: 'total_half_days') int totalHalfDays,@JsonKey(name: 'total_leave_days') int totalLeaveDays,@JsonKey(name: 'total_holidays') int totalHolidays, List<AttendanceCalendarDayModel> days
});




}
/// @nodoc
class _$AttendanceCalendarModelCopyWithImpl<$Res>
    implements $AttendanceCalendarModelCopyWith<$Res> {
  _$AttendanceCalendarModelCopyWithImpl(this._self, this._then);

  final AttendanceCalendarModel _self;
  final $Res Function(AttendanceCalendarModel) _then;

/// Create a copy of AttendanceCalendarModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? totalWorkingDays = null,Object? totalPresentDays = null,Object? totalAbsentDays = null,Object? totalHalfDays = null,Object? totalLeaveDays = null,Object? totalHolidays = null,Object? days = null,}) {
  return _then(AttendanceCalendarModel(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalWorkingDays: null == totalWorkingDays ? _self.totalWorkingDays : totalWorkingDays // ignore: cast_nullable_to_non_nullable
as int,totalPresentDays: null == totalPresentDays ? _self.totalPresentDays : totalPresentDays // ignore: cast_nullable_to_non_nullable
as int,totalAbsentDays: null == totalAbsentDays ? _self.totalAbsentDays : totalAbsentDays // ignore: cast_nullable_to_non_nullable
as int,totalHalfDays: null == totalHalfDays ? _self.totalHalfDays : totalHalfDays // ignore: cast_nullable_to_non_nullable
as int,totalLeaveDays: null == totalLeaveDays ? _self.totalLeaveDays : totalLeaveDays // ignore: cast_nullable_to_non_nullable
as int,totalHolidays: null == totalHolidays ? _self.totalHolidays : totalHolidays // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<AttendanceCalendarDayModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceCalendarModel].
extension AttendanceCalendarModelPatterns on AttendanceCalendarModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceCalendarModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceCalendarModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceCalendarModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceCalendarModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceCalendarModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceCalendarModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month, @JsonKey(name: 'total_working_days')  int totalWorkingDays, @JsonKey(name: 'total_present_days')  int totalPresentDays, @JsonKey(name: 'total_absent_days')  int totalAbsentDays, @JsonKey(name: 'total_half_days')  int totalHalfDays, @JsonKey(name: 'total_leave_days')  int totalLeaveDays, @JsonKey(name: 'total_holidays')  int totalHolidays,  List<AttendanceCalendarDayModel> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceCalendarModel() when $default != null:
return $default(_that.year,_that.month,_that.totalWorkingDays,_that.totalPresentDays,_that.totalAbsentDays,_that.totalHalfDays,_that.totalLeaveDays,_that.totalHolidays,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month, @JsonKey(name: 'total_working_days')  int totalWorkingDays, @JsonKey(name: 'total_present_days')  int totalPresentDays, @JsonKey(name: 'total_absent_days')  int totalAbsentDays, @JsonKey(name: 'total_half_days')  int totalHalfDays, @JsonKey(name: 'total_leave_days')  int totalLeaveDays, @JsonKey(name: 'total_holidays')  int totalHolidays,  List<AttendanceCalendarDayModel> days)  $default,) {final _that = this;
switch (_that) {
case _AttendanceCalendarModel():
return $default(_that.year,_that.month,_that.totalWorkingDays,_that.totalPresentDays,_that.totalAbsentDays,_that.totalHalfDays,_that.totalLeaveDays,_that.totalHolidays,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month, @JsonKey(name: 'total_working_days')  int totalWorkingDays, @JsonKey(name: 'total_present_days')  int totalPresentDays, @JsonKey(name: 'total_absent_days')  int totalAbsentDays, @JsonKey(name: 'total_half_days')  int totalHalfDays, @JsonKey(name: 'total_leave_days')  int totalLeaveDays, @JsonKey(name: 'total_holidays')  int totalHolidays,  List<AttendanceCalendarDayModel> days)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceCalendarModel() when $default != null:
return $default(_that.year,_that.month,_that.totalWorkingDays,_that.totalPresentDays,_that.totalAbsentDays,_that.totalHalfDays,_that.totalLeaveDays,_that.totalHolidays,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceCalendarModel implements AttendanceCalendarModel {
  const _AttendanceCalendarModel({required this.year, required this.month, @JsonKey(name: 'total_working_days') this.totalWorkingDays = 0, @JsonKey(name: 'total_present_days') this.totalPresentDays = 0, @JsonKey(name: 'total_absent_days') this.totalAbsentDays = 0, @JsonKey(name: 'total_half_days') this.totalHalfDays = 0, @JsonKey(name: 'total_leave_days') this.totalLeaveDays = 0, @JsonKey(name: 'total_holidays') this.totalHolidays = 0,  List<AttendanceCalendarDayModel> days = const <AttendanceCalendarDayModel>[]}): _days = days;
  factory _AttendanceCalendarModel.fromJson(Map<String, dynamic> json) => _$AttendanceCalendarModelFromJson(json);

@override final  int year;
@override final  int month;
@override@JsonKey(name: 'total_working_days') final  int totalWorkingDays;
@override@JsonKey(name: 'total_present_days') final  int totalPresentDays;
@override@JsonKey(name: 'total_absent_days') final  int totalAbsentDays;
@override@JsonKey(name: 'total_half_days') final  int totalHalfDays;
@override@JsonKey(name: 'total_leave_days') final  int totalLeaveDays;
@override@JsonKey(name: 'total_holidays') final  int totalHolidays;
 final  List<AttendanceCalendarDayModel> _days;
@override@JsonKey() List<AttendanceCalendarDayModel> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of AttendanceCalendarModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCalendarModelCopyWith<_AttendanceCalendarModel> get copyWith => __$AttendanceCalendarModelCopyWithImpl<_AttendanceCalendarModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceCalendarModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceCalendarModel&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalWorkingDays, totalWorkingDays) || other.totalWorkingDays == totalWorkingDays)&&(identical(other.totalPresentDays, totalPresentDays) || other.totalPresentDays == totalPresentDays)&&(identical(other.totalAbsentDays, totalAbsentDays) || other.totalAbsentDays == totalAbsentDays)&&(identical(other.totalHalfDays, totalHalfDays) || other.totalHalfDays == totalHalfDays)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.totalHolidays, totalHolidays) || other.totalHolidays == totalHolidays)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,month,totalWorkingDays,totalPresentDays,totalAbsentDays,totalHalfDays,totalLeaveDays,totalHolidays,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'AttendanceCalendarModel(year: $year, month: $month, totalWorkingDays: $totalWorkingDays, totalPresentDays: $totalPresentDays, totalAbsentDays: $totalAbsentDays, totalHalfDays: $totalHalfDays, totalLeaveDays: $totalLeaveDays, totalHolidays: $totalHolidays, days: $days)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCalendarModelCopyWith<$Res> implements $AttendanceCalendarModelCopyWith<$Res> {
  factory _$AttendanceCalendarModelCopyWith(_AttendanceCalendarModel value, $Res Function(_AttendanceCalendarModel) _then) = __$AttendanceCalendarModelCopyWithImpl;
@override @useResult
$Res call({
 int year, int month,@JsonKey(name: 'total_working_days') int totalWorkingDays,@JsonKey(name: 'total_present_days') int totalPresentDays,@JsonKey(name: 'total_absent_days') int totalAbsentDays,@JsonKey(name: 'total_half_days') int totalHalfDays,@JsonKey(name: 'total_leave_days') int totalLeaveDays,@JsonKey(name: 'total_holidays') int totalHolidays, List<AttendanceCalendarDayModel> days
});




}
/// @nodoc
class __$AttendanceCalendarModelCopyWithImpl<$Res>
    implements _$AttendanceCalendarModelCopyWith<$Res> {
  __$AttendanceCalendarModelCopyWithImpl(this._self, this._then);

  final _AttendanceCalendarModel _self;
  final $Res Function(_AttendanceCalendarModel) _then;

/// Create a copy of AttendanceCalendarModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? totalWorkingDays = null,Object? totalPresentDays = null,Object? totalAbsentDays = null,Object? totalHalfDays = null,Object? totalLeaveDays = null,Object? totalHolidays = null,Object? days = null,}) {
  return _then(_AttendanceCalendarModel(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalWorkingDays: null == totalWorkingDays ? _self.totalWorkingDays : totalWorkingDays // ignore: cast_nullable_to_non_nullable
as int,totalPresentDays: null == totalPresentDays ? _self.totalPresentDays : totalPresentDays // ignore: cast_nullable_to_non_nullable
as int,totalAbsentDays: null == totalAbsentDays ? _self.totalAbsentDays : totalAbsentDays // ignore: cast_nullable_to_non_nullable
as int,totalHalfDays: null == totalHalfDays ? _self.totalHalfDays : totalHalfDays // ignore: cast_nullable_to_non_nullable
as int,totalLeaveDays: null == totalLeaveDays ? _self.totalLeaveDays : totalLeaveDays // ignore: cast_nullable_to_non_nullable
as int,totalHolidays: null == totalHolidays ? _self.totalHolidays : totalHolidays // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<AttendanceCalendarDayModel>,
  ));
}


}


/// @nodoc
mixin _$DailyAttendanceRecordModel {

 String get date; String get status;@JsonKey(name: 'status_label') String get statusLabel;@JsonKey(name: 'status_color') String get statusColor;@JsonKey(name: 'check_in_at') DateTime? get checkInAt;@JsonKey(name: 'check_out_at') DateTime? get checkOutAt;@JsonKey(name: 'work_hours') double? get workHours;@JsonKey(name: 'is_manual') bool get isManual;@JsonKey(name: 'correction_applied') bool get correctionApplied; String? get remarks;@JsonKey(name: 'holiday_name') String? get holidayName;@JsonKey(name: 'leave_type_name') String? get leaveTypeName;
/// Create a copy of DailyAttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyAttendanceRecordModelCopyWith<DailyAttendanceRecordModel> get copyWith => _$DailyAttendanceRecordModelCopyWithImpl<DailyAttendanceRecordModel>(this as DailyAttendanceRecordModel, _$identity);

  /// Serializes this DailyAttendanceRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyAttendanceRecordModel&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColor, statusColor) || other.statusColor == statusColor)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.workHours, workHours) || other.workHours == workHours)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.correctionApplied, correctionApplied) || other.correctionApplied == correctionApplied)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.holidayName, holidayName) || other.holidayName == holidayName)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,status,statusLabel,statusColor,checkInAt,checkOutAt,workHours,isManual,correctionApplied,remarks,holidayName,leaveTypeName);

@override
String toString() {
  return 'DailyAttendanceRecordModel(date: $date, status: $status, statusLabel: $statusLabel, statusColor: $statusColor, checkInAt: $checkInAt, checkOutAt: $checkOutAt, workHours: $workHours, isManual: $isManual, correctionApplied: $correctionApplied, remarks: $remarks, holidayName: $holidayName, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class $DailyAttendanceRecordModelCopyWith<$Res>  {
  factory $DailyAttendanceRecordModelCopyWith(DailyAttendanceRecordModel value, $Res Function(DailyAttendanceRecordModel) _then) = _$DailyAttendanceRecordModelCopyWithImpl;
@useResult
$Res call({
 String date, String status,@JsonKey(name: 'status_label') String statusLabel,@JsonKey(name: 'status_color') String statusColor,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'work_hours') double? workHours,@JsonKey(name: 'is_manual') bool isManual,@JsonKey(name: 'correction_applied') bool correctionApplied, String? remarks,@JsonKey(name: 'holiday_name') String? holidayName,@JsonKey(name: 'leave_type_name') String? leaveTypeName
});




}
/// @nodoc
class _$DailyAttendanceRecordModelCopyWithImpl<$Res>
    implements $DailyAttendanceRecordModelCopyWith<$Res> {
  _$DailyAttendanceRecordModelCopyWithImpl(this._self, this._then);

  final DailyAttendanceRecordModel _self;
  final $Res Function(DailyAttendanceRecordModel) _then;

/// Create a copy of DailyAttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? status = null,Object? statusLabel = null,Object? statusColor = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? workHours = freezed,Object? isManual = null,Object? correctionApplied = null,Object? remarks = freezed,Object? holidayName = freezed,Object? leaveTypeName = freezed,}) {
  return _then(DailyAttendanceRecordModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColor: null == statusColor ? _self.statusColor : statusColor // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,workHours: freezed == workHours ? _self.workHours : workHours // ignore: cast_nullable_to_non_nullable
as double?,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,correctionApplied: null == correctionApplied ? _self.correctionApplied : correctionApplied // ignore: cast_nullable_to_non_nullable
as bool,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,holidayName: freezed == holidayName ? _self.holidayName : holidayName // ignore: cast_nullable_to_non_nullable
as String?,leaveTypeName: freezed == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyAttendanceRecordModel].
extension DailyAttendanceRecordModelPatterns on DailyAttendanceRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyAttendanceRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyAttendanceRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyAttendanceRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyAttendanceRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyAttendanceRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyAttendanceRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'work_hours')  double? workHours, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'correction_applied')  bool correctionApplied,  String? remarks, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'leave_type_name')  String? leaveTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyAttendanceRecordModel() when $default != null:
return $default(_that.date,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.workHours,_that.isManual,_that.correctionApplied,_that.remarks,_that.holidayName,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'work_hours')  double? workHours, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'correction_applied')  bool correctionApplied,  String? remarks, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'leave_type_name')  String? leaveTypeName)  $default,) {final _that = this;
switch (_that) {
case _DailyAttendanceRecordModel():
return $default(_that.date,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.workHours,_that.isManual,_that.correctionApplied,_that.remarks,_that.holidayName,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String status, @JsonKey(name: 'status_label')  String statusLabel, @JsonKey(name: 'status_color')  String statusColor, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'work_hours')  double? workHours, @JsonKey(name: 'is_manual')  bool isManual, @JsonKey(name: 'correction_applied')  bool correctionApplied,  String? remarks, @JsonKey(name: 'holiday_name')  String? holidayName, @JsonKey(name: 'leave_type_name')  String? leaveTypeName)?  $default,) {final _that = this;
switch (_that) {
case _DailyAttendanceRecordModel() when $default != null:
return $default(_that.date,_that.status,_that.statusLabel,_that.statusColor,_that.checkInAt,_that.checkOutAt,_that.workHours,_that.isManual,_that.correctionApplied,_that.remarks,_that.holidayName,_that.leaveTypeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyAttendanceRecordModel implements DailyAttendanceRecordModel {
  const _DailyAttendanceRecordModel({required this.date, required this.status, @JsonKey(name: 'status_label') required this.statusLabel, @JsonKey(name: 'status_color') required this.statusColor, @JsonKey(name: 'check_in_at') this.checkInAt, @JsonKey(name: 'check_out_at') this.checkOutAt, @JsonKey(name: 'work_hours') this.workHours, @JsonKey(name: 'is_manual') this.isManual = false, @JsonKey(name: 'correction_applied') this.correctionApplied = false, this.remarks, @JsonKey(name: 'holiday_name') this.holidayName, @JsonKey(name: 'leave_type_name') this.leaveTypeName});
  factory _DailyAttendanceRecordModel.fromJson(Map<String, dynamic> json) => _$DailyAttendanceRecordModelFromJson(json);

@override final  String date;
@override final  String status;
@override@JsonKey(name: 'status_label') final  String statusLabel;
@override@JsonKey(name: 'status_color') final  String statusColor;
@override@JsonKey(name: 'check_in_at') final  DateTime? checkInAt;
@override@JsonKey(name: 'check_out_at') final  DateTime? checkOutAt;
@override@JsonKey(name: 'work_hours') final  double? workHours;
@override@JsonKey(name: 'is_manual') final  bool isManual;
@override@JsonKey(name: 'correction_applied') final  bool correctionApplied;
@override final  String? remarks;
@override@JsonKey(name: 'holiday_name') final  String? holidayName;
@override@JsonKey(name: 'leave_type_name') final  String? leaveTypeName;

/// Create a copy of DailyAttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyAttendanceRecordModelCopyWith<_DailyAttendanceRecordModel> get copyWith => __$DailyAttendanceRecordModelCopyWithImpl<_DailyAttendanceRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyAttendanceRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyAttendanceRecordModel&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColor, statusColor) || other.statusColor == statusColor)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.workHours, workHours) || other.workHours == workHours)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.correctionApplied, correctionApplied) || other.correctionApplied == correctionApplied)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.holidayName, holidayName) || other.holidayName == holidayName)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,status,statusLabel,statusColor,checkInAt,checkOutAt,workHours,isManual,correctionApplied,remarks,holidayName,leaveTypeName);

@override
String toString() {
  return 'DailyAttendanceRecordModel(date: $date, status: $status, statusLabel: $statusLabel, statusColor: $statusColor, checkInAt: $checkInAt, checkOutAt: $checkOutAt, workHours: $workHours, isManual: $isManual, correctionApplied: $correctionApplied, remarks: $remarks, holidayName: $holidayName, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class _$DailyAttendanceRecordModelCopyWith<$Res> implements $DailyAttendanceRecordModelCopyWith<$Res> {
  factory _$DailyAttendanceRecordModelCopyWith(_DailyAttendanceRecordModel value, $Res Function(_DailyAttendanceRecordModel) _then) = __$DailyAttendanceRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String date, String status,@JsonKey(name: 'status_label') String statusLabel,@JsonKey(name: 'status_color') String statusColor,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'work_hours') double? workHours,@JsonKey(name: 'is_manual') bool isManual,@JsonKey(name: 'correction_applied') bool correctionApplied, String? remarks,@JsonKey(name: 'holiday_name') String? holidayName,@JsonKey(name: 'leave_type_name') String? leaveTypeName
});




}
/// @nodoc
class __$DailyAttendanceRecordModelCopyWithImpl<$Res>
    implements _$DailyAttendanceRecordModelCopyWith<$Res> {
  __$DailyAttendanceRecordModelCopyWithImpl(this._self, this._then);

  final _DailyAttendanceRecordModel _self;
  final $Res Function(_DailyAttendanceRecordModel) _then;

/// Create a copy of DailyAttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? status = null,Object? statusLabel = null,Object? statusColor = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? workHours = freezed,Object? isManual = null,Object? correctionApplied = null,Object? remarks = freezed,Object? holidayName = freezed,Object? leaveTypeName = freezed,}) {
  return _then(_DailyAttendanceRecordModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColor: null == statusColor ? _self.statusColor : statusColor // ignore: cast_nullable_to_non_nullable
as String,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,workHours: freezed == workHours ? _self.workHours : workHours // ignore: cast_nullable_to_non_nullable
as double?,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,correctionApplied: null == correctionApplied ? _self.correctionApplied : correctionApplied // ignore: cast_nullable_to_non_nullable
as bool,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,holidayName: freezed == holidayName ? _self.holidayName : holidayName // ignore: cast_nullable_to_non_nullable
as String?,leaveTypeName: freezed == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EmployeeMonthlyReportModel {

@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'full_name') String get fullName; int get year; int get month;@JsonKey(name: 'department_name') String? get departmentName; String? get designation;@JsonKey(name: 'total_days_in_month') int get totalDaysInMonth;@JsonKey(name: 'working_days') int get workingDays;@JsonKey(name: 'present_days') int get presentDays;@JsonKey(name: 'late_days') int get lateDays;@JsonKey(name: 'half_days') int get halfDays;@JsonKey(name: 'absent_days') int get absentDays;@JsonKey(name: 'leave_days') int get leaveDays;@JsonKey(name: 'holiday_days') int get holidayDays;@JsonKey(name: 'week_off_days') int get weekOffDays;@JsonKey(name: 'total_hours_worked') double get totalHoursWorked;@JsonKey(name: 'average_hours_per_day') double get averageHoursPerDay;@JsonKey(name: 'attendance_percentage') double get attendancePercentage;@JsonKey(name: 'daily_records') List<DailyAttendanceRecordModel> get dailyRecords;
/// Create a copy of EmployeeMonthlyReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeMonthlyReportModelCopyWith<EmployeeMonthlyReportModel> get copyWith => _$EmployeeMonthlyReportModelCopyWithImpl<EmployeeMonthlyReportModel>(this as EmployeeMonthlyReportModel, _$identity);

  /// Serializes this EmployeeMonthlyReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeMonthlyReportModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.totalDaysInMonth, totalDaysInMonth) || other.totalDaysInMonth == totalDaysInMonth)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.weekOffDays, weekOffDays) || other.weekOffDays == weekOffDays)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.averageHoursPerDay, averageHoursPerDay) || other.averageHoursPerDay == averageHoursPerDay)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&const DeepCollectionEquality().equals(other.dailyRecords, dailyRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,employeeId,employeeCode,fullName,year,month,departmentName,designation,totalDaysInMonth,workingDays,presentDays,lateDays,halfDays,absentDays,leaveDays,holidayDays,weekOffDays,totalHoursWorked,averageHoursPerDay,attendancePercentage,const DeepCollectionEquality().hash(dailyRecords)]);

@override
String toString() {
  return 'EmployeeMonthlyReportModel(employeeId: $employeeId, employeeCode: $employeeCode, fullName: $fullName, year: $year, month: $month, departmentName: $departmentName, designation: $designation, totalDaysInMonth: $totalDaysInMonth, workingDays: $workingDays, presentDays: $presentDays, lateDays: $lateDays, halfDays: $halfDays, absentDays: $absentDays, leaveDays: $leaveDays, holidayDays: $holidayDays, weekOffDays: $weekOffDays, totalHoursWorked: $totalHoursWorked, averageHoursPerDay: $averageHoursPerDay, attendancePercentage: $attendancePercentage, dailyRecords: $dailyRecords)';
}


}

/// @nodoc
abstract mixin class $EmployeeMonthlyReportModelCopyWith<$Res>  {
  factory $EmployeeMonthlyReportModelCopyWith(EmployeeMonthlyReportModel value, $Res Function(EmployeeMonthlyReportModel) _then) = _$EmployeeMonthlyReportModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, int year, int month,@JsonKey(name: 'department_name') String? departmentName, String? designation,@JsonKey(name: 'total_days_in_month') int totalDaysInMonth,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'week_off_days') int weekOffDays,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'average_hours_per_day') double averageHoursPerDay,@JsonKey(name: 'attendance_percentage') double attendancePercentage,@JsonKey(name: 'daily_records') List<DailyAttendanceRecordModel> dailyRecords
});




}
/// @nodoc
class _$EmployeeMonthlyReportModelCopyWithImpl<$Res>
    implements $EmployeeMonthlyReportModelCopyWith<$Res> {
  _$EmployeeMonthlyReportModelCopyWithImpl(this._self, this._then);

  final EmployeeMonthlyReportModel _self;
  final $Res Function(EmployeeMonthlyReportModel) _then;

/// Create a copy of EmployeeMonthlyReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? employeeCode = null,Object? fullName = null,Object? year = null,Object? month = null,Object? departmentName = freezed,Object? designation = freezed,Object? totalDaysInMonth = null,Object? workingDays = null,Object? presentDays = null,Object? lateDays = null,Object? halfDays = null,Object? absentDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? weekOffDays = null,Object? totalHoursWorked = null,Object? averageHoursPerDay = null,Object? attendancePercentage = null,Object? dailyRecords = null,}) {
  return _then(EmployeeMonthlyReportModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,totalDaysInMonth: null == totalDaysInMonth ? _self.totalDaysInMonth : totalDaysInMonth // ignore: cast_nullable_to_non_nullable
as int,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,weekOffDays: null == weekOffDays ? _self.weekOffDays : weekOffDays // ignore: cast_nullable_to_non_nullable
as int,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,averageHoursPerDay: null == averageHoursPerDay ? _self.averageHoursPerDay : averageHoursPerDay // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,dailyRecords: null == dailyRecords ? _self.dailyRecords : dailyRecords // ignore: cast_nullable_to_non_nullable
as List<DailyAttendanceRecordModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeMonthlyReportModel].
extension EmployeeMonthlyReportModelPatterns on EmployeeMonthlyReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeMonthlyReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeMonthlyReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeMonthlyReportModel value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeMonthlyReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeMonthlyReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeMonthlyReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  int year,  int month, @JsonKey(name: 'department_name')  String? departmentName,  String? designation, @JsonKey(name: 'total_days_in_month')  int totalDaysInMonth, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'week_off_days')  int weekOffDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'average_hours_per_day')  double averageHoursPerDay, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'daily_records')  List<DailyAttendanceRecordModel> dailyRecords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeMonthlyReportModel() when $default != null:
return $default(_that.employeeId,_that.employeeCode,_that.fullName,_that.year,_that.month,_that.departmentName,_that.designation,_that.totalDaysInMonth,_that.workingDays,_that.presentDays,_that.lateDays,_that.halfDays,_that.absentDays,_that.leaveDays,_that.holidayDays,_that.weekOffDays,_that.totalHoursWorked,_that.averageHoursPerDay,_that.attendancePercentage,_that.dailyRecords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  int year,  int month, @JsonKey(name: 'department_name')  String? departmentName,  String? designation, @JsonKey(name: 'total_days_in_month')  int totalDaysInMonth, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'week_off_days')  int weekOffDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'average_hours_per_day')  double averageHoursPerDay, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'daily_records')  List<DailyAttendanceRecordModel> dailyRecords)  $default,) {final _that = this;
switch (_that) {
case _EmployeeMonthlyReportModel():
return $default(_that.employeeId,_that.employeeCode,_that.fullName,_that.year,_that.month,_that.departmentName,_that.designation,_that.totalDaysInMonth,_that.workingDays,_that.presentDays,_that.lateDays,_that.halfDays,_that.absentDays,_that.leaveDays,_that.holidayDays,_that.weekOffDays,_that.totalHoursWorked,_that.averageHoursPerDay,_that.attendancePercentage,_that.dailyRecords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  int year,  int month, @JsonKey(name: 'department_name')  String? departmentName,  String? designation, @JsonKey(name: 'total_days_in_month')  int totalDaysInMonth, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'week_off_days')  int weekOffDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'average_hours_per_day')  double averageHoursPerDay, @JsonKey(name: 'attendance_percentage')  double attendancePercentage, @JsonKey(name: 'daily_records')  List<DailyAttendanceRecordModel> dailyRecords)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeMonthlyReportModel() when $default != null:
return $default(_that.employeeId,_that.employeeCode,_that.fullName,_that.year,_that.month,_that.departmentName,_that.designation,_that.totalDaysInMonth,_that.workingDays,_that.presentDays,_that.lateDays,_that.halfDays,_that.absentDays,_that.leaveDays,_that.holidayDays,_that.weekOffDays,_that.totalHoursWorked,_that.averageHoursPerDay,_that.attendancePercentage,_that.dailyRecords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeMonthlyReportModel implements EmployeeMonthlyReportModel {
  const _EmployeeMonthlyReportModel({@JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'full_name') required this.fullName, required this.year, required this.month, @JsonKey(name: 'department_name') this.departmentName, this.designation, @JsonKey(name: 'total_days_in_month') this.totalDaysInMonth = 0, @JsonKey(name: 'working_days') this.workingDays = 0, @JsonKey(name: 'present_days') this.presentDays = 0, @JsonKey(name: 'late_days') this.lateDays = 0, @JsonKey(name: 'half_days') this.halfDays = 0, @JsonKey(name: 'absent_days') this.absentDays = 0, @JsonKey(name: 'leave_days') this.leaveDays = 0, @JsonKey(name: 'holiday_days') this.holidayDays = 0, @JsonKey(name: 'week_off_days') this.weekOffDays = 0, @JsonKey(name: 'total_hours_worked') this.totalHoursWorked = 0.0, @JsonKey(name: 'average_hours_per_day') this.averageHoursPerDay = 0.0, @JsonKey(name: 'attendance_percentage') this.attendancePercentage = 0.0, @JsonKey(name: 'daily_records')  List<DailyAttendanceRecordModel> dailyRecords = const <DailyAttendanceRecordModel>[]}): _dailyRecords = dailyRecords;
  factory _EmployeeMonthlyReportModel.fromJson(Map<String, dynamic> json) => _$EmployeeMonthlyReportModelFromJson(json);

@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  int year;
@override final  int month;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override final  String? designation;
@override@JsonKey(name: 'total_days_in_month') final  int totalDaysInMonth;
@override@JsonKey(name: 'working_days') final  int workingDays;
@override@JsonKey(name: 'present_days') final  int presentDays;
@override@JsonKey(name: 'late_days') final  int lateDays;
@override@JsonKey(name: 'half_days') final  int halfDays;
@override@JsonKey(name: 'absent_days') final  int absentDays;
@override@JsonKey(name: 'leave_days') final  int leaveDays;
@override@JsonKey(name: 'holiday_days') final  int holidayDays;
@override@JsonKey(name: 'week_off_days') final  int weekOffDays;
@override@JsonKey(name: 'total_hours_worked') final  double totalHoursWorked;
@override@JsonKey(name: 'average_hours_per_day') final  double averageHoursPerDay;
@override@JsonKey(name: 'attendance_percentage') final  double attendancePercentage;
 final  List<DailyAttendanceRecordModel> _dailyRecords;
@override@JsonKey(name: 'daily_records') List<DailyAttendanceRecordModel> get dailyRecords {
  if (_dailyRecords is EqualUnmodifiableListView) return _dailyRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyRecords);
}


/// Create a copy of EmployeeMonthlyReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeMonthlyReportModelCopyWith<_EmployeeMonthlyReportModel> get copyWith => __$EmployeeMonthlyReportModelCopyWithImpl<_EmployeeMonthlyReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeMonthlyReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeMonthlyReportModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.totalDaysInMonth, totalDaysInMonth) || other.totalDaysInMonth == totalDaysInMonth)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.weekOffDays, weekOffDays) || other.weekOffDays == weekOffDays)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.averageHoursPerDay, averageHoursPerDay) || other.averageHoursPerDay == averageHoursPerDay)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&const DeepCollectionEquality().equals(other._dailyRecords, _dailyRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,employeeId,employeeCode,fullName,year,month,departmentName,designation,totalDaysInMonth,workingDays,presentDays,lateDays,halfDays,absentDays,leaveDays,holidayDays,weekOffDays,totalHoursWorked,averageHoursPerDay,attendancePercentage,const DeepCollectionEquality().hash(_dailyRecords)]);

@override
String toString() {
  return 'EmployeeMonthlyReportModel(employeeId: $employeeId, employeeCode: $employeeCode, fullName: $fullName, year: $year, month: $month, departmentName: $departmentName, designation: $designation, totalDaysInMonth: $totalDaysInMonth, workingDays: $workingDays, presentDays: $presentDays, lateDays: $lateDays, halfDays: $halfDays, absentDays: $absentDays, leaveDays: $leaveDays, holidayDays: $holidayDays, weekOffDays: $weekOffDays, totalHoursWorked: $totalHoursWorked, averageHoursPerDay: $averageHoursPerDay, attendancePercentage: $attendancePercentage, dailyRecords: $dailyRecords)';
}


}

/// @nodoc
abstract mixin class _$EmployeeMonthlyReportModelCopyWith<$Res> implements $EmployeeMonthlyReportModelCopyWith<$Res> {
  factory _$EmployeeMonthlyReportModelCopyWith(_EmployeeMonthlyReportModel value, $Res Function(_EmployeeMonthlyReportModel) _then) = __$EmployeeMonthlyReportModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, int year, int month,@JsonKey(name: 'department_name') String? departmentName, String? designation,@JsonKey(name: 'total_days_in_month') int totalDaysInMonth,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'week_off_days') int weekOffDays,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'average_hours_per_day') double averageHoursPerDay,@JsonKey(name: 'attendance_percentage') double attendancePercentage,@JsonKey(name: 'daily_records') List<DailyAttendanceRecordModel> dailyRecords
});




}
/// @nodoc
class __$EmployeeMonthlyReportModelCopyWithImpl<$Res>
    implements _$EmployeeMonthlyReportModelCopyWith<$Res> {
  __$EmployeeMonthlyReportModelCopyWithImpl(this._self, this._then);

  final _EmployeeMonthlyReportModel _self;
  final $Res Function(_EmployeeMonthlyReportModel) _then;

/// Create a copy of EmployeeMonthlyReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeCode = null,Object? fullName = null,Object? year = null,Object? month = null,Object? departmentName = freezed,Object? designation = freezed,Object? totalDaysInMonth = null,Object? workingDays = null,Object? presentDays = null,Object? lateDays = null,Object? halfDays = null,Object? absentDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? weekOffDays = null,Object? totalHoursWorked = null,Object? averageHoursPerDay = null,Object? attendancePercentage = null,Object? dailyRecords = null,}) {
  return _then(_EmployeeMonthlyReportModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,totalDaysInMonth: null == totalDaysInMonth ? _self.totalDaysInMonth : totalDaysInMonth // ignore: cast_nullable_to_non_nullable
as int,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,weekOffDays: null == weekOffDays ? _self.weekOffDays : weekOffDays // ignore: cast_nullable_to_non_nullable
as int,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,averageHoursPerDay: null == averageHoursPerDay ? _self.averageHoursPerDay : averageHoursPerDay // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,dailyRecords: null == dailyRecords ? _self._dailyRecords : dailyRecords // ignore: cast_nullable_to_non_nullable
as List<DailyAttendanceRecordModel>,
  ));
}


}


/// @nodoc
mixin _$MonthSummaryItemModel {

 int get month;@JsonKey(name: 'month_name') String get monthName;@JsonKey(name: 'working_days') int get workingDays;@JsonKey(name: 'present_days') int get presentDays;@JsonKey(name: 'late_days') int get lateDays;@JsonKey(name: 'half_days') int get halfDays;@JsonKey(name: 'absent_days') int get absentDays;@JsonKey(name: 'leave_days') int get leaveDays;@JsonKey(name: 'holiday_days') int get holidayDays;@JsonKey(name: 'total_hours_worked') double get totalHoursWorked;@JsonKey(name: 'attendance_percentage') double get attendancePercentage;
/// Create a copy of MonthSummaryItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthSummaryItemModelCopyWith<MonthSummaryItemModel> get copyWith => _$MonthSummaryItemModelCopyWithImpl<MonthSummaryItemModel>(this as MonthSummaryItemModel, _$identity);

  /// Serializes this MonthSummaryItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummaryItemModel&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,monthName,workingDays,presentDays,lateDays,halfDays,absentDays,leaveDays,holidayDays,totalHoursWorked,attendancePercentage);

@override
String toString() {
  return 'MonthSummaryItemModel(month: $month, monthName: $monthName, workingDays: $workingDays, presentDays: $presentDays, lateDays: $lateDays, halfDays: $halfDays, absentDays: $absentDays, leaveDays: $leaveDays, holidayDays: $holidayDays, totalHoursWorked: $totalHoursWorked, attendancePercentage: $attendancePercentage)';
}


}

/// @nodoc
abstract mixin class $MonthSummaryItemModelCopyWith<$Res>  {
  factory $MonthSummaryItemModelCopyWith(MonthSummaryItemModel value, $Res Function(MonthSummaryItemModel) _then) = _$MonthSummaryItemModelCopyWithImpl;
@useResult
$Res call({
 int month,@JsonKey(name: 'month_name') String monthName,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'attendance_percentage') double attendancePercentage
});




}
/// @nodoc
class _$MonthSummaryItemModelCopyWithImpl<$Res>
    implements $MonthSummaryItemModelCopyWith<$Res> {
  _$MonthSummaryItemModelCopyWithImpl(this._self, this._then);

  final MonthSummaryItemModel _self;
  final $Res Function(MonthSummaryItemModel) _then;

/// Create a copy of MonthSummaryItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? monthName = null,Object? workingDays = null,Object? presentDays = null,Object? lateDays = null,Object? halfDays = null,Object? absentDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? totalHoursWorked = null,Object? attendancePercentage = null,}) {
  return _then(MonthSummaryItemModel(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,monthName: null == monthName ? _self.monthName : monthName // ignore: cast_nullable_to_non_nullable
as String,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthSummaryItemModel].
extension MonthSummaryItemModelPatterns on MonthSummaryItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthSummaryItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthSummaryItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthSummaryItemModel value)  $default,){
final _that = this;
switch (_that) {
case _MonthSummaryItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthSummaryItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _MonthSummaryItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int month, @JsonKey(name: 'month_name')  String monthName, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'attendance_percentage')  double attendancePercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthSummaryItemModel() when $default != null:
return $default(_that.month,_that.monthName,_that.workingDays,_that.presentDays,_that.lateDays,_that.halfDays,_that.absentDays,_that.leaveDays,_that.holidayDays,_that.totalHoursWorked,_that.attendancePercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int month, @JsonKey(name: 'month_name')  String monthName, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'attendance_percentage')  double attendancePercentage)  $default,) {final _that = this;
switch (_that) {
case _MonthSummaryItemModel():
return $default(_that.month,_that.monthName,_that.workingDays,_that.presentDays,_that.lateDays,_that.halfDays,_that.absentDays,_that.leaveDays,_that.holidayDays,_that.totalHoursWorked,_that.attendancePercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int month, @JsonKey(name: 'month_name')  String monthName, @JsonKey(name: 'working_days')  int workingDays, @JsonKey(name: 'present_days')  int presentDays, @JsonKey(name: 'late_days')  int lateDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'leave_days')  int leaveDays, @JsonKey(name: 'holiday_days')  int holidayDays, @JsonKey(name: 'total_hours_worked')  double totalHoursWorked, @JsonKey(name: 'attendance_percentage')  double attendancePercentage)?  $default,) {final _that = this;
switch (_that) {
case _MonthSummaryItemModel() when $default != null:
return $default(_that.month,_that.monthName,_that.workingDays,_that.presentDays,_that.lateDays,_that.halfDays,_that.absentDays,_that.leaveDays,_that.holidayDays,_that.totalHoursWorked,_that.attendancePercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthSummaryItemModel implements MonthSummaryItemModel {
  const _MonthSummaryItemModel({required this.month, @JsonKey(name: 'month_name') required this.monthName, @JsonKey(name: 'working_days') this.workingDays = 0, @JsonKey(name: 'present_days') this.presentDays = 0, @JsonKey(name: 'late_days') this.lateDays = 0, @JsonKey(name: 'half_days') this.halfDays = 0, @JsonKey(name: 'absent_days') this.absentDays = 0, @JsonKey(name: 'leave_days') this.leaveDays = 0, @JsonKey(name: 'holiday_days') this.holidayDays = 0, @JsonKey(name: 'total_hours_worked') this.totalHoursWorked = 0.0, @JsonKey(name: 'attendance_percentage') this.attendancePercentage = 0.0});
  factory _MonthSummaryItemModel.fromJson(Map<String, dynamic> json) => _$MonthSummaryItemModelFromJson(json);

@override final  int month;
@override@JsonKey(name: 'month_name') final  String monthName;
@override@JsonKey(name: 'working_days') final  int workingDays;
@override@JsonKey(name: 'present_days') final  int presentDays;
@override@JsonKey(name: 'late_days') final  int lateDays;
@override@JsonKey(name: 'half_days') final  int halfDays;
@override@JsonKey(name: 'absent_days') final  int absentDays;
@override@JsonKey(name: 'leave_days') final  int leaveDays;
@override@JsonKey(name: 'holiday_days') final  int holidayDays;
@override@JsonKey(name: 'total_hours_worked') final  double totalHoursWorked;
@override@JsonKey(name: 'attendance_percentage') final  double attendancePercentage;

/// Create a copy of MonthSummaryItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthSummaryItemModelCopyWith<_MonthSummaryItemModel> get copyWith => __$MonthSummaryItemModelCopyWithImpl<_MonthSummaryItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthSummaryItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthSummaryItemModel&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.lateDays, lateDays) || other.lateDays == lateDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.leaveDays, leaveDays) || other.leaveDays == leaveDays)&&(identical(other.holidayDays, holidayDays) || other.holidayDays == holidayDays)&&(identical(other.totalHoursWorked, totalHoursWorked) || other.totalHoursWorked == totalHoursWorked)&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,monthName,workingDays,presentDays,lateDays,halfDays,absentDays,leaveDays,holidayDays,totalHoursWorked,attendancePercentage);

@override
String toString() {
  return 'MonthSummaryItemModel(month: $month, monthName: $monthName, workingDays: $workingDays, presentDays: $presentDays, lateDays: $lateDays, halfDays: $halfDays, absentDays: $absentDays, leaveDays: $leaveDays, holidayDays: $holidayDays, totalHoursWorked: $totalHoursWorked, attendancePercentage: $attendancePercentage)';
}


}

/// @nodoc
abstract mixin class _$MonthSummaryItemModelCopyWith<$Res> implements $MonthSummaryItemModelCopyWith<$Res> {
  factory _$MonthSummaryItemModelCopyWith(_MonthSummaryItemModel value, $Res Function(_MonthSummaryItemModel) _then) = __$MonthSummaryItemModelCopyWithImpl;
@override @useResult
$Res call({
 int month,@JsonKey(name: 'month_name') String monthName,@JsonKey(name: 'working_days') int workingDays,@JsonKey(name: 'present_days') int presentDays,@JsonKey(name: 'late_days') int lateDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'leave_days') int leaveDays,@JsonKey(name: 'holiday_days') int holidayDays,@JsonKey(name: 'total_hours_worked') double totalHoursWorked,@JsonKey(name: 'attendance_percentage') double attendancePercentage
});




}
/// @nodoc
class __$MonthSummaryItemModelCopyWithImpl<$Res>
    implements _$MonthSummaryItemModelCopyWith<$Res> {
  __$MonthSummaryItemModelCopyWithImpl(this._self, this._then);

  final _MonthSummaryItemModel _self;
  final $Res Function(_MonthSummaryItemModel) _then;

/// Create a copy of MonthSummaryItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? monthName = null,Object? workingDays = null,Object? presentDays = null,Object? lateDays = null,Object? halfDays = null,Object? absentDays = null,Object? leaveDays = null,Object? holidayDays = null,Object? totalHoursWorked = null,Object? attendancePercentage = null,}) {
  return _then(_MonthSummaryItemModel(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,monthName: null == monthName ? _self.monthName : monthName // ignore: cast_nullable_to_non_nullable
as String,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as int,presentDays: null == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int,lateDays: null == lateDays ? _self.lateDays : lateDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,leaveDays: null == leaveDays ? _self.leaveDays : leaveDays // ignore: cast_nullable_to_non_nullable
as int,holidayDays: null == holidayDays ? _self.holidayDays : holidayDays // ignore: cast_nullable_to_non_nullable
as int,totalHoursWorked: null == totalHoursWorked ? _self.totalHoursWorked : totalHoursWorked // ignore: cast_nullable_to_non_nullable
as double,attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EmployeeYearlyReportModel {

@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'full_name') String get fullName; int get year;@JsonKey(name: 'department_name') String? get departmentName;@JsonKey(name: 'annual_working_days') int get annualWorkingDays;@JsonKey(name: 'annual_present_days') int get annualPresentDays;@JsonKey(name: 'annual_absent_days') int get annualAbsentDays;@JsonKey(name: 'annual_leave_days') int get annualLeaveDays;@JsonKey(name: 'annual_total_hours') double get annualTotalHours;@JsonKey(name: 'annual_attendance_percentage') double get annualAttendancePercentage; List<MonthSummaryItemModel> get months;
/// Create a copy of EmployeeYearlyReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeYearlyReportModelCopyWith<EmployeeYearlyReportModel> get copyWith => _$EmployeeYearlyReportModelCopyWithImpl<EmployeeYearlyReportModel>(this as EmployeeYearlyReportModel, _$identity);

  /// Serializes this EmployeeYearlyReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeYearlyReportModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.year, year) || other.year == year)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.annualWorkingDays, annualWorkingDays) || other.annualWorkingDays == annualWorkingDays)&&(identical(other.annualPresentDays, annualPresentDays) || other.annualPresentDays == annualPresentDays)&&(identical(other.annualAbsentDays, annualAbsentDays) || other.annualAbsentDays == annualAbsentDays)&&(identical(other.annualLeaveDays, annualLeaveDays) || other.annualLeaveDays == annualLeaveDays)&&(identical(other.annualTotalHours, annualTotalHours) || other.annualTotalHours == annualTotalHours)&&(identical(other.annualAttendancePercentage, annualAttendancePercentage) || other.annualAttendancePercentage == annualAttendancePercentage)&&const DeepCollectionEquality().equals(other.months, months));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeCode,fullName,year,departmentName,annualWorkingDays,annualPresentDays,annualAbsentDays,annualLeaveDays,annualTotalHours,annualAttendancePercentage,const DeepCollectionEquality().hash(months));

@override
String toString() {
  return 'EmployeeYearlyReportModel(employeeId: $employeeId, employeeCode: $employeeCode, fullName: $fullName, year: $year, departmentName: $departmentName, annualWorkingDays: $annualWorkingDays, annualPresentDays: $annualPresentDays, annualAbsentDays: $annualAbsentDays, annualLeaveDays: $annualLeaveDays, annualTotalHours: $annualTotalHours, annualAttendancePercentage: $annualAttendancePercentage, months: $months)';
}


}

/// @nodoc
abstract mixin class $EmployeeYearlyReportModelCopyWith<$Res>  {
  factory $EmployeeYearlyReportModelCopyWith(EmployeeYearlyReportModel value, $Res Function(EmployeeYearlyReportModel) _then) = _$EmployeeYearlyReportModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, int year,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'annual_working_days') int annualWorkingDays,@JsonKey(name: 'annual_present_days') int annualPresentDays,@JsonKey(name: 'annual_absent_days') int annualAbsentDays,@JsonKey(name: 'annual_leave_days') int annualLeaveDays,@JsonKey(name: 'annual_total_hours') double annualTotalHours,@JsonKey(name: 'annual_attendance_percentage') double annualAttendancePercentage, List<MonthSummaryItemModel> months
});




}
/// @nodoc
class _$EmployeeYearlyReportModelCopyWithImpl<$Res>
    implements $EmployeeYearlyReportModelCopyWith<$Res> {
  _$EmployeeYearlyReportModelCopyWithImpl(this._self, this._then);

  final EmployeeYearlyReportModel _self;
  final $Res Function(EmployeeYearlyReportModel) _then;

/// Create a copy of EmployeeYearlyReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? employeeCode = null,Object? fullName = null,Object? year = null,Object? departmentName = freezed,Object? annualWorkingDays = null,Object? annualPresentDays = null,Object? annualAbsentDays = null,Object? annualLeaveDays = null,Object? annualTotalHours = null,Object? annualAttendancePercentage = null,Object? months = null,}) {
  return _then(EmployeeYearlyReportModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,annualWorkingDays: null == annualWorkingDays ? _self.annualWorkingDays : annualWorkingDays // ignore: cast_nullable_to_non_nullable
as int,annualPresentDays: null == annualPresentDays ? _self.annualPresentDays : annualPresentDays // ignore: cast_nullable_to_non_nullable
as int,annualAbsentDays: null == annualAbsentDays ? _self.annualAbsentDays : annualAbsentDays // ignore: cast_nullable_to_non_nullable
as int,annualLeaveDays: null == annualLeaveDays ? _self.annualLeaveDays : annualLeaveDays // ignore: cast_nullable_to_non_nullable
as int,annualTotalHours: null == annualTotalHours ? _self.annualTotalHours : annualTotalHours // ignore: cast_nullable_to_non_nullable
as double,annualAttendancePercentage: null == annualAttendancePercentage ? _self.annualAttendancePercentage : annualAttendancePercentage // ignore: cast_nullable_to_non_nullable
as double,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as List<MonthSummaryItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeYearlyReportModel].
extension EmployeeYearlyReportModelPatterns on EmployeeYearlyReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeYearlyReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeYearlyReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeYearlyReportModel value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeYearlyReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeYearlyReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeYearlyReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  int year, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'annual_working_days')  int annualWorkingDays, @JsonKey(name: 'annual_present_days')  int annualPresentDays, @JsonKey(name: 'annual_absent_days')  int annualAbsentDays, @JsonKey(name: 'annual_leave_days')  int annualLeaveDays, @JsonKey(name: 'annual_total_hours')  double annualTotalHours, @JsonKey(name: 'annual_attendance_percentage')  double annualAttendancePercentage,  List<MonthSummaryItemModel> months)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeYearlyReportModel() when $default != null:
return $default(_that.employeeId,_that.employeeCode,_that.fullName,_that.year,_that.departmentName,_that.annualWorkingDays,_that.annualPresentDays,_that.annualAbsentDays,_that.annualLeaveDays,_that.annualTotalHours,_that.annualAttendancePercentage,_that.months);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  int year, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'annual_working_days')  int annualWorkingDays, @JsonKey(name: 'annual_present_days')  int annualPresentDays, @JsonKey(name: 'annual_absent_days')  int annualAbsentDays, @JsonKey(name: 'annual_leave_days')  int annualLeaveDays, @JsonKey(name: 'annual_total_hours')  double annualTotalHours, @JsonKey(name: 'annual_attendance_percentage')  double annualAttendancePercentage,  List<MonthSummaryItemModel> months)  $default,) {final _that = this;
switch (_that) {
case _EmployeeYearlyReportModel():
return $default(_that.employeeId,_that.employeeCode,_that.fullName,_that.year,_that.departmentName,_that.annualWorkingDays,_that.annualPresentDays,_that.annualAbsentDays,_that.annualLeaveDays,_that.annualTotalHours,_that.annualAttendancePercentage,_that.months);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  int year, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'annual_working_days')  int annualWorkingDays, @JsonKey(name: 'annual_present_days')  int annualPresentDays, @JsonKey(name: 'annual_absent_days')  int annualAbsentDays, @JsonKey(name: 'annual_leave_days')  int annualLeaveDays, @JsonKey(name: 'annual_total_hours')  double annualTotalHours, @JsonKey(name: 'annual_attendance_percentage')  double annualAttendancePercentage,  List<MonthSummaryItemModel> months)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeYearlyReportModel() when $default != null:
return $default(_that.employeeId,_that.employeeCode,_that.fullName,_that.year,_that.departmentName,_that.annualWorkingDays,_that.annualPresentDays,_that.annualAbsentDays,_that.annualLeaveDays,_that.annualTotalHours,_that.annualAttendancePercentage,_that.months);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeYearlyReportModel implements EmployeeYearlyReportModel {
  const _EmployeeYearlyReportModel({@JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'full_name') required this.fullName, required this.year, @JsonKey(name: 'department_name') this.departmentName, @JsonKey(name: 'annual_working_days') this.annualWorkingDays = 0, @JsonKey(name: 'annual_present_days') this.annualPresentDays = 0, @JsonKey(name: 'annual_absent_days') this.annualAbsentDays = 0, @JsonKey(name: 'annual_leave_days') this.annualLeaveDays = 0, @JsonKey(name: 'annual_total_hours') this.annualTotalHours = 0.0, @JsonKey(name: 'annual_attendance_percentage') this.annualAttendancePercentage = 0.0,  List<MonthSummaryItemModel> months = const <MonthSummaryItemModel>[]}): _months = months;
  factory _EmployeeYearlyReportModel.fromJson(Map<String, dynamic> json) => _$EmployeeYearlyReportModelFromJson(json);

@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  int year;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override@JsonKey(name: 'annual_working_days') final  int annualWorkingDays;
@override@JsonKey(name: 'annual_present_days') final  int annualPresentDays;
@override@JsonKey(name: 'annual_absent_days') final  int annualAbsentDays;
@override@JsonKey(name: 'annual_leave_days') final  int annualLeaveDays;
@override@JsonKey(name: 'annual_total_hours') final  double annualTotalHours;
@override@JsonKey(name: 'annual_attendance_percentage') final  double annualAttendancePercentage;
 final  List<MonthSummaryItemModel> _months;
@override@JsonKey() List<MonthSummaryItemModel> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}


/// Create a copy of EmployeeYearlyReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeYearlyReportModelCopyWith<_EmployeeYearlyReportModel> get copyWith => __$EmployeeYearlyReportModelCopyWithImpl<_EmployeeYearlyReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeYearlyReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeYearlyReportModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.year, year) || other.year == year)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.annualWorkingDays, annualWorkingDays) || other.annualWorkingDays == annualWorkingDays)&&(identical(other.annualPresentDays, annualPresentDays) || other.annualPresentDays == annualPresentDays)&&(identical(other.annualAbsentDays, annualAbsentDays) || other.annualAbsentDays == annualAbsentDays)&&(identical(other.annualLeaveDays, annualLeaveDays) || other.annualLeaveDays == annualLeaveDays)&&(identical(other.annualTotalHours, annualTotalHours) || other.annualTotalHours == annualTotalHours)&&(identical(other.annualAttendancePercentage, annualAttendancePercentage) || other.annualAttendancePercentage == annualAttendancePercentage)&&const DeepCollectionEquality().equals(other._months, _months));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeCode,fullName,year,departmentName,annualWorkingDays,annualPresentDays,annualAbsentDays,annualLeaveDays,annualTotalHours,annualAttendancePercentage,const DeepCollectionEquality().hash(_months));

@override
String toString() {
  return 'EmployeeYearlyReportModel(employeeId: $employeeId, employeeCode: $employeeCode, fullName: $fullName, year: $year, departmentName: $departmentName, annualWorkingDays: $annualWorkingDays, annualPresentDays: $annualPresentDays, annualAbsentDays: $annualAbsentDays, annualLeaveDays: $annualLeaveDays, annualTotalHours: $annualTotalHours, annualAttendancePercentage: $annualAttendancePercentage, months: $months)';
}


}

/// @nodoc
abstract mixin class _$EmployeeYearlyReportModelCopyWith<$Res> implements $EmployeeYearlyReportModelCopyWith<$Res> {
  factory _$EmployeeYearlyReportModelCopyWith(_EmployeeYearlyReportModel value, $Res Function(_EmployeeYearlyReportModel) _then) = __$EmployeeYearlyReportModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, int year,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'annual_working_days') int annualWorkingDays,@JsonKey(name: 'annual_present_days') int annualPresentDays,@JsonKey(name: 'annual_absent_days') int annualAbsentDays,@JsonKey(name: 'annual_leave_days') int annualLeaveDays,@JsonKey(name: 'annual_total_hours') double annualTotalHours,@JsonKey(name: 'annual_attendance_percentage') double annualAttendancePercentage, List<MonthSummaryItemModel> months
});




}
/// @nodoc
class __$EmployeeYearlyReportModelCopyWithImpl<$Res>
    implements _$EmployeeYearlyReportModelCopyWith<$Res> {
  __$EmployeeYearlyReportModelCopyWithImpl(this._self, this._then);

  final _EmployeeYearlyReportModel _self;
  final $Res Function(_EmployeeYearlyReportModel) _then;

/// Create a copy of EmployeeYearlyReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeCode = null,Object? fullName = null,Object? year = null,Object? departmentName = freezed,Object? annualWorkingDays = null,Object? annualPresentDays = null,Object? annualAbsentDays = null,Object? annualLeaveDays = null,Object? annualTotalHours = null,Object? annualAttendancePercentage = null,Object? months = null,}) {
  return _then(_EmployeeYearlyReportModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,annualWorkingDays: null == annualWorkingDays ? _self.annualWorkingDays : annualWorkingDays // ignore: cast_nullable_to_non_nullable
as int,annualPresentDays: null == annualPresentDays ? _self.annualPresentDays : annualPresentDays // ignore: cast_nullable_to_non_nullable
as int,annualAbsentDays: null == annualAbsentDays ? _self.annualAbsentDays : annualAbsentDays // ignore: cast_nullable_to_non_nullable
as int,annualLeaveDays: null == annualLeaveDays ? _self.annualLeaveDays : annualLeaveDays // ignore: cast_nullable_to_non_nullable
as int,annualTotalHours: null == annualTotalHours ? _self.annualTotalHours : annualTotalHours // ignore: cast_nullable_to_non_nullable
as double,annualAttendancePercentage: null == annualAttendancePercentage ? _self.annualAttendancePercentage : annualAttendancePercentage // ignore: cast_nullable_to_non_nullable
as double,months: null == months ? _self._months : months // ignore: cast_nullable_to_non_nullable
as List<MonthSummaryItemModel>,
  ));
}


}

// dart format on
