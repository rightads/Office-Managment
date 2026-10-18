import 'package:flutter/material.dart';

/// Single source of truth for the application's brand seed color and
/// semantic feedback seed colors.
///
/// Status and priority colors NEVER live here — they come from API data
/// as hex strings and are parsed via `DynamicColorParser`.
abstract final class AppBrandColors {
  static const Color brandSeed = Color(0xFF1E40AF);

  static const Color successSeed = Color(0xFF15803D);
  static const Color warningSeed = Color(0xFFB45309);
  static const Color infoSeed = Color(0xFF0369A1);

  static const Color highContrastLightText = Color(0xFFFFFFFF);
  static const Color highContrastDarkText = Color(0xFF0F172A);
}
