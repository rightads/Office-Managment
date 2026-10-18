import 'package:flutter/material.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() {
    try {
      final stored = ref
          .watch(preferencesStorageServiceProvider)
          .readThemeMode();
      return _parseThemeMode(stored);
    } on Object {
      return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    try {
      await ref
          .read(preferencesStorageServiceProvider)
          .writeThemeMode(mode.name);
    } on Object {
      // Non-fatal in test environments where SharedPreferences is not overridden.
    }
  }

  static ThemeMode _parseThemeMode(String? raw) {
    return switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}

@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale? build() {
    try {
      final stored = ref
          .watch(preferencesStorageServiceProvider)
          .readLocaleCode();
      if (stored == null || stored.isEmpty) return null;
      return Locale(stored);
    } on Object {
      return null;
    }
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    try {
      if (locale != null) {
        await ref
            .read(preferencesStorageServiceProvider)
            .writeLocaleCode(locale.languageCode);
      }
    } on Object {
      // Non-fatal in test environments where SharedPreferences is not overridden.
    }
  }
}
