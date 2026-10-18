import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_controller.freezed.dart';
part 'task_list_controller.g.dart';

@freezed
abstract class TaskListState with _$TaskListState {
  const factory TaskListState({
    @Default(<TaskItemModel>[]) List<TaskItemModel> tasks,
    @Default(1) int page,
    @Default(20) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasMore,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingNextPage,
    @Default(TaskFilterState()) TaskFilterState filter,
    String? errorMessage,
  }) = _TaskListState;
}

@Riverpod(keepAlive: true)
Future<List<TaskStatusModel>> taskStatuses(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final (statuses, _) = await repo.getTaskStatuses();
  return statuses ?? <TaskStatusModel>[];
}

@Riverpod(keepAlive: true)
Future<List<TaskPriorityModel>> taskPriorities(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final (priorities, _) = await repo.getTaskPriorities();
  return priorities ?? <TaskPriorityModel>[];
}

@Riverpod(keepAlive: true)
Future<List<TaskStatusTransitionModel>> taskStatusTransitions(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final (transitions, _) = await repo.getTaskStatusTransitions();
  return transitions ?? <TaskStatusTransitionModel>[];
}

@Riverpod(keepAlive: true)
Future<List<DepartmentModel>> taskDepartments(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final (depts, _) = await repo.getDepartments();
  return depts ?? <DepartmentModel>[];
}

@Riverpod(keepAlive: true)
Future<List<ClientBriefModel>> taskClients(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final (clients, _) = await repo.getClients();
  return clients ?? <ClientBriefModel>[];
}

@Riverpod(keepAlive: true)
Future<List<ProjectBriefModel>> taskProjects(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final (projects, _) = await repo.getProjects();
  return projects ?? <ProjectBriefModel>[];
}

@riverpod
class TaskListController extends _$TaskListController {
  @override
  TaskListState build() {
    // Initial fetch on build
    unawaited(Future<void>.microtask(loadInitial));
    return const TaskListState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final repo = ref.read(taskRepositoryProvider);
    final (response, failure) = await repo.getMyTasks(
      filter: state.filter,
      pageSize: state.pageSize,
    );

    if (failure != null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      );
      return;
    }

    if (response != null) {
      final hasMore = response.page < response.pages;
      state = state.copyWith(
        tasks: response.items,
        page: response.page,
        totalCount: response.total,
        hasMore: hasMore,
        isLoading: false,
        errorMessage: null,
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingNextPage || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoadingNextPage: true);
    final nextPage = state.page + 1;
    final repo = ref.read(taskRepositoryProvider);
    final (response, failure) = await repo.getMyTasks(
      filter: state.filter,
      page: nextPage,
      pageSize: state.pageSize,
    );

    if (failure != null) {
      state = state.copyWith(
        isLoadingNextPage: false,
        errorMessage: failure.message,
      );
      return;
    }

    if (response != null) {
      final combined = <TaskItemModel>[
        ...state.tasks,
        ...response.items,
      ];
      final hasMore = response.page < response.pages;
      state = state.copyWith(
        tasks: combined,
        page: response.page,
        totalCount: response.total,
        hasMore: hasMore,
        isLoadingNextPage: false,
      );
    }
  }

  Future<void> refresh() async {
    final repo = ref.read(taskRepositoryProvider);
    final (response, failure) = await repo.getMyTasks(
      filter: state.filter,
      pageSize: state.pageSize,
    );

    if (failure != null) {
      state = state.copyWith(errorMessage: failure.message);
      return;
    }

    if (response != null) {
      final hasMore = response.page < response.pages;
      state = state.copyWith(
        tasks: response.items,
        page: response.page,
        totalCount: response.total,
        hasMore: hasMore,
        isLoading: false,
        errorMessage: null,
      );
    }
  }

  void selectStatusTab(String? statusId) {
    if (state.filter.statusId == statusId) return;
    final updatedFilter = state.filter.copyWith(statusId: statusId);
    state = state.copyWith(filter: updatedFilter);
    unawaited(loadInitial());
  }

  void setSearch(String query) {
    final sanitized = query.trim().isEmpty ? null : query.trim();
    if (state.filter.search == sanitized) return;
    final updatedFilter = state.filter.copyWith(search: sanitized);
    state = state.copyWith(filter: updatedFilter);
    unawaited(loadInitial());
  }

  void applyFilter(TaskFilterState newFilter) {
    state = state.copyWith(filter: newFilter);
    unawaited(loadInitial());
  }

  void resetFilter() {
    state = state.copyWith(filter: const TaskFilterState());
    unawaited(loadInitial());
  }
}
