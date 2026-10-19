import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';

/// Card widget presenting an announcement item on the bulletin board.
class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    required this.announcement,
    required this.onTap,
    super.key,
  });

  final AnnouncementModel announcement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formattedDate = DateFormat(
      'MMM d, y',
    ).format(announcement.createdAt.toLocal());

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top row: Department tag / Company-wide badge & Date
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: announcement.isCompanyWide
                          ? colorScheme.primaryContainer
                          : colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      announcement.isCompanyWide
                          ? l10n.announcementsCompanyWideBadge
                          : (announcement.targetDepartmentName ??
                                l10n.announcementsCompanyWideBadge),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: announcement.isCompanyWide
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formattedDate,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // Title
              Text(
                announcement.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),

              // Preview Body
              Text(
                announcement.body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Creator info & Expiry
              Row(
                children: <Widget>[
                  AvatarWithInitials(
                    name: announcement.creator.fullName,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      announcement.creator.fullName,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (announcement.expiresAt != null) ...<Widget>[
                    Icon(
                      Icons.schedule_outlined,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.announcementsExpiresOn(
                        DateFormat(
                          'MMM d',
                        ).format(announcement.expiresAt!.toLocal()),
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
