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
mixin _$PasswordPolicySummary {

@JsonKey(name: 'min_length') int get minLength;@JsonKey(name: 'require_uppercase') bool get requireUppercase;@JsonKey(name: 'require_lowercase') bool get requireLowercase;@JsonKey(name: 'require_digit') bool get requireDigit;@JsonKey(name: 'require_special') bool get requireSpecial;
/// Create a copy of PasswordPolicySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordPolicySummaryCopyWith<PasswordPolicySummary> get copyWith => _$PasswordPolicySummaryCopyWithImpl<PasswordPolicySummary>(this as PasswordPolicySummary, _$identity);

  /// Serializes this PasswordPolicySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordPolicySummary&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.requireUppercase, requireUppercase) || other.requireUppercase == requireUppercase)&&(identical(other.requireLowercase, requireLowercase) || other.requireLowercase == requireLowercase)&&(identical(other.requireDigit, requireDigit) || other.requireDigit == requireDigit)&&(identical(other.requireSpecial, requireSpecial) || other.requireSpecial == requireSpecial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLength,requireUppercase,requireLowercase,requireDigit,requireSpecial);

@override
String toString() {
  return 'PasswordPolicySummary(minLength: $minLength, requireUppercase: $requireUppercase, requireLowercase: $requireLowercase, requireDigit: $requireDigit, requireSpecial: $requireSpecial)';
}


}

/// @nodoc
abstract mixin class $PasswordPolicySummaryCopyWith<$Res>  {
  factory $PasswordPolicySummaryCopyWith(PasswordPolicySummary value, $Res Function(PasswordPolicySummary) _then) = _$PasswordPolicySummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_length') int minLength,@JsonKey(name: 'require_uppercase') bool requireUppercase,@JsonKey(name: 'require_lowercase') bool requireLowercase,@JsonKey(name: 'require_digit') bool requireDigit,@JsonKey(name: 'require_special') bool requireSpecial
});




}
/// @nodoc
class _$PasswordPolicySummaryCopyWithImpl<$Res>
    implements $PasswordPolicySummaryCopyWith<$Res> {
  _$PasswordPolicySummaryCopyWithImpl(this._self, this._then);

  final PasswordPolicySummary _self;
  final $Res Function(PasswordPolicySummary) _then;

/// Create a copy of PasswordPolicySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLength = null,Object? requireUppercase = null,Object? requireLowercase = null,Object? requireDigit = null,Object? requireSpecial = null,}) {
  return _then(PasswordPolicySummary(
minLength: null == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int,requireUppercase: null == requireUppercase ? _self.requireUppercase : requireUppercase // ignore: cast_nullable_to_non_nullable
as bool,requireLowercase: null == requireLowercase ? _self.requireLowercase : requireLowercase // ignore: cast_nullable_to_non_nullable
as bool,requireDigit: null == requireDigit ? _self.requireDigit : requireDigit // ignore: cast_nullable_to_non_nullable
as bool,requireSpecial: null == requireSpecial ? _self.requireSpecial : requireSpecial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordPolicySummary].
extension PasswordPolicySummaryPatterns on PasswordPolicySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordPolicySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordPolicySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordPolicySummary value)  $default,){
final _that = this;
switch (_that) {
case _PasswordPolicySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordPolicySummary value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordPolicySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_length')  int minLength, @JsonKey(name: 'require_uppercase')  bool requireUppercase, @JsonKey(name: 'require_lowercase')  bool requireLowercase, @JsonKey(name: 'require_digit')  bool requireDigit, @JsonKey(name: 'require_special')  bool requireSpecial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordPolicySummary() when $default != null:
return $default(_that.minLength,_that.requireUppercase,_that.requireLowercase,_that.requireDigit,_that.requireSpecial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_length')  int minLength, @JsonKey(name: 'require_uppercase')  bool requireUppercase, @JsonKey(name: 'require_lowercase')  bool requireLowercase, @JsonKey(name: 'require_digit')  bool requireDigit, @JsonKey(name: 'require_special')  bool requireSpecial)  $default,) {final _that = this;
switch (_that) {
case _PasswordPolicySummary():
return $default(_that.minLength,_that.requireUppercase,_that.requireLowercase,_that.requireDigit,_that.requireSpecial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'min_length')  int minLength, @JsonKey(name: 'require_uppercase')  bool requireUppercase, @JsonKey(name: 'require_lowercase')  bool requireLowercase, @JsonKey(name: 'require_digit')  bool requireDigit, @JsonKey(name: 'require_special')  bool requireSpecial)?  $default,) {final _that = this;
switch (_that) {
case _PasswordPolicySummary() when $default != null:
return $default(_that.minLength,_that.requireUppercase,_that.requireLowercase,_that.requireDigit,_that.requireSpecial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PasswordPolicySummary implements PasswordPolicySummary {
  const _PasswordPolicySummary({@JsonKey(name: 'min_length') this.minLength = 8, @JsonKey(name: 'require_uppercase') this.requireUppercase = true, @JsonKey(name: 'require_lowercase') this.requireLowercase = true, @JsonKey(name: 'require_digit') this.requireDigit = true, @JsonKey(name: 'require_special') this.requireSpecial = true});
  factory _PasswordPolicySummary.fromJson(Map<String, dynamic> json) => _$PasswordPolicySummaryFromJson(json);

@override@JsonKey(name: 'min_length') final  int minLength;
@override@JsonKey(name: 'require_uppercase') final  bool requireUppercase;
@override@JsonKey(name: 'require_lowercase') final  bool requireLowercase;
@override@JsonKey(name: 'require_digit') final  bool requireDigit;
@override@JsonKey(name: 'require_special') final  bool requireSpecial;

/// Create a copy of PasswordPolicySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordPolicySummaryCopyWith<_PasswordPolicySummary> get copyWith => __$PasswordPolicySummaryCopyWithImpl<_PasswordPolicySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PasswordPolicySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordPolicySummary&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.requireUppercase, requireUppercase) || other.requireUppercase == requireUppercase)&&(identical(other.requireLowercase, requireLowercase) || other.requireLowercase == requireLowercase)&&(identical(other.requireDigit, requireDigit) || other.requireDigit == requireDigit)&&(identical(other.requireSpecial, requireSpecial) || other.requireSpecial == requireSpecial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minLength,requireUppercase,requireLowercase,requireDigit,requireSpecial);

@override
String toString() {
  return 'PasswordPolicySummary(minLength: $minLength, requireUppercase: $requireUppercase, requireLowercase: $requireLowercase, requireDigit: $requireDigit, requireSpecial: $requireSpecial)';
}


}

/// @nodoc
abstract mixin class _$PasswordPolicySummaryCopyWith<$Res> implements $PasswordPolicySummaryCopyWith<$Res> {
  factory _$PasswordPolicySummaryCopyWith(_PasswordPolicySummary value, $Res Function(_PasswordPolicySummary) _then) = __$PasswordPolicySummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_length') int minLength,@JsonKey(name: 'require_uppercase') bool requireUppercase,@JsonKey(name: 'require_lowercase') bool requireLowercase,@JsonKey(name: 'require_digit') bool requireDigit,@JsonKey(name: 'require_special') bool requireSpecial
});




}
/// @nodoc
class __$PasswordPolicySummaryCopyWithImpl<$Res>
    implements _$PasswordPolicySummaryCopyWith<$Res> {
  __$PasswordPolicySummaryCopyWithImpl(this._self, this._then);

  final _PasswordPolicySummary _self;
  final $Res Function(_PasswordPolicySummary) _then;

/// Create a copy of PasswordPolicySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLength = null,Object? requireUppercase = null,Object? requireLowercase = null,Object? requireDigit = null,Object? requireSpecial = null,}) {
  return _then(_PasswordPolicySummary(
minLength: null == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int,requireUppercase: null == requireUppercase ? _self.requireUppercase : requireUppercase // ignore: cast_nullable_to_non_nullable
as bool,requireLowercase: null == requireLowercase ? _self.requireLowercase : requireLowercase // ignore: cast_nullable_to_non_nullable
as bool,requireDigit: null == requireDigit ? _self.requireDigit : requireDigit // ignore: cast_nullable_to_non_nullable
as bool,requireSpecial: null == requireSpecial ? _self.requireSpecial : requireSpecial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RuntimeAppConfig {

@JsonKey(name: 'app_timezone') String get timezone; String get localeCode; String get currencyCode;@JsonKey(name: 'default_page_size') int get defaultPageSize;@JsonKey(name: 'max_page_size') int get maxPageSize;@JsonKey(name: 'max_upload_mb') int get maxUploadMb;@JsonKey(name: 'allowed_upload_mime_types') List<String> get allowedUploadMimeTypes;@JsonKey(name: 'min_supported_app_version') String get minSupportedAppVersion;@JsonKey(name: 'force_update') bool get forceUpdate;@JsonKey(name: 'navigation_refresh_interval_minutes') int get navigationRefreshIntervalMinutes;@JsonKey(name: 'password_policy') PasswordPolicySummary get passwordPolicy;@JsonKey(name: 'feature_flags') Map<String, dynamic> get featureFlags;
/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuntimeAppConfigCopyWith<RuntimeAppConfig> get copyWith => _$RuntimeAppConfigCopyWithImpl<RuntimeAppConfig>(this as RuntimeAppConfig, _$identity);

  /// Serializes this RuntimeAppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuntimeAppConfig&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.defaultPageSize, defaultPageSize) || other.defaultPageSize == defaultPageSize)&&(identical(other.maxPageSize, maxPageSize) || other.maxPageSize == maxPageSize)&&(identical(other.maxUploadMb, maxUploadMb) || other.maxUploadMb == maxUploadMb)&&const DeepCollectionEquality().equals(other.allowedUploadMimeTypes, allowedUploadMimeTypes)&&(identical(other.minSupportedAppVersion, minSupportedAppVersion) || other.minSupportedAppVersion == minSupportedAppVersion)&&(identical(other.forceUpdate, forceUpdate) || other.forceUpdate == forceUpdate)&&(identical(other.navigationRefreshIntervalMinutes, navigationRefreshIntervalMinutes) || other.navigationRefreshIntervalMinutes == navigationRefreshIntervalMinutes)&&(identical(other.passwordPolicy, passwordPolicy) || other.passwordPolicy == passwordPolicy)&&const DeepCollectionEquality().equals(other.featureFlags, featureFlags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timezone,localeCode,currencyCode,defaultPageSize,maxPageSize,maxUploadMb,const DeepCollectionEquality().hash(allowedUploadMimeTypes),minSupportedAppVersion,forceUpdate,navigationRefreshIntervalMinutes,passwordPolicy,const DeepCollectionEquality().hash(featureFlags));

@override
String toString() {
  return 'RuntimeAppConfig(timezone: $timezone, localeCode: $localeCode, currencyCode: $currencyCode, defaultPageSize: $defaultPageSize, maxPageSize: $maxPageSize, maxUploadMb: $maxUploadMb, allowedUploadMimeTypes: $allowedUploadMimeTypes, minSupportedAppVersion: $minSupportedAppVersion, forceUpdate: $forceUpdate, navigationRefreshIntervalMinutes: $navigationRefreshIntervalMinutes, passwordPolicy: $passwordPolicy, featureFlags: $featureFlags)';
}


}

/// @nodoc
abstract mixin class $RuntimeAppConfigCopyWith<$Res>  {
  factory $RuntimeAppConfigCopyWith(RuntimeAppConfig value, $Res Function(RuntimeAppConfig) _then) = _$RuntimeAppConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'app_timezone') String timezone, String localeCode, String currencyCode,@JsonKey(name: 'default_page_size') int defaultPageSize,@JsonKey(name: 'max_page_size') int maxPageSize,@JsonKey(name: 'max_upload_mb') int maxUploadMb,@JsonKey(name: 'allowed_upload_mime_types') List<String> allowedUploadMimeTypes,@JsonKey(name: 'min_supported_app_version') String minSupportedAppVersion,@JsonKey(name: 'force_update') bool forceUpdate,@JsonKey(name: 'navigation_refresh_interval_minutes') int navigationRefreshIntervalMinutes,@JsonKey(name: 'password_policy') PasswordPolicySummary passwordPolicy,@JsonKey(name: 'feature_flags') Map<String, dynamic> featureFlags
});


$PasswordPolicySummaryCopyWith<$Res> get passwordPolicy;

}
/// @nodoc
class _$RuntimeAppConfigCopyWithImpl<$Res>
    implements $RuntimeAppConfigCopyWith<$Res> {
  _$RuntimeAppConfigCopyWithImpl(this._self, this._then);

  final RuntimeAppConfig _self;
  final $Res Function(RuntimeAppConfig) _then;

/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timezone = null,Object? localeCode = null,Object? currencyCode = null,Object? defaultPageSize = null,Object? maxPageSize = null,Object? maxUploadMb = null,Object? allowedUploadMimeTypes = null,Object? minSupportedAppVersion = null,Object? forceUpdate = null,Object? navigationRefreshIntervalMinutes = null,Object? passwordPolicy = null,Object? featureFlags = null,}) {
  return _then(RuntimeAppConfig(
timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,localeCode: null == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,defaultPageSize: null == defaultPageSize ? _self.defaultPageSize : defaultPageSize // ignore: cast_nullable_to_non_nullable
as int,maxPageSize: null == maxPageSize ? _self.maxPageSize : maxPageSize // ignore: cast_nullable_to_non_nullable
as int,maxUploadMb: null == maxUploadMb ? _self.maxUploadMb : maxUploadMb // ignore: cast_nullable_to_non_nullable
as int,allowedUploadMimeTypes: null == allowedUploadMimeTypes ? _self.allowedUploadMimeTypes : allowedUploadMimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,minSupportedAppVersion: null == minSupportedAppVersion ? _self.minSupportedAppVersion : minSupportedAppVersion // ignore: cast_nullable_to_non_nullable
as String,forceUpdate: null == forceUpdate ? _self.forceUpdate : forceUpdate // ignore: cast_nullable_to_non_nullable
as bool,navigationRefreshIntervalMinutes: null == navigationRefreshIntervalMinutes ? _self.navigationRefreshIntervalMinutes : navigationRefreshIntervalMinutes // ignore: cast_nullable_to_non_nullable
as int,passwordPolicy: null == passwordPolicy ? _self.passwordPolicy : passwordPolicy // ignore: cast_nullable_to_non_nullable
as PasswordPolicySummary,featureFlags: null == featureFlags ? _self.featureFlags : featureFlags // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PasswordPolicySummaryCopyWith<$Res> get passwordPolicy {
  
  return $PasswordPolicySummaryCopyWith<$Res>(_self.passwordPolicy, (value) {
    return _then(_self.copyWith(passwordPolicy: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'app_timezone')  String timezone,  String localeCode,  String currencyCode, @JsonKey(name: 'default_page_size')  int defaultPageSize, @JsonKey(name: 'max_page_size')  int maxPageSize, @JsonKey(name: 'max_upload_mb')  int maxUploadMb, @JsonKey(name: 'allowed_upload_mime_types')  List<String> allowedUploadMimeTypes, @JsonKey(name: 'min_supported_app_version')  String minSupportedAppVersion, @JsonKey(name: 'force_update')  bool forceUpdate, @JsonKey(name: 'navigation_refresh_interval_minutes')  int navigationRefreshIntervalMinutes, @JsonKey(name: 'password_policy')  PasswordPolicySummary passwordPolicy, @JsonKey(name: 'feature_flags')  Map<String, dynamic> featureFlags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuntimeAppConfig() when $default != null:
return $default(_that.timezone,_that.localeCode,_that.currencyCode,_that.defaultPageSize,_that.maxPageSize,_that.maxUploadMb,_that.allowedUploadMimeTypes,_that.minSupportedAppVersion,_that.forceUpdate,_that.navigationRefreshIntervalMinutes,_that.passwordPolicy,_that.featureFlags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'app_timezone')  String timezone,  String localeCode,  String currencyCode, @JsonKey(name: 'default_page_size')  int defaultPageSize, @JsonKey(name: 'max_page_size')  int maxPageSize, @JsonKey(name: 'max_upload_mb')  int maxUploadMb, @JsonKey(name: 'allowed_upload_mime_types')  List<String> allowedUploadMimeTypes, @JsonKey(name: 'min_supported_app_version')  String minSupportedAppVersion, @JsonKey(name: 'force_update')  bool forceUpdate, @JsonKey(name: 'navigation_refresh_interval_minutes')  int navigationRefreshIntervalMinutes, @JsonKey(name: 'password_policy')  PasswordPolicySummary passwordPolicy, @JsonKey(name: 'feature_flags')  Map<String, dynamic> featureFlags)  $default,) {final _that = this;
switch (_that) {
case _RuntimeAppConfig():
return $default(_that.timezone,_that.localeCode,_that.currencyCode,_that.defaultPageSize,_that.maxPageSize,_that.maxUploadMb,_that.allowedUploadMimeTypes,_that.minSupportedAppVersion,_that.forceUpdate,_that.navigationRefreshIntervalMinutes,_that.passwordPolicy,_that.featureFlags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'app_timezone')  String timezone,  String localeCode,  String currencyCode, @JsonKey(name: 'default_page_size')  int defaultPageSize, @JsonKey(name: 'max_page_size')  int maxPageSize, @JsonKey(name: 'max_upload_mb')  int maxUploadMb, @JsonKey(name: 'allowed_upload_mime_types')  List<String> allowedUploadMimeTypes, @JsonKey(name: 'min_supported_app_version')  String minSupportedAppVersion, @JsonKey(name: 'force_update')  bool forceUpdate, @JsonKey(name: 'navigation_refresh_interval_minutes')  int navigationRefreshIntervalMinutes, @JsonKey(name: 'password_policy')  PasswordPolicySummary passwordPolicy, @JsonKey(name: 'feature_flags')  Map<String, dynamic> featureFlags)?  $default,) {final _that = this;
switch (_that) {
case _RuntimeAppConfig() when $default != null:
return $default(_that.timezone,_that.localeCode,_that.currencyCode,_that.defaultPageSize,_that.maxPageSize,_that.maxUploadMb,_that.allowedUploadMimeTypes,_that.minSupportedAppVersion,_that.forceUpdate,_that.navigationRefreshIntervalMinutes,_that.passwordPolicy,_that.featureFlags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RuntimeAppConfig extends RuntimeAppConfig {
  const _RuntimeAppConfig({@JsonKey(name: 'app_timezone') this.timezone = 'UTC', this.localeCode = 'en_IN', this.currencyCode = 'INR', @JsonKey(name: 'default_page_size') this.defaultPageSize = 20, @JsonKey(name: 'max_page_size') this.maxPageSize = 100, @JsonKey(name: 'max_upload_mb') this.maxUploadMb = 10, @JsonKey(name: 'allowed_upload_mime_types')  List<String> allowedUploadMimeTypes = const <String>['image/jpeg', 'image/png', 'application/pdf'], @JsonKey(name: 'min_supported_app_version') this.minSupportedAppVersion = '1.0.0', @JsonKey(name: 'force_update') this.forceUpdate = false, @JsonKey(name: 'navigation_refresh_interval_minutes') this.navigationRefreshIntervalMinutes = 5, @JsonKey(name: 'password_policy') this.passwordPolicy = const PasswordPolicySummary(), @JsonKey(name: 'feature_flags')  Map<String, dynamic> featureFlags = const <String, dynamic>{}}): _allowedUploadMimeTypes = allowedUploadMimeTypes,_featureFlags = featureFlags,super._();
  factory _RuntimeAppConfig.fromJson(Map<String, dynamic> json) => _$RuntimeAppConfigFromJson(json);

@override@JsonKey(name: 'app_timezone') final  String timezone;
@override@JsonKey() final  String localeCode;
@override@JsonKey() final  String currencyCode;
@override@JsonKey(name: 'default_page_size') final  int defaultPageSize;
@override@JsonKey(name: 'max_page_size') final  int maxPageSize;
@override@JsonKey(name: 'max_upload_mb') final  int maxUploadMb;
 final  List<String> _allowedUploadMimeTypes;
@override@JsonKey(name: 'allowed_upload_mime_types') List<String> get allowedUploadMimeTypes {
  if (_allowedUploadMimeTypes is EqualUnmodifiableListView) return _allowedUploadMimeTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedUploadMimeTypes);
}

@override@JsonKey(name: 'min_supported_app_version') final  String minSupportedAppVersion;
@override@JsonKey(name: 'force_update') final  bool forceUpdate;
@override@JsonKey(name: 'navigation_refresh_interval_minutes') final  int navigationRefreshIntervalMinutes;
@override@JsonKey(name: 'password_policy') final  PasswordPolicySummary passwordPolicy;
 final  Map<String, dynamic> _featureFlags;
@override@JsonKey(name: 'feature_flags') Map<String, dynamic> get featureFlags {
  if (_featureFlags is EqualUnmodifiableMapView) return _featureFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_featureFlags);
}


/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuntimeAppConfigCopyWith<_RuntimeAppConfig> get copyWith => __$RuntimeAppConfigCopyWithImpl<_RuntimeAppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RuntimeAppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuntimeAppConfig&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.defaultPageSize, defaultPageSize) || other.defaultPageSize == defaultPageSize)&&(identical(other.maxPageSize, maxPageSize) || other.maxPageSize == maxPageSize)&&(identical(other.maxUploadMb, maxUploadMb) || other.maxUploadMb == maxUploadMb)&&const DeepCollectionEquality().equals(other._allowedUploadMimeTypes, _allowedUploadMimeTypes)&&(identical(other.minSupportedAppVersion, minSupportedAppVersion) || other.minSupportedAppVersion == minSupportedAppVersion)&&(identical(other.forceUpdate, forceUpdate) || other.forceUpdate == forceUpdate)&&(identical(other.navigationRefreshIntervalMinutes, navigationRefreshIntervalMinutes) || other.navigationRefreshIntervalMinutes == navigationRefreshIntervalMinutes)&&(identical(other.passwordPolicy, passwordPolicy) || other.passwordPolicy == passwordPolicy)&&const DeepCollectionEquality().equals(other._featureFlags, _featureFlags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timezone,localeCode,currencyCode,defaultPageSize,maxPageSize,maxUploadMb,const DeepCollectionEquality().hash(_allowedUploadMimeTypes),minSupportedAppVersion,forceUpdate,navigationRefreshIntervalMinutes,passwordPolicy,const DeepCollectionEquality().hash(_featureFlags));

@override
String toString() {
  return 'RuntimeAppConfig(timezone: $timezone, localeCode: $localeCode, currencyCode: $currencyCode, defaultPageSize: $defaultPageSize, maxPageSize: $maxPageSize, maxUploadMb: $maxUploadMb, allowedUploadMimeTypes: $allowedUploadMimeTypes, minSupportedAppVersion: $minSupportedAppVersion, forceUpdate: $forceUpdate, navigationRefreshIntervalMinutes: $navigationRefreshIntervalMinutes, passwordPolicy: $passwordPolicy, featureFlags: $featureFlags)';
}


}

/// @nodoc
abstract mixin class _$RuntimeAppConfigCopyWith<$Res> implements $RuntimeAppConfigCopyWith<$Res> {
  factory _$RuntimeAppConfigCopyWith(_RuntimeAppConfig value, $Res Function(_RuntimeAppConfig) _then) = __$RuntimeAppConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'app_timezone') String timezone, String localeCode, String currencyCode,@JsonKey(name: 'default_page_size') int defaultPageSize,@JsonKey(name: 'max_page_size') int maxPageSize,@JsonKey(name: 'max_upload_mb') int maxUploadMb,@JsonKey(name: 'allowed_upload_mime_types') List<String> allowedUploadMimeTypes,@JsonKey(name: 'min_supported_app_version') String minSupportedAppVersion,@JsonKey(name: 'force_update') bool forceUpdate,@JsonKey(name: 'navigation_refresh_interval_minutes') int navigationRefreshIntervalMinutes,@JsonKey(name: 'password_policy') PasswordPolicySummary passwordPolicy,@JsonKey(name: 'feature_flags') Map<String, dynamic> featureFlags
});


@override $PasswordPolicySummaryCopyWith<$Res> get passwordPolicy;

}
/// @nodoc
class __$RuntimeAppConfigCopyWithImpl<$Res>
    implements _$RuntimeAppConfigCopyWith<$Res> {
  __$RuntimeAppConfigCopyWithImpl(this._self, this._then);

  final _RuntimeAppConfig _self;
  final $Res Function(_RuntimeAppConfig) _then;

/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timezone = null,Object? localeCode = null,Object? currencyCode = null,Object? defaultPageSize = null,Object? maxPageSize = null,Object? maxUploadMb = null,Object? allowedUploadMimeTypes = null,Object? minSupportedAppVersion = null,Object? forceUpdate = null,Object? navigationRefreshIntervalMinutes = null,Object? passwordPolicy = null,Object? featureFlags = null,}) {
  return _then(_RuntimeAppConfig(
timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,localeCode: null == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,defaultPageSize: null == defaultPageSize ? _self.defaultPageSize : defaultPageSize // ignore: cast_nullable_to_non_nullable
as int,maxPageSize: null == maxPageSize ? _self.maxPageSize : maxPageSize // ignore: cast_nullable_to_non_nullable
as int,maxUploadMb: null == maxUploadMb ? _self.maxUploadMb : maxUploadMb // ignore: cast_nullable_to_non_nullable
as int,allowedUploadMimeTypes: null == allowedUploadMimeTypes ? _self._allowedUploadMimeTypes : allowedUploadMimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,minSupportedAppVersion: null == minSupportedAppVersion ? _self.minSupportedAppVersion : minSupportedAppVersion // ignore: cast_nullable_to_non_nullable
as String,forceUpdate: null == forceUpdate ? _self.forceUpdate : forceUpdate // ignore: cast_nullable_to_non_nullable
as bool,navigationRefreshIntervalMinutes: null == navigationRefreshIntervalMinutes ? _self.navigationRefreshIntervalMinutes : navigationRefreshIntervalMinutes // ignore: cast_nullable_to_non_nullable
as int,passwordPolicy: null == passwordPolicy ? _self.passwordPolicy : passwordPolicy // ignore: cast_nullable_to_non_nullable
as PasswordPolicySummary,featureFlags: null == featureFlags ? _self._featureFlags : featureFlags // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of RuntimeAppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PasswordPolicySummaryCopyWith<$Res> get passwordPolicy {
  
  return $PasswordPolicySummaryCopyWith<$Res>(_self.passwordPolicy, (value) {
    return _then(_self.copyWith(passwordPolicy: value));
  });
}
}

// dart format on
