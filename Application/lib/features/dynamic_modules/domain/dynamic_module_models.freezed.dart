// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_module_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DynamicSelectOption {

 String get value; String get label; String? get color;
/// Create a copy of DynamicSelectOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicSelectOptionCopyWith<DynamicSelectOption> get copyWith => _$DynamicSelectOptionCopyWithImpl<DynamicSelectOption>(this as DynamicSelectOption, _$identity);

  /// Serializes this DynamicSelectOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicSelectOption&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label,color);

@override
String toString() {
  return 'DynamicSelectOption(value: $value, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class $DynamicSelectOptionCopyWith<$Res>  {
  factory $DynamicSelectOptionCopyWith(DynamicSelectOption value, $Res Function(DynamicSelectOption) _then) = _$DynamicSelectOptionCopyWithImpl;
@useResult
$Res call({
 String value, String label, String? color
});




}
/// @nodoc
class _$DynamicSelectOptionCopyWithImpl<$Res>
    implements $DynamicSelectOptionCopyWith<$Res> {
  _$DynamicSelectOptionCopyWithImpl(this._self, this._then);

  final DynamicSelectOption _self;
  final $Res Function(DynamicSelectOption) _then;

/// Create a copy of DynamicSelectOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,Object? color = freezed,}) {
  return _then(DynamicSelectOption(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicSelectOption].
extension DynamicSelectOptionPatterns on DynamicSelectOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicSelectOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicSelectOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicSelectOption value)  $default,){
final _that = this;
switch (_that) {
case _DynamicSelectOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicSelectOption value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicSelectOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicSelectOption() when $default != null:
return $default(_that.value,_that.label,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label,  String? color)  $default,) {final _that = this;
switch (_that) {
case _DynamicSelectOption():
return $default(_that.value,_that.label,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _DynamicSelectOption() when $default != null:
return $default(_that.value,_that.label,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicSelectOption implements DynamicSelectOption {
  const _DynamicSelectOption({required this.value, required this.label, this.color});
  factory _DynamicSelectOption.fromJson(Map<String, dynamic> json) => _$DynamicSelectOptionFromJson(json);

@override final  String value;
@override final  String label;
@override final  String? color;

/// Create a copy of DynamicSelectOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicSelectOptionCopyWith<_DynamicSelectOption> get copyWith => __$DynamicSelectOptionCopyWithImpl<_DynamicSelectOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicSelectOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicSelectOption&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label,color);

@override
String toString() {
  return 'DynamicSelectOption(value: $value, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class _$DynamicSelectOptionCopyWith<$Res> implements $DynamicSelectOptionCopyWith<$Res> {
  factory _$DynamicSelectOptionCopyWith(_DynamicSelectOption value, $Res Function(_DynamicSelectOption) _then) = __$DynamicSelectOptionCopyWithImpl;
@override @useResult
$Res call({
 String value, String label, String? color
});




}
/// @nodoc
class __$DynamicSelectOptionCopyWithImpl<$Res>
    implements _$DynamicSelectOptionCopyWith<$Res> {
  __$DynamicSelectOptionCopyWithImpl(this._self, this._then);

  final _DynamicSelectOption _self;
  final $Res Function(_DynamicSelectOption) _then;

/// Create a copy of DynamicSelectOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,Object? color = freezed,}) {
  return _then(_DynamicSelectOption(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DynamicFieldValidation {

 num? get min; num? get max;@JsonKey(name: 'min_length') int? get minLength;@JsonKey(name: 'max_length') int? get maxLength; String? get regex;@JsonKey(name: 'regex_message') String? get regexMessage;
/// Create a copy of DynamicFieldValidation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicFieldValidationCopyWith<DynamicFieldValidation> get copyWith => _$DynamicFieldValidationCopyWithImpl<DynamicFieldValidation>(this as DynamicFieldValidation, _$identity);

  /// Serializes this DynamicFieldValidation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicFieldValidation&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.regex, regex) || other.regex == regex)&&(identical(other.regexMessage, regexMessage) || other.regexMessage == regexMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,min,max,minLength,maxLength,regex,regexMessage);

@override
String toString() {
  return 'DynamicFieldValidation(min: $min, max: $max, minLength: $minLength, maxLength: $maxLength, regex: $regex, regexMessage: $regexMessage)';
}


}

/// @nodoc
abstract mixin class $DynamicFieldValidationCopyWith<$Res>  {
  factory $DynamicFieldValidationCopyWith(DynamicFieldValidation value, $Res Function(DynamicFieldValidation) _then) = _$DynamicFieldValidationCopyWithImpl;
@useResult
$Res call({
 num? min, num? max,@JsonKey(name: 'min_length') int? minLength,@JsonKey(name: 'max_length') int? maxLength, String? regex,@JsonKey(name: 'regex_message') String? regexMessage
});




}
/// @nodoc
class _$DynamicFieldValidationCopyWithImpl<$Res>
    implements $DynamicFieldValidationCopyWith<$Res> {
  _$DynamicFieldValidationCopyWithImpl(this._self, this._then);

  final DynamicFieldValidation _self;
  final $Res Function(DynamicFieldValidation) _then;

/// Create a copy of DynamicFieldValidation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? min = freezed,Object? max = freezed,Object? minLength = freezed,Object? maxLength = freezed,Object? regex = freezed,Object? regexMessage = freezed,}) {
  return _then(DynamicFieldValidation(
min: freezed == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as num?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num?,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,regex: freezed == regex ? _self.regex : regex // ignore: cast_nullable_to_non_nullable
as String?,regexMessage: freezed == regexMessage ? _self.regexMessage : regexMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicFieldValidation].
extension DynamicFieldValidationPatterns on DynamicFieldValidation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicFieldValidation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicFieldValidation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicFieldValidation value)  $default,){
final _that = this;
switch (_that) {
case _DynamicFieldValidation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicFieldValidation value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicFieldValidation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num? min,  num? max, @JsonKey(name: 'min_length')  int? minLength, @JsonKey(name: 'max_length')  int? maxLength,  String? regex, @JsonKey(name: 'regex_message')  String? regexMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicFieldValidation() when $default != null:
return $default(_that.min,_that.max,_that.minLength,_that.maxLength,_that.regex,_that.regexMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num? min,  num? max, @JsonKey(name: 'min_length')  int? minLength, @JsonKey(name: 'max_length')  int? maxLength,  String? regex, @JsonKey(name: 'regex_message')  String? regexMessage)  $default,) {final _that = this;
switch (_that) {
case _DynamicFieldValidation():
return $default(_that.min,_that.max,_that.minLength,_that.maxLength,_that.regex,_that.regexMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num? min,  num? max, @JsonKey(name: 'min_length')  int? minLength, @JsonKey(name: 'max_length')  int? maxLength,  String? regex, @JsonKey(name: 'regex_message')  String? regexMessage)?  $default,) {final _that = this;
switch (_that) {
case _DynamicFieldValidation() when $default != null:
return $default(_that.min,_that.max,_that.minLength,_that.maxLength,_that.regex,_that.regexMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicFieldValidation implements DynamicFieldValidation {
  const _DynamicFieldValidation({this.min, this.max, @JsonKey(name: 'min_length') this.minLength, @JsonKey(name: 'max_length') this.maxLength, this.regex, @JsonKey(name: 'regex_message') this.regexMessage});
  factory _DynamicFieldValidation.fromJson(Map<String, dynamic> json) => _$DynamicFieldValidationFromJson(json);

@override final  num? min;
@override final  num? max;
@override@JsonKey(name: 'min_length') final  int? minLength;
@override@JsonKey(name: 'max_length') final  int? maxLength;
@override final  String? regex;
@override@JsonKey(name: 'regex_message') final  String? regexMessage;

/// Create a copy of DynamicFieldValidation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicFieldValidationCopyWith<_DynamicFieldValidation> get copyWith => __$DynamicFieldValidationCopyWithImpl<_DynamicFieldValidation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicFieldValidationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicFieldValidation&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.regex, regex) || other.regex == regex)&&(identical(other.regexMessage, regexMessage) || other.regexMessage == regexMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,min,max,minLength,maxLength,regex,regexMessage);

@override
String toString() {
  return 'DynamicFieldValidation(min: $min, max: $max, minLength: $minLength, maxLength: $maxLength, regex: $regex, regexMessage: $regexMessage)';
}


}

/// @nodoc
abstract mixin class _$DynamicFieldValidationCopyWith<$Res> implements $DynamicFieldValidationCopyWith<$Res> {
  factory _$DynamicFieldValidationCopyWith(_DynamicFieldValidation value, $Res Function(_DynamicFieldValidation) _then) = __$DynamicFieldValidationCopyWithImpl;
@override @useResult
$Res call({
 num? min, num? max,@JsonKey(name: 'min_length') int? minLength,@JsonKey(name: 'max_length') int? maxLength, String? regex,@JsonKey(name: 'regex_message') String? regexMessage
});




}
/// @nodoc
class __$DynamicFieldValidationCopyWithImpl<$Res>
    implements _$DynamicFieldValidationCopyWith<$Res> {
  __$DynamicFieldValidationCopyWithImpl(this._self, this._then);

  final _DynamicFieldValidation _self;
  final $Res Function(_DynamicFieldValidation) _then;

/// Create a copy of DynamicFieldValidation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? min = freezed,Object? max = freezed,Object? minLength = freezed,Object? maxLength = freezed,Object? regex = freezed,Object? regexMessage = freezed,}) {
  return _then(_DynamicFieldValidation(
min: freezed == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as num?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num?,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,regex: freezed == regex ? _self.regex : regex // ignore: cast_nullable_to_non_nullable
as String?,regexMessage: freezed == regexMessage ? _self.regexMessage : regexMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DynamicModuleField {

 String get id; String get key; String get label; String get type;@JsonKey(name: 'is_required') bool get isRequired;@JsonKey(name: 'is_list_visible') bool get isListVisible;@JsonKey(name: 'is_filterable') bool get isFilterable;@JsonKey(name: 'is_searchable') bool get isSearchable; List<DynamicSelectOption> get options; DynamicFieldValidation? get validation;@JsonKey(name: 'default_value') dynamic get defaultValue;@JsonKey(name: 'sort_order') int get sortOrder; String? get section;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of DynamicModuleField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicModuleFieldCopyWith<DynamicModuleField> get copyWith => _$DynamicModuleFieldCopyWithImpl<DynamicModuleField>(this as DynamicModuleField, _$identity);

  /// Serializes this DynamicModuleField to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicModuleField&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.isListVisible, isListVisible) || other.isListVisible == isListVisible)&&(identical(other.isFilterable, isFilterable) || other.isFilterable == isFilterable)&&(identical(other.isSearchable, isSearchable) || other.isSearchable == isSearchable)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.validation, validation) || other.validation == validation)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.section, section) || other.section == section)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,key,label,type,isRequired,isListVisible,isFilterable,isSearchable,const DeepCollectionEquality().hash(options),validation,const DeepCollectionEquality().hash(defaultValue),sortOrder,section,isActive);

@override
String toString() {
  return 'DynamicModuleField(id: $id, key: $key, label: $label, type: $type, isRequired: $isRequired, isListVisible: $isListVisible, isFilterable: $isFilterable, isSearchable: $isSearchable, options: $options, validation: $validation, defaultValue: $defaultValue, sortOrder: $sortOrder, section: $section, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $DynamicModuleFieldCopyWith<$Res>  {
  factory $DynamicModuleFieldCopyWith(DynamicModuleField value, $Res Function(DynamicModuleField) _then) = _$DynamicModuleFieldCopyWithImpl;
@useResult
$Res call({
 String id, String key, String label, String type,@JsonKey(name: 'is_required') bool isRequired,@JsonKey(name: 'is_list_visible') bool isListVisible,@JsonKey(name: 'is_filterable') bool isFilterable,@JsonKey(name: 'is_searchable') bool isSearchable, List<DynamicSelectOption> options, DynamicFieldValidation? validation,@JsonKey(name: 'default_value') dynamic defaultValue,@JsonKey(name: 'sort_order') int sortOrder, String? section,@JsonKey(name: 'is_active') bool isActive
});


$DynamicFieldValidationCopyWith<$Res>? get validation;

}
/// @nodoc
class _$DynamicModuleFieldCopyWithImpl<$Res>
    implements $DynamicModuleFieldCopyWith<$Res> {
  _$DynamicModuleFieldCopyWithImpl(this._self, this._then);

  final DynamicModuleField _self;
  final $Res Function(DynamicModuleField) _then;

/// Create a copy of DynamicModuleField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? key = null,Object? label = null,Object? type = null,Object? isRequired = null,Object? isListVisible = null,Object? isFilterable = null,Object? isSearchable = null,Object? options = null,Object? validation = freezed,Object? defaultValue = freezed,Object? sortOrder = null,Object? section = freezed,Object? isActive = null,}) {
  return _then(DynamicModuleField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,isListVisible: null == isListVisible ? _self.isListVisible : isListVisible // ignore: cast_nullable_to_non_nullable
as bool,isFilterable: null == isFilterable ? _self.isFilterable : isFilterable // ignore: cast_nullable_to_non_nullable
as bool,isSearchable: null == isSearchable ? _self.isSearchable : isSearchable // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<DynamicSelectOption>,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as DynamicFieldValidation?,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,section: freezed == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DynamicModuleField
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicFieldValidationCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $DynamicFieldValidationCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicModuleField].
extension DynamicModuleFieldPatterns on DynamicModuleField {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicModuleField value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicModuleField() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicModuleField value)  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleField():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicModuleField value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleField() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String key,  String label,  String type, @JsonKey(name: 'is_required')  bool isRequired, @JsonKey(name: 'is_list_visible')  bool isListVisible, @JsonKey(name: 'is_filterable')  bool isFilterable, @JsonKey(name: 'is_searchable')  bool isSearchable,  List<DynamicSelectOption> options,  DynamicFieldValidation? validation, @JsonKey(name: 'default_value')  dynamic defaultValue, @JsonKey(name: 'sort_order')  int sortOrder,  String? section, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicModuleField() when $default != null:
return $default(_that.id,_that.key,_that.label,_that.type,_that.isRequired,_that.isListVisible,_that.isFilterable,_that.isSearchable,_that.options,_that.validation,_that.defaultValue,_that.sortOrder,_that.section,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String key,  String label,  String type, @JsonKey(name: 'is_required')  bool isRequired, @JsonKey(name: 'is_list_visible')  bool isListVisible, @JsonKey(name: 'is_filterable')  bool isFilterable, @JsonKey(name: 'is_searchable')  bool isSearchable,  List<DynamicSelectOption> options,  DynamicFieldValidation? validation, @JsonKey(name: 'default_value')  dynamic defaultValue, @JsonKey(name: 'sort_order')  int sortOrder,  String? section, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleField():
return $default(_that.id,_that.key,_that.label,_that.type,_that.isRequired,_that.isListVisible,_that.isFilterable,_that.isSearchable,_that.options,_that.validation,_that.defaultValue,_that.sortOrder,_that.section,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String key,  String label,  String type, @JsonKey(name: 'is_required')  bool isRequired, @JsonKey(name: 'is_list_visible')  bool isListVisible, @JsonKey(name: 'is_filterable')  bool isFilterable, @JsonKey(name: 'is_searchable')  bool isSearchable,  List<DynamicSelectOption> options,  DynamicFieldValidation? validation, @JsonKey(name: 'default_value')  dynamic defaultValue, @JsonKey(name: 'sort_order')  int sortOrder,  String? section, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleField() when $default != null:
return $default(_that.id,_that.key,_that.label,_that.type,_that.isRequired,_that.isListVisible,_that.isFilterable,_that.isSearchable,_that.options,_that.validation,_that.defaultValue,_that.sortOrder,_that.section,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicModuleField implements DynamicModuleField {
  const _DynamicModuleField({required this.id, required this.key, required this.label, required this.type, @JsonKey(name: 'is_required') this.isRequired = false, @JsonKey(name: 'is_list_visible') this.isListVisible = true, @JsonKey(name: 'is_filterable') this.isFilterable = false, @JsonKey(name: 'is_searchable') this.isSearchable = false,  List<DynamicSelectOption> options = const <DynamicSelectOption>[], this.validation, @JsonKey(name: 'default_value') this.defaultValue, @JsonKey(name: 'sort_order') this.sortOrder = 0, this.section, @JsonKey(name: 'is_active') this.isActive = true}): _options = options;
  factory _DynamicModuleField.fromJson(Map<String, dynamic> json) => _$DynamicModuleFieldFromJson(json);

@override final  String id;
@override final  String key;
@override final  String label;
@override final  String type;
@override@JsonKey(name: 'is_required') final  bool isRequired;
@override@JsonKey(name: 'is_list_visible') final  bool isListVisible;
@override@JsonKey(name: 'is_filterable') final  bool isFilterable;
@override@JsonKey(name: 'is_searchable') final  bool isSearchable;
 final  List<DynamicSelectOption> _options;
@override@JsonKey() List<DynamicSelectOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  DynamicFieldValidation? validation;
@override@JsonKey(name: 'default_value') final  dynamic defaultValue;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override final  String? section;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of DynamicModuleField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicModuleFieldCopyWith<_DynamicModuleField> get copyWith => __$DynamicModuleFieldCopyWithImpl<_DynamicModuleField>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicModuleFieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicModuleField&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.isListVisible, isListVisible) || other.isListVisible == isListVisible)&&(identical(other.isFilterable, isFilterable) || other.isFilterable == isFilterable)&&(identical(other.isSearchable, isSearchable) || other.isSearchable == isSearchable)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.validation, validation) || other.validation == validation)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.section, section) || other.section == section)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,key,label,type,isRequired,isListVisible,isFilterable,isSearchable,const DeepCollectionEquality().hash(_options),validation,const DeepCollectionEquality().hash(defaultValue),sortOrder,section,isActive);

@override
String toString() {
  return 'DynamicModuleField(id: $id, key: $key, label: $label, type: $type, isRequired: $isRequired, isListVisible: $isListVisible, isFilterable: $isFilterable, isSearchable: $isSearchable, options: $options, validation: $validation, defaultValue: $defaultValue, sortOrder: $sortOrder, section: $section, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$DynamicModuleFieldCopyWith<$Res> implements $DynamicModuleFieldCopyWith<$Res> {
  factory _$DynamicModuleFieldCopyWith(_DynamicModuleField value, $Res Function(_DynamicModuleField) _then) = __$DynamicModuleFieldCopyWithImpl;
@override @useResult
$Res call({
 String id, String key, String label, String type,@JsonKey(name: 'is_required') bool isRequired,@JsonKey(name: 'is_list_visible') bool isListVisible,@JsonKey(name: 'is_filterable') bool isFilterable,@JsonKey(name: 'is_searchable') bool isSearchable, List<DynamicSelectOption> options, DynamicFieldValidation? validation,@JsonKey(name: 'default_value') dynamic defaultValue,@JsonKey(name: 'sort_order') int sortOrder, String? section,@JsonKey(name: 'is_active') bool isActive
});


@override $DynamicFieldValidationCopyWith<$Res>? get validation;

}
/// @nodoc
class __$DynamicModuleFieldCopyWithImpl<$Res>
    implements _$DynamicModuleFieldCopyWith<$Res> {
  __$DynamicModuleFieldCopyWithImpl(this._self, this._then);

  final _DynamicModuleField _self;
  final $Res Function(_DynamicModuleField) _then;

/// Create a copy of DynamicModuleField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? key = null,Object? label = null,Object? type = null,Object? isRequired = null,Object? isListVisible = null,Object? isFilterable = null,Object? isSearchable = null,Object? options = null,Object? validation = freezed,Object? defaultValue = freezed,Object? sortOrder = null,Object? section = freezed,Object? isActive = null,}) {
  return _then(_DynamicModuleField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,isListVisible: null == isListVisible ? _self.isListVisible : isListVisible // ignore: cast_nullable_to_non_nullable
as bool,isFilterable: null == isFilterable ? _self.isFilterable : isFilterable // ignore: cast_nullable_to_non_nullable
as bool,isSearchable: null == isSearchable ? _self.isSearchable : isSearchable // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<DynamicSelectOption>,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as DynamicFieldValidation?,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,section: freezed == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DynamicModuleField
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicFieldValidationCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $DynamicFieldValidationCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}


/// @nodoc
mixin _$DynamicModuleStatus {

 String get id; String get code; String get label; String get color;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'is_terminal') bool get isTerminal;@JsonKey(name: 'required_permission') String? get requiredPermission;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of DynamicModuleStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicModuleStatusCopyWith<DynamicModuleStatus> get copyWith => _$DynamicModuleStatusCopyWithImpl<DynamicModuleStatus>(this as DynamicModuleStatus, _$identity);

  /// Serializes this DynamicModuleStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicModuleStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isTerminal, isTerminal) || other.isTerminal == isTerminal)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,color,sortOrder,isTerminal,requiredPermission,isActive);

@override
String toString() {
  return 'DynamicModuleStatus(id: $id, code: $code, label: $label, color: $color, sortOrder: $sortOrder, isTerminal: $isTerminal, requiredPermission: $requiredPermission, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $DynamicModuleStatusCopyWith<$Res>  {
  factory $DynamicModuleStatusCopyWith(DynamicModuleStatus value, $Res Function(DynamicModuleStatus) _then) = _$DynamicModuleStatusCopyWithImpl;
@useResult
$Res call({
 String id, String code, String label, String color,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'is_terminal') bool isTerminal,@JsonKey(name: 'required_permission') String? requiredPermission,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$DynamicModuleStatusCopyWithImpl<$Res>
    implements $DynamicModuleStatusCopyWith<$Res> {
  _$DynamicModuleStatusCopyWithImpl(this._self, this._then);

  final DynamicModuleStatus _self;
  final $Res Function(DynamicModuleStatus) _then;

/// Create a copy of DynamicModuleStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? label = null,Object? color = null,Object? sortOrder = null,Object? isTerminal = null,Object? requiredPermission = freezed,Object? isActive = null,}) {
  return _then(DynamicModuleStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isTerminal: null == isTerminal ? _self.isTerminal : isTerminal // ignore: cast_nullable_to_non_nullable
as bool,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicModuleStatus].
extension DynamicModuleStatusPatterns on DynamicModuleStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicModuleStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicModuleStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicModuleStatus value)  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicModuleStatus value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String label,  String color, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'is_terminal')  bool isTerminal, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicModuleStatus() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.color,_that.sortOrder,_that.isTerminal,_that.requiredPermission,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String label,  String color, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'is_terminal')  bool isTerminal, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleStatus():
return $default(_that.id,_that.code,_that.label,_that.color,_that.sortOrder,_that.isTerminal,_that.requiredPermission,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String label,  String color, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'is_terminal')  bool isTerminal, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleStatus() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.color,_that.sortOrder,_that.isTerminal,_that.requiredPermission,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicModuleStatus implements DynamicModuleStatus {
  const _DynamicModuleStatus({required this.id, required this.code, required this.label, this.color = '#6B7280', @JsonKey(name: 'sort_order') this.sortOrder = 0, @JsonKey(name: 'is_terminal') this.isTerminal = false, @JsonKey(name: 'required_permission') this.requiredPermission, @JsonKey(name: 'is_active') this.isActive = true});
  factory _DynamicModuleStatus.fromJson(Map<String, dynamic> json) => _$DynamicModuleStatusFromJson(json);

@override final  String id;
@override final  String code;
@override final  String label;
@override@JsonKey() final  String color;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'is_terminal') final  bool isTerminal;
@override@JsonKey(name: 'required_permission') final  String? requiredPermission;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of DynamicModuleStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicModuleStatusCopyWith<_DynamicModuleStatus> get copyWith => __$DynamicModuleStatusCopyWithImpl<_DynamicModuleStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicModuleStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicModuleStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isTerminal, isTerminal) || other.isTerminal == isTerminal)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,color,sortOrder,isTerminal,requiredPermission,isActive);

@override
String toString() {
  return 'DynamicModuleStatus(id: $id, code: $code, label: $label, color: $color, sortOrder: $sortOrder, isTerminal: $isTerminal, requiredPermission: $requiredPermission, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$DynamicModuleStatusCopyWith<$Res> implements $DynamicModuleStatusCopyWith<$Res> {
  factory _$DynamicModuleStatusCopyWith(_DynamicModuleStatus value, $Res Function(_DynamicModuleStatus) _then) = __$DynamicModuleStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String label, String color,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'is_terminal') bool isTerminal,@JsonKey(name: 'required_permission') String? requiredPermission,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$DynamicModuleStatusCopyWithImpl<$Res>
    implements _$DynamicModuleStatusCopyWith<$Res> {
  __$DynamicModuleStatusCopyWithImpl(this._self, this._then);

  final _DynamicModuleStatus _self;
  final $Res Function(_DynamicModuleStatus) _then;

/// Create a copy of DynamicModuleStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? label = null,Object? color = null,Object? sortOrder = null,Object? isTerminal = null,Object? requiredPermission = freezed,Object? isActive = null,}) {
  return _then(_DynamicModuleStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isTerminal: null == isTerminal ? _self.isTerminal : isTerminal // ignore: cast_nullable_to_non_nullable
as bool,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DynamicModuleTransition {

 String get id;@JsonKey(name: 'from_status_id') String get fromStatusId;@JsonKey(name: 'to_status_id') String get toStatusId;@JsonKey(name: 'to_status_code') String? get toStatusCode;@JsonKey(name: 'to_status_label') String? get toStatusLabel;@JsonKey(name: 'to_status_color') String? get toStatusColor;@JsonKey(name: 'required_permission') String? get requiredPermission;
/// Create a copy of DynamicModuleTransition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicModuleTransitionCopyWith<DynamicModuleTransition> get copyWith => _$DynamicModuleTransitionCopyWithImpl<DynamicModuleTransition>(this as DynamicModuleTransition, _$identity);

  /// Serializes this DynamicModuleTransition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicModuleTransition&&(identical(other.id, id) || other.id == id)&&(identical(other.fromStatusId, fromStatusId) || other.fromStatusId == fromStatusId)&&(identical(other.toStatusId, toStatusId) || other.toStatusId == toStatusId)&&(identical(other.toStatusCode, toStatusCode) || other.toStatusCode == toStatusCode)&&(identical(other.toStatusLabel, toStatusLabel) || other.toStatusLabel == toStatusLabel)&&(identical(other.toStatusColor, toStatusColor) || other.toStatusColor == toStatusColor)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromStatusId,toStatusId,toStatusCode,toStatusLabel,toStatusColor,requiredPermission);

@override
String toString() {
  return 'DynamicModuleTransition(id: $id, fromStatusId: $fromStatusId, toStatusId: $toStatusId, toStatusCode: $toStatusCode, toStatusLabel: $toStatusLabel, toStatusColor: $toStatusColor, requiredPermission: $requiredPermission)';
}


}

/// @nodoc
abstract mixin class $DynamicModuleTransitionCopyWith<$Res>  {
  factory $DynamicModuleTransitionCopyWith(DynamicModuleTransition value, $Res Function(DynamicModuleTransition) _then) = _$DynamicModuleTransitionCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'from_status_id') String fromStatusId,@JsonKey(name: 'to_status_id') String toStatusId,@JsonKey(name: 'to_status_code') String? toStatusCode,@JsonKey(name: 'to_status_label') String? toStatusLabel,@JsonKey(name: 'to_status_color') String? toStatusColor,@JsonKey(name: 'required_permission') String? requiredPermission
});




}
/// @nodoc
class _$DynamicModuleTransitionCopyWithImpl<$Res>
    implements $DynamicModuleTransitionCopyWith<$Res> {
  _$DynamicModuleTransitionCopyWithImpl(this._self, this._then);

  final DynamicModuleTransition _self;
  final $Res Function(DynamicModuleTransition) _then;

/// Create a copy of DynamicModuleTransition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromStatusId = null,Object? toStatusId = null,Object? toStatusCode = freezed,Object? toStatusLabel = freezed,Object? toStatusColor = freezed,Object? requiredPermission = freezed,}) {
  return _then(DynamicModuleTransition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromStatusId: null == fromStatusId ? _self.fromStatusId : fromStatusId // ignore: cast_nullable_to_non_nullable
as String,toStatusId: null == toStatusId ? _self.toStatusId : toStatusId // ignore: cast_nullable_to_non_nullable
as String,toStatusCode: freezed == toStatusCode ? _self.toStatusCode : toStatusCode // ignore: cast_nullable_to_non_nullable
as String?,toStatusLabel: freezed == toStatusLabel ? _self.toStatusLabel : toStatusLabel // ignore: cast_nullable_to_non_nullable
as String?,toStatusColor: freezed == toStatusColor ? _self.toStatusColor : toStatusColor // ignore: cast_nullable_to_non_nullable
as String?,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicModuleTransition].
extension DynamicModuleTransitionPatterns on DynamicModuleTransition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicModuleTransition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicModuleTransition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicModuleTransition value)  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleTransition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicModuleTransition value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleTransition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'from_status_id')  String fromStatusId, @JsonKey(name: 'to_status_id')  String toStatusId, @JsonKey(name: 'to_status_code')  String? toStatusCode, @JsonKey(name: 'to_status_label')  String? toStatusLabel, @JsonKey(name: 'to_status_color')  String? toStatusColor, @JsonKey(name: 'required_permission')  String? requiredPermission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicModuleTransition() when $default != null:
return $default(_that.id,_that.fromStatusId,_that.toStatusId,_that.toStatusCode,_that.toStatusLabel,_that.toStatusColor,_that.requiredPermission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'from_status_id')  String fromStatusId, @JsonKey(name: 'to_status_id')  String toStatusId, @JsonKey(name: 'to_status_code')  String? toStatusCode, @JsonKey(name: 'to_status_label')  String? toStatusLabel, @JsonKey(name: 'to_status_color')  String? toStatusColor, @JsonKey(name: 'required_permission')  String? requiredPermission)  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleTransition():
return $default(_that.id,_that.fromStatusId,_that.toStatusId,_that.toStatusCode,_that.toStatusLabel,_that.toStatusColor,_that.requiredPermission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'from_status_id')  String fromStatusId, @JsonKey(name: 'to_status_id')  String toStatusId, @JsonKey(name: 'to_status_code')  String? toStatusCode, @JsonKey(name: 'to_status_label')  String? toStatusLabel, @JsonKey(name: 'to_status_color')  String? toStatusColor, @JsonKey(name: 'required_permission')  String? requiredPermission)?  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleTransition() when $default != null:
return $default(_that.id,_that.fromStatusId,_that.toStatusId,_that.toStatusCode,_that.toStatusLabel,_that.toStatusColor,_that.requiredPermission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicModuleTransition implements DynamicModuleTransition {
  const _DynamicModuleTransition({required this.id, @JsonKey(name: 'from_status_id') required this.fromStatusId, @JsonKey(name: 'to_status_id') required this.toStatusId, @JsonKey(name: 'to_status_code') this.toStatusCode, @JsonKey(name: 'to_status_label') this.toStatusLabel, @JsonKey(name: 'to_status_color') this.toStatusColor, @JsonKey(name: 'required_permission') this.requiredPermission});
  factory _DynamicModuleTransition.fromJson(Map<String, dynamic> json) => _$DynamicModuleTransitionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'from_status_id') final  String fromStatusId;
@override@JsonKey(name: 'to_status_id') final  String toStatusId;
@override@JsonKey(name: 'to_status_code') final  String? toStatusCode;
@override@JsonKey(name: 'to_status_label') final  String? toStatusLabel;
@override@JsonKey(name: 'to_status_color') final  String? toStatusColor;
@override@JsonKey(name: 'required_permission') final  String? requiredPermission;

/// Create a copy of DynamicModuleTransition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicModuleTransitionCopyWith<_DynamicModuleTransition> get copyWith => __$DynamicModuleTransitionCopyWithImpl<_DynamicModuleTransition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicModuleTransitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicModuleTransition&&(identical(other.id, id) || other.id == id)&&(identical(other.fromStatusId, fromStatusId) || other.fromStatusId == fromStatusId)&&(identical(other.toStatusId, toStatusId) || other.toStatusId == toStatusId)&&(identical(other.toStatusCode, toStatusCode) || other.toStatusCode == toStatusCode)&&(identical(other.toStatusLabel, toStatusLabel) || other.toStatusLabel == toStatusLabel)&&(identical(other.toStatusColor, toStatusColor) || other.toStatusColor == toStatusColor)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromStatusId,toStatusId,toStatusCode,toStatusLabel,toStatusColor,requiredPermission);

@override
String toString() {
  return 'DynamicModuleTransition(id: $id, fromStatusId: $fromStatusId, toStatusId: $toStatusId, toStatusCode: $toStatusCode, toStatusLabel: $toStatusLabel, toStatusColor: $toStatusColor, requiredPermission: $requiredPermission)';
}


}

/// @nodoc
abstract mixin class _$DynamicModuleTransitionCopyWith<$Res> implements $DynamicModuleTransitionCopyWith<$Res> {
  factory _$DynamicModuleTransitionCopyWith(_DynamicModuleTransition value, $Res Function(_DynamicModuleTransition) _then) = __$DynamicModuleTransitionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'from_status_id') String fromStatusId,@JsonKey(name: 'to_status_id') String toStatusId,@JsonKey(name: 'to_status_code') String? toStatusCode,@JsonKey(name: 'to_status_label') String? toStatusLabel,@JsonKey(name: 'to_status_color') String? toStatusColor,@JsonKey(name: 'required_permission') String? requiredPermission
});




}
/// @nodoc
class __$DynamicModuleTransitionCopyWithImpl<$Res>
    implements _$DynamicModuleTransitionCopyWith<$Res> {
  __$DynamicModuleTransitionCopyWithImpl(this._self, this._then);

  final _DynamicModuleTransition _self;
  final $Res Function(_DynamicModuleTransition) _then;

/// Create a copy of DynamicModuleTransition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromStatusId = null,Object? toStatusId = null,Object? toStatusCode = freezed,Object? toStatusLabel = freezed,Object? toStatusColor = freezed,Object? requiredPermission = freezed,}) {
  return _then(_DynamicModuleTransition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromStatusId: null == fromStatusId ? _self.fromStatusId : fromStatusId // ignore: cast_nullable_to_non_nullable
as String,toStatusId: null == toStatusId ? _self.toStatusId : toStatusId // ignore: cast_nullable_to_non_nullable
as String,toStatusCode: freezed == toStatusCode ? _self.toStatusCode : toStatusCode // ignore: cast_nullable_to_non_nullable
as String?,toStatusLabel: freezed == toStatusLabel ? _self.toStatusLabel : toStatusLabel // ignore: cast_nullable_to_non_nullable
as String?,toStatusColor: freezed == toStatusColor ? _self.toStatusColor : toStatusColor // ignore: cast_nullable_to_non_nullable
as String?,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DynamicModuleDefinition {

 String get id; String get code; String get label; int get version;@JsonKey(name: 'record_label_singular') String get recordLabelSingular;@JsonKey(name: 'record_label_plural') String get recordLabelPlural; String? get description;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'app_module_id') String? get appModuleId; List<DynamicModuleField> get fields; List<DynamicModuleStatus> get statuses; List<DynamicModuleTransition> get transitions;
/// Create a copy of DynamicModuleDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicModuleDefinitionCopyWith<DynamicModuleDefinition> get copyWith => _$DynamicModuleDefinitionCopyWithImpl<DynamicModuleDefinition>(this as DynamicModuleDefinition, _$identity);

  /// Serializes this DynamicModuleDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicModuleDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.version, version) || other.version == version)&&(identical(other.recordLabelSingular, recordLabelSingular) || other.recordLabelSingular == recordLabelSingular)&&(identical(other.recordLabelPlural, recordLabelPlural) || other.recordLabelPlural == recordLabelPlural)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.appModuleId, appModuleId) || other.appModuleId == appModuleId)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.transitions, transitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,version,recordLabelSingular,recordLabelPlural,description,isActive,appModuleId,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(transitions));

@override
String toString() {
  return 'DynamicModuleDefinition(id: $id, code: $code, label: $label, version: $version, recordLabelSingular: $recordLabelSingular, recordLabelPlural: $recordLabelPlural, description: $description, isActive: $isActive, appModuleId: $appModuleId, fields: $fields, statuses: $statuses, transitions: $transitions)';
}


}

/// @nodoc
abstract mixin class $DynamicModuleDefinitionCopyWith<$Res>  {
  factory $DynamicModuleDefinitionCopyWith(DynamicModuleDefinition value, $Res Function(DynamicModuleDefinition) _then) = _$DynamicModuleDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String code, String label, int version,@JsonKey(name: 'record_label_singular') String recordLabelSingular,@JsonKey(name: 'record_label_plural') String recordLabelPlural, String? description,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'app_module_id') String? appModuleId, List<DynamicModuleField> fields, List<DynamicModuleStatus> statuses, List<DynamicModuleTransition> transitions
});




}
/// @nodoc
class _$DynamicModuleDefinitionCopyWithImpl<$Res>
    implements $DynamicModuleDefinitionCopyWith<$Res> {
  _$DynamicModuleDefinitionCopyWithImpl(this._self, this._then);

  final DynamicModuleDefinition _self;
  final $Res Function(DynamicModuleDefinition) _then;

/// Create a copy of DynamicModuleDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? label = null,Object? version = null,Object? recordLabelSingular = null,Object? recordLabelPlural = null,Object? description = freezed,Object? isActive = null,Object? appModuleId = freezed,Object? fields = null,Object? statuses = null,Object? transitions = null,}) {
  return _then(DynamicModuleDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,recordLabelSingular: null == recordLabelSingular ? _self.recordLabelSingular : recordLabelSingular // ignore: cast_nullable_to_non_nullable
as String,recordLabelPlural: null == recordLabelPlural ? _self.recordLabelPlural : recordLabelPlural // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,appModuleId: freezed == appModuleId ? _self.appModuleId : appModuleId // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleField>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleStatus>,transitions: null == transitions ? _self.transitions : transitions // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleTransition>,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicModuleDefinition].
extension DynamicModuleDefinitionPatterns on DynamicModuleDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicModuleDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicModuleDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicModuleDefinition value)  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicModuleDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String label,  int version, @JsonKey(name: 'record_label_singular')  String recordLabelSingular, @JsonKey(name: 'record_label_plural')  String recordLabelPlural,  String? description, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'app_module_id')  String? appModuleId,  List<DynamicModuleField> fields,  List<DynamicModuleStatus> statuses,  List<DynamicModuleTransition> transitions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicModuleDefinition() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.version,_that.recordLabelSingular,_that.recordLabelPlural,_that.description,_that.isActive,_that.appModuleId,_that.fields,_that.statuses,_that.transitions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String label,  int version, @JsonKey(name: 'record_label_singular')  String recordLabelSingular, @JsonKey(name: 'record_label_plural')  String recordLabelPlural,  String? description, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'app_module_id')  String? appModuleId,  List<DynamicModuleField> fields,  List<DynamicModuleStatus> statuses,  List<DynamicModuleTransition> transitions)  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleDefinition():
return $default(_that.id,_that.code,_that.label,_that.version,_that.recordLabelSingular,_that.recordLabelPlural,_that.description,_that.isActive,_that.appModuleId,_that.fields,_that.statuses,_that.transitions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String label,  int version, @JsonKey(name: 'record_label_singular')  String recordLabelSingular, @JsonKey(name: 'record_label_plural')  String recordLabelPlural,  String? description, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'app_module_id')  String? appModuleId,  List<DynamicModuleField> fields,  List<DynamicModuleStatus> statuses,  List<DynamicModuleTransition> transitions)?  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleDefinition() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.version,_that.recordLabelSingular,_that.recordLabelPlural,_that.description,_that.isActive,_that.appModuleId,_that.fields,_that.statuses,_that.transitions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicModuleDefinition implements DynamicModuleDefinition {
  const _DynamicModuleDefinition({required this.id, required this.code, required this.label, this.version = 1, @JsonKey(name: 'record_label_singular') this.recordLabelSingular = 'Record', @JsonKey(name: 'record_label_plural') this.recordLabelPlural = 'Records', this.description, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'app_module_id') this.appModuleId,  List<DynamicModuleField> fields = const <DynamicModuleField>[],  List<DynamicModuleStatus> statuses = const <DynamicModuleStatus>[],  List<DynamicModuleTransition> transitions = const <DynamicModuleTransition>[]}): _fields = fields,_statuses = statuses,_transitions = transitions;
  factory _DynamicModuleDefinition.fromJson(Map<String, dynamic> json) => _$DynamicModuleDefinitionFromJson(json);

@override final  String id;
@override final  String code;
@override final  String label;
@override@JsonKey() final  int version;
@override@JsonKey(name: 'record_label_singular') final  String recordLabelSingular;
@override@JsonKey(name: 'record_label_plural') final  String recordLabelPlural;
@override final  String? description;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'app_module_id') final  String? appModuleId;
 final  List<DynamicModuleField> _fields;
@override@JsonKey() List<DynamicModuleField> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}

 final  List<DynamicModuleStatus> _statuses;
@override@JsonKey() List<DynamicModuleStatus> get statuses {
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statuses);
}

 final  List<DynamicModuleTransition> _transitions;
@override@JsonKey() List<DynamicModuleTransition> get transitions {
  if (_transitions is EqualUnmodifiableListView) return _transitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transitions);
}


/// Create a copy of DynamicModuleDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicModuleDefinitionCopyWith<_DynamicModuleDefinition> get copyWith => __$DynamicModuleDefinitionCopyWithImpl<_DynamicModuleDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicModuleDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicModuleDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.version, version) || other.version == version)&&(identical(other.recordLabelSingular, recordLabelSingular) || other.recordLabelSingular == recordLabelSingular)&&(identical(other.recordLabelPlural, recordLabelPlural) || other.recordLabelPlural == recordLabelPlural)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.appModuleId, appModuleId) || other.appModuleId == appModuleId)&&const DeepCollectionEquality().equals(other._fields, _fields)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._transitions, _transitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,version,recordLabelSingular,recordLabelPlural,description,isActive,appModuleId,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_transitions));

@override
String toString() {
  return 'DynamicModuleDefinition(id: $id, code: $code, label: $label, version: $version, recordLabelSingular: $recordLabelSingular, recordLabelPlural: $recordLabelPlural, description: $description, isActive: $isActive, appModuleId: $appModuleId, fields: $fields, statuses: $statuses, transitions: $transitions)';
}


}

/// @nodoc
abstract mixin class _$DynamicModuleDefinitionCopyWith<$Res> implements $DynamicModuleDefinitionCopyWith<$Res> {
  factory _$DynamicModuleDefinitionCopyWith(_DynamicModuleDefinition value, $Res Function(_DynamicModuleDefinition) _then) = __$DynamicModuleDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String label, int version,@JsonKey(name: 'record_label_singular') String recordLabelSingular,@JsonKey(name: 'record_label_plural') String recordLabelPlural, String? description,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'app_module_id') String? appModuleId, List<DynamicModuleField> fields, List<DynamicModuleStatus> statuses, List<DynamicModuleTransition> transitions
});




}
/// @nodoc
class __$DynamicModuleDefinitionCopyWithImpl<$Res>
    implements _$DynamicModuleDefinitionCopyWith<$Res> {
  __$DynamicModuleDefinitionCopyWithImpl(this._self, this._then);

  final _DynamicModuleDefinition _self;
  final $Res Function(_DynamicModuleDefinition) _then;

/// Create a copy of DynamicModuleDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? label = null,Object? version = null,Object? recordLabelSingular = null,Object? recordLabelPlural = null,Object? description = freezed,Object? isActive = null,Object? appModuleId = freezed,Object? fields = null,Object? statuses = null,Object? transitions = null,}) {
  return _then(_DynamicModuleDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,recordLabelSingular: null == recordLabelSingular ? _self.recordLabelSingular : recordLabelSingular // ignore: cast_nullable_to_non_nullable
as String,recordLabelPlural: null == recordLabelPlural ? _self.recordLabelPlural : recordLabelPlural // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,appModuleId: freezed == appModuleId ? _self.appModuleId : appModuleId // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleField>,statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleStatus>,transitions: null == transitions ? _self._transitions : transitions // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleTransition>,
  ));
}


}


/// @nodoc
mixin _$DynamicRecordComment {

 String get id;@JsonKey(name: 'record_id') String get recordId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_name') String? get userName; String get comment;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of DynamicRecordComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordCommentCopyWith<DynamicRecordComment> get copyWith => _$DynamicRecordCommentCopyWithImpl<DynamicRecordComment>(this as DynamicRecordComment, _$identity);

  /// Serializes this DynamicRecordComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordComment&&(identical(other.id, id) || other.id == id)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,recordId,userId,userName,comment,createdAt);

@override
String toString() {
  return 'DynamicRecordComment(id: $id, recordId: $recordId, userId: $userId, userName: $userName, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordCommentCopyWith<$Res>  {
  factory $DynamicRecordCommentCopyWith(DynamicRecordComment value, $Res Function(DynamicRecordComment) _then) = _$DynamicRecordCommentCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'record_id') String recordId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String? userName, String comment,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$DynamicRecordCommentCopyWithImpl<$Res>
    implements $DynamicRecordCommentCopyWith<$Res> {
  _$DynamicRecordCommentCopyWithImpl(this._self, this._then);

  final DynamicRecordComment _self;
  final $Res Function(DynamicRecordComment) _then;

/// Create a copy of DynamicRecordComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? recordId = null,Object? userId = null,Object? userName = freezed,Object? comment = null,Object? createdAt = null,}) {
  return _then(DynamicRecordComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicRecordComment].
extension DynamicRecordCommentPatterns on DynamicRecordComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordComment value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordComment value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordComment() when $default != null:
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordComment():
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName,  String comment, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordComment() when $default != null:
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicRecordComment implements DynamicRecordComment {
  const _DynamicRecordComment({required this.id, @JsonKey(name: 'record_id') required this.recordId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_name') this.userName, required this.comment, @JsonKey(name: 'created_at') required this.createdAt});
  factory _DynamicRecordComment.fromJson(Map<String, dynamic> json) => _$DynamicRecordCommentFromJson(json);

@override final  String id;
@override@JsonKey(name: 'record_id') final  String recordId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_name') final  String? userName;
@override final  String comment;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of DynamicRecordComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordCommentCopyWith<_DynamicRecordComment> get copyWith => __$DynamicRecordCommentCopyWithImpl<_DynamicRecordComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicRecordCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordComment&&(identical(other.id, id) || other.id == id)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,recordId,userId,userName,comment,createdAt);

@override
String toString() {
  return 'DynamicRecordComment(id: $id, recordId: $recordId, userId: $userId, userName: $userName, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordCommentCopyWith<$Res> implements $DynamicRecordCommentCopyWith<$Res> {
  factory _$DynamicRecordCommentCopyWith(_DynamicRecordComment value, $Res Function(_DynamicRecordComment) _then) = __$DynamicRecordCommentCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'record_id') String recordId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String? userName, String comment,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$DynamicRecordCommentCopyWithImpl<$Res>
    implements _$DynamicRecordCommentCopyWith<$Res> {
  __$DynamicRecordCommentCopyWithImpl(this._self, this._then);

  final _DynamicRecordComment _self;
  final $Res Function(_DynamicRecordComment) _then;

/// Create a copy of DynamicRecordComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? recordId = null,Object? userId = null,Object? userName = freezed,Object? comment = null,Object? createdAt = null,}) {
  return _then(_DynamicRecordComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$DynamicRecordAttachment {

 String get id;@JsonKey(name: 'record_id') String get recordId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_name') String? get userName;@JsonKey(name: 'file_url') String get fileUrl;@JsonKey(name: 'file_name') String get fileName;@JsonKey(name: 'file_size') int get fileSize;@JsonKey(name: 'mime_type') String? get mimeType;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of DynamicRecordAttachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordAttachmentCopyWith<DynamicRecordAttachment> get copyWith => _$DynamicRecordAttachmentCopyWithImpl<DynamicRecordAttachment>(this as DynamicRecordAttachment, _$identity);

  /// Serializes this DynamicRecordAttachment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,recordId,userId,userName,fileUrl,fileName,fileSize,mimeType,createdAt);

@override
String toString() {
  return 'DynamicRecordAttachment(id: $id, recordId: $recordId, userId: $userId, userName: $userName, fileUrl: $fileUrl, fileName: $fileName, fileSize: $fileSize, mimeType: $mimeType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordAttachmentCopyWith<$Res>  {
  factory $DynamicRecordAttachmentCopyWith(DynamicRecordAttachment value, $Res Function(DynamicRecordAttachment) _then) = _$DynamicRecordAttachmentCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'record_id') String recordId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String? userName,@JsonKey(name: 'file_url') String fileUrl,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_size') int fileSize,@JsonKey(name: 'mime_type') String? mimeType,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$DynamicRecordAttachmentCopyWithImpl<$Res>
    implements $DynamicRecordAttachmentCopyWith<$Res> {
  _$DynamicRecordAttachmentCopyWithImpl(this._self, this._then);

  final DynamicRecordAttachment _self;
  final $Res Function(DynamicRecordAttachment) _then;

/// Create a copy of DynamicRecordAttachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? recordId = null,Object? userId = null,Object? userName = freezed,Object? fileUrl = null,Object? fileName = null,Object? fileSize = null,Object? mimeType = freezed,Object? createdAt = null,}) {
  return _then(DynamicRecordAttachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicRecordAttachment].
extension DynamicRecordAttachmentPatterns on DynamicRecordAttachment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordAttachment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordAttachment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordAttachment value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordAttachment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordAttachment value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordAttachment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName, @JsonKey(name: 'file_url')  String fileUrl, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size')  int fileSize, @JsonKey(name: 'mime_type')  String? mimeType, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordAttachment() when $default != null:
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.fileUrl,_that.fileName,_that.fileSize,_that.mimeType,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName, @JsonKey(name: 'file_url')  String fileUrl, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size')  int fileSize, @JsonKey(name: 'mime_type')  String? mimeType, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordAttachment():
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.fileUrl,_that.fileName,_that.fileSize,_that.mimeType,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName, @JsonKey(name: 'file_url')  String fileUrl, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size')  int fileSize, @JsonKey(name: 'mime_type')  String? mimeType, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordAttachment() when $default != null:
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.fileUrl,_that.fileName,_that.fileSize,_that.mimeType,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicRecordAttachment implements DynamicRecordAttachment {
  const _DynamicRecordAttachment({required this.id, @JsonKey(name: 'record_id') required this.recordId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_name') this.userName, @JsonKey(name: 'file_url') required this.fileUrl, @JsonKey(name: 'file_name') required this.fileName, @JsonKey(name: 'file_size') this.fileSize = 0, @JsonKey(name: 'mime_type') this.mimeType, @JsonKey(name: 'created_at') required this.createdAt});
  factory _DynamicRecordAttachment.fromJson(Map<String, dynamic> json) => _$DynamicRecordAttachmentFromJson(json);

@override final  String id;
@override@JsonKey(name: 'record_id') final  String recordId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_name') final  String? userName;
@override@JsonKey(name: 'file_url') final  String fileUrl;
@override@JsonKey(name: 'file_name') final  String fileName;
@override@JsonKey(name: 'file_size') final  int fileSize;
@override@JsonKey(name: 'mime_type') final  String? mimeType;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of DynamicRecordAttachment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordAttachmentCopyWith<_DynamicRecordAttachment> get copyWith => __$DynamicRecordAttachmentCopyWithImpl<_DynamicRecordAttachment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicRecordAttachmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,recordId,userId,userName,fileUrl,fileName,fileSize,mimeType,createdAt);

@override
String toString() {
  return 'DynamicRecordAttachment(id: $id, recordId: $recordId, userId: $userId, userName: $userName, fileUrl: $fileUrl, fileName: $fileName, fileSize: $fileSize, mimeType: $mimeType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordAttachmentCopyWith<$Res> implements $DynamicRecordAttachmentCopyWith<$Res> {
  factory _$DynamicRecordAttachmentCopyWith(_DynamicRecordAttachment value, $Res Function(_DynamicRecordAttachment) _then) = __$DynamicRecordAttachmentCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'record_id') String recordId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String? userName,@JsonKey(name: 'file_url') String fileUrl,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_size') int fileSize,@JsonKey(name: 'mime_type') String? mimeType,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$DynamicRecordAttachmentCopyWithImpl<$Res>
    implements _$DynamicRecordAttachmentCopyWith<$Res> {
  __$DynamicRecordAttachmentCopyWithImpl(this._self, this._then);

  final _DynamicRecordAttachment _self;
  final $Res Function(_DynamicRecordAttachment) _then;

/// Create a copy of DynamicRecordAttachment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? recordId = null,Object? userId = null,Object? userName = freezed,Object? fileUrl = null,Object? fileName = null,Object? fileSize = null,Object? mimeType = freezed,Object? createdAt = null,}) {
  return _then(_DynamicRecordAttachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$DynamicRecordActivity {

 String get id;@JsonKey(name: 'record_id') String get recordId;@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'user_name') String? get userName; String get action; Map<String, dynamic>? get details;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of DynamicRecordActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordActivityCopyWith<DynamicRecordActivity> get copyWith => _$DynamicRecordActivityCopyWithImpl<DynamicRecordActivity>(this as DynamicRecordActivity, _$identity);

  /// Serializes this DynamicRecordActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other.details, details)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,recordId,userId,userName,action,const DeepCollectionEquality().hash(details),createdAt);

@override
String toString() {
  return 'DynamicRecordActivity(id: $id, recordId: $recordId, userId: $userId, userName: $userName, action: $action, details: $details, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordActivityCopyWith<$Res>  {
  factory $DynamicRecordActivityCopyWith(DynamicRecordActivity value, $Res Function(DynamicRecordActivity) _then) = _$DynamicRecordActivityCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'record_id') String recordId,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'user_name') String? userName, String action, Map<String, dynamic>? details,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$DynamicRecordActivityCopyWithImpl<$Res>
    implements $DynamicRecordActivityCopyWith<$Res> {
  _$DynamicRecordActivityCopyWithImpl(this._self, this._then);

  final DynamicRecordActivity _self;
  final $Res Function(DynamicRecordActivity) _then;

/// Create a copy of DynamicRecordActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? recordId = null,Object? userId = freezed,Object? userName = freezed,Object? action = null,Object? details = freezed,Object? createdAt = null,}) {
  return _then(DynamicRecordActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicRecordActivity].
extension DynamicRecordActivityPatterns on DynamicRecordActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordActivity value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordActivity value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'user_name')  String? userName,  String action,  Map<String, dynamic>? details, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordActivity() when $default != null:
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.action,_that.details,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'user_name')  String? userName,  String action,  Map<String, dynamic>? details, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordActivity():
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.action,_that.details,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'record_id')  String recordId, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'user_name')  String? userName,  String action,  Map<String, dynamic>? details, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordActivity() when $default != null:
return $default(_that.id,_that.recordId,_that.userId,_that.userName,_that.action,_that.details,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicRecordActivity implements DynamicRecordActivity {
  const _DynamicRecordActivity({required this.id, @JsonKey(name: 'record_id') required this.recordId, @JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'user_name') this.userName, required this.action,  Map<String, dynamic>? details, @JsonKey(name: 'created_at') required this.createdAt}): _details = details;
  factory _DynamicRecordActivity.fromJson(Map<String, dynamic> json) => _$DynamicRecordActivityFromJson(json);

@override final  String id;
@override@JsonKey(name: 'record_id') final  String recordId;
@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'user_name') final  String? userName;
@override final  String action;
 final  Map<String, dynamic>? _details;
@override Map<String, dynamic>? get details {
  final value = _details;
  if (value == null) return null;
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of DynamicRecordActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordActivityCopyWith<_DynamicRecordActivity> get copyWith => __$DynamicRecordActivityCopyWithImpl<_DynamicRecordActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicRecordActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other._details, _details)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,recordId,userId,userName,action,const DeepCollectionEquality().hash(_details),createdAt);

@override
String toString() {
  return 'DynamicRecordActivity(id: $id, recordId: $recordId, userId: $userId, userName: $userName, action: $action, details: $details, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordActivityCopyWith<$Res> implements $DynamicRecordActivityCopyWith<$Res> {
  factory _$DynamicRecordActivityCopyWith(_DynamicRecordActivity value, $Res Function(_DynamicRecordActivity) _then) = __$DynamicRecordActivityCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'record_id') String recordId,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'user_name') String? userName, String action, Map<String, dynamic>? details,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$DynamicRecordActivityCopyWithImpl<$Res>
    implements _$DynamicRecordActivityCopyWith<$Res> {
  __$DynamicRecordActivityCopyWithImpl(this._self, this._then);

  final _DynamicRecordActivity _self;
  final $Res Function(_DynamicRecordActivity) _then;

/// Create a copy of DynamicRecordActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? recordId = null,Object? userId = freezed,Object? userName = freezed,Object? action = null,Object? details = freezed,Object? createdAt = null,}) {
  return _then(_DynamicRecordActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$DynamicRecordModel {

 String get id;@JsonKey(name: 'module_id') String get moduleId; Map<String, dynamic> get data;@JsonKey(name: 'status_id') String? get statusId; DynamicModuleStatus? get status;@JsonKey(name: 'created_by') String get createdBy;@JsonKey(name: 'creator_name') String? get creatorName;@JsonKey(name: 'assigned_to') String? get assignedTo;@JsonKey(name: 'assignee_name') String? get assigneeName;@JsonKey(name: 'client_id') String? get clientId;@JsonKey(name: 'client_name') String? get clientName;@JsonKey(name: 'due_at') DateTime? get dueAt;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> get allowedTransitions;
/// Create a copy of DynamicRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordModelCopyWith<DynamicRecordModel> get copyWith => _$DynamicRecordModelCopyWithImpl<DynamicRecordModel>(this as DynamicRecordModel, _$identity);

  /// Serializes this DynamicRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.assigneeName, assigneeName) || other.assigneeName == assigneeName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.allowedTransitions, allowedTransitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moduleId,const DeepCollectionEquality().hash(data),statusId,status,createdBy,creatorName,assignedTo,assigneeName,clientId,clientName,dueAt,createdAt,updatedAt,const DeepCollectionEquality().hash(allowedTransitions));

@override
String toString() {
  return 'DynamicRecordModel(id: $id, moduleId: $moduleId, data: $data, statusId: $statusId, status: $status, createdBy: $createdBy, creatorName: $creatorName, assignedTo: $assignedTo, assigneeName: $assigneeName, clientId: $clientId, clientName: $clientName, dueAt: $dueAt, createdAt: $createdAt, updatedAt: $updatedAt, allowedTransitions: $allowedTransitions)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordModelCopyWith<$Res>  {
  factory $DynamicRecordModelCopyWith(DynamicRecordModel value, $Res Function(DynamicRecordModel) _then) = _$DynamicRecordModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'module_id') String moduleId, Map<String, dynamic> data,@JsonKey(name: 'status_id') String? statusId, DynamicModuleStatus? status,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'creator_name') String? creatorName,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'assignee_name') String? assigneeName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'due_at') DateTime? dueAt,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> allowedTransitions
});


$DynamicModuleStatusCopyWith<$Res>? get status;

}
/// @nodoc
class _$DynamicRecordModelCopyWithImpl<$Res>
    implements $DynamicRecordModelCopyWith<$Res> {
  _$DynamicRecordModelCopyWithImpl(this._self, this._then);

  final DynamicRecordModel _self;
  final $Res Function(DynamicRecordModel) _then;

/// Create a copy of DynamicRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moduleId = null,Object? data = null,Object? statusId = freezed,Object? status = freezed,Object? createdBy = null,Object? creatorName = freezed,Object? assignedTo = freezed,Object? assigneeName = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? dueAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? allowedTransitions = null,}) {
  return _then(DynamicRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DynamicModuleStatus?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,creatorName: freezed == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,assigneeName: freezed == assigneeName ? _self.assigneeName : assigneeName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,allowedTransitions: null == allowedTransitions ? _self.allowedTransitions : allowedTransitions // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleTransition>,
  ));
}
/// Create a copy of DynamicRecordModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicModuleStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $DynamicModuleStatusCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicRecordModel].
extension DynamicRecordModelPatterns on DynamicRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'module_id')  String moduleId,  Map<String, dynamic> data, @JsonKey(name: 'status_id')  String? statusId,  DynamicModuleStatus? status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'creator_name')  String? creatorName, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'assignee_name')  String? assigneeName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordModel() when $default != null:
return $default(_that.id,_that.moduleId,_that.data,_that.statusId,_that.status,_that.createdBy,_that.creatorName,_that.assignedTo,_that.assigneeName,_that.clientId,_that.clientName,_that.dueAt,_that.createdAt,_that.updatedAt,_that.allowedTransitions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'module_id')  String moduleId,  Map<String, dynamic> data, @JsonKey(name: 'status_id')  String? statusId,  DynamicModuleStatus? status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'creator_name')  String? creatorName, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'assignee_name')  String? assigneeName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordModel():
return $default(_that.id,_that.moduleId,_that.data,_that.statusId,_that.status,_that.createdBy,_that.creatorName,_that.assignedTo,_that.assigneeName,_that.clientId,_that.clientName,_that.dueAt,_that.createdAt,_that.updatedAt,_that.allowedTransitions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'module_id')  String moduleId,  Map<String, dynamic> data, @JsonKey(name: 'status_id')  String? statusId,  DynamicModuleStatus? status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'creator_name')  String? creatorName, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'assignee_name')  String? assigneeName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordModel() when $default != null:
return $default(_that.id,_that.moduleId,_that.data,_that.statusId,_that.status,_that.createdBy,_that.creatorName,_that.assignedTo,_that.assigneeName,_that.clientId,_that.clientName,_that.dueAt,_that.createdAt,_that.updatedAt,_that.allowedTransitions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicRecordModel implements DynamicRecordModel {
  const _DynamicRecordModel({required this.id, @JsonKey(name: 'module_id') required this.moduleId,  Map<String, dynamic> data = const <String, dynamic>{}, @JsonKey(name: 'status_id') this.statusId, this.status, @JsonKey(name: 'created_by') required this.createdBy, @JsonKey(name: 'creator_name') this.creatorName, @JsonKey(name: 'assigned_to') this.assignedTo, @JsonKey(name: 'assignee_name') this.assigneeName, @JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'client_name') this.clientName, @JsonKey(name: 'due_at') this.dueAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions = const <DynamicModuleTransition>[]}): _data = data,_allowedTransitions = allowedTransitions;
  factory _DynamicRecordModel.fromJson(Map<String, dynamic> json) => _$DynamicRecordModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'module_id') final  String moduleId;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override@JsonKey(name: 'status_id') final  String? statusId;
@override final  DynamicModuleStatus? status;
@override@JsonKey(name: 'created_by') final  String createdBy;
@override@JsonKey(name: 'creator_name') final  String? creatorName;
@override@JsonKey(name: 'assigned_to') final  String? assignedTo;
@override@JsonKey(name: 'assignee_name') final  String? assigneeName;
@override@JsonKey(name: 'client_id') final  String? clientId;
@override@JsonKey(name: 'client_name') final  String? clientName;
@override@JsonKey(name: 'due_at') final  DateTime? dueAt;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
 final  List<DynamicModuleTransition> _allowedTransitions;
@override@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> get allowedTransitions {
  if (_allowedTransitions is EqualUnmodifiableListView) return _allowedTransitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedTransitions);
}


/// Create a copy of DynamicRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordModelCopyWith<_DynamicRecordModel> get copyWith => __$DynamicRecordModelCopyWithImpl<_DynamicRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.assigneeName, assigneeName) || other.assigneeName == assigneeName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._allowedTransitions, _allowedTransitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moduleId,const DeepCollectionEquality().hash(_data),statusId,status,createdBy,creatorName,assignedTo,assigneeName,clientId,clientName,dueAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_allowedTransitions));

@override
String toString() {
  return 'DynamicRecordModel(id: $id, moduleId: $moduleId, data: $data, statusId: $statusId, status: $status, createdBy: $createdBy, creatorName: $creatorName, assignedTo: $assignedTo, assigneeName: $assigneeName, clientId: $clientId, clientName: $clientName, dueAt: $dueAt, createdAt: $createdAt, updatedAt: $updatedAt, allowedTransitions: $allowedTransitions)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordModelCopyWith<$Res> implements $DynamicRecordModelCopyWith<$Res> {
  factory _$DynamicRecordModelCopyWith(_DynamicRecordModel value, $Res Function(_DynamicRecordModel) _then) = __$DynamicRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'module_id') String moduleId, Map<String, dynamic> data,@JsonKey(name: 'status_id') String? statusId, DynamicModuleStatus? status,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'creator_name') String? creatorName,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'assignee_name') String? assigneeName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'due_at') DateTime? dueAt,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> allowedTransitions
});


@override $DynamicModuleStatusCopyWith<$Res>? get status;

}
/// @nodoc
class __$DynamicRecordModelCopyWithImpl<$Res>
    implements _$DynamicRecordModelCopyWith<$Res> {
  __$DynamicRecordModelCopyWithImpl(this._self, this._then);

  final _DynamicRecordModel _self;
  final $Res Function(_DynamicRecordModel) _then;

/// Create a copy of DynamicRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moduleId = null,Object? data = null,Object? statusId = freezed,Object? status = freezed,Object? createdBy = null,Object? creatorName = freezed,Object? assignedTo = freezed,Object? assigneeName = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? dueAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? allowedTransitions = null,}) {
  return _then(_DynamicRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DynamicModuleStatus?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,creatorName: freezed == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,assigneeName: freezed == assigneeName ? _self.assigneeName : assigneeName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,allowedTransitions: null == allowedTransitions ? _self._allowedTransitions : allowedTransitions // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleTransition>,
  ));
}

/// Create a copy of DynamicRecordModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicModuleStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $DynamicModuleStatusCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
mixin _$DynamicRecordDetailModel {

 String get id;@JsonKey(name: 'module_id') String get moduleId; Map<String, dynamic> get data;@JsonKey(name: 'status_id') String? get statusId; DynamicModuleStatus? get status;@JsonKey(name: 'created_by') String get createdBy;@JsonKey(name: 'creator_name') String? get creatorName;@JsonKey(name: 'assigned_to') String? get assignedTo;@JsonKey(name: 'assignee_name') String? get assigneeName;@JsonKey(name: 'client_id') String? get clientId;@JsonKey(name: 'client_name') String? get clientName;@JsonKey(name: 'due_at') DateTime? get dueAt;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> get allowedTransitions; List<DynamicRecordComment> get comments; List<DynamicRecordAttachment> get attachments; List<DynamicRecordActivity> get activities;
/// Create a copy of DynamicRecordDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordDetailModelCopyWith<DynamicRecordDetailModel> get copyWith => _$DynamicRecordDetailModelCopyWithImpl<DynamicRecordDetailModel>(this as DynamicRecordDetailModel, _$identity);

  /// Serializes this DynamicRecordDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.assigneeName, assigneeName) || other.assigneeName == assigneeName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.allowedTransitions, allowedTransitions)&&const DeepCollectionEquality().equals(other.comments, comments)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&const DeepCollectionEquality().equals(other.activities, activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moduleId,const DeepCollectionEquality().hash(data),statusId,status,createdBy,creatorName,assignedTo,assigneeName,clientId,clientName,dueAt,createdAt,updatedAt,const DeepCollectionEquality().hash(allowedTransitions),const DeepCollectionEquality().hash(comments),const DeepCollectionEquality().hash(attachments),const DeepCollectionEquality().hash(activities));

@override
String toString() {
  return 'DynamicRecordDetailModel(id: $id, moduleId: $moduleId, data: $data, statusId: $statusId, status: $status, createdBy: $createdBy, creatorName: $creatorName, assignedTo: $assignedTo, assigneeName: $assigneeName, clientId: $clientId, clientName: $clientName, dueAt: $dueAt, createdAt: $createdAt, updatedAt: $updatedAt, allowedTransitions: $allowedTransitions, comments: $comments, attachments: $attachments, activities: $activities)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordDetailModelCopyWith<$Res>  {
  factory $DynamicRecordDetailModelCopyWith(DynamicRecordDetailModel value, $Res Function(DynamicRecordDetailModel) _then) = _$DynamicRecordDetailModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'module_id') String moduleId, Map<String, dynamic> data,@JsonKey(name: 'status_id') String? statusId, DynamicModuleStatus? status,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'creator_name') String? creatorName,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'assignee_name') String? assigneeName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'due_at') DateTime? dueAt,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> allowedTransitions, List<DynamicRecordComment> comments, List<DynamicRecordAttachment> attachments, List<DynamicRecordActivity> activities
});


$DynamicModuleStatusCopyWith<$Res>? get status;

}
/// @nodoc
class _$DynamicRecordDetailModelCopyWithImpl<$Res>
    implements $DynamicRecordDetailModelCopyWith<$Res> {
  _$DynamicRecordDetailModelCopyWithImpl(this._self, this._then);

  final DynamicRecordDetailModel _self;
  final $Res Function(DynamicRecordDetailModel) _then;

/// Create a copy of DynamicRecordDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moduleId = null,Object? data = null,Object? statusId = freezed,Object? status = freezed,Object? createdBy = null,Object? creatorName = freezed,Object? assignedTo = freezed,Object? assigneeName = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? dueAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? allowedTransitions = null,Object? comments = null,Object? attachments = null,Object? activities = null,}) {
  return _then(DynamicRecordDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DynamicModuleStatus?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,creatorName: freezed == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,assigneeName: freezed == assigneeName ? _self.assigneeName : assigneeName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,allowedTransitions: null == allowedTransitions ? _self.allowedTransitions : allowedTransitions // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleTransition>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordComment>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordAttachment>,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordActivity>,
  ));
}
/// Create a copy of DynamicRecordDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicModuleStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $DynamicModuleStatusCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicRecordDetailModel].
extension DynamicRecordDetailModelPatterns on DynamicRecordDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'module_id')  String moduleId,  Map<String, dynamic> data, @JsonKey(name: 'status_id')  String? statusId,  DynamicModuleStatus? status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'creator_name')  String? creatorName, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'assignee_name')  String? assigneeName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions,  List<DynamicRecordComment> comments,  List<DynamicRecordAttachment> attachments,  List<DynamicRecordActivity> activities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordDetailModel() when $default != null:
return $default(_that.id,_that.moduleId,_that.data,_that.statusId,_that.status,_that.createdBy,_that.creatorName,_that.assignedTo,_that.assigneeName,_that.clientId,_that.clientName,_that.dueAt,_that.createdAt,_that.updatedAt,_that.allowedTransitions,_that.comments,_that.attachments,_that.activities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'module_id')  String moduleId,  Map<String, dynamic> data, @JsonKey(name: 'status_id')  String? statusId,  DynamicModuleStatus? status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'creator_name')  String? creatorName, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'assignee_name')  String? assigneeName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions,  List<DynamicRecordComment> comments,  List<DynamicRecordAttachment> attachments,  List<DynamicRecordActivity> activities)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordDetailModel():
return $default(_that.id,_that.moduleId,_that.data,_that.statusId,_that.status,_that.createdBy,_that.creatorName,_that.assignedTo,_that.assigneeName,_that.clientId,_that.clientName,_that.dueAt,_that.createdAt,_that.updatedAt,_that.allowedTransitions,_that.comments,_that.attachments,_that.activities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'module_id')  String moduleId,  Map<String, dynamic> data, @JsonKey(name: 'status_id')  String? statusId,  DynamicModuleStatus? status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'creator_name')  String? creatorName, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'assignee_name')  String? assigneeName, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'due_at')  DateTime? dueAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions,  List<DynamicRecordComment> comments,  List<DynamicRecordAttachment> attachments,  List<DynamicRecordActivity> activities)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordDetailModel() when $default != null:
return $default(_that.id,_that.moduleId,_that.data,_that.statusId,_that.status,_that.createdBy,_that.creatorName,_that.assignedTo,_that.assigneeName,_that.clientId,_that.clientName,_that.dueAt,_that.createdAt,_that.updatedAt,_that.allowedTransitions,_that.comments,_that.attachments,_that.activities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicRecordDetailModel implements DynamicRecordDetailModel {
  const _DynamicRecordDetailModel({required this.id, @JsonKey(name: 'module_id') required this.moduleId,  Map<String, dynamic> data = const <String, dynamic>{}, @JsonKey(name: 'status_id') this.statusId, this.status, @JsonKey(name: 'created_by') required this.createdBy, @JsonKey(name: 'creator_name') this.creatorName, @JsonKey(name: 'assigned_to') this.assignedTo, @JsonKey(name: 'assignee_name') this.assigneeName, @JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'client_name') this.clientName, @JsonKey(name: 'due_at') this.dueAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'allowed_transitions')  List<DynamicModuleTransition> allowedTransitions = const <DynamicModuleTransition>[],  List<DynamicRecordComment> comments = const <DynamicRecordComment>[],  List<DynamicRecordAttachment> attachments = const <DynamicRecordAttachment>[],  List<DynamicRecordActivity> activities = const <DynamicRecordActivity>[]}): _data = data,_allowedTransitions = allowedTransitions,_comments = comments,_attachments = attachments,_activities = activities;
  factory _DynamicRecordDetailModel.fromJson(Map<String, dynamic> json) => _$DynamicRecordDetailModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'module_id') final  String moduleId;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override@JsonKey(name: 'status_id') final  String? statusId;
@override final  DynamicModuleStatus? status;
@override@JsonKey(name: 'created_by') final  String createdBy;
@override@JsonKey(name: 'creator_name') final  String? creatorName;
@override@JsonKey(name: 'assigned_to') final  String? assignedTo;
@override@JsonKey(name: 'assignee_name') final  String? assigneeName;
@override@JsonKey(name: 'client_id') final  String? clientId;
@override@JsonKey(name: 'client_name') final  String? clientName;
@override@JsonKey(name: 'due_at') final  DateTime? dueAt;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
 final  List<DynamicModuleTransition> _allowedTransitions;
@override@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> get allowedTransitions {
  if (_allowedTransitions is EqualUnmodifiableListView) return _allowedTransitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedTransitions);
}

 final  List<DynamicRecordComment> _comments;
@override@JsonKey() List<DynamicRecordComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  List<DynamicRecordAttachment> _attachments;
@override@JsonKey() List<DynamicRecordAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

 final  List<DynamicRecordActivity> _activities;
@override@JsonKey() List<DynamicRecordActivity> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}


/// Create a copy of DynamicRecordDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordDetailModelCopyWith<_DynamicRecordDetailModel> get copyWith => __$DynamicRecordDetailModelCopyWithImpl<_DynamicRecordDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicRecordDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.assigneeName, assigneeName) || other.assigneeName == assigneeName)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._allowedTransitions, _allowedTransitions)&&const DeepCollectionEquality().equals(other._comments, _comments)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&const DeepCollectionEquality().equals(other._activities, _activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moduleId,const DeepCollectionEquality().hash(_data),statusId,status,createdBy,creatorName,assignedTo,assigneeName,clientId,clientName,dueAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_allowedTransitions),const DeepCollectionEquality().hash(_comments),const DeepCollectionEquality().hash(_attachments),const DeepCollectionEquality().hash(_activities));

@override
String toString() {
  return 'DynamicRecordDetailModel(id: $id, moduleId: $moduleId, data: $data, statusId: $statusId, status: $status, createdBy: $createdBy, creatorName: $creatorName, assignedTo: $assignedTo, assigneeName: $assigneeName, clientId: $clientId, clientName: $clientName, dueAt: $dueAt, createdAt: $createdAt, updatedAt: $updatedAt, allowedTransitions: $allowedTransitions, comments: $comments, attachments: $attachments, activities: $activities)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordDetailModelCopyWith<$Res> implements $DynamicRecordDetailModelCopyWith<$Res> {
  factory _$DynamicRecordDetailModelCopyWith(_DynamicRecordDetailModel value, $Res Function(_DynamicRecordDetailModel) _then) = __$DynamicRecordDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'module_id') String moduleId, Map<String, dynamic> data,@JsonKey(name: 'status_id') String? statusId, DynamicModuleStatus? status,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'creator_name') String? creatorName,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'assignee_name') String? assigneeName,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'due_at') DateTime? dueAt,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'allowed_transitions') List<DynamicModuleTransition> allowedTransitions, List<DynamicRecordComment> comments, List<DynamicRecordAttachment> attachments, List<DynamicRecordActivity> activities
});


@override $DynamicModuleStatusCopyWith<$Res>? get status;

}
/// @nodoc
class __$DynamicRecordDetailModelCopyWithImpl<$Res>
    implements _$DynamicRecordDetailModelCopyWith<$Res> {
  __$DynamicRecordDetailModelCopyWithImpl(this._self, this._then);

  final _DynamicRecordDetailModel _self;
  final $Res Function(_DynamicRecordDetailModel) _then;

/// Create a copy of DynamicRecordDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moduleId = null,Object? data = null,Object? statusId = freezed,Object? status = freezed,Object? createdBy = null,Object? creatorName = freezed,Object? assignedTo = freezed,Object? assigneeName = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? dueAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? allowedTransitions = null,Object? comments = null,Object? attachments = null,Object? activities = null,}) {
  return _then(_DynamicRecordDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DynamicModuleStatus?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,creatorName: freezed == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,assigneeName: freezed == assigneeName ? _self.assigneeName : assigneeName // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,allowedTransitions: null == allowedTransitions ? _self._allowedTransitions : allowedTransitions // ignore: cast_nullable_to_non_nullable
as List<DynamicModuleTransition>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordComment>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordAttachment>,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordActivity>,
  ));
}

/// Create a copy of DynamicRecordDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicModuleStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $DynamicModuleStatusCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
mixin _$DynamicRecordPageResponse {

 List<DynamicRecordModel> get items; int get total; int get page;@JsonKey(name: 'page_size') int get pageSize;@JsonKey(name: 'total_pages') int get totalPages;
/// Create a copy of DynamicRecordPageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordPageResponseCopyWith<DynamicRecordPageResponse> get copyWith => _$DynamicRecordPageResponseCopyWithImpl<DynamicRecordPageResponse>(this as DynamicRecordPageResponse, _$identity);

  /// Serializes this DynamicRecordPageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordPageResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,pageSize,totalPages);

@override
String toString() {
  return 'DynamicRecordPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordPageResponseCopyWith<$Res>  {
  factory $DynamicRecordPageResponseCopyWith(DynamicRecordPageResponse value, $Res Function(DynamicRecordPageResponse) _then) = _$DynamicRecordPageResponseCopyWithImpl;
@useResult
$Res call({
 List<DynamicRecordModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class _$DynamicRecordPageResponseCopyWithImpl<$Res>
    implements $DynamicRecordPageResponseCopyWith<$Res> {
  _$DynamicRecordPageResponseCopyWithImpl(this._self, this._then);

  final DynamicRecordPageResponse _self;
  final $Res Function(DynamicRecordPageResponse) _then;

/// Create a copy of DynamicRecordPageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,}) {
  return _then(DynamicRecordPageResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicRecordPageResponse].
extension DynamicRecordPageResponsePatterns on DynamicRecordPageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordPageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordPageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordPageResponse value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordPageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordPageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordPageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DynamicRecordModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DynamicRecordModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordPageResponse():
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DynamicRecordModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicRecordPageResponse implements DynamicRecordPageResponse {
  const _DynamicRecordPageResponse({ List<DynamicRecordModel> items = const <DynamicRecordModel>[], this.total = 0, this.page = 1, @JsonKey(name: 'page_size') this.pageSize = 20, @JsonKey(name: 'total_pages') this.totalPages = 1}): _items = items;
  factory _DynamicRecordPageResponse.fromJson(Map<String, dynamic> json) => _$DynamicRecordPageResponseFromJson(json);

 final  List<DynamicRecordModel> _items;
@override@JsonKey() List<DynamicRecordModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int page;
@override@JsonKey(name: 'page_size') final  int pageSize;
@override@JsonKey(name: 'total_pages') final  int totalPages;

/// Create a copy of DynamicRecordPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordPageResponseCopyWith<_DynamicRecordPageResponse> get copyWith => __$DynamicRecordPageResponseCopyWithImpl<_DynamicRecordPageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicRecordPageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordPageResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,pageSize,totalPages);

@override
String toString() {
  return 'DynamicRecordPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordPageResponseCopyWith<$Res> implements $DynamicRecordPageResponseCopyWith<$Res> {
  factory _$DynamicRecordPageResponseCopyWith(_DynamicRecordPageResponse value, $Res Function(_DynamicRecordPageResponse) _then) = __$DynamicRecordPageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<DynamicRecordModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class __$DynamicRecordPageResponseCopyWithImpl<$Res>
    implements _$DynamicRecordPageResponseCopyWith<$Res> {
  __$DynamicRecordPageResponseCopyWithImpl(this._self, this._then);

  final _DynamicRecordPageResponse _self;
  final $Res Function(_DynamicRecordPageResponse) _then;

/// Create a copy of DynamicRecordPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,}) {
  return _then(_DynamicRecordPageResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DynamicModuleSummary {

@JsonKey(name: 'total_records') int get totalRecords;@JsonKey(name: 'counts_by_status') Map<String, int> get countsByStatus;@JsonKey(name: 'field_totals') Map<String, double> get fieldTotals;
/// Create a copy of DynamicModuleSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicModuleSummaryCopyWith<DynamicModuleSummary> get copyWith => _$DynamicModuleSummaryCopyWithImpl<DynamicModuleSummary>(this as DynamicModuleSummary, _$identity);

  /// Serializes this DynamicModuleSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicModuleSummary&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords)&&const DeepCollectionEquality().equals(other.countsByStatus, countsByStatus)&&const DeepCollectionEquality().equals(other.fieldTotals, fieldTotals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRecords,const DeepCollectionEquality().hash(countsByStatus),const DeepCollectionEquality().hash(fieldTotals));

@override
String toString() {
  return 'DynamicModuleSummary(totalRecords: $totalRecords, countsByStatus: $countsByStatus, fieldTotals: $fieldTotals)';
}


}

/// @nodoc
abstract mixin class $DynamicModuleSummaryCopyWith<$Res>  {
  factory $DynamicModuleSummaryCopyWith(DynamicModuleSummary value, $Res Function(DynamicModuleSummary) _then) = _$DynamicModuleSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_records') int totalRecords,@JsonKey(name: 'counts_by_status') Map<String, int> countsByStatus,@JsonKey(name: 'field_totals') Map<String, double> fieldTotals
});




}
/// @nodoc
class _$DynamicModuleSummaryCopyWithImpl<$Res>
    implements $DynamicModuleSummaryCopyWith<$Res> {
  _$DynamicModuleSummaryCopyWithImpl(this._self, this._then);

  final DynamicModuleSummary _self;
  final $Res Function(DynamicModuleSummary) _then;

/// Create a copy of DynamicModuleSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRecords = null,Object? countsByStatus = null,Object? fieldTotals = null,}) {
  return _then(DynamicModuleSummary(
totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,countsByStatus: null == countsByStatus ? _self.countsByStatus : countsByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,fieldTotals: null == fieldTotals ? _self.fieldTotals : fieldTotals // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicModuleSummary].
extension DynamicModuleSummaryPatterns on DynamicModuleSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicModuleSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicModuleSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicModuleSummary value)  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicModuleSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicModuleSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_records')  int totalRecords, @JsonKey(name: 'counts_by_status')  Map<String, int> countsByStatus, @JsonKey(name: 'field_totals')  Map<String, double> fieldTotals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicModuleSummary() when $default != null:
return $default(_that.totalRecords,_that.countsByStatus,_that.fieldTotals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_records')  int totalRecords, @JsonKey(name: 'counts_by_status')  Map<String, int> countsByStatus, @JsonKey(name: 'field_totals')  Map<String, double> fieldTotals)  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleSummary():
return $default(_that.totalRecords,_that.countsByStatus,_that.fieldTotals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_records')  int totalRecords, @JsonKey(name: 'counts_by_status')  Map<String, int> countsByStatus, @JsonKey(name: 'field_totals')  Map<String, double> fieldTotals)?  $default,) {final _that = this;
switch (_that) {
case _DynamicModuleSummary() when $default != null:
return $default(_that.totalRecords,_that.countsByStatus,_that.fieldTotals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicModuleSummary implements DynamicModuleSummary {
  const _DynamicModuleSummary({@JsonKey(name: 'total_records') this.totalRecords = 0, @JsonKey(name: 'counts_by_status')  Map<String, int> countsByStatus = const <String, int>{}, @JsonKey(name: 'field_totals')  Map<String, double> fieldTotals = const <String, double>{}}): _countsByStatus = countsByStatus,_fieldTotals = fieldTotals;
  factory _DynamicModuleSummary.fromJson(Map<String, dynamic> json) => _$DynamicModuleSummaryFromJson(json);

@override@JsonKey(name: 'total_records') final  int totalRecords;
 final  Map<String, int> _countsByStatus;
@override@JsonKey(name: 'counts_by_status') Map<String, int> get countsByStatus {
  if (_countsByStatus is EqualUnmodifiableMapView) return _countsByStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_countsByStatus);
}

 final  Map<String, double> _fieldTotals;
@override@JsonKey(name: 'field_totals') Map<String, double> get fieldTotals {
  if (_fieldTotals is EqualUnmodifiableMapView) return _fieldTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fieldTotals);
}


/// Create a copy of DynamicModuleSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicModuleSummaryCopyWith<_DynamicModuleSummary> get copyWith => __$DynamicModuleSummaryCopyWithImpl<_DynamicModuleSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicModuleSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicModuleSummary&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords)&&const DeepCollectionEquality().equals(other._countsByStatus, _countsByStatus)&&const DeepCollectionEquality().equals(other._fieldTotals, _fieldTotals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRecords,const DeepCollectionEquality().hash(_countsByStatus),const DeepCollectionEquality().hash(_fieldTotals));

@override
String toString() {
  return 'DynamicModuleSummary(totalRecords: $totalRecords, countsByStatus: $countsByStatus, fieldTotals: $fieldTotals)';
}


}

/// @nodoc
abstract mixin class _$DynamicModuleSummaryCopyWith<$Res> implements $DynamicModuleSummaryCopyWith<$Res> {
  factory _$DynamicModuleSummaryCopyWith(_DynamicModuleSummary value, $Res Function(_DynamicModuleSummary) _then) = __$DynamicModuleSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_records') int totalRecords,@JsonKey(name: 'counts_by_status') Map<String, int> countsByStatus,@JsonKey(name: 'field_totals') Map<String, double> fieldTotals
});




}
/// @nodoc
class __$DynamicModuleSummaryCopyWithImpl<$Res>
    implements _$DynamicModuleSummaryCopyWith<$Res> {
  __$DynamicModuleSummaryCopyWithImpl(this._self, this._then);

  final _DynamicModuleSummary _self;
  final $Res Function(_DynamicModuleSummary) _then;

/// Create a copy of DynamicModuleSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRecords = null,Object? countsByStatus = null,Object? fieldTotals = null,}) {
  return _then(_DynamicModuleSummary(
totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,countsByStatus: null == countsByStatus ? _self._countsByStatus : countsByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,fieldTotals: null == fieldTotals ? _self._fieldTotals : fieldTotals // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
