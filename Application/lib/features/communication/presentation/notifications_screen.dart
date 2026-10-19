import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/notifications/notification_payload_parser.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/empty_state.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/communication/application/notifications_controller.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:right_ads/features/communication/presentation/widgets/notification_permission_banner.dart';
import 'package:right_ads/features/communication/presentation/widgets/notification_tile.dart';

/// In-app Notifications Inbox Screen.
///
/// Features paginated scrolling, unread filtering, marking single/all as read,
/// and deep-linking to tasks, leaves, or announcements upon tapping.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        ref.read(notificationsListControllerProvider.notifier).loadInitial(),
      );
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      unawaited(
        ref.read(notificationsListControllerProvider.notifier).loadMore(),
      );
    }
  }

  Future<void> _handleNotificationTap(NotificationItemModel item) async {
    // 1. Mark as read immediately
    if (!item.isRead) {
      await ref
          .read(notificationsListControllerProvider.notifier)
          .markAsRead(item.id);
    }

    if (!mounted) return;

    // 2. Parse target payload and route if applicable
    final link = NotificationPayloadParser.parse(item.data);
    if (link.targetPath != RoutePaths.notifications) {
      await context.push(link.targetPath);
    }
  }

  Future<void> _markAllRead() async {
    final l10n = context.l10n;
    final failure = await ref
        .read(notificationsListControllerProvider.notifier)
        .markAllAsRead();

    if (!mounted) return;
    if (failure != null) {
      AppSnackbar.showError(
        context,
        failure.message ?? l10n.errorStateDefaultMessage,
      );
    } else {
      AppSnackbar.showSuccess(context, l10n.notificationsMarkAllReadSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final state = ref.watch(notificationsListControllerProvider);
    final unreadCount = ref.watch(unreadNotificationCountControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        actions: <Widget>[
          if (state.items.any((n) => !n.isRead))
            IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: l10n.notificationsMarkAllRead,
              onPressed: _markAllRead,
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Sensible Permission Request Banner
            const NotificationPermissionBanner(),

            // Filter Chips Bar (All vs Unread Only)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: <Widget>[
                  FilterChip(
                    label: Text(l10n.notificationsFilterAll),
                    selected: !state.unreadOnly,
                    onSelected: (_) {
                      unawaited(
                        ref
                            .read(notificationsListControllerProvider.notifier)
                            .setUnreadFilter(unreadOnly: false),
                      );
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(l10n.notificationsFilterUnread),
                        if (unreadCount > 0) ...<Widget>[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$unreadCount',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    selected: state.unreadOnly,
                    onSelected: (_) {
                      unawaited(
                        ref
                            .read(notificationsListControllerProvider.notifier)
                            .setUnreadFilter(unreadOnly: true),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Content Body
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref
                    .read(notificationsListControllerProvider.notifier)
                    .loadInitial(),
                child: _buildBody(state, l10n),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(NotificationsListState state, AppLocalizations l10n) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: LoadingSkeletonList(),
      );
    }

    if (state.error != null && state.items.isEmpty) {
      return ErrorState(
        message: state.error!.message ?? l10n.errorStateDefaultMessage,
        onRetry: () => ref
            .read(notificationsListControllerProvider.notifier)
            .loadInitial(),
      );
    }

    if (state.items.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: EmptyState(
            icon: Icons.notifications_none_outlined,
            title: l10n.notificationsEmptyTitle,
            subtitle: l10n.notificationsEmptySubtitle,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.items.length) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final item = state.items[index];
        return NotificationTile(
          notification: item,
          onTap: () => _handleNotificationTap(item),
        );
      },
    );
  }
}
