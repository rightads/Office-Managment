import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/network/connectivity_provider.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

class NetworkBanner extends ConsumerWidget {
  const NetworkBanner({
    this.isOfflineOverride,
    super.key,
  });

  final bool? isOfflineOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isOffline;
    if (isOfflineOverride != null) {
      isOffline = isOfflineOverride!;
    } else {
      final connectivityAsync = ref.watch(connectivityChangesProvider);
      isOffline = connectivityAsync.maybeWhen(
        data: (results) =>
            results.isNotEmpty &&
            results.every((r) => r == ConnectivityResult.none),
        orElse: () => false,
      );
    }

    if (!isOffline) {
      return const SizedBox.shrink();
    }

    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.networkOfflineBanner,
      child: Material(
        color: colorScheme.errorContainer,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.wifi_off_outlined,
                  size: AppSpacing.iconMd,
                  color: colorScheme.onErrorContainer,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.networkOfflineBanner,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onErrorContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
