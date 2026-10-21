import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_field_renderer.dart';

void main() {
  group('DynamicFieldRenderer - Table-driven test for all 18 field types', () {
    final fieldTypes = <String, dynamic>{
      DynamicFieldType.text: 'Acme Corporation',
      DynamicFieldType.longText: 'Detailed description with multiple paragraphs.',
      DynamicFieldType.number: 42,
      DynamicFieldType.currency: 125000.50,
      DynamicFieldType.date: '2026-10-21',
      DynamicFieldType.datetime: '2026-10-21 14:30:00',
      DynamicFieldType.phone: '+919876543210',
      DynamicFieldType.email: 'contact@acme.com',
      DynamicFieldType.url: 'https://acme.com',
      DynamicFieldType.singleSelect: 'active',
      DynamicFieldType.multiSelect: <String>['sales', 'marketing'],
      DynamicFieldType.boolean: true,
      DynamicFieldType.file: 'https://storage.agency.com/docs/nda.pdf',
      DynamicFieldType.image: 'https://storage.agency.com/images/banner.png',
      DynamicFieldType.user: 'EMP-001 (Bruce Wayne)',
      DynamicFieldType.client: 'Wayne Enterprises',
      DynamicFieldType.project: 'Gotham Metro Billboard',
      DynamicFieldType.geoPoint: <String, double>{'lat': 28.6139, 'lng': 77.2090},
    };

    for (final entry in fieldTypes.entries) {
      testWidgets('Renders field type "${entry.key}" without error', (tester) async {
        final field = DynamicModuleField(
          id: 'f_${entry.key}',
          key: 'field_${entry.key}',
          label: 'Field ${entry.key}',
          type: entry.key,
          options: <DynamicSelectOption>[
            const DynamicSelectOption(value: 'active', label: 'Active', color: '#10B981'),
            const DynamicSelectOption(value: 'sales', label: 'Sales', color: '#3B82F6'),
            const DynamicSelectOption(value: 'marketing', label: 'Marketing', color: '#8B5CF6'),
          ],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DynamicFieldRenderer(
                field: field,
                value: entry.value,
              ),
            ),
          ),
        );

        expect(find.text('Field ${entry.key}'), findsOneWidget);
      });
    }

    testWidgets('Renders unknown field type as fallback text without crashing', (tester) async {
      const field = DynamicModuleField(
        id: 'f_unknown',
        key: 'custom_secret',
        label: 'Secret Field',
        type: 'unsupported_quantum_hash',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DynamicFieldRenderer(
              field: field,
              value: 'encrypted-payload-value',
            ),
          ),
        ),
      );

      expect(find.text('Secret Field'), findsOneWidget);
      expect(find.text('encrypted-payload-value'), findsOneWidget);
    });
  });
}
