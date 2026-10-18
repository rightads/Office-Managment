import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/empty_state.dart';

/// Friendly 403 "No Access" screen displayed when a user attempts to open a
/// route or resource for which they lack the required permission.
class ForbiddenScreen extends StatelessWidget {
  const ForbiddenScreen({
    this.onBackHome,
    super.key,
  });

  final VoidCallback? onBackHome;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppScaffold(
      title: l10n.forbiddenTitle,
      body: SafeArea(
        child: EmptyState(
          icon: Icons.lock_person_outlined,
          title: l10n.forbiddenTitle,
          subtitle: l10n.forbiddenMessage,
          actionLabel: l10n.forbiddenBackHomeButton,
          onAction: onBackHome ?? () => context.go(RoutePaths.home),
        ),
      ),
    );
  }
}
