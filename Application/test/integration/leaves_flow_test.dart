import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/leaves/application/leave_controller.dart';
import 'package:right_ads/features/leaves/data/leave_repository.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';

class _FakeLeaveRepository implements LeaveRepository {
  List<LeaveBalanceModel> balancesToReturn = [];
  List<LeaveTypeModel> typesToReturn = [];
  LeaveRequestListResponse? requestsToReturn;
  LeaveRequestModel? singleLeaveToReturn;
  LeavePreviewResponse? previewToReturn;
  LeaveRequestModel? createdLeaveToReturn;
  LeaveRequestModel? cancelledLeaveToReturn;

  @override
  Future<(List<LeaveBalanceModel>?, AppFailure?)> getMyBalances({
    int? year,
  }) async => (balancesToReturn, null);

  @override
  Future<(List<LeaveTypeModel>?, AppFailure?)> getLeaveTypes() async =>
      (typesToReturn, null);

  @override
  Future<(HolidayPageResponse?, AppFailure?)> getHolidays({
    int? year,
    int page = 1,
    int pageSize = 50,
  }) async => (
    const HolidayPageResponse(items: [], total: 0, page: 1, pageSize: 50),
    null,
  );

  @override
  Future<(LeaveRequestListResponse?, AppFailure?)> getMyRequests({
    String? status,
    int? year,
    int page = 1,
    int size = 20,
  }) async => (requestsToReturn, null);

  @override
  Future<(LeaveRequestModel?, AppFailure?)> getLeaveById(String id) async =>
      (singleLeaveToReturn, null);

  @override
  Future<(LeavePreviewResponse?, AppFailure?)> previewLeave(
    LeavePreviewPayload payload,
  ) async => (previewToReturn, null);

  @override
  Future<(LeaveRequestModel?, AppFailure?)> applyLeave(
    LeaveApplyPayload payload,
  ) async => (createdLeaveToReturn, null);

  @override
  Future<(LeaveRequestModel?, AppFailure?)> cancelPendingLeave(
    String id,
  ) async => (cancelledLeaveToReturn, null);

  @override
  Future<(LeaveRequestModel?, AppFailure?)> cancelApprovedLeave(
    String id, {
    String? reason,
  }) async => (cancelledLeaveToReturn, null);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const sampleLeaveType = LeaveTypeModel(
    id: 'lt-1',
    name: 'Casual Leave',
    annualQuota: 12,
    isPaid: true,
    carryForward: false,
    maxCarryForward: 0,
  );

  const sampleBalance = LeaveBalanceModel(
    id: 'bal-1',
    userId: 'u-1',
    leaveTypeId: 'lt-1',
    leaveTypeName: 'Casual Leave',
    year: 2026,
    allocated: 12,
    carriedForward: 0,
    used: 2,
    available: 10,
  );

  final pendingRequest = LeaveRequestModel(
    id: 'lr-101',
    userId: 'u-1',
    userFullName: 'Creative Lead',
    employeeCode: 'EMP001',
    leaveTypeId: 'lt-1',
    leaveTypeName: 'Casual Leave',
    fromDate: DateTime(2026, 11, 10),
    toDate: DateTime(2026, 11, 12),
    isHalfDay: false,
    totalDays: 3,
    reason: 'Family Event',
    status: 'pending',
    createdAt: DateTime.utc(2026, 10, 22),
  );

  group('Leaves End-to-End Integration Flow', () {
    test(
      'inspects leave balances, submits a new leave request, and cancels pending request',
      () async {
        final fakeRepo = _FakeLeaveRepository()
          ..balancesToReturn = [sampleBalance]
          ..typesToReturn = [sampleLeaveType]
          ..previewToReturn = LeavePreviewResponse(
            fromDate: DateTime(2026, 11, 10),
            toDate: DateTime(2026, 11, 12),
            isHalfDay: false,
            workingDays: 3,
            isValid: true,
          )
          ..createdLeaveToReturn = pendingRequest
          ..cancelledLeaveToReturn = pendingRequest.copyWith(
            status: 'cancelled',
          );

        final container = ProviderContainer(
          overrides: [
            leaveRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        addTearDown(container.dispose);

        // 1. Verify balances loaded
        final balances = await container.read(leaveBalancesProvider().future);
        expect(balances.length, 1);
        expect(balances.first.available, 10.0);

        // 2. Fill and submit leave request
        final applyController = container.read(
          leaveApplyControllerProvider.notifier,
        );
        applyController
          ..setLeaveType('lt-1')
          ..setDateRange(DateTime(2026, 11, 10), DateTime(2026, 11, 12))
          ..setReason('Family Event');

        final submitSuccess = await applyController.submit();
        expect(submitSuccess, isTrue);

        // 3. Inspect request in detail controller
        fakeRepo.singleLeaveToReturn = pendingRequest;
        final detailFuture = await container.read(
          leaveDetailControllerProvider('lr-101').future,
        );
        expect(detailFuture.status, 'pending');

        final detailController = container.read(
          leaveDetailControllerProvider('lr-101').notifier,
        );

        // 4. Cancel pending leave
        final cancelSuccess = await detailController.cancel();
        expect(cancelSuccess, isTrue);
        expect(
          container.read(leaveDetailControllerProvider('lr-101')).value?.status,
          'cancelled',
        );
      },
    );
  });
}
