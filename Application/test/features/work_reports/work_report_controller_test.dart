import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:right_ads/features/work_reports/application/work_report_controller.dart';
import 'package:right_ads/features/work_reports/data/work_report_repository.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';

class _FakeWorkReportRepository extends WorkReportRepository {
  _FakeWorkReportRepository() : super(dio: Dio());

  WorkReportModel? mockReportByDate;
  AppFailure? mockReportByDateFailure;

  WorkReportModel? mockReportById;
  AppFailure? mockReportByIdFailure;

  WorkReportPageResponse? mockPageResponse;
  AppFailure? mockPageFailure;

  WorkReportModel? mockCreatedReport;
  AppFailure? mockCreateFailure;

  WorkReportModel? mockUpdatedReport;
  AppFailure? mockUpdateFailure;

  WorkReportModel? mockSubmittedReport;
  AppFailure? mockSubmitFailure;

  @override
  Future<(WorkReportModel?, AppFailure?)> getByDate(DateTime date) async {
    if (mockReportByDateFailure != null) return (null, mockReportByDateFailure);
    return (mockReportByDate, null);
  }

  @override
  Future<(WorkReportModel?, AppFailure?)> getById(String id) async {
    if (mockReportByIdFailure != null) return (null, mockReportByIdFailure);
    return (mockReportById, null);
  }

  @override
  Future<(WorkReportPageResponse?, AppFailure?)> getMyReports({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (mockPageFailure != null) return (null, mockPageFailure);
    return (mockPageResponse, null);
  }

  @override
  Future<(WorkReportModel?, AppFailure?)> createOrSaveDraft(
    WorkReportCreatePayload payload,
  ) async {
    if (mockCreateFailure != null) return (null, mockCreateFailure);
    return (mockCreatedReport, null);
  }

  @override
  Future<(WorkReportModel?, AppFailure?)> updateReport(
    String id,
    WorkReportUpdatePayload payload,
  ) async {
    if (mockUpdateFailure != null) return (null, mockUpdateFailure);
    return (mockUpdatedReport, null);
  }

  @override
  Future<(WorkReportModel?, AppFailure?)> submitReport(String id) async {
    if (mockSubmitFailure != null) return (null, mockSubmitFailure);
    return (mockSubmittedReport, null);
  }
}

void main() {
  group('WorkReport Controllers Tests', () {
    late _FakeWorkReportRepository fakeRepo;
    late ProviderContainer container;

    const runtimeConfig = RuntimeAppConfig(
      workReportMaxMinutesPerDay: 480, // 8 hours
    );

    setUp(() {
      fakeRepo = _FakeWorkReportRepository();
      container = ProviderContainer(
        overrides: [
          workReportRepositoryProvider.overrideWithValue(fakeRepo),
          runtimeAppConfigControllerProvider.overrideWith(
            () => _FakeRuntimeConfigNotifier(runtimeConfig),
          ),
          workReportTodayProvider.overrideWithValue(DateTime(2026, 10, 20)),
        ],
      );
    });

    tearDown(() => container.dispose());

    group('WorkReportEditorController', () {
      const todayKey = '2026-10-20';

      test(
        'initializes with a blank draft row when no existing report',
        () async {
          fakeRepo.mockReportByDate = null;

          final stateAsync = await container.read(
            workReportEditorControllerProvider(todayKey).future,
          );

          expect(stateAsync.report, isNull);
          expect(stateAsync.summary, '');
          expect(stateAsync.items.length, 1);
          expect(stateAsync.items.first.description, '');
          expect(stateAsync.items.first.minutes, isNull);
          expect(stateAsync.totalMinutes, 0);
        },
      );

      test(
        'initializes with server items when existing report is returned',
        () async {
          fakeRepo.mockReportByDate = WorkReportModel(
            id: 'wr-1',
            reportDate: DateTime(2026, 10, 20),
            status: 'draft',
            summary: 'Existing summary',
            totalMinutes: 120,
            items: const [
              WorkReportItemModel(
                id: 'wri-1',
                description: 'Initial task',
                minutesSpent: 120,
              ),
            ],
          );

          final stateAsync = await container.read(
            workReportEditorControllerProvider(todayKey).future,
          );

          expect(stateAsync.report?.id, 'wr-1');
          expect(stateAsync.summary, 'Existing summary');
          expect(stateAsync.items.length, 1);
          expect(stateAsync.items.first.description, 'Initial task');
          expect(stateAsync.items.first.minutes, 120);
          expect(stateAsync.totalMinutes, 120);
        },
      );

      test(
        'adding, editing, and removing rows mutates state and updates total minutes',
        () async {
          fakeRepo.mockReportByDate = null;
          await container.read(
            workReportEditorControllerProvider(todayKey).future,
          );

          final notifier = container.read(
            workReportEditorControllerProvider(todayKey).notifier,
          );

          // Set summary
          notifier.setSummary('Worked on mobile sprint');
          expect(
            container
                .read(workReportEditorControllerProvider(todayKey))
                .value
                ?.summary,
            'Worked on mobile sprint',
          );

          // Add second row
          notifier.addItem();
          final items = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!
              .items;
          expect(items.length, 2);

          final row1 = items[0];
          final row2 = items[1];

          // Mutate first row
          notifier.setDescription(row1.localId, 'Feature A');
          notifier.setMinutes(row1.localId, 120);

          // Mutate second row
          notifier.setDescription(row2.localId, 'Feature B');
          notifier.setMinutes(row2.localId, 60);

          var state = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!;
          expect(state.totalMinutes, 180);

          // Delete first row
          notifier.removeItem(row1.localId);
          state = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!;
          expect(state.items.length, 1);
          expect(state.items.first.description, 'Feature B');
          expect(state.totalMinutes, 60);
        },
      );

      test(
        'validates minimum description length and positive minutes',
        () async {
          fakeRepo.mockReportByDate = null;
          await container.read(
            workReportEditorControllerProvider(todayKey).future,
          );

          final notifier = container.read(
            workReportEditorControllerProvider(todayKey).notifier,
          );

          // Description length < 2
          final rowId = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!
              .items
              .first
              .localId;
          notifier.setDescription(rowId, 'X'); // 1 char
          notifier.setMinutes(rowId, 60);

          final success = await notifier.save();
          expect(success, isFalse);

          final state = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!;
          expect(
            state.itemErrors[rowId],
            WorkReportItemError.descriptionTooShort,
          );
        },
      );

      test(
        'validates total minutes does not exceed maxMinutesPerDay',
        () async {
          fakeRepo.mockReportByDate = null;
          await container.read(
            workReportEditorControllerProvider(todayKey).future,
          );

          final notifier = container.read(
            workReportEditorControllerProvider(todayKey).notifier,
          );

          final rowId = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!
              .items
              .first
              .localId;
          notifier.setDescription(rowId, 'Full Day');
          notifier.setMinutes(rowId, 500); // Max is 480

          final success = await notifier.save();
          expect(success, isFalse);

          final state = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!;
          expect(state.formError, WorkReportFormError.totalExceedsMax);
        },
      );

      test('blocks saving or submitting when date is in the future', () async {
        const futureDateKey = '2026-10-25'; // Ahead of today (2026-10-20)
        fakeRepo.mockReportByDate = null;

        await container.read(
          workReportEditorControllerProvider(futureDateKey).future,
        );

        final notifier = container.read(
          workReportEditorControllerProvider(futureDateKey).notifier,
        );

        final rowId = container
            .read(workReportEditorControllerProvider(futureDateKey))
            .value!
            .items
            .first
            .localId;
        notifier.setDescription(rowId, 'Future work');
        notifier.setMinutes(rowId, 60);

        final success = await notifier.save();
        expect(success, isFalse);

        final state = container
            .read(workReportEditorControllerProvider(futureDateKey))
            .value!;
        expect(state.formError, WorkReportFormError.futureDate);
      });

      test('successful draft save creates report and updates state', () async {
        fakeRepo.mockReportByDate = null;
        fakeRepo.mockCreatedReport = WorkReportModel(
          id: 'wr-created',
          reportDate: DateTime(2026, 10, 20),
          status: 'draft',
          summary: 'Draft summary',
          totalMinutes: 60,
          items: const [
            WorkReportItemModel(
              id: 'item-1',
              description: 'Completed Task',
              minutesSpent: 60,
            ),
          ],
        );

        await container.read(
          workReportEditorControllerProvider(todayKey).future,
        );

        final notifier = container.read(
          workReportEditorControllerProvider(todayKey).notifier,
        );

        final rowId = container
            .read(workReportEditorControllerProvider(todayKey))
            .value!
            .items
            .first
            .localId;
        notifier.setDescription(rowId, 'Completed Task');
        notifier.setMinutes(rowId, 60);

        final success = await notifier.save();
        expect(success, isTrue);

        final state = container
            .read(workReportEditorControllerProvider(todayKey))
            .value!;
        expect(state.report?.id, 'wr-created');
        expect(state.report?.status, 'draft');
        expect(state.isDirty, isFalse);
      });

      test(
        'successful submit transitions report status to submitted',
        () async {
          fakeRepo.mockReportByDate = null;
          fakeRepo.mockCreatedReport = WorkReportModel(
            id: 'wr-to-sub',
            reportDate: DateTime(2026, 10, 20),
            status: 'draft',
            totalMinutes: 90,
            items: const [
              WorkReportItemModel(
                id: 'item-1',
                description: 'Submitting task',
                minutesSpent: 90,
              ),
            ],
          );
          fakeRepo.mockSubmittedReport = WorkReportModel(
            id: 'wr-to-sub',
            reportDate: DateTime(2026, 10, 20),
            status: 'submitted',
            totalMinutes: 90,
            items: const [
              WorkReportItemModel(
                id: 'item-1',
                description: 'Submitting task',
                minutesSpent: 90,
              ),
            ],
          );

          await container.read(
            workReportEditorControllerProvider(todayKey).future,
          );

          final notifier = container.read(
            workReportEditorControllerProvider(todayKey).notifier,
          );

          final rowId = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!
              .items
              .first
              .localId;
          notifier.setDescription(rowId, 'Submitting task');
          notifier.setMinutes(rowId, 90);

          final success = await notifier.submit();
          expect(success, isTrue);

          final state = container
              .read(workReportEditorControllerProvider(todayKey))
              .value!;
          expect(state.report?.status, 'submitted');
          expect(state.isSubmitting, isFalse);
        },
      );
    });

    group('WorkReportHistoryController', () {
      test('loads first page of reports on initial build', () async {
        fakeRepo.mockPageResponse = WorkReportPageResponse(
          items: [
            WorkReportModel(
              id: 'wr-h1',
              reportDate: DateTime(2026, 10, 20),
              status: 'submitted',
              totalMinutes: 120,
            ),
          ],
          total: 1,
        );

        final historyState = await container.read(
          workReportHistoryControllerProvider.future,
        );

        expect(historyState.items.length, 1);
        expect(historyState.items.first.id, 'wr-h1');
        expect(historyState.total, 1);
        expect(historyState.hasMore, isFalse);
      });

      test('setStatusFilter reloads page 1 with new filter', () async {
        fakeRepo.mockPageResponse = const WorkReportPageResponse();

        await container.read(workReportHistoryControllerProvider.future);
        final notifier = container.read(
          workReportHistoryControllerProvider.notifier,
        );

        await notifier.setStatusFilter('reviewed');

        final state = container
            .read(workReportHistoryControllerProvider)
            .value!;
        expect(state.statusFilter, 'reviewed');
      });
    });

    group('WorkReport Editor Row Mutations & Field Updates', () {
      test(
        'manipulates draft items: add, remove, edit fields, and set task',
        () async {
          const dateKey = '2026-10-21';
          await container.read(
            workReportEditorControllerProvider(dateKey).future,
          );
          final notifier = container.read(
            workReportEditorControllerProvider(dateKey).notifier,
          );

          var editorState = container
              .read(workReportEditorControllerProvider(dateKey))
              .value!;
          expect(editorState.items.length, 1);
          final initialLocalId = editorState.items.first.localId;

          // Set minutes and description
          notifier.setDescription(initialLocalId, 'Developing features');
          notifier.setMinutes(initialLocalId, 180);
          editorState = container
              .read(workReportEditorControllerProvider(dateKey))
              .value!;
          expect(editorState.items.first.description, 'Developing features');
          expect(editorState.items.first.minutes, 180);

          // Set client and project
          const client = ClientBriefModel(id: 'client-1', name: 'Acme Corp');
          const project = ProjectBriefModel(
            id: 'proj-1',
            name: 'Mobile App',
            clientId: 'client-1',
          );
          notifier.setClient(initialLocalId, client);
          notifier.setProject(initialLocalId, project);
          editorState = container
              .read(workReportEditorControllerProvider(dateKey))
              .value!;
          expect(editorState.items.first.clientId, 'client-1');
          expect(editorState.items.first.projectName, 'Mobile App');

          // Add item
          notifier.addItem();
          editorState = container
              .read(workReportEditorControllerProvider(dateKey))
              .value!;
          expect(editorState.items.length, 2);

          // Remove item
          notifier.removeItem(initialLocalId);
          editorState = container
              .read(workReportEditorControllerProvider(dateKey))
              .value!;
          expect(editorState.items.length, 1);

          // Remove last remaining item resets with empty default row
          notifier.removeItem(editorState.items.first.localId);
          editorState = container
              .read(workReportEditorControllerProvider(dateKey))
              .value!;
          expect(editorState.items.length, 1);
        },
      );
    });

    group('WorkReport Utility Providers', () {
      test('selectedWorkReportDateProvider selects and clears date', () {
        final notifier = container.read(
          selectedWorkReportDateProvider.notifier,
        );
        expect(container.read(selectedWorkReportDateProvider), isNull);

        notifier.select('2026-10-22');
        expect(container.read(selectedWorkReportDateProvider), '2026-10-22');

        notifier.select(null);
        expect(container.read(selectedWorkReportDateProvider), isNull);
      });
    });
  });
}

class _FakeRuntimeConfigNotifier extends RuntimeAppConfigController {
  _FakeRuntimeConfigNotifier(this._initial);

  final RuntimeAppConfig _initial;

  @override
  RuntimeAppConfig build() => _initial;
}
