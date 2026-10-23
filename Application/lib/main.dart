import 'package:right_ads/bootstrap.dart';
import 'package:right_ads/core/config/app_environment.dart';

/// Default fallback entrypoint for development.
///
/// For specific environment flavors, prefer running:
/// - `lib/main_dev.dart` (Dev flavor)
/// - `lib/main_staging.dart` (Staging flavor)
/// - `lib/main_prod.dart` (Production flavor)
Future<void> main() async {
  await bootstrap(expectedFlavor: AppEnvironment.dev);
}
