// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_operations_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskReportItem {

 String? get id; String get name;@JsonKey(name: 'total_tasks') int get totalTasks;@JsonKey(name: 'completed_tasks') int get completedTasks;@JsonKey(name: 'pending_tasks') int get pendingTasks;@JsonKey(name: 'overdue_tasks') int get overdueTasks;
/// Create a copy of TaskReportItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskReportItemCopyWith<TaskReportItem> get copyWith => _$TaskReportItemCopyWithImpl<TaskReportItem>(this as TaskReportItem, _$identity);

  /// Serializes this TaskReportItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskReportItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks)&&(identical(other.pendingTasks, pendingTasks) || other.pendingTasks == pendingTasks)&&(identical(other.overdueTasks, overdueTasks) || other.overdueTasks == overdueTasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,totalTasks,completedTasks,pendingTasks,overdueTasks);

@override
String toString() {
  return 'TaskReportItem(id: $id, name: $name, totalTasks: $totalTasks, completedTasks: $completedTasks, pendingTasks: $pendingTasks, overdueTasks: $overdueTasks)';
}


}

/// @nodoc
abstract mixin class $TaskReportItemCopyWith<$Res>  {
  factory $TaskReportItemCopyWith(TaskReportItem value, $Res Function(TaskReportItem) _then) = _$TaskReportItemCopyWithImpl;
@useResult
$Res call({
 String? id, String name,@JsonKey(name: 'total_tasks') int totalTasks,@JsonKey(name: 'completed_tasks') int completedTasks,@JsonKey(name: 'pending_tasks') int pendingTasks,@JsonKey(name: 'overdue_tasks') int overdueTasks
});




}
/// @nodoc
class _$TaskReportItemCopyWithImpl<$Res>
    implements $TaskReportItemCopyWith<$Res> {
  _$TaskReportItemCopyWithImpl(this._self, this._then);

  final TaskReportItem _self;
  final $Res Function(TaskReportItem) _then;

/// Create a copy of TaskReportItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? totalTasks = null,Object? completedTasks = null,Object? pendingTasks = null,Object? overdueTasks = null,}) {
  return _then(TaskReportItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as int,pendingTasks: null == pendingTasks ? _self.pendingTasks : pendingTasks // ignore: cast_nullable_to_non_nullable
as int,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskReportItem].
extension TaskReportItemPatterns on TaskReportItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskReportItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskReportItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskReportItem value)  $default,){
final _that = this;
switch (_that) {
case _TaskReportItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskReportItem value)?  $default,){
final _that = this;
switch (_that) {
case _TaskReportItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name, @JsonKey(name: 'total_tasks')  int totalTasks, @JsonKey(name: 'completed_tasks')  int completedTasks, @JsonKey(name: 'pending_tasks')  int pendingTasks, @JsonKey(name: 'overdue_tasks')  int overdueTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskReportItem() when $default != null:
return $default(_that.id,_that.name,_that.totalTasks,_that.completedTasks,_that.pendingTasks,_that.overdueTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name, @JsonKey(name: 'total_tasks')  int totalTasks, @JsonKey(name: 'completed_tasks')  int completedTasks, @JsonKey(name: 'pending_tasks')  int pendingTasks, @JsonKey(name: 'overdue_tasks')  int overdueTasks)  $default,) {final _that = this;
switch (_that) {
case _TaskReportItem():
return $default(_that.id,_that.name,_that.totalTasks,_that.completedTasks,_that.pendingTasks,_that.overdueTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name, @JsonKey(name: 'total_tasks')  int totalTasks, @JsonKey(name: 'completed_tasks')  int completedTasks, @JsonKey(name: 'pending_tasks')  int pendingTasks, @JsonKey(name: 'overdue_tasks')  int overdueTasks)?  $default,) {final _that = this;
switch (_that) {
case _TaskReportItem() when $default != null:
return $default(_that.id,_that.name,_that.totalTasks,_that.completedTasks,_that.pendingTasks,_that.overdueTasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskReportItem implements TaskReportItem {
  const _TaskReportItem({this.id, required this.name, @JsonKey(name: 'total_tasks') required this.totalTasks, @JsonKey(name: 'completed_tasks') required this.completedTasks, @JsonKey(name: 'pending_tasks') required this.pendingTasks, @JsonKey(name: 'overdue_tasks') required this.overdueTasks});
  factory _TaskReportItem.fromJson(Map<String, dynamic> json) => _$TaskReportItemFromJson(json);

@override final  String? id;
@override final  String name;
@override@JsonKey(name: 'total_tasks') final  int totalTasks;
@override@JsonKey(name: 'completed_tasks') final  int completedTasks;
@override@JsonKey(name: 'pending_tasks') final  int pendingTasks;
@override@JsonKey(name: 'overdue_tasks') final  int overdueTasks;

/// Create a copy of TaskReportItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskReportItemCopyWith<_TaskReportItem> get copyWith => __$TaskReportItemCopyWithImpl<_TaskReportItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskReportItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskReportItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks)&&(identical(other.pendingTasks, pendingTasks) || other.pendingTasks == pendingTasks)&&(identical(other.overdueTasks, overdueTasks) || other.overdueTasks == overdueTasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,totalTasks,completedTasks,pendingTasks,overdueTasks);

@override
String toString() {
  return 'TaskReportItem(id: $id, name: $name, totalTasks: $totalTasks, completedTasks: $completedTasks, pendingTasks: $pendingTasks, overdueTasks: $overdueTasks)';
}


}

/// @nodoc
abstract mixin class _$TaskReportItemCopyWith<$Res> implements $TaskReportItemCopyWith<$Res> {
  factory _$TaskReportItemCopyWith(_TaskReportItem value, $Res Function(_TaskReportItem) _then) = __$TaskReportItemCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name,@JsonKey(name: 'total_tasks') int totalTasks,@JsonKey(name: 'completed_tasks') int completedTasks,@JsonKey(name: 'pending_tasks') int pendingTasks,@JsonKey(name: 'overdue_tasks') int overdueTasks
});




}
/// @nodoc
class __$TaskReportItemCopyWithImpl<$Res>
    implements _$TaskReportItemCopyWith<$Res> {
  __$TaskReportItemCopyWithImpl(this._self, this._then);

  final _TaskReportItem _self;
  final $Res Function(_TaskReportItem) _then;

/// Create a copy of TaskReportItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? totalTasks = null,Object? completedTasks = null,Object? pendingTasks = null,Object? overdueTasks = null,}) {
  return _then(_TaskReportItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as int,pendingTasks: null == pendingTasks ? _self.pendingTasks : pendingTasks // ignore: cast_nullable_to_non_nullable
as int,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TaskSummaryReportsResponse {

@JsonKey(name: 'total_tasks') int get totalTasks;@JsonKey(name: 'completed_tasks') int get completedTasks;@JsonKey(name: 'pending_tasks') int get pendingTasks;@JsonKey(name: 'overdue_tasks') int get overdueTasks;@JsonKey(name: 'on_time_completion_rate') double get onTimeCompletionRate;@JsonKey(name: 'by_employee') List<TaskReportItem> get byEmployee;@JsonKey(name: 'by_department') List<TaskReportItem> get byDepartment;@JsonKey(name: 'by_client') List<TaskReportItem> get byClient;
/// Create a copy of TaskSummaryReportsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSummaryReportsResponseCopyWith<TaskSummaryReportsResponse> get copyWith => _$TaskSummaryReportsResponseCopyWithImpl<TaskSummaryReportsResponse>(this as TaskSummaryReportsResponse, _$identity);

  /// Serializes this TaskSummaryReportsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSummaryReportsResponse&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks)&&(identical(other.pendingTasks, pendingTasks) || other.pendingTasks == pendingTasks)&&(identical(other.overdueTasks, overdueTasks) || other.overdueTasks == overdueTasks)&&(identical(other.onTimeCompletionRate, onTimeCompletionRate) || other.onTimeCompletionRate == onTimeCompletionRate)&&const DeepCollectionEquality().equals(other.byEmployee, byEmployee)&&const DeepCollectionEquality().equals(other.byDepartment, byDepartment)&&const DeepCollectionEquality().equals(other.byClient, byClient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalTasks,completedTasks,pendingTasks,overdueTasks,onTimeCompletionRate,const DeepCollectionEquality().hash(byEmployee),const DeepCollectionEquality().hash(byDepartment),const DeepCollectionEquality().hash(byClient));

@override
String toString() {
  return 'TaskSummaryReportsResponse(totalTasks: $totalTasks, completedTasks: $completedTasks, pendingTasks: $pendingTasks, overdueTasks: $overdueTasks, onTimeCompletionRate: $onTimeCompletionRate, byEmployee: $byEmployee, byDepartment: $byDepartment, byClient: $byClient)';
}


}

/// @nodoc
abstract mixin class $TaskSummaryReportsResponseCopyWith<$Res>  {
  factory $TaskSummaryReportsResponseCopyWith(TaskSummaryReportsResponse value, $Res Function(TaskSummaryReportsResponse) _then) = _$TaskSummaryReportsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_tasks') int totalTasks,@JsonKey(name: 'completed_tasks') int completedTasks,@JsonKey(name: 'pending_tasks') int pendingTasks,@JsonKey(name: 'overdue_tasks') int overdueTasks,@JsonKey(name: 'on_time_completion_rate') double onTimeCompletionRate,@JsonKey(name: 'by_employee') List<TaskReportItem> byEmployee,@JsonKey(name: 'by_department') List<TaskReportItem> byDepartment,@JsonKey(name: 'by_client') List<TaskReportItem> byClient
});




}
/// @nodoc
class _$TaskSummaryReportsResponseCopyWithImpl<$Res>
    implements $TaskSummaryReportsResponseCopyWith<$Res> {
  _$TaskSummaryReportsResponseCopyWithImpl(this._self, this._then);

  final TaskSummaryReportsResponse _self;
  final $Res Function(TaskSummaryReportsResponse) _then;

/// Create a copy of TaskSummaryReportsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalTasks = null,Object? completedTasks = null,Object? pendingTasks = null,Object? overdueTasks = null,Object? onTimeCompletionRate = null,Object? byEmployee = null,Object? byDepartment = null,Object? byClient = null,}) {
  return _then(TaskSummaryReportsResponse(
totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as int,pendingTasks: null == pendingTasks ? _self.pendingTasks : pendingTasks // ignore: cast_nullable_to_non_nullable
as int,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as int,onTimeCompletionRate: null == onTimeCompletionRate ? _self.onTimeCompletionRate : onTimeCompletionRate // ignore: cast_nullable_to_non_nullable
as double,byEmployee: null == byEmployee ? _self.byEmployee : byEmployee // ignore: cast_nullable_to_non_nullable
as List<TaskReportItem>,byDepartment: null == byDepartment ? _self.byDepartment : byDepartment // ignore: cast_nullable_to_non_nullable
as List<TaskReportItem>,byClient: null == byClient ? _self.byClient : byClient // ignore: cast_nullable_to_non_nullable
as List<TaskReportItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskSummaryReportsResponse].
extension TaskSummaryReportsResponsePatterns on TaskSummaryReportsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskSummaryReportsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskSummaryReportsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskSummaryReportsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TaskSummaryReportsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskSummaryReportsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TaskSummaryReportsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_tasks')  int totalTasks, @JsonKey(name: 'completed_tasks')  int completedTasks, @JsonKey(name: 'pending_tasks')  int pendingTasks, @JsonKey(name: 'overdue_tasks')  int overdueTasks, @JsonKey(name: 'on_time_completion_rate')  double onTimeCompletionRate, @JsonKey(name: 'by_employee')  List<TaskReportItem> byEmployee, @JsonKey(name: 'by_department')  List<TaskReportItem> byDepartment, @JsonKey(name: 'by_client')  List<TaskReportItem> byClient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskSummaryReportsResponse() when $default != null:
return $default(_that.totalTasks,_that.completedTasks,_that.pendingTasks,_that.overdueTasks,_that.onTimeCompletionRate,_that.byEmployee,_that.byDepartment,_that.byClient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_tasks')  int totalTasks, @JsonKey(name: 'completed_tasks')  int completedTasks, @JsonKey(name: 'pending_tasks')  int pendingTasks, @JsonKey(name: 'overdue_tasks')  int overdueTasks, @JsonKey(name: 'on_time_completion_rate')  double onTimeCompletionRate, @JsonKey(name: 'by_employee')  List<TaskReportItem> byEmployee, @JsonKey(name: 'by_department')  List<TaskReportItem> byDepartment, @JsonKey(name: 'by_client')  List<TaskReportItem> byClient)  $default,) {final _that = this;
switch (_that) {
case _TaskSummaryReportsResponse():
return $default(_that.totalTasks,_that.completedTasks,_that.pendingTasks,_that.overdueTasks,_that.onTimeCompletionRate,_that.byEmployee,_that.byDepartment,_that.byClient);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_tasks')  int totalTasks, @JsonKey(name: 'completed_tasks')  int completedTasks, @JsonKey(name: 'pending_tasks')  int pendingTasks, @JsonKey(name: 'overdue_tasks')  int overdueTasks, @JsonKey(name: 'on_time_completion_rate')  double onTimeCompletionRate, @JsonKey(name: 'by_employee')  List<TaskReportItem> byEmployee, @JsonKey(name: 'by_department')  List<TaskReportItem> byDepartment, @JsonKey(name: 'by_client')  List<TaskReportItem> byClient)?  $default,) {final _that = this;
switch (_that) {
case _TaskSummaryReportsResponse() when $default != null:
return $default(_that.totalTasks,_that.completedTasks,_that.pendingTasks,_that.overdueTasks,_that.onTimeCompletionRate,_that.byEmployee,_that.byDepartment,_that.byClient);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskSummaryReportsResponse implements TaskSummaryReportsResponse {
  const _TaskSummaryReportsResponse({@JsonKey(name: 'total_tasks') required this.totalTasks, @JsonKey(name: 'completed_tasks') required this.completedTasks, @JsonKey(name: 'pending_tasks') required this.pendingTasks, @JsonKey(name: 'overdue_tasks') required this.overdueTasks, @JsonKey(name: 'on_time_completion_rate') required this.onTimeCompletionRate, @JsonKey(name: 'by_employee')  List<TaskReportItem> byEmployee = const <TaskReportItem>[], @JsonKey(name: 'by_department')  List<TaskReportItem> byDepartment = const <TaskReportItem>[], @JsonKey(name: 'by_client')  List<TaskReportItem> byClient = const <TaskReportItem>[]}): _byEmployee = byEmployee,_byDepartment = byDepartment,_byClient = byClient;
  factory _TaskSummaryReportsResponse.fromJson(Map<String, dynamic> json) => _$TaskSummaryReportsResponseFromJson(json);

@override@JsonKey(name: 'total_tasks') final  int totalTasks;
@override@JsonKey(name: 'completed_tasks') final  int completedTasks;
@override@JsonKey(name: 'pending_tasks') final  int pendingTasks;
@override@JsonKey(name: 'overdue_tasks') final  int overdueTasks;
@override@JsonKey(name: 'on_time_completion_rate') final  double onTimeCompletionRate;
 final  List<TaskReportItem> _byEmployee;
@override@JsonKey(name: 'by_employee') List<TaskReportItem> get byEmployee {
  if (_byEmployee is EqualUnmodifiableListView) return _byEmployee;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byEmployee);
}

 final  List<TaskReportItem> _byDepartment;
@override@JsonKey(name: 'by_department') List<TaskReportItem> get byDepartment {
  if (_byDepartment is EqualUnmodifiableListView) return _byDepartment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byDepartment);
}

 final  List<TaskReportItem> _byClient;
@override@JsonKey(name: 'by_client') List<TaskReportItem> get byClient {
  if (_byClient is EqualUnmodifiableListView) return _byClient;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byClient);
}


/// Create a copy of TaskSummaryReportsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskSummaryReportsResponseCopyWith<_TaskSummaryReportsResponse> get copyWith => __$TaskSummaryReportsResponseCopyWithImpl<_TaskSummaryReportsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskSummaryReportsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskSummaryReportsResponse&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks)&&(identical(other.pendingTasks, pendingTasks) || other.pendingTasks == pendingTasks)&&(identical(other.overdueTasks, overdueTasks) || other.overdueTasks == overdueTasks)&&(identical(other.onTimeCompletionRate, onTimeCompletionRate) || other.onTimeCompletionRate == onTimeCompletionRate)&&const DeepCollectionEquality().equals(other._byEmployee, _byEmployee)&&const DeepCollectionEquality().equals(other._byDepartment, _byDepartment)&&const DeepCollectionEquality().equals(other._byClient, _byClient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalTasks,completedTasks,pendingTasks,overdueTasks,onTimeCompletionRate,const DeepCollectionEquality().hash(_byEmployee),const DeepCollectionEquality().hash(_byDepartment),const DeepCollectionEquality().hash(_byClient));

@override
String toString() {
  return 'TaskSummaryReportsResponse(totalTasks: $totalTasks, completedTasks: $completedTasks, pendingTasks: $pendingTasks, overdueTasks: $overdueTasks, onTimeCompletionRate: $onTimeCompletionRate, byEmployee: $byEmployee, byDepartment: $byDepartment, byClient: $byClient)';
}


}

/// @nodoc
abstract mixin class _$TaskSummaryReportsResponseCopyWith<$Res> implements $TaskSummaryReportsResponseCopyWith<$Res> {
  factory _$TaskSummaryReportsResponseCopyWith(_TaskSummaryReportsResponse value, $Res Function(_TaskSummaryReportsResponse) _then) = __$TaskSummaryReportsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_tasks') int totalTasks,@JsonKey(name: 'completed_tasks') int completedTasks,@JsonKey(name: 'pending_tasks') int pendingTasks,@JsonKey(name: 'overdue_tasks') int overdueTasks,@JsonKey(name: 'on_time_completion_rate') double onTimeCompletionRate,@JsonKey(name: 'by_employee') List<TaskReportItem> byEmployee,@JsonKey(name: 'by_department') List<TaskReportItem> byDepartment,@JsonKey(name: 'by_client') List<TaskReportItem> byClient
});




}
/// @nodoc
class __$TaskSummaryReportsResponseCopyWithImpl<$Res>
    implements _$TaskSummaryReportsResponseCopyWith<$Res> {
  __$TaskSummaryReportsResponseCopyWithImpl(this._self, this._then);

  final _TaskSummaryReportsResponse _self;
  final $Res Function(_TaskSummaryReportsResponse) _then;

/// Create a copy of TaskSummaryReportsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalTasks = null,Object? completedTasks = null,Object? pendingTasks = null,Object? overdueTasks = null,Object? onTimeCompletionRate = null,Object? byEmployee = null,Object? byDepartment = null,Object? byClient = null,}) {
  return _then(_TaskSummaryReportsResponse(
totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as int,pendingTasks: null == pendingTasks ? _self.pendingTasks : pendingTasks // ignore: cast_nullable_to_non_nullable
as int,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as int,onTimeCompletionRate: null == onTimeCompletionRate ? _self.onTimeCompletionRate : onTimeCompletionRate // ignore: cast_nullable_to_non_nullable
as double,byEmployee: null == byEmployee ? _self._byEmployee : byEmployee // ignore: cast_nullable_to_non_nullable
as List<TaskReportItem>,byDepartment: null == byDepartment ? _self._byDepartment : byDepartment // ignore: cast_nullable_to_non_nullable
as List<TaskReportItem>,byClient: null == byClient ? _self._byClient : byClient // ignore: cast_nullable_to_non_nullable
as List<TaskReportItem>,
  ));
}


}


/// @nodoc
mixin _$TaskAssignRequest {

@JsonKey(name: 'assignee_ids') List<String> get assigneeIds; bool get replace;
/// Create a copy of TaskAssignRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskAssignRequestCopyWith<TaskAssignRequest> get copyWith => _$TaskAssignRequestCopyWithImpl<TaskAssignRequest>(this as TaskAssignRequest, _$identity);

  /// Serializes this TaskAssignRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskAssignRequest&&const DeepCollectionEquality().equals(other.assigneeIds, assigneeIds)&&(identical(other.replace, replace) || other.replace == replace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(assigneeIds),replace);

@override
String toString() {
  return 'TaskAssignRequest(assigneeIds: $assigneeIds, replace: $replace)';
}


}

/// @nodoc
abstract mixin class $TaskAssignRequestCopyWith<$Res>  {
  factory $TaskAssignRequestCopyWith(TaskAssignRequest value, $Res Function(TaskAssignRequest) _then) = _$TaskAssignRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'assignee_ids') List<String> assigneeIds, bool replace
});




}
/// @nodoc
class _$TaskAssignRequestCopyWithImpl<$Res>
    implements $TaskAssignRequestCopyWith<$Res> {
  _$TaskAssignRequestCopyWithImpl(this._self, this._then);

  final TaskAssignRequest _self;
  final $Res Function(TaskAssignRequest) _then;

/// Create a copy of TaskAssignRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assigneeIds = null,Object? replace = null,}) {
  return _then(TaskAssignRequest(
assigneeIds: null == assigneeIds ? _self.assigneeIds : assigneeIds // ignore: cast_nullable_to_non_nullable
as List<String>,replace: null == replace ? _self.replace : replace // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskAssignRequest].
extension TaskAssignRequestPatterns on TaskAssignRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskAssignRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskAssignRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskAssignRequest value)  $default,){
final _that = this;
switch (_that) {
case _TaskAssignRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskAssignRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TaskAssignRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'assignee_ids')  List<String> assigneeIds,  bool replace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskAssignRequest() when $default != null:
return $default(_that.assigneeIds,_that.replace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'assignee_ids')  List<String> assigneeIds,  bool replace)  $default,) {final _that = this;
switch (_that) {
case _TaskAssignRequest():
return $default(_that.assigneeIds,_that.replace);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'assignee_ids')  List<String> assigneeIds,  bool replace)?  $default,) {final _that = this;
switch (_that) {
case _TaskAssignRequest() when $default != null:
return $default(_that.assigneeIds,_that.replace);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskAssignRequest implements TaskAssignRequest {
  const _TaskAssignRequest({@JsonKey(name: 'assignee_ids') required  List<String> assigneeIds, this.replace = false}): _assigneeIds = assigneeIds;
  factory _TaskAssignRequest.fromJson(Map<String, dynamic> json) => _$TaskAssignRequestFromJson(json);

 final  List<String> _assigneeIds;
@override@JsonKey(name: 'assignee_ids') List<String> get assigneeIds {
  if (_assigneeIds is EqualUnmodifiableListView) return _assigneeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assigneeIds);
}

@override@JsonKey() final  bool replace;

/// Create a copy of TaskAssignRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskAssignRequestCopyWith<_TaskAssignRequest> get copyWith => __$TaskAssignRequestCopyWithImpl<_TaskAssignRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskAssignRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskAssignRequest&&const DeepCollectionEquality().equals(other._assigneeIds, _assigneeIds)&&(identical(other.replace, replace) || other.replace == replace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assigneeIds),replace);

@override
String toString() {
  return 'TaskAssignRequest(assigneeIds: $assigneeIds, replace: $replace)';
}


}

/// @nodoc
abstract mixin class _$TaskAssignRequestCopyWith<$Res> implements $TaskAssignRequestCopyWith<$Res> {
  factory _$TaskAssignRequestCopyWith(_TaskAssignRequest value, $Res Function(_TaskAssignRequest) _then) = __$TaskAssignRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'assignee_ids') List<String> assigneeIds, bool replace
});




}
/// @nodoc
class __$TaskAssignRequestCopyWithImpl<$Res>
    implements _$TaskAssignRequestCopyWith<$Res> {
  __$TaskAssignRequestCopyWithImpl(this._self, this._then);

  final _TaskAssignRequest _self;
  final $Res Function(_TaskAssignRequest) _then;

/// Create a copy of TaskAssignRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assigneeIds = null,Object? replace = null,}) {
  return _then(_TaskAssignRequest(
assigneeIds: null == assigneeIds ? _self._assigneeIds : assigneeIds // ignore: cast_nullable_to_non_nullable
as List<String>,replace: null == replace ? _self.replace : replace // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LeaveReviewRequest {

@JsonKey(name: 'review_note') String? get reviewNote;
/// Create a copy of LeaveReviewRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveReviewRequestCopyWith<LeaveReviewRequest> get copyWith => _$LeaveReviewRequestCopyWithImpl<LeaveReviewRequest>(this as LeaveReviewRequest, _$identity);

  /// Serializes this LeaveReviewRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveReviewRequest&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reviewNote);

@override
String toString() {
  return 'LeaveReviewRequest(reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class $LeaveReviewRequestCopyWith<$Res>  {
  factory $LeaveReviewRequestCopyWith(LeaveReviewRequest value, $Res Function(LeaveReviewRequest) _then) = _$LeaveReviewRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'review_note') String? reviewNote
});




}
/// @nodoc
class _$LeaveReviewRequestCopyWithImpl<$Res>
    implements $LeaveReviewRequestCopyWith<$Res> {
  _$LeaveReviewRequestCopyWithImpl(this._self, this._then);

  final LeaveReviewRequest _self;
  final $Res Function(LeaveReviewRequest) _then;

/// Create a copy of LeaveReviewRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviewNote = freezed,}) {
  return _then(LeaveReviewRequest(
reviewNote: freezed == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveReviewRequest].
extension LeaveReviewRequestPatterns on LeaveReviewRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveReviewRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveReviewRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveReviewRequest value)  $default,){
final _that = this;
switch (_that) {
case _LeaveReviewRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveReviewRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveReviewRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'review_note')  String? reviewNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveReviewRequest() when $default != null:
return $default(_that.reviewNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'review_note')  String? reviewNote)  $default,) {final _that = this;
switch (_that) {
case _LeaveReviewRequest():
return $default(_that.reviewNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'review_note')  String? reviewNote)?  $default,) {final _that = this;
switch (_that) {
case _LeaveReviewRequest() when $default != null:
return $default(_that.reviewNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveReviewRequest implements LeaveReviewRequest {
  const _LeaveReviewRequest({@JsonKey(name: 'review_note') this.reviewNote});
  factory _LeaveReviewRequest.fromJson(Map<String, dynamic> json) => _$LeaveReviewRequestFromJson(json);

@override@JsonKey(name: 'review_note') final  String? reviewNote;

/// Create a copy of LeaveReviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveReviewRequestCopyWith<_LeaveReviewRequest> get copyWith => __$LeaveReviewRequestCopyWithImpl<_LeaveReviewRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveReviewRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveReviewRequest&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reviewNote);

@override
String toString() {
  return 'LeaveReviewRequest(reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class _$LeaveReviewRequestCopyWith<$Res> implements $LeaveReviewRequestCopyWith<$Res> {
  factory _$LeaveReviewRequestCopyWith(_LeaveReviewRequest value, $Res Function(_LeaveReviewRequest) _then) = __$LeaveReviewRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'review_note') String? reviewNote
});




}
/// @nodoc
class __$LeaveReviewRequestCopyWithImpl<$Res>
    implements _$LeaveReviewRequestCopyWith<$Res> {
  __$LeaveReviewRequestCopyWithImpl(this._self, this._then);

  final _LeaveReviewRequest _self;
  final $Res Function(_LeaveReviewRequest) _then;

/// Create a copy of LeaveReviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviewNote = freezed,}) {
  return _then(_LeaveReviewRequest(
reviewNote: freezed == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LeaveRejectRequest {

@JsonKey(name: 'review_note') String get reviewNote;
/// Create a copy of LeaveRejectRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveRejectRequestCopyWith<LeaveRejectRequest> get copyWith => _$LeaveRejectRequestCopyWithImpl<LeaveRejectRequest>(this as LeaveRejectRequest, _$identity);

  /// Serializes this LeaveRejectRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveRejectRequest&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reviewNote);

@override
String toString() {
  return 'LeaveRejectRequest(reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class $LeaveRejectRequestCopyWith<$Res>  {
  factory $LeaveRejectRequestCopyWith(LeaveRejectRequest value, $Res Function(LeaveRejectRequest) _then) = _$LeaveRejectRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'review_note') String reviewNote
});




}
/// @nodoc
class _$LeaveRejectRequestCopyWithImpl<$Res>
    implements $LeaveRejectRequestCopyWith<$Res> {
  _$LeaveRejectRequestCopyWithImpl(this._self, this._then);

  final LeaveRejectRequest _self;
  final $Res Function(LeaveRejectRequest) _then;

/// Create a copy of LeaveRejectRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviewNote = null,}) {
  return _then(LeaveRejectRequest(
reviewNote: null == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveRejectRequest].
extension LeaveRejectRequestPatterns on LeaveRejectRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveRejectRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveRejectRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveRejectRequest value)  $default,){
final _that = this;
switch (_that) {
case _LeaveRejectRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveRejectRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveRejectRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'review_note')  String reviewNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveRejectRequest() when $default != null:
return $default(_that.reviewNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'review_note')  String reviewNote)  $default,) {final _that = this;
switch (_that) {
case _LeaveRejectRequest():
return $default(_that.reviewNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'review_note')  String reviewNote)?  $default,) {final _that = this;
switch (_that) {
case _LeaveRejectRequest() when $default != null:
return $default(_that.reviewNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveRejectRequest implements LeaveRejectRequest {
  const _LeaveRejectRequest({@JsonKey(name: 'review_note') required this.reviewNote});
  factory _LeaveRejectRequest.fromJson(Map<String, dynamic> json) => _$LeaveRejectRequestFromJson(json);

@override@JsonKey(name: 'review_note') final  String reviewNote;

/// Create a copy of LeaveRejectRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveRejectRequestCopyWith<_LeaveRejectRequest> get copyWith => __$LeaveRejectRequestCopyWithImpl<_LeaveRejectRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveRejectRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveRejectRequest&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reviewNote);

@override
String toString() {
  return 'LeaveRejectRequest(reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class _$LeaveRejectRequestCopyWith<$Res> implements $LeaveRejectRequestCopyWith<$Res> {
  factory _$LeaveRejectRequestCopyWith(_LeaveRejectRequest value, $Res Function(_LeaveRejectRequest) _then) = __$LeaveRejectRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'review_note') String reviewNote
});




}
/// @nodoc
class __$LeaveRejectRequestCopyWithImpl<$Res>
    implements _$LeaveRejectRequestCopyWith<$Res> {
  __$LeaveRejectRequestCopyWithImpl(this._self, this._then);

  final _LeaveRejectRequest _self;
  final $Res Function(_LeaveRejectRequest) _then;

/// Create a copy of LeaveRejectRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviewNote = null,}) {
  return _then(_LeaveRejectRequest(
reviewNote: null == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AnnouncementCreateRequest {

 String get title; String get body;@JsonKey(name: 'target_department_id') String? get targetDepartmentId;@JsonKey(name: 'expires_at') String? get expiresAt;
/// Create a copy of AnnouncementCreateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementCreateRequestCopyWith<AnnouncementCreateRequest> get copyWith => _$AnnouncementCreateRequestCopyWithImpl<AnnouncementCreateRequest>(this as AnnouncementCreateRequest, _$identity);

  /// Serializes this AnnouncementCreateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementCreateRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.targetDepartmentId, targetDepartmentId) || other.targetDepartmentId == targetDepartmentId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,body,targetDepartmentId,expiresAt);

@override
String toString() {
  return 'AnnouncementCreateRequest(title: $title, body: $body, targetDepartmentId: $targetDepartmentId, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $AnnouncementCreateRequestCopyWith<$Res>  {
  factory $AnnouncementCreateRequestCopyWith(AnnouncementCreateRequest value, $Res Function(AnnouncementCreateRequest) _then) = _$AnnouncementCreateRequestCopyWithImpl;
@useResult
$Res call({
 String title, String body,@JsonKey(name: 'target_department_id') String? targetDepartmentId,@JsonKey(name: 'expires_at') String? expiresAt
});




}
/// @nodoc
class _$AnnouncementCreateRequestCopyWithImpl<$Res>
    implements $AnnouncementCreateRequestCopyWith<$Res> {
  _$AnnouncementCreateRequestCopyWithImpl(this._self, this._then);

  final AnnouncementCreateRequest _self;
  final $Res Function(AnnouncementCreateRequest) _then;

/// Create a copy of AnnouncementCreateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? body = null,Object? targetDepartmentId = freezed,Object? expiresAt = freezed,}) {
  return _then(AnnouncementCreateRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,targetDepartmentId: freezed == targetDepartmentId ? _self.targetDepartmentId : targetDepartmentId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementCreateRequest].
extension AnnouncementCreateRequestPatterns on AnnouncementCreateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementCreateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementCreateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementCreateRequest value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementCreateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementCreateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementCreateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String body, @JsonKey(name: 'target_department_id')  String? targetDepartmentId, @JsonKey(name: 'expires_at')  String? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementCreateRequest() when $default != null:
return $default(_that.title,_that.body,_that.targetDepartmentId,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String body, @JsonKey(name: 'target_department_id')  String? targetDepartmentId, @JsonKey(name: 'expires_at')  String? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementCreateRequest():
return $default(_that.title,_that.body,_that.targetDepartmentId,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String body, @JsonKey(name: 'target_department_id')  String? targetDepartmentId, @JsonKey(name: 'expires_at')  String? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementCreateRequest() when $default != null:
return $default(_that.title,_that.body,_that.targetDepartmentId,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementCreateRequest implements AnnouncementCreateRequest {
  const _AnnouncementCreateRequest({required this.title, required this.body, @JsonKey(name: 'target_department_id') this.targetDepartmentId, @JsonKey(name: 'expires_at') this.expiresAt});
  factory _AnnouncementCreateRequest.fromJson(Map<String, dynamic> json) => _$AnnouncementCreateRequestFromJson(json);

@override final  String title;
@override final  String body;
@override@JsonKey(name: 'target_department_id') final  String? targetDepartmentId;
@override@JsonKey(name: 'expires_at') final  String? expiresAt;

/// Create a copy of AnnouncementCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementCreateRequestCopyWith<_AnnouncementCreateRequest> get copyWith => __$AnnouncementCreateRequestCopyWithImpl<_AnnouncementCreateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementCreateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementCreateRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.targetDepartmentId, targetDepartmentId) || other.targetDepartmentId == targetDepartmentId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,body,targetDepartmentId,expiresAt);

@override
String toString() {
  return 'AnnouncementCreateRequest(title: $title, body: $body, targetDepartmentId: $targetDepartmentId, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementCreateRequestCopyWith<$Res> implements $AnnouncementCreateRequestCopyWith<$Res> {
  factory _$AnnouncementCreateRequestCopyWith(_AnnouncementCreateRequest value, $Res Function(_AnnouncementCreateRequest) _then) = __$AnnouncementCreateRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String body,@JsonKey(name: 'target_department_id') String? targetDepartmentId,@JsonKey(name: 'expires_at') String? expiresAt
});




}
/// @nodoc
class __$AnnouncementCreateRequestCopyWithImpl<$Res>
    implements _$AnnouncementCreateRequestCopyWith<$Res> {
  __$AnnouncementCreateRequestCopyWithImpl(this._self, this._then);

  final _AnnouncementCreateRequest _self;
  final $Res Function(_AnnouncementCreateRequest) _then;

/// Create a copy of AnnouncementCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? body = null,Object? targetDepartmentId = freezed,Object? expiresAt = freezed,}) {
  return _then(_AnnouncementCreateRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,targetDepartmentId: freezed == targetDepartmentId ? _self.targetDepartmentId : targetDepartmentId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WorkReportReviewRequest {

@JsonKey(name: 'review_note') String get reviewNote; String get status;
/// Create a copy of WorkReportReviewRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkReportReviewRequestCopyWith<WorkReportReviewRequest> get copyWith => _$WorkReportReviewRequestCopyWithImpl<WorkReportReviewRequest>(this as WorkReportReviewRequest, _$identity);

  /// Serializes this WorkReportReviewRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkReportReviewRequest&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reviewNote,status);

@override
String toString() {
  return 'WorkReportReviewRequest(reviewNote: $reviewNote, status: $status)';
}


}

/// @nodoc
abstract mixin class $WorkReportReviewRequestCopyWith<$Res>  {
  factory $WorkReportReviewRequestCopyWith(WorkReportReviewRequest value, $Res Function(WorkReportReviewRequest) _then) = _$WorkReportReviewRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'review_note') String reviewNote, String status
});




}
/// @nodoc
class _$WorkReportReviewRequestCopyWithImpl<$Res>
    implements $WorkReportReviewRequestCopyWith<$Res> {
  _$WorkReportReviewRequestCopyWithImpl(this._self, this._then);

  final WorkReportReviewRequest _self;
  final $Res Function(WorkReportReviewRequest) _then;

/// Create a copy of WorkReportReviewRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviewNote = null,Object? status = null,}) {
  return _then(WorkReportReviewRequest(
reviewNote: null == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkReportReviewRequest].
extension WorkReportReviewRequestPatterns on WorkReportReviewRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkReportReviewRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkReportReviewRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkReportReviewRequest value)  $default,){
final _that = this;
switch (_that) {
case _WorkReportReviewRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkReportReviewRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WorkReportReviewRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'review_note')  String reviewNote,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkReportReviewRequest() when $default != null:
return $default(_that.reviewNote,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'review_note')  String reviewNote,  String status)  $default,) {final _that = this;
switch (_that) {
case _WorkReportReviewRequest():
return $default(_that.reviewNote,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'review_note')  String reviewNote,  String status)?  $default,) {final _that = this;
switch (_that) {
case _WorkReportReviewRequest() when $default != null:
return $default(_that.reviewNote,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkReportReviewRequest implements WorkReportReviewRequest {
  const _WorkReportReviewRequest({@JsonKey(name: 'review_note') required this.reviewNote, this.status = 'reviewed'});
  factory _WorkReportReviewRequest.fromJson(Map<String, dynamic> json) => _$WorkReportReviewRequestFromJson(json);

@override@JsonKey(name: 'review_note') final  String reviewNote;
@override@JsonKey() final  String status;

/// Create a copy of WorkReportReviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkReportReviewRequestCopyWith<_WorkReportReviewRequest> get copyWith => __$WorkReportReviewRequestCopyWithImpl<_WorkReportReviewRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkReportReviewRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkReportReviewRequest&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reviewNote,status);

@override
String toString() {
  return 'WorkReportReviewRequest(reviewNote: $reviewNote, status: $status)';
}


}

/// @nodoc
abstract mixin class _$WorkReportReviewRequestCopyWith<$Res> implements $WorkReportReviewRequestCopyWith<$Res> {
  factory _$WorkReportReviewRequestCopyWith(_WorkReportReviewRequest value, $Res Function(_WorkReportReviewRequest) _then) = __$WorkReportReviewRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'review_note') String reviewNote, String status
});




}
/// @nodoc
class __$WorkReportReviewRequestCopyWithImpl<$Res>
    implements _$WorkReportReviewRequestCopyWith<$Res> {
  __$WorkReportReviewRequestCopyWithImpl(this._self, this._then);

  final _WorkReportReviewRequest _self;
  final $Res Function(_WorkReportReviewRequest) _then;

/// Create a copy of WorkReportReviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviewNote = null,Object? status = null,}) {
  return _then(_WorkReportReviewRequest(
reviewNote: null == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MissingWorkReportUserResponse {

 String get id;@JsonKey(name: 'employee_code') String get employeeCode;@JsonKey(name: 'full_name') String get fullName; String get email;@JsonKey(name: 'department_name') String? get departmentName;
/// Create a copy of MissingWorkReportUserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissingWorkReportUserResponseCopyWith<MissingWorkReportUserResponse> get copyWith => _$MissingWorkReportUserResponseCopyWithImpl<MissingWorkReportUserResponse>(this as MissingWorkReportUserResponse, _$identity);

  /// Serializes this MissingWorkReportUserResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissingWorkReportUserResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,departmentName);

@override
String toString() {
  return 'MissingWorkReportUserResponse(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, departmentName: $departmentName)';
}


}

/// @nodoc
abstract mixin class $MissingWorkReportUserResponseCopyWith<$Res>  {
  factory $MissingWorkReportUserResponseCopyWith(MissingWorkReportUserResponse value, $Res Function(MissingWorkReportUserResponse) _then) = _$MissingWorkReportUserResponseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email,@JsonKey(name: 'department_name') String? departmentName
});




}
/// @nodoc
class _$MissingWorkReportUserResponseCopyWithImpl<$Res>
    implements $MissingWorkReportUserResponseCopyWith<$Res> {
  _$MissingWorkReportUserResponseCopyWithImpl(this._self, this._then);

  final MissingWorkReportUserResponse _self;
  final $Res Function(MissingWorkReportUserResponse) _then;

/// Create a copy of MissingWorkReportUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? departmentName = freezed,}) {
  return _then(MissingWorkReportUserResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MissingWorkReportUserResponse].
extension MissingWorkReportUserResponsePatterns on MissingWorkReportUserResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissingWorkReportUserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissingWorkReportUserResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissingWorkReportUserResponse value)  $default,){
final _that = this;
switch (_that) {
case _MissingWorkReportUserResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissingWorkReportUserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MissingWorkReportUserResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'department_name')  String? departmentName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissingWorkReportUserResponse() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.departmentName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'department_name')  String? departmentName)  $default,) {final _that = this;
switch (_that) {
case _MissingWorkReportUserResponse():
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.departmentName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'employee_code')  String employeeCode, @JsonKey(name: 'full_name')  String fullName,  String email, @JsonKey(name: 'department_name')  String? departmentName)?  $default,) {final _that = this;
switch (_that) {
case _MissingWorkReportUserResponse() when $default != null:
return $default(_that.id,_that.employeeCode,_that.fullName,_that.email,_that.departmentName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissingWorkReportUserResponse implements MissingWorkReportUserResponse {
  const _MissingWorkReportUserResponse({required this.id, @JsonKey(name: 'employee_code') required this.employeeCode, @JsonKey(name: 'full_name') required this.fullName, required this.email, @JsonKey(name: 'department_name') this.departmentName});
  factory _MissingWorkReportUserResponse.fromJson(Map<String, dynamic> json) => _$MissingWorkReportUserResponseFromJson(json);

@override final  String id;
@override@JsonKey(name: 'employee_code') final  String employeeCode;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String email;
@override@JsonKey(name: 'department_name') final  String? departmentName;

/// Create a copy of MissingWorkReportUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissingWorkReportUserResponseCopyWith<_MissingWorkReportUserResponse> get copyWith => __$MissingWorkReportUserResponseCopyWithImpl<_MissingWorkReportUserResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissingWorkReportUserResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissingWorkReportUserResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,fullName,email,departmentName);

@override
String toString() {
  return 'MissingWorkReportUserResponse(id: $id, employeeCode: $employeeCode, fullName: $fullName, email: $email, departmentName: $departmentName)';
}


}

/// @nodoc
abstract mixin class _$MissingWorkReportUserResponseCopyWith<$Res> implements $MissingWorkReportUserResponseCopyWith<$Res> {
  factory _$MissingWorkReportUserResponseCopyWith(_MissingWorkReportUserResponse value, $Res Function(_MissingWorkReportUserResponse) _then) = __$MissingWorkReportUserResponseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'employee_code') String employeeCode,@JsonKey(name: 'full_name') String fullName, String email,@JsonKey(name: 'department_name') String? departmentName
});




}
/// @nodoc
class __$MissingWorkReportUserResponseCopyWithImpl<$Res>
    implements _$MissingWorkReportUserResponseCopyWith<$Res> {
  __$MissingWorkReportUserResponseCopyWithImpl(this._self, this._then);

  final _MissingWorkReportUserResponse _self;
  final $Res Function(_MissingWorkReportUserResponse) _then;

/// Create a copy of MissingWorkReportUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? fullName = null,Object? email = null,Object? departmentName = freezed,}) {
  return _then(_MissingWorkReportUserResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MissingWorkReportListResponse {

@JsonKey(name: 'report_date') String get reportDate;@JsonKey(name: 'missing_count') int get missingCount; List<MissingWorkReportUserResponse> get users;
/// Create a copy of MissingWorkReportListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissingWorkReportListResponseCopyWith<MissingWorkReportListResponse> get copyWith => _$MissingWorkReportListResponseCopyWithImpl<MissingWorkReportListResponse>(this as MissingWorkReportListResponse, _$identity);

  /// Serializes this MissingWorkReportListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissingWorkReportListResponse&&(identical(other.reportDate, reportDate) || other.reportDate == reportDate)&&(identical(other.missingCount, missingCount) || other.missingCount == missingCount)&&const DeepCollectionEquality().equals(other.users, users));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportDate,missingCount,const DeepCollectionEquality().hash(users));

@override
String toString() {
  return 'MissingWorkReportListResponse(reportDate: $reportDate, missingCount: $missingCount, users: $users)';
}


}

/// @nodoc
abstract mixin class $MissingWorkReportListResponseCopyWith<$Res>  {
  factory $MissingWorkReportListResponseCopyWith(MissingWorkReportListResponse value, $Res Function(MissingWorkReportListResponse) _then) = _$MissingWorkReportListResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'report_date') String reportDate,@JsonKey(name: 'missing_count') int missingCount, List<MissingWorkReportUserResponse> users
});




}
/// @nodoc
class _$MissingWorkReportListResponseCopyWithImpl<$Res>
    implements $MissingWorkReportListResponseCopyWith<$Res> {
  _$MissingWorkReportListResponseCopyWithImpl(this._self, this._then);

  final MissingWorkReportListResponse _self;
  final $Res Function(MissingWorkReportListResponse) _then;

/// Create a copy of MissingWorkReportListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportDate = null,Object? missingCount = null,Object? users = null,}) {
  return _then(MissingWorkReportListResponse(
reportDate: null == reportDate ? _self.reportDate : reportDate // ignore: cast_nullable_to_non_nullable
as String,missingCount: null == missingCount ? _self.missingCount : missingCount // ignore: cast_nullable_to_non_nullable
as int,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<MissingWorkReportUserResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [MissingWorkReportListResponse].
extension MissingWorkReportListResponsePatterns on MissingWorkReportListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissingWorkReportListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissingWorkReportListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissingWorkReportListResponse value)  $default,){
final _that = this;
switch (_that) {
case _MissingWorkReportListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissingWorkReportListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MissingWorkReportListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'report_date')  String reportDate, @JsonKey(name: 'missing_count')  int missingCount,  List<MissingWorkReportUserResponse> users)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissingWorkReportListResponse() when $default != null:
return $default(_that.reportDate,_that.missingCount,_that.users);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'report_date')  String reportDate, @JsonKey(name: 'missing_count')  int missingCount,  List<MissingWorkReportUserResponse> users)  $default,) {final _that = this;
switch (_that) {
case _MissingWorkReportListResponse():
return $default(_that.reportDate,_that.missingCount,_that.users);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'report_date')  String reportDate, @JsonKey(name: 'missing_count')  int missingCount,  List<MissingWorkReportUserResponse> users)?  $default,) {final _that = this;
switch (_that) {
case _MissingWorkReportListResponse() when $default != null:
return $default(_that.reportDate,_that.missingCount,_that.users);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissingWorkReportListResponse implements MissingWorkReportListResponse {
  const _MissingWorkReportListResponse({@JsonKey(name: 'report_date') required this.reportDate, @JsonKey(name: 'missing_count') required this.missingCount,  List<MissingWorkReportUserResponse> users = const <MissingWorkReportUserResponse>[]}): _users = users;
  factory _MissingWorkReportListResponse.fromJson(Map<String, dynamic> json) => _$MissingWorkReportListResponseFromJson(json);

@override@JsonKey(name: 'report_date') final  String reportDate;
@override@JsonKey(name: 'missing_count') final  int missingCount;
 final  List<MissingWorkReportUserResponse> _users;
@override@JsonKey() List<MissingWorkReportUserResponse> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of MissingWorkReportListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissingWorkReportListResponseCopyWith<_MissingWorkReportListResponse> get copyWith => __$MissingWorkReportListResponseCopyWithImpl<_MissingWorkReportListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissingWorkReportListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissingWorkReportListResponse&&(identical(other.reportDate, reportDate) || other.reportDate == reportDate)&&(identical(other.missingCount, missingCount) || other.missingCount == missingCount)&&const DeepCollectionEquality().equals(other._users, _users));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportDate,missingCount,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'MissingWorkReportListResponse(reportDate: $reportDate, missingCount: $missingCount, users: $users)';
}


}

/// @nodoc
abstract mixin class _$MissingWorkReportListResponseCopyWith<$Res> implements $MissingWorkReportListResponseCopyWith<$Res> {
  factory _$MissingWorkReportListResponseCopyWith(_MissingWorkReportListResponse value, $Res Function(_MissingWorkReportListResponse) _then) = __$MissingWorkReportListResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'report_date') String reportDate,@JsonKey(name: 'missing_count') int missingCount, List<MissingWorkReportUserResponse> users
});




}
/// @nodoc
class __$MissingWorkReportListResponseCopyWithImpl<$Res>
    implements _$MissingWorkReportListResponseCopyWith<$Res> {
  __$MissingWorkReportListResponseCopyWithImpl(this._self, this._then);

  final _MissingWorkReportListResponse _self;
  final $Res Function(_MissingWorkReportListResponse) _then;

/// Create a copy of MissingWorkReportListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportDate = null,Object? missingCount = null,Object? users = null,}) {
  return _then(_MissingWorkReportListResponse(
reportDate: null == reportDate ? _self.reportDate : reportDate // ignore: cast_nullable_to_non_nullable
as String,missingCount: null == missingCount ? _self.missingCount : missingCount // ignore: cast_nullable_to_non_nullable
as int,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<MissingWorkReportUserResponse>,
  ));
}


}

// dart format on
