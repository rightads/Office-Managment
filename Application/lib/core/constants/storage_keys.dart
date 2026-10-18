abstract final class StorageKeys {
  // Secure storage keys (sensitive credentials & device identity only)
  static const String accessToken = 'right_ads.secure.access_token';
  static const String refreshToken = 'right_ads.secure.refresh_token';
  static const String deviceId = 'right_ads.secure.device_id';

  // SharedPreferences keys (strictly non-sensitive UI preferences)
  static const String themeMode = 'right_ads.prefs.theme_mode';
  static const String localeCode = 'right_ads.prefs.locale_code';
  static const String biometricEnabled = 'right_ads.prefs.biometric_enabled';
}
