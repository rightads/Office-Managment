// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'super_admin_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PermissionModel {

 String get id; String get code; String get description;
/// Create a copy of PermissionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermissionModelCopyWith<PermissionModel> get copyWith => _$PermissionModelCopyWithImpl<PermissionModel>(this as PermissionModel, _$identity);

  /// Serializes this PermissionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,description);

@override
String toString() {
  return 'PermissionModel(id: $id, code: $code, description: $description)';
}


}

/// @nodoc
abstract mixin class $PermissionModelCopyWith<$Res>  {
  factory $PermissionModelCopyWith(PermissionModel value, $Res Function(PermissionModel) _then) = _$PermissionModelCopyWithImpl;
@useResult
$Res call({
 String id, String code, String description
});




}
/// @nodoc
class _$PermissionModelCopyWithImpl<$Res>
    implements $PermissionModelCopyWith<$Res> {
  _$PermissionModelCopyWithImpl(this._self, this._then);

  final PermissionModel _self;
  final $Res Function(PermissionModel) _then;

/// Create a copy of PermissionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? description = null,}) {
  return _then(PermissionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PermissionModel].
extension PermissionModelPatterns on PermissionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PermissionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PermissionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PermissionModel value)  $default,){
final _that = this;
switch (_that) {
case _PermissionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PermissionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PermissionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PermissionModel() when $default != null:
return $default(_that.id,_that.code,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String description)  $default,) {final _that = this;
switch (_that) {
case _PermissionModel():
return $default(_that.id,_that.code,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String description)?  $default,) {final _that = this;
switch (_that) {
case _PermissionModel() when $default != null:
return $default(_that.id,_that.code,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PermissionModel implements PermissionModel {
  const _PermissionModel({required this.id, required this.code, required this.description});
  factory _PermissionModel.fromJson(Map<String, dynamic> json) => _$PermissionModelFromJson(json);

@override final  String id;
@override final  String code;
@override final  String description;

/// Create a copy of PermissionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermissionModelCopyWith<_PermissionModel> get copyWith => __$PermissionModelCopyWithImpl<_PermissionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PermissionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,description);

@override
String toString() {
  return 'PermissionModel(id: $id, code: $code, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PermissionModelCopyWith<$Res> implements $PermissionModelCopyWith<$Res> {
  factory _$PermissionModelCopyWith(_PermissionModel value, $Res Function(_PermissionModel) _then) = __$PermissionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String description
});




}
/// @nodoc
class __$PermissionModelCopyWithImpl<$Res>
    implements _$PermissionModelCopyWith<$Res> {
  __$PermissionModelCopyWithImpl(this._self, this._then);

  final _PermissionModel _self;
  final $Res Function(_PermissionModel) _then;

/// Create a copy of PermissionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? description = null,}) {
  return _then(_PermissionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RoleDetailModel {

 String get id; String get name; String? get description;@JsonKey(name: 'is_system') bool get isSystem;@JsonKey(name: 'user_count') int get userCount; List<PermissionModel> get permissions;
/// Create a copy of RoleDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleDetailModelCopyWith<RoleDetailModel> get copyWith => _$RoleDetailModelCopyWithImpl<RoleDetailModel>(this as RoleDetailModel, _$identity);

  /// Serializes this RoleDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.userCount, userCount) || other.userCount == userCount)&&const DeepCollectionEquality().equals(other.permissions, permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isSystem,userCount,const DeepCollectionEquality().hash(permissions));

@override
String toString() {
  return 'RoleDetailModel(id: $id, name: $name, description: $description, isSystem: $isSystem, userCount: $userCount, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class $RoleDetailModelCopyWith<$Res>  {
  factory $RoleDetailModelCopyWith(RoleDetailModel value, $Res Function(RoleDetailModel) _then) = _$RoleDetailModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'is_system') bool isSystem,@JsonKey(name: 'user_count') int userCount, List<PermissionModel> permissions
});




}
/// @nodoc
class _$RoleDetailModelCopyWithImpl<$Res>
    implements $RoleDetailModelCopyWith<$Res> {
  _$RoleDetailModelCopyWithImpl(this._self, this._then);

  final RoleDetailModel _self;
  final $Res Function(RoleDetailModel) _then;

/// Create a copy of RoleDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? isSystem = null,Object? userCount = null,Object? permissions = null,}) {
  return _then(RoleDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<PermissionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleDetailModel].
extension RoleDetailModelPatterns on RoleDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _RoleDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoleDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'is_system')  bool isSystem, @JsonKey(name: 'user_count')  int userCount,  List<PermissionModel> permissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isSystem,_that.userCount,_that.permissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'is_system')  bool isSystem, @JsonKey(name: 'user_count')  int userCount,  List<PermissionModel> permissions)  $default,) {final _that = this;
switch (_that) {
case _RoleDetailModel():
return $default(_that.id,_that.name,_that.description,_that.isSystem,_that.userCount,_that.permissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(name: 'is_system')  bool isSystem, @JsonKey(name: 'user_count')  int userCount,  List<PermissionModel> permissions)?  $default,) {final _that = this;
switch (_that) {
case _RoleDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.isSystem,_that.userCount,_that.permissions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleDetailModel implements RoleDetailModel {
  const _RoleDetailModel({required this.id, required this.name, this.description, @JsonKey(name: 'is_system') this.isSystem = false, @JsonKey(name: 'user_count') this.userCount = 0,  List<PermissionModel> permissions = const <PermissionModel>[]}): _permissions = permissions;
  factory _RoleDetailModel.fromJson(Map<String, dynamic> json) => _$RoleDetailModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'is_system') final  bool isSystem;
@override@JsonKey(name: 'user_count') final  int userCount;
 final  List<PermissionModel> _permissions;
@override@JsonKey() List<PermissionModel> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}


/// Create a copy of RoleDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleDetailModelCopyWith<_RoleDetailModel> get copyWith => __$RoleDetailModelCopyWithImpl<_RoleDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.userCount, userCount) || other.userCount == userCount)&&const DeepCollectionEquality().equals(other._permissions, _permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,isSystem,userCount,const DeepCollectionEquality().hash(_permissions));

@override
String toString() {
  return 'RoleDetailModel(id: $id, name: $name, description: $description, isSystem: $isSystem, userCount: $userCount, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class _$RoleDetailModelCopyWith<$Res> implements $RoleDetailModelCopyWith<$Res> {
  factory _$RoleDetailModelCopyWith(_RoleDetailModel value, $Res Function(_RoleDetailModel) _then) = __$RoleDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'is_system') bool isSystem,@JsonKey(name: 'user_count') int userCount, List<PermissionModel> permissions
});




}
/// @nodoc
class __$RoleDetailModelCopyWithImpl<$Res>
    implements _$RoleDetailModelCopyWith<$Res> {
  __$RoleDetailModelCopyWithImpl(this._self, this._then);

  final _RoleDetailModel _self;
  final $Res Function(_RoleDetailModel) _then;

/// Create a copy of RoleDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? isSystem = null,Object? userCount = null,Object? permissions = null,}) {
  return _then(_RoleDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<PermissionModel>,
  ));
}


}


/// @nodoc
mixin _$RoleUpsertRequest {

 String get name; String? get description;@JsonKey(name: 'permission_ids') List<String> get permissionIds;
/// Create a copy of RoleUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleUpsertRequestCopyWith<RoleUpsertRequest> get copyWith => _$RoleUpsertRequestCopyWithImpl<RoleUpsertRequest>(this as RoleUpsertRequest, _$identity);

  /// Serializes this RoleUpsertRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleUpsertRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.permissionIds, permissionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(permissionIds));

@override
String toString() {
  return 'RoleUpsertRequest(name: $name, description: $description, permissionIds: $permissionIds)';
}


}

/// @nodoc
abstract mixin class $RoleUpsertRequestCopyWith<$Res>  {
  factory $RoleUpsertRequestCopyWith(RoleUpsertRequest value, $Res Function(RoleUpsertRequest) _then) = _$RoleUpsertRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? description,@JsonKey(name: 'permission_ids') List<String> permissionIds
});




}
/// @nodoc
class _$RoleUpsertRequestCopyWithImpl<$Res>
    implements $RoleUpsertRequestCopyWith<$Res> {
  _$RoleUpsertRequestCopyWithImpl(this._self, this._then);

  final RoleUpsertRequest _self;
  final $Res Function(RoleUpsertRequest) _then;

/// Create a copy of RoleUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? permissionIds = null,}) {
  return _then(RoleUpsertRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,permissionIds: null == permissionIds ? _self.permissionIds : permissionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleUpsertRequest].
extension RoleUpsertRequestPatterns on RoleUpsertRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleUpsertRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleUpsertRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleUpsertRequest value)  $default,){
final _that = this;
switch (_that) {
case _RoleUpsertRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleUpsertRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RoleUpsertRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description, @JsonKey(name: 'permission_ids')  List<String> permissionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleUpsertRequest() when $default != null:
return $default(_that.name,_that.description,_that.permissionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description, @JsonKey(name: 'permission_ids')  List<String> permissionIds)  $default,) {final _that = this;
switch (_that) {
case _RoleUpsertRequest():
return $default(_that.name,_that.description,_that.permissionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description, @JsonKey(name: 'permission_ids')  List<String> permissionIds)?  $default,) {final _that = this;
switch (_that) {
case _RoleUpsertRequest() when $default != null:
return $default(_that.name,_that.description,_that.permissionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleUpsertRequest implements RoleUpsertRequest {
  const _RoleUpsertRequest({required this.name, this.description, @JsonKey(name: 'permission_ids')  List<String> permissionIds = const <String>[]}): _permissionIds = permissionIds;
  factory _RoleUpsertRequest.fromJson(Map<String, dynamic> json) => _$RoleUpsertRequestFromJson(json);

@override final  String name;
@override final  String? description;
 final  List<String> _permissionIds;
@override@JsonKey(name: 'permission_ids') List<String> get permissionIds {
  if (_permissionIds is EqualUnmodifiableListView) return _permissionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissionIds);
}


/// Create a copy of RoleUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleUpsertRequestCopyWith<_RoleUpsertRequest> get copyWith => __$RoleUpsertRequestCopyWithImpl<_RoleUpsertRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleUpsertRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleUpsertRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._permissionIds, _permissionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(_permissionIds));

@override
String toString() {
  return 'RoleUpsertRequest(name: $name, description: $description, permissionIds: $permissionIds)';
}


}

/// @nodoc
abstract mixin class _$RoleUpsertRequestCopyWith<$Res> implements $RoleUpsertRequestCopyWith<$Res> {
  factory _$RoleUpsertRequestCopyWith(_RoleUpsertRequest value, $Res Function(_RoleUpsertRequest) _then) = __$RoleUpsertRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description,@JsonKey(name: 'permission_ids') List<String> permissionIds
});




}
/// @nodoc
class __$RoleUpsertRequestCopyWithImpl<$Res>
    implements _$RoleUpsertRequestCopyWith<$Res> {
  __$RoleUpsertRequestCopyWithImpl(this._self, this._then);

  final _RoleUpsertRequest _self;
  final $Res Function(_RoleUpsertRequest) _then;

/// Create a copy of RoleUpsertRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? permissionIds = null,}) {
  return _then(_RoleUpsertRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,permissionIds: null == permissionIds ? _self._permissionIds : permissionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SystemSettingModel {

 String get key; dynamic get value; String? get description;
/// Create a copy of SystemSettingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemSettingModelCopyWith<SystemSettingModel> get copyWith => _$SystemSettingModelCopyWithImpl<SystemSettingModel>(this as SystemSettingModel, _$identity);

  /// Serializes this SystemSettingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemSettingModel&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(value),description);

@override
String toString() {
  return 'SystemSettingModel(key: $key, value: $value, description: $description)';
}


}

/// @nodoc
abstract mixin class $SystemSettingModelCopyWith<$Res>  {
  factory $SystemSettingModelCopyWith(SystemSettingModel value, $Res Function(SystemSettingModel) _then) = _$SystemSettingModelCopyWithImpl;
@useResult
$Res call({
 String key, dynamic value, String? description
});




}
/// @nodoc
class _$SystemSettingModelCopyWithImpl<$Res>
    implements $SystemSettingModelCopyWith<$Res> {
  _$SystemSettingModelCopyWithImpl(this._self, this._then);

  final SystemSettingModel _self;
  final $Res Function(SystemSettingModel) _then;

/// Create a copy of SystemSettingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? value = freezed,Object? description = freezed,}) {
  return _then(SystemSettingModel(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SystemSettingModel].
extension SystemSettingModelPatterns on SystemSettingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SystemSettingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SystemSettingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SystemSettingModel value)  $default,){
final _that = this;
switch (_that) {
case _SystemSettingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SystemSettingModel value)?  $default,){
final _that = this;
switch (_that) {
case _SystemSettingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  dynamic value,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SystemSettingModel() when $default != null:
return $default(_that.key,_that.value,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  dynamic value,  String? description)  $default,) {final _that = this;
switch (_that) {
case _SystemSettingModel():
return $default(_that.key,_that.value,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  dynamic value,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _SystemSettingModel() when $default != null:
return $default(_that.key,_that.value,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SystemSettingModel implements SystemSettingModel {
  const _SystemSettingModel({required this.key, required this.value, this.description});
  factory _SystemSettingModel.fromJson(Map<String, dynamic> json) => _$SystemSettingModelFromJson(json);

@override final  String key;
@override final  dynamic value;
@override final  String? description;

/// Create a copy of SystemSettingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemSettingModelCopyWith<_SystemSettingModel> get copyWith => __$SystemSettingModelCopyWithImpl<_SystemSettingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemSettingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemSettingModel&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(value),description);

@override
String toString() {
  return 'SystemSettingModel(key: $key, value: $value, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SystemSettingModelCopyWith<$Res> implements $SystemSettingModelCopyWith<$Res> {
  factory _$SystemSettingModelCopyWith(_SystemSettingModel value, $Res Function(_SystemSettingModel) _then) = __$SystemSettingModelCopyWithImpl;
@override @useResult
$Res call({
 String key, dynamic value, String? description
});




}
/// @nodoc
class __$SystemSettingModelCopyWithImpl<$Res>
    implements _$SystemSettingModelCopyWith<$Res> {
  __$SystemSettingModelCopyWithImpl(this._self, this._then);

  final _SystemSettingModel _self;
  final $Res Function(_SystemSettingModel) _then;

/// Create a copy of SystemSettingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = freezed,Object? description = freezed,}) {
  return _then(_SystemSettingModel(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SystemSettingUpdateRequest {

 dynamic get value;
/// Create a copy of SystemSettingUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemSettingUpdateRequestCopyWith<SystemSettingUpdateRequest> get copyWith => _$SystemSettingUpdateRequestCopyWithImpl<SystemSettingUpdateRequest>(this as SystemSettingUpdateRequest, _$identity);

  /// Serializes this SystemSettingUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemSettingUpdateRequest&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SystemSettingUpdateRequest(value: $value)';
}


}

/// @nodoc
abstract mixin class $SystemSettingUpdateRequestCopyWith<$Res>  {
  factory $SystemSettingUpdateRequestCopyWith(SystemSettingUpdateRequest value, $Res Function(SystemSettingUpdateRequest) _then) = _$SystemSettingUpdateRequestCopyWithImpl;
@useResult
$Res call({
 dynamic value
});




}
/// @nodoc
class _$SystemSettingUpdateRequestCopyWithImpl<$Res>
    implements $SystemSettingUpdateRequestCopyWith<$Res> {
  _$SystemSettingUpdateRequestCopyWithImpl(this._self, this._then);

  final SystemSettingUpdateRequest _self;
  final $Res Function(SystemSettingUpdateRequest) _then;

/// Create a copy of SystemSettingUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(SystemSettingUpdateRequest(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [SystemSettingUpdateRequest].
extension SystemSettingUpdateRequestPatterns on SystemSettingUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SystemSettingUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SystemSettingUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SystemSettingUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _SystemSettingUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SystemSettingUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SystemSettingUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SystemSettingUpdateRequest() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic value)  $default,) {final _that = this;
switch (_that) {
case _SystemSettingUpdateRequest():
return $default(_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic value)?  $default,) {final _that = this;
switch (_that) {
case _SystemSettingUpdateRequest() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SystemSettingUpdateRequest implements SystemSettingUpdateRequest {
  const _SystemSettingUpdateRequest({required this.value});
  factory _SystemSettingUpdateRequest.fromJson(Map<String, dynamic> json) => _$SystemSettingUpdateRequestFromJson(json);

@override final  dynamic value;

/// Create a copy of SystemSettingUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemSettingUpdateRequestCopyWith<_SystemSettingUpdateRequest> get copyWith => __$SystemSettingUpdateRequestCopyWithImpl<_SystemSettingUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemSettingUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemSettingUpdateRequest&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SystemSettingUpdateRequest(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SystemSettingUpdateRequestCopyWith<$Res> implements $SystemSettingUpdateRequestCopyWith<$Res> {
  factory _$SystemSettingUpdateRequestCopyWith(_SystemSettingUpdateRequest value, $Res Function(_SystemSettingUpdateRequest) _then) = __$SystemSettingUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 dynamic value
});




}
/// @nodoc
class __$SystemSettingUpdateRequestCopyWithImpl<$Res>
    implements _$SystemSettingUpdateRequestCopyWith<$Res> {
  __$SystemSettingUpdateRequestCopyWithImpl(this._self, this._then);

  final _SystemSettingUpdateRequest _self;
  final $Res Function(_SystemSettingUpdateRequest) _then;

/// Create a copy of SystemSettingUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_SystemSettingUpdateRequest(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$AuditLogItemModel {

 String get id;@JsonKey(name: 'actor_id') String? get actorId;@JsonKey(name: 'actor_name') String? get actorName;@JsonKey(name: 'actor_email') String? get actorEmail; String get action;@JsonKey(name: 'entity_type') String get entityType;@JsonKey(name: 'entity_id') String get entityId;@JsonKey(name: 'old_data') Map<String, dynamic>? get oldData;@JsonKey(name: 'new_data') Map<String, dynamic>? get newData;@JsonKey(name: 'ip_address') String? get ipAddress;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of AuditLogItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogItemModelCopyWith<AuditLogItemModel> get copyWith => _$AuditLogItemModelCopyWithImpl<AuditLogItemModel>(this as AuditLogItemModel, _$identity);

  /// Serializes this AuditLogItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorEmail, actorEmail) || other.actorEmail == actorEmail)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other.oldData, oldData)&&const DeepCollectionEquality().equals(other.newData, newData)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,actorId,actorName,actorEmail,action,entityType,entityId,const DeepCollectionEquality().hash(oldData),const DeepCollectionEquality().hash(newData),ipAddress,createdAt);

@override
String toString() {
  return 'AuditLogItemModel(id: $id, actorId: $actorId, actorName: $actorName, actorEmail: $actorEmail, action: $action, entityType: $entityType, entityId: $entityId, oldData: $oldData, newData: $newData, ipAddress: $ipAddress, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AuditLogItemModelCopyWith<$Res>  {
  factory $AuditLogItemModelCopyWith(AuditLogItemModel value, $Res Function(AuditLogItemModel) _then) = _$AuditLogItemModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'actor_id') String? actorId,@JsonKey(name: 'actor_name') String? actorName,@JsonKey(name: 'actor_email') String? actorEmail, String action,@JsonKey(name: 'entity_type') String entityType,@JsonKey(name: 'entity_id') String entityId,@JsonKey(name: 'old_data') Map<String, dynamic>? oldData,@JsonKey(name: 'new_data') Map<String, dynamic>? newData,@JsonKey(name: 'ip_address') String? ipAddress,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$AuditLogItemModelCopyWithImpl<$Res>
    implements $AuditLogItemModelCopyWith<$Res> {
  _$AuditLogItemModelCopyWithImpl(this._self, this._then);

  final AuditLogItemModel _self;
  final $Res Function(AuditLogItemModel) _then;

/// Create a copy of AuditLogItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? actorId = freezed,Object? actorName = freezed,Object? actorEmail = freezed,Object? action = null,Object? entityType = null,Object? entityId = null,Object? oldData = freezed,Object? newData = freezed,Object? ipAddress = freezed,Object? createdAt = null,}) {
  return _then(AuditLogItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actorId: freezed == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String?,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,actorEmail: freezed == actorEmail ? _self.actorEmail : actorEmail // ignore: cast_nullable_to_non_nullable
as String?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,oldData: freezed == oldData ? _self.oldData : oldData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newData: freezed == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogItemModel].
extension AuditLogItemModelPatterns on AuditLogItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogItemModel value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'actor_id')  String? actorId, @JsonKey(name: 'actor_name')  String? actorName, @JsonKey(name: 'actor_email')  String? actorEmail,  String action, @JsonKey(name: 'entity_type')  String entityType, @JsonKey(name: 'entity_id')  String entityId, @JsonKey(name: 'old_data')  Map<String, dynamic>? oldData, @JsonKey(name: 'new_data')  Map<String, dynamic>? newData, @JsonKey(name: 'ip_address')  String? ipAddress, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogItemModel() when $default != null:
return $default(_that.id,_that.actorId,_that.actorName,_that.actorEmail,_that.action,_that.entityType,_that.entityId,_that.oldData,_that.newData,_that.ipAddress,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'actor_id')  String? actorId, @JsonKey(name: 'actor_name')  String? actorName, @JsonKey(name: 'actor_email')  String? actorEmail,  String action, @JsonKey(name: 'entity_type')  String entityType, @JsonKey(name: 'entity_id')  String entityId, @JsonKey(name: 'old_data')  Map<String, dynamic>? oldData, @JsonKey(name: 'new_data')  Map<String, dynamic>? newData, @JsonKey(name: 'ip_address')  String? ipAddress, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditLogItemModel():
return $default(_that.id,_that.actorId,_that.actorName,_that.actorEmail,_that.action,_that.entityType,_that.entityId,_that.oldData,_that.newData,_that.ipAddress,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'actor_id')  String? actorId, @JsonKey(name: 'actor_name')  String? actorName, @JsonKey(name: 'actor_email')  String? actorEmail,  String action, @JsonKey(name: 'entity_type')  String entityType, @JsonKey(name: 'entity_id')  String entityId, @JsonKey(name: 'old_data')  Map<String, dynamic>? oldData, @JsonKey(name: 'new_data')  Map<String, dynamic>? newData, @JsonKey(name: 'ip_address')  String? ipAddress, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogItemModel() when $default != null:
return $default(_that.id,_that.actorId,_that.actorName,_that.actorEmail,_that.action,_that.entityType,_that.entityId,_that.oldData,_that.newData,_that.ipAddress,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLogItemModel implements AuditLogItemModel {
  const _AuditLogItemModel({required this.id, @JsonKey(name: 'actor_id') this.actorId, @JsonKey(name: 'actor_name') this.actorName, @JsonKey(name: 'actor_email') this.actorEmail, required this.action, @JsonKey(name: 'entity_type') required this.entityType, @JsonKey(name: 'entity_id') required this.entityId, @JsonKey(name: 'old_data')  Map<String, dynamic>? oldData, @JsonKey(name: 'new_data')  Map<String, dynamic>? newData, @JsonKey(name: 'ip_address') this.ipAddress, @JsonKey(name: 'created_at') required this.createdAt}): _oldData = oldData,_newData = newData;
  factory _AuditLogItemModel.fromJson(Map<String, dynamic> json) => _$AuditLogItemModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'actor_id') final  String? actorId;
@override@JsonKey(name: 'actor_name') final  String? actorName;
@override@JsonKey(name: 'actor_email') final  String? actorEmail;
@override final  String action;
@override@JsonKey(name: 'entity_type') final  String entityType;
@override@JsonKey(name: 'entity_id') final  String entityId;
 final  Map<String, dynamic>? _oldData;
@override@JsonKey(name: 'old_data') Map<String, dynamic>? get oldData {
  final value = _oldData;
  if (value == null) return null;
  if (_oldData is EqualUnmodifiableMapView) return _oldData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _newData;
@override@JsonKey(name: 'new_data') Map<String, dynamic>? get newData {
  final value = _newData;
  if (value == null) return null;
  if (_newData is EqualUnmodifiableMapView) return _newData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'ip_address') final  String? ipAddress;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of AuditLogItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogItemModelCopyWith<_AuditLogItemModel> get copyWith => __$AuditLogItemModelCopyWithImpl<_AuditLogItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorEmail, actorEmail) || other.actorEmail == actorEmail)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other._oldData, _oldData)&&const DeepCollectionEquality().equals(other._newData, _newData)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,actorId,actorName,actorEmail,action,entityType,entityId,const DeepCollectionEquality().hash(_oldData),const DeepCollectionEquality().hash(_newData),ipAddress,createdAt);

@override
String toString() {
  return 'AuditLogItemModel(id: $id, actorId: $actorId, actorName: $actorName, actorEmail: $actorEmail, action: $action, entityType: $entityType, entityId: $entityId, oldData: $oldData, newData: $newData, ipAddress: $ipAddress, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditLogItemModelCopyWith<$Res> implements $AuditLogItemModelCopyWith<$Res> {
  factory _$AuditLogItemModelCopyWith(_AuditLogItemModel value, $Res Function(_AuditLogItemModel) _then) = __$AuditLogItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'actor_id') String? actorId,@JsonKey(name: 'actor_name') String? actorName,@JsonKey(name: 'actor_email') String? actorEmail, String action,@JsonKey(name: 'entity_type') String entityType,@JsonKey(name: 'entity_id') String entityId,@JsonKey(name: 'old_data') Map<String, dynamic>? oldData,@JsonKey(name: 'new_data') Map<String, dynamic>? newData,@JsonKey(name: 'ip_address') String? ipAddress,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$AuditLogItemModelCopyWithImpl<$Res>
    implements _$AuditLogItemModelCopyWith<$Res> {
  __$AuditLogItemModelCopyWithImpl(this._self, this._then);

  final _AuditLogItemModel _self;
  final $Res Function(_AuditLogItemModel) _then;

/// Create a copy of AuditLogItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? actorId = freezed,Object? actorName = freezed,Object? actorEmail = freezed,Object? action = null,Object? entityType = null,Object? entityId = null,Object? oldData = freezed,Object? newData = freezed,Object? ipAddress = freezed,Object? createdAt = null,}) {
  return _then(_AuditLogItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actorId: freezed == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String?,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,actorEmail: freezed == actorEmail ? _self.actorEmail : actorEmail // ignore: cast_nullable_to_non_nullable
as String?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,oldData: freezed == oldData ? _self._oldData : oldData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newData: freezed == newData ? _self._newData : newData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$AuditLogQueryResponse {

 List<AuditLogItemModel> get items; int get total; int get page; int get size;
/// Create a copy of AuditLogQueryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogQueryResponseCopyWith<AuditLogQueryResponse> get copyWith => _$AuditLogQueryResponseCopyWithImpl<AuditLogQueryResponse>(this as AuditLogQueryResponse, _$identity);

  /// Serializes this AuditLogQueryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogQueryResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,size);

@override
String toString() {
  return 'AuditLogQueryResponse(items: $items, total: $total, page: $page, size: $size)';
}


}

/// @nodoc
abstract mixin class $AuditLogQueryResponseCopyWith<$Res>  {
  factory $AuditLogQueryResponseCopyWith(AuditLogQueryResponse value, $Res Function(AuditLogQueryResponse) _then) = _$AuditLogQueryResponseCopyWithImpl;
@useResult
$Res call({
 List<AuditLogItemModel> items, int total, int page, int size
});




}
/// @nodoc
class _$AuditLogQueryResponseCopyWithImpl<$Res>
    implements $AuditLogQueryResponseCopyWith<$Res> {
  _$AuditLogQueryResponseCopyWithImpl(this._self, this._then);

  final AuditLogQueryResponse _self;
  final $Res Function(AuditLogQueryResponse) _then;

/// Create a copy of AuditLogQueryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? size = null,}) {
  return _then(AuditLogQueryResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AuditLogItemModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogQueryResponse].
extension AuditLogQueryResponsePatterns on AuditLogQueryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogQueryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogQueryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogQueryResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogQueryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogQueryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogQueryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AuditLogItemModel> items,  int total,  int page,  int size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogQueryResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AuditLogItemModel> items,  int total,  int page,  int size)  $default,) {final _that = this;
switch (_that) {
case _AuditLogQueryResponse():
return $default(_that.items,_that.total,_that.page,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AuditLogItemModel> items,  int total,  int page,  int size)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogQueryResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLogQueryResponse implements AuditLogQueryResponse {
  const _AuditLogQueryResponse({ List<AuditLogItemModel> items = const <AuditLogItemModel>[], this.total = 0, this.page = 1, this.size = 20}): _items = items;
  factory _AuditLogQueryResponse.fromJson(Map<String, dynamic> json) => _$AuditLogQueryResponseFromJson(json);

 final  List<AuditLogItemModel> _items;
@override@JsonKey() List<AuditLogItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int page;
@override@JsonKey() final  int size;

/// Create a copy of AuditLogQueryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogQueryResponseCopyWith<_AuditLogQueryResponse> get copyWith => __$AuditLogQueryResponseCopyWithImpl<_AuditLogQueryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogQueryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogQueryResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,size);

@override
String toString() {
  return 'AuditLogQueryResponse(items: $items, total: $total, page: $page, size: $size)';
}


}

/// @nodoc
abstract mixin class _$AuditLogQueryResponseCopyWith<$Res> implements $AuditLogQueryResponseCopyWith<$Res> {
  factory _$AuditLogQueryResponseCopyWith(_AuditLogQueryResponse value, $Res Function(_AuditLogQueryResponse) _then) = __$AuditLogQueryResponseCopyWithImpl;
@override @useResult
$Res call({
 List<AuditLogItemModel> items, int total, int page, int size
});




}
/// @nodoc
class __$AuditLogQueryResponseCopyWithImpl<$Res>
    implements _$AuditLogQueryResponseCopyWith<$Res> {
  __$AuditLogQueryResponseCopyWithImpl(this._self, this._then);

  final _AuditLogQueryResponse _self;
  final $Res Function(_AuditLogQueryResponse) _then;

/// Create a copy of AuditLogQueryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? size = null,}) {
  return _then(_AuditLogQueryResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AuditLogItemModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$NotificationTemplateModel {

 String get id; String get code;@JsonKey(name: 'title_template') String get titleTemplate;@JsonKey(name: 'body_template') String get bodyTemplate;@JsonKey(name: 'channel_push') bool get channelPush;@JsonKey(name: 'channel_email') bool get channelEmail;@JsonKey(name: 'channel_sms') bool get channelSms;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of NotificationTemplateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTemplateModelCopyWith<NotificationTemplateModel> get copyWith => _$NotificationTemplateModelCopyWithImpl<NotificationTemplateModel>(this as NotificationTemplateModel, _$identity);

  /// Serializes this NotificationTemplateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.titleTemplate, titleTemplate) || other.titleTemplate == titleTemplate)&&(identical(other.bodyTemplate, bodyTemplate) || other.bodyTemplate == bodyTemplate)&&(identical(other.channelPush, channelPush) || other.channelPush == channelPush)&&(identical(other.channelEmail, channelEmail) || other.channelEmail == channelEmail)&&(identical(other.channelSms, channelSms) || other.channelSms == channelSms)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,titleTemplate,bodyTemplate,channelPush,channelEmail,channelSms,isActive);

@override
String toString() {
  return 'NotificationTemplateModel(id: $id, code: $code, titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, channelPush: $channelPush, channelEmail: $channelEmail, channelSms: $channelSms, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $NotificationTemplateModelCopyWith<$Res>  {
  factory $NotificationTemplateModelCopyWith(NotificationTemplateModel value, $Res Function(NotificationTemplateModel) _then) = _$NotificationTemplateModelCopyWithImpl;
@useResult
$Res call({
 String id, String code,@JsonKey(name: 'title_template') String titleTemplate,@JsonKey(name: 'body_template') String bodyTemplate,@JsonKey(name: 'channel_push') bool channelPush,@JsonKey(name: 'channel_email') bool channelEmail,@JsonKey(name: 'channel_sms') bool channelSms,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$NotificationTemplateModelCopyWithImpl<$Res>
    implements $NotificationTemplateModelCopyWith<$Res> {
  _$NotificationTemplateModelCopyWithImpl(this._self, this._then);

  final NotificationTemplateModel _self;
  final $Res Function(NotificationTemplateModel) _then;

/// Create a copy of NotificationTemplateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? titleTemplate = null,Object? bodyTemplate = null,Object? channelPush = null,Object? channelEmail = null,Object? channelSms = null,Object? isActive = null,}) {
  return _then(NotificationTemplateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,titleTemplate: null == titleTemplate ? _self.titleTemplate : titleTemplate // ignore: cast_nullable_to_non_nullable
as String,bodyTemplate: null == bodyTemplate ? _self.bodyTemplate : bodyTemplate // ignore: cast_nullable_to_non_nullable
as String,channelPush: null == channelPush ? _self.channelPush : channelPush // ignore: cast_nullable_to_non_nullable
as bool,channelEmail: null == channelEmail ? _self.channelEmail : channelEmail // ignore: cast_nullable_to_non_nullable
as bool,channelSms: null == channelSms ? _self.channelSms : channelSms // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTemplateModel].
extension NotificationTemplateModelPatterns on NotificationTemplateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTemplateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTemplateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTemplateModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTemplateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTemplateModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTemplateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code, @JsonKey(name: 'title_template')  String titleTemplate, @JsonKey(name: 'body_template')  String bodyTemplate, @JsonKey(name: 'channel_push')  bool channelPush, @JsonKey(name: 'channel_email')  bool channelEmail, @JsonKey(name: 'channel_sms')  bool channelSms, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTemplateModel() when $default != null:
return $default(_that.id,_that.code,_that.titleTemplate,_that.bodyTemplate,_that.channelPush,_that.channelEmail,_that.channelSms,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code, @JsonKey(name: 'title_template')  String titleTemplate, @JsonKey(name: 'body_template')  String bodyTemplate, @JsonKey(name: 'channel_push')  bool channelPush, @JsonKey(name: 'channel_email')  bool channelEmail, @JsonKey(name: 'channel_sms')  bool channelSms, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _NotificationTemplateModel():
return $default(_that.id,_that.code,_that.titleTemplate,_that.bodyTemplate,_that.channelPush,_that.channelEmail,_that.channelSms,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code, @JsonKey(name: 'title_template')  String titleTemplate, @JsonKey(name: 'body_template')  String bodyTemplate, @JsonKey(name: 'channel_push')  bool channelPush, @JsonKey(name: 'channel_email')  bool channelEmail, @JsonKey(name: 'channel_sms')  bool channelSms, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTemplateModel() when $default != null:
return $default(_that.id,_that.code,_that.titleTemplate,_that.bodyTemplate,_that.channelPush,_that.channelEmail,_that.channelSms,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTemplateModel implements NotificationTemplateModel {
  const _NotificationTemplateModel({required this.id, required this.code, @JsonKey(name: 'title_template') required this.titleTemplate, @JsonKey(name: 'body_template') required this.bodyTemplate, @JsonKey(name: 'channel_push') this.channelPush = true, @JsonKey(name: 'channel_email') this.channelEmail = false, @JsonKey(name: 'channel_sms') this.channelSms = false, @JsonKey(name: 'is_active') this.isActive = true});
  factory _NotificationTemplateModel.fromJson(Map<String, dynamic> json) => _$NotificationTemplateModelFromJson(json);

@override final  String id;
@override final  String code;
@override@JsonKey(name: 'title_template') final  String titleTemplate;
@override@JsonKey(name: 'body_template') final  String bodyTemplate;
@override@JsonKey(name: 'channel_push') final  bool channelPush;
@override@JsonKey(name: 'channel_email') final  bool channelEmail;
@override@JsonKey(name: 'channel_sms') final  bool channelSms;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of NotificationTemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTemplateModelCopyWith<_NotificationTemplateModel> get copyWith => __$NotificationTemplateModelCopyWithImpl<_NotificationTemplateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTemplateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.titleTemplate, titleTemplate) || other.titleTemplate == titleTemplate)&&(identical(other.bodyTemplate, bodyTemplate) || other.bodyTemplate == bodyTemplate)&&(identical(other.channelPush, channelPush) || other.channelPush == channelPush)&&(identical(other.channelEmail, channelEmail) || other.channelEmail == channelEmail)&&(identical(other.channelSms, channelSms) || other.channelSms == channelSms)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,titleTemplate,bodyTemplate,channelPush,channelEmail,channelSms,isActive);

@override
String toString() {
  return 'NotificationTemplateModel(id: $id, code: $code, titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, channelPush: $channelPush, channelEmail: $channelEmail, channelSms: $channelSms, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$NotificationTemplateModelCopyWith<$Res> implements $NotificationTemplateModelCopyWith<$Res> {
  factory _$NotificationTemplateModelCopyWith(_NotificationTemplateModel value, $Res Function(_NotificationTemplateModel) _then) = __$NotificationTemplateModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String code,@JsonKey(name: 'title_template') String titleTemplate,@JsonKey(name: 'body_template') String bodyTemplate,@JsonKey(name: 'channel_push') bool channelPush,@JsonKey(name: 'channel_email') bool channelEmail,@JsonKey(name: 'channel_sms') bool channelSms,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$NotificationTemplateModelCopyWithImpl<$Res>
    implements _$NotificationTemplateModelCopyWith<$Res> {
  __$NotificationTemplateModelCopyWithImpl(this._self, this._then);

  final _NotificationTemplateModel _self;
  final $Res Function(_NotificationTemplateModel) _then;

/// Create a copy of NotificationTemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? titleTemplate = null,Object? bodyTemplate = null,Object? channelPush = null,Object? channelEmail = null,Object? channelSms = null,Object? isActive = null,}) {
  return _then(_NotificationTemplateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,titleTemplate: null == titleTemplate ? _self.titleTemplate : titleTemplate // ignore: cast_nullable_to_non_nullable
as String,bodyTemplate: null == bodyTemplate ? _self.bodyTemplate : bodyTemplate // ignore: cast_nullable_to_non_nullable
as String,channelPush: null == channelPush ? _self.channelPush : channelPush // ignore: cast_nullable_to_non_nullable
as bool,channelEmail: null == channelEmail ? _self.channelEmail : channelEmail // ignore: cast_nullable_to_non_nullable
as bool,channelSms: null == channelSms ? _self.channelSms : channelSms // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationTemplateUpdateRequest {

@JsonKey(name: 'title_template') String get titleTemplate;@JsonKey(name: 'body_template') String get bodyTemplate;@JsonKey(name: 'channel_push') bool? get channelPush;@JsonKey(name: 'channel_email') bool? get channelEmail;@JsonKey(name: 'is_active') bool? get isActive;
/// Create a copy of NotificationTemplateUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTemplateUpdateRequestCopyWith<NotificationTemplateUpdateRequest> get copyWith => _$NotificationTemplateUpdateRequestCopyWithImpl<NotificationTemplateUpdateRequest>(this as NotificationTemplateUpdateRequest, _$identity);

  /// Serializes this NotificationTemplateUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTemplateUpdateRequest&&(identical(other.titleTemplate, titleTemplate) || other.titleTemplate == titleTemplate)&&(identical(other.bodyTemplate, bodyTemplate) || other.bodyTemplate == bodyTemplate)&&(identical(other.channelPush, channelPush) || other.channelPush == channelPush)&&(identical(other.channelEmail, channelEmail) || other.channelEmail == channelEmail)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleTemplate,bodyTemplate,channelPush,channelEmail,isActive);

@override
String toString() {
  return 'NotificationTemplateUpdateRequest(titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, channelPush: $channelPush, channelEmail: $channelEmail, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $NotificationTemplateUpdateRequestCopyWith<$Res>  {
  factory $NotificationTemplateUpdateRequestCopyWith(NotificationTemplateUpdateRequest value, $Res Function(NotificationTemplateUpdateRequest) _then) = _$NotificationTemplateUpdateRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'title_template') String titleTemplate,@JsonKey(name: 'body_template') String bodyTemplate,@JsonKey(name: 'channel_push') bool? channelPush,@JsonKey(name: 'channel_email') bool? channelEmail,@JsonKey(name: 'is_active') bool? isActive
});




}
/// @nodoc
class _$NotificationTemplateUpdateRequestCopyWithImpl<$Res>
    implements $NotificationTemplateUpdateRequestCopyWith<$Res> {
  _$NotificationTemplateUpdateRequestCopyWithImpl(this._self, this._then);

  final NotificationTemplateUpdateRequest _self;
  final $Res Function(NotificationTemplateUpdateRequest) _then;

/// Create a copy of NotificationTemplateUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleTemplate = null,Object? bodyTemplate = null,Object? channelPush = freezed,Object? channelEmail = freezed,Object? isActive = freezed,}) {
  return _then(NotificationTemplateUpdateRequest(
titleTemplate: null == titleTemplate ? _self.titleTemplate : titleTemplate // ignore: cast_nullable_to_non_nullable
as String,bodyTemplate: null == bodyTemplate ? _self.bodyTemplate : bodyTemplate // ignore: cast_nullable_to_non_nullable
as String,channelPush: freezed == channelPush ? _self.channelPush : channelPush // ignore: cast_nullable_to_non_nullable
as bool?,channelEmail: freezed == channelEmail ? _self.channelEmail : channelEmail // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTemplateUpdateRequest].
extension NotificationTemplateUpdateRequestPatterns on NotificationTemplateUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTemplateUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTemplateUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTemplateUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTemplateUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTemplateUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTemplateUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'title_template')  String titleTemplate, @JsonKey(name: 'body_template')  String bodyTemplate, @JsonKey(name: 'channel_push')  bool? channelPush, @JsonKey(name: 'channel_email')  bool? channelEmail, @JsonKey(name: 'is_active')  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTemplateUpdateRequest() when $default != null:
return $default(_that.titleTemplate,_that.bodyTemplate,_that.channelPush,_that.channelEmail,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'title_template')  String titleTemplate, @JsonKey(name: 'body_template')  String bodyTemplate, @JsonKey(name: 'channel_push')  bool? channelPush, @JsonKey(name: 'channel_email')  bool? channelEmail, @JsonKey(name: 'is_active')  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _NotificationTemplateUpdateRequest():
return $default(_that.titleTemplate,_that.bodyTemplate,_that.channelPush,_that.channelEmail,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'title_template')  String titleTemplate, @JsonKey(name: 'body_template')  String bodyTemplate, @JsonKey(name: 'channel_push')  bool? channelPush, @JsonKey(name: 'channel_email')  bool? channelEmail, @JsonKey(name: 'is_active')  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTemplateUpdateRequest() when $default != null:
return $default(_that.titleTemplate,_that.bodyTemplate,_that.channelPush,_that.channelEmail,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTemplateUpdateRequest implements NotificationTemplateUpdateRequest {
  const _NotificationTemplateUpdateRequest({@JsonKey(name: 'title_template') required this.titleTemplate, @JsonKey(name: 'body_template') required this.bodyTemplate, @JsonKey(name: 'channel_push') this.channelPush, @JsonKey(name: 'channel_email') this.channelEmail, @JsonKey(name: 'is_active') this.isActive});
  factory _NotificationTemplateUpdateRequest.fromJson(Map<String, dynamic> json) => _$NotificationTemplateUpdateRequestFromJson(json);

@override@JsonKey(name: 'title_template') final  String titleTemplate;
@override@JsonKey(name: 'body_template') final  String bodyTemplate;
@override@JsonKey(name: 'channel_push') final  bool? channelPush;
@override@JsonKey(name: 'channel_email') final  bool? channelEmail;
@override@JsonKey(name: 'is_active') final  bool? isActive;

/// Create a copy of NotificationTemplateUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTemplateUpdateRequestCopyWith<_NotificationTemplateUpdateRequest> get copyWith => __$NotificationTemplateUpdateRequestCopyWithImpl<_NotificationTemplateUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTemplateUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTemplateUpdateRequest&&(identical(other.titleTemplate, titleTemplate) || other.titleTemplate == titleTemplate)&&(identical(other.bodyTemplate, bodyTemplate) || other.bodyTemplate == bodyTemplate)&&(identical(other.channelPush, channelPush) || other.channelPush == channelPush)&&(identical(other.channelEmail, channelEmail) || other.channelEmail == channelEmail)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleTemplate,bodyTemplate,channelPush,channelEmail,isActive);

@override
String toString() {
  return 'NotificationTemplateUpdateRequest(titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, channelPush: $channelPush, channelEmail: $channelEmail, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$NotificationTemplateUpdateRequestCopyWith<$Res> implements $NotificationTemplateUpdateRequestCopyWith<$Res> {
  factory _$NotificationTemplateUpdateRequestCopyWith(_NotificationTemplateUpdateRequest value, $Res Function(_NotificationTemplateUpdateRequest) _then) = __$NotificationTemplateUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'title_template') String titleTemplate,@JsonKey(name: 'body_template') String bodyTemplate,@JsonKey(name: 'channel_push') bool? channelPush,@JsonKey(name: 'channel_email') bool? channelEmail,@JsonKey(name: 'is_active') bool? isActive
});




}
/// @nodoc
class __$NotificationTemplateUpdateRequestCopyWithImpl<$Res>
    implements _$NotificationTemplateUpdateRequestCopyWith<$Res> {
  __$NotificationTemplateUpdateRequestCopyWithImpl(this._self, this._then);

  final _NotificationTemplateUpdateRequest _self;
  final $Res Function(_NotificationTemplateUpdateRequest) _then;

/// Create a copy of NotificationTemplateUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleTemplate = null,Object? bodyTemplate = null,Object? channelPush = freezed,Object? channelEmail = freezed,Object? isActive = freezed,}) {
  return _then(_NotificationTemplateUpdateRequest(
titleTemplate: null == titleTemplate ? _self.titleTemplate : titleTemplate // ignore: cast_nullable_to_non_nullable
as String,bodyTemplate: null == bodyTemplate ? _self.bodyTemplate : bodyTemplate // ignore: cast_nullable_to_non_nullable
as String,channelPush: freezed == channelPush ? _self.channelPush : channelPush // ignore: cast_nullable_to_non_nullable
as bool?,channelEmail: freezed == channelEmail ? _self.channelEmail : channelEmail // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
