// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsListState {

 List<NotificationItemModel> get items; int get page; bool get hasMore; bool get isLoading; bool get isLoadingMore; bool get unreadOnly; AppFailure? get error;
/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsListStateCopyWith<NotificationsListState> get copyWith => _$NotificationsListStateCopyWithImpl<NotificationsListState>(this as NotificationsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsListState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.unreadOnly, unreadOnly) || other.unreadOnly == unreadOnly)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,hasMore,isLoading,isLoadingMore,unreadOnly,error);

@override
String toString() {
  return 'NotificationsListState(items: $items, page: $page, hasMore: $hasMore, isLoading: $isLoading, isLoadingMore: $isLoadingMore, unreadOnly: $unreadOnly, error: $error)';
}


}

/// @nodoc
abstract mixin class $NotificationsListStateCopyWith<$Res>  {
  factory $NotificationsListStateCopyWith(NotificationsListState value, $Res Function(NotificationsListState) _then) = _$NotificationsListStateCopyWithImpl;
@useResult
$Res call({
 List<NotificationItemModel> items, int page, bool hasMore, bool isLoading, bool isLoadingMore, bool unreadOnly, AppFailure? error
});


$AppFailureCopyWith<$Res>? get error;

}
/// @nodoc
class _$NotificationsListStateCopyWithImpl<$Res>
    implements $NotificationsListStateCopyWith<$Res> {
  _$NotificationsListStateCopyWithImpl(this._self, this._then);

  final NotificationsListState _self;
  final $Res Function(NotificationsListState) _then;

/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoading = null,Object? isLoadingMore = null,Object? unreadOnly = null,Object? error = freezed,}) {
  return _then(NotificationsListState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationItemModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,unreadOnly: null == unreadOnly ? _self.unreadOnly : unreadOnly // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of NotificationsListState
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


/// Adds pattern-matching-related methods to [NotificationsListState].
extension NotificationsListStatePatterns on NotificationsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsListState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsListState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationItemModel> items,  int page,  bool hasMore,  bool isLoading,  bool isLoadingMore,  bool unreadOnly,  AppFailure? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsListState() when $default != null:
return $default(_that.items,_that.page,_that.hasMore,_that.isLoading,_that.isLoadingMore,_that.unreadOnly,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationItemModel> items,  int page,  bool hasMore,  bool isLoading,  bool isLoadingMore,  bool unreadOnly,  AppFailure? error)  $default,) {final _that = this;
switch (_that) {
case _NotificationsListState():
return $default(_that.items,_that.page,_that.hasMore,_that.isLoading,_that.isLoadingMore,_that.unreadOnly,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationItemModel> items,  int page,  bool hasMore,  bool isLoading,  bool isLoadingMore,  bool unreadOnly,  AppFailure? error)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsListState() when $default != null:
return $default(_that.items,_that.page,_that.hasMore,_that.isLoading,_that.isLoadingMore,_that.unreadOnly,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationsListState implements NotificationsListState {
  const _NotificationsListState({ List<NotificationItemModel> items = const <NotificationItemModel>[], this.page = 1, this.hasMore = true, this.isLoading = false, this.isLoadingMore = false, this.unreadOnly = false, this.error}): _items = items;
  

 final  List<NotificationItemModel> _items;
@override@JsonKey() List<NotificationItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool unreadOnly;
@override final  AppFailure? error;

/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsListStateCopyWith<_NotificationsListState> get copyWith => __$NotificationsListStateCopyWithImpl<_NotificationsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsListState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.unreadOnly, unreadOnly) || other.unreadOnly == unreadOnly)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,hasMore,isLoading,isLoadingMore,unreadOnly,error);

@override
String toString() {
  return 'NotificationsListState(items: $items, page: $page, hasMore: $hasMore, isLoading: $isLoading, isLoadingMore: $isLoadingMore, unreadOnly: $unreadOnly, error: $error)';
}


}

/// @nodoc
abstract mixin class _$NotificationsListStateCopyWith<$Res> implements $NotificationsListStateCopyWith<$Res> {
  factory _$NotificationsListStateCopyWith(_NotificationsListState value, $Res Function(_NotificationsListState) _then) = __$NotificationsListStateCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationItemModel> items, int page, bool hasMore, bool isLoading, bool isLoadingMore, bool unreadOnly, AppFailure? error
});


@override $AppFailureCopyWith<$Res>? get error;

}
/// @nodoc
class __$NotificationsListStateCopyWithImpl<$Res>
    implements _$NotificationsListStateCopyWith<$Res> {
  __$NotificationsListStateCopyWithImpl(this._self, this._then);

  final _NotificationsListState _self;
  final $Res Function(_NotificationsListState) _then;

/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoading = null,Object? isLoadingMore = null,Object? unreadOnly = null,Object? error = freezed,}) {
  return _then(_NotificationsListState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationItemModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,unreadOnly: null == unreadOnly ? _self.unreadOnly : unreadOnly // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of NotificationsListState
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
