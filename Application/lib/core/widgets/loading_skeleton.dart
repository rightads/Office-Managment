import 'dart:async';

import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({
    this.width = double.infinity,
    this.height = AppSpacing.md,
    this.borderRadius = AppRadius.sm,
    super.key,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.skeletonPulse,
    );
    unawaited(_controller.repeat(reverse: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final color = Color.lerp(
          colorScheme.surfaceContainerHighest,
          colorScheme.surfaceContainerLow,
          _controller.value,
        );
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        );
      },
    );
  }
}

class LoadingSkeletonList extends StatelessWidget {
  const LoadingSkeletonList({
    this.itemCount = 5,
    this.itemHeight = AppSpacing.xxl,
    super.key,
  });

  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Semantics(
      container: true,
      label: l10n.commonLoading,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: itemCount,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) => LoadingSkeleton(
          height: itemHeight,
          borderRadius: AppRadius.md,
        ),
      ),
    );
  }
}
