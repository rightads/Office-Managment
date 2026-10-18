import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/errors/app_failure.dart';

part 'navigation_models.freezed.dart';
part 'navigation_models.g.dart';

@freezed
abstract class AppModuleItem with _$AppModuleItem {
  const factory AppModuleItem({
    required String id,
    required String code,
    required String label,
    @JsonKey(name: 'icon_key') required String iconKey,
    @JsonKey(name: 'route_key') required String routeKey,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'required_permission') String? requiredPermission,
    @JsonKey(name: 'is_base') @Default(false) bool isBase,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'show_on_home') @Default(true) bool showOnHome,
    String? description,
  }) = _AppModuleItem;

  factory AppModuleItem.fromJson(Map<String, dynamic> json) =>
      _$AppModuleItemFromJson(json);
}

@freezed
abstract class UserNavigationData with _$UserNavigationData {
  const factory UserNavigationData({
    @Default(<AppModuleItem>[]) List<AppModuleItem> modules,
    @Default(<String>[]) List<String> permissions,
    @JsonKey(name: 'role_name') @Default('') String roleName,
    @JsonKey(name: 'role_label') @Default('') String roleLabel,
    @JsonKey(name: 'department_id') String? departmentId,
    @JsonKey(name: 'department_name') String? departmentName,
    @JsonKey(name: 'must_change_password')
    @Default(false)
    bool mustChangePassword,
  }) = _UserNavigationData;

  factory UserNavigationData.fromJson(Map<String, dynamic> json) =>
      _$UserNavigationDataFromJson(json);
}

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState({
    @Default(false) bool isLoading,
    @Default(UserNavigationData()) UserNavigationData data,
    AppFailure? error,
    DateTime? lastRefreshedAt,
    @Default(false) bool isFromOfflineCache,
  }) = _NavigationState;
}
