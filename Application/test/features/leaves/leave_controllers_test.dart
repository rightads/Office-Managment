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
  HolidayPageResponse? holidaysToReturn;

  AppFailure? failureToReturn;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<(List<LeaveBalanceModel>?, AppFailure?)> getMyBalances({
    int? year,
  }) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (balancesToReturn, null);
  }

  @override
  Future<(List<LeaveTypeModel>?, AppFailure?)> getLeaveTypes() async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (typesToReturn, null);
  }

  @override
  Future<(HolidayPageResponse?, AppFailure?)> getHolidays({
    int? year,
    int page = 1,
    int pageSize = 50,
  }) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (holidaysToReturn, null);
  }

  @override
  Future<(LeaveRequestListResponse?, AppFailure?)> getMyRequests({
    String? status,
    int? year,
    int page = 1,
    int size = 20,
  }) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (requestsToReturn, null);
  }

  @override
  Future<(LeaveRequestModel?, AppFailure?)> getLeaveById(String id) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (singleLeaveToReturn, null);
  }

  @override
  Future<(LeavePreviewResponse?, AppFailure?)> previewLeave(
    LeavePreviewPayload payload,
  ) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (previewToReturn, null);
  }

  @override
  Future<(LeaveRequestModel?, AppFailure?)> applyLeave(
    LeaveApplyPayload payload,
  ) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (createdLeaveToReturn, null);
  }

  @override
  Future<(LeaveRequestModel?, AppFailure?)> cancelPendingLeave(
    String id,
  ) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (cancelledLeaveToReturn, null);
  }

  @override
  Future<(LeaveRequestModel?, AppFailure?)> cancelApprovedLeave(
    String id, {
    String? reason,
  }) async {
    if (failureToReturn != null) return (null, failureToReturn);
    return (cancelledLeaveToReturn, null);
  }
}

void main() {
  group('Leave Controllers Tests', () {
    late _FakeLeaveRepository fakeRepo;
    late ProviderContainer container;

    setUp(() {
      fakeRepo = _FakeLeaveRepository();
      container = ProviderContainer(
        overrides: [
          leaveRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'SelectedLeaveYearController initializes with current year and updates',
      () {
        final currentYear = DateTime.now().year;
        expect(
          container.read(selectedLeaveYearControllerProvider),
          currentYear,
        );

        container
            .read(selectedLeaveYearControllerProvider.notifier)
            .setYear(2027);
        expect(container.read(selectedLeaveYearControllerProvider), 2027);
      },
    );

    test('leaveTypesProvider loads active categories', () async {
      fakeRepo.typesToReturn = [
        const LeaveTypeModel(
          id: 'lt-1',
          name: 'Casual Leave',
          annualQuota: 12,
          isPaid: true,
          carryForward: true,
          maxCarryForward: 5,
        ),
      ];

      final types = await container.read(leaveTypesProvider.future);
      expect(types.length, 1);
      expect(types.first.name, 'Casual Leave');
    });

    test('leaveBalancesProvider loads employee balances', () async {
      fakeRepo.balancesToReturn = [
        const LeaveBalanceModel(
          id: 'bal-1',
          userId: 'u-1',
          leaveTypeId: 'lt-1',
          leaveTypeName: 'Casual Leave',
          year: 2026,
          allocated: 12,
          carriedForward: 0,
          used: 2,
          available: 10,
        ),
      ];

      final balances = await container.read(leaveBalancesProvider().future);
      expect(balances.length, 1);
      expect(balances.first.available, 10);
    });

    test('holidaysProvider loads calendar holidays', () async {
      fakeRepo.holidaysToReturn = HolidayPageResponse(
        items: [
          HolidayModel(
            id: 'h-1',
            name: 'New Year',
            date: DateTime(2026),
            year: 2026,
          ),
        ],
        total: 1,
        page: 1,
        pageSize: 50,
      );

      final holidays = await container.read(holidaysProvider().future);
      expect(holidays.length, 1);
      expect(holidays.first.name, 'New Year');
    });

    test(
      'LeaveRequestsController loads initial page and filters by status',
      () async {
        fakeRepo.requestsToReturn = LeaveRequestListResponse(
          items: [
            LeaveRequestModel(
              id: 'lr-1',
              userId: 'u-1',
              userFullName: 'John Doe',
              employeeCode: 'EMP001',
              leaveTypeId: 'lt-1',
              leaveTypeName: 'Casual Leave',
              fromDate: DateTime(2026, 10, 20),
              toDate: DateTime(2026, 10, 21),
              isHalfDay: false,
              totalDays: 2,
              reason: 'Vacation',
              status: 'pending',
              createdAt: DateTime(2026, 10, 18),
            ),
          ],
          total: 1,
          page: 1,
          size: 20,
          pages: 1,
        );

        final state = await container.read(
          leaveRequestsControllerProvider.future,
        );
        expect(state.items.length, 1);
        expect(state.items.first.id, 'lr-1');
        expect(state.statusFilter, 'all');

        // Filter by approved
        fakeRepo.requestsToReturn = const LeaveRequestListResponse(
          items: [],
          total: 0,
          page: 1,
          size: 20,
          pages: 0,
        );

        await container
            .read(leaveRequestsControllerProvider.notifier)
            .setStatusFilter('approved');

        final updatedState = container
            .read(leaveRequestsControllerProvider)
            .value!;
        expect(updatedState.statusFilter, 'approved');
        expect(updatedState.items, isEmpty);
      },
    );

    test(
      'LeaveApplyController validation, preview debounce, and successful submit',
      () async {
        final controller = container.read(
          leaveApplyControllerProvider.notifier,
        );

        // Initially empty -> submit fails validation
        final initialSubmit = await controller.submit();
        expect(initialSubmit, isFalse);
        expect(
          container
              .read(leaveApplyControllerProvider)
              .fieldErrors
              .containsKey('leave_type_id'),
          isTrue,
        );

        // Fill valid values
        controller
          ..setLeaveType('lt-1')
          ..setDateRange(
            DateTime(2026, 10, 20),
            DateTime(2026, 10, 22),
          )
          ..setReason('Family celebration');

        fakeRepo
          ..previewToReturn = LeavePreviewResponse(
            fromDate: DateTime(2026, 10, 20),
            toDate: DateTime(2026, 10, 22),
            isHalfDay: false,
            workingDays: 3,
            isValid: true,
          )
          ..createdLeaveToReturn = LeaveRequestModel(
            id: 'lr-created',
            userId: 'u-1',
            userFullName: 'John Doe',
            employeeCode: 'EMP001',
            leaveTypeId: 'lt-1',
            leaveTypeName: 'Casual Leave',
            fromDate: DateTime(2026, 10, 20),
            toDate: DateTime(2026, 10, 22),
            isHalfDay: false,
            totalDays: 3,
            reason: 'Family celebration',
            status: 'pending',
            createdAt: DateTime.now(),
          );

        final success = await controller.submit();
        expect(success, isTrue);
        expect(
          container.read(leaveApplyControllerProvider).isSubmitting,
          isFalse,
        );
      },
    );

    test(
      'LeaveDetailController loads request and cancels pending leave',
      () async {
        final singleLeave = LeaveRequestModel(
          id: 'lr-detail',
          userId: 'u-1',
          userFullName: 'John Doe',
          employeeCode: 'EMP001',
          leaveTypeId: 'lt-1',
          leaveTypeName: 'Casual Leave',
          fromDate: DateTime(2026, 10, 20),
          toDate: DateTime(2026, 10, 21),
          isHalfDay: false,
          totalDays: 2,
          reason: 'Vacation',
          status: 'pending',
          createdAt: DateTime.now(),
        );

        fakeRepo
          ..singleLeaveToReturn = singleLeave
          ..cancelledLeaveToReturn = singleLeave.copyWith(status: 'cancelled');

        final leave = await container.read(
          leaveDetailControllerProvider('lr-detail').future,
        );
        expect(leave.id, 'lr-detail');
        expect(leave.status, 'pending');

        final cancelled = await container
            .read(leaveDetailControllerProvider('lr-detail').notifier)
            .cancel();

        expect(cancelled, isTrue);
        final currentLeave = container
            .read(leaveDetailControllerProvider('lr-detail'))
            .value!;
        expect(currentLeave.status, 'cancelled');
      },
    );
  });
}
