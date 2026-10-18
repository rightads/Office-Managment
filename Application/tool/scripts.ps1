param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("get", "gen", "format", "analyze", "test", "run-dev", "run-staging", "run-prod", "build-apk-dev", "build-apk-staging", "build-apk-prod", "build-web-prod")]
    [string]$Task
)

$ErrorActionPreference = "Stop"

switch ($Task) {
    "get" {
        flutter pub get
    }
    "gen" {
        flutter gen-l10n
        dart run build_runner build --delete-conflicting-outputs
    }
    "format" {
        dart format .
    }
    "analyze" {
        flutter analyze
    }
    "test" {
        flutter test
    }
    "run-dev" {
        flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json
    }
    "run-staging" {
        flutter run --flavor staging -t lib/main_staging.dart --dart-define-from-file=env/staging.json
    }
    "run-prod" {
        flutter run --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json
    }
    "build-apk-dev" {
        flutter build apk --debug --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json
    }
    "build-apk-staging" {
        flutter build apk --release --flavor staging -t lib/main_staging.dart --dart-define-from-file=env/staging.json
    }
    "build-apk-prod" {
        flutter build apk --release --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json
    }
    "build-web-prod" {
        flutter build web -t lib/main_prod.dart --dart-define-from-file=env/prod.json
    }
}
