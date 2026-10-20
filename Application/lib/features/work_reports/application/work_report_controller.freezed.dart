// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_report_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkReportEditorState {

 DateTime get date;/// The server copy for [date]; `null` until the first save.
 WorkReportModel? get report; String get summary; List<WorkReportItemDraft> get items; bool get isSaving; bool get isSubmitting; bool get isDirty; WorkReportFormError? get formError; Map<String, WorkReportItemError> get itemErrors;/// Message returned by the server when a save/submit call fails.
 String? get serverError;
/// Create a copy of WorkReportEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportEditorStateCopyWith<WorkReportEditorState> get copyWith => _$WorkReportEditorStateCopyWithImpl<WorkReportEditorState>(this as WorkReportEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportEditorState&&(identical(other.date, date) || other.date == date)&&(identical(other.report, report) || other.report == report)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.formError, formError) || other.formError == formError)&&const DeepCollectionEquality().equals(other.itemErrors, itemErrors)&&(identical(other.serverError, serverError) || other.serverError == serverError));
}


@override
int get hashCode => Object.hash(runtimeType,date,report,summary,const DeepCollectionEquality().hash(items),isSaving,isSubmitting,isDirty,formError,const DeepCollectionEquality().hash(itemErrors),serverError);

@override
String toString() {
  return 'WorkReportEditorState(date: $date, report: $report, summary: $summary, items: $items, isSaving: $isSaving, isSubmitting: $isSubmitting, isDirty: $isDirty, formError: $formError, itemErrors: $itemErrors, serverError: $serverError)';
}


}

/// @nodoc
abstract mixin class $WorkReportEditorStateCopyWith<$Res>  {
  factory $WorkReportEditorStateCopyWith(WorkReportEditorState value, $Res Function(WorkReportEditorState) _then) = _$WorkReportEditorStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, WorkReportModel? report, String summary, List<WorkReportItemDraft> items, bool isSaving, bool isSubmitting, bool isDirty, WorkReportFormError? formError, Map<String, WorkReportItemError> itemErrors, String? serverError
});


$WorkReportModelCopyWith<$Res>? get report;

}
/// @nodoc
class _$WorkReportEditorStateCopyWithImpl<$Res>
    implements $WorkReportEditorStateCopyWith<$Res> {
  _$WorkReportEditorStateCopyWithImpl(this._self, this._then);

  final WorkReportEditorState _self;
  final $Res Function(WorkReportEditorState) _then;

/// Create a copy of WorkReportEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? report = freezed,Object? summary = null,Object? items = null,Object? isSaving = null,Object? isSubmitting = null,Object? isDirty = null,Object? formError = freezed,Object? itemErrors = null,Object? serverError = freezed,}) {
  return _then(WorkReportEditorState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as WorkReportModel?,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportItemDraft>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,formError: freezed == formError ? _self.formError : formError // ignore: cast_nullable_to_non_nullable
as WorkReportFormError?,itemErrors: null == itemErrors ? _self.itemErrors : itemErrors // ignore: cast_nullable_to_non_nullable
as Map<String, WorkReportItemError>,serverError: freezed == serverError ? _self.serverError : serverError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WorkReportEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkReportModelCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $WorkReportModelCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkReportEditorState].
extension WorkReportEditorStatePatterns on WorkReportEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportEditorState value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  WorkReportModel? report,  String summary,  List<WorkReportItemDraft> items,  bool isSaving,  bool isSubmitting,  bool isDirty,  WorkReportFormError? formError,  Map<String, WorkReportItemError> itemErrors,  String? serverError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportEditorState() when $default != null:
return $default(_that.date,_that.report,_that.summary,_that.items,_that.isSaving,_that.isSubmitting,_that.isDirty,_that.formError,_that.itemErrors,_that.serverError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  WorkReportModel? report,  String summary,  List<WorkReportItemDraft> items,  bool isSaving,  bool isSubmitting,  bool isDirty,  WorkReportFormError? formError,  Map<String, WorkReportItemError> itemErrors,  String? serverError)  $default,) {final _that = this;
switch (_that) {
case _WorkReportEditorState():
return $default(_that.date,_that.report,_that.summary,_that.items,_that.isSaving,_that.isSubmitting,_that.isDirty,_that.formError,_that.itemErrors,_that.serverError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  WorkReportModel? report,  String summary,  List<WorkReportItemDraft> items,  bool isSaving,  bool isSubmitting,  bool isDirty,  WorkReportFormError? formError,  Map<String, WorkReportItemError> itemErrors,  String? serverError)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportEditorState() when $default != null:
return $default(_that.date,_that.report,_that.summary,_that.items,_that.isSaving,_that.isSubmitting,_that.isDirty,_that.formError,_that.itemErrors,_that.serverError);case _:
  return null;

}
}

}

/// @nodoc


class _WorkReportEditorState extends WorkReportEditorState {
  const _WorkReportEditorState({required this.date, this.report, this.summary = '',  List<WorkReportItemDraft> items = const <WorkReportItemDraft>[], this.isSaving = false, this.isSubmitting = false, this.isDirty = false, this.formError,  Map<String, WorkReportItemError> itemErrors = const <String, WorkReportItemError>{}, this.serverError}): _items = items,_itemErrors = itemErrors,super._();
  

@override final  DateTime date;
/// The server copy for [date]; `null` until the first save.
@override final  WorkReportModel? report;
@override@JsonKey() final  String summary;
 final  List<WorkReportItemDraft> _items;
@override@JsonKey() List<WorkReportItemDraft> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isDirty;
@override final  WorkReportFormError? formError;
 final  Map<String, WorkReportItemError> _itemErrors;
@override@JsonKey() Map<String, WorkReportItemError> get itemErrors {
  if (_itemErrors is EqualUnmodifiableMapView) return _itemErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_itemErrors);
}

/// Message returned by the server when a save/submit call fails.
@override final  String? serverError;

/// Create a copy of WorkReportEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportEditorStateCopyWith<_WorkReportEditorState> get copyWith => __$WorkReportEditorStateCopyWithImpl<_WorkReportEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportEditorState&&(identical(other.date, date) || other.date == date)&&(identical(other.report, report) || other.report == report)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.formError, formError) || other.formError == formError)&&const DeepCollectionEquality().equals(other._itemErrors, _itemErrors)&&(identical(other.serverError, serverError) || other.serverError == serverError));
}


@override
int get hashCode => Object.hash(runtimeType,date,report,summary,const DeepCollectionEquality().hash(_items),isSaving,isSubmitting,isDirty,formError,const DeepCollectionEquality().hash(_itemErrors),serverError);

@override
String toString() {
  return 'WorkReportEditorState(date: $date, report: $report, summary: $summary, items: $items, isSaving: $isSaving, isSubmitting: $isSubmitting, isDirty: $isDirty, formError: $formError, itemErrors: $itemErrors, serverError: $serverError)';
}


}

/// @nodoc
abstract mixin class _$WorkReportEditorStateCopyWith<$Res> implements $WorkReportEditorStateCopyWith<$Res> {
  factory _$WorkReportEditorStateCopyWith(_WorkReportEditorState value, $Res Function(_WorkReportEditorState) _then) = __$WorkReportEditorStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, WorkReportModel? report, String summary, List<WorkReportItemDraft> items, bool isSaving, bool isSubmitting, bool isDirty, WorkReportFormError? formError, Map<String, WorkReportItemError> itemErrors, String? serverError
});


@override $WorkReportModelCopyWith<$Res>? get report;

}
/// @nodoc
class __$WorkReportEditorStateCopyWithImpl<$Res>
    implements _$WorkReportEditorStateCopyWith<$Res> {
  __$WorkReportEditorStateCopyWithImpl(this._self, this._then);

  final _WorkReportEditorState _self;
  final $Res Function(_WorkReportEditorState) _then;

/// Create a copy of WorkReportEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? report = freezed,Object? summary = null,Object? items = null,Object? isSaving = null,Object? isSubmitting = null,Object? isDirty = null,Object? formError = freezed,Object? itemErrors = null,Object? serverError = freezed,}) {
  return _then(_WorkReportEditorState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as WorkReportModel?,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportItemDraft>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,formError: freezed == formError ? _self.formError : formError // ignore: cast_nullable_to_non_nullable
as WorkReportFormError?,itemErrors: null == itemErrors ? _self._itemErrors : itemErrors // ignore: cast_nullable_to_non_nullable
as Map<String, WorkReportItemError>,serverError: freezed == serverError ? _self.serverError : serverError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WorkReportEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkReportModelCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $WorkReportModelCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

/// @nodoc
mixin _$WorkReportHistoryState {

 List<WorkReportModel> get items; int get total; int get page; bool get hasMore; String get statusFilter; bool get isLoadingMore; String? get errorMessage;
/// Create a copy of WorkReportHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportHistoryStateCopyWith<WorkReportHistoryState> get copyWith => _$WorkReportHistoryStateCopyWithImpl<WorkReportHistoryState>(this as WorkReportHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportHistoryState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,hasMore,statusFilter,isLoadingMore,errorMessage);

@override
String toString() {
  return 'WorkReportHistoryState(items: $items, total: $total, page: $page, hasMore: $hasMore, statusFilter: $statusFilter, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WorkReportHistoryStateCopyWith<$Res>  {
  factory $WorkReportHistoryStateCopyWith(WorkReportHistoryState value, $Res Function(WorkReportHistoryState) _then) = _$WorkReportHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<WorkReportModel> items, int total, int page, bool hasMore, String statusFilter, bool isLoadingMore, String? errorMessage
});




}
/// @nodoc
class _$WorkReportHistoryStateCopyWithImpl<$Res>
    implements $WorkReportHistoryStateCopyWith<$Res> {
  _$WorkReportHistoryStateCopyWithImpl(this._self, this._then);

  final WorkReportHistoryState _self;
  final $Res Function(WorkReportHistoryState) _then;

/// Create a copy of WorkReportHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? hasMore = null,Object? statusFilter = null,Object? isLoadingMore = null,Object? errorMessage = freezed,}) {
  return _then(WorkReportHistoryState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkReportHistoryState].
extension WorkReportHistoryStatePatterns on WorkReportHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WorkReportModel> items,  int total,  int page,  bool hasMore,  String statusFilter,  bool isLoadingMore,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportHistoryState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WorkReportModel> items,  int total,  int page,  bool hasMore,  String statusFilter,  bool isLoadingMore,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _WorkReportHistoryState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WorkReportModel> items,  int total,  int page,  bool hasMore,  String statusFilter,  bool isLoadingMore,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportHistoryState() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.hasMore,_that.statusFilter,_that.isLoadingMore,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _WorkReportHistoryState implements WorkReportHistoryState {
  const _WorkReportHistoryState({ List<WorkReportModel> items = const <WorkReportModel>[], this.total = 0, this.page = 1, this.hasMore = false, this.statusFilter = 'all', this.isLoadingMore = false, this.errorMessage}): _items = items;
  

 final  List<WorkReportModel> _items;
@override@JsonKey() List<WorkReportModel> get items {
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

/// Create a copy of WorkReportHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportHistoryStateCopyWith<_WorkReportHistoryState> get copyWith => __$WorkReportHistoryStateCopyWithImpl<_WorkReportHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportHistoryState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,hasMore,statusFilter,isLoadingMore,errorMessage);

@override
String toString() {
  return 'WorkReportHistoryState(items: $items, total: $total, page: $page, hasMore: $hasMore, statusFilter: $statusFilter, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WorkReportHistoryStateCopyWith<$Res> implements $WorkReportHistoryStateCopyWith<$Res> {
  factory _$WorkReportHistoryStateCopyWith(_WorkReportHistoryState value, $Res Function(_WorkReportHistoryState) _then) = __$WorkReportHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<WorkReportModel> items, int total, int page, bool hasMore, String statusFilter, bool isLoadingMore, String? errorMessage
});




}
/// @nodoc
class __$WorkReportHistoryStateCopyWithImpl<$Res>
    implements _$WorkReportHistoryStateCopyWith<$Res> {
  __$WorkReportHistoryStateCopyWithImpl(this._self, this._then);

  final _WorkReportHistoryState _self;
  final $Res Function(_WorkReportHistoryState) _then;

/// Create a copy of WorkReportHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? hasMore = null,Object? statusFilter = null,Object? isLoadingMore = null,Object? errorMessage = freezed,}) {
  return _then(_WorkReportHistoryState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
