// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationItemModel {

 String get id; String get title; String get body; String get type;@JsonKey(name: 'is_read') bool get isRead;@JsonKey(name: 'created_at') DateTime get createdAt; Map<String, dynamic> get data;
/// Create a copy of NotificationItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationItemModelCopyWith<NotificationItemModel> get copyWith => _$NotificationItemModelCopyWithImpl<NotificationItemModel>(this as NotificationItemModel, _$identity);

  /// Serializes this NotificationItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,isRead,createdAt,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NotificationItemModel(id: $id, title: $title, body: $body, type: $type, isRead: $isRead, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class $NotificationItemModelCopyWith<$Res>  {
  factory $NotificationItemModelCopyWith(NotificationItemModel value, $Res Function(NotificationItemModel) _then) = _$NotificationItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, String type,@JsonKey(name: 'is_read') bool isRead,@JsonKey(name: 'created_at') DateTime createdAt, Map<String, dynamic> data
});




}
/// @nodoc
class _$NotificationItemModelCopyWithImpl<$Res>
    implements $NotificationItemModelCopyWith<$Res> {
  _$NotificationItemModelCopyWithImpl(this._self, this._then);

  final NotificationItemModel _self;
  final $Res Function(NotificationItemModel) _then;

/// Create a copy of NotificationItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? isRead = null,Object? createdAt = null,Object? data = null,}) {
  return _then(NotificationItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationItemModel].
extension NotificationItemModelPatterns on NotificationItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationItemModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  String type, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationItemModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.isRead,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  String type, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic> data)  $default,) {final _that = this;
switch (_that) {
case _NotificationItemModel():
return $default(_that.id,_that.title,_that.body,_that.type,_that.isRead,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  String type, @JsonKey(name: 'is_read')  bool isRead, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic> data)?  $default,) {final _that = this;
switch (_that) {
case _NotificationItemModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.isRead,_that.createdAt,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationItemModel implements NotificationItemModel {
  const _NotificationItemModel({required this.id, required this.title, required this.body, required this.type, @JsonKey(name: 'is_read') required this.isRead, @JsonKey(name: 'created_at') required this.createdAt,  Map<String, dynamic> data = const <String, dynamic>{}}): _data = data;
  factory _NotificationItemModel.fromJson(Map<String, dynamic> json) => _$NotificationItemModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String body;
@override final  String type;
@override@JsonKey(name: 'is_read') final  bool isRead;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of NotificationItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationItemModelCopyWith<_NotificationItemModel> get copyWith => __$NotificationItemModelCopyWithImpl<_NotificationItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,isRead,createdAt,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NotificationItemModel(id: $id, title: $title, body: $body, type: $type, isRead: $isRead, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class _$NotificationItemModelCopyWith<$Res> implements $NotificationItemModelCopyWith<$Res> {
  factory _$NotificationItemModelCopyWith(_NotificationItemModel value, $Res Function(_NotificationItemModel) _then) = __$NotificationItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, String type,@JsonKey(name: 'is_read') bool isRead,@JsonKey(name: 'created_at') DateTime createdAt, Map<String, dynamic> data
});




}
/// @nodoc
class __$NotificationItemModelCopyWithImpl<$Res>
    implements _$NotificationItemModelCopyWith<$Res> {
  __$NotificationItemModelCopyWithImpl(this._self, this._then);

  final _NotificationItemModel _self;
  final $Res Function(_NotificationItemModel) _then;

/// Create a copy of NotificationItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? isRead = null,Object? createdAt = null,Object? data = null,}) {
  return _then(_NotificationItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$NotificationPageResponse {

 List<NotificationItemModel> get items; int get total; int get page;@JsonKey(name: 'page_size') int get pageSize;@JsonKey(name: 'total_pages') int get totalPages;
/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPageResponseCopyWith<NotificationPageResponse> get copyWith => _$NotificationPageResponseCopyWithImpl<NotificationPageResponse>(this as NotificationPageResponse, _$identity);

  /// Serializes this NotificationPageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPageResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,pageSize,totalPages);

@override
String toString() {
  return 'NotificationPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $NotificationPageResponseCopyWith<$Res>  {
  factory $NotificationPageResponseCopyWith(NotificationPageResponse value, $Res Function(NotificationPageResponse) _then) = _$NotificationPageResponseCopyWithImpl;
@useResult
$Res call({
 List<NotificationItemModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class _$NotificationPageResponseCopyWithImpl<$Res>
    implements $NotificationPageResponseCopyWith<$Res> {
  _$NotificationPageResponseCopyWithImpl(this._self, this._then);

  final NotificationPageResponse _self;
  final $Res Function(NotificationPageResponse) _then;

/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,}) {
  return _then(NotificationPageResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationItemModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPageResponse].
extension NotificationPageResponsePatterns on NotificationPageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPageResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationItemModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationItemModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _NotificationPageResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationItemModel> items,  int total,  int page, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'total_pages')  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPageResponse() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.pageSize,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPageResponse implements NotificationPageResponse {
  const _NotificationPageResponse({required  List<NotificationItemModel> items, required this.total, required this.page, @JsonKey(name: 'page_size') required this.pageSize, @JsonKey(name: 'total_pages') required this.totalPages}): _items = items;
  factory _NotificationPageResponse.fromJson(Map<String, dynamic> json) => _$NotificationPageResponseFromJson(json);

 final  List<NotificationItemModel> _items;
@override List<NotificationItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override final  int page;
@override@JsonKey(name: 'page_size') final  int pageSize;
@override@JsonKey(name: 'total_pages') final  int totalPages;

/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPageResponseCopyWith<_NotificationPageResponse> get copyWith => __$NotificationPageResponseCopyWithImpl<_NotificationPageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPageResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,pageSize,totalPages);

@override
String toString() {
  return 'NotificationPageResponse(items: $items, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$NotificationPageResponseCopyWith<$Res> implements $NotificationPageResponseCopyWith<$Res> {
  factory _$NotificationPageResponseCopyWith(_NotificationPageResponse value, $Res Function(_NotificationPageResponse) _then) = __$NotificationPageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationItemModel> items, int total, int page,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class __$NotificationPageResponseCopyWithImpl<$Res>
    implements _$NotificationPageResponseCopyWith<$Res> {
  __$NotificationPageResponseCopyWithImpl(this._self, this._then);

  final _NotificationPageResponse _self;
  final $Res Function(_NotificationPageResponse) _then;

/// Create a copy of NotificationPageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,}) {
  return _then(_NotificationPageResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationItemModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AnnouncementModel {

 String get id; String get title; String get body; UserBriefModel get creator;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'target_department_id') String? get targetDepartmentId;@JsonKey(name: 'target_department_name') String? get targetDepartmentName;@JsonKey(name: 'expires_at') DateTime? get expiresAt;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementModelCopyWith<AnnouncementModel> get copyWith => _$AnnouncementModelCopyWithImpl<AnnouncementModel>(this as AnnouncementModel, _$identity);

  /// Serializes this AnnouncementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.targetDepartmentId, targetDepartmentId) || other.targetDepartmentId == targetDepartmentId)&&(identical(other.targetDepartmentName, targetDepartmentName) || other.targetDepartmentName == targetDepartmentName)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,creator,createdAt,targetDepartmentId,targetDepartmentName,expiresAt,isActive);

@override
String toString() {
  return 'AnnouncementModel(id: $id, title: $title, body: $body, creator: $creator, createdAt: $createdAt, targetDepartmentId: $targetDepartmentId, targetDepartmentName: $targetDepartmentName, expiresAt: $expiresAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $AnnouncementModelCopyWith<$Res>  {
  factory $AnnouncementModelCopyWith(AnnouncementModel value, $Res Function(AnnouncementModel) _then) = _$AnnouncementModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, UserBriefModel creator,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'target_department_id') String? targetDepartmentId,@JsonKey(name: 'target_department_name') String? targetDepartmentName,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'is_active') bool isActive
});


$UserBriefModelCopyWith<$Res> get creator;

}
/// @nodoc
class _$AnnouncementModelCopyWithImpl<$Res>
    implements $AnnouncementModelCopyWith<$Res> {
  _$AnnouncementModelCopyWithImpl(this._self, this._then);

  final AnnouncementModel _self;
  final $Res Function(AnnouncementModel) _then;

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? creator = null,Object? createdAt = null,Object? targetDepartmentId = freezed,Object? targetDepartmentName = freezed,Object? expiresAt = freezed,Object? isActive = null,}) {
  return _then(AnnouncementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetDepartmentId: freezed == targetDepartmentId ? _self.targetDepartmentId : targetDepartmentId // ignore: cast_nullable_to_non_nullable
as String?,targetDepartmentName: freezed == targetDepartmentName ? _self.targetDepartmentName : targetDepartmentName // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get creator {
  
  return $UserBriefModelCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnnouncementModel].
extension AnnouncementModelPatterns on AnnouncementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementModel value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementModel value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  UserBriefModel creator, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'target_department_id')  String? targetDepartmentId, @JsonKey(name: 'target_department_name')  String? targetDepartmentName, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.creator,_that.createdAt,_that.targetDepartmentId,_that.targetDepartmentName,_that.expiresAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  UserBriefModel creator, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'target_department_id')  String? targetDepartmentId, @JsonKey(name: 'target_department_name')  String? targetDepartmentName, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementModel():
return $default(_that.id,_that.title,_that.body,_that.creator,_that.createdAt,_that.targetDepartmentId,_that.targetDepartmentName,_that.expiresAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  UserBriefModel creator, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'target_department_id')  String? targetDepartmentId, @JsonKey(name: 'target_department_name')  String? targetDepartmentName, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.creator,_that.createdAt,_that.targetDepartmentId,_that.targetDepartmentName,_that.expiresAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementModel extends AnnouncementModel {
  const _AnnouncementModel({required this.id, required this.title, required this.body, required this.creator, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'target_department_id') this.targetDepartmentId, @JsonKey(name: 'target_department_name') this.targetDepartmentName, @JsonKey(name: 'expires_at') this.expiresAt, @JsonKey(name: 'is_active') this.isActive = true}): super._();
  factory _AnnouncementModel.fromJson(Map<String, dynamic> json) => _$AnnouncementModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String body;
@override final  UserBriefModel creator;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'target_department_id') final  String? targetDepartmentId;
@override@JsonKey(name: 'target_department_name') final  String? targetDepartmentName;
@override@JsonKey(name: 'expires_at') final  DateTime? expiresAt;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementModelCopyWith<_AnnouncementModel> get copyWith => __$AnnouncementModelCopyWithImpl<_AnnouncementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.targetDepartmentId, targetDepartmentId) || other.targetDepartmentId == targetDepartmentId)&&(identical(other.targetDepartmentName, targetDepartmentName) || other.targetDepartmentName == targetDepartmentName)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,creator,createdAt,targetDepartmentId,targetDepartmentName,expiresAt,isActive);

@override
String toString() {
  return 'AnnouncementModel(id: $id, title: $title, body: $body, creator: $creator, createdAt: $createdAt, targetDepartmentId: $targetDepartmentId, targetDepartmentName: $targetDepartmentName, expiresAt: $expiresAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementModelCopyWith<$Res> implements $AnnouncementModelCopyWith<$Res> {
  factory _$AnnouncementModelCopyWith(_AnnouncementModel value, $Res Function(_AnnouncementModel) _then) = __$AnnouncementModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, UserBriefModel creator,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'target_department_id') String? targetDepartmentId,@JsonKey(name: 'target_department_name') String? targetDepartmentName,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'is_active') bool isActive
});


@override $UserBriefModelCopyWith<$Res> get creator;

}
/// @nodoc
class __$AnnouncementModelCopyWithImpl<$Res>
    implements _$AnnouncementModelCopyWith<$Res> {
  __$AnnouncementModelCopyWithImpl(this._self, this._then);

  final _AnnouncementModel _self;
  final $Res Function(_AnnouncementModel) _then;

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? creator = null,Object? createdAt = null,Object? targetDepartmentId = freezed,Object? targetDepartmentName = freezed,Object? expiresAt = freezed,Object? isActive = null,}) {
  return _then(_AnnouncementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserBriefModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetDepartmentId: freezed == targetDepartmentId ? _self.targetDepartmentId : targetDepartmentId // ignore: cast_nullable_to_non_nullable
as String?,targetDepartmentName: freezed == targetDepartmentName ? _self.targetDepartmentName : targetDepartmentName // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserBriefModelCopyWith<$Res> get creator {
  
  return $UserBriefModelCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// @nodoc
mixin _$DeviceTokenRegisterPayload {

@JsonKey(name: 'fcm_token') String get fcmToken;@JsonKey(name: 'device_id') String get deviceId; String get platform;
/// Create a copy of DeviceTokenRegisterPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceTokenRegisterPayloadCopyWith<DeviceTokenRegisterPayload> get copyWith => _$DeviceTokenRegisterPayloadCopyWithImpl<DeviceTokenRegisterPayload>(this as DeviceTokenRegisterPayload, _$identity);

  /// Serializes this DeviceTokenRegisterPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenRegisterPayload&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fcmToken,deviceId,platform);

@override
String toString() {
  return 'DeviceTokenRegisterPayload(fcmToken: $fcmToken, deviceId: $deviceId, platform: $platform)';
}


}

/// @nodoc
abstract mixin class $DeviceTokenRegisterPayloadCopyWith<$Res>  {
  factory $DeviceTokenRegisterPayloadCopyWith(DeviceTokenRegisterPayload value, $Res Function(DeviceTokenRegisterPayload) _then) = _$DeviceTokenRegisterPayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'fcm_token') String fcmToken,@JsonKey(name: 'device_id') String deviceId, String platform
});




}
/// @nodoc
class _$DeviceTokenRegisterPayloadCopyWithImpl<$Res>
    implements $DeviceTokenRegisterPayloadCopyWith<$Res> {
  _$DeviceTokenRegisterPayloadCopyWithImpl(this._self, this._then);

  final DeviceTokenRegisterPayload _self;
  final $Res Function(DeviceTokenRegisterPayload) _then;

/// Create a copy of DeviceTokenRegisterPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fcmToken = null,Object? deviceId = null,Object? platform = null,}) {
  return _then(DeviceTokenRegisterPayload(
fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceTokenRegisterPayload].
extension DeviceTokenRegisterPayloadPatterns on DeviceTokenRegisterPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceTokenRegisterPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceTokenRegisterPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceTokenRegisterPayload value)  $default,){
final _that = this;
switch (_that) {
case _DeviceTokenRegisterPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceTokenRegisterPayload value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceTokenRegisterPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'fcm_token')  String fcmToken, @JsonKey(name: 'device_id')  String deviceId,  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceTokenRegisterPayload() when $default != null:
return $default(_that.fcmToken,_that.deviceId,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'fcm_token')  String fcmToken, @JsonKey(name: 'device_id')  String deviceId,  String platform)  $default,) {final _that = this;
switch (_that) {
case _DeviceTokenRegisterPayload():
return $default(_that.fcmToken,_that.deviceId,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'fcm_token')  String fcmToken, @JsonKey(name: 'device_id')  String deviceId,  String platform)?  $default,) {final _that = this;
switch (_that) {
case _DeviceTokenRegisterPayload() when $default != null:
return $default(_that.fcmToken,_that.deviceId,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceTokenRegisterPayload implements DeviceTokenRegisterPayload {
  const _DeviceTokenRegisterPayload({@JsonKey(name: 'fcm_token') required this.fcmToken, @JsonKey(name: 'device_id') required this.deviceId, required this.platform});
  factory _DeviceTokenRegisterPayload.fromJson(Map<String, dynamic> json) => _$DeviceTokenRegisterPayloadFromJson(json);

@override@JsonKey(name: 'fcm_token') final  String fcmToken;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override final  String platform;

/// Create a copy of DeviceTokenRegisterPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceTokenRegisterPayloadCopyWith<_DeviceTokenRegisterPayload> get copyWith => __$DeviceTokenRegisterPayloadCopyWithImpl<_DeviceTokenRegisterPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceTokenRegisterPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceTokenRegisterPayload&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fcmToken,deviceId,platform);

@override
String toString() {
  return 'DeviceTokenRegisterPayload(fcmToken: $fcmToken, deviceId: $deviceId, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$DeviceTokenRegisterPayloadCopyWith<$Res> implements $DeviceTokenRegisterPayloadCopyWith<$Res> {
  factory _$DeviceTokenRegisterPayloadCopyWith(_DeviceTokenRegisterPayload value, $Res Function(_DeviceTokenRegisterPayload) _then) = __$DeviceTokenRegisterPayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'fcm_token') String fcmToken,@JsonKey(name: 'device_id') String deviceId, String platform
});




}
/// @nodoc
class __$DeviceTokenRegisterPayloadCopyWithImpl<$Res>
    implements _$DeviceTokenRegisterPayloadCopyWith<$Res> {
  __$DeviceTokenRegisterPayloadCopyWithImpl(this._self, this._then);

  final _DeviceTokenRegisterPayload _self;
  final $Res Function(_DeviceTokenRegisterPayload) _then;

/// Create a copy of DeviceTokenRegisterPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fcmToken = null,Object? deviceId = null,Object? platform = null,}) {
  return _then(_DeviceTokenRegisterPayload(
fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DeviceTokenResponseModel {

 String get id;@JsonKey(name: 'device_id') String get deviceId; String get platform;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of DeviceTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceTokenResponseModelCopyWith<DeviceTokenResponseModel> get copyWith => _$DeviceTokenResponseModelCopyWithImpl<DeviceTokenResponseModel>(this as DeviceTokenResponseModel, _$identity);

  /// Serializes this DeviceTokenResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,platform,createdAt);

@override
String toString() {
  return 'DeviceTokenResponseModel(id: $id, deviceId: $deviceId, platform: $platform, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DeviceTokenResponseModelCopyWith<$Res>  {
  factory $DeviceTokenResponseModelCopyWith(DeviceTokenResponseModel value, $Res Function(DeviceTokenResponseModel) _then) = _$DeviceTokenResponseModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'device_id') String deviceId, String platform,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$DeviceTokenResponseModelCopyWithImpl<$Res>
    implements $DeviceTokenResponseModelCopyWith<$Res> {
  _$DeviceTokenResponseModelCopyWithImpl(this._self, this._then);

  final DeviceTokenResponseModel _self;
  final $Res Function(DeviceTokenResponseModel) _then;

/// Create a copy of DeviceTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceId = null,Object? platform = null,Object? createdAt = null,}) {
  return _then(DeviceTokenResponseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceTokenResponseModel].
extension DeviceTokenResponseModelPatterns on DeviceTokenResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceTokenResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceTokenResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceTokenResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _DeviceTokenResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceTokenResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceTokenResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'device_id')  String deviceId,  String platform, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceTokenResponseModel() when $default != null:
return $default(_that.id,_that.deviceId,_that.platform,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'device_id')  String deviceId,  String platform, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceTokenResponseModel():
return $default(_that.id,_that.deviceId,_that.platform,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'device_id')  String deviceId,  String platform, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceTokenResponseModel() when $default != null:
return $default(_that.id,_that.deviceId,_that.platform,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceTokenResponseModel implements DeviceTokenResponseModel {
  const _DeviceTokenResponseModel({required this.id, @JsonKey(name: 'device_id') required this.deviceId, required this.platform, @JsonKey(name: 'created_at') required this.createdAt});
  factory _DeviceTokenResponseModel.fromJson(Map<String, dynamic> json) => _$DeviceTokenResponseModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override final  String platform;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of DeviceTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceTokenResponseModelCopyWith<_DeviceTokenResponseModel> get copyWith => __$DeviceTokenResponseModelCopyWithImpl<_DeviceTokenResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceTokenResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceTokenResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,platform,createdAt);

@override
String toString() {
  return 'DeviceTokenResponseModel(id: $id, deviceId: $deviceId, platform: $platform, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceTokenResponseModelCopyWith<$Res> implements $DeviceTokenResponseModelCopyWith<$Res> {
  factory _$DeviceTokenResponseModelCopyWith(_DeviceTokenResponseModel value, $Res Function(_DeviceTokenResponseModel) _then) = __$DeviceTokenResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'device_id') String deviceId, String platform,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$DeviceTokenResponseModelCopyWithImpl<$Res>
    implements _$DeviceTokenResponseModelCopyWith<$Res> {
  __$DeviceTokenResponseModelCopyWithImpl(this._self, this._then);

  final _DeviceTokenResponseModel _self;
  final $Res Function(_DeviceTokenResponseModel) _then;

/// Create a copy of DeviceTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceId = null,Object? platform = null,Object? createdAt = null,}) {
  return _then(_DeviceTokenResponseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
