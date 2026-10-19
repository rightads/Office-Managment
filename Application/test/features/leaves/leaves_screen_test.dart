import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/leaves/application/leave_controller.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';
import 'package:right_ads/features/leaves/presentation/leave_detail_screen.dart';
import 'package:right_ads/features/leaves/presentation/leaves_screen.dart';
import 'package:right_ads/features/leaves/presentation/widgets/apply_leave_bottom_sheet.dart';
import 'package:right_ads/features/leaves/presentation/widgets/holiday_list_tile.dart';
import 'package:right_ads/features/leaves/presentation/widgets/leave_balance_card.dart';
import 'package:right_ads/features/leaves/presentation/widgets/leave_request_card.dart';

class _FakePermissionsController extends UserPermissionsController {
  _FakePermissionsController(this._permissions);
  final Set<String> _permissions;

  @override
  PermissionSet build() => PermissionSet(_permissions);
}

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  _FakeRuntimeAppConfigController(this._config);
  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;
}

class _FakeLeaveRequestsController extends LeaveRequestsController {
  _FakeLeaveRequestsController(this._state);
  final LeaveRequestsState _state;

  @override
  FutureOr<LeaveRequestsState> build() => _state;

  @override
  Future<void> refresh() async {}

  @override
  Future<void> setStatusFilter(String status) async {}

  @override
  Future<void> loadMore() async {}
}

class _FakeLeaveDetailController extends LeaveDetailController {
  _FakeLeaveDetailController(this._leave);
  final LeaveRequestModel _leave;

  @override
  FutureOr<LeaveRequestModel> build(String leaveId) => _leave;

  @override
  Future<bool> cancel({String? reason}) async => true;
}

void main() {
  const testAppConfig = AppConfig(
    environment: AppEnvironment.dev,
    apiBaseUrl: 'http://localhost:8000/api/v1',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    sendTimeout: Duration(seconds: 5),
  );

  final sampleBalances = [
    const LeaveBalanceModel(
      id: 'bal-1',
      userId: 'u-1',
      leaveTypeId: 'lt-1',
      leaveTypeName: 'Casual Leave',
      year: 2026,
      allocated: 12,
      carriedForward: 2,
      used: 4,
      available: 10,
    ),
    const LeaveBalanceModel(
      id: 'bal-2',
      userId: 'u-1',
      leaveTypeId: 'lt-2',
      leaveTypeName: 'Sick Leave',
      year: 2026,
      allocated: 10,
      carriedForward: 0,
      used: 1,
      available: 9,
    ),
  ];

  final sampleHolidays = [
    HolidayModel(
      id: 'hol-1',
      name: 'Republic Day',
      date: DateTime(2026, 1, 26),
      year: 2026,
    ),
    HolidayModel(
      id: 'hol-2',
      name: 'Maha Shivratri',
      date: DateTime(2026, 2, 17),
      year: 2026,
      isOptional: true,
    ),
  ];

  final sampleRequests = [
    LeaveRequestModel(
      id: 'req-1',
      userId: 'u-1',
      userFullName: 'John Doe',
      employeeCode: 'EMP001',
      leaveTypeId: 'lt-1',
      leaveTypeName: 'Casual Leave',
      fromDate: DateTime(2026, 10, 20),
      toDate: DateTime(2026, 10, 22),
      isHalfDay: false,
      totalDays: 3,
      reason: 'Family wedding ceremony',
      status: 'pending',
      createdAt: DateTime(2026, 10, 18),
    ),
    LeaveRequestModel(
      id: 'req-2',
      userId: 'u-1',
      userFullName: 'John Doe',
      employeeCode: 'EMP001',
      leaveTypeId: 'lt-2',
      leaveTypeName: 'Sick Leave',
      fromDate: DateTime(2026, 10, 5),
      toDate: DateTime(2026, 10, 5),
      isHalfDay: true,
      halfDaySession: 'first_half',
      totalDays: 0.5,
      reason: 'Doctor checkup',
      status: 'approved',
      reviewerName: 'Jane Smith',
      reviewNote: 'Take care!',
      createdAt: DateTime(2026, 10, 4),
    ),
  ];

  Widget buildLeavesScreenHarness({
    LeavesInitialTab initialTab = LeavesInitialTab.myLeaves,
    Set<String> permissions = const {
      PermissionCodes.leaveViewOwn,
      PermissionCodes.leaveApply,
    },
    LeaveRequestsState? requestsState,
  }) {
    final state =
        requestsState ??
        LeaveRequestsState(
          items: sampleRequests,
          total: sampleRequests.length,
        );

    return ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(testAppConfig),
        runtimeAppConfigControllerProvider.overrideWith(
          () => _FakeRuntimeAppConfigController(const RuntimeAppConfig()),
        ),
        userPermissionsControllerProvider.overrideWith(
          () => _FakePermissionsController(permissions),
        ),
        leaveBalancesProvider().overrideWith(
          (ref) async => sampleBalances,
        ),
        holidaysProvider().overrideWith(
          (ref) async => sampleHolidays,
        ),
        leaveTypesProvider.overrideWith(
          (ref) async => [
            const LeaveTypeModel(
              id: 'lt-1',
              name: 'Casual Leave',
              annualQuota: 12,
              isPaid: true,
              carryForward: true,
              maxCarryForward: 5,
            ),
            const LeaveTypeModel(
              id: 'lt-2',
              name: 'Sick Leave',
              annualQuota: 10,
              isPaid: true,
              carryForward: false,
              maxCarryForward: 0,
            ),
          ],
        ),
        leaveRequestsControllerProvider.overrideWith(
          () => _FakeLeaveRequestsController(state),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: LeavesScreen(initialTab: initialTab),
        ),
      ),
    );
  }

  Widget buildLeaveDetailHarness({
    required LeaveRequestModel leave,
    Set<String> permissions = const {
      PermissionCodes.leaveViewOwn,
      PermissionCodes.leaveApply,
    },
  }) {
    return ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(testAppConfig),
        runtimeAppConfigControllerProvider.overrideWith(
          () => _FakeRuntimeAppConfigController(const RuntimeAppConfig()),
        ),
        userPermissionsControllerProvider.overrideWith(
          () => _FakePermissionsController(permissions),
        ),
        leaveDetailControllerProvider(leave.id).overrideWith(
          () => _FakeLeaveDetailController(leave),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: LeaveDetailScreen(leaveId: leave.id),
        ),
      ),
    );
  }

  group('LeavesScreen Widget Tests', () {
    testWidgets('renders TabBar with My Leaves and Holidays tabs', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 960));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildLeavesScreenHarness());
      await tester.pumpAndSettle();

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text('My Leaves'), findsOneWidget);
      expect(find.text('Company Holidays'), findsOneWidget);
    });

    testWidgets(
      'renders Leave Balance Cards with allocated, used, and available balance',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(600, 960));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(buildLeavesScreenHarness());
        await tester.pumpAndSettle();

        expect(find.byType(LeaveBalanceCard), findsNWidgets(2));
        expect(find.text('Casual Leave'), findsWidgets);
        expect(find.text('Sick Leave'), findsWidgets);
        expect(
          find.text('10'),
          findsOneWidget,
        ); // available balance (formatted as int)
      },
    );

    testWidgets('renders Leave Request Cards with status chips and details', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 960));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildLeavesScreenHarness());
      await tester.pumpAndSettle();

      expect(find.byType(LeaveRequestCard), findsNWidgets(2));
      expect(find.text('Family wedding ceremony'), findsOneWidget);
      expect(find.text('Doctor checkup'), findsOneWidget);
      expect(find.text('Pending'), findsWidgets);
      expect(find.text('Approved'), findsWidgets);
    });

    testWidgets(
      'switches to Holidays tab and renders HolidayListTile widgets',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(600, 960));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(
          buildLeavesScreenHarness(initialTab: LeavesInitialTab.holidays),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HolidayListTile), findsNWidgets(2));
        expect(find.text('Republic Day'), findsOneWidget);
        expect(find.text('Maha Shivratri'), findsOneWidget);
        expect(find.text('Optional'), findsOneWidget);
      },
    );

    testWidgets('displays Apply Leave FAB and opens bottom sheet on tap', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 960));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildLeavesScreenHarness());
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);

      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(find.byType(ApplyLeaveBottomSheet), findsOneWidget);
      expect(find.text('Apply for Leave'), findsOneWidget);
      expect(find.text('Half Day Application'), findsOneWidget);
      expect(find.text('Reason for Leave'), findsOneWidget);
    });

    testWidgets(
      'LeaveDetailScreen renders metadata, working days, and cancel action',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(600, 960));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        final pendingLeave = sampleRequests.first;
        await tester.pumpWidget(buildLeaveDetailHarness(leave: pendingLeave));
        await tester.pumpAndSettle();

        expect(find.text('Leave Details'), findsOneWidget);
        expect(find.text('Casual Leave'), findsOneWidget);
        expect(find.text('3 days'), findsOneWidget);
        expect(find.text('Family wedding ceremony'), findsOneWidget);
        expect(find.text('Cancel Request'), findsOneWidget);
      },
    );
  });
}
