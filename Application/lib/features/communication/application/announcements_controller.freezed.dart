// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcements_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnnouncementsListState {

 List<AnnouncementModel> get items; bool get isLoading; AppFailure? get error;
/// Create a copy of AnnouncementsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementsListStateCopyWith<AnnouncementsListState> get copyWith => _$AnnouncementsListStateCopyWithImpl<AnnouncementsListState>(this as AnnouncementsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementsListState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),isLoading,error);

@override
String toString() {
  return 'AnnouncementsListState(items: $items, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $AnnouncementsListStateCopyWith<$Res>  {
  factory $AnnouncementsListStateCopyWith(AnnouncementsListState value, $Res Function(AnnouncementsListState) _then) = _$AnnouncementsListStateCopyWithImpl;
@useResult
$Res call({
 List<AnnouncementModel> items, bool isLoading, AppFailure? error
});


$AppFailureCopyWith<$Res>? get error;

}
/// @nodoc
class _$AnnouncementsListStateCopyWithImpl<$Res>
    implements $AnnouncementsListStateCopyWith<$Res> {
  _$AnnouncementsListStateCopyWithImpl(this._self, this._then);

  final AnnouncementsListState _self;
  final $Res Function(AnnouncementsListState) _then;

/// Create a copy of AnnouncementsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(AnnouncementsListState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AnnouncementModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of AnnouncementsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnnouncementsListState].
extension AnnouncementsListStatePatterns on AnnouncementsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementsListState value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementsListState value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AnnouncementModel> items,  bool isLoading,  AppFailure? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementsListState() when $default != null:
return $default(_that.items,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AnnouncementModel> items,  bool isLoading,  AppFailure? error)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementsListState():
return $default(_that.items,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AnnouncementModel> items,  bool isLoading,  AppFailure? error)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementsListState() when $default != null:
return $default(_that.items,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _AnnouncementsListState implements AnnouncementsListState {
  const _AnnouncementsListState({ List<AnnouncementModel> items = const <AnnouncementModel>[], this.isLoading = false, this.error}): _items = items;
  

 final  List<AnnouncementModel> _items;
@override@JsonKey() List<AnnouncementModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool isLoading;
@override final  AppFailure? error;

/// Create a copy of AnnouncementsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementsListStateCopyWith<_AnnouncementsListState> get copyWith => __$AnnouncementsListStateCopyWithImpl<_AnnouncementsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementsListState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),isLoading,error);

@override
String toString() {
  return 'AnnouncementsListState(items: $items, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementsListStateCopyWith<$Res> implements $AnnouncementsListStateCopyWith<$Res> {
  factory _$AnnouncementsListStateCopyWith(_AnnouncementsListState value, $Res Function(_AnnouncementsListState) _then) = __$AnnouncementsListStateCopyWithImpl;
@override @useResult
$Res call({
 List<AnnouncementModel> items, bool isLoading, AppFailure? error
});


@override $AppFailureCopyWith<$Res>? get error;

}
/// @nodoc
class __$AnnouncementsListStateCopyWithImpl<$Res>
    implements _$AnnouncementsListStateCopyWith<$Res> {
  __$AnnouncementsListStateCopyWithImpl(this._self, this._then);

  final _AnnouncementsListState _self;
  final $Res Function(_AnnouncementsListState) _then;

/// Create a copy of AnnouncementsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_AnnouncementsListState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AnnouncementModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of AnnouncementsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
