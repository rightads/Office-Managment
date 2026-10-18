import 'package:flutter/material.dart';
import 'package:right_ads/core/theme/app_brand_colors.dart';

class ResolvedDynamicColors {
  const ResolvedDynamicColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
}

/// Safely parses backend-supplied hex color strings (e.g. `#10B981`, `10B981`,
/// `#FF10B981`, `0xFF10B981`) and computes a WCAG contrast-aware foreground
/// text color. Never maps status names or priority names in code.
abstract final class DynamicColorParser {
  /// Luminance threshold above which dark text is used for legibility.
  static const double _luminanceCutoff = 0.42;

  static Color? tryParseHex(String? rawHex) {
    if (rawHex == null) return null;
    var cleaned = rawHex.trim();
    if (cleaned.isEmpty) return null;

    if (cleaned.startsWith('#')) {
      cleaned = cleaned.substring(1);
    } else if (cleaned.toLowerCase().startsWith('0x')) {
      cleaned = cleaned.substring(2);
    }

    if (cleaned.length == 6) {
      cleaned = 'FF$cleaned';
    } else if (cleaned.length != 8) {
      return null;
    }

    final intValue = int.tryParse(cleaned, radix: 16);
    if (intValue == null) return null;

    return Color(intValue);
  }

  /// Computes a contrast-safe foreground color (`highContrastDarkText` for
  /// light backgrounds, `highContrastLightText` for dark backgrounds).
  static Color contrastForegroundFor(Color background) {
    final luminance = background.computeLuminance();
    return luminance > _luminanceCutoff
        ? AppBrandColors.highContrastDarkText
        : AppBrandColors.highContrastLightText;
  }

  /// Resolves background, foreground, and border colors for a dynamic badge or
  /// status chip, falling back to [fallbackScheme] if [rawHex] is null or invalid.
  static ResolvedDynamicColors resolve({
    required String? rawHex,
    required ColorScheme fallbackScheme,
  }) {
    final parsed = tryParseHex(rawHex);
    if (parsed == null) {
      return ResolvedDynamicColors(
        backgroundColor: fallbackScheme.secondaryContainer,
        foregroundColor: fallbackScheme.onSecondaryContainer,
        borderColor: fallbackScheme.outlineVariant,
      );
    }

    final foreground = contrastForegroundFor(parsed);
    return ResolvedDynamicColors(
      backgroundColor: parsed,
      foregroundColor: foreground,
      borderColor: parsed.withValues(alpha: 0.75),
    );
  }
}
