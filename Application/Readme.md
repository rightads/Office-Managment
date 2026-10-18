# Right Ads — Employee Management App (Flutter)

Adaptive Flutter application (Android, iOS, and Web) for **Right Ads**, built with feature-first Clean Architecture, Riverpod, GoRouter, Dio, Freezed, and ARB localization.

---

## 1. Prerequisites

- **Flutter SDK**: `>= 3.44.0` (Dart `>= 3.12.0`)
- **Android Studio / SDK**: Android SDK 34+ & Java 17
- **Xcode**: 15+ (for iOS builds on macOS)

---

## 2. Environment Configuration (`--dart-define-from-file`)

All runtime configuration (API base URL, environment name, HTTP timeouts, optional Sentry DSN) is injected at build/run time via `--dart-define-from-file`. **Never commit real `env/*.json` files.**

1. Copy the example environment files to create your local environment configs:
   ```bash
   cp env/dev.example.json env/dev.json
   cp env/staging.example.json env/staging.json
   cp env/prod.example.json env/prod.json
   ```
2. Edit `env/dev.json` (or `staging.json` / `prod.json`) with your environment values:
   ```json
   {
     "ENVIRONMENT": "dev",
     "API_BASE_URL": "http://10.0.2.2:8000/api/v1",
     "CONNECT_TIMEOUT_MS": "15000",
     "RECEIVE_TIMEOUT_MS": "30000",
     "SEND_TIMEOUT_MS": "15000",
     "SENTRY_DSN": ""
   }
   ```
3. If any required key is missing or invalid (or mismatches the entrypoint flavor), the app fails fast on startup and renders `ConfigErrorScreen` listing the invalid keys.

---

## 3. Firebase & Signing Secrets (Never Commit)

When push notifications (FCM) or release signing are enabled in later steps, place the platform config files at these git-ignored paths:

- **Android (`google-services.json`)**:
  - `android/app/src/dev/google-services.json`
  - `android/app/src/staging/google-services.json`
  - `android/app/src/prod/google-services.json`
- **iOS (`GoogleService-Info.plist`)**:
  - `ios/Runner/Firebase/dev/GoogleService-Info.plist`
  - `ios/Runner/Firebase/staging/GoogleService-Info.plist`
  - `ios/Runner/Firebase/prod/GoogleService-Info.plist`
- **Android Release Signing**:
  - Place `key.properties` at `android/key.properties` (git-ignored) and reference your `.jks` keystore outside the repository.

---

## 4. Code Generation, Linting, Testing & Running

You can use either `make` or the PowerShell helper `.\tool\scripts.ps1`:

```powershell
# 1. Install dependencies
flutter pub get

# 2. Generate localizations & Riverpod/Freezed code
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
# Or via PowerShell script:
.\tool\scripts.ps1 -Task gen

# 3. Format & Analyze
dart format .
flutter analyze

# 4. Run Tests
flutter test

# 5. Run the App per Flavor
flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json
flutter run --flavor staging -t lib/main_staging.dart --dart-define-from-file=env/staging.json
flutter run --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json

# 6. Build Debug APK (Dev Flavor)
flutter build apk --debug --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json
```

---

## 5. Project Structure

```text
lib/
├── app.dart                 # Root MaterialApp.router widget
├── bootstrap.dart           # Global error handlers, AppConfig check, ProviderScope
├── main_dev.dart            # Dev flavor entrypoint
├── main_staging.dart        # Staging flavor entrypoint
├── main_prod.dart           # Prod flavor entrypoint
├── core/
│   ├── config/              # AppConfig, AppEnvironment, appConfigProvider
│   ├── constants/           # StorageKeys (secure vs non-sensitive prefs)
│   ├── errors/              # AppFailure hierarchy, AppErrorObserver
│   ├── l10n/                # ARB files (app_en.arb) & context.l10n extension
│   ├── network/             # Connectivity provider
│   ├── permissions/         # PermissionCodes (mirrors backend PERMISSIONS_CATALOG)
│   ├── router/              # GoRouter & RoutePaths
│   ├── storage/             # SecureStorageService & PreferencesStorageService
│   ├── theme/               # AppTheme (Material 3 light/dark) & AppSpacing tokens
│   ├── utils/               # AppLogger
│   └── widgets/             # SplashScreen, PlaceholderHomeScreen, ConfigErrorApp
└── features/                # Feature-first modules (data, domain, application, presentation)
```
