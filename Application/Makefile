# Right Ads Flutter - Developer Makefile

.PHONY: help get gen l10n analyze format test run-dev run-staging run-prod build-apk-dev build-apk-staging build-apk-prod build-web-prod

help:
	@echo "Available targets:"
	@echo "  make get               - Install pub dependencies"
	@echo "  make gen               - Run l10n + build_runner code generation"
	@echo "  make analyze           - Run flutter analyze"
	@echo "  make format            - Format all Dart files"
	@echo "  make test              - Run unit and widget tests"
	@echo "  make run-dev           - Run dev flavor"
	@echo "  make run-staging       - Run staging flavor"
	@echo "  make run-prod          - Run prod flavor"
	@echo "  make build-apk-dev     - Build debug APK (dev flavor)"
	@echo "  make build-apk-staging - Build release APK (staging flavor)"
	@echo "  make build-apk-prod    - Build release APK (prod flavor)"
	@echo "  make build-web-prod    - Build Flutter Web (prod)"

get:
	flutter pub get

l10n:
	flutter gen-l10n

gen: l10n
	dart run build_runner build --delete-conflicting-outputs

format:
	dart format lib test

analyze:
	flutter analyze

test:
	flutter test

run-dev:
	flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json

run-staging:
	flutter run --flavor staging -t lib/main_staging.dart --dart-define-from-file=env/staging.json

run-prod:
	flutter run --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json

build-apk-dev:
	flutter build apk --debug --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json

build-apk-staging:
	flutter build apk --release --flavor staging -t lib/main_staging.dart --dart-define-from-file=env/staging.json

build-apk-prod:
	flutter build apk --release --flavor prod -t lib/main_prod.dart --dart-define-from-file=env/prod.json

build-web-prod:
	flutter build web -t lib/main_prod.dart --dart-define-from-file=env/prod.json
