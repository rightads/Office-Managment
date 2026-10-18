// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskStatuses)
final taskStatusesProvider = TaskStatusesProvider._();

final class TaskStatusesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskStatusModel>>,
          List<TaskStatusModel>,
          FutureOr<List<TaskStatusModel>>
        >
    with
        $FutureModifier<List<TaskStatusModel>>,
        $FutureProvider<List<TaskStatusModel>> {
  TaskStatusesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskStatusesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskStatusesHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskStatusModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskStatusModel>> create(Ref ref) {
    return taskStatuses(ref);
  }
}

String _$taskStatusesHash() => r'89fade480242515a4c3ef665f9ba3a2829358172';

@ProviderFor(taskPriorities)
final taskPrioritiesProvider = TaskPrioritiesProvider._();

final class TaskPrioritiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskPriorityModel>>,
          List<TaskPriorityModel>,
          FutureOr<List<TaskPriorityModel>>
        >
    with
        $FutureModifier<List<TaskPriorityModel>>,
        $FutureProvider<List<TaskPriorityModel>> {
  TaskPrioritiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskPrioritiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskPrioritiesHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskPriorityModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskPriorityModel>> create(Ref ref) {
    return taskPriorities(ref);
  }
}

String _$taskPrioritiesHash() => r'c83232ae944c6c46d1b2bd16e575a61d47e9871a';

@ProviderFor(taskStatusTransitions)
final taskStatusTransitionsProvider = TaskStatusTransitionsProvider._();

final class TaskStatusTransitionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskStatusTransitionModel>>,
          List<TaskStatusTransitionModel>,
          FutureOr<List<TaskStatusTransitionModel>>
        >
    with
        $FutureModifier<List<TaskStatusTransitionModel>>,
        $FutureProvider<List<TaskStatusTransitionModel>> {
  TaskStatusTransitionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskStatusTransitionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskStatusTransitionsHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskStatusTransitionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskStatusTransitionModel>> create(Ref ref) {
    return taskStatusTransitions(ref);
  }
}

String _$taskStatusTransitionsHash() =>
    r'fc23982c7db5959ded1378677aa7bbd9d3f80b01';

@ProviderFor(taskDepartments)
final taskDepartmentsProvider = TaskDepartmentsProvider._();

final class TaskDepartmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DepartmentModel>>,
          List<DepartmentModel>,
          FutureOr<List<DepartmentModel>>
        >
    with
        $FutureModifier<List<DepartmentModel>>,
        $FutureProvider<List<DepartmentModel>> {
  TaskDepartmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDepartmentsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDepartmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<DepartmentModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DepartmentModel>> create(Ref ref) {
    return taskDepartments(ref);
  }
}

String _$taskDepartmentsHash() => r'7430b2858ebf76a8d454fb8b4887600941938a51';

@ProviderFor(taskClients)
final taskClientsProvider = TaskClientsProvider._();

final class TaskClientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ClientBriefModel>>,
          List<ClientBriefModel>,
          FutureOr<List<ClientBriefModel>>
        >
    with
        $FutureModifier<List<ClientBriefModel>>,
        $FutureProvider<List<ClientBriefModel>> {
  TaskClientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskClientsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskClientsHash();

  @$internal
  @override
  $FutureProviderElement<List<ClientBriefModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ClientBriefModel>> create(Ref ref) {
    return taskClients(ref);
  }
}

String _$taskClientsHash() => r'9e4bbb55ab54dd94b4a9fe30d9e2c9b62c0b601d';

@ProviderFor(taskProjects)
final taskProjectsProvider = TaskProjectsProvider._();

final class TaskProjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProjectBriefModel>>,
          List<ProjectBriefModel>,
          FutureOr<List<ProjectBriefModel>>
        >
    with
        $FutureModifier<List<ProjectBriefModel>>,
        $FutureProvider<List<ProjectBriefModel>> {
  TaskProjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskProjectsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskProjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProjectBriefModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProjectBriefModel>> create(Ref ref) {
    return taskProjects(ref);
  }
}

String _$taskProjectsHash() => r'f1c735ea1dfdd38420705ca6b98c7a3703d44a28';

@ProviderFor(TaskListController)
final taskListControllerProvider = TaskListControllerProvider._();

final class TaskListControllerProvider
    extends $NotifierProvider<TaskListController, TaskListState> {
  TaskListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskListControllerHash();

  @$internal
  @override
  TaskListController create() => TaskListController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskListState>(value),
    );
  }
}

String _$taskListControllerHash() =>
    r'542c3b1bf825c57e6f29e6a6c7895ec2c70122c9';

abstract class _$TaskListController extends $Notifier<TaskListState> {
  TaskListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TaskListState, TaskListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TaskListState, TaskListState>,
              TaskListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
