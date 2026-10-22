// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'master_data_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MasterDataState {

 List<MasterDataItem> get items; bool get isLoading; bool get isActionLoading; String? get errorMessage;
/// Create a copy of MasterDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasterDataStateCopyWith<MasterDataState> get copyWith => _$MasterDataStateCopyWithImpl<MasterDataState>(this as MasterDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MasterDataState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'MasterDataState(items: $items, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $MasterDataStateCopyWith<$Res>  {
  factory $MasterDataStateCopyWith(MasterDataState value, $Res Function(MasterDataState) _then) = _$MasterDataStateCopyWithImpl;
@useResult
$Res call({
 List<MasterDataItem> items, bool isLoading, bool isActionLoading, String? errorMessage
});




}
/// @nodoc
class _$MasterDataStateCopyWithImpl<$Res>
    implements $MasterDataStateCopyWith<$Res> {
  _$MasterDataStateCopyWithImpl(this._self, this._then);

  final MasterDataState _self;
  final $Res Function(MasterDataState) _then;

/// Create a copy of MasterDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,}) {
  return _then(MasterDataState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MasterDataItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MasterDataState].
extension MasterDataStatePatterns on MasterDataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MasterDataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MasterDataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MasterDataState value)  $default,){
final _that = this;
switch (_that) {
case _MasterDataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MasterDataState value)?  $default,){
final _that = this;
switch (_that) {
case _MasterDataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MasterDataItem> items,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MasterDataState() when $default != null:
return $default(_that.items,_that.isLoading,_that.isActionLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MasterDataItem> items,  bool isLoading,  bool isActionLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _MasterDataState():
return $default(_that.items,_that.isLoading,_that.isActionLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MasterDataItem> items,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _MasterDataState() when $default != null:
return $default(_that.items,_that.isLoading,_that.isActionLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MasterDataState implements MasterDataState {
  const _MasterDataState({ List<MasterDataItem> items = const <MasterDataItem>[], this.isLoading = true, this.isActionLoading = false, this.errorMessage}): _items = items;
  

 final  List<MasterDataItem> _items;
@override@JsonKey() List<MasterDataItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String? errorMessage;

/// Create a copy of MasterDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MasterDataStateCopyWith<_MasterDataState> get copyWith => __$MasterDataStateCopyWithImpl<_MasterDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MasterDataState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'MasterDataState(items: $items, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$MasterDataStateCopyWith<$Res> implements $MasterDataStateCopyWith<$Res> {
  factory _$MasterDataStateCopyWith(_MasterDataState value, $Res Function(_MasterDataState) _then) = __$MasterDataStateCopyWithImpl;
@override @useResult
$Res call({
 List<MasterDataItem> items, bool isLoading, bool isActionLoading, String? errorMessage
});




}
/// @nodoc
class __$MasterDataStateCopyWithImpl<$Res>
    implements _$MasterDataStateCopyWith<$Res> {
  __$MasterDataStateCopyWithImpl(this._self, this._then);

  final _MasterDataState _self;
  final $Res Function(_MasterDataState) _then;

/// Create a copy of MasterDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,}) {
  return _then(_MasterDataState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MasterDataItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
