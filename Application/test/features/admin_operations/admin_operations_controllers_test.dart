import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin_operations/application/admin_operations_controllers.dart';
import 'package:right_ads/features/admin_operations/data/admin_operations_repository.dart';
import 'package:right_ads/features/admin_operations/domain/admin_operations_models.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';

class _FakeAdminOperationsRepository implements AdminOperationsRepository {
  TaskSummaryReportsResponse? taskSummaryToReturn;
  List<LeaveRequestModel> leavesToReturn = [];
  List<WorkReportModel> workReportsToReturn = [];
  MissingWorkReportListResponse? missingReportsToReturn;

  bool approveLeaveCalled = false;
  bool rejectLeaveCalled = false;
  bool reviewWorkReportCalled = false;

  @override
  Future<TaskSummaryReportsResponse> getTaskReportsSummary({
    String? departmentId,
  }) async => taskSummaryToReturn!;

  @override
  Future<List<LeaveRequestModel>> getLeavesAdmin({
    String? status,
    String? departmentId,
    int page = 1,
    int pageSize = 50,
  }) async => leavesToReturn;

  @override
  Future<void> approveLeave(String leaveId, {String? reviewNote}) async {
    approveLeaveCalled = true;
  }

  @override
  Future<void> rejectLeave(String leaveId, {required String reviewNote}) async {
    rejectLeaveCalled = true;
  }

  @override
  Future<List<WorkReportModel>> getWorkReportsAdmin({
    String? date,
    String? departmentId,
    String? employeeId,
  }) async => workReportsToReturn;

  @override
  Future<MissingWorkReportListResponse> getMissingWorkReports({
    required String date,
    String? departmentId,
  }) async => missingReportsToReturn!;

  @override
  Future<void> reviewWorkReport(
    String reportId, {
    required String reviewNote,
    String status = 'reviewed',
  }) async {
    reviewWorkReportCalled = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final sampleLeave = LeaveRequestModel(
    id: 'leave-1',
    userId: 'u-1',
    userFullName: 'John Doe',
    employeeCode: 'EMP001',
    leaveTypeId: 'lt-1',
    leaveTypeName: 'Sick Leave',
    fromDate: DateTime(2026, 10, 22),
    toDate: DateTime(2026, 10, 24),
    isHalfDay: false,
    totalDays: 2,
    reason: 'Fever',
    status: 'pending',
    createdAt: DateTime(2026, 10, 20),
  );

  final sampleReport = WorkReportModel(
    id: 'wr-1',
    reportDate: DateTime(2026, 10, 22),
    status: 'submitted',
    userFullName: 'John Doe',
  );

  const sampleMissing = MissingWorkReportListResponse(
    reportDate: '2026-10-22',
    missingCount: 2,
  );

  const sampleTaskSummary = TaskSummaryReportsResponse(
    totalTasks: 20,
    completedTasks: 15,
    pendingTasks: 5,
    overdueTasks: 0,
    onTimeCompletionRate: 90,
  );

  group('Admin Operations Controllers Suite', () {
    test('AdminTaskReportsController loads summary metrics', () async {
      final fakeRepo = _FakeAdminOperationsRepository()
        ..taskSummaryToReturn = sampleTaskSummary;

      final container = ProviderContainer(
        overrides: [
          adminOperationsRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      final sub = container.listen(
        adminTaskReportsControllerProvider,
        (_, _) {},
      );
      addTearDown(() {
        sub.close();
        container.dispose();
      });

      final controller = container.read(
        adminTaskReportsControllerProvider.notifier,
      );
      await controller.loadReports();

      final state = container.read(adminTaskReportsControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.summary?.totalTasks, 20);
    });

    test(
      'AdminLeaveApprovalsController approves and rejects leave requests',
      () async {
        final fakeRepo = _FakeAdminOperationsRepository()
          ..leavesToReturn = [sampleLeave];

        final container = ProviderContainer(
          overrides: [
            adminOperationsRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          adminLeaveApprovalsControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          adminLeaveApprovalsControllerProvider.notifier,
        );
        await controller.loadRequests();

        final state = container.read(adminLeaveApprovalsControllerProvider);
        expect(state.requests.length, 1);

        controller.onDepartmentChanged('dept-1');
        controller.onStatusChanged('pending');

        final approved = await controller.approve(
          'leave-1',
          reviewNote: 'Approved by lead',
        );
        expect(approved, isTrue);
        expect(fakeRepo.approveLeaveCalled, isTrue);

        final rejected = await controller.reject(
          'leave-1',
          reviewNote: 'Insufficient coverage',
        );
        expect(rejected, isTrue);
        expect(fakeRepo.rejectLeaveCalled, isTrue);
      },
    );

    test(
      'AdminWorkReportsReviewController reviews reports and loads missing',
      () async {
        final fakeRepo = _FakeAdminOperationsRepository()
          ..workReportsToReturn = [sampleReport]
          ..missingReportsToReturn = sampleMissing;

        final container = ProviderContainer(
          overrides: [
            adminOperationsRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        final sub = container.listen(
          adminWorkReportsReviewControllerProvider,
          (_, _) {},
        );
        addTearDown(() {
          sub.close();
          container.dispose();
        });

        final controller = container.read(
          adminWorkReportsReviewControllerProvider.notifier,
        );
        await controller.loadData();

        final state = container.read(adminWorkReportsReviewControllerProvider);
        expect(state.reports.length, 1);
        expect(state.missingReports?.missingCount, 2);

        controller.setDate('2026-10-21');
        controller.onDepartmentChanged('dept-2');

        final reviewed = await controller.submitReview(
          'wr-1',
          reviewNote: 'Good job',
        );
        expect(reviewed, isTrue);
        expect(fakeRepo.reviewWorkReportCalled, isTrue);
      },
    );
  });
}
