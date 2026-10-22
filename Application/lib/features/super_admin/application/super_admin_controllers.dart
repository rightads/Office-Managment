import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/super_admin_repository.dart';
import '../domain/super_admin_models.dart';

part 'super_admin_controllers.freezed.dart';
part 'super_admin_controllers.g.dart';

// -------------------------------------------------------------
// 1. Roles & Permissions State & Controller
// -------------------------------------------------------------
@freezed
abstract class SuperAdminRolesState with _$SuperAdminRolesState {
  const factory SuperAdminRolesState({
    @Default(<RoleDetailModel>[]) List<RoleDetailModel> roles,
    @Default(<PermissionModel>[]) List<PermissionModel> permissions,
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _SuperAdminRolesState;
}

@riverpod
class SuperAdminRolesController extends _$SuperAdminRolesController {
  @override
  SuperAdminRolesState build() {
    state = const SuperAdminRolesState();
    loadRolesAndPermissions();
    return state;
  }

  Future<void> loadRolesAndPermissions() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      final roles = await repo.getRoles();
      final permissions = await repo.getPermissions();
      state = state.copyWith(
        roles: roles,
        permissions: permissions,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> saveRole({
    String? roleId,
    required String name,
    String? description,
    required List<String> permissionIds,
  }) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      final req = RoleUpsertRequest(
        name: name,
        description: description,
        permissionIds: permissionIds,
      );
      if (roleId != null) {
        await repo.updateRole(roleId, req);
      } else {
        await repo.createRole(req);
      }
      await loadRolesAndPermissions();
      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> deleteRole(String roleId) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      await repo.deleteRole(roleId);
      await loadRolesAndPermissions();
      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: e.toString());
      return false;
    }
  }
}

// -------------------------------------------------------------
// 2. System Settings State & Controller
// -------------------------------------------------------------
@freezed
abstract class SuperAdminSettingsState with _$SuperAdminSettingsState {
  const factory SuperAdminSettingsState({
    @Default(<SystemSettingModel>[]) List<SystemSettingModel> settings,
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _SuperAdminSettingsState;
}

@riverpod
class SuperAdminSettingsController extends _$SuperAdminSettingsController {
  @override
  SuperAdminSettingsState build() {
    state = const SuperAdminSettingsState();
    loadSettings();
    return state;
  }

  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      final items = await repo.getSystemSettings();
      state = state.copyWith(settings: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> updateSetting(String key, dynamic value) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      await repo.updateSystemSetting(key, value);
      await loadSettings();
      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: e.toString());
      return false;
    }
  }
}

// -------------------------------------------------------------
// 3. Audit Logs State & Controller
// -------------------------------------------------------------
@freezed
abstract class SuperAdminAuditState with _$SuperAdminAuditState {
  const factory SuperAdminAuditState({
    @Default(<AuditLogItemModel>[]) List<AuditLogItemModel> logs,
    @Default(1) int page,
    @Default(0) int total,
    @Default(true) bool isLoading,
    String? filterActorId,
    String? filterEntityType,
    String? filterAction,
    String? errorMessage,
  }) = _SuperAdminAuditState;
}

@riverpod
class SuperAdminAuditController extends _$SuperAdminAuditController {
  @override
  SuperAdminAuditState build() {
    state = const SuperAdminAuditState();
    loadLogs();
    return state;
  }

  Future<void> loadLogs({int page = 1}) async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: page);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      final res = await repo.getAuditLogs(
        page: page,
        actorId: state.filterActorId,
        entityType: state.filterEntityType,
        action: state.filterAction,
      );
      state = state.copyWith(
        logs: res.items,
        total: res.total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setFilter({String? actorId, String? entityType, String? action}) {
    state = state.copyWith(
      filterActorId: actorId,
      filterEntityType: entityType,
      filterAction: action,
    );
    loadLogs(page: 1);
  }
}

// -------------------------------------------------------------
// 4. Notification Templates State & Controller
// -------------------------------------------------------------
@freezed
abstract class SuperAdminTemplatesState with _$SuperAdminTemplatesState {
  const factory SuperAdminTemplatesState({
    @Default(<NotificationTemplateModel>[])
    List<NotificationTemplateModel> templates,
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _SuperAdminTemplatesState;
}

@riverpod
class SuperAdminTemplatesController extends _$SuperAdminTemplatesController {
  @override
  SuperAdminTemplatesState build() {
    state = const SuperAdminTemplatesState();
    loadTemplates();
    return state;
  }

  Future<void> loadTemplates() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      final items = await repo.getNotificationTemplates();
      state = state.copyWith(templates: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> updateTemplate(
    String code,
    NotificationTemplateUpdateRequest req,
  ) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      final repo = ref.read(superAdminRepositoryProvider);
      await repo.updateNotificationTemplate(code, req);
      await loadTemplates();
      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: e.toString());
      return false;
    }
  }
}
