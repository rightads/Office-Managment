// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_import_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BulkImportState {

 bool get isUploading; bool get dryRun; BulkImportReport? get report; String? get errorMessage; String? get selectedFileName; List<int>? get selectedFileBytes;
/// Create a copy of BulkImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkImportStateCopyWith<BulkImportState> get copyWith => _$BulkImportStateCopyWithImpl<BulkImportState>(this as BulkImportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkImportState&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&(identical(other.report, report) || other.report == report)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedFileName, selectedFileName) || other.selectedFileName == selectedFileName)&&const DeepCollectionEquality().equals(other.selectedFileBytes, selectedFileBytes));
}


@override
int get hashCode => Object.hash(runtimeType,isUploading,dryRun,report,errorMessage,selectedFileName,const DeepCollectionEquality().hash(selectedFileBytes));

@override
String toString() {
  return 'BulkImportState(isUploading: $isUploading, dryRun: $dryRun, report: $report, errorMessage: $errorMessage, selectedFileName: $selectedFileName, selectedFileBytes: $selectedFileBytes)';
}


}

/// @nodoc
abstract mixin class $BulkImportStateCopyWith<$Res>  {
  factory $BulkImportStateCopyWith(BulkImportState value, $Res Function(BulkImportState) _then) = _$BulkImportStateCopyWithImpl;
@useResult
$Res call({
 bool isUploading, bool dryRun, BulkImportReport? report, String? errorMessage, String? selectedFileName, List<int>? selectedFileBytes
});


$BulkImportReportCopyWith<$Res>? get report;

}
/// @nodoc
class _$BulkImportStateCopyWithImpl<$Res>
    implements $BulkImportStateCopyWith<$Res> {
  _$BulkImportStateCopyWithImpl(this._self, this._then);

  final BulkImportState _self;
  final $Res Function(BulkImportState) _then;

/// Create a copy of BulkImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isUploading = null,Object? dryRun = null,Object? report = freezed,Object? errorMessage = freezed,Object? selectedFileName = freezed,Object? selectedFileBytes = freezed,}) {
  return _then(BulkImportState(
isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as BulkImportReport?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedFileName: freezed == selectedFileName ? _self.selectedFileName : selectedFileName // ignore: cast_nullable_to_non_nullable
as String?,selectedFileBytes: freezed == selectedFileBytes ? _self.selectedFileBytes : selectedFileBytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}
/// Create a copy of BulkImportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BulkImportReportCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $BulkImportReportCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}


/// Adds pattern-matching-related methods to [BulkImportState].
extension BulkImportStatePatterns on BulkImportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BulkImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BulkImportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BulkImportState value)  $default,){
final _that = this;
switch (_that) {
case _BulkImportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BulkImportState value)?  $default,){
final _that = this;
switch (_that) {
case _BulkImportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isUploading,  bool dryRun,  BulkImportReport? report,  String? errorMessage,  String? selectedFileName,  List<int>? selectedFileBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BulkImportState() when $default != null:
return $default(_that.isUploading,_that.dryRun,_that.report,_that.errorMessage,_that.selectedFileName,_that.selectedFileBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isUploading,  bool dryRun,  BulkImportReport? report,  String? errorMessage,  String? selectedFileName,  List<int>? selectedFileBytes)  $default,) {final _that = this;
switch (_that) {
case _BulkImportState():
return $default(_that.isUploading,_that.dryRun,_that.report,_that.errorMessage,_that.selectedFileName,_that.selectedFileBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isUploading,  bool dryRun,  BulkImportReport? report,  String? errorMessage,  String? selectedFileName,  List<int>? selectedFileBytes)?  $default,) {final _that = this;
switch (_that) {
case _BulkImportState() when $default != null:
return $default(_that.isUploading,_that.dryRun,_that.report,_that.errorMessage,_that.selectedFileName,_that.selectedFileBytes);case _:
  return null;

}
}

}

/// @nodoc


class _BulkImportState implements BulkImportState {
  const _BulkImportState({this.isUploading = false, this.dryRun = false, this.report, this.errorMessage, this.selectedFileName,  List<int>? selectedFileBytes}): _selectedFileBytes = selectedFileBytes;
  

@override@JsonKey() final  bool isUploading;
@override@JsonKey() final  bool dryRun;
@override final  BulkImportReport? report;
@override final  String? errorMessage;
@override final  String? selectedFileName;
 final  List<int>? _selectedFileBytes;
@override List<int>? get selectedFileBytes {
  final value = _selectedFileBytes;
  if (value == null) return null;
  if (_selectedFileBytes is EqualUnmodifiableListView) return _selectedFileBytes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BulkImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkImportStateCopyWith<_BulkImportState> get copyWith => __$BulkImportStateCopyWithImpl<_BulkImportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkImportState&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&(identical(other.report, report) || other.report == report)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedFileName, selectedFileName) || other.selectedFileName == selectedFileName)&&const DeepCollectionEquality().equals(other._selectedFileBytes, _selectedFileBytes));
}


@override
int get hashCode => Object.hash(runtimeType,isUploading,dryRun,report,errorMessage,selectedFileName,const DeepCollectionEquality().hash(_selectedFileBytes));

@override
String toString() {
  return 'BulkImportState(isUploading: $isUploading, dryRun: $dryRun, report: $report, errorMessage: $errorMessage, selectedFileName: $selectedFileName, selectedFileBytes: $selectedFileBytes)';
}


}

/// @nodoc
abstract mixin class _$BulkImportStateCopyWith<$Res> implements $BulkImportStateCopyWith<$Res> {
  factory _$BulkImportStateCopyWith(_BulkImportState value, $Res Function(_BulkImportState) _then) = __$BulkImportStateCopyWithImpl;
@override @useResult
$Res call({
 bool isUploading, bool dryRun, BulkImportReport? report, String? errorMessage, String? selectedFileName, List<int>? selectedFileBytes
});


@override $BulkImportReportCopyWith<$Res>? get report;

}
/// @nodoc
class __$BulkImportStateCopyWithImpl<$Res>
    implements _$BulkImportStateCopyWith<$Res> {
  __$BulkImportStateCopyWithImpl(this._self, this._then);

  final _BulkImportState _self;
  final $Res Function(_BulkImportState) _then;

/// Create a copy of BulkImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isUploading = null,Object? dryRun = null,Object? report = freezed,Object? errorMessage = freezed,Object? selectedFileName = freezed,Object? selectedFileBytes = freezed,}) {
  return _then(_BulkImportState(
isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as BulkImportReport?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedFileName: freezed == selectedFileName ? _self.selectedFileName : selectedFileName // ignore: cast_nullable_to_non_nullable
as String?,selectedFileBytes: freezed == selectedFileBytes ? _self._selectedFileBytes : selectedFileBytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

/// Create a copy of BulkImportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BulkImportReportCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $BulkImportReportCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

// dart format on
