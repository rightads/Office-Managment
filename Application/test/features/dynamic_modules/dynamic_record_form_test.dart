import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_record_form_screen.dart';

void main() {
  group('DynamicRecordFormScreen - Schema-driven Form Tests', () {
    const testDefinition = DynamicModuleDefinition(
      id: 'mod_leads',
      code: 'leads',
      label: 'Leads',
      recordLabelSingular: 'Lead',
      recordLabelPlural: 'Leads',
      fields: <DynamicModuleField>[
        DynamicModuleField(
          id: 'f1',
          key: 'title',
          label: 'Lead Title',
          type: DynamicFieldType.text,
          isRequired: true,
          validation: DynamicFieldValidation(minLength: 3),
        ),
        DynamicModuleField(
          id: 'f2',
          key: 'deal_value',
          label: 'Deal Value',
          type: DynamicFieldType.currency,
          isRequired: false,
          validation: DynamicFieldValidation(min: 1000),
        ),
        DynamicModuleField(
          id: 'f3',
          key: 'status',
          label: 'Stage',
          type: DynamicFieldType.singleSelect,
          isRequired: true,
          options: <DynamicSelectOption>[
            DynamicSelectOption(value: 'new', label: 'New'),
            DynamicSelectOption(value: 'in_progress', label: 'In Progress'),
          ],
        ),
      ],
      statuses: <DynamicModuleStatus>[
        DynamicModuleStatus(id: 's1', code: 'new', label: 'New'),
      ],
    );

    Widget buildTestForm() {
      return const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: DynamicRecordFormScreen(
            definition: testDefinition,
          ),
        ),
      );
    }

    testWidgets('Renders all fields defined in the schema', (tester) async {
      await tester.pumpWidget(buildTestForm());
      await tester.pumpAndSettle();

      expect(find.text('Lead Title *'), findsOneWidget);
      expect(find.text('Deal Value'), findsOneWidget);
      expect(find.text('Stage *'), findsOneWidget);
      expect(find.text('Create Record'), findsOneWidget);
    });

    testWidgets('Triggers validation on empty required field upon submission', (tester) async {
      await tester.pumpWidget(buildTestForm());
      await tester.pumpAndSettle();

      // Tap Create Record button without filling required fields
      await tester.tap(find.text('Create Record'));
      await tester.pumpAndSettle();

      expect(find.text('Lead Title is required'), findsOneWidget);
    });
  });
}
