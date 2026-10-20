import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/core/theme/app_theme.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/work_reports/application/work_report_controller.dart';
import 'package:right_ads/features/work_reports/application/work_report_reminder_service.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_card.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_item_row.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_lock_banner.dart';
import 'package:right_ads/features/work_reports/presentation/widgets/work_report_time_budget_card.dart';
import 'package:right_ads/features/work_reports/presentation/work_reports_screen.dart';

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  _FakeRuntimeAppConfigController(this._config);
  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;
}

class _FakeEditorController extends WorkReportEditorController {
  _FakeEditorController(this._initialState);
  final WorkReportEditorState _initialState;

  @override
  FutureOr<WorkReportEditorState> build(String dateKey) => _initialState;

  @override
  void setSummary(String value) {}

  @override
  void addItem() {}

  @override
  void removeItem(String localId) {}
}

class _FakeHistoryController extends WorkReportHistoryController {
  _FakeHistoryController(this._initialState);
  final WorkReportHistoryState _initialState;

  @override
  FutureOr<WorkReportHistoryState> build() => _initialState;

  @override
  Future<void> refresh() async {}
}

Widget _buildWorkReportsScreenHarness({
  required WorkReportEditorState editorState,
  required WorkReportHistoryState historyState,
  RuntimeAppConfig config = const RuntimeAppConfig(
    workReportMaxMinutesPerDay: 480,
    workReportEditableWindowDays: 7,
  ),
  DateTime? testToday,
}) {
  final today = testToday ?? DateTime(2026, 10, 20);

  return ProviderScope(
    overrides: [
      appConfigProvider.overrideWithValue(
        const AppConfig(
          environment: AppEnvironment.dev,
          apiBaseUrl: 'https://api.test.com/api/v1',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
          sendTimeout: Duration(seconds: 5),
        ),
      ),
      runtimeAppConfigControllerProvider.overrideWith(
        () => _FakeRuntimeAppConfigController(config),
      ),
      workReportTodayProvider.overrideWithValue(today),
      selectedWorkReportDateProvider.overrideWith(() => SelectedWorkReportDate()),
      workReportEditorControllerProvider(WorkReportRules.toIsoDate(today)).overrideWith(
        () => _FakeEditorController(editorState),
      ),
      workReportHistoryControllerProvider.overrideWith(
        () => _FakeHistoryController(historyState),
      ),
      workReportReminderSyncProvider.overrideWith((ref) async {}),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const WorkReportsScreen(),
    ),
  );
}

void main() {
  group('WorkReportsScreen Widget Tests', () {
    final today = DateTime(2026, 10, 20);

    testWidgets('renders Today/Edit tab and History tab', (tester) async {
      final editorState = WorkReportEditorState(
        date: today,
        summary: 'Developing mobile app',
        items: const [
          WorkReportItemDraft(
            localId: 'row-1',
            description: 'Implemented work reports screen',
            minutes: 180,
          ),
        ],
      );
      const historyState = WorkReportHistoryState();

      await tester.pumpWidget(
        _buildWorkReportsScreenHarness(
          editorState: editorState,
          historyState: historyState,
        ),
      );
      await tester.pumpAndSettle();

      // App bar title
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(2));

      // Today editor contents
      expect(find.byType(WorkReportTimeBudgetCard), findsOneWidget);
      expect(find.byType(WorkReportItemRow), findsOneWidget);
      expect(find.text('Developing mobile app'), findsOneWidget);
      expect(find.text('Implemented work reports screen'), findsOneWidget);
    });

    testWidgets('displays lock banner when viewing locked report', (tester) async {
      final editorState = WorkReportEditorState(
        date: today,
        summary: 'Submitted report',
        report: WorkReportModel(
          id: 'wr-sub-1',
          reportDate: today,
          status: 'submitted',
          totalMinutes: 120,
        ),
        items: const [
          WorkReportItemDraft(
            localId: 'row-1',
            description: 'Task done',
            minutes: 120,
          ),
        ],
      );
      const historyState = WorkReportHistoryState();

      await tester.pumpWidget(
        _buildWorkReportsScreenHarness(
          editorState: editorState,
          historyState: historyState,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WorkReportLockBanner), findsOneWidget);
    });

    testWidgets('switches to History tab and renders report cards', (tester) async {
      final editorState = WorkReportEditorState(date: today);
      final historyState = WorkReportHistoryState(
        items: [
          WorkReportModel(
            id: 'wr-hist-1',
            reportDate: DateTime(2026, 10, 19),
            status: 'reviewed',
            summary: 'Completed Prompt 09 FCM integration',
            totalMinutes: 240,
            reviewNote: 'Great job!',
          ),
        ],
        total: 1,
      );

      await tester.pumpWidget(
        _buildWorkReportsScreenHarness(
          editorState: editorState,
          historyState: historyState,
        ),
      );
      await tester.pumpAndSettle();

      // Tap on History tab
      await tester.tap(find.byType(Tab).last);
      await tester.pumpAndSettle();

      // Verify report card rendered
      expect(find.byType(WorkReportCard), findsOneWidget);
      expect(find.text('Completed Prompt 09 FCM integration'), findsOneWidget);
      expect(find.text('Great job!'), findsOneWidget);
    });

    testWidgets('renders empty history state when no reports', (tester) async {
      final editorState = WorkReportEditorState(date: today);
      const historyState = WorkReportHistoryState(items: [], total: 0);

      await tester.pumpWidget(
        _buildWorkReportsScreenHarness(
          editorState: editorState,
          historyState: historyState,
        ),
      );
      await tester.pumpAndSettle();

      // Tap History tab
      await tester.tap(find.byType(Tab).last);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.description_outlined), findsOneWidget);
    });
  });
}
