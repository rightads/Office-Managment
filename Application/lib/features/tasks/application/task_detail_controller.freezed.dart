// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_detail_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskDetailState {

 AsyncValue<TaskItemModel> get task; List<TaskActivityModel> get timeline; List<TaskCommentModel> get comments; List<TaskAttachmentModel> get attachments; bool get isChangingStatus; bool get isPostingComment; bool get isUploadingAttachment; double? get uploadProgress; bool get isDownloading; double? get downloadProgress; String? get errorMessage;
/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDetailStateCopyWith<TaskDetailState> get copyWith => _$TaskDetailStateCopyWithImpl<TaskDetailState>(this as TaskDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailState&&(identical(other.task, task) || other.task == task)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&const DeepCollectionEquality().equals(other.comments, comments)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&(identical(other.isChangingStatus, isChangingStatus) || other.isChangingStatus == isChangingStatus)&&(identical(other.isPostingComment, isPostingComment) || other.isPostingComment == isPostingComment)&&(identical(other.isUploadingAttachment, isUploadingAttachment) || other.isUploadingAttachment == isUploadingAttachment)&&(identical(other.uploadProgress, uploadProgress) || other.uploadProgress == uploadProgress)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,task,const DeepCollectionEquality().hash(timeline),const DeepCollectionEquality().hash(comments),const DeepCollectionEquality().hash(attachments),isChangingStatus,isPostingComment,isUploadingAttachment,uploadProgress,isDownloading,downloadProgress,errorMessage);

@override
String toString() {
  return 'TaskDetailState(task: $task, timeline: $timeline, comments: $comments, attachments: $attachments, isChangingStatus: $isChangingStatus, isPostingComment: $isPostingComment, isUploadingAttachment: $isUploadingAttachment, uploadProgress: $uploadProgress, isDownloading: $isDownloading, downloadProgress: $downloadProgress, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TaskDetailStateCopyWith<$Res>  {
  factory $TaskDetailStateCopyWith(TaskDetailState value, $Res Function(TaskDetailState) _then) = _$TaskDetailStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<TaskItemModel> task, List<TaskActivityModel> timeline, List<TaskCommentModel> comments, List<TaskAttachmentModel> attachments, bool isChangingStatus, bool isPostingComment, bool isUploadingAttachment, double? uploadProgress, bool isDownloading, double? downloadProgress, String? errorMessage
});




}
/// @nodoc
class _$TaskDetailStateCopyWithImpl<$Res>
    implements $TaskDetailStateCopyWith<$Res> {
  _$TaskDetailStateCopyWithImpl(this._self, this._then);

  final TaskDetailState _self;
  final $Res Function(TaskDetailState) _then;

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? task = null,Object? timeline = null,Object? comments = null,Object? attachments = null,Object? isChangingStatus = null,Object? isPostingComment = null,Object? isUploadingAttachment = null,Object? uploadProgress = freezed,Object? isDownloading = null,Object? downloadProgress = freezed,Object? errorMessage = freezed,}) {
  return _then(TaskDetailState(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as AsyncValue<TaskItemModel>,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TaskActivityModel>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<TaskCommentModel>,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TaskAttachmentModel>,isChangingStatus: null == isChangingStatus ? _self.isChangingStatus : isChangingStatus // ignore: cast_nullable_to_non_nullable
as bool,isPostingComment: null == isPostingComment ? _self.isPostingComment : isPostingComment // ignore: cast_nullable_to_non_nullable
as bool,isUploadingAttachment: null == isUploadingAttachment ? _self.isUploadingAttachment : isUploadingAttachment // ignore: cast_nullable_to_non_nullable
as bool,uploadProgress: freezed == uploadProgress ? _self.uploadProgress : uploadProgress // ignore: cast_nullable_to_non_nullable
as double?,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: freezed == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskDetailState].
extension TaskDetailStatePatterns on TaskDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskDetailState value)  $default,){
final _that = this;
switch (_that) {
case _TaskDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<TaskItemModel> task,  List<TaskActivityModel> timeline,  List<TaskCommentModel> comments,  List<TaskAttachmentModel> attachments,  bool isChangingStatus,  bool isPostingComment,  bool isUploadingAttachment,  double? uploadProgress,  bool isDownloading,  double? downloadProgress,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
return $default(_that.task,_that.timeline,_that.comments,_that.attachments,_that.isChangingStatus,_that.isPostingComment,_that.isUploadingAttachment,_that.uploadProgress,_that.isDownloading,_that.downloadProgress,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<TaskItemModel> task,  List<TaskActivityModel> timeline,  List<TaskCommentModel> comments,  List<TaskAttachmentModel> attachments,  bool isChangingStatus,  bool isPostingComment,  bool isUploadingAttachment,  double? uploadProgress,  bool isDownloading,  double? downloadProgress,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TaskDetailState():
return $default(_that.task,_that.timeline,_that.comments,_that.attachments,_that.isChangingStatus,_that.isPostingComment,_that.isUploadingAttachment,_that.uploadProgress,_that.isDownloading,_that.downloadProgress,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<TaskItemModel> task,  List<TaskActivityModel> timeline,  List<TaskCommentModel> comments,  List<TaskAttachmentModel> attachments,  bool isChangingStatus,  bool isPostingComment,  bool isUploadingAttachment,  double? uploadProgress,  bool isDownloading,  double? downloadProgress,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TaskDetailState() when $default != null:
return $default(_that.task,_that.timeline,_that.comments,_that.attachments,_that.isChangingStatus,_that.isPostingComment,_that.isUploadingAttachment,_that.uploadProgress,_that.isDownloading,_that.downloadProgress,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TaskDetailState implements TaskDetailState {
  const _TaskDetailState({required this.task,  List<TaskActivityModel> timeline = const <TaskActivityModel>[],  List<TaskCommentModel> comments = const <TaskCommentModel>[],  List<TaskAttachmentModel> attachments = const <TaskAttachmentModel>[], this.isChangingStatus = false, this.isPostingComment = false, this.isUploadingAttachment = false, this.uploadProgress, this.isDownloading = false, this.downloadProgress, this.errorMessage}): _timeline = timeline,_comments = comments,_attachments = attachments;
  

@override final  AsyncValue<TaskItemModel> task;
 final  List<TaskActivityModel> _timeline;
@override@JsonKey() List<TaskActivityModel> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

 final  List<TaskCommentModel> _comments;
@override@JsonKey() List<TaskCommentModel> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  List<TaskAttachmentModel> _attachments;
@override@JsonKey() List<TaskAttachmentModel> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override@JsonKey() final  bool isChangingStatus;
@override@JsonKey() final  bool isPostingComment;
@override@JsonKey() final  bool isUploadingAttachment;
@override final  double? uploadProgress;
@override@JsonKey() final  bool isDownloading;
@override final  double? downloadProgress;
@override final  String? errorMessage;

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskDetailStateCopyWith<_TaskDetailState> get copyWith => __$TaskDetailStateCopyWithImpl<_TaskDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskDetailState&&(identical(other.task, task) || other.task == task)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&const DeepCollectionEquality().equals(other._comments, _comments)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&(identical(other.isChangingStatus, isChangingStatus) || other.isChangingStatus == isChangingStatus)&&(identical(other.isPostingComment, isPostingComment) || other.isPostingComment == isPostingComment)&&(identical(other.isUploadingAttachment, isUploadingAttachment) || other.isUploadingAttachment == isUploadingAttachment)&&(identical(other.uploadProgress, uploadProgress) || other.uploadProgress == uploadProgress)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,task,const DeepCollectionEquality().hash(_timeline),const DeepCollectionEquality().hash(_comments),const DeepCollectionEquality().hash(_attachments),isChangingStatus,isPostingComment,isUploadingAttachment,uploadProgress,isDownloading,downloadProgress,errorMessage);

@override
String toString() {
  return 'TaskDetailState(task: $task, timeline: $timeline, comments: $comments, attachments: $attachments, isChangingStatus: $isChangingStatus, isPostingComment: $isPostingComment, isUploadingAttachment: $isUploadingAttachment, uploadProgress: $uploadProgress, isDownloading: $isDownloading, downloadProgress: $downloadProgress, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TaskDetailStateCopyWith<$Res> implements $TaskDetailStateCopyWith<$Res> {
  factory _$TaskDetailStateCopyWith(_TaskDetailState value, $Res Function(_TaskDetailState) _then) = __$TaskDetailStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<TaskItemModel> task, List<TaskActivityModel> timeline, List<TaskCommentModel> comments, List<TaskAttachmentModel> attachments, bool isChangingStatus, bool isPostingComment, bool isUploadingAttachment, double? uploadProgress, bool isDownloading, double? downloadProgress, String? errorMessage
});




}
/// @nodoc
class __$TaskDetailStateCopyWithImpl<$Res>
    implements _$TaskDetailStateCopyWith<$Res> {
  __$TaskDetailStateCopyWithImpl(this._self, this._then);

  final _TaskDetailState _self;
  final $Res Function(_TaskDetailState) _then;

/// Create a copy of TaskDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? task = null,Object? timeline = null,Object? comments = null,Object? attachments = null,Object? isChangingStatus = null,Object? isPostingComment = null,Object? isUploadingAttachment = null,Object? uploadProgress = freezed,Object? isDownloading = null,Object? downloadProgress = freezed,Object? errorMessage = freezed,}) {
  return _then(_TaskDetailState(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as AsyncValue<TaskItemModel>,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TaskActivityModel>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<TaskCommentModel>,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TaskAttachmentModel>,isChangingStatus: null == isChangingStatus ? _self.isChangingStatus : isChangingStatus // ignore: cast_nullable_to_non_nullable
as bool,isPostingComment: null == isPostingComment ? _self.isPostingComment : isPostingComment // ignore: cast_nullable_to_non_nullable
as bool,isUploadingAttachment: null == isUploadingAttachment ? _self.isUploadingAttachment : isUploadingAttachment // ignore: cast_nullable_to_non_nullable
as bool,uploadProgress: freezed == uploadProgress ? _self.uploadProgress : uploadProgress // ignore: cast_nullable_to_non_nullable
as double?,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: freezed == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
