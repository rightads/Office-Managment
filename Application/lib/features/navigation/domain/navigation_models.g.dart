// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppModuleItem _$AppModuleItemFromJson(Map<String, dynamic> json) =>
    _AppModuleItem(
      id: json['id'] as String,
      code: json['code'] as String,
      label: json['label'] as String,
      iconKey: json['icon_key'] as String,
      routeKey: json['route_key'] as String,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      requiredPermission: json['required_permission'] as String?,
      isBase: json['is_base'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      showOnHome: json['show_on_home'] as bool? ?? true,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AppModuleItemToJson(_AppModuleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'label': instance.label,
      'icon_key': instance.iconKey,
      'route_key': instance.routeKey,
      'sort_order': instance.sortOrder,
      'required_permission': instance.requiredPermission,
      'is_base': instance.isBase,
      'is_active': instance.isActive,
      'show_on_home': instance.showOnHome,
      'description': instance.description,
    };

_UserNavigationData _$UserNavigationDataFromJson(Map<String, dynamic> json) =>
    _UserNavigationData(
      modules:
          (json['modules'] as List<dynamic>?)
              ?.map((e) => AppModuleItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AppModuleItem>[],
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      roleName: json['role_name'] as String? ?? '',
      roleLabel: json['role_label'] as String? ?? '',
      departmentId: json['department_id'] as String?,
      departmentName: json['department_name'] as String?,
      mustChangePassword: json['must_change_password'] as bool? ?? false,
    );

Map<String, dynamic> _$UserNavigationDataToJson(_UserNavigationData instance) =>
    <String, dynamic>{
      'modules': instance.modules,
      'permissions': instance.permissions,
      'role_name': instance.roleName,
      'role_label': instance.roleLabel,
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'must_change_password': instance.mustChangePassword,
    };
