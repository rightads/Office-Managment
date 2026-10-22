import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin/application/bulk_import_controller.dart';
import 'package:right_ads/features/admin/application/employee_detail_controller.dart';
import 'package:right_ads/features/admin/application/employee_list_controller.dart';
import 'package:right_ads/features/admin/application/master_data_controller.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';

class _FakeAdminRepository implements AdminRepository {
  List<RoleItem> rolesToReturn = [];
  List<EmployeeItem> employeesToReturn = [];
  EmployeeItem? employeeDetailToReturn;
  List<MasterDataItem> masterDataToReturn = [];
  BulkImportReport? bulkImportReportToReturn;

  bool activateCalled = false;
  bool deactivateCalled = false;
  bool resetDeviceCalled = false;
  bool resetPasswordCalled = false;
  bool assignRoleCalled = false;
  bool assignManagerCalled = false;
  bool assignPolicyCalled = false;

  @override
  Future<List<RoleItem>> getRoles() async => rolesToReturn;

  @override
  Future<List<EmployeeItem>> getEmployees({
    String? search,
    String? departmentId,
    String? roleId,
    bool? isActive,
    int page = 1,
    int pageSize = 20,
  }) async => employeesToReturn;

  @override
  Future<EmployeeItem> getEmployeeDetail(String id) async =>
      employeeDetailToReturn!;

  @override
  Future<void> activateEmployee(String id) async {
    activateCalled = true;
  }

  @override
  Future<void> deactivateEmployee(String id) async {
    deactivateCalled = true;
  }

  @override
  Future<void> resetPassword(String id, {String? newPassword}) async {
    resetPasswordCalled = true;
  }

  @override
  Future<void> resetDevice(String userId) async {
    resetDeviceCalled = true;
  }

  @override
  Future<void> assignRole(String id, String roleId) async {
    assignRoleCalled = true;
  }

  @override
  Future<void> assignManager(String id, String? managerId) async {
    assignManagerCalled = true;
  }

  @override
  Future<void> assignAttendancePolicy(String id, String? policyId) async {
    assignPolicyCalled = true;
  }

  @override
  Future<List<MasterDataItem>> getMasterDataList(String basePath) async =>
      masterDataToReturn;

  @override
  Future<MasterDataItem> createMasterDataItem(
    String basePath,
    Map<String, dynamic> data,
  ) async => MasterDataItem(
    id: 'md-new',
    name: data['name']?.toString() ?? '',
    code: data['code']?.toString(),
    isActive: true,
  );

  @override
  Future<MasterDataItem> updateMasterDataItem(
    String itemPath,
    Map<String, dynamic> data,
  ) async => MasterDataItem(
    id: 'md-1',
    name: data['name']?.toString() ?? '',
    code: data['code']?.toString(),
    isActive: true,
  );

  @override
  Future<void> deleteMasterDataItem(String itemPath) async {}

  @override
  Future<BulkImportReport> bulkImportEmployees({
    required List<int> fileBytes,
    required String fileName,
    bool dryRun = false,
  }) async => bulkImportReportToReturn!;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const sampleEmployee = EmployeeItem(
    id: 'emp-1',
    employeeCode: 'EMP001',
    email: 'test@agency.com',
    fullName: 'Jane Doe',
    isActive: true,
    mustChangePassword: false,
    roleId: 'role-1',
    createdAt: '2026-10-22T00:00:00Z',
  );

  const sampleRole = RoleItem(
    id: 'role-1',
    name: 'Admin',
    isSystem: true,
    isActive: true,
    createdAt: '2026-10-22T00:00:00Z',
  );

  const sampleMasterData = MasterDataItem(
    id: 'dept-1',
    name: 'Design',
    code: 'DES',
    isActive: true,
  );

  group('Admin Controllers Suite', () {
    test(
      'EmployeeListController loads, filters, and paginates employees',
      () async {
        final fakeRepo = _FakeAdminRepository()
          ..rolesToReturn = [sampleRole]
          ..employeesToReturn = [sampleEmployee];

        final container = ProviderContainer(
          overrides: [
            adminRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          employeeListControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          employeeListControllerProvider.notifier,
        );
        await controller.loadInitial();

        var state = container.read(employeeListControllerProvider);
        expect(state.isLoading, isFalse);
        expect(state.employees.length, 1);
        expect(state.roles.length, 1);

        controller.onSearchChanged('Jane');
        await controller.loadInitial();
        controller.onDepartmentFilterChanged('dept-1');
        await controller.loadInitial();
        controller.onRoleFilterChanged('role-1');
        await controller.loadInitial();
        controller.onActiveFilterChanged(true);
        await controller.loadInitial();

        state = container.read(employeeListControllerProvider);
        expect(state.search, 'Jane');
        expect(state.departmentId, 'dept-1');
        expect(state.roleId, 'role-1');
        expect(state.isActive, isTrue);
      },
    );

    test(
      'EmployeeDetailController loads and executes administrative actions',
      () async {
        final fakeRepo = _FakeAdminRepository()
          ..employeeDetailToReturn = sampleEmployee;

        final container = ProviderContainer(
          overrides: [
            adminRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          employeeDetailControllerProvider('emp-1'),
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          employeeDetailControllerProvider('emp-1').notifier,
        );
        await controller.loadEmployee('emp-1');

        final state = container.read(employeeDetailControllerProvider('emp-1'));
        expect(state.employee?.fullName, 'Jane Doe');

        final activated = await controller.activate('emp-1');
        expect(activated, isTrue);
        expect(fakeRepo.activateCalled, isTrue);

        final deactivated = await controller.deactivate('emp-1');
        expect(deactivated, isTrue);
        expect(fakeRepo.deactivateCalled, isTrue);

        final resetDev = await controller.resetDevice('emp-1');
        expect(resetDev, isTrue);
        expect(fakeRepo.resetDeviceCalled, isTrue);

        final resetPass = await controller.resetPassword(
          'emp-1',
          newPassword: 'NewPassword123!',
        );
        expect(resetPass, isTrue);
        expect(fakeRepo.resetPasswordCalled, isTrue);

        final roleAssigned = await controller.assignRole('emp-1', 'role-2');
        expect(roleAssigned, isTrue);
        expect(fakeRepo.assignRoleCalled, isTrue);

        final managerAssigned = await controller.assignManager(
          'emp-1',
          'emp-mgr',
        );
        expect(managerAssigned, isTrue);
        expect(fakeRepo.assignManagerCalled, isTrue);

        final policyAssigned = await controller.assignPolicy('emp-1', 'pol-1');
        expect(policyAssigned, isTrue);
        expect(fakeRepo.assignPolicyCalled, isTrue);
      },
    );

    test(
      'MasterDataController loads items, creates, updates, and deletes',
      () async {
        final fakeRepo = _FakeAdminRepository()
          ..masterDataToReturn = [sampleMasterData];

        final container = ProviderContainer(
          overrides: [
            adminRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          masterDataControllerProvider('/departments').notifier,
        );
        await controller.loadItems('/departments');

        final state = container.read(
          masterDataControllerProvider('/departments'),
        );
        expect(state.items.length, 1);

        final created = await controller.createItem('/departments', {
          'name': 'Marketing',
          'code': 'MKT',
        });
        expect(created, isTrue);

        final updated = await controller.updateItem('/departments/dept-1', {
          'name': 'Marketing',
          'code': 'MKT',
        });
        expect(updated, isTrue);

        final deleted = await controller.deleteItem('/departments/dept-1');
        expect(deleted, isTrue);
      },
    );

    test('BulkImportController processes file upload and dry run', () async {
      const report = BulkImportReport(
        totalRows: 10,
        successfulImports: 10,
        failedRows: 0,
        dryRun: true,
      );
      final fakeRepo = _FakeAdminRepository()
        ..bulkImportReportToReturn = report;

      final container = ProviderContainer(
        overrides: [
          adminRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(bulkImportControllerProvider.notifier);
      controller.setSelectedFile(fileName: 'employees.csv', bytes: [1, 2, 3]);
      controller.setDryRun(value: true);

      final success = await controller.upload();
      expect(success, isTrue);
      expect(
        container.read(bulkImportControllerProvider).report?.successfulImports,
        10,
      );
    });
  });
}
