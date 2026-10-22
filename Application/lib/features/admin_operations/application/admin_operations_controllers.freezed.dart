// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_operations_controllers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminTaskReportsState {

 TaskSummaryReportsResponse? get summary; bool get isLoading; String? get errorMessage;
/// Create a copy of AdminTaskReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminTaskReportsStateCopyWith<AdminTaskReportsState> get copyWith => _$AdminTaskReportsStateCopyWithImpl<AdminTaskReportsState>(this as AdminTaskReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminTaskReportsState&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,errorMessage);

@override
String toString() {
  return 'AdminTaskReportsState(summary: $summary, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminTaskReportsStateCopyWith<$Res>  {
  factory $AdminTaskReportsStateCopyWith(AdminTaskReportsState value, $Res Function(AdminTaskReportsState) _then) = _$AdminTaskReportsStateCopyWithImpl;
@useResult
$Res call({
 TaskSummaryReportsResponse? summary, bool isLoading, String? errorMessage
});


$TaskSummaryReportsResponseCopyWith<$Res>? get summary;

}
/// @nodoc
class _$AdminTaskReportsStateCopyWithImpl<$Res>
    implements $AdminTaskReportsStateCopyWith<$Res> {
  _$AdminTaskReportsStateCopyWithImpl(this._self, this._then);

  final AdminTaskReportsState _self;
  final $Res Function(AdminTaskReportsState) _then;

/// Create a copy of AdminTaskReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(AdminTaskReportsState(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TaskSummaryReportsResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminTaskReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSummaryReportsResponseCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $TaskSummaryReportsResponseCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminTaskReportsState].
extension AdminTaskReportsStatePatterns on AdminTaskReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminTaskReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminTaskReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminTaskReportsState value)  $default,){
final _that = this;
switch (_that) {
case _AdminTaskReportsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminTaskReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminTaskReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TaskSummaryReportsResponse? summary,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminTaskReportsState() when $default != null:
return $default(_that.summary,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TaskSummaryReportsResponse? summary,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminTaskReportsState():
return $default(_that.summary,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TaskSummaryReportsResponse? summary,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminTaskReportsState() when $default != null:
return $default(_that.summary,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminTaskReportsState implements AdminTaskReportsState {
  const _AdminTaskReportsState({this.summary, this.isLoading = true, this.errorMessage});
  

@override final  TaskSummaryReportsResponse? summary;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of AdminTaskReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTaskReportsStateCopyWith<_AdminTaskReportsState> get copyWith => __$AdminTaskReportsStateCopyWithImpl<_AdminTaskReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTaskReportsState&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,errorMessage);

@override
String toString() {
  return 'AdminTaskReportsState(summary: $summary, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminTaskReportsStateCopyWith<$Res> implements $AdminTaskReportsStateCopyWith<$Res> {
  factory _$AdminTaskReportsStateCopyWith(_AdminTaskReportsState value, $Res Function(_AdminTaskReportsState) _then) = __$AdminTaskReportsStateCopyWithImpl;
@override @useResult
$Res call({
 TaskSummaryReportsResponse? summary, bool isLoading, String? errorMessage
});


@override $TaskSummaryReportsResponseCopyWith<$Res>? get summary;

}
/// @nodoc
class __$AdminTaskReportsStateCopyWithImpl<$Res>
    implements _$AdminTaskReportsStateCopyWith<$Res> {
  __$AdminTaskReportsStateCopyWithImpl(this._self, this._then);

  final _AdminTaskReportsState _self;
  final $Res Function(_AdminTaskReportsState) _then;

/// Create a copy of AdminTaskReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_AdminTaskReportsState(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TaskSummaryReportsResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminTaskReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSummaryReportsResponseCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $TaskSummaryReportsResponseCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$AdminLeaveApprovalsState {

 List<LeaveRequestModel> get requests; bool get isLoading; bool get isActionLoading; String? get departmentId; String? get statusFilter; String? get errorMessage;
/// Create a copy of AdminLeaveApprovalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminLeaveApprovalsStateCopyWith<AdminLeaveApprovalsState> get copyWith => _$AdminLeaveApprovalsStateCopyWithImpl<AdminLeaveApprovalsState>(this as AdminLeaveApprovalsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminLeaveApprovalsState&&const DeepCollectionEquality().equals(other.requests, requests)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(requests),isLoading,isActionLoading,departmentId,statusFilter,errorMessage);

@override
String toString() {
  return 'AdminLeaveApprovalsState(requests: $requests, isLoading: $isLoading, isActionLoading: $isActionLoading, departmentId: $departmentId, statusFilter: $statusFilter, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminLeaveApprovalsStateCopyWith<$Res>  {
  factory $AdminLeaveApprovalsStateCopyWith(AdminLeaveApprovalsState value, $Res Function(AdminLeaveApprovalsState) _then) = _$AdminLeaveApprovalsStateCopyWithImpl;
@useResult
$Res call({
 List<LeaveRequestModel> requests, bool isLoading, bool isActionLoading, String? departmentId, String? statusFilter, String? errorMessage
});




}
/// @nodoc
class _$AdminLeaveApprovalsStateCopyWithImpl<$Res>
    implements $AdminLeaveApprovalsStateCopyWith<$Res> {
  _$AdminLeaveApprovalsStateCopyWithImpl(this._self, this._then);

  final AdminLeaveApprovalsState _self;
  final $Res Function(AdminLeaveApprovalsState) _then;

/// Create a copy of AdminLeaveApprovalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requests = null,Object? isLoading = null,Object? isActionLoading = null,Object? departmentId = freezed,Object? statusFilter = freezed,Object? errorMessage = freezed,}) {
  return _then(AdminLeaveApprovalsState(
requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as List<LeaveRequestModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminLeaveApprovalsState].
extension AdminLeaveApprovalsStatePatterns on AdminLeaveApprovalsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminLeaveApprovalsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminLeaveApprovalsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminLeaveApprovalsState value)  $default,){
final _that = this;
switch (_that) {
case _AdminLeaveApprovalsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminLeaveApprovalsState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminLeaveApprovalsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaveRequestModel> requests,  bool isLoading,  bool isActionLoading,  String? departmentId,  String? statusFilter,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminLeaveApprovalsState() when $default != null:
return $default(_that.requests,_that.isLoading,_that.isActionLoading,_that.departmentId,_that.statusFilter,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaveRequestModel> requests,  bool isLoading,  bool isActionLoading,  String? departmentId,  String? statusFilter,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminLeaveApprovalsState():
return $default(_that.requests,_that.isLoading,_that.isActionLoading,_that.departmentId,_that.statusFilter,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaveRequestModel> requests,  bool isLoading,  bool isActionLoading,  String? departmentId,  String? statusFilter,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminLeaveApprovalsState() when $default != null:
return $default(_that.requests,_that.isLoading,_that.isActionLoading,_that.departmentId,_that.statusFilter,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminLeaveApprovalsState implements AdminLeaveApprovalsState {
  const _AdminLeaveApprovalsState({ List<LeaveRequestModel> requests = const <LeaveRequestModel>[], this.isLoading = true, this.isActionLoading = false, this.departmentId, this.statusFilter, this.errorMessage}): _requests = requests;
  

 final  List<LeaveRequestModel> _requests;
@override@JsonKey() List<LeaveRequestModel> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String? departmentId;
@override final  String? statusFilter;
@override final  String? errorMessage;

/// Create a copy of AdminLeaveApprovalsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminLeaveApprovalsStateCopyWith<_AdminLeaveApprovalsState> get copyWith => __$AdminLeaveApprovalsStateCopyWithImpl<_AdminLeaveApprovalsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminLeaveApprovalsState&&const DeepCollectionEquality().equals(other._requests, _requests)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requests),isLoading,isActionLoading,departmentId,statusFilter,errorMessage);

@override
String toString() {
  return 'AdminLeaveApprovalsState(requests: $requests, isLoading: $isLoading, isActionLoading: $isActionLoading, departmentId: $departmentId, statusFilter: $statusFilter, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminLeaveApprovalsStateCopyWith<$Res> implements $AdminLeaveApprovalsStateCopyWith<$Res> {
  factory _$AdminLeaveApprovalsStateCopyWith(_AdminLeaveApprovalsState value, $Res Function(_AdminLeaveApprovalsState) _then) = __$AdminLeaveApprovalsStateCopyWithImpl;
@override @useResult
$Res call({
 List<LeaveRequestModel> requests, bool isLoading, bool isActionLoading, String? departmentId, String? statusFilter, String? errorMessage
});




}
/// @nodoc
class __$AdminLeaveApprovalsStateCopyWithImpl<$Res>
    implements _$AdminLeaveApprovalsStateCopyWith<$Res> {
  __$AdminLeaveApprovalsStateCopyWithImpl(this._self, this._then);

  final _AdminLeaveApprovalsState _self;
  final $Res Function(_AdminLeaveApprovalsState) _then;

/// Create a copy of AdminLeaveApprovalsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requests = null,Object? isLoading = null,Object? isActionLoading = null,Object? departmentId = freezed,Object? statusFilter = freezed,Object? errorMessage = freezed,}) {
  return _then(_AdminLeaveApprovalsState(
requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<LeaveRequestModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AdminWorkReportsReviewState {

 List<WorkReportModel> get reports; MissingWorkReportListResponse? get missingReports; bool get isLoading; bool get isActionLoading; String get selectedDate; String? get departmentId; String? get errorMessage;
/// Create a copy of AdminWorkReportsReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminWorkReportsReviewStateCopyWith<AdminWorkReportsReviewState> get copyWith => _$AdminWorkReportsReviewStateCopyWithImpl<AdminWorkReportsReviewState>(this as AdminWorkReportsReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminWorkReportsReviewState&&const DeepCollectionEquality().equals(other.reports, reports)&&(identical(other.missingReports, missingReports) || other.missingReports == missingReports)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reports),missingReports,isLoading,isActionLoading,selectedDate,departmentId,errorMessage);

@override
String toString() {
  return 'AdminWorkReportsReviewState(reports: $reports, missingReports: $missingReports, isLoading: $isLoading, isActionLoading: $isActionLoading, selectedDate: $selectedDate, departmentId: $departmentId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AdminWorkReportsReviewStateCopyWith<$Res>  {
  factory $AdminWorkReportsReviewStateCopyWith(AdminWorkReportsReviewState value, $Res Function(AdminWorkReportsReviewState) _then) = _$AdminWorkReportsReviewStateCopyWithImpl;
@useResult
$Res call({
 List<WorkReportModel> reports, MissingWorkReportListResponse? missingReports, bool isLoading, bool isActionLoading, String selectedDate, String? departmentId, String? errorMessage
});


$MissingWorkReportListResponseCopyWith<$Res>? get missingReports;

}
/// @nodoc
class _$AdminWorkReportsReviewStateCopyWithImpl<$Res>
    implements $AdminWorkReportsReviewStateCopyWith<$Res> {
  _$AdminWorkReportsReviewStateCopyWithImpl(this._self, this._then);

  final AdminWorkReportsReviewState _self;
  final $Res Function(AdminWorkReportsReviewState) _then;

/// Create a copy of AdminWorkReportsReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reports = null,Object? missingReports = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? selectedDate = null,Object? departmentId = freezed,Object? errorMessage = freezed,}) {
  return _then(AdminWorkReportsReviewState(
reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as List<WorkReportModel>,missingReports: freezed == missingReports ? _self.missingReports : missingReports // ignore: cast_nullable_to_non_nullable
as MissingWorkReportListResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as String,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminWorkReportsReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MissingWorkReportListResponseCopyWith<$Res>? get missingReports {
    if (_self.missingReports == null) {
    return null;
  }

  return $MissingWorkReportListResponseCopyWith<$Res>(_self.missingReports!, (value) {
    return _then(_self.copyWith(missingReports: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminWorkReportsReviewState].
extension AdminWorkReportsReviewStatePatterns on AdminWorkReportsReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminWorkReportsReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminWorkReportsReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminWorkReportsReviewState value)  $default,){
final _that = this;
switch (_that) {
case _AdminWorkReportsReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminWorkReportsReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminWorkReportsReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WorkReportModel> reports,  MissingWorkReportListResponse? missingReports,  bool isLoading,  bool isActionLoading,  String selectedDate,  String? departmentId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminWorkReportsReviewState() when $default != null:
return $default(_that.reports,_that.missingReports,_that.isLoading,_that.isActionLoading,_that.selectedDate,_that.departmentId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WorkReportModel> reports,  MissingWorkReportListResponse? missingReports,  bool isLoading,  bool isActionLoading,  String selectedDate,  String? departmentId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminWorkReportsReviewState():
return $default(_that.reports,_that.missingReports,_that.isLoading,_that.isActionLoading,_that.selectedDate,_that.departmentId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WorkReportModel> reports,  MissingWorkReportListResponse? missingReports,  bool isLoading,  bool isActionLoading,  String selectedDate,  String? departmentId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminWorkReportsReviewState() when $default != null:
return $default(_that.reports,_that.missingReports,_that.isLoading,_that.isActionLoading,_that.selectedDate,_that.departmentId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AdminWorkReportsReviewState implements AdminWorkReportsReviewState {
  const _AdminWorkReportsReviewState({ List<WorkReportModel> reports = const <WorkReportModel>[], this.missingReports, this.isLoading = true, this.isActionLoading = false, required this.selectedDate, this.departmentId, this.errorMessage}): _reports = reports;
  

 final  List<WorkReportModel> _reports;
@override@JsonKey() List<WorkReportModel> get reports {
  if (_reports is EqualUnmodifiableListView) return _reports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reports);
}

@override final  MissingWorkReportListResponse? missingReports;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String selectedDate;
@override final  String? departmentId;
@override final  String? errorMessage;

/// Create a copy of AdminWorkReportsReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminWorkReportsReviewStateCopyWith<_AdminWorkReportsReviewState> get copyWith => __$AdminWorkReportsReviewStateCopyWithImpl<_AdminWorkReportsReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminWorkReportsReviewState&&const DeepCollectionEquality().equals(other._reports, _reports)&&(identical(other.missingReports, missingReports) || other.missingReports == missingReports)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reports),missingReports,isLoading,isActionLoading,selectedDate,departmentId,errorMessage);

@override
String toString() {
  return 'AdminWorkReportsReviewState(reports: $reports, missingReports: $missingReports, isLoading: $isLoading, isActionLoading: $isActionLoading, selectedDate: $selectedDate, departmentId: $departmentId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminWorkReportsReviewStateCopyWith<$Res> implements $AdminWorkReportsReviewStateCopyWith<$Res> {
  factory _$AdminWorkReportsReviewStateCopyWith(_AdminWorkReportsReviewState value, $Res Function(_AdminWorkReportsReviewState) _then) = __$AdminWorkReportsReviewStateCopyWithImpl;
@override @useResult
$Res call({
 List<WorkReportModel> reports, MissingWorkReportListResponse? missingReports, bool isLoading, bool isActionLoading, String selectedDate, String? departmentId, String? errorMessage
});


@override $MissingWorkReportListResponseCopyWith<$Res>? get missingReports;

}
/// @nodoc
class __$AdminWorkReportsReviewStateCopyWithImpl<$Res>
    implements _$AdminWorkReportsReviewStateCopyWith<$Res> {
  __$AdminWorkReportsReviewStateCopyWithImpl(this._self, this._then);

  final _AdminWorkReportsReviewState _self;
  final $Res Function(_AdminWorkReportsReviewState) _then;

/// Create a copy of AdminWorkReportsReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reports = null,Object? missingReports = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? selectedDate = null,Object? departmentId = freezed,Object? errorMessage = freezed,}) {
  return _then(_AdminWorkReportsReviewState(
reports: null == reports ? _self._reports : reports // ignore: cast_nullable_to_non_nullable
as List<WorkReportModel>,missingReports: freezed == missingReports ? _self.missingReports : missingReports // ignore: cast_nullable_to_non_nullable
as MissingWorkReportListResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as String,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminWorkReportsReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MissingWorkReportListResponseCopyWith<$Res>? get missingReports {
    if (_self.missingReports == null) {
    return null;
  }

  return $MissingWorkReportListResponseCopyWith<$Res>(_self.missingReports!, (value) {
    return _then(_self.copyWith(missingReports: value));
  });
}
}

// dart format on
