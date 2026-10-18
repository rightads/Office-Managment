import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

class AvatarWithInitials extends StatelessWidget {
  const AvatarWithInitials({
    required this.name,
    this.imageUrl,
    this.size = AppSpacing.avatarMd,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final double size;

  static String extractInitials(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }
    final first = parts.first.characters.first.toUpperCase();
    final last = parts.last.characters.first.toUpperCase();
    return '$first$last';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final initials = extractInitials(name);
    final trimmedUrl = imageUrl?.trim() ?? '';
    final hasImage =
        trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://');

    return Semantics(
      image: true,
      label: l10n.avatarSemanticsLabel(name),
      child: SizedBox(
        width: size,
        height: size,
        child: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          backgroundImage: hasImage ? NetworkImage(imageUrl!.trim()) : null,
          onBackgroundImageError: hasImage ? (exception, stackTrace) {} : null,
          child: Text(
            initials,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
