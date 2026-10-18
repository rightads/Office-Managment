import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_repository.g.dart';

/// Repository handling all task queries, status transitions, attachments,
/// comments, and master workflow metadata.
class TaskRepository {
  TaskRepository({required this.dio});

  final Dio dio;

  /// Fetches paginated tasks assigned to the current employee
  /// (`GET /api/v1/tasks/my`).
  Future<(TaskPageResponse?, AppFailure?)> getMyTasks({
    required TaskFilterState filter,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'page_size': pageSize,
        'sort_by': filter.sortBy,
        'sort_desc': filter.sortDesc,
      };

      if (filter.statusId != null && filter.statusId!.isNotEmpty) {
        queryParams['status_id'] = filter.statusId;
      }
      if (filter.priorityId != null && filter.priorityId!.isNotEmpty) {
        queryParams['priority_id'] = filter.priorityId;
      }
      if (filter.departmentId != null && filter.departmentId!.isNotEmpty) {
        queryParams['department_id'] = filter.departmentId;
      }
      if (filter.clientId != null && filter.clientId!.isNotEmpty) {
        queryParams['client_id'] = filter.clientId;
      }
      if (filter.projectId != null && filter.projectId!.isNotEmpty) {
        queryParams['project_id'] = filter.projectId;
      }
      if (filter.isOverdue != null) {
        queryParams['is_overdue'] = filter.isOverdue;
      }
      if (filter.dueFrom != null) {
        queryParams['due_from'] = filter.dueFrom!.toIso8601String();
      }
      if (filter.dueTo != null) {
        queryParams['due_to'] = filter.dueTo!.toIso8601String();
      }
      if (filter.search != null && filter.search!.trim().isNotEmpty) {
        queryParams['search'] = filter.search!.trim();
      }

      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.myTasks,
        queryParameters: queryParams,
      );

      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (TaskPageResponse.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches details for a single task (`GET /api/v1/tasks/{id}`).
  Future<(TaskItemModel?, AppFailure?)> getTaskDetail(String taskId) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.taskDetail(taskId),
      );
      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (TaskItemModel.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  List<dynamic> _extractList(dynamic raw) {
    if (raw is List<dynamic>) return raw;
    if (raw is Map<String, dynamic>) {
      final payload = raw['data'] is Map<String, dynamic>
          ? raw['data'] as Map<String, dynamic>
          : raw;
      if (payload['items'] is List<dynamic>) {
        return payload['items'] as List<dynamic>;
      }
      if (payload['data'] is List<dynamic>) {
        return payload['data'] as List<dynamic>;
      }
    }
    return <dynamic>[];
  }

  /// Fetches workflow statuses sorted by `order` (`GET /api/v1/task-statuses`).
  Future<(List<TaskStatusModel>?, AppFailure?)> getTaskStatuses() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.taskStatuses,
        queryParameters: {'page_size': 100, 'is_active': true},
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items =
            list
                .map((e) => TaskStatusModel.fromJson(e as Map<String, dynamic>))
                .toList()
              ..sort((a, b) => a.order.compareTo(b.order));
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches priority tiers sorted by `weight` (`GET /api/v1/task-priorities`).
  Future<(List<TaskPriorityModel>?, AppFailure?)> getTaskPriorities() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.taskPriorities,
        queryParameters: {'page_size': 100, 'is_active': true},
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items =
            list
                .map(
                  (e) => TaskPriorityModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
              ..sort((a, b) => b.weight.compareTo(a.weight));
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches allowed transitions (`GET /api/v1/task-status-transitions`).
  Future<(List<TaskStatusTransitionModel>?, AppFailure?)>
  getTaskStatusTransitions() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.taskStatusTransitions,
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map(
              (e) =>
                  TaskStatusTransitionModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches departments for filtering (`GET /api/v1/departments`).
  Future<(List<DepartmentModel>?, AppFailure?)> getDepartments() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.departments,
        queryParameters: {'page_size': 100, 'is_active': true},
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches clients for filtering (`GET /api/v1/clients`).
  Future<(List<ClientBriefModel>?, AppFailure?)> getClients() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.clients,
        queryParameters: {'page_size': 100, 'is_active': true},
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map((e) => ClientBriefModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches projects for filtering (`GET /api/v1/projects`).
  Future<(List<ProjectBriefModel>?, AppFailure?)> getProjects() async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.projects,
        queryParameters: {'page_size': 100, 'is_active': true},
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map((e) => ProjectBriefModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Updates a task's status along allowed database transition paths
  /// (`POST /api/v1/tasks/{id}/status`).
  ///
  /// CRITICAL ANTI-HARDCODING SAFEGUARD: Client NEVER supplies `completed_at`.
  /// Server determines terminal state and stamps `completed_at` timestamp.
  Future<(TaskItemModel?, AppFailure?)> updateTaskStatus({
    required String taskId,
    required String toStatusId,
    String? remarks,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.taskStatus(taskId),
        data: <String, dynamic>{
          'to_status_id': toStatusId,
          if (remarks != null && remarks.trim().isNotEmpty)
            'remarks': remarks.trim(),
        },
      );
      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (TaskItemModel.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches chronological task activity timeline (`GET /api/v1/tasks/{id}/timeline`).
  Future<(List<TaskActivityModel>?, AppFailure?)> getTaskTimeline(
    String taskId,
  ) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.taskTimeline(taskId),
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map((e) => TaskActivityModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches comments for a task (`GET /api/v1/tasks/{id}/comments`).
  Future<(List<TaskCommentModel>?, AppFailure?)> getTaskComments(
    String taskId,
  ) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.taskComments(taskId),
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map((e) => TaskCommentModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Adds a comment to a task (`POST /api/v1/tasks/{id}/comments`).
  Future<(TaskCommentModel?, AppFailure?)> addTaskComment({
    required String taskId,
    required String comment,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.taskComments(taskId),
        data: <String, dynamic>{'comment': comment.trim()},
      );
      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (TaskCommentModel.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Fetches attachments for a task (`GET /api/v1/tasks/{id}/attachments`).
  Future<(List<TaskAttachmentModel>?, AppFailure?)> getTaskAttachments(
    String taskId,
  ) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndpoints.taskAttachments(taskId),
      );
      final raw = response.data;
      if (raw != null) {
        final list = _extractList(raw);
        final items = list
            .map((e) => TaskAttachmentModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (items, null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Uploads a file attachment (`POST /api/v1/tasks/{id}/attachments`).
  Future<(TaskAttachmentModel?, AppFailure?)> uploadTaskAttachment({
    required String taskId,
    required List<int> fileBytes,
    required String fileName,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final formData = FormData.fromMap(<String, dynamic>{
        'file': MultipartFile.fromBytes(
          fileBytes,
          filename: fileName,
        ),
      });

      final response = await dio.post<Map<String, dynamic>>(
        ApiEndpoints.taskAttachments(taskId),
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
      final raw = response.data;
      if (raw != null) {
        final payload = raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : raw;
        return (TaskAttachmentModel.fromJson(payload), null);
      }
      return (null, const AppFailure.unknown());
    } on Object catch (error) {
      return (null, ErrorMapper.mapException(error));
    }
  }

  /// Downloads an attachment from its signed URL with progress tracking.
  Future<(bool, AppFailure?)> downloadTaskAttachment({
    required String downloadUrl,
    required String savePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.download(
        downloadUrl,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      return (response.statusCode == 200, null);
    } on Object catch (error) {
      return (false, ErrorMapper.mapException(error));
    }
  }
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return TaskRepository(dio: dio);
}
