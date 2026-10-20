// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_report_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkReportItemModel {

 String get id; String get description;@JsonKey(name: 'minutes_spent') int get minutesSpent;@JsonKey(name: 'report_id') String get reportId;@JsonKey(name: 'task_id') String? get taskId;@JsonKey(name: 'task_title') String? get taskTitle;@JsonKey(name: 'client_id') String? get clientId;@JsonKey(name: 'client_name') String? get clientName;@JsonKey(name: 'project_id') String? get projectId;@JsonKey(name: 'project_name') String? get projectName;
/// Create a copy of WorkReportItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportItemModelCopyWith<WorkReportItemModel> get copyWith => _$WorkReportItemModelCopyWithImpl<WorkReportItemModel>(this as WorkReportItemModel, _$identity);

  /// Serializes this WorkReportItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.minutesSpent, minutesSpent) || other.minutesSpent == minutesSpent)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskTitle, taskTitle) || other.taskTitle == taskTitle)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,minutesSpent,reportId,taskId,taskTitle,clientId,clientName,projectId,projectName);

@override
String toString() {
  return 'WorkReportItemModel(id: $id, description: $description, minutesSpent: $minutesSpent, reportId: $reportId, taskId: $taskId, taskTitle: $taskTitle, clientId: $clientId, clientName: $clientName, projectId: $projectId, projectName: $projectName)';
}


}

/// @nodoc
abstract mixin class $WorkReportItemModelCopyWith<$Res>  {
  factory $WorkReportItemModelCopyWith(WorkReportItemModel value, $Res Function(WorkReportItemModel) _then) = _$WorkReportItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String description,@JsonKey(name: 'minutes_spent') int minutesSpent,@JsonKey(name: 'report_id') String reportId,@JsonKey(name: 'task_id') String? taskId,@JsonKey(name: 'task_title') String? taskTitle,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'project_id') String? projectId,@JsonKey(name: 'project_name') String? projectName
});




}
/// @nodoc
class _$WorkReportItemModelCopyWithImpl<$Res>
    implements $WorkReportItemModelCopyWith<$Res> {
  _$WorkReportItemModelCopyWithImpl(this._self, this._then);

  final WorkReportItemModel _self;
  final $Res Function(WorkReportItemModel) _then;

/// Create a copy of WorkReportItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? minutesSpent = null,Object? reportId = null,Object? taskId = freezed,Object? taskTitle = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? projectId = freezed,Object? projectName = freezed,}) {
  return _then(WorkReportItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minutesSpent: null == minutesSpent ? _self.minutesSpent : minutesSpent // ignore: cast_nullable_to_non_nullable
as int,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,taskTitle: freezed == taskTitle ? _self.taskTitle : taskTitle // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkReportItemModel].
extension WorkReportItemModelPatterns on WorkReportItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportItemModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description, @JsonKey(name: 'minutes_spent')  int minutesSpent, @JsonKey(name: 'report_id')  String reportId, @JsonKey(name: 'task_id')  String? taskId, @JsonKey(name: 'task_title')  String? taskTitle, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportItemModel() when $default != null:
return $default(_that.id,_that.description,_that.minutesSpent,_that.reportId,_that.taskId,_that.taskTitle,_that.clientId,_that.clientName,_that.projectId,_that.projectName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description, @JsonKey(name: 'minutes_spent')  int minutesSpent, @JsonKey(name: 'report_id')  String reportId, @JsonKey(name: 'task_id')  String? taskId, @JsonKey(name: 'task_title')  String? taskTitle, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName)  $default,) {final _that = this;
switch (_that) {
case _WorkReportItemModel():
return $default(_that.id,_that.description,_that.minutesSpent,_that.reportId,_that.taskId,_that.taskTitle,_that.clientId,_that.clientName,_that.projectId,_that.projectName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description, @JsonKey(name: 'minutes_spent')  int minutesSpent, @JsonKey(name: 'report_id')  String reportId, @JsonKey(name: 'task_id')  String? taskId, @JsonKey(name: 'task_title')  String? taskTitle, @JsonKey(name: 'client_id')  String? clientId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportItemModel() when $default != null:
return $default(_that.id,_that.description,_that.minutesSpent,_that.reportId,_that.taskId,_that.taskTitle,_that.clientId,_that.clientName,_that.projectId,_that.projectName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkReportItemModel implements WorkReportItemModel {
  const _WorkReportItemModel({required this.id, required this.description, @JsonKey(name: 'minutes_spent') required this.minutesSpent, @JsonKey(name: 'report_id') this.reportId = '', @JsonKey(name: 'task_id') this.taskId, @JsonKey(name: 'task_title') this.taskTitle, @JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'client_name') this.clientName, @JsonKey(name: 'project_id') this.projectId, @JsonKey(name: 'project_name') this.projectName});
  factory _WorkReportItemModel.fromJson(Map<String, dynamic> json) => _$WorkReportItemModelFromJson(json);

@override final  String id;
@override final  String description;
@override@JsonKey(name: 'minutes_spent') final  int minutesSpent;
@override@JsonKey(name: 'report_id') final  String reportId;
@override@JsonKey(name: 'task_id') final  String? taskId;
@override@JsonKey(name: 'task_title') final  String? taskTitle;
@override@JsonKey(name: 'client_id') final  String? clientId;
@override@JsonKey(name: 'client_name') final  String? clientName;
@override@JsonKey(name: 'project_id') final  String? projectId;
@override@JsonKey(name: 'project_name') final  String? projectName;

/// Create a copy of WorkReportItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportItemModelCopyWith<_WorkReportItemModel> get copyWith => __$WorkReportItemModelCopyWithImpl<_WorkReportItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkReportItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.minutesSpent, minutesSpent) || other.minutesSpent == minutesSpent)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskTitle, taskTitle) || other.taskTitle == taskTitle)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,minutesSpent,reportId,taskId,taskTitle,clientId,clientName,projectId,projectName);

@override
String toString() {
  return 'WorkReportItemModel(id: $id, description: $description, minutesSpent: $minutesSpent, reportId: $reportId, taskId: $taskId, taskTitle: $taskTitle, clientId: $clientId, clientName: $clientName, projectId: $projectId, projectName: $projectName)';
}


}

/// @nodoc
abstract mixin class _$WorkReportItemModelCopyWith<$Res> implements $WorkReportItemModelCopyWith<$Res> {
  factory _$WorkReportItemModelCopyWith(_WorkReportItemModel value, $Res Function(_WorkReportItemModel) _then) = __$WorkReportItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String description,@JsonKey(name: 'minutes_spent') int minutesSpent,@JsonKey(name: 'report_id') String reportId,@JsonKey(name: 'task_id') String? taskId,@JsonKey(name: 'task_title') String? taskTitle,@JsonKey(name: 'client_id') String? clientId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'project_id') String? projectId,@JsonKey(name: 'project_name') String? projectName
});




}
/// @nodoc
class __$WorkReportItemModelCopyWithImpl<$Res>
    implements _$WorkReportItemModelCopyWith<$Res> {
  __$WorkReportItemModelCopyWithImpl(this._self, this._then);

  final _WorkReportItemModel _self;
  final $Res Function(_WorkReportItemModel) _then;

/// Create a copy of WorkReportItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? minutesSpent = null,Object? reportId = null,Object? taskId = freezed,Object? taskTitle = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? projectId = freezed,Object? projectName = freezed,}) {
  return _then(_WorkReportItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minutesSpent: null == minutesSpent ? _self.minutesSpent : minutesSpent // ignore: cast_nullable_to_non_nullable
as int,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,taskTitle: freezed == taskTitle ? _self.taskTitle : taskTitle // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WorkReportModel {

 String get id;@JsonKey(name: 'report_date') DateTime get reportDate; String get status;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_full_name') String? get userFullName; String? get summary;@JsonKey(name: 'total_minutes') int get totalMinutes;@JsonKey(name: 'submitted_at') DateTime? get submittedAt;@JsonKey(name: 'reviewed_by') String? get reviewedBy;@JsonKey(name: 'reviewer_name') String? get reviewerName;@JsonKey(name: 'reviewed_at') DateTime? get reviewedAt;@JsonKey(name: 'review_note') String? get reviewNote; List<WorkReportItemModel> get items;
/// Create a copy of WorkReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportModelCopyWith<WorkReportModel> get copyWith => _$WorkReportModelCopyWithImpl<WorkReportModel>(this as WorkReportModel, _$identity);

  /// Serializes this WorkReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.reportDate, reportDate) || other.reportDate == reportDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reportDate,status,userId,userFullName,summary,totalMinutes,submittedAt,reviewedBy,reviewerName,reviewedAt,reviewNote,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'WorkReportModel(id: $id, reportDate: $reportDate, status: $status, userId: $userId, userFullName: $userFullName, summary: $summary, totalMinutes: $totalMinutes, submittedAt: $submittedAt, reviewedBy: $reviewedBy, reviewerName: $reviewerName, reviewedAt: $reviewedAt, reviewNote: $reviewNote, items: $items)';
}


}

/// @nodoc
abstract mixin class $WorkReportModelCopyWith<$Res>  {
  factory $WorkReportModelCopyWith(WorkReportModel value, $Res Function(WorkReportModel) _then) = _$WorkReportModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'report_date') DateTime reportDate, String status,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_full_name') String? userFullName, String? summary,@JsonKey(name: 'total_minutes') int totalMinutes,@JsonKey(name: 'submitted_at') DateTime? submittedAt,@JsonKey(name: 'reviewed_by') String? reviewedBy,@JsonKey(name: 'reviewer_name') String? reviewerName,@JsonKey(name: 'reviewed_at') DateTime? reviewedAt,@JsonKey(name: 'review_note') String? reviewNote, List<WorkReportItemModel> items
});




}
/// @nodoc
class _$WorkReportModelCopyWithImpl<$Res>
    implements $WorkReportModelCopyWith<$Res> {
  _$WorkReportModelCopyWithImpl(this._self, this._then);

  final WorkReportModel _self;
  final $Res Function(WorkReportModel) _then;

/// Create a copy of WorkReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reportDate = null,Object? status = null,Object? userId = null,Object? userFullName = freezed,Object? summary = freezed,Object? totalMinutes = null,Object? submittedAt = freezed,Object? reviewedBy = freezed,Object? reviewerName = freezed,Object? reviewedAt = freezed,Object? reviewNote = freezed,Object? items = null,}) {
  return _then(WorkReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reportDate: null == reportDate ? _self.reportDate : reportDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: freezed == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewNote: freezed == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkReportModel].
extension WorkReportModelPatterns on WorkReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'report_date')  DateTime reportDate,  String status, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_full_name')  String? userFullName,  String? summary, @JsonKey(name: 'total_minutes')  int totalMinutes, @JsonKey(name: 'submitted_at')  DateTime? submittedAt, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewer_name')  String? reviewerName, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt, @JsonKey(name: 'review_note')  String? reviewNote,  List<WorkReportItemModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportModel() when $default != null:
return $default(_that.id,_that.reportDate,_that.status,_that.userId,_that.userFullName,_that.summary,_that.totalMinutes,_that.submittedAt,_that.reviewedBy,_that.reviewerName,_that.reviewedAt,_that.reviewNote,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'report_date')  DateTime reportDate,  String status, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_full_name')  String? userFullName,  String? summary, @JsonKey(name: 'total_minutes')  int totalMinutes, @JsonKey(name: 'submitted_at')  DateTime? submittedAt, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewer_name')  String? reviewerName, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt, @JsonKey(name: 'review_note')  String? reviewNote,  List<WorkReportItemModel> items)  $default,) {final _that = this;
switch (_that) {
case _WorkReportModel():
return $default(_that.id,_that.reportDate,_that.status,_that.userId,_that.userFullName,_that.summary,_that.totalMinutes,_that.submittedAt,_that.reviewedBy,_that.reviewerName,_that.reviewedAt,_that.reviewNote,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'report_date')  DateTime reportDate,  String status, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_full_name')  String? userFullName,  String? summary, @JsonKey(name: 'total_minutes')  int totalMinutes, @JsonKey(name: 'submitted_at')  DateTime? submittedAt, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewer_name')  String? reviewerName, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt, @JsonKey(name: 'review_note')  String? reviewNote,  List<WorkReportItemModel> items)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportModel() when $default != null:
return $default(_that.id,_that.reportDate,_that.status,_that.userId,_that.userFullName,_that.summary,_that.totalMinutes,_that.submittedAt,_that.reviewedBy,_that.reviewerName,_that.reviewedAt,_that.reviewNote,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkReportModel extends WorkReportModel {
  const _WorkReportModel({required this.id, @JsonKey(name: 'report_date') required this.reportDate, required this.status, @JsonKey(name: 'user_id') this.userId = '', @JsonKey(name: 'user_full_name') this.userFullName, this.summary, @JsonKey(name: 'total_minutes') this.totalMinutes = 0, @JsonKey(name: 'submitted_at') this.submittedAt, @JsonKey(name: 'reviewed_by') this.reviewedBy, @JsonKey(name: 'reviewer_name') this.reviewerName, @JsonKey(name: 'reviewed_at') this.reviewedAt, @JsonKey(name: 'review_note') this.reviewNote,  List<WorkReportItemModel> items = const <WorkReportItemModel>[]}): _items = items,super._();
  factory _WorkReportModel.fromJson(Map<String, dynamic> json) => _$WorkReportModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'report_date') final  DateTime reportDate;
@override final  String status;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_full_name') final  String? userFullName;
@override final  String? summary;
@override@JsonKey(name: 'total_minutes') final  int totalMinutes;
@override@JsonKey(name: 'submitted_at') final  DateTime? submittedAt;
@override@JsonKey(name: 'reviewed_by') final  String? reviewedBy;
@override@JsonKey(name: 'reviewer_name') final  String? reviewerName;
@override@JsonKey(name: 'reviewed_at') final  DateTime? reviewedAt;
@override@JsonKey(name: 'review_note') final  String? reviewNote;
 final  List<WorkReportItemModel> _items;
@override@JsonKey() List<WorkReportItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of WorkReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportModelCopyWith<_WorkReportModel> get copyWith => __$WorkReportModelCopyWithImpl<_WorkReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.reportDate, reportDate) || other.reportDate == reportDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reportDate,status,userId,userFullName,summary,totalMinutes,submittedAt,reviewedBy,reviewerName,reviewedAt,reviewNote,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'WorkReportModel(id: $id, reportDate: $reportDate, status: $status, userId: $userId, userFullName: $userFullName, summary: $summary, totalMinutes: $totalMinutes, submittedAt: $submittedAt, reviewedBy: $reviewedBy, reviewerName: $reviewerName, reviewedAt: $reviewedAt, reviewNote: $reviewNote, items: $items)';
}


}

/// @nodoc
abstract mixin class _$WorkReportModelCopyWith<$Res> implements $WorkReportModelCopyWith<$Res> {
  factory _$WorkReportModelCopyWith(_WorkReportModel value, $Res Function(_WorkReportModel) _then) = __$WorkReportModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'report_date') DateTime reportDate, String status,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_full_name') String? userFullName, String? summary,@JsonKey(name: 'total_minutes') int totalMinutes,@JsonKey(name: 'submitted_at') DateTime? submittedAt,@JsonKey(name: 'reviewed_by') String? reviewedBy,@JsonKey(name: 'reviewer_name') String? reviewerName,@JsonKey(name: 'reviewed_at') DateTime? reviewedAt,@JsonKey(name: 'review_note') String? reviewNote, List<WorkReportItemModel> items
});




}
/// @nodoc
class __$WorkReportModelCopyWithImpl<$Res>
    implements _$WorkReportModelCopyWith<$Res> {
  __$WorkReportModelCopyWithImpl(this._self, this._then);

  final _WorkReportModel _self;
  final $Res Function(_WorkReportModel) _then;

/// Create a copy of WorkReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reportDate = null,Object? status = null,Object? userId = null,Object? userFullName = freezed,Object? summary = freezed,Object? totalMinutes = null,Object? submittedAt = freezed,Object? reviewedBy = freezed,Object? reviewerName = freezed,Object? reviewedAt = freezed,Object? reviewNote = freezed,Object? items = null,}) {
  return _then(_WorkReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reportDate: null == reportDate ? _self.reportDate : reportDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: freezed == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewNote: freezed == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportItemModel>,
  ));
}


}


/// @nodoc
mixin _$WorkReportPageResponse {

 List<WorkReportModel> get items; int get total; int get page;@JsonKey(name: 'page_size') int get pageSize;@JsonKey(name: 'total_pages') int get totalPages;
/// Create a copy of WorkReportPageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportPageResponseCopyWith<WorkReportPageResponse> get copyWith => _$WorkReportPageResponseCopyWithImpl<WorkReportPageResponse>(this as WorkReportPageResponse, _$identity);

  /// Serializes this WorkReportPageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportPageResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,pageSize,totalPages);

@override
String toString() {
  return 'WorkReportPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $WorkReportPageResponseCopyWith<$Res>  {
  factory $WorkReportPageResponseCopyWith(WorkReportPageResponse value, $Res Function(WorkReportPageResponse) _then) = _$WorkReportPageResponseCopyWithImpl;
@useResult
$Res call({
 List<WorkReportModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class _$WorkReportPageResponseCopyWithImpl<$Res>
    implements $WorkReportPageResponseCopyWith<$Res> {
  _$WorkReportPageResponseCopyWithImpl(this._self, this._then);

  final WorkReportPageResponse _self;
  final $Res Function(WorkReportPageResponse) _then;

/// Create a copy of WorkReportPageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,}) {
  return _then(WorkReportPageResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkReportPageResponse].
extension WorkReportPageResponsePatterns on WorkReportPageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportPageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportPageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportPageResponse value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportPageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportPageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportPageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WorkReportModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportPageResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WorkReportModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _WorkReportPageResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WorkReportModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkReportPageResponse implements WorkReportPageResponse {
  const _WorkReportPageResponse({ List<WorkReportModel> items = const <WorkReportModel>[], this.total = 0, this.page = 1, @JsonKey(name: 'page_size') this.pageSize = 20, @JsonKey(name: 'total_pages') this.totalPages = 1}): _items = items;
  factory _WorkReportPageResponse.fromJson(Map<String, dynamic> json) => _$WorkReportPageResponseFromJson(json);

 final  List<WorkReportModel> _items;
@override@JsonKey() List<WorkReportModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int page;
@override@JsonKey(name: 'page_size') final  int pageSize;
@override@JsonKey(name: 'total_pages') final  int totalPages;

/// Create a copy of WorkReportPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportPageResponseCopyWith<_WorkReportPageResponse> get copyWith => __$WorkReportPageResponseCopyWithImpl<_WorkReportPageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkReportPageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportPageResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,pageSize,totalPages);

@override
String toString() {
  return 'WorkReportPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$WorkReportPageResponseCopyWith<$Res> implements $WorkReportPageResponseCopyWith<$Res> {
  factory _$WorkReportPageResponseCopyWith(_WorkReportPageResponse value, $Res Function(_WorkReportPageResponse) _then) = __$WorkReportPageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<WorkReportModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class __$WorkReportPageResponseCopyWithImpl<$Res>
    implements _$WorkReportPageResponseCopyWith<$Res> {
  __$WorkReportPageResponseCopyWithImpl(this._self, this._then);

  final _WorkReportPageResponse _self;
  final $Res Function(_WorkReportPageResponse) _then;

/// Create a copy of WorkReportPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,}) {
  return _then(_WorkReportPageResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WorkReportModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WorkReportItemDraft {

/// Stable local identity so rows keep focus/state while being edited.
 String get localId; String get description;/// `null` while the minutes field is empty or unparsable.
 int? get minutes; String? get taskId; String? get taskTitle; String? get clientId; String? get clientName; String? get projectId; String? get projectName;
/// Create a copy of WorkReportItemDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportItemDraftCopyWith<WorkReportItemDraft> get copyWith => _$WorkReportItemDraftCopyWithImpl<WorkReportItemDraft>(this as WorkReportItemDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportItemDraft&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.description, description) || other.description == description)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskTitle, taskTitle) || other.taskTitle == taskTitle)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName));
}


@override
int get hashCode => Object.hash(runtimeType,localId,description,minutes,taskId,taskTitle,clientId,clientName,projectId,projectName);

@override
String toString() {
  return 'WorkReportItemDraft(localId: $localId, description: $description, minutes: $minutes, taskId: $taskId, taskTitle: $taskTitle, clientId: $clientId, clientName: $clientName, projectId: $projectId, projectName: $projectName)';
}


}

/// @nodoc
abstract mixin class $WorkReportItemDraftCopyWith<$Res>  {
  factory $WorkReportItemDraftCopyWith(WorkReportItemDraft value, $Res Function(WorkReportItemDraft) _then) = _$WorkReportItemDraftCopyWithImpl;
@useResult
$Res call({
 String localId, String description, int? minutes, String? taskId, String? taskTitle, String? clientId, String? clientName, String? projectId, String? projectName
});




}
/// @nodoc
class _$WorkReportItemDraftCopyWithImpl<$Res>
    implements $WorkReportItemDraftCopyWith<$Res> {
  _$WorkReportItemDraftCopyWithImpl(this._self, this._then);

  final WorkReportItemDraft _self;
  final $Res Function(WorkReportItemDraft) _then;

/// Create a copy of WorkReportItemDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? description = null,Object? minutes = freezed,Object? taskId = freezed,Object? taskTitle = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? projectId = freezed,Object? projectName = freezed,}) {
  return _then(WorkReportItemDraft(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,taskTitle: freezed == taskTitle ? _self.taskTitle : taskTitle // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkReportItemDraft].
extension WorkReportItemDraftPatterns on WorkReportItemDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportItemDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportItemDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportItemDraft value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportItemDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportItemDraft value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportItemDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localId,  String description,  int? minutes,  String? taskId,  String? taskTitle,  String? clientId,  String? clientName,  String? projectId,  String? projectName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportItemDraft() when $default != null:
return $default(_that.localId,_that.description,_that.minutes,_that.taskId,_that.taskTitle,_that.clientId,_that.clientName,_that.projectId,_that.projectName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localId,  String description,  int? minutes,  String? taskId,  String? taskTitle,  String? clientId,  String? clientName,  String? projectId,  String? projectName)  $default,) {final _that = this;
switch (_that) {
case _WorkReportItemDraft():
return $default(_that.localId,_that.description,_that.minutes,_that.taskId,_that.taskTitle,_that.clientId,_that.clientName,_that.projectId,_that.projectName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localId,  String description,  int? minutes,  String? taskId,  String? taskTitle,  String? clientId,  String? clientName,  String? projectId,  String? projectName)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportItemDraft() when $default != null:
return $default(_that.localId,_that.description,_that.minutes,_that.taskId,_that.taskTitle,_that.clientId,_that.clientName,_that.projectId,_that.projectName);case _:
  return null;

}
}

}

/// @nodoc


class _WorkReportItemDraft extends WorkReportItemDraft {
  const _WorkReportItemDraft({required this.localId, this.description = '', this.minutes, this.taskId, this.taskTitle, this.clientId, this.clientName, this.projectId, this.projectName}): super._();
  

/// Stable local identity so rows keep focus/state while being edited.
@override final  String localId;
@override@JsonKey() final  String description;
/// `null` while the minutes field is empty or unparsable.
@override final  int? minutes;
@override final  String? taskId;
@override final  String? taskTitle;
@override final  String? clientId;
@override final  String? clientName;
@override final  String? projectId;
@override final  String? projectName;

/// Create a copy of WorkReportItemDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportItemDraftCopyWith<_WorkReportItemDraft> get copyWith => __$WorkReportItemDraftCopyWithImpl<_WorkReportItemDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportItemDraft&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.description, description) || other.description == description)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskTitle, taskTitle) || other.taskTitle == taskTitle)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName));
}


@override
int get hashCode => Object.hash(runtimeType,localId,description,minutes,taskId,taskTitle,clientId,clientName,projectId,projectName);

@override
String toString() {
  return 'WorkReportItemDraft(localId: $localId, description: $description, minutes: $minutes, taskId: $taskId, taskTitle: $taskTitle, clientId: $clientId, clientName: $clientName, projectId: $projectId, projectName: $projectName)';
}


}

/// @nodoc
abstract mixin class _$WorkReportItemDraftCopyWith<$Res> implements $WorkReportItemDraftCopyWith<$Res> {
  factory _$WorkReportItemDraftCopyWith(_WorkReportItemDraft value, $Res Function(_WorkReportItemDraft) _then) = __$WorkReportItemDraftCopyWithImpl;
@override @useResult
$Res call({
 String localId, String description, int? minutes, String? taskId, String? taskTitle, String? clientId, String? clientName, String? projectId, String? projectName
});




}
/// @nodoc
class __$WorkReportItemDraftCopyWithImpl<$Res>
    implements _$WorkReportItemDraftCopyWith<$Res> {
  __$WorkReportItemDraftCopyWithImpl(this._self, this._then);

  final _WorkReportItemDraft _self;
  final $Res Function(_WorkReportItemDraft) _then;

/// Create a copy of WorkReportItemDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? description = null,Object? minutes = freezed,Object? taskId = freezed,Object? taskTitle = freezed,Object? clientId = freezed,Object? clientName = freezed,Object? projectId = freezed,Object? projectName = freezed,}) {
  return _then(_WorkReportItemDraft(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,taskTitle: freezed == taskTitle ? _self.taskTitle : taskTitle // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
