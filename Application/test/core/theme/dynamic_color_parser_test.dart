import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/theme/app_brand_colors.dart';
import 'package:right_ads/core/theme/app_theme.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';

void main() {
  group('DynamicColorParser', () {
    test('parses 6-digit and 8-digit hex strings accurately', () {
      expect(
        DynamicColorParser.tryParseHex('#10B981'),
        const Color(0xFF10B981),
      );
      expect(
        DynamicColorParser.tryParseHex('10B981'),
        const Color(0xFF10B981),
      );
      expect(
        DynamicColorParser.tryParseHex('#8010B981'),
        const Color(0x8010B981),
      );
      expect(
        DynamicColorParser.tryParseHex('0xFF1E3A8A'),
        const Color(0xFF1E3A8A),
      );
    });

    test('returns null for null, empty, or malformed hex strings', () {
      expect(DynamicColorParser.tryParseHex(null), isNull);
      expect(DynamicColorParser.tryParseHex(''), isNull);
      expect(DynamicColorParser.tryParseHex('   '), isNull);
      expect(DynamicColorParser.tryParseHex('#12345'), isNull);
      expect(DynamicColorParser.tryParseHex('#ZZZZZZ'), isNull);
    });

    test(
      'selects dark foreground for light backgrounds and light for dark',
      () {
        const lightYellow = Color(0xFFFDE047);
        const darkNavy = Color(0xFF1E3A8A);

        expect(
          DynamicColorParser.contrastForegroundFor(lightYellow),
          AppBrandColors.highContrastDarkText,
        );
        expect(
          DynamicColorParser.contrastForegroundFor(darkNavy),
          AppBrandColors.highContrastLightText,
        );
      },
    );

    test('resolve falls back to ColorScheme when hex is invalid', () {
      final fallbackScheme = AppTheme.light().colorScheme;
      final resolved = DynamicColorParser.resolve(
        rawHex: 'not-a-color',
        fallbackScheme: fallbackScheme,
      );

      expect(resolved.backgroundColor, fallbackScheme.secondaryContainer);
      expect(resolved.foregroundColor, fallbackScheme.onSecondaryContainer);
    });
  });
}
