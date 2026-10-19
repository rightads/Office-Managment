import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/empty_state.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/communication/application/announcements_controller.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:right_ads/features/communication/presentation/widgets/announcement_card.dart';

/// Screen listing active announcements bulletin board for the employee.
class AnnouncementsScreen extends ConsumerWidget {
  const AnnouncementsScreen({
    this.isRootNavigation = false,
    super.key,
  });

  final bool isRootNavigation;

  void _openDetail(BuildContext context, AnnouncementModel announcement) {
    unawaited(context.push('${RoutePaths.announcements}/${announcement.id}'));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(announcementsListControllerProvider);

    final content = RefreshIndicator(
      onRefresh: () =>
          ref.read(announcementsListControllerProvider.notifier).refresh(),
      child: _buildBody(context, ref, state, l10n),
    );

    if (isRootNavigation) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.announcementsTitle),
      ),
      body: SafeArea(child: content),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AnnouncementsListState state,
    AppLocalizations l10n,
  ) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: LoadingSkeletonList(itemCount: 4),
      );
    }

    if (state.error != null && state.items.isEmpty) {
      return ErrorState(
        message: state.error!.message ?? l10n.errorStateDefaultMessage,
        onRetry: () =>
            ref.read(announcementsListControllerProvider.notifier).refresh(),
      );
    }

    if (state.items.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: EmptyState(
            icon: Icons.campaign_outlined,
            title: l10n.announcementsEmptyTitle,
            subtitle: l10n.announcementsEmptySubtitle,
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return AnnouncementCard(
          announcement: item,
          onTap: () => _openDetail(context, item),
        );
      },
    );
  }
}
