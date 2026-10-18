abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double minTapTarget = 48;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 40;

  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;

  static const double maxContentWidth = 560;
  static const double maxWideContentWidth = 1200;
}

abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;
}

abstract final class AppElevation {
  static const double none = 0;
  static const double low = 1;
  static const double medium = 3;
  static const double high = 6;
}

abstract final class AppBreakpoints {
  /// Widths `< 600` use bottom navigation (phone layout).
  static const double compactMaxWidth = 600;

  /// Widths `600 .. < 1024` use compact NavigationRail (tablet layout).
  /// Widths `>= 1024` use extended NavigationRail / sidebar (web/desktop).
  static const double mediumMaxWidth = 1024;
}

abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration skeletonPulse = Duration(milliseconds: 900);
}
