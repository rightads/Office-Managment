// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_module_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DynamicRecordListState {

 bool get isLoading; bool get isFetchingNextPage; List<DynamicRecordModel> get records; int get total; int get currentPage; int get totalPages; String get search; String? get statusFilter; String? get sortBy; bool get sortDesc; AppFailure? get failure;
/// Create a copy of DynamicRecordListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordListStateCopyWith<DynamicRecordListState> get copyWith => _$DynamicRecordListStateCopyWithImpl<DynamicRecordListState>(this as DynamicRecordListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFetchingNextPage, isFetchingNextPage) || other.isFetchingNextPage == isFetchingNextPage)&&const DeepCollectionEquality().equals(other.records, records)&&(identical(other.total, total) || other.total == total)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.search, search) || other.search == search)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortDesc, sortDesc) || other.sortDesc == sortDesc)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFetchingNextPage,const DeepCollectionEquality().hash(records),total,currentPage,totalPages,search,statusFilter,sortBy,sortDesc,failure);

@override
String toString() {
  return 'DynamicRecordListState(isLoading: $isLoading, isFetchingNextPage: $isFetchingNextPage, records: $records, total: $total, currentPage: $currentPage, totalPages: $totalPages, search: $search, statusFilter: $statusFilter, sortBy: $sortBy, sortDesc: $sortDesc, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordListStateCopyWith<$Res>  {
  factory $DynamicRecordListStateCopyWith(DynamicRecordListState value, $Res Function(DynamicRecordListState) _then) = _$DynamicRecordListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isFetchingNextPage, List<DynamicRecordModel> records, int total, int currentPage, int totalPages, String search, String? statusFilter, String? sortBy, bool sortDesc, AppFailure? failure
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DynamicRecordListStateCopyWithImpl<$Res>
    implements $DynamicRecordListStateCopyWith<$Res> {
  _$DynamicRecordListStateCopyWithImpl(this._self, this._then);

  final DynamicRecordListState _self;
  final $Res Function(DynamicRecordListState) _then;

/// Create a copy of DynamicRecordListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFetchingNextPage = null,Object? records = null,Object? total = null,Object? currentPage = null,Object? totalPages = null,Object? search = null,Object? statusFilter = freezed,Object? sortBy = freezed,Object? sortDesc = null,Object? failure = freezed,}) {
  return _then(DynamicRecordListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFetchingNextPage: null == isFetchingNextPage ? _self.isFetchingNextPage : isFetchingNextPage // ignore: cast_nullable_to_non_nullable
as bool,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortDesc: null == sortDesc ? _self.sortDesc : sortDesc // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of DynamicRecordListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicRecordListState].
extension DynamicRecordListStatePatterns on DynamicRecordListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordListState value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordListState value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isFetchingNextPage,  List<DynamicRecordModel> records,  int total,  int currentPage,  int totalPages,  String search,  String? statusFilter,  String? sortBy,  bool sortDesc,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordListState() when $default != null:
return $default(_that.isLoading,_that.isFetchingNextPage,_that.records,_that.total,_that.currentPage,_that.totalPages,_that.search,_that.statusFilter,_that.sortBy,_that.sortDesc,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isFetchingNextPage,  List<DynamicRecordModel> records,  int total,  int currentPage,  int totalPages,  String search,  String? statusFilter,  String? sortBy,  bool sortDesc,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordListState():
return $default(_that.isLoading,_that.isFetchingNextPage,_that.records,_that.total,_that.currentPage,_that.totalPages,_that.search,_that.statusFilter,_that.sortBy,_that.sortDesc,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isFetchingNextPage,  List<DynamicRecordModel> records,  int total,  int currentPage,  int totalPages,  String search,  String? statusFilter,  String? sortBy,  bool sortDesc,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordListState() when $default != null:
return $default(_that.isLoading,_that.isFetchingNextPage,_that.records,_that.total,_that.currentPage,_that.totalPages,_that.search,_that.statusFilter,_that.sortBy,_that.sortDesc,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DynamicRecordListState implements DynamicRecordListState {
  const _DynamicRecordListState({this.isLoading = true, this.isFetchingNextPage = false,  List<DynamicRecordModel> records = const <DynamicRecordModel>[], this.total = 0, this.currentPage = 1, this.totalPages = 1, this.search = '', this.statusFilter, this.sortBy, this.sortDesc = true, this.failure}): _records = records;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFetchingNextPage;
 final  List<DynamicRecordModel> _records;
@override@JsonKey() List<DynamicRecordModel> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  String search;
@override final  String? statusFilter;
@override final  String? sortBy;
@override@JsonKey() final  bool sortDesc;
@override final  AppFailure? failure;

/// Create a copy of DynamicRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordListStateCopyWith<_DynamicRecordListState> get copyWith => __$DynamicRecordListStateCopyWithImpl<_DynamicRecordListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFetchingNextPage, isFetchingNextPage) || other.isFetchingNextPage == isFetchingNextPage)&&const DeepCollectionEquality().equals(other._records, _records)&&(identical(other.total, total) || other.total == total)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.search, search) || other.search == search)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortDesc, sortDesc) || other.sortDesc == sortDesc)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFetchingNextPage,const DeepCollectionEquality().hash(_records),total,currentPage,totalPages,search,statusFilter,sortBy,sortDesc,failure);

@override
String toString() {
  return 'DynamicRecordListState(isLoading: $isLoading, isFetchingNextPage: $isFetchingNextPage, records: $records, total: $total, currentPage: $currentPage, totalPages: $totalPages, search: $search, statusFilter: $statusFilter, sortBy: $sortBy, sortDesc: $sortDesc, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordListStateCopyWith<$Res> implements $DynamicRecordListStateCopyWith<$Res> {
  factory _$DynamicRecordListStateCopyWith(_DynamicRecordListState value, $Res Function(_DynamicRecordListState) _then) = __$DynamicRecordListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isFetchingNextPage, List<DynamicRecordModel> records, int total, int currentPage, int totalPages, String search, String? statusFilter, String? sortBy, bool sortDesc, AppFailure? failure
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DynamicRecordListStateCopyWithImpl<$Res>
    implements _$DynamicRecordListStateCopyWith<$Res> {
  __$DynamicRecordListStateCopyWithImpl(this._self, this._then);

  final _DynamicRecordListState _self;
  final $Res Function(_DynamicRecordListState) _then;

/// Create a copy of DynamicRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFetchingNextPage = null,Object? records = null,Object? total = null,Object? currentPage = null,Object? totalPages = null,Object? search = null,Object? statusFilter = freezed,Object? sortBy = freezed,Object? sortDesc = null,Object? failure = freezed,}) {
  return _then(_DynamicRecordListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFetchingNextPage: null == isFetchingNextPage ? _self.isFetchingNextPage : isFetchingNextPage // ignore: cast_nullable_to_non_nullable
as bool,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<DynamicRecordModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortDesc: null == sortDesc ? _self.sortDesc : sortDesc // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of DynamicRecordListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc
mixin _$DynamicRecordDetailState {

 bool get isLoading; bool get isActionInProgress; DynamicRecordDetailModel? get detail; AppFailure? get failure;
/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicRecordDetailStateCopyWith<DynamicRecordDetailState> get copyWith => _$DynamicRecordDetailStateCopyWithImpl<DynamicRecordDetailState>(this as DynamicRecordDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicRecordDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isActionInProgress,detail,failure);

@override
String toString() {
  return 'DynamicRecordDetailState(isLoading: $isLoading, isActionInProgress: $isActionInProgress, detail: $detail, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DynamicRecordDetailStateCopyWith<$Res>  {
  factory $DynamicRecordDetailStateCopyWith(DynamicRecordDetailState value, $Res Function(DynamicRecordDetailState) _then) = _$DynamicRecordDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isActionInProgress, DynamicRecordDetailModel? detail, AppFailure? failure
});


$DynamicRecordDetailModelCopyWith<$Res>? get detail;$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DynamicRecordDetailStateCopyWithImpl<$Res>
    implements $DynamicRecordDetailStateCopyWith<$Res> {
  _$DynamicRecordDetailStateCopyWithImpl(this._self, this._then);

  final DynamicRecordDetailState _self;
  final $Res Function(DynamicRecordDetailState) _then;

/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isActionInProgress = null,Object? detail = freezed,Object? failure = freezed,}) {
  return _then(DynamicRecordDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionInProgress: null == isActionInProgress ? _self.isActionInProgress : isActionInProgress // ignore: cast_nullable_to_non_nullable
as bool,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DynamicRecordDetailModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicRecordDetailModelCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DynamicRecordDetailModelCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [DynamicRecordDetailState].
extension DynamicRecordDetailStatePatterns on DynamicRecordDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicRecordDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicRecordDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicRecordDetailState value)  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicRecordDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicRecordDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isActionInProgress,  DynamicRecordDetailModel? detail,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicRecordDetailState() when $default != null:
return $default(_that.isLoading,_that.isActionInProgress,_that.detail,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isActionInProgress,  DynamicRecordDetailModel? detail,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordDetailState():
return $default(_that.isLoading,_that.isActionInProgress,_that.detail,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isActionInProgress,  DynamicRecordDetailModel? detail,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DynamicRecordDetailState() when $default != null:
return $default(_that.isLoading,_that.isActionInProgress,_that.detail,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DynamicRecordDetailState implements DynamicRecordDetailState {
  const _DynamicRecordDetailState({this.isLoading = true, this.isActionInProgress = false, this.detail, this.failure});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionInProgress;
@override final  DynamicRecordDetailModel? detail;
@override final  AppFailure? failure;

/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicRecordDetailStateCopyWith<_DynamicRecordDetailState> get copyWith => __$DynamicRecordDetailStateCopyWithImpl<_DynamicRecordDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicRecordDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isActionInProgress,detail,failure);

@override
String toString() {
  return 'DynamicRecordDetailState(isLoading: $isLoading, isActionInProgress: $isActionInProgress, detail: $detail, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DynamicRecordDetailStateCopyWith<$Res> implements $DynamicRecordDetailStateCopyWith<$Res> {
  factory _$DynamicRecordDetailStateCopyWith(_DynamicRecordDetailState value, $Res Function(_DynamicRecordDetailState) _then) = __$DynamicRecordDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isActionInProgress, DynamicRecordDetailModel? detail, AppFailure? failure
});


@override $DynamicRecordDetailModelCopyWith<$Res>? get detail;@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DynamicRecordDetailStateCopyWithImpl<$Res>
    implements _$DynamicRecordDetailStateCopyWith<$Res> {
  __$DynamicRecordDetailStateCopyWithImpl(this._self, this._then);

  final _DynamicRecordDetailState _self;
  final $Res Function(_DynamicRecordDetailState) _then;

/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isActionInProgress = null,Object? detail = freezed,Object? failure = freezed,}) {
  return _then(_DynamicRecordDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionInProgress: null == isActionInProgress ? _self.isActionInProgress : isActionInProgress // ignore: cast_nullable_to_non_nullable
as bool,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DynamicRecordDetailModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DynamicRecordDetailModelCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DynamicRecordDetailModelCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of DynamicRecordDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
