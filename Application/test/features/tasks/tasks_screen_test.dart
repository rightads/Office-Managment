import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/theme/app_theme.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/features/tasks/application/task_detail_controller.dart';
import 'package:right_ads/features/tasks/application/task_list_controller.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:right_ads/features/tasks/presentation/task_detail_screen.dart';
import 'package:right_ads/features/tasks/presentation/tasks_screen.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_card_widget.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_status_transition_dialog.dart';

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

class _FakeTaskListController extends TaskListController {
  _FakeTaskListController(this._initialState);
  final TaskListState _initialState;

  @override
  TaskListState build() => _initialState;

  @override
  Future<void> loadInitial() async {}

  @override
  Future<void> refresh() async {}
}

class _FakeTaskDetailController extends TaskDetailController {
  _FakeTaskDetailController(this._initialState, this._allowedStatuses);
  final TaskDetailState _initialState;
  final List<TaskStatusModel> _allowedStatuses;

  @override
  TaskDetailState build(String taskId) => _initialState;

  @override
  Future<void> load() async {}

  @override
  List<TaskStatusModel> getAllowedTargetStatuses() => _allowedStatuses;
}

Widget _buildTasksScreenHarness({
  required TaskListState taskListState,
  List<TaskStatusModel> statuses = const [],
}) {
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
        () => _FakeRuntimeAppConfigController(
          const RuntimeAppConfig(),
        ),
      ),
      userPermissionsControllerProvider.overrideWith(
        () =>
            _TestPermissionsController({'task.view_assigned', 'task.complete'}),
      ),
      taskStatusesProvider.overrideWith((ref) async => statuses),
      taskPrioritiesProvider.overrideWith((ref) async => <TaskPriorityModel>[]),
      taskDepartmentsProvider.overrideWith((ref) async => <DepartmentModel>[]),
      taskClientsProvider.overrideWith((ref) async => <ClientBriefModel>[]),
      taskProjectsProvider.overrideWith((ref) async => <ProjectBriefModel>[]),
      taskListControllerProvider.overrideWith(
        () => _FakeTaskListController(taskListState),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const TasksScreen(),
    ),
  );
}

Widget _buildTaskCardHarness({
  required TaskItemModel task,
  required VoidCallback onTap,
}) {
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
        () => _FakeRuntimeAppConfigController(
          const RuntimeAppConfig(),
        ),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: TaskCardWidget(
          task: task,
          onTap: onTap,
        ),
      ),
    ),
  );
}

Widget _buildTaskDetailScreenHarness({
  required String taskId,
  required TaskDetailState detailState,
  List<TaskStatusModel> allowedStatuses = const [],
}) {
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
        () => _FakeRuntimeAppConfigController(
          const RuntimeAppConfig(),
        ),
      ),
      userPermissionsControllerProvider.overrideWith(
        () =>
            _TestPermissionsController({'task.view_assigned', 'task.complete'}),
      ),
      taskDetailControllerProvider(taskId).overrideWith(
        () => _FakeTaskDetailController(detailState, allowedStatuses),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: TaskDetailScreen(taskId: taskId),
    ),
  );
}

void main() {
  const todoStatus = TaskStatusModel(
    id: 'st-todo',
    code: 'todo',
    label: 'To Do',
    color: '#3B82F6',
    order: 1,
    isTerminal: false,
  );
  const inProgStatus = TaskStatusModel(
    id: 'st-inprog',
    code: 'in_progress',
    label: 'In Progress',
    color: '#F59E0B',
    order: 2,
    isTerminal: false,
  );
  const doneStatus = TaskStatusModel(
    id: 'st-done',
    code: 'completed',
    label: 'Completed',
    color: '#10B981',
    order: 3,
    isTerminal: true,
  );

  const supervisorUser = UserBriefModel(
    id: 'u-1',
    employeeCode: 'EMP001',
    fullName: 'Supervisor David',
    email: 'david@agency.com',
  );

  const sarahUser = UserBriefModel(
    id: 'u-2',
    employeeCode: 'EMP002',
    fullName: 'Sarah Designer',
    email: 'sarah@agency.com',
  );

  final sampleTask = TaskItemModel(
    id: 'task-1',
    title: 'Billboard Campaign Design',
    description: 'Design key visual for roadside billboards',
    status: inProgStatus,
    priority: const TaskPriorityModel(
      id: 'pr-high',
      code: 'high',
      label: 'High',
      color: '#EF4444',
      weight: 3,
    ),
    assigner: supervisorUser,
    assignees: const [sarahUser],
    dueAt: DateTime.parse('2026-10-25T18:00:00Z'),
    isOverdue: true,
    commentsCount: 2,
    attachmentsCount: 1,
    createdAt: DateTime.parse('2026-10-18T10:00:00Z'),
    updatedAt: DateTime.parse('2026-10-18T12:00:00Z'),
  );

  group('TasksScreen Widget Tests', () {
    testWidgets('Renders dynamic status tabs in server-ordered sequence', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTasksScreenHarness(
          statuses: const [todoStatus, inProgStatus, doneStatus],
          taskListState: TaskListState(
            tasks: [sampleTask],
            totalCount: 1,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check dynamic tabs are rendered in order: All, To Do, In Progress, Completed
      expect(find.text('All'), findsOneWidget);
      expect(find.text('To Do'), findsOneWidget);
      expect(find.widgetWithText(Tab, 'In Progress'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);

      // Check task card is displayed
      expect(find.text('Billboard Campaign Design'), findsOneWidget);
      expect(find.text('High'), findsOneWidget);
      expect(find.text('OVERDUE'), findsOneWidget);
    });

    testWidgets(
      'TaskCardWidget displays priority, assigner, and overdue badge',
      (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          _buildTaskCardHarness(
            task: sampleTask,
            onTap: () => tapped = true,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Billboard Campaign Design'), findsOneWidget);
        expect(find.byType(AvatarWithInitials), findsOneWidget);
        expect(find.text('High'), findsOneWidget);
        expect(find.text('OVERDUE'), findsOneWidget);

        await tester.tap(find.byType(TaskCardWidget));
        expect(tapped, isTrue);
      },
    );
  });

  group('TaskDetailScreen Widget Tests', () {
    testWidgets('Renders task detail info and status transition dialog', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTaskDetailScreenHarness(
          taskId: 'task-1',
          detailState: TaskDetailState(
            task: AsyncValue.data(sampleTask),
            timeline: [
              TaskActivityModel(
                id: 'act-1',
                taskId: 'task-1',
                action: 'created',
                actor: supervisorUser,
                createdAt: DateTime.parse('2026-10-18T10:00:00Z'),
              ),
            ],
            comments: [
              TaskCommentModel(
                id: 'com-1',
                taskId: 'task-1',
                author: supervisorUser,
                comment: 'Please check brand guidelines.',
                createdAt: DateTime.parse('2026-10-18T11:00:00Z'),
              ),
            ],
            attachments: [
              TaskAttachmentModel(
                id: 'att-1',
                taskId: 'task-1',
                fileName: 'specs.pdf',
                fileSizeBytes: 2048,
                mimeType: 'application/pdf',
                downloadUrl: 'https://s3.example.com/specs.pdf',
                uploader: supervisorUser,
                createdAt: DateTime.parse('2026-10-18T11:30:00Z'),
              ),
            ],
          ),
          allowedStatuses: const [doneStatus],
        ),
      );

      await tester.pumpAndSettle();

      // Check header and core info
      expect(find.text('Billboard Campaign Design'), findsOneWidget);
      expect(
        find.text('Design key visual for roadside billboards'),
        findsOneWidget,
      );
      expect(find.text('Change Status'), findsOneWidget);

      // Open status transition dialog
      await tester.tap(find.text('Change Status'));
      await tester.pumpAndSettle();

      // Dialog should appear with allowed transition 'Completed'
      expect(find.byType(TaskStatusTransitionDialog), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });
  });
}
