import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/tasks/application/task_detail_controller.dart';
import 'package:right_ads/features/tasks/application/task_list_controller.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

class _FakeTaskRepository extends TaskRepository {
  _FakeTaskRepository() : super(dio: Dio());

  TaskPageResponse? mockPageResponse;
  AppFailure? mockPageFailure;

  TaskItemModel? mockTaskDetail;
  AppFailure? mockDetailFailure;

  List<TaskStatusModel> mockStatuses = [];
  List<TaskStatusTransitionModel> mockTransitions = [];

  TaskItemModel? updatedTaskResult;
  AppFailure? updateStatusFailure;

  TaskCommentModel? newCommentResult;
  AppFailure? commentFailure;

  TaskAttachmentModel? newAttachmentResult;
  AppFailure? attachmentFailure;

  @override
  Future<(TaskPageResponse?, AppFailure?)> getMyTasks({
    TaskFilterState filter = const TaskFilterState(),
    int page = 1,
    int pageSize = 20,
  }) async {
    if (mockPageFailure != null) return (null, mockPageFailure);
    return (mockPageResponse, null);
  }

  @override
  Future<(TaskItemModel?, AppFailure?)> getTaskDetail(String taskId) async {
    if (mockDetailFailure != null) return (null, mockDetailFailure);
    return (mockTaskDetail, null);
  }

  @override
  Future<(List<TaskStatusModel>?, AppFailure?)> getTaskStatuses() async {
    return (mockStatuses, null);
  }

  @override
  Future<(List<TaskStatusTransitionModel>?, AppFailure?)>
  getTaskStatusTransitions() async {
    return (mockTransitions, null);
  }

  @override
  Future<(List<TaskActivityModel>?, AppFailure?)> getTaskTimeline(
    String taskId,
  ) async {
    return (<TaskActivityModel>[], null);
  }

  @override
  Future<(List<TaskCommentModel>?, AppFailure?)> getTaskComments(
    String taskId,
  ) async {
    return (<TaskCommentModel>[], null);
  }

  @override
  Future<(List<TaskAttachmentModel>?, AppFailure?)> getTaskAttachments(
    String taskId,
  ) async {
    return (<TaskAttachmentModel>[], null);
  }

  @override
  Future<(TaskItemModel?, AppFailure?)> updateTaskStatus({
    required String taskId,
    required String toStatusId,
    String? remarks,
  }) async {
    if (updateStatusFailure != null) return (null, updateStatusFailure);
    return (updatedTaskResult, null);
  }

  @override
  Future<(TaskCommentModel?, AppFailure?)> addTaskComment({
    required String taskId,
    required String comment,
  }) async {
    if (commentFailure != null) return (null, commentFailure);
    return (newCommentResult, null);
  }

  @override
  Future<(TaskAttachmentModel?, AppFailure?)> uploadTaskAttachment({
    required String taskId,
    required List<int> fileBytes,
    required String fileName,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    if (attachmentFailure != null) return (null, attachmentFailure);
    return (newAttachmentResult, null);
  }
}

class _TestPermissionsController extends UserPermissionsController {
  _TestPermissionsController(this._initial);
  final Set<String> _initial;

  @override
  PermissionSet build() => PermissionSet(_initial);
}

class _FakeRuntimeAppConfigController extends RuntimeAppConfigController {
  _FakeRuntimeAppConfigController(this._config);
  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;
}

void main() {
  const managerUser = UserBriefModel(
    id: 'u-1',
    employeeCode: 'EMP001',
    fullName: 'Manager Bob',
    email: 'bob@agency.com',
  );

  const normalPriority = TaskPriorityModel(
    id: 'pr-1',
    code: 'normal',
    label: 'Normal',
    weight: 2,
    color: '#3B82F6',
  );

  const openStatus = TaskStatusModel(
    id: 'st-open',
    code: 'open',
    label: 'Open',
    color: '#3B82F6',
    order: 1,
    isTerminal: false,
  );

  const inProgressStatus = TaskStatusModel(
    id: 'st-prog',
    code: 'in_progress',
    label: 'In Progress',
    color: '#F59E0B',
    order: 2,
    isTerminal: false,
  );

  const doneStatus = TaskStatusModel(
    id: 'st-done',
    code: 'completed',
    label: 'Done',
    color: '#10B981',
    order: 3,
    isTerminal: true,
  );

  group('TaskListController Tests', () {
    late _FakeTaskRepository fakeRepo;

    final sampleTask = TaskItemModel(
      id: 'task-1',
      title: 'Campaign Visuals',
      priority: normalPriority,
      status: openStatus,
      assigner: managerUser,
      createdAt: DateTime.parse('2026-10-18T10:00:00Z'),
      updatedAt: DateTime.parse('2026-10-18T10:00:00Z'),
    );

    setUp(() {
      fakeRepo = _FakeTaskRepository()
        ..mockPageResponse = TaskPageResponse(
          items: [sampleTask],
          total: 1,
          page: 1,
          pageSize: 20,
        );
    });

    test('Initial build triggers load and populates tasks', () async {
      final element = ProviderContainer(
        overrides: [taskRepositoryProvider.overrideWithValue(fakeRepo)],
      );

      final state = element.read(taskListControllerProvider);
      expect(state.isLoading, isTrue);

      await element.read(taskListControllerProvider.notifier).loadInitial();

      final loadedState = element.read(taskListControllerProvider);
      expect(loadedState.isLoading, isFalse);
      expect(loadedState.tasks.length, 1);
      expect(loadedState.tasks.first.title, 'Campaign Visuals');
    });

    test('selectStatusTab updates filter state and reloads', () async {
      final element = ProviderContainer(
        overrides: [taskRepositoryProvider.overrideWithValue(fakeRepo)],
      );

      await element.read(taskListControllerProvider.notifier).loadInitial();

      element
          .read(taskListControllerProvider.notifier)
          .selectStatusTab('st-in-progress');
      expect(
        element.read(taskListControllerProvider).filter.statusId,
        'st-in-progress',
      );

      element.read(taskListControllerProvider.notifier).resetFilter();
      expect(element.read(taskListControllerProvider).filter.statusId, isNull);
    });
  });

  group('TaskDetailController Tests', () {
    late _FakeTaskRepository fakeRepo;

    const transitionToProg = TaskStatusTransitionModel(
      id: 'tr-1',
      fromStatusId: 'st-open',
      toStatusId: 'st-prog',
    );
    const transitionToDone = TaskStatusTransitionModel(
      id: 'tr-2',
      fromStatusId: 'st-prog',
      toStatusId: 'st-done',
      requiredPermission: 'task.complete',
    );

    final sampleTask = TaskItemModel(
      id: 'task-100',
      title: 'Packaging Art',
      priority: normalPriority,
      status: inProgressStatus,
      assigner: managerUser,
      createdAt: DateTime.parse('2026-10-18T10:00:00Z'),
      updatedAt: DateTime.parse('2026-10-18T10:00:00Z'),
    );

    setUp(() {
      fakeRepo = _FakeTaskRepository()
        ..mockTaskDetail = sampleTask
        ..mockStatuses = [openStatus, inProgressStatus, doneStatus]
        ..mockTransitions = [transitionToProg, transitionToDone];
    });

    test(
      'getAllowedTargetStatuses filters strictly by transitions and user permissions',
      () async {
        // User WITHOUT task.complete permission
        final containerNoPerm = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(fakeRepo),
            userPermissionsControllerProvider.overrideWith(
              () => _TestPermissionsController({'task.view_assigned'}),
            ),
            taskStatusesProvider.overrideWith(
              (ref) async => [openStatus, inProgressStatus, doneStatus],
            ),
            taskStatusTransitionsProvider.overrideWith(
              (ref) async => [transitionToProg, transitionToDone],
            ),
          ],
        );

        final controllerNoPerm = containerNoPerm.read(
          taskDetailControllerProvider('task-100').notifier,
        );
        await controllerNoPerm.load();

        final allowedNoPerm = controllerNoPerm.getAllowedTargetStatuses();

        // Since user lacks task.complete, transition to done is disallowed!
        expect(allowedNoPerm.isEmpty, isTrue);

        // User WITH task.complete permission
        final containerWithPerm = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(fakeRepo),
            userPermissionsControllerProvider.overrideWith(
              () => _TestPermissionsController({'task.complete'}),
            ),
            taskStatusesProvider.overrideWith(
              (ref) async => [openStatus, inProgressStatus, doneStatus],
            ),
            taskStatusTransitionsProvider.overrideWith(
              (ref) async => [transitionToProg, transitionToDone],
            ),
          ],
        );

        final controllerWithPerm = containerWithPerm.read(
          taskDetailControllerProvider('task-100').notifier,
        );
        await controllerWithPerm.load();

        final allowedWithPerm = controllerWithPerm.getAllowedTargetStatuses();

        // Now allowed!
        expect(allowedWithPerm.length, 1);
        expect(allowedWithPerm.first.id, 'st-done');
      },
    );

    test(
      'updateStatus performs optimistic update and rolls back on failure',
      () async {
        fakeRepo.updateStatusFailure = const AppFailure.server(
          message: 'Server error updating status',
        );

        final container = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(fakeRepo),
            taskStatusesProvider.overrideWith(
              (ref) async => [openStatus, inProgressStatus, doneStatus],
            ),
          ],
        );

        final controller = container.read(
          taskDetailControllerProvider('task-100').notifier,
        );
        await controller.load();

        final success = await controller.updateStatus(toStatusId: 'st-done');
        expect(success, isFalse);

        final currentState = container.read(
          taskDetailControllerProvider('task-100'),
        );
        // Verified rollback to inProgressStatus!
        expect(currentState.task.value?.status.id, 'st-prog');
        expect(currentState.errorMessage, 'Server error updating status');
      },
    );

    test(
      'updateStatus applies server response without client setting completed_at locally',
      () async {
        fakeRepo.updatedTaskResult = sampleTask.copyWith(
          status: doneStatus,
          completedAt: DateTime.parse(
            '2026-10-18T18:00:00Z',
          ), // Server-stamped timestamp
        );

        final container = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(fakeRepo),
            taskStatusesProvider.overrideWith(
              (ref) async => [openStatus, inProgressStatus, doneStatus],
            ),
          ],
        );

        final controller = container.read(
          taskDetailControllerProvider('task-100').notifier,
        );
        await controller.load();

        final success = await controller.updateStatus(toStatusId: 'st-done');
        expect(success, isTrue);

        final currentState = container.read(
          taskDetailControllerProvider('task-100'),
        );
        expect(currentState.task.value?.status.id, 'st-done');
        expect(
          currentState.task.value?.completedAt,
          DateTime.parse('2026-10-18T18:00:00Z'),
        );
        expect(currentState.errorMessage, isNull);
      },
    );

    test(
      'uploadAttachment validates size and MIME against RuntimeAppConfig',
      () async {
        final container = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(fakeRepo),
            runtimeAppConfigControllerProvider.overrideWith(
              () => _FakeRuntimeAppConfigController(
                const RuntimeAppConfig(
                  maxUploadMb: 2,
                  allowedUploadMimeTypes: ['image/png', 'application/pdf'],
                ),
              ),
            ),
          ],
        );

        final controller = container.read(
          taskDetailControllerProvider('task-100').notifier,
        );
        await controller.load();

        // 1. File exceeding 2 MB
        final oversizedBytes = List<int>.filled(3 * 1024 * 1024, 0);
        final sizeResult = await controller.uploadAttachment(
          fileBytes: oversizedBytes,
          fileName: 'huge.pdf',
          mimeType: 'application/pdf',
        );
        expect(sizeResult, isFalse);
        expect(
          container.read(taskDetailControllerProvider('task-100')).errorMessage,
          contains('exceeds allowed maximum of 2 MB'),
        );

        // 2. Disallowed MIME type
        final smallBytes = [1, 2, 3];
        final mimeResult = await controller.uploadAttachment(
          fileBytes: smallBytes,
          fileName: 'app.exe',
          mimeType: 'application/x-msdownload',
        );
        expect(mimeResult, isFalse);
        expect(
          container.read(taskDetailControllerProvider('task-100')).errorMessage,
          contains('not permitted'),
        );

        // 3. Valid file
        fakeRepo.newAttachmentResult = TaskAttachmentModel(
          id: 'att-1',
          taskId: 'task-100',
          fileName: 'design.png',
          fileSizeBytes: 3,
          mimeType: 'image/png',
          downloadUrl: 'https://s3.example.com/design.png',
          uploader: managerUser,
          createdAt: DateTime.parse('2026-10-18T12:00:00Z'),
        );

        final validResult = await controller.uploadAttachment(
          fileBytes: smallBytes,
          fileName: 'design.png',
          mimeType: 'image/png',
        );
        expect(validResult, isTrue);
        expect(
          container
              .read(taskDetailControllerProvider('task-100'))
              .attachments
              .length,
          1,
        );
      },
    );
  });
}
