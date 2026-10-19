import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/communication/application/announcements_controller.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';

/// Screen displaying the full content of an announcement by ID.
class AnnouncementDetailScreen extends ConsumerWidget {
  const AnnouncementDetailScreen({
    required this.announcementId,
    super.key,
  });

  final String announcementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final asyncDetail = ref.watch(announcementDetailProvider(announcementId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.announcementDetailTitle),
      ),
      body: SafeArea(
        child: asyncDetail.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: LoadingSkeletonList(itemCount: 4),
          ),
          error: (error, _) {
            final failure = error is AppFailure
                ? error
                : AppFailure.unknown(message: error.toString());
            return ErrorState(
              message: failure.message ?? l10n.errorStateDefaultMessage,
              onRetry: () =>
                  ref.invalidate(announcementDetailProvider(announcementId)),
            );
          },
          data: (announcement) {
            if (announcement == null) {
              return Center(
                child: Text(l10n.announcementsEmptyTitle),
              );
            }
            return _AnnouncementDetailContent(announcement: announcement);
          },
        ),
      ),
    );
  }
}

class _AnnouncementDetailContent extends StatelessWidget {
  const _AnnouncementDetailContent({required this.announcement});

  final AnnouncementModel announcement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formattedPublished = DateFormat(
      'MMMM d, y • h:mm a',
    ).format(announcement.createdAt.toLocal());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Badges row: Target Audience & Expiry
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: <Widget>[
                  Chip(
                    visualDensity: VisualDensity.compact,
                    backgroundColor: announcement.isCompanyWide
                        ? colorScheme.primaryContainer
                        : colorScheme.secondaryContainer,
                    label: Text(
                      announcement.isCompanyWide
                          ? l10n.announcementsCompanyWideBadge
                          : (announcement.targetDepartmentName ??
                                l10n.announcementsCompanyWideBadge),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: announcement.isCompanyWide
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  if (announcement.expiresAt != null)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      avatar: Icon(
                        Icons.schedule,
                        size: 14,
                        color: announcement.isExpired
                            ? colorScheme.error
                            : colorScheme.onSurfaceVariant,
                      ),
                      label: Text(
                        announcement.isExpired
                            ? l10n.announcementsExpiredBadge
                            : l10n.announcementsExpiresOn(
                                DateFormat(
                                  'MMM d, y',
                                ).format(announcement.expiresAt!.toLocal()),
                              ),
                        style: TextStyle(
                          color: announcement.isExpired
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                announcement.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Publication Date
              Text(
                l10n.announcementsPublishedOn(formattedPublished),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Creator card
              Card(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: <Widget>[
                      AvatarWithInitials(
                        name: announcement.creator.fullName,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              l10n.announcementDetailPostedByLabel,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              announcement.creator.fullName,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              announcement.creator.employeeCode,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              const Divider(),
              const SizedBox(height: AppSpacing.lg),

              // Body Content
              SelectableText(
                announcement.body,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
