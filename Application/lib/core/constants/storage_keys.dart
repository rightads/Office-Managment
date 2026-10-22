abstract final class StorageKeys {
  // Secure storage keys (sensitive credentials & device identity only)
  static const String accessToken = 'right_ads.secure.access_token';
  static const String refreshToken = 'right_ads.secure.refresh_token';
  static const String deviceId = 'right_ads.secure.device_id';

  // SharedPreferences keys (strictly non-sensitive UI preferences & offline navigation/config cache)
  static const String themeMode = 'right_ads.prefs.theme_mode';
  static const String localeCode = 'right_ads.prefs.locale_code';
  static const String biometricEnabled = 'right_ads.prefs.biometric_enabled';
  static const String cachedAppConfigJson =
      'right_ads.prefs.cached_app_config_json';
  static const String cachedNavigationJson =
      'right_ads.prefs.cached_navigation_json';
  static const String cachedTasksJson = 'right_ads.prefs.cached_tasks_json';
  static const String cachedAttendanceMonthJson =
      'right_ads.prefs.cached_attendance_month_json';
  static const String cachedAnnouncementsJson =
      'right_ads.prefs.cached_announcements_json';

  // Offline Sync Queue & Drafts
  static const String offlineSyncQueue = 'right_ads.prefs.offline_sync_queue';
  static const String offlineDrafts = 'right_ads.prefs.offline_drafts';
}
