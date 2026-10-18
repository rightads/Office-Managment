import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/app.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/widgets/config_error_app.dart';

void main() {
  group('Bootstrap & Initial Screens', () {
    testWidgets(
      'RightAdsApp shows SplashScreen then navigates to PlaceholderHomeScreen',
      (tester) async {
        const testConfig = AppConfig(
          environment: AppEnvironment.dev,
          apiBaseUrl: 'http://10.0.2.2:8000/api/v1',
          connectTimeout: Duration(seconds: 15),
          receiveTimeout: Duration(seconds: 30),
          sendTimeout: Duration(seconds: 15),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appConfigProvider.overrideWithValue(testConfig),
            ],
            child: const RightAdsApp(),
          ),
        );

        await tester.pump();
        expect(find.text('Initializing workspace...'), findsOneWidget);

        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Right Ads Workspace Ready'), findsOneWidget);
        expect(find.text('Environment: DEV'), findsOneWidget);
        expect(
          find.text('API Base URL: http://10.0.2.2:8000/api/v1'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'ConfigErrorApp displays missing configuration keys when validation fails',
      (tester) async {
        const invalidResult = AppConfigInvalid(
          invalidKeys: <String>[
            AppConfigEnvKeys.environment,
            AppConfigEnvKeys.apiBaseUrl,
          ],
        );

        await tester.pumpWidget(
          const ConfigErrorApp(validationError: invalidResult),
        );
        await tester.pumpAndSettle();

        expect(find.text('Configuration Error'), findsOneWidget);
        expect(find.text(AppConfigEnvKeys.environment), findsOneWidget);
        expect(find.text(AppConfigEnvKeys.apiBaseUrl), findsOneWidget);
      },
    );
  });
}
