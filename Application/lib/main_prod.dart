import 'package:right_ads/bootstrap.dart';
import 'package:right_ads/core/config/app_environment.dart';

Future<void> main() async {
  await bootstrap(expectedFlavor: AppEnvironment.prod);
}
