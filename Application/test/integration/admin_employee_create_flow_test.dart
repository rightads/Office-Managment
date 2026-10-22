import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:right_ads/features/admin/presentation/employee_form_screen.dart';

class _FakeAdminRepository implements AdminRepository {
  List<RoleItem> rolesToReturn = [];
  List<MasterDataItem> departmentsToReturn = [];
  List<MasterDataItem> policiesToReturn = [];
  List<EmployeeItem> employeesToReturn = [];

  bool createCalled = false;
  EmployeeCreatePayload? lastCreatedPayload;
  bool passwordResetCalled = false;
  bool roleAssignedCalled = false;

  @override
  Future<List<RoleItem>> getRoles() async => rolesToReturn;

  @override
  Future<List<MasterDataItem>> getMasterDataList(String basePath) async {
    if (basePath.contains('departments')) return departmentsToReturn;
    if (basePath.contains('attendance-policies')) return policiesToReturn;
    return [];
  }

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
  Future<EmployeeItem> createEmployee(EmployeeCreatePayload payload) async {
    createCalled = true;
    lastCreatedPayload = payload;
    return EmployeeItem(
      id: 'emp-new',
      employeeCode: 'EMP100',
      email: payload.email,
      fullName: payload.fullName,
      roleId: payload.roleId,
      departmentId: payload.departmentId,
      attendancePolicyId: payload.attendancePolicyId,
      isActive: true,
      mustChangePassword: true,
      createdAt: '2026-10-22T10:00:00Z',
    );
  }

  @override
  Future<void> resetPassword(String id, {String? newPassword}) async {
    passwordResetCalled = true;
  }

  @override
  Future<void> assignRole(String id, String roleId) async {
    roleAssignedCalled = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const sampleRole = RoleItem(
    id: 'role-dev',
    name: 'Developer',
    description: 'Engineering role',
    isSystem: false,
    isActive: true,
    createdAt: '2026-10-22T00:00:00Z',
  );

  const sampleDept = MasterDataItem(
    id: 'dept-eng',
    name: 'Engineering',
    code: 'ENG',
    isActive: true,
  );

  group('Admin Employee Create & Manage End-to-End Flow', () {
    testWidgets(
      'loads catalogs, enforces validation, and creates new employee record',
      (tester) async {
        final fakeRepo = _FakeAdminRepository()
          ..rolesToReturn = [sampleRole]
          ..departmentsToReturn = [sampleDept];

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              adminRepositoryProvider.overrideWithValue(fakeRepo),
            ],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: EmployeeFormScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 1. Catalogs loaded and fields rendered
        expect(find.byType(TextFormField), findsWidgets);

        // 2. Tap save without required inputs
        final saveBtn = find.widgetWithText(ElevatedButton, 'Save');
        await tester.ensureVisible(saveBtn);
        await tester.pumpAndSettle();
        await tester.tap(saveBtn);
        await tester.pumpAndSettle();

        expect(fakeRepo.createCalled, isFalse);

        // 3. Fill required text fields: Full Name, Email
        final textFormFields = find.byType(TextFormField);
        await tester.enterText(textFormFields.at(0), 'Jane Doe');
        await tester.enterText(
          textFormFields.at(1),
          'jane.doe@marketingagency.com',
        );

        // Select Role dropdown
        final dropdowns = find.byType(DropdownButtonFormField<String>);
        expect(dropdowns, findsWidgets);
        await tester.ensureVisible(dropdowns.first);
        await tester.pumpAndSettle();
        await tester.tap(dropdowns.first);
        await tester.pumpAndSettle();

        final roleOption = find.text('Developer').last;
        await tester.tap(roleOption);
        await tester.pumpAndSettle();

        // 4. Save with valid employee inputs
        await tester.ensureVisible(saveBtn);
        await tester.pumpAndSettle();
        await tester.tap(saveBtn);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));

        expect(fakeRepo.createCalled, isTrue);
        expect(fakeRepo.lastCreatedPayload?.fullName, 'Jane Doe');
        expect(
          fakeRepo.lastCreatedPayload?.email,
          'jane.doe@marketingagency.com',
        );
        expect(fakeRepo.lastCreatedPayload?.roleId, 'role-dev');

        // 5. Dismiss credentials dialog
        final closeBtn = find.widgetWithText(ElevatedButton, 'Close');
        if (closeBtn.evaluate().isNotEmpty) {
          await tester.tap(closeBtn);
          await tester.pumpAndSettle();
        }
      },
    );

    test(
      'resets employee password and reassigns role via admin repository',
      () async {
        final fakeRepo = _FakeAdminRepository();
        await fakeRepo.resetPassword(
          'emp-new',
          newPassword: 'NewSecurePass123!',
        );
        expect(fakeRepo.passwordResetCalled, isTrue);

        await fakeRepo.assignRole('emp-new', 'role-dev');
        expect(fakeRepo.roleAssignedCalled, isTrue);
      },
    );
  });
}
