import 'dart:convert';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_cache_service.g.dart';

/// Service providing encrypted / persistent local caching of last-good read responses.
class LocalCacheService {
  LocalCacheService(this._prefs);

  final SharedPreferences _prefs;

  /// Saves JSON-encodable [data] under [key].
  Future<void> saveJson(String key, dynamic data) async {
    final encoded = jsonEncode(data);
    await _prefs.setString(key, encoded);
  }

  /// Reads and parses JSON payload under [key]. Returns null if missing or corrupt.
  dynamic readJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw);
    } on FormatException catch (_) {
      return null;
    }
  }

  /// Removes cached entry for [key].
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  /// Checks if [key] exists in cache.
  bool has(String key) => _prefs.containsKey(key);
}

@riverpod
LocalCacheService localCacheService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalCacheService(prefs);
}
