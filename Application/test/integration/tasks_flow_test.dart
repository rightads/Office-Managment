import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/tasks/application/task_detail_controller.dart';
import 'package:right_ads/features/tasks/application/task_list_controller.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

class _TestPermissionsController extends UserPermissionsController {
  _TestPermissionsController(this._initial);
  final Set<String> _initial;

  @override
  PermissionSet build() => PermissionSet(_initial);
}

class _FakeTaskRepository implements TaskRepository {
  _FakeTaskRepository({
    required this.taskDetail,
    required this.statuses,
    required this.transitions,
  });

  TaskItemModel taskDetail;
  final List<TaskStatusModel> statuses;
  final List<TaskStatusTransitionModel> transitions;
  final List<TaskCommentModel> comments = [];
  String? updatedStatusId;
  String? lastCommentContent;

  @override
  Future<(TaskItemModel?, AppFailure?)> getTaskDetail(String taskId) async {
    return (taskDetail, null);
  }

  @override
  Future<(TaskItemModel?, AppFailure?)> updateTaskStatus({
    required String taskId,
    required String toStatusId,
    String? remarks,
  }) async {
    updatedStatusId = toStatusId;
    final newStatus = statuses.firstWhere((s) => s.id == toStatusId);
    taskDetail = taskDetail.copyWith(status: newStatus);
    return (taskDetail, null);
  }

  @override
  Future<(TaskCommentModel?, AppFailure?)> addTaskComment({
    required String taskId,
    required String comment,
  }) async {
    lastCommentContent = comment;
    final commentModel = TaskCommentModel(
      id: 'cmt-new-1',
      taskId: taskId,
      author: const UserBriefModel(
        id: 'u-1',
        fullName: 'Creative Lead',
        employeeCode: 'EMP-001',
        email: 'lead@rightads.com',
      ),
      comment: comment,
      createdAt: DateTime.utc(2026, 10, 22, 11),
    );
    return (commentModel, null);
  }

  @override
  Future<(List<TaskActivityModel>?, AppFailure?)> getTaskTimeline(
    String taskId,
  ) async => (const <TaskActivityModel>[], null);

  @override
  Future<(List<TaskCommentModel>?, AppFailure?)> getTaskComments(
    String taskId,
  ) async => (comments, null);

  @override
  Future<(List<TaskAttachmentModel>?, AppFailure?)> getTaskAttachments(
    String taskId,
  ) async => (const <TaskAttachmentModel>[], null);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const statusTodo = TaskStatusModel(
    id: 'st-todo',
    code: 'TO_DO',
    label: 'To Do',
    color: '#64748B',
    order: 1,
    isTerminal: false,
  );

  const statusInProgress = TaskStatusModel(
    id: 'st-in-progress',
    code: 'IN_PROGRESS',
    label: 'In Progress',
    color: '#3B82F6',
    order: 2,
    isTerminal: false,
  );

  const statusDone = TaskStatusModel(
    id: 'st-done',
    code: 'DONE',
    label: 'Completed',
    color: '#10B981',
    order: 3,
    isTerminal: true,
  );

  const priorityMedium = TaskPriorityModel(
    id: 'pr-med',
    code: 'MEDIUM',
    label: 'Medium',
    weight: 2,
    color: '#F59E0B',
  );

  const userLead = UserBriefModel(
    id: 'u-1',
    fullName: 'Creative Lead',
    employeeCode: 'EMP-001',
    email: 'lead@rightads.com',
  );

  final sampleTask = TaskItemModel(
    id: 'task-101',
    title: 'Design Diwali Campaign Banners',
    priority: priorityMedium,
    status: statusTodo,
    assigner: userLead,
    createdAt: DateTime.utc(2026, 10, 20, 8),
    updatedAt: DateTime.utc(2026, 10, 20, 8),
  );

  final transitions = [
    const TaskStatusTransitionModel(
      id: 'tr-1',
      fromStatusId: 'st-todo',
      toStatusId: 'st-in-progress',
    ),
    const TaskStatusTransitionModel(
      id: 'tr-2',
      fromStatusId: 'st-in-progress',
      toStatusId: 'st-done',
    ),
  ];

  group('Tasks End-to-End Integration Flow', () {
    test(
      'executes status progression TO_DO -> IN_PROGRESS -> DONE and records comments',
      () async {
        final fakeRepo = _FakeTaskRepository(
          taskDetail: sampleTask,
          statuses: [statusTodo, statusInProgress, statusDone],
          transitions: transitions,
        );

        final container = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(fakeRepo),
            taskStatusesProvider.overrideWith(
              (ref) async => [statusTodo, statusInProgress, statusDone],
            ),
            taskStatusTransitionsProvider.overrideWith(
              (ref) async => transitions,
            ),
            userPermissionsControllerProvider.overrideWith(
              () => _TestPermissionsController({
                'task.update',
                'task.view_assigned',
              }),
            ),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          taskDetailControllerProvider('task-101').notifier,
        );
        await controller.load();

        // 1. Check allowed target statuses from TO_DO
        final allowedFromTodo = controller.getAllowedTargetStatuses();
        expect(allowedFromTodo.length, 1);
        expect(allowedFromTodo.first.code, 'IN_PROGRESS');

        // 2. Advance to IN_PROGRESS
        final transitionedToInProgress = await controller.updateStatus(
          toStatusId: 'st-in-progress',
        );
        expect(transitionedToInProgress, isTrue);
        expect(fakeRepo.updatedStatusId, 'st-in-progress');
        expect(controller.state.task.value?.status.code, 'IN_PROGRESS');

        // 3. Advance to DONE
        final allowedFromProgress = controller.getAllowedTargetStatuses();
        expect(allowedFromProgress.length, 1);
        expect(allowedFromProgress.first.code, 'DONE');

        final transitionedToDone = await controller.updateStatus(
          toStatusId: 'st-done',
        );
        expect(transitionedToDone, isTrue);
        expect(fakeRepo.updatedStatusId, 'st-done');
        expect(controller.state.task.value?.status.code, 'DONE');

        // 4. Add a comment
        final commentAdded = await controller.addComment(
          'Asset delivery completed on Drive.',
        );
        expect(commentAdded, isTrue);
        expect(
          fakeRepo.lastCommentContent,
          'Asset delivery completed on Drive.',
        );
        expect(controller.state.comments.length, 1);
      },
    );
  });
}
