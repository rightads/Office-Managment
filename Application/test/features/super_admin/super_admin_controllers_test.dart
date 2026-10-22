import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/super_admin/application/super_admin_controllers.dart';
import 'package:right_ads/features/super_admin/data/super_admin_repository.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';

class _FakeSuperAdminRepository implements SuperAdminRepository {
  List<RoleDetailModel> rolesToReturn = [];
  List<PermissionModel> permissionsToReturn = [];
  List<SystemSettingModel> settingsToReturn = [];
  AuditLogQueryResponse? auditLogsToReturn;
  List<NotificationTemplateModel> templatesToReturn = [];

  bool createRoleCalled = false;
  bool updateRoleCalled = false;
  bool deleteRoleCalled = false;
  bool updateSettingCalled = false;
  bool updateTemplateCalled = false;

  @override
  Future<List<RoleDetailModel>> getRoles() async => rolesToReturn;

  @override
  Future<List<PermissionModel>> getPermissions() async => permissionsToReturn;

  @override
  Future<void> createRole(RoleUpsertRequest request) async {
    createRoleCalled = true;
  }

  @override
  Future<void> updateRole(String roleId, RoleUpsertRequest request) async {
    updateRoleCalled = true;
  }

  @override
  Future<void> deleteRole(String roleId) async {
    deleteRoleCalled = true;
  }

  @override
  Future<List<SystemSettingModel>> getSystemSettings() async =>
      settingsToReturn;

  @override
  Future<void> updateSystemSetting(String key, dynamic value) async {
    updateSettingCalled = true;
  }

  @override
  Future<AuditLogQueryResponse> getAuditLogs({
    int page = 1,
    int size = 20,
    String? actorId,
    String? entityType,
    String? action,
  }) async => auditLogsToReturn!;

  @override
  Future<List<NotificationTemplateModel>> getNotificationTemplates() async =>
      templatesToReturn;

  @override
  Future<void> updateNotificationTemplate(
    String code,
    NotificationTemplateUpdateRequest request,
  ) async {
    updateTemplateCalled = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const sampleRole = RoleDetailModel(
    id: 'role-1',
    name: 'CSD',
  );

  const samplePermission = PermissionModel(
    id: 'perm-1',
    code: 'tasks.view',
    description: 'View Tasks permission',
  );

  const sampleSetting = SystemSettingModel(
    key: 'app_timezone',
    value: 'UTC',
    description: 'Application Timezone',
  );

  const sampleAudit = AuditLogQueryResponse();

  const sampleTemplate = NotificationTemplateModel(
    id: 'tpl-1',
    code: 'welcome_email',
    titleTemplate: 'Welcome to Right Ads',
    bodyTemplate: 'Hello and welcome',
    channelEmail: true,
  );

  group('Super Admin Controllers Suite', () {
    test(
      'SuperAdminRolesController loads, creates, updates, and deletes roles',
      () async {
        final fakeRepo = _FakeSuperAdminRepository()
          ..rolesToReturn = [sampleRole]
          ..permissionsToReturn = [samplePermission];

        final container = ProviderContainer(
          overrides: [
            superAdminRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          superAdminRolesControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          superAdminRolesControllerProvider.notifier,
        );
        await controller.loadRolesAndPermissions();

        final state = container.read(superAdminRolesControllerProvider);
        expect(state.isLoading, isFalse);
        expect(state.roles.length, 1);
        expect(state.permissions.length, 1);

        final created = await controller.saveRole(
          name: 'Tele Sales',
          permissionIds: ['perm-1'],
        );
        expect(created, isTrue);
        expect(fakeRepo.createRoleCalled, isTrue);

        final updated = await controller.saveRole(
          roleId: 'role-1',
          name: 'CSD Senior',
          permissionIds: ['perm-1'],
        );
        expect(updated, isTrue);
        expect(fakeRepo.updateRoleCalled, isTrue);

        final deleted = await controller.deleteRole('role-1');
        expect(deleted, isTrue);
        expect(fakeRepo.deleteRoleCalled, isTrue);
      },
    );

    test(
      'SuperAdminSettingsController loads and updates system settings',
      () async {
        final fakeRepo = _FakeSuperAdminRepository()
          ..settingsToReturn = [sampleSetting];

        final container = ProviderContainer(
          overrides: [
            superAdminRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          superAdminSettingsControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          superAdminSettingsControllerProvider.notifier,
        );
        await controller.loadSettings();

        final state = container.read(superAdminSettingsControllerProvider);
        expect(state.isLoading, isFalse);
        expect(state.settings.length, 1);

        final updated = await controller.updateSetting(
          'app_timezone',
          'Asia/Kolkata',
        );
        expect(updated, isTrue);
        expect(fakeRepo.updateSettingCalled, isTrue);
      },
    );

    test('SuperAdminAuditController loads and filters audit trail', () async {
      final fakeRepo = _FakeSuperAdminRepository()
        ..auditLogsToReturn = sampleAudit;

      final container = ProviderContainer(
        overrides: [
          superAdminRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      final sub = container.listen(
        superAdminAuditControllerProvider,
        (_, _) {},
      );
      addTearDown(() {
        sub.close();
        container.dispose();
      });

      final controller = container.read(
        superAdminAuditControllerProvider.notifier,
      );
      await controller.loadLogs();

      var state = container.read(superAdminAuditControllerProvider);
      expect(state.isLoading, isFalse);

      controller.setFilter(entityType: 'employee', action: 'CREATE');

      state = container.read(superAdminAuditControllerProvider);
      expect(state.filterEntityType, 'employee');
      expect(state.filterAction, 'CREATE');
    });

    test(
      'SuperAdminTemplatesController loads and updates notification templates',
      () async {
        final fakeRepo = _FakeSuperAdminRepository()
          ..templatesToReturn = [sampleTemplate];

        final container = ProviderContainer(
          overrides: [
            superAdminRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          superAdminTemplatesControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          superAdminTemplatesControllerProvider.notifier,
        );
        await controller.loadTemplates();

        final state = container.read(superAdminTemplatesControllerProvider);
        expect(state.isLoading, isFalse);
        expect(state.templates.length, 1);

        const req = NotificationTemplateUpdateRequest(
          titleTemplate: 'Welcome Employee',
          bodyTemplate: 'Welcome to our platform',
          isActive: true,
        );
        final updated = await controller.updateTemplate('welcome_email', req);
        expect(updated, isTrue);
        expect(fakeRepo.updateTemplateCalled, isTrue);
      },
    );
  });
}
