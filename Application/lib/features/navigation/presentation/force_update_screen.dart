import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';

/// Blocking Force-Update gate screen displayed when `/app/config` reports that
/// the client's version is below `min_supported_app_version` or `force_update`
/// is enabled.
class ForceUpdateScreen extends ConsumerStatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  ConsumerState<ForceUpdateScreen> createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends ConsumerState<ForceUpdateScreen> {
  bool _isRefreshing = false;

  Future<void> _recheckConfig() async {
    setState(() => _isRefreshing = true);
    try {
      await ref
          .read(runtimeAppConfigControllerProvider.notifier)
          .refreshFromServer();
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final runtimeConfig = ref.watch(runtimeAppConfigControllerProvider);
    final currentVersion = ref.watch(currentAppVersionProvider);

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
                        Icons.system_security_update_warning_outlined,
                        size: AppSpacing.xxl,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.forceUpdateTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.forceUpdateSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Text(
                          l10n.forceUpdateVersionInfo(
                            currentVersion,
                            runtimeConfig.minSupportedAppVersion,
                          ),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppButton(
                        label: l10n.forceUpdateRefreshButton,
                        icon: Icons.refresh,
                        isLoading: _isRefreshing,
                        expanded: true,
                        onPressed: _recheckConfig,
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
