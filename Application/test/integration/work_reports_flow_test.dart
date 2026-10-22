import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/work_reports/application/work_report_controller.dart';
import 'package:right_ads/features/work_reports/data/work_report_repository.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  _FakeRuntimeAppConfigController(this._config);

  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;

  @override
  Future<(RuntimeAppConfig, AppFailure?)> refreshFromServer() async =>
      (_config, null);
}

class _FakeWorkReportRepository implements WorkReportRepository {
  WorkReportModel? reportForDate;
  WorkReportModel? singleReport;

  @override
  Future<(WorkReportModel?, AppFailure?)> getByDate(DateTime date) async =>
      (reportForDate, null);

  @override
  Future<(WorkReportModel?, AppFailure?)> getById(String id) async =>
      (singleReport, null);

  @override
  Future<(WorkReportPageResponse?, AppFailure?)> getMyReports({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int pageSize = 20,
  }) async => (
    WorkReportPageResponse(
      items: reportForDate != null ? [reportForDate!] : const [],
      total: reportForDate != null ? 1 : 0,
    ),
    null,
  );

  @override
  Future<(WorkReportModel?, AppFailure?)> createOrSaveDraft(
    WorkReportCreatePayload payload,
  ) async {
    final updated = WorkReportModel(
      id: 'wr-1',
      reportDate: DateTime.parse(payload.reportDate),
      status: WorkReportStatus.draft,
      summary: payload.summary,
      totalMinutes: payload.items.fold(0, (s, i) => s + i.minutesSpent),
      items: payload.items
          .asMap()
          .entries
          .map(
            (e) => WorkReportItemModel(
              id: 'item-${e.key}',
              description: e.value.description,
              minutesSpent: e.value.minutesSpent,
              reportId: 'wr-1',
            ),
          )
          .toList(),
    );
    reportForDate = updated;
    return (updated, null);
  }

  @override
  Future<(WorkReportModel?, AppFailure?)> updateReport(
    String id,
    WorkReportUpdatePayload payload,
  ) async {
    final updated = WorkReportModel(
      id: id,
      reportDate: reportForDate?.reportDate ?? DateTime.now(),
      status: reportForDate?.status ?? WorkReportStatus.draft,
      summary: payload.summary,
      totalMinutes: payload.items.fold(0, (s, i) => s + i.minutesSpent),
      items: payload.items
          .asMap()
          .entries
          .map(
            (e) => WorkReportItemModel(
              id: 'item-${e.key}',
              description: e.value.description,
              minutesSpent: e.value.minutesSpent,
              reportId: id,
            ),
          )
          .toList(),
    );
    reportForDate = updated;
    return (updated, null);
  }

  @override
  Future<(WorkReportModel?, AppFailure?)> submitReport(String id) async {
    final submitted = reportForDate?.copyWith(
      status: WorkReportStatus.submitted,
      submittedAt: DateTime.now(),
    );
    reportForDate = submitted;
    return (submitted, null);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeTaskRepository implements TaskRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final testToday = DateTime(2026, 10, 22);
  final testDateKey = WorkReportRules.toIsoDate(testToday);

  group('Work Reports End-to-End Integration Flow', () {
    test(
      'creates draft work report, updates items, saves, and submits for review',
      () async {
        final fakeRepo = _FakeWorkReportRepository();
        final fakeTaskRepo = _FakeTaskRepository();

        final container = ProviderContainer(
          overrides: [
            workReportRepositoryProvider.overrideWithValue(fakeRepo),
            taskRepositoryProvider.overrideWithValue(fakeTaskRepo),
            workReportTodayProvider.overrideWithValue(testToday),
            runtimeAppConfigControllerProvider.overrideWith(
              () => _FakeRuntimeAppConfigController(const RuntimeAppConfig()),
            ),
          ],
        );
        addTearDown(container.dispose);

        // 1. Initialize editor controller for today
        final initialEditorState = await container.read(
          workReportEditorControllerProvider(testDateKey).future,
        );
        expect(initialEditorState.report, isNull);
        expect(initialEditorState.items.isNotEmpty, isTrue);

        final controller = container.read(
          workReportEditorControllerProvider(testDateKey).notifier,
        );

        // 2. Add description and minutes spent
        final firstRowId = initialEditorState.items.first.localId;
        controller.setDescription(firstRowId, 'Client onboarding meeting');
        controller.setMinutes(firstRowId, 120);
        controller.setSummary('Completed morning sprint tasks');

        // 3. Save as draft
        final draftSaved = await controller.save();
        expect(draftSaved, isTrue);
        expect(fakeRepo.reportForDate?.status, WorkReportStatus.draft);
        expect(fakeRepo.reportForDate?.totalMinutes, 120);

        // 4. Submit report
        final submitted = await controller.submit();
        expect(submitted, isTrue);
        expect(fakeRepo.reportForDate?.status, WorkReportStatus.submitted);

        // 5. Verify submitted state locks or reflects in state
        final currentState = container
            .read(
              workReportEditorControllerProvider(testDateKey),
            )
            .value;
        expect(currentState?.report?.isSubmitted, isTrue);
      },
    );
  });
}
