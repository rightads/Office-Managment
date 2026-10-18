import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';

class PlaceholderHomeScreen extends ConsumerWidget {
  const PlaceholderHomeScreen({super.key});

  Future<void> _confirmLogoutAll(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.authLogoutAllConfirmTitle,
      message: l10n.authLogoutAllConfirmMessage,
      confirmLabel: l10n.authLogoutAllButton,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final failure = await ref
        .read(sessionControllerProvider.notifier)
        .logoutAll();
    if (!context.mounted) return;
    if (failure != null) {
      AppSnackbar.showError(
        context,
        failure.message ?? l10n.errorStateDefaultMessage,
      );
    } else {
      AppSnackbar.showSuccess(context, l10n.authLogoutAllSuccess);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final authState = ref.watch(sessionControllerProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (authState is AuthAuthenticated && authState.isBiometricLocked) {
      return AppScaffold(
        title: l10n.appTitle,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.maxContentWidth,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.fingerprint,
                          size: AppSpacing.xxl,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.authBiometricLockedTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.authBiometricLockedSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(
                          label: l10n.authBiometricUnlockButton,
                          icon: Icons.lock_open_outlined,
                          expanded: true,
                          onPressed: () => ref
                              .read(sessionControllerProvider.notifier)
                              .unlockWithBiometrics(
                                localizedReason: l10n.authBiometricReason,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          label: l10n.authLogoutButton,
                          icon: Icons.logout,
                          variant: AppButtonVariant.text,
                          expanded: true,
                          onPressed: () => ref
                              .read(sessionControllerProvider.notifier)
                              .logout(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return AppScaffold(
      title: l10n.appTitle,
      actions: <Widget>[
        AppButton(
          label: l10n.authLogoutButton,
          icon: Icons.logout,
          variant: AppButtonVariant.text,
          onPressed: () =>
              ref.read(sessionControllerProvider.notifier).logout(),
        ),
      ],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.verified_outlined,
                            color: colorScheme.primary,
                            size: AppSpacing.xl,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              l10n.homePlaceholderTitle,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.homePlaceholderSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (authState is AuthAuthenticated) ...<Widget>[
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.authSignedInAs(
                            authState.user.fullName,
                            authState.user.employeeCode,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.md),
                      Chip(
                        label: Text(
                          l10n.environmentLabel(
                            config.environment.value.toUpperCase(),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        l10n.apiEndpointLabel(config.apiBaseUrl),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: <Widget>[
                          AppButton(
                            label: l10n.authLogoutButton,
                            icon: Icons.logout,
                            variant: AppButtonVariant.secondary,
                            onPressed: () => ref
                                .read(sessionControllerProvider.notifier)
                                .logout(),
                          ),
                          AppButton(
                            label: l10n.authLogoutAllButton,
                            icon: Icons.devices_other_outlined,
                            variant: AppButtonVariant.destructive,
                            onPressed: () => _confirmLogoutAll(context, ref),
                          ),
                          if (kDebugMode)
                            AppButton(
                              label: l10n.openDevGalleryButton,
                              icon: Icons.widgets_outlined,
                              variant: AppButtonVariant.tonal,
                              onPressed: () =>
                                  context.push(RoutePaths.devGallery),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
