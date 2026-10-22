import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_field_renderer.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('Dynamic Field Actions Tests', () {
    testWidgets('renders phone field with Call and WhatsApp action buttons', (
      tester,
    ) async {
      const field = DynamicModuleField(
        id: 'f1',
        key: 'contact_number',
        label: 'Phone Number',
        type: DynamicFieldType.phone,
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const DynamicFieldRenderer(field: field, value: '+919876543210'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('+919876543210'), findsOneWidget);
      expect(find.byIcon(Icons.call_outlined), findsOneWidget);
      expect(find.byIcon(Icons.chat_outlined), findsOneWidget);
    });

    testWidgets(
      'renders follow-up date field with Overdue badge when date in past',
      (tester) async {
        const field = DynamicModuleField(
          id: 'f2',
          key: 'next_follow_up',
          label: 'Next Follow-up',
          type: DynamicFieldType.date,
        );

        await tester.pumpWidget(
          buildTestableWidget(
            const DynamicFieldRenderer(field: field, value: '2020-01-01'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('2020-01-01'), findsOneWidget);
        expect(find.text('Overdue'), findsOneWidget);
      },
    );

    testWidgets('renders currency formatted properly', (tester) async {
      const field = DynamicModuleField(
        id: 'f3',
        key: 'amount',
        label: 'Invoice Amount',
        type: DynamicFieldType.currency,
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const DynamicFieldRenderer(field: field, value: '15000'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('₹15000.00'), findsOneWidget);
    });

    testWidgets('renders geo-point with location icon', (tester) async {
      const field = DynamicModuleField(
        id: 'f4',
        key: 'client_location',
        label: 'Location',
        type: DynamicFieldType.geoPoint,
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const DynamicFieldRenderer(
            field: field,
            value: {'lat': 28.6139, 'lng': 77.2090},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('28.6139, 77.209'), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    });
  });
}
