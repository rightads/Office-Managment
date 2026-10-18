import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/features/tasks/application/task_list_controller.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_detail_controller.freezed.dart';
part 'task_detail_controller.g.dart';

@freezed
abstract class TaskDetailState with _$TaskDetailState {
  const factory TaskDetailState({
    required AsyncValue<TaskItemModel> task,
    @Default(<TaskActivityModel>[]) List<TaskActivityModel> timeline,
    @Default(<TaskCommentModel>[]) List<TaskCommentModel> comments,
    @Default(<TaskAttachmentModel>[]) List<TaskAttachmentModel> attachments,
    @Default(false) bool isChangingStatus,
    @Default(false) bool isPostingComment,
    @Default(false) bool isUploadingAttachment,
    double? uploadProgress,
    @Default(false) bool isDownloading,
    double? downloadProgress,
    String? errorMessage,
  }) = _TaskDetailState;
}

@riverpod
class TaskDetailController extends _$TaskDetailController {
  @override
  TaskDetailState build(String taskId) {
    unawaited(Future<void>.microtask(load));
    return const TaskDetailState(task: AsyncValue.loading());
  }

  Future<void> load() async {
    final repo = ref.read(taskRepositoryProvider);

    state = state.copyWith(
      task: const AsyncValue.loading(),
      errorMessage: null,
    );

    final (task, failure) = await repo.getTaskDetail(taskId);
    if (failure != null) {
      state = state.copyWith(
        task: AsyncValue.error(failure, StackTrace.current),
        errorMessage: failure.message,
      );
      return;
    }

    if (task == null) {
      state = state.copyWith(
        task: const AsyncValue.error(
          AppFailure.notFound(message: 'Task not found'),
          StackTrace.empty,
        ),
      );
      return;
    }

    state = state.copyWith(
      task: AsyncValue.data(task),
      errorMessage: null,
    );

    // Concurrently load timeline, comments, attachments, and workflow lookups
    await Future.wait(<Future<dynamic>>[
      _loadTimeline(),
      _loadComments(),
      _loadAttachments(),
      ref.read(taskStatusesProvider.future),
      ref.read(taskStatusTransitionsProvider.future),
    ]);
  }

  Future<void> _loadTimeline() async {
    final repo = ref.read(taskRepositoryProvider);
    final (timeline, _) = await repo.getTaskTimeline(taskId);
    if (timeline != null) {
      state = state.copyWith(timeline: timeline);
    }
  }

  Future<void> _loadComments() async {
    final repo = ref.read(taskRepositoryProvider);
    final (comments, _) = await repo.getTaskComments(taskId);
    if (comments != null) {
      state = state.copyWith(comments: comments);
    }
  }

  Future<void> _loadAttachments() async {
    final repo = ref.read(taskRepositoryProvider);
    final (attachments, _) = await repo.getTaskAttachments(taskId);
    if (attachments != null) {
      state = state.copyWith(attachments: attachments);
    }
  }

  /// Derives list of target statuses that the current user is permitted
  /// to transition this task to, based entirely on `task_status_transitions`.
  List<TaskStatusModel> getAllowedTargetStatuses() {
    final task = state.task.value;
    if (task == null) return <TaskStatusModel>[];

    final transitions =
        ref.read(taskStatusTransitionsProvider).value ??
        <TaskStatusTransitionModel>[];
    final allStatuses =
        ref.read(taskStatusesProvider).value ?? <TaskStatusModel>[];

    final permissionService = ref.read(permissionServiceProvider);

    // Filter transitions that originate from current task's status
    final applicableTransitions = transitions.where((tr) {
      if (tr.fromStatusId != task.status.id) return false;
      // If transition requires a specific permission, user must have it
      if (tr.requiredPermission != null &&
          tr.requiredPermission!.trim().isNotEmpty) {
        if (!permissionService.can(tr.requiredPermission!.trim())) {
          return false;
        }
      }
      return true;
    }).toList();

    final allowedToIds = applicableTransitions
        .map((tr) => tr.toStatusId)
        .toSet();

    return allStatuses.where((st) => allowedToIds.contains(st.id)).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Changes task status with optimistic UI update and failure rollback.
  ///
  /// CRITICAL SAFEGUARD: Never sets `completed_at` locally. Only the server stamps
  /// `completed_at` upon transitioning to a terminal status.
  Future<bool> updateStatus({
    required String toStatusId,
    String? remarks,
  }) async {
    final previousTask = state.task.value;
    if (previousTask == null) return false;

    final allStatuses =
        ref.read(taskStatusesProvider).value ?? <TaskStatusModel>[];
    final targetStatus = allStatuses.firstWhere(
      (st) => st.id == toStatusId,
      orElse: () => previousTask.status,
    );

    // Optimistic Update: Apply new status locally immediately
    final optimisticTask = previousTask.copyWith(
      status: targetStatus,
    );
    state = state.copyWith(
      task: AsyncValue.data(optimisticTask),
      isChangingStatus: true,
      errorMessage: null,
    );

    final repo = ref.read(taskRepositoryProvider);
    final (updatedTask, failure) = await repo.updateTaskStatus(
      taskId: taskId,
      toStatusId: toStatusId,
      remarks: remarks,
    );

    if (failure != null) {
      // Rollback on failure!
      state = state.copyWith(
        task: AsyncValue.data(previousTask),
        isChangingStatus: false,
        errorMessage: failure.message,
      );
      return false;
    }

    if (updatedTask != null) {
      // Server returned canonical task (including server's completed_at, is_overdue)
      state = state.copyWith(
        task: AsyncValue.data(updatedTask),
        isChangingStatus: false,
        errorMessage: null,
      );
      // Refresh timeline to reflect new activity audit event
      await _loadTimeline();
      return true;
    }

    state = state.copyWith(isChangingStatus: false);
    return false;
  }

  /// Posts a new comment on this task.
  Future<bool> addComment(String commentText) async {
    if (commentText.trim().isEmpty) return false;

    state = state.copyWith(isPostingComment: true, errorMessage: null);
    final repo = ref.read(taskRepositoryProvider);
    final (newComment, failure) = await repo.addTaskComment(
      taskId: taskId,
      comment: commentText,
    );

    if (failure != null) {
      state = state.copyWith(
        isPostingComment: false,
        errorMessage: failure.message,
      );
      return false;
    }

    if (newComment != null) {
      final updatedComments = <TaskCommentModel>[
        ...state.comments,
        newComment,
      ];
      final currentTask = state.task.value;
      final updatedTask = currentTask?.copyWith(
        commentsCount: currentTask.commentsCount + 1,
      );

      state = state.copyWith(
        comments: updatedComments,
        task: updatedTask != null ? AsyncValue.data(updatedTask) : state.task,
        isPostingComment: false,
        errorMessage: null,
      );
      return true;
    }

    state = state.copyWith(isPostingComment: false);
    return false;
  }

  /// Uploads a file attachment after validating against [RuntimeAppConfig].
  Future<bool> uploadAttachment({
    required List<int> fileBytes,
    required String fileName,
    required String mimeType,
  }) async {
    final config = ref.read(runtimeAppConfigControllerProvider);

    // Validate size against RuntimeAppConfig
    final maxBytes = config.maxUploadMb * 1024 * 1024;
    if (fileBytes.length > maxBytes) {
      state = state.copyWith(
        errorMessage:
            'File size exceeds allowed maximum of ${config.maxUploadMb} MB',
      );
      return false;
    }

    // Validate MIME against RuntimeAppConfig
    final normalizedMime = mimeType.trim().toLowerCase();
    final allowedMimes = config.allowedUploadMimeTypes
        .map((m) => m.trim().toLowerCase())
        .where((m) => m.isNotEmpty)
        .toSet();

    if (allowedMimes.isNotEmpty && !allowedMimes.contains(normalizedMime)) {
      state = state.copyWith(
        errorMessage: 'File type $normalizedMime is not permitted.',
      );
      return false;
    }

    state = state.copyWith(
      isUploadingAttachment: true,
      uploadProgress: 0,
      errorMessage: null,
    );

    final repo = ref.read(taskRepositoryProvider);
    final (newAtt, failure) = await repo.uploadTaskAttachment(
      taskId: taskId,
      fileBytes: fileBytes,
      fileName: fileName,
      onSendProgress: (sent, total) {
        if (total > 0) {
          state = state.copyWith(uploadProgress: sent / total);
        }
      },
    );

    if (failure != null) {
      state = state.copyWith(
        isUploadingAttachment: false,
        uploadProgress: null,
        errorMessage: failure.message,
      );
      return false;
    }

    if (newAtt != null) {
      final updatedAttachments = <TaskAttachmentModel>[
        ...state.attachments,
        newAtt,
      ];
      final currentTask = state.task.value;
      final updatedTask = currentTask?.copyWith(
        attachmentsCount: currentTask.attachmentsCount + 1,
      );

      state = state.copyWith(
        attachments: updatedAttachments,
        task: updatedTask != null ? AsyncValue.data(updatedTask) : state.task,
        isUploadingAttachment: false,
        uploadProgress: null,
        errorMessage: null,
      );
      return true;
    }

    state = state.copyWith(
      isUploadingAttachment: false,
      uploadProgress: null,
    );
    return false;
  }
}
