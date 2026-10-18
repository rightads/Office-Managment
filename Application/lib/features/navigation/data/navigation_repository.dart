import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_repository.g.dart';

class NavigationRepository {
  const NavigationRepository({
    required this.dio,
    required this.preferencesStorage,
  });

  final Dio dio;
  final PreferencesStorageService? preferencesStorage;

  /// Fetches `/me/navigation` from the server and caches the response JSON
  /// locally. If a network error occurs and a cached copy exists, returns the
  /// cached copy with `isFromCache = true`.
  Future<(UserNavigationData?, AppFailure?, bool isFromCache)>
  fetchNavigation() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiEndpoints.meNavigation,
      );
      final raw = response.data;
      if (raw == null) {
        return (null, const AppFailure.unknown(), false);
      }

      final payload = raw['data'] is Map<String, dynamic>
          ? raw['data'] as Map<String, dynamic>
          : raw;
      final parsed = UserNavigationData.fromJson(payload);

      try {
        await preferencesStorage?.writeCachedNavigationJson(
          jsonEncode(payload),
        );
      } on Object {
        // Ignore cache write errors in unit test environments
      }

      return (parsed, null, false);
    } on Object catch (error) {
      final failure = ErrorMapper.mapException(error);
      if (failure is NetworkFailure) {
        final cached = readCachedNavigation();
        if (cached != null) {
          return (cached, failure, true);
        }
      }
      return (null, failure, false);
    }
  }

  UserNavigationData? readCachedNavigation() {
    try {
      final rawJson = preferencesStorage?.readCachedNavigationJson();
      if (rawJson == null || rawJson.isEmpty) {
        return null;
      }
      final decoded = jsonDecode(rawJson);
      if (decoded is Map<String, dynamic>) {
        return UserNavigationData.fromJson(decoded);
      }
    } on Object {
      // Ignore malformed cache
    }
    return null;
  }

  Future<void> clearCachedNavigation() async {
    try {
      await preferencesStorage?.clearCachedNavigationJson();
    } on Object {
      // Ignore in test environments without SharedPreferences
    }
  }
}

@Riverpod(keepAlive: true)
NavigationRepository navigationRepository(Ref ref) {
  PreferencesStorageService? prefs;
  try {
    prefs = ref.watch(preferencesStorageServiceProvider);
  } on Object {
    prefs = null;
  }
  return NavigationRepository(
    dio: ref.watch(dioProvider),
    preferencesStorage: prefs,
  );
}
