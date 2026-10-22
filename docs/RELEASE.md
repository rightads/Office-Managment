# Release, Distribution & CI/CD Guide

This document describes the end-to-end release procedures, cryptographic signing requirements, continuous distribution tracks, in-app force-update mechanics, and monitoring setup for the Right Ads mobile application.

---

## 1. Non-Negotiable Security Rules

- **Zero Secrets in Git**: Keystore files (`.jks`, `.keystore`), provisioning profiles (`.mobileprovision`), certificates (`.p12`), API keys, and environment files containing production secrets (`env/prod.json`) MUST NEVER be checked into Git.
- **Flavored Artifacts**: Build separate artifacts for `dev`, `staging`, and `prod`. The backend environment, base URL, Sentry DSN, and application IDs differ strictly per flavor.
- **Client Integrity**: Release builds must enable code shrinking, obfuscation, and R8 optimization.

---

## 2. Versioning Scheme

We follow [Semantic Versioning 2.0](https://semver.org/):
```
version: MAJOR.MINOR.PATCH+BUILD_NUMBER
```
- `MAJOR.MINOR.PATCH` is tracked in `pubspec.yaml` (e.g. `1.0.0`).
- `BUILD_NUMBER` is generated automatically by CI using the pipeline execution sequence (`$GITHUB_RUN_NUMBER`), ensuring every built artifact has a monotonically increasing integer build code.

Example command during CI:
```bash
flutter build appbundle \
  --release \
  --flavor prod \
  -t lib/main_prod.dart \
  --build-name="1.0.0" \
  --build-number="${GITHUB_RUN_NUMBER}" \
  --dart-define-from-file=env/prod.json
```

---

## 3. Android Signing & Keystore Management

### Keystore Generation
Generate a cryptographically secure 2048-bit RSA key for production release:
```bash
keytool -genkey -v \
  -keystore upload-keystore.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias rightads \
  -storetype PKCS12
```

### CI Keystore Injection
1. Base64-encode the keystore file:
   ```bash
   base64 -w 0 upload-keystore.jks > upload-keystore.jks.b64
   ```
2. Save the string in GitHub Actions Secrets as `ANDROID_KEYSTORE_BASE64`.
3. Add the following secrets in GitHub Repository Secrets:
   - `ANDROID_KEYSTORE_BASE64`: Base64 encoded `.jks` file.
   - `ANDROID_KEYSTORE_PASSWORD`: Keystore store password.
   - `ANDROID_KEY_ALIAS`: Key alias name (e.g. `rightads`).
   - `ANDROID_KEY_PASSWORD`: Key password.

4. In the CI pipeline, decode the keystore and write `android/key.properties`:
   ```bash
   echo "$ANDROID_KEYSTORE_BASE64" | base64 -d > android/app/upload-keystore.jks
   cat <<EOF > android/key.properties
   storePassword=$ANDROID_KEYSTORE_PASSWORD
   keyPassword=$ANDROID_KEY_PASSWORD
   keyAlias=$ANDROID_KEY_ALIAS
   storeFile=upload-keystore.jks
   EOF
   ```

---

## 4. iOS Signing & Fastlane Integration

### Signing Artifacts
- **Certificates**: Apple Distribution Certificate (`.p12`).
- **Provisioning Profiles**: App Store Distribution Profile & AdHoc/Development Profiles.
- Store `APPLE_CERTIFICATE_BASE64`, `APPLE_CERTIFICATE_PASSWORD`, and `APPLE_PROVISIONING_PROFILE_BASE64` in GitHub Secrets or manage them via Fastlane `match` with a private Git/GCS repo.

### Fastlane Configuration
Run Fastlane match and build IPA without manual certificate management on local machines:
```bash
cd ios
bundle exec fastlane beta
```

---

## 5. Distribution Tracks

### A. Firebase App Distribution (Dev & Staging)
Used for internal team QA, beta testers, and agency staff dogfooding:
- Triggered on push to `develop` or release candidate branches.
- Uses Firebase CLI or Fastlane `firebase_app_distribution` action:
```bash
firebase appdistribution:distribute \
  Application/build/app/outputs/flutter-apk/app-staging-release.apk \
  --app "$FIREBASE_APP_ID" \
  --groups "agency-testers,stakeholders" \
  --release-notes "Automated CI Build #${GITHUB_RUN_NUMBER}"
```

### B. Google Play Console (Internal Testing Track)
For compliance checks, pre-launch testing, and alpha verification:
1. Build signed Android App Bundle (AAB):
   ```bash
   flutter build appbundle --release --flavor prod -t lib/main_prod.dart
   ```
2. Upload via `r0adkll/upload-google-play` GitHub Action:
   ```yaml
   - name: Upload to Google Play Internal Track
     uses: r0adkll/upload-google-play@v1
     with:
       serviceAccountJsonPlainText: ${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON }}
       packageName: com.rightads.app
       releaseFiles: Application/build/app/outputs/bundle/prodRelease/app-prod-release.aab
       track: internal
       status: completed
   ```

### C. Apple TestFlight
Upload production-ready iOS builds for external stakeholders and client acceptance testing:
```bash
bundle exec fastlane pilot upload \
  --ipa "Application/build/ios/ipa/RightAds.ipa" \
  --api_key_path "fastlane/app_store_connect_key.json"
```

---

## 6. In-App Force Update Mechanics

The client enforces minimum version policies dynamically driven by the server config (`GET /api/v1/app/config`).

1. **Config Response Schema**:
   ```json
   {
     "min_supported_app_version": "1.2.0",
     "force_update": true,
     "app_store_url": "https://apps.apple.com/app/id...",
     "play_store_url": "https://play.google.com/store/apps/details?id=com.rightads.app"
   }
   ```
2. **Version Evaluation**:
   `RuntimeAppConfigController` compares the running client's version against `min_supported_app_version` using semantic comparison.
3. **Redirection Guard**:
   `AppRouter` redirects any active session to `/force-update` if `forceUpdate == true` or `currentVersion < minSupportedAppVersion`.
   The `ForceUpdateScreen` prevents dismissal and provides a direct link to the respective app store.

---

## 7. Crash Reporting & Observability (Sentry)

- Configured per environment in `bootstrap.dart`:
```dart
await SentryFlutter.init(
  (options) {
    options.dsn = appConfig.sentryDsn;
    options.environment = appConfig.environment.name;
    options.tracesSampleRate = appConfig.environment == AppEnvironment.prod ? 0.2 : 1.0;
    options.attachScreenshot = false; // Protect sensitive PII
  },
  appRunner: () => runApp(const ProviderScope(child: RightAdsApp())),
);
```
- Release symbols (Proguard mapping files for Android, dSYM for iOS) must be uploaded to Sentry as part of the CI build process using `@sentry/cli`.
