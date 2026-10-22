import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin_attendance/application/admin_attendance_controllers.dart';
import 'package:right_ads/features/admin_attendance/data/admin_attendance_repository.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';

class _FakeAdminAttendanceRepository implements AdminAttendanceRepository {
  AttendanceTodayReportResponse? todayDashboardToReturn;
  MonthlyOverviewResponse? monthlyOverviewToReturn;
  EmployeeMonthlyReportResponse? employeeMonthlyToReturn;
  EmployeeYearlyReportResponse? employeeYearlyToReturn;
  AttendanceCorrectionResponse? correctionToReturn;

  @override
  Future<AttendanceTodayReportResponse> getTodayDashboard({
    String? departmentId,
  }) async => todayDashboardToReturn!;

  @override
  Future<MonthlyOverviewResponse> getMonthlyOverview({
    required int month,
    required int year,
    String? departmentId,
  }) async => monthlyOverviewToReturn!;

  @override
  Future<EmployeeMonthlyReportResponse> getEmployeeMonthly(
    String employeeId, {
    int? month,
    int? year,
  }) async => employeeMonthlyToReturn!;

  @override
  Future<EmployeeYearlyReportResponse> getEmployeeYearly(
    String employeeId, {
    int? year,
  }) async => employeeYearlyToReturn!;

  @override
  Future<AttendanceCorrectionResponse> submitCorrection(
    String recordId,
    AttendanceCorrectionRequest request,
  ) async => correctionToReturn!;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const sampleTodayDashboard = AttendanceTodayReportResponse(
    date: '2026-10-22',
    totalActiveEmployees: 50,
    presentCount: 45,
    absentCount: 5,
    onLeaveCount: 2,
    halfDayCount: 1,
    lateCount: 3,
  );

  const sampleMonthlyOverview = MonthlyOverviewResponse(
    month: 10,
    year: 2026,
    totalEmployees: 50,
  );

  const sampleEmployeeMonthly = EmployeeMonthlyReportResponse(
    employeeId: 'emp-1',
    employeeName: 'Jane Doe',
    employeeCode: 'EMP001',
    month: 10,
    year: 2026,
    totalDays: 31,
    workingDays: 22,
    presentDays: 20,
    absentDays: 1,
    halfDays: 0,
    lateDays: 1,
    leaveDays: 1,
    holidayDays: 0,
    weekOffDays: 8,
    totalHoursWorked: 160,
    averageHoursPerDay: 8,
    attendancePercentage: 95,
  );

  group('Admin Attendance Controllers Suite', () {
    test(
      'AdminAttendanceTodayController loads dashboard and changes department',
      () async {
        final fakeRepo = _FakeAdminAttendanceRepository()
          ..todayDashboardToReturn = sampleTodayDashboard;

        final container = ProviderContainer(
          overrides: [
            adminAttendanceRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          adminAttendanceTodayControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          adminAttendanceTodayControllerProvider.notifier,
        );
        await controller.loadDashboard();

        var state = container.read(adminAttendanceTodayControllerProvider);
        expect(state.isLoading, isFalse);
        expect(state.data?.presentCount, 45);

        controller.onDepartmentChanged('dept-it');
        state = container.read(adminAttendanceTodayControllerProvider);
        expect(state.departmentId, 'dept-it');
      },
    );

    test(
      'AdminMonthlyOverviewController updates month, year, and department',
      () async {
        final fakeRepo = _FakeAdminAttendanceRepository()
          ..monthlyOverviewToReturn = sampleMonthlyOverview;

        final container = ProviderContainer(
          overrides: [
            adminAttendanceRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          adminMonthlyOverviewControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          adminMonthlyOverviewControllerProvider.notifier,
        );
        await controller.loadOverview();

        var state = container.read(adminMonthlyOverviewControllerProvider);
        expect(state.isLoading, isFalse);
        expect(state.data?.totalEmployees, 50);

        controller.setDate(month: 11, year: 2026);
        controller.onDepartmentChanged('dept-sales');

        state = container.read(adminMonthlyOverviewControllerProvider);
        expect(state.month, 11);
        expect(state.departmentId, 'dept-sales');
      },
    );

    test(
      'AdminEmployeeMonthlyController loads employee monthly history',
      () async {
        final fakeRepo = _FakeAdminAttendanceRepository()
          ..employeeMonthlyToReturn = sampleEmployeeMonthly;

        final container = ProviderContainer(
          overrides: [
            adminAttendanceRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          adminEmployeeMonthlyControllerProvider('emp-1'),
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          adminEmployeeMonthlyControllerProvider('emp-1').notifier,
        );
        await controller.loadReport('emp-1');

        var state = container.read(
          adminEmployeeMonthlyControllerProvider('emp-1'),
        );
        expect(state.isLoading, isFalse);
        expect(state.data?.employeeName, 'Jane Doe');

        controller.setDate('emp-1', month: 11, year: 2026);
        state = container.read(adminEmployeeMonthlyControllerProvider('emp-1'));
        expect(state.month, 11);
      },
    );
  });
}
