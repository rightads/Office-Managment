import 'package:right_ads/core/constants/storage_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_storage.g.dart';

/// Wrapper around [SharedPreferences] strictly for non-sensitive UI preferences
/// (theme mode, locale code, biometric toggle). Never store tokens or PII here.
class PreferencesStorageService {
  const PreferencesStorageService(this._prefs);

  final SharedPreferences _prefs;

  String? readThemeMode() => _prefs.getString(StorageKeys.themeMode);

  Future<bool> writeThemeMode(String mode) =>
      _prefs.setString(StorageKeys.themeMode, mode);

  String? readLocaleCode() => _prefs.getString(StorageKeys.localeCode);

  Future<bool> writeLocaleCode(String localeCode) =>
      _prefs.setString(StorageKeys.localeCode, localeCode);

  bool readBiometricEnabled() =>
      _prefs.getBool(StorageKeys.biometricEnabled) ?? false;

  Future<bool> writeBiometricEnabled({required bool enabled}) =>
      _prefs.setBool(StorageKeys.biometricEnabled, enabled);

  String? readCachedAppConfigJson() =>
      _prefs.getString(StorageKeys.cachedAppConfigJson);

  Future<bool> writeCachedAppConfigJson(String rawJson) =>
      _prefs.setString(StorageKeys.cachedAppConfigJson, rawJson);

  String? readCachedNavigationJson() =>
      _prefs.getString(StorageKeys.cachedNavigationJson);

  Future<bool> writeCachedNavigationJson(String rawJson) =>
      _prefs.setString(StorageKeys.cachedNavigationJson, rawJson);

  Future<bool> clearCachedNavigationJson() =>
      _prefs.remove(StorageKeys.cachedNavigationJson);
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope during bootstrap.',
  );
}

@Riverpod(keepAlive: true)
PreferencesStorageService preferencesStorageService(Ref ref) {
  return PreferencesStorageService(ref.watch(sharedPreferencesProvider));
}
