import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/communication/data/communication_repository.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_controller.freezed.dart';
part 'notifications_controller.g.dart';

/// State for the notifications inbox list.
@freezed
abstract class NotificationsListState with _$NotificationsListState {
  const factory NotificationsListState({
    @Default(<NotificationItemModel>[]) List<NotificationItemModel> items,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool unreadOnly,
    AppFailure? error,
  }) = _NotificationsListState;
}

/// Unread notification count badge provider.
@Riverpod(keepAlive: true)
class UnreadNotificationCountController
    extends _$UnreadNotificationCountController {
  @override
  int build() {
    return 0;
  }

  Future<void> loadCount() async {
    final repo = ref.read(communicationRepositoryProvider);
    final (count, failure) = await repo.getUnreadNotificationCount();
    if (failure == null && count != null) {
      state = count;
    }
  }

  void decrement() {
    if (state > 0) {
      state = state - 1;
    }
  }

  void reset() {
    state = 0;
  }

  void setCount(int count) {
    state = count >= 0 ? count : 0;
  }
}

/// Controller managing the notifications inbox list, pagination, and read actions.
@Riverpod(keepAlive: true)
class NotificationsListController extends _$NotificationsListController {
  @override
  NotificationsListState build() {
    return const NotificationsListState(isLoading: true);
  }

  Future<void> loadInitial({bool? unreadOnly}) async {
    final filterUnread = unreadOnly ?? state.unreadOnly;
    state = state.copyWith(
      isLoading: true,
      error: null,
      unreadOnly: filterUnread,
      page: 1,
    );

    final repo = ref.read(communicationRepositoryProvider);
    final (res, failure) = await repo.getNotifications(
      unreadOnly: filterUnread,
    );

    if (failure != null) {
      state = state.copyWith(isLoading: false, error: failure);
      return;
    }

    final items = res?.items ?? <NotificationItemModel>[];
    final totalPages = res?.totalPages ?? 1;

    state = state.copyWith(
      items: items,
      isLoading: false,
      hasMore: totalPages > 1 && items.length < (res?.total ?? 0),
    );

    // Refresh unread count
    await ref
        .read(unreadNotificationCountControllerProvider.notifier)
        .loadCount();
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);
    final nextPage = state.page + 1;
    final repo = ref.read(communicationRepositoryProvider);

    final (res, failure) = await repo.getNotifications(
      page: nextPage,
      unreadOnly: state.unreadOnly,
    );

    if (failure != null) {
      state = state.copyWith(isLoadingMore: false, error: failure);
      return;
    }

    final newItems = res?.items ?? <NotificationItemModel>[];
    final combined = [...state.items, ...newItems];
    final totalPages = res?.totalPages ?? nextPage;

    state = state.copyWith(
      items: combined,
      page: nextPage,
      isLoadingMore: false,
      hasMore: nextPage < totalPages && combined.length < (res?.total ?? 0),
    );
  }

  Future<void> setUnreadFilter({required bool unreadOnly}) async {
    if (state.unreadOnly == unreadOnly) return;
    await loadInitial(unreadOnly: unreadOnly);
  }

  Future<void> markAsRead(String notificationId) async {
    final repo = ref.read(communicationRepositoryProvider);
    final existingIdx = state.items.indexWhere((n) => n.id == notificationId);

    // Optimistically update local item if found and unread
    if (existingIdx != -1 && !state.items[existingIdx].isRead) {
      final updatedList = List<NotificationItemModel>.from(state.items);
      updatedList[existingIdx] = updatedList[existingIdx].copyWith(
        isRead: true,
      );
      state = state.copyWith(items: updatedList);
      ref.read(unreadNotificationCountControllerProvider.notifier).decrement();
    }

    final (_, failure) = await repo.markNotificationAsRead(notificationId);
    if (failure != null) {
      // Refresh count on failure
      unawaited(
        ref
            .read(unreadNotificationCountControllerProvider.notifier)
            .loadCount(),
      );
    }
  }

  Future<AppFailure?> markAllAsRead() async {
    final repo = ref.read(communicationRepositoryProvider);

    // Optimistically mark all current items as read
    final updatedList = state.items
        .map((n) => n.copyWith(isRead: true))
        .toList();
    state = state.copyWith(items: updatedList);
    ref.read(unreadNotificationCountControllerProvider.notifier).reset();

    final (_, failure) = await repo.markAllNotificationsAsRead();
    if (failure != null) {
      // Revert/refresh unread count
      unawaited(
        ref
            .read(unreadNotificationCountControllerProvider.notifier)
            .loadCount(),
      );
      return failure;
    }
    return null;
  }
}
