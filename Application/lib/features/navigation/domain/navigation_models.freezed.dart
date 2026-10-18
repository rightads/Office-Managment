// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppModuleItem {

 String get id; String get code; String get label;@JsonKey(name: 'icon_key') String get iconKey;@JsonKey(name: 'route_key') String get routeKey;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'required_permission') String? get requiredPermission;@JsonKey(name: 'is_base') bool get isBase;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'show_on_home') bool get showOnHome; String? get description;
/// Create a copy of AppModuleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppModuleItemCopyWith<AppModuleItem> get copyWith => _$AppModuleItemCopyWithImpl<AppModuleItem>(this as AppModuleItem, _$identity);

  /// Serializes this AppModuleItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppModuleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.routeKey, routeKey) || other.routeKey == routeKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission)&&(identical(other.isBase, isBase) || other.isBase == isBase)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.showOnHome, showOnHome) || other.showOnHome == showOnHome)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,iconKey,routeKey,sortOrder,requiredPermission,isBase,isActive,showOnHome,description);

@override
String toString() {
  return 'AppModuleItem(id: $id, code: $code, label: $label, iconKey: $iconKey, routeKey: $routeKey, sortOrder: $sortOrder, requiredPermission: $requiredPermission, isBase: $isBase, isActive: $isActive, showOnHome: $showOnHome, description: $description)';
}


}

/// @nodoc
abstract mixin class $AppModuleItemCopyWith<$Res>  {
  factory $AppModuleItemCopyWith(AppModuleItem value, $Res Function(AppModuleItem) _then) = _$AppModuleItemCopyWithImpl;
@useResult
$Res call({
 String id, String code, String label,@JsonKey(name: 'icon_key') String iconKey,@JsonKey(name: 'route_key') String routeKey,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'required_permission') String? requiredPermission,@JsonKey(name: 'is_base') bool isBase,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'show_on_home') bool showOnHome, String? description
});




}
/// @nodoc
class _$AppModuleItemCopyWithImpl<$Res>
    implements $AppModuleItemCopyWith<$Res> {
  _$AppModuleItemCopyWithImpl(this._self, this._then);

  final AppModuleItem _self;
  final $Res Function(AppModuleItem) _then;

/// Create a copy of AppModuleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? label = null,Object? iconKey = null,Object? routeKey = null,Object? sortOrder = null,Object? requiredPermission = freezed,Object? isBase = null,Object? isActive = null,Object? showOnHome = null,Object? description = freezed,}) {
  return _then(AppModuleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,routeKey: null == routeKey ? _self.routeKey : routeKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,isBase: null == isBase ? _self.isBase : isBase // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,showOnHome: null == showOnHome ? _self.showOnHome : showOnHome // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppModuleItem].
extension AppModuleItemPatterns on AppModuleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppModuleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppModuleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppModuleItem value)  $default,){
final _that = this;
switch (_that) {
case _AppModuleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppModuleItem value)?  $default,){
final _that = this;
switch (_that) {
case _AppModuleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String label, @JsonKey(name: 'icon_key')  String iconKey, @JsonKey(name: 'route_key')  String routeKey, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'is_base')  bool isBase, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'show_on_home')  bool showOnHome,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppModuleItem() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.iconKey,_that.routeKey,_that.sortOrder,_that.requiredPermission,_that.isBase,_that.isActive,_that.showOnHome,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String label, @JsonKey(name: 'icon_key')  String iconKey, @JsonKey(name: 'route_key')  String routeKey, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'is_base')  bool isBase, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'show_on_home')  bool showOnHome,  String? description)  $default,) {final _that = this;
switch (_that) {
case _AppModuleItem():
return $default(_that.id,_that.code,_that.label,_that.iconKey,_that.routeKey,_that.sortOrder,_that.requiredPermission,_that.isBase,_that.isActive,_that.showOnHome,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String label, @JsonKey(name: 'icon_key')  String iconKey, @JsonKey(name: 'route_key')  String routeKey, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'required_permission')  String? requiredPermission, @JsonKey(name: 'is_base')  bool isBase, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'show_on_home')  bool showOnHome,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _AppModuleItem() when $default != null:
return $default(_that.id,_that.code,_that.label,_that.iconKey,_that.routeKey,_that.sortOrder,_that.requiredPermission,_that.isBase,_that.isActive,_that.showOnHome,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppModuleItem implements AppModuleItem {
  const _AppModuleItem({required this.id, required this.code, required this.label, @JsonKey(name: 'icon_key') required this.iconKey, @JsonKey(name: 'route_key') required this.routeKey, @JsonKey(name: 'sort_order') this.sortOrder = 0, @JsonKey(name: 'required_permission') this.requiredPermission, @JsonKey(name: 'is_base') this.isBase = false, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'show_on_home') this.showOnHome = true, this.description});
  factory _AppModuleItem.fromJson(Map<String, dynamic> json) => _$AppModuleItemFromJson(json);

@override final  String id;
@override final  String code;
@override final  String label;
@override@JsonKey(name: 'icon_key') final  String iconKey;
@override@JsonKey(name: 'route_key') final  String routeKey;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'required_permission') final  String? requiredPermission;
@override@JsonKey(name: 'is_base') final  bool isBase;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'show_on_home') final  bool showOnHome;
@override final  String? description;

/// Create a copy of AppModuleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppModuleItemCopyWith<_AppModuleItem> get copyWith => __$AppModuleItemCopyWithImpl<_AppModuleItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppModuleItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppModuleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.routeKey, routeKey) || other.routeKey == routeKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.requiredPermission, requiredPermission) || other.requiredPermission == requiredPermission)&&(identical(other.isBase, isBase) || other.isBase == isBase)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.showOnHome, showOnHome) || other.showOnHome == showOnHome)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,label,iconKey,routeKey,sortOrder,requiredPermission,isBase,isActive,showOnHome,description);

@override
String toString() {
  return 'AppModuleItem(id: $id, code: $code, label: $label, iconKey: $iconKey, routeKey: $routeKey, sortOrder: $sortOrder, requiredPermission: $requiredPermission, isBase: $isBase, isActive: $isActive, showOnHome: $showOnHome, description: $description)';
}


}

/// @nodoc
abstract mixin class _$AppModuleItemCopyWith<$Res> implements $AppModuleItemCopyWith<$Res> {
  factory _$AppModuleItemCopyWith(_AppModuleItem value, $Res Function(_AppModuleItem) _then) = __$AppModuleItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String label,@JsonKey(name: 'icon_key') String iconKey,@JsonKey(name: 'route_key') String routeKey,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'required_permission') String? requiredPermission,@JsonKey(name: 'is_base') bool isBase,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'show_on_home') bool showOnHome, String? description
});




}
/// @nodoc
class __$AppModuleItemCopyWithImpl<$Res>
    implements _$AppModuleItemCopyWith<$Res> {
  __$AppModuleItemCopyWithImpl(this._self, this._then);

  final _AppModuleItem _self;
  final $Res Function(_AppModuleItem) _then;

/// Create a copy of AppModuleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? label = null,Object? iconKey = null,Object? routeKey = null,Object? sortOrder = null,Object? requiredPermission = freezed,Object? isBase = null,Object? isActive = null,Object? showOnHome = null,Object? description = freezed,}) {
  return _then(_AppModuleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,routeKey: null == routeKey ? _self.routeKey : routeKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,requiredPermission: freezed == requiredPermission ? _self.requiredPermission : requiredPermission // ignore: cast_nullable_to_non_nullable
as String?,isBase: null == isBase ? _self.isBase : isBase // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,showOnHome: null == showOnHome ? _self.showOnHome : showOnHome // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserNavigationData {

 List<AppModuleItem> get modules; List<String> get permissions;@JsonKey(name: 'role_name') String get roleName;@JsonKey(name: 'role_label') String get roleLabel;@JsonKey(name: 'department_id') String? get departmentId;@JsonKey(name: 'department_name') String? get departmentName;@JsonKey(name: 'must_change_password') bool get mustChangePassword;
/// Create a copy of UserNavigationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNavigationDataCopyWith<UserNavigationData> get copyWith => _$UserNavigationDataCopyWithImpl<UserNavigationData>(this as UserNavigationData, _$identity);

  /// Serializes this UserNavigationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNavigationData&&const DeepCollectionEquality().equals(other.modules, modules)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(modules),const DeepCollectionEquality().hash(permissions),roleName,roleLabel,departmentId,departmentName,mustChangePassword);

@override
String toString() {
  return 'UserNavigationData(modules: $modules, permissions: $permissions, roleName: $roleName, roleLabel: $roleLabel, departmentId: $departmentId, departmentName: $departmentName, mustChangePassword: $mustChangePassword)';
}


}

/// @nodoc
abstract mixin class $UserNavigationDataCopyWith<$Res>  {
  factory $UserNavigationDataCopyWith(UserNavigationData value, $Res Function(UserNavigationData) _then) = _$UserNavigationDataCopyWithImpl;
@useResult
$Res call({
 List<AppModuleItem> modules, List<String> permissions,@JsonKey(name: 'role_name') String roleName,@JsonKey(name: 'role_label') String roleLabel,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'must_change_password') bool mustChangePassword
});




}
/// @nodoc
class _$UserNavigationDataCopyWithImpl<$Res>
    implements $UserNavigationDataCopyWith<$Res> {
  _$UserNavigationDataCopyWithImpl(this._self, this._then);

  final UserNavigationData _self;
  final $Res Function(UserNavigationData) _then;

/// Create a copy of UserNavigationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modules = null,Object? permissions = null,Object? roleName = null,Object? roleLabel = null,Object? departmentId = freezed,Object? departmentName = freezed,Object? mustChangePassword = null,}) {
  return _then(UserNavigationData(
modules: null == modules ? _self.modules : modules // ignore: cast_nullable_to_non_nullable
as List<AppModuleItem>,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,roleName: null == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserNavigationData].
extension UserNavigationDataPatterns on UserNavigationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserNavigationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserNavigationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserNavigationData value)  $default,){
final _that = this;
switch (_that) {
case _UserNavigationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserNavigationData value)?  $default,){
final _that = this;
switch (_that) {
case _UserNavigationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AppModuleItem> modules,  List<String> permissions, @JsonKey(name: 'role_name')  String roleName, @JsonKey(name: 'role_label')  String roleLabel, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'must_change_password')  bool mustChangePassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserNavigationData() when $default != null:
return $default(_that.modules,_that.permissions,_that.roleName,_that.roleLabel,_that.departmentId,_that.departmentName,_that.mustChangePassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AppModuleItem> modules,  List<String> permissions, @JsonKey(name: 'role_name')  String roleName, @JsonKey(name: 'role_label')  String roleLabel, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'must_change_password')  bool mustChangePassword)  $default,) {final _that = this;
switch (_that) {
case _UserNavigationData():
return $default(_that.modules,_that.permissions,_that.roleName,_that.roleLabel,_that.departmentId,_that.departmentName,_that.mustChangePassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AppModuleItem> modules,  List<String> permissions, @JsonKey(name: 'role_name')  String roleName, @JsonKey(name: 'role_label')  String roleLabel, @JsonKey(name: 'department_id')  String? departmentId, @JsonKey(name: 'department_name')  String? departmentName, @JsonKey(name: 'must_change_password')  bool mustChangePassword)?  $default,) {final _that = this;
switch (_that) {
case _UserNavigationData() when $default != null:
return $default(_that.modules,_that.permissions,_that.roleName,_that.roleLabel,_that.departmentId,_that.departmentName,_that.mustChangePassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserNavigationData implements UserNavigationData {
  const _UserNavigationData({ List<AppModuleItem> modules = const <AppModuleItem>[],  List<String> permissions = const <String>[], @JsonKey(name: 'role_name') this.roleName = '', @JsonKey(name: 'role_label') this.roleLabel = '', @JsonKey(name: 'department_id') this.departmentId, @JsonKey(name: 'department_name') this.departmentName, @JsonKey(name: 'must_change_password') this.mustChangePassword = false}): _modules = modules,_permissions = permissions;
  factory _UserNavigationData.fromJson(Map<String, dynamic> json) => _$UserNavigationDataFromJson(json);

 final  List<AppModuleItem> _modules;
@override@JsonKey() List<AppModuleItem> get modules {
  if (_modules is EqualUnmodifiableListView) return _modules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_modules);
}

 final  List<String> _permissions;
@override@JsonKey() List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override@JsonKey(name: 'role_name') final  String roleName;
@override@JsonKey(name: 'role_label') final  String roleLabel;
@override@JsonKey(name: 'department_id') final  String? departmentId;
@override@JsonKey(name: 'department_name') final  String? departmentName;
@override@JsonKey(name: 'must_change_password') final  bool mustChangePassword;

/// Create a copy of UserNavigationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserNavigationDataCopyWith<_UserNavigationData> get copyWith => __$UserNavigationDataCopyWithImpl<_UserNavigationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserNavigationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserNavigationData&&const DeepCollectionEquality().equals(other._modules, _modules)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_modules),const DeepCollectionEquality().hash(_permissions),roleName,roleLabel,departmentId,departmentName,mustChangePassword);

@override
String toString() {
  return 'UserNavigationData(modules: $modules, permissions: $permissions, roleName: $roleName, roleLabel: $roleLabel, departmentId: $departmentId, departmentName: $departmentName, mustChangePassword: $mustChangePassword)';
}


}

/// @nodoc
abstract mixin class _$UserNavigationDataCopyWith<$Res> implements $UserNavigationDataCopyWith<$Res> {
  factory _$UserNavigationDataCopyWith(_UserNavigationData value, $Res Function(_UserNavigationData) _then) = __$UserNavigationDataCopyWithImpl;
@override @useResult
$Res call({
 List<AppModuleItem> modules, List<String> permissions,@JsonKey(name: 'role_name') String roleName,@JsonKey(name: 'role_label') String roleLabel,@JsonKey(name: 'department_id') String? departmentId,@JsonKey(name: 'department_name') String? departmentName,@JsonKey(name: 'must_change_password') bool mustChangePassword
});




}
/// @nodoc
class __$UserNavigationDataCopyWithImpl<$Res>
    implements _$UserNavigationDataCopyWith<$Res> {
  __$UserNavigationDataCopyWithImpl(this._self, this._then);

  final _UserNavigationData _self;
  final $Res Function(_UserNavigationData) _then;

/// Create a copy of UserNavigationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modules = null,Object? permissions = null,Object? roleName = null,Object? roleLabel = null,Object? departmentId = freezed,Object? departmentName = freezed,Object? mustChangePassword = null,}) {
  return _then(_UserNavigationData(
modules: null == modules ? _self._modules : modules // ignore: cast_nullable_to_non_nullable
as List<AppModuleItem>,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,roleName: null == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$NavigationState {

 bool get isLoading; UserNavigationData get data; AppFailure? get error; DateTime? get lastRefreshedAt; bool get isFromOfflineCache;
/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationStateCopyWith<NavigationState> get copyWith => _$NavigationStateCopyWithImpl<NavigationState>(this as NavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.data, data) || other.data == data)&&(identical(other.error, error) || other.error == error)&&(identical(other.lastRefreshedAt, lastRefreshedAt) || other.lastRefreshedAt == lastRefreshedAt)&&(identical(other.isFromOfflineCache, isFromOfflineCache) || other.isFromOfflineCache == isFromOfflineCache));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,data,error,lastRefreshedAt,isFromOfflineCache);

@override
String toString() {
  return 'NavigationState(isLoading: $isLoading, data: $data, error: $error, lastRefreshedAt: $lastRefreshedAt, isFromOfflineCache: $isFromOfflineCache)';
}


}

/// @nodoc
abstract mixin class $NavigationStateCopyWith<$Res>  {
  factory $NavigationStateCopyWith(NavigationState value, $Res Function(NavigationState) _then) = _$NavigationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, UserNavigationData data, AppFailure? error, DateTime? lastRefreshedAt, bool isFromOfflineCache
});


$UserNavigationDataCopyWith<$Res> get data;$AppFailureCopyWith<$Res>? get error;

}
/// @nodoc
class _$NavigationStateCopyWithImpl<$Res>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._self, this._then);

  final NavigationState _self;
  final $Res Function(NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? data = null,Object? error = freezed,Object? lastRefreshedAt = freezed,Object? isFromOfflineCache = null,}) {
  return _then(NavigationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as UserNavigationData,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppFailure?,lastRefreshedAt: freezed == lastRefreshedAt ? _self.lastRefreshedAt : lastRefreshedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFromOfflineCache: null == isFromOfflineCache ? _self.isFromOfflineCache : isFromOfflineCache // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserNavigationDataCopyWith<$Res> get data {
  
  return $UserNavigationDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of NavigationState
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


/// Adds pattern-matching-related methods to [NavigationState].
extension NavigationStatePatterns on NavigationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationState value)  $default,){
final _that = this;
switch (_that) {
case _NavigationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  UserNavigationData data,  AppFailure? error,  DateTime? lastRefreshedAt,  bool isFromOfflineCache)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.isLoading,_that.data,_that.error,_that.lastRefreshedAt,_that.isFromOfflineCache);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  UserNavigationData data,  AppFailure? error,  DateTime? lastRefreshedAt,  bool isFromOfflineCache)  $default,) {final _that = this;
switch (_that) {
case _NavigationState():
return $default(_that.isLoading,_that.data,_that.error,_that.lastRefreshedAt,_that.isFromOfflineCache);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  UserNavigationData data,  AppFailure? error,  DateTime? lastRefreshedAt,  bool isFromOfflineCache)?  $default,) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.isLoading,_that.data,_that.error,_that.lastRefreshedAt,_that.isFromOfflineCache);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationState implements NavigationState {
  const _NavigationState({this.isLoading = false, this.data = const UserNavigationData(), this.error, this.lastRefreshedAt, this.isFromOfflineCache = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  UserNavigationData data;
@override final  AppFailure? error;
@override final  DateTime? lastRefreshedAt;
@override@JsonKey() final  bool isFromOfflineCache;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationStateCopyWith<_NavigationState> get copyWith => __$NavigationStateCopyWithImpl<_NavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.data, data) || other.data == data)&&(identical(other.error, error) || other.error == error)&&(identical(other.lastRefreshedAt, lastRefreshedAt) || other.lastRefreshedAt == lastRefreshedAt)&&(identical(other.isFromOfflineCache, isFromOfflineCache) || other.isFromOfflineCache == isFromOfflineCache));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,data,error,lastRefreshedAt,isFromOfflineCache);

@override
String toString() {
  return 'NavigationState(isLoading: $isLoading, data: $data, error: $error, lastRefreshedAt: $lastRefreshedAt, isFromOfflineCache: $isFromOfflineCache)';
}


}

/// @nodoc
abstract mixin class _$NavigationStateCopyWith<$Res> implements $NavigationStateCopyWith<$Res> {
  factory _$NavigationStateCopyWith(_NavigationState value, $Res Function(_NavigationState) _then) = __$NavigationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, UserNavigationData data, AppFailure? error, DateTime? lastRefreshedAt, bool isFromOfflineCache
});


@override $UserNavigationDataCopyWith<$Res> get data;@override $AppFailureCopyWith<$Res>? get error;

}
/// @nodoc
class __$NavigationStateCopyWithImpl<$Res>
    implements _$NavigationStateCopyWith<$Res> {
  __$NavigationStateCopyWithImpl(this._self, this._then);

  final _NavigationState _self;
  final $Res Function(_NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? data = null,Object? error = freezed,Object? lastRefreshedAt = freezed,Object? isFromOfflineCache = null,}) {
  return _then(_NavigationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as UserNavigationData,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppFailure?,lastRefreshedAt: freezed == lastRefreshedAt ? _self.lastRefreshedAt : lastRefreshedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFromOfflineCache: null == isFromOfflineCache ? _self.isFromOfflineCache : isFromOfflineCache // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserNavigationDataCopyWith<$Res> get data {
  
  return $UserNavigationDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of NavigationState
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
