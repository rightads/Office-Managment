import 'package:flutter/material.dart';

import 'app_brand_colors.dart';

/// Semantic color shortcuts for UI indicators.
abstract final class AppColors {
  static const Color success = AppBrandColors.successSeed;
  static const Color warning = AppBrandColors.warningSeed;
  static const Color error = Color(0xFFDC2626);
  static const Color info = AppBrandColors.infoSeed;
}
