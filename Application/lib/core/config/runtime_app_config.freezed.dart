// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'runtime_app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuntimeAppConfig {

 String get timezone; String get localeCode; String get currencyCode; int get defaultPageSize; int get maxPageSize; int get maxUploadMb;
/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuntimeAppConfigCopyWith<RuntimeAppConfig> get copyWith => _$RuntimeAppConfigCopyWithImpl<RuntimeAppConfig>(this as RuntimeAppConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuntimeAppConfig&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.defaultPageSize, defaultPageSize) || other.defaultPageSize == defaultPageSize)&&(identical(other.maxPageSize, maxPageSize) || other.maxPageSize == maxPageSize)&&(identical(other.maxUploadMb, maxUploadMb) || other.maxUploadMb == maxUploadMb));
}


@override
int get hashCode => Object.hash(runtimeType,timezone,localeCode,currencyCode,defaultPageSize,maxPageSize,maxUploadMb);

@override
String toString() {
  return 'RuntimeAppConfig(timezone: $timezone, localeCode: $localeCode, currencyCode: $currencyCode, defaultPageSize: $defaultPageSize, maxPageSize: $maxPageSize, maxUploadMb: $maxUploadMb)';
}


}

/// @nodoc
abstract mixin class $RuntimeAppConfigCopyWith<$Res>  {
  factory $RuntimeAppConfigCopyWith(RuntimeAppConfig value, $Res Function(RuntimeAppConfig) _then) = _$RuntimeAppConfigCopyWithImpl;
@useResult
$Res call({
 String timezone, String localeCode, String currencyCode, int defaultPageSize, int maxPageSize, int maxUploadMb
});




}
/// @nodoc
class _$RuntimeAppConfigCopyWithImpl<$Res>
    implements $RuntimeAppConfigCopyWith<$Res> {
  _$RuntimeAppConfigCopyWithImpl(this._self, this._then);

  final RuntimeAppConfig _self;
  final $Res Function(RuntimeAppConfig) _then;

/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timezone = null,Object? localeCode = null,Object? currencyCode = null,Object? defaultPageSize = null,Object? maxPageSize = null,Object? maxUploadMb = null,}) {
  return _then(RuntimeAppConfig(
timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,localeCode: null == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,defaultPageSize: null == defaultPageSize ? _self.defaultPageSize : defaultPageSize // ignore: cast_nullable_to_non_nullable
as int,maxPageSize: null == maxPageSize ? _self.maxPageSize : maxPageSize // ignore: cast_nullable_to_non_nullable
as int,maxUploadMb: null == maxUploadMb ? _self.maxUploadMb : maxUploadMb // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RuntimeAppConfig].
extension RuntimeAppConfigPatterns on RuntimeAppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuntimeAppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuntimeAppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuntimeAppConfig value)  $default,){
final _that = this;
switch (_that) {
case _RuntimeAppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuntimeAppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RuntimeAppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String timezone,  String localeCode,  String currencyCode,  int defaultPageSize,  int maxPageSize,  int maxUploadMb)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuntimeAppConfig() when $default != null:
return $default(_that.timezone,_that.localeCode,_that.currencyCode,_that.defaultPageSize,_that.maxPageSize,_that.maxUploadMb);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String timezone,  String localeCode,  String currencyCode,  int defaultPageSize,  int maxPageSize,  int maxUploadMb)  $default,) {final _that = this;
switch (_that) {
case _RuntimeAppConfig():
return $default(_that.timezone,_that.localeCode,_that.currencyCode,_that.defaultPageSize,_that.maxPageSize,_that.maxUploadMb);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String timezone,  String localeCode,  String currencyCode,  int defaultPageSize,  int maxPageSize,  int maxUploadMb)?  $default,) {final _that = this;
switch (_that) {
case _RuntimeAppConfig() when $default != null:
return $default(_that.timezone,_that.localeCode,_that.currencyCode,_that.defaultPageSize,_that.maxPageSize,_that.maxUploadMb);case _:
  return null;

}
}

}

/// @nodoc


class _RuntimeAppConfig implements RuntimeAppConfig {
  const _RuntimeAppConfig({this.timezone = 'UTC', this.localeCode = 'en_IN', this.currencyCode = 'INR', this.defaultPageSize = 20, this.maxPageSize = 100, this.maxUploadMb = 10});
  

@override@JsonKey() final  String timezone;
@override@JsonKey() final  String localeCode;
@override@JsonKey() final  String currencyCode;
@override@JsonKey() final  int defaultPageSize;
@override@JsonKey() final  int maxPageSize;
@override@JsonKey() final  int maxUploadMb;

/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuntimeAppConfigCopyWith<_RuntimeAppConfig> get copyWith => __$RuntimeAppConfigCopyWithImpl<_RuntimeAppConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuntimeAppConfig&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.defaultPageSize, defaultPageSize) || other.defaultPageSize == defaultPageSize)&&(identical(other.maxPageSize, maxPageSize) || other.maxPageSize == maxPageSize)&&(identical(other.maxUploadMb, maxUploadMb) || other.maxUploadMb == maxUploadMb));
}


@override
int get hashCode => Object.hash(runtimeType,timezone,localeCode,currencyCode,defaultPageSize,maxPageSize,maxUploadMb);

@override
String toString() {
  return 'RuntimeAppConfig(timezone: $timezone, localeCode: $localeCode, currencyCode: $currencyCode, defaultPageSize: $defaultPageSize, maxPageSize: $maxPageSize, maxUploadMb: $maxUploadMb)';
}


}

/// @nodoc
abstract mixin class _$RuntimeAppConfigCopyWith<$Res> implements $RuntimeAppConfigCopyWith<$Res> {
  factory _$RuntimeAppConfigCopyWith(_RuntimeAppConfig value, $Res Function(_RuntimeAppConfig) _then) = __$RuntimeAppConfigCopyWithImpl;
@override @useResult
$Res call({
 String timezone, String localeCode, String currencyCode, int defaultPageSize, int maxPageSize, int maxUploadMb
});




}
/// @nodoc
class __$RuntimeAppConfigCopyWithImpl<$Res>
    implements _$RuntimeAppConfigCopyWith<$Res> {
  __$RuntimeAppConfigCopyWithImpl(this._self, this._then);

  final _RuntimeAppConfig _self;
  final $Res Function(_RuntimeAppConfig) _then;

/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timezone = null,Object? localeCode = null,Object? currencyCode = null,Object? defaultPageSize = null,Object? maxPageSize = null,Object? maxUploadMb = null,}) {
  return _then(_RuntimeAppConfig(
timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,localeCode: null == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,defaultPageSize: null == defaultPageSize ? _self.defaultPageSize : defaultPageSize // ignore: cast_nullable_to_non_nullable
as int,maxPageSize: null == maxPageSize ? _self.maxPageSize : maxPageSize // ignore: cast_nullable_to_non_nullable
as int,maxUploadMb: null == maxUploadMb ? _self.maxUploadMb : maxUploadMb // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
