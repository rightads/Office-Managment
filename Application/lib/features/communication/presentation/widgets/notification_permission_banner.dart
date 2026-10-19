import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/notifications/notification_service.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

/// Banner shown in communication screens to prompt for push notification permission
/// at a sensible moment rather than blindly on app launch.
class NotificationPermissionBanner extends ConsumerStatefulWidget {
  const NotificationPermissionBanner({super.key});

  @override
  ConsumerState<NotificationPermissionBanner> createState() =>
      _NotificationPermissionBannerState();
}

class _NotificationPermissionBannerState
    extends ConsumerState<NotificationPermissionBanner> {
  bool _dismissed = false;
  bool _requesting = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.all(AppSpacing.md),
      color: colorScheme.secondaryContainer.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.notifications_active_outlined,
                  color: colorScheme.secondary,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.notificationsPermissionPromptTitle,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.notificationsPermissionPromptSubtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () => setState(() => _dismissed = true),
                  child: Text(l10n.notificationsDismissButton),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilledButton.tonal(
                  onPressed: _requesting
                      ? null
                      : () async {
                          setState(() => _requesting = true);
                          await ref
                              .read(notificationServiceProvider)
                              .requestPermission();
                          if (mounted) {
                            setState(() {
                              _requesting = false;
                              _dismissed = true;
                            });
                          }
                        },
                  child: _requesting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.notificationsEnableButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
