import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/debug/presentation/role_simulator_screen.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  group('RoleSimulatorScreen Tests', () {
    testWidgets('renders preset choice chips and JSON text field', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const RoleSimulatorScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Tele Sales'), findsOneWidget);
      expect(find.text('Accounts'), findsOneWidget);
      expect(find.text('CSD (Customer Service)'), findsOneWidget);
      expect(find.text('Admin'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('selecting a preset populates the JSON editor', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const RoleSimulatorScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tele Sales'));
      await tester.pumpAndSettle();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, contains('leads'));
      expect(textField.controller?.text, contains('attendance'));
    });
  });
}
