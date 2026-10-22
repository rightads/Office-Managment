// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'super_admin_controllers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SuperAdminRolesState {

 List<RoleDetailModel> get roles; List<PermissionModel> get permissions; bool get isLoading; bool get isSaving; String? get errorMessage;
/// Create a copy of SuperAdminRolesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuperAdminRolesStateCopyWith<SuperAdminRolesState> get copyWith => _$SuperAdminRolesStateCopyWithImpl<SuperAdminRolesState>(this as SuperAdminRolesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuperAdminRolesState&&const DeepCollectionEquality().equals(other.roles, roles)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(roles),const DeepCollectionEquality().hash(permissions),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'SuperAdminRolesState(roles: $roles, permissions: $permissions, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuperAdminRolesStateCopyWith<$Res>  {
  factory $SuperAdminRolesStateCopyWith(SuperAdminRolesState value, $Res Function(SuperAdminRolesState) _then) = _$SuperAdminRolesStateCopyWithImpl;
@useResult
$Res call({
 List<RoleDetailModel> roles, List<PermissionModel> permissions, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class _$SuperAdminRolesStateCopyWithImpl<$Res>
    implements $SuperAdminRolesStateCopyWith<$Res> {
  _$SuperAdminRolesStateCopyWithImpl(this._self, this._then);

  final SuperAdminRolesState _self;
  final $Res Function(SuperAdminRolesState) _then;

/// Create a copy of SuperAdminRolesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roles = null,Object? permissions = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(SuperAdminRolesState(
roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<RoleDetailModel>,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<PermissionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuperAdminRolesState].
extension SuperAdminRolesStatePatterns on SuperAdminRolesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuperAdminRolesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuperAdminRolesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuperAdminRolesState value)  $default,){
final _that = this;
switch (_that) {
case _SuperAdminRolesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuperAdminRolesState value)?  $default,){
final _that = this;
switch (_that) {
case _SuperAdminRolesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RoleDetailModel> roles,  List<PermissionModel> permissions,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuperAdminRolesState() when $default != null:
return $default(_that.roles,_that.permissions,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RoleDetailModel> roles,  List<PermissionModel> permissions,  bool isLoading,  bool isSaving,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SuperAdminRolesState():
return $default(_that.roles,_that.permissions,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RoleDetailModel> roles,  List<PermissionModel> permissions,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SuperAdminRolesState() when $default != null:
return $default(_that.roles,_that.permissions,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SuperAdminRolesState implements SuperAdminRolesState {
  const _SuperAdminRolesState({ List<RoleDetailModel> roles = const <RoleDetailModel>[],  List<PermissionModel> permissions = const <PermissionModel>[], this.isLoading = true, this.isSaving = false, this.errorMessage}): _roles = roles,_permissions = permissions;
  

 final  List<RoleDetailModel> _roles;
@override@JsonKey() List<RoleDetailModel> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  List<PermissionModel> _permissions;
@override@JsonKey() List<PermissionModel> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;

/// Create a copy of SuperAdminRolesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuperAdminRolesStateCopyWith<_SuperAdminRolesState> get copyWith => __$SuperAdminRolesStateCopyWithImpl<_SuperAdminRolesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuperAdminRolesState&&const DeepCollectionEquality().equals(other._roles, _roles)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_permissions),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'SuperAdminRolesState(roles: $roles, permissions: $permissions, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SuperAdminRolesStateCopyWith<$Res> implements $SuperAdminRolesStateCopyWith<$Res> {
  factory _$SuperAdminRolesStateCopyWith(_SuperAdminRolesState value, $Res Function(_SuperAdminRolesState) _then) = __$SuperAdminRolesStateCopyWithImpl;
@override @useResult
$Res call({
 List<RoleDetailModel> roles, List<PermissionModel> permissions, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class __$SuperAdminRolesStateCopyWithImpl<$Res>
    implements _$SuperAdminRolesStateCopyWith<$Res> {
  __$SuperAdminRolesStateCopyWithImpl(this._self, this._then);

  final _SuperAdminRolesState _self;
  final $Res Function(_SuperAdminRolesState) _then;

/// Create a copy of SuperAdminRolesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roles = null,Object? permissions = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_SuperAdminRolesState(
roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<RoleDetailModel>,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<PermissionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SuperAdminSettingsState {

 List<SystemSettingModel> get settings; bool get isLoading; bool get isSaving; String? get errorMessage;
/// Create a copy of SuperAdminSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuperAdminSettingsStateCopyWith<SuperAdminSettingsState> get copyWith => _$SuperAdminSettingsStateCopyWithImpl<SuperAdminSettingsState>(this as SuperAdminSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuperAdminSettingsState&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(settings),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'SuperAdminSettingsState(settings: $settings, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuperAdminSettingsStateCopyWith<$Res>  {
  factory $SuperAdminSettingsStateCopyWith(SuperAdminSettingsState value, $Res Function(SuperAdminSettingsState) _then) = _$SuperAdminSettingsStateCopyWithImpl;
@useResult
$Res call({
 List<SystemSettingModel> settings, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class _$SuperAdminSettingsStateCopyWithImpl<$Res>
    implements $SuperAdminSettingsStateCopyWith<$Res> {
  _$SuperAdminSettingsStateCopyWithImpl(this._self, this._then);

  final SuperAdminSettingsState _self;
  final $Res Function(SuperAdminSettingsState) _then;

/// Create a copy of SuperAdminSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(SuperAdminSettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as List<SystemSettingModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuperAdminSettingsState].
extension SuperAdminSettingsStatePatterns on SuperAdminSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuperAdminSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuperAdminSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuperAdminSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SuperAdminSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuperAdminSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SuperAdminSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SystemSettingModel> settings,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuperAdminSettingsState() when $default != null:
return $default(_that.settings,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SystemSettingModel> settings,  bool isLoading,  bool isSaving,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SuperAdminSettingsState():
return $default(_that.settings,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SystemSettingModel> settings,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SuperAdminSettingsState() when $default != null:
return $default(_that.settings,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SuperAdminSettingsState implements SuperAdminSettingsState {
  const _SuperAdminSettingsState({ List<SystemSettingModel> settings = const <SystemSettingModel>[], this.isLoading = true, this.isSaving = false, this.errorMessage}): _settings = settings;
  

 final  List<SystemSettingModel> _settings;
@override@JsonKey() List<SystemSettingModel> get settings {
  if (_settings is EqualUnmodifiableListView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settings);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;

/// Create a copy of SuperAdminSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuperAdminSettingsStateCopyWith<_SuperAdminSettingsState> get copyWith => __$SuperAdminSettingsStateCopyWithImpl<_SuperAdminSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuperAdminSettingsState&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_settings),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'SuperAdminSettingsState(settings: $settings, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SuperAdminSettingsStateCopyWith<$Res> implements $SuperAdminSettingsStateCopyWith<$Res> {
  factory _$SuperAdminSettingsStateCopyWith(_SuperAdminSettingsState value, $Res Function(_SuperAdminSettingsState) _then) = __$SuperAdminSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 List<SystemSettingModel> settings, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class __$SuperAdminSettingsStateCopyWithImpl<$Res>
    implements _$SuperAdminSettingsStateCopyWith<$Res> {
  __$SuperAdminSettingsStateCopyWithImpl(this._self, this._then);

  final _SuperAdminSettingsState _self;
  final $Res Function(_SuperAdminSettingsState) _then;

/// Create a copy of SuperAdminSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_SuperAdminSettingsState(
settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as List<SystemSettingModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SuperAdminAuditState {

 List<AuditLogItemModel> get logs; int get page; int get total; bool get isLoading; String? get filterActorId; String? get filterEntityType; String? get filterAction; String? get errorMessage;
/// Create a copy of SuperAdminAuditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuperAdminAuditStateCopyWith<SuperAdminAuditState> get copyWith => _$SuperAdminAuditStateCopyWithImpl<SuperAdminAuditState>(this as SuperAdminAuditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuperAdminAuditState&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.filterActorId, filterActorId) || other.filterActorId == filterActorId)&&(identical(other.filterEntityType, filterEntityType) || other.filterEntityType == filterEntityType)&&(identical(other.filterAction, filterAction) || other.filterAction == filterAction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(logs),page,total,isLoading,filterActorId,filterEntityType,filterAction,errorMessage);

@override
String toString() {
  return 'SuperAdminAuditState(logs: $logs, page: $page, total: $total, isLoading: $isLoading, filterActorId: $filterActorId, filterEntityType: $filterEntityType, filterAction: $filterAction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuperAdminAuditStateCopyWith<$Res>  {
  factory $SuperAdminAuditStateCopyWith(SuperAdminAuditState value, $Res Function(SuperAdminAuditState) _then) = _$SuperAdminAuditStateCopyWithImpl;
@useResult
$Res call({
 List<AuditLogItemModel> logs, int page, int total, bool isLoading, String? filterActorId, String? filterEntityType, String? filterAction, String? errorMessage
});




}
/// @nodoc
class _$SuperAdminAuditStateCopyWithImpl<$Res>
    implements $SuperAdminAuditStateCopyWith<$Res> {
  _$SuperAdminAuditStateCopyWithImpl(this._self, this._then);

  final SuperAdminAuditState _self;
  final $Res Function(SuperAdminAuditState) _then;

/// Create a copy of SuperAdminAuditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logs = null,Object? page = null,Object? total = null,Object? isLoading = null,Object? filterActorId = freezed,Object? filterEntityType = freezed,Object? filterAction = freezed,Object? errorMessage = freezed,}) {
  return _then(SuperAdminAuditState(
logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<AuditLogItemModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,filterActorId: freezed == filterActorId ? _self.filterActorId : filterActorId // ignore: cast_nullable_to_non_nullable
as String?,filterEntityType: freezed == filterEntityType ? _self.filterEntityType : filterEntityType // ignore: cast_nullable_to_non_nullable
as String?,filterAction: freezed == filterAction ? _self.filterAction : filterAction // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuperAdminAuditState].
extension SuperAdminAuditStatePatterns on SuperAdminAuditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuperAdminAuditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuperAdminAuditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuperAdminAuditState value)  $default,){
final _that = this;
switch (_that) {
case _SuperAdminAuditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuperAdminAuditState value)?  $default,){
final _that = this;
switch (_that) {
case _SuperAdminAuditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AuditLogItemModel> logs,  int page,  int total,  bool isLoading,  String? filterActorId,  String? filterEntityType,  String? filterAction,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuperAdminAuditState() when $default != null:
return $default(_that.logs,_that.page,_that.total,_that.isLoading,_that.filterActorId,_that.filterEntityType,_that.filterAction,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AuditLogItemModel> logs,  int page,  int total,  bool isLoading,  String? filterActorId,  String? filterEntityType,  String? filterAction,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SuperAdminAuditState():
return $default(_that.logs,_that.page,_that.total,_that.isLoading,_that.filterActorId,_that.filterEntityType,_that.filterAction,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AuditLogItemModel> logs,  int page,  int total,  bool isLoading,  String? filterActorId,  String? filterEntityType,  String? filterAction,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SuperAdminAuditState() when $default != null:
return $default(_that.logs,_that.page,_that.total,_that.isLoading,_that.filterActorId,_that.filterEntityType,_that.filterAction,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SuperAdminAuditState implements SuperAdminAuditState {
  const _SuperAdminAuditState({ List<AuditLogItemModel> logs = const <AuditLogItemModel>[], this.page = 1, this.total = 0, this.isLoading = true, this.filterActorId, this.filterEntityType, this.filterAction, this.errorMessage}): _logs = logs;
  

 final  List<AuditLogItemModel> _logs;
@override@JsonKey() List<AuditLogItemModel> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int total;
@override@JsonKey() final  bool isLoading;
@override final  String? filterActorId;
@override final  String? filterEntityType;
@override final  String? filterAction;
@override final  String? errorMessage;

/// Create a copy of SuperAdminAuditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuperAdminAuditStateCopyWith<_SuperAdminAuditState> get copyWith => __$SuperAdminAuditStateCopyWithImpl<_SuperAdminAuditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuperAdminAuditState&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.filterActorId, filterActorId) || other.filterActorId == filterActorId)&&(identical(other.filterEntityType, filterEntityType) || other.filterEntityType == filterEntityType)&&(identical(other.filterAction, filterAction) || other.filterAction == filterAction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),page,total,isLoading,filterActorId,filterEntityType,filterAction,errorMessage);

@override
String toString() {
  return 'SuperAdminAuditState(logs: $logs, page: $page, total: $total, isLoading: $isLoading, filterActorId: $filterActorId, filterEntityType: $filterEntityType, filterAction: $filterAction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SuperAdminAuditStateCopyWith<$Res> implements $SuperAdminAuditStateCopyWith<$Res> {
  factory _$SuperAdminAuditStateCopyWith(_SuperAdminAuditState value, $Res Function(_SuperAdminAuditState) _then) = __$SuperAdminAuditStateCopyWithImpl;
@override @useResult
$Res call({
 List<AuditLogItemModel> logs, int page, int total, bool isLoading, String? filterActorId, String? filterEntityType, String? filterAction, String? errorMessage
});




}
/// @nodoc
class __$SuperAdminAuditStateCopyWithImpl<$Res>
    implements _$SuperAdminAuditStateCopyWith<$Res> {
  __$SuperAdminAuditStateCopyWithImpl(this._self, this._then);

  final _SuperAdminAuditState _self;
  final $Res Function(_SuperAdminAuditState) _then;

/// Create a copy of SuperAdminAuditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? page = null,Object? total = null,Object? isLoading = null,Object? filterActorId = freezed,Object? filterEntityType = freezed,Object? filterAction = freezed,Object? errorMessage = freezed,}) {
  return _then(_SuperAdminAuditState(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<AuditLogItemModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,filterActorId: freezed == filterActorId ? _self.filterActorId : filterActorId // ignore: cast_nullable_to_non_nullable
as String?,filterEntityType: freezed == filterEntityType ? _self.filterEntityType : filterEntityType // ignore: cast_nullable_to_non_nullable
as String?,filterAction: freezed == filterAction ? _self.filterAction : filterAction // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SuperAdminTemplatesState {

 List<NotificationTemplateModel> get templates; bool get isLoading; bool get isSaving; String? get errorMessage;
/// Create a copy of SuperAdminTemplatesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuperAdminTemplatesStateCopyWith<SuperAdminTemplatesState> get copyWith => _$SuperAdminTemplatesStateCopyWithImpl<SuperAdminTemplatesState>(this as SuperAdminTemplatesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuperAdminTemplatesState&&const DeepCollectionEquality().equals(other.templates, templates)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(templates),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'SuperAdminTemplatesState(templates: $templates, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuperAdminTemplatesStateCopyWith<$Res>  {
  factory $SuperAdminTemplatesStateCopyWith(SuperAdminTemplatesState value, $Res Function(SuperAdminTemplatesState) _then) = _$SuperAdminTemplatesStateCopyWithImpl;
@useResult
$Res call({
 List<NotificationTemplateModel> templates, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class _$SuperAdminTemplatesStateCopyWithImpl<$Res>
    implements $SuperAdminTemplatesStateCopyWith<$Res> {
  _$SuperAdminTemplatesStateCopyWithImpl(this._self, this._then);

  final SuperAdminTemplatesState _self;
  final $Res Function(SuperAdminTemplatesState) _then;

/// Create a copy of SuperAdminTemplatesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? templates = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(SuperAdminTemplatesState(
templates: null == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as List<NotificationTemplateModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuperAdminTemplatesState].
extension SuperAdminTemplatesStatePatterns on SuperAdminTemplatesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuperAdminTemplatesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuperAdminTemplatesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuperAdminTemplatesState value)  $default,){
final _that = this;
switch (_that) {
case _SuperAdminTemplatesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuperAdminTemplatesState value)?  $default,){
final _that = this;
switch (_that) {
case _SuperAdminTemplatesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationTemplateModel> templates,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuperAdminTemplatesState() when $default != null:
return $default(_that.templates,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationTemplateModel> templates,  bool isLoading,  bool isSaving,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SuperAdminTemplatesState():
return $default(_that.templates,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationTemplateModel> templates,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SuperAdminTemplatesState() when $default != null:
return $default(_that.templates,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SuperAdminTemplatesState implements SuperAdminTemplatesState {
  const _SuperAdminTemplatesState({ List<NotificationTemplateModel> templates = const <NotificationTemplateModel>[], this.isLoading = true, this.isSaving = false, this.errorMessage}): _templates = templates;
  

 final  List<NotificationTemplateModel> _templates;
@override@JsonKey() List<NotificationTemplateModel> get templates {
  if (_templates is EqualUnmodifiableListView) return _templates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_templates);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;

/// Create a copy of SuperAdminTemplatesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuperAdminTemplatesStateCopyWith<_SuperAdminTemplatesState> get copyWith => __$SuperAdminTemplatesStateCopyWithImpl<_SuperAdminTemplatesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuperAdminTemplatesState&&const DeepCollectionEquality().equals(other._templates, _templates)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_templates),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'SuperAdminTemplatesState(templates: $templates, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SuperAdminTemplatesStateCopyWith<$Res> implements $SuperAdminTemplatesStateCopyWith<$Res> {
  factory _$SuperAdminTemplatesStateCopyWith(_SuperAdminTemplatesState value, $Res Function(_SuperAdminTemplatesState) _then) = __$SuperAdminTemplatesStateCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationTemplateModel> templates, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class __$SuperAdminTemplatesStateCopyWithImpl<$Res>
    implements _$SuperAdminTemplatesStateCopyWith<$Res> {
  __$SuperAdminTemplatesStateCopyWithImpl(this._self, this._then);

  final _SuperAdminTemplatesState _self;
  final $Res Function(_SuperAdminTemplatesState) _then;

/// Create a copy of SuperAdminTemplatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? templates = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_SuperAdminTemplatesState(
templates: null == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as List<NotificationTemplateModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
