// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveRequestsState {

 List<LeaveRequestModel> get items; int get total; int get page; bool get hasMore; String get statusFilter; bool get isLoadingMore; String? get errorMessage;
/// Create a copy of LeaveRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveRequestsStateCopyWith<LeaveRequestsState> get copyWith => _$LeaveRequestsStateCopyWithImpl<LeaveRequestsState>(this as LeaveRequestsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveRequestsState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,hasMore,statusFilter,isLoadingMore,errorMessage);

@override
String toString() {
  return 'LeaveRequestsState(items: $items, total: $total, page: $page, hasMore: $hasMore, statusFilter: $statusFilter, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LeaveRequestsStateCopyWith<$Res>  {
  factory $LeaveRequestsStateCopyWith(LeaveRequestsState value, $Res Function(LeaveRequestsState) _then) = _$LeaveRequestsStateCopyWithImpl;
@useResult
$Res call({
 List<LeaveRequestModel> items, int total, int page, bool hasMore, String statusFilter, bool isLoadingMore, String? errorMessage
});




}
/// @nodoc
class _$LeaveRequestsStateCopyWithImpl<$Res>
    implements $LeaveRequestsStateCopyWith<$Res> {
  _$LeaveRequestsStateCopyWithImpl(this._self, this._then);

  final LeaveRequestsState _self;
  final $Res Function(LeaveRequestsState) _then;

/// Create a copy of LeaveRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? hasMore = null,Object? statusFilter = null,Object? isLoadingMore = null,Object? errorMessage = freezed,}) {
  return _then(LeaveRequestsState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LeaveRequestModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveRequestsState].
extension LeaveRequestsStatePatterns on LeaveRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveRequestsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveRequestsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveRequestsState value)  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveRequestsState value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaveRequestModel> items,  int total,  int page,  bool hasMore,  String statusFilter,  bool isLoadingMore,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveRequestsState() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.hasMore,_that.statusFilter,_that.isLoadingMore,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaveRequestModel> items,  int total,  int page,  bool hasMore,  String statusFilter,  bool isLoadingMore,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestsState():
return $default(_that.items,_that.total,_that.page,_that.hasMore,_that.statusFilter,_that.isLoadingMore,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaveRequestModel> items,  int total,  int page,  bool hasMore,  String statusFilter,  bool isLoadingMore,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestsState() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.hasMore,_that.statusFilter,_that.isLoadingMore,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveRequestsState implements LeaveRequestsState {
  const _LeaveRequestsState({ List<LeaveRequestModel> items = const [], this.total = 0, this.page = 1, this.hasMore = false, this.statusFilter = 'all', this.isLoadingMore = false, this.errorMessage}): _items = items;
  

 final  List<LeaveRequestModel> _items;
@override@JsonKey() List<LeaveRequestModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  String statusFilter;
@override@JsonKey() final  bool isLoadingMore;
@override final  String? errorMessage;

/// Create a copy of LeaveRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveRequestsStateCopyWith<_LeaveRequestsState> get copyWith => __$LeaveRequestsStateCopyWithImpl<_LeaveRequestsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveRequestsState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,hasMore,statusFilter,isLoadingMore,errorMessage);

@override
String toString() {
  return 'LeaveRequestsState(items: $items, total: $total, page: $page, hasMore: $hasMore, statusFilter: $statusFilter, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LeaveRequestsStateCopyWith<$Res> implements $LeaveRequestsStateCopyWith<$Res> {
  factory _$LeaveRequestsStateCopyWith(_LeaveRequestsState value, $Res Function(_LeaveRequestsState) _then) = __$LeaveRequestsStateCopyWithImpl;
@override @useResult
$Res call({
 List<LeaveRequestModel> items, int total, int page, bool hasMore, String statusFilter, bool isLoadingMore, String? errorMessage
});




}
/// @nodoc
class __$LeaveRequestsStateCopyWithImpl<$Res>
    implements _$LeaveRequestsStateCopyWith<$Res> {
  __$LeaveRequestsStateCopyWithImpl(this._self, this._then);

  final _LeaveRequestsState _self;
  final $Res Function(_LeaveRequestsState) _then;

/// Create a copy of LeaveRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? hasMore = null,Object? statusFilter = null,Object? isLoadingMore = null,Object? errorMessage = freezed,}) {
  return _then(_LeaveRequestsState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LeaveRequestModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LeaveApplyState {

 String? get leaveTypeId; DateTime? get fromDate; DateTime? get toDate; bool get isHalfDay; String get halfDaySession; String get reason; LeavePreviewResponse? get preview; bool get isPreviewLoading; bool get isSubmitting; String? get submissionError; Map<String, String> get fieldErrors;
/// Create a copy of LeaveApplyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveApplyStateCopyWith<LeaveApplyState> get copyWith => _$LeaveApplyStateCopyWithImpl<LeaveApplyState>(this as LeaveApplyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveApplyState&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.isPreviewLoading, isPreviewLoading) || other.isPreviewLoading == isPreviewLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.submissionError, submissionError) || other.submissionError == submissionError)&&const DeepCollectionEquality().equals(other.fieldErrors, fieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,leaveTypeId,fromDate,toDate,isHalfDay,halfDaySession,reason,preview,isPreviewLoading,isSubmitting,submissionError,const DeepCollectionEquality().hash(fieldErrors));

@override
String toString() {
  return 'LeaveApplyState(leaveTypeId: $leaveTypeId, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession, reason: $reason, preview: $preview, isPreviewLoading: $isPreviewLoading, isSubmitting: $isSubmitting, submissionError: $submissionError, fieldErrors: $fieldErrors)';
}


}

/// @nodoc
abstract mixin class $LeaveApplyStateCopyWith<$Res>  {
  factory $LeaveApplyStateCopyWith(LeaveApplyState value, $Res Function(LeaveApplyState) _then) = _$LeaveApplyStateCopyWithImpl;
@useResult
$Res call({
 String? leaveTypeId, DateTime? fromDate, DateTime? toDate, bool isHalfDay, String halfDaySession, String reason, LeavePreviewResponse? preview, bool isPreviewLoading, bool isSubmitting, String? submissionError, Map<String, String> fieldErrors
});


$LeavePreviewResponseCopyWith<$Res>? get preview;

}
/// @nodoc
class _$LeaveApplyStateCopyWithImpl<$Res>
    implements $LeaveApplyStateCopyWith<$Res> {
  _$LeaveApplyStateCopyWithImpl(this._self, this._then);

  final LeaveApplyState _self;
  final $Res Function(LeaveApplyState) _then;

/// Create a copy of LeaveApplyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveTypeId = freezed,Object? fromDate = freezed,Object? toDate = freezed,Object? isHalfDay = null,Object? halfDaySession = null,Object? reason = null,Object? preview = freezed,Object? isPreviewLoading = null,Object? isSubmitting = null,Object? submissionError = freezed,Object? fieldErrors = null,}) {
  return _then(LeaveApplyState(
leaveTypeId: freezed == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String?,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: null == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as LeavePreviewResponse?,isPreviewLoading: null == isPreviewLoading ? _self.isPreviewLoading : isPreviewLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,submissionError: freezed == submissionError ? _self.submissionError : submissionError // ignore: cast_nullable_to_non_nullable
as String?,fieldErrors: null == fieldErrors ? _self.fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of LeaveApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePreviewResponseCopyWith<$Res>? get preview {
    if (_self.preview == null) {
    return null;
  }

  return $LeavePreviewResponseCopyWith<$Res>(_self.preview!, (value) {
    return _then(_self.copyWith(preview: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaveApplyState].
extension LeaveApplyStatePatterns on LeaveApplyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveApplyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveApplyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveApplyState value)  $default,){
final _that = this;
switch (_that) {
case _LeaveApplyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveApplyState value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveApplyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? leaveTypeId,  DateTime? fromDate,  DateTime? toDate,  bool isHalfDay,  String halfDaySession,  String reason,  LeavePreviewResponse? preview,  bool isPreviewLoading,  bool isSubmitting,  String? submissionError,  Map<String, String> fieldErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveApplyState() when $default != null:
return $default(_that.leaveTypeId,_that.fromDate,_that.toDate,_that.isHalfDay,_that.halfDaySession,_that.reason,_that.preview,_that.isPreviewLoading,_that.isSubmitting,_that.submissionError,_that.fieldErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? leaveTypeId,  DateTime? fromDate,  DateTime? toDate,  bool isHalfDay,  String halfDaySession,  String reason,  LeavePreviewResponse? preview,  bool isPreviewLoading,  bool isSubmitting,  String? submissionError,  Map<String, String> fieldErrors)  $default,) {final _that = this;
switch (_that) {
case _LeaveApplyState():
return $default(_that.leaveTypeId,_that.fromDate,_that.toDate,_that.isHalfDay,_that.halfDaySession,_that.reason,_that.preview,_that.isPreviewLoading,_that.isSubmitting,_that.submissionError,_that.fieldErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? leaveTypeId,  DateTime? fromDate,  DateTime? toDate,  bool isHalfDay,  String halfDaySession,  String reason,  LeavePreviewResponse? preview,  bool isPreviewLoading,  bool isSubmitting,  String? submissionError,  Map<String, String> fieldErrors)?  $default,) {final _that = this;
switch (_that) {
case _LeaveApplyState() when $default != null:
return $default(_that.leaveTypeId,_that.fromDate,_that.toDate,_that.isHalfDay,_that.halfDaySession,_that.reason,_that.preview,_that.isPreviewLoading,_that.isSubmitting,_that.submissionError,_that.fieldErrors);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveApplyState implements LeaveApplyState {
  const _LeaveApplyState({this.leaveTypeId, this.fromDate, this.toDate, this.isHalfDay = false, this.halfDaySession = 'first_half', this.reason = '', this.preview, this.isPreviewLoading = false, this.isSubmitting = false, this.submissionError,  Map<String, String> fieldErrors = const {}}): _fieldErrors = fieldErrors;
  

@override final  String? leaveTypeId;
@override final  DateTime? fromDate;
@override final  DateTime? toDate;
@override@JsonKey() final  bool isHalfDay;
@override@JsonKey() final  String halfDaySession;
@override@JsonKey() final  String reason;
@override final  LeavePreviewResponse? preview;
@override@JsonKey() final  bool isPreviewLoading;
@override@JsonKey() final  bool isSubmitting;
@override final  String? submissionError;
 final  Map<String, String> _fieldErrors;
@override@JsonKey() Map<String, String> get fieldErrors {
  if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fieldErrors);
}


/// Create a copy of LeaveApplyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveApplyStateCopyWith<_LeaveApplyState> get copyWith => __$LeaveApplyStateCopyWithImpl<_LeaveApplyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveApplyState&&(identical(other.leaveTypeId, leaveTypeId) || other.leaveTypeId == leaveTypeId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.isHalfDay, isHalfDay) || other.isHalfDay == isHalfDay)&&(identical(other.halfDaySession, halfDaySession) || other.halfDaySession == halfDaySession)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.isPreviewLoading, isPreviewLoading) || other.isPreviewLoading == isPreviewLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.submissionError, submissionError) || other.submissionError == submissionError)&&const DeepCollectionEquality().equals(other._fieldErrors, _fieldErrors));
}


@override
int get hashCode => Object.hash(runtimeType,leaveTypeId,fromDate,toDate,isHalfDay,halfDaySession,reason,preview,isPreviewLoading,isSubmitting,submissionError,const DeepCollectionEquality().hash(_fieldErrors));

@override
String toString() {
  return 'LeaveApplyState(leaveTypeId: $leaveTypeId, fromDate: $fromDate, toDate: $toDate, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession, reason: $reason, preview: $preview, isPreviewLoading: $isPreviewLoading, isSubmitting: $isSubmitting, submissionError: $submissionError, fieldErrors: $fieldErrors)';
}


}

/// @nodoc
abstract mixin class _$LeaveApplyStateCopyWith<$Res> implements $LeaveApplyStateCopyWith<$Res> {
  factory _$LeaveApplyStateCopyWith(_LeaveApplyState value, $Res Function(_LeaveApplyState) _then) = __$LeaveApplyStateCopyWithImpl;
@override @useResult
$Res call({
 String? leaveTypeId, DateTime? fromDate, DateTime? toDate, bool isHalfDay, String halfDaySession, String reason, LeavePreviewResponse? preview, bool isPreviewLoading, bool isSubmitting, String? submissionError, Map<String, String> fieldErrors
});


@override $LeavePreviewResponseCopyWith<$Res>? get preview;

}
/// @nodoc
class __$LeaveApplyStateCopyWithImpl<$Res>
    implements _$LeaveApplyStateCopyWith<$Res> {
  __$LeaveApplyStateCopyWithImpl(this._self, this._then);

  final _LeaveApplyState _self;
  final $Res Function(_LeaveApplyState) _then;

/// Create a copy of LeaveApplyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveTypeId = freezed,Object? fromDate = freezed,Object? toDate = freezed,Object? isHalfDay = null,Object? halfDaySession = null,Object? reason = null,Object? preview = freezed,Object? isPreviewLoading = null,Object? isSubmitting = null,Object? submissionError = freezed,Object? fieldErrors = null,}) {
  return _then(_LeaveApplyState(
leaveTypeId: freezed == leaveTypeId ? _self.leaveTypeId : leaveTypeId // ignore: cast_nullable_to_non_nullable
as String?,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isHalfDay: null == isHalfDay ? _self.isHalfDay : isHalfDay // ignore: cast_nullable_to_non_nullable
as bool,halfDaySession: null == halfDaySession ? _self.halfDaySession : halfDaySession // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as LeavePreviewResponse?,isPreviewLoading: null == isPreviewLoading ? _self.isPreviewLoading : isPreviewLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,submissionError: freezed == submissionError ? _self.submissionError : submissionError // ignore: cast_nullable_to_non_nullable
as String?,fieldErrors: null == fieldErrors ? _self._fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of LeaveApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePreviewResponseCopyWith<$Res>? get preview {
    if (_self.preview == null) {
    return null;
  }

  return $LeavePreviewResponseCopyWith<$Res>(_self.preview!, (value) {
    return _then(_self.copyWith(preview: value));
  });
}
}

// dart format on
