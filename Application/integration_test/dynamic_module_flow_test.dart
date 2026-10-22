import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/features/dynamic_modules/application/dynamic_module_controller.dart';
import 'package:right_ads/features/dynamic_modules/data/dynamic_module_repository.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_record_form_screen.dart';
import 'test_helper.dart';

class _FakeDynamicModuleRepository implements DynamicModuleRepository {
  DynamicModuleDefinition? definitionToReturn;
  DynamicRecordModel? createdRecord;
  DynamicRecordDetailModel? detailToReturn;
  bool createCalled = false;

  @override
  Future<(DynamicModuleDefinition?, AppFailure?)> getDefinition(
    String code,
  ) async => (definitionToReturn, null);

  @override
  Future<(DynamicRecordModel?, AppFailure?)> createRecord(
    String code, {
    required Map<String, dynamic> data,
    String? statusId,
    String? assignedTo,
    String? clientId,
    DateTime? dueAt,
  }) async {
    createCalled = true;
    createdRecord = DynamicRecordModel(
      id: 'rec-1',
      moduleId: code,
      data: data,
      statusId: statusId,
      createdBy: 'u-1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return (createdRecord, null);
  }

  @override
  Future<(DynamicRecordDetailModel?, AppFailure?)> getRecord(
    String code,
    String id,
  ) async => (detailToReturn, null);

  @override
  Future<(DynamicRecordModel?, AppFailure?)> changeStatus(
    String code,
    String id, {
    required String toStatusId,
    String? note,
  }) async {
    final updated = detailToReturn?.copyWith(statusId: toStatusId);
    detailToReturn = updated;
    return (
      DynamicRecordModel(
        id: id,
        moduleId: code,
        statusId: toStatusId,
        createdBy: 'u-1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      null,
    );
  }

  @override
  Future<(DynamicRecordComment?, AppFailure?)> addComment(
    String code,
    String id,
    String comment,
  ) async {
    final newComment = DynamicRecordComment(
      id: 'c-1',
      recordId: id,
      userId: 'u-1',
      userName: 'Agent',
      comment: comment,
      createdAt: DateTime.now(),
    );
    return (newComment, null);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  IntegrationTestHelper.ensureInitialized();

  const sampleDefinition = DynamicModuleDefinition(
    id: 'mod-1',
    code: 'leads',
    label: 'Leads',
    recordLabelSingular: 'Lead',
    recordLabelPlural: 'Leads',
    fields: [
      DynamicModuleField(
        id: 'f-1',
        key: 'company_name',
        label: 'Company Name',
        type: DynamicFieldType.text,
        isRequired: true,
      ),
      DynamicModuleField(
        id: 'f-2',
        key: 'budget',
        label: 'Estimated Budget',
        type: DynamicFieldType.number,
      ),
    ],
    statuses: [
      DynamicModuleStatus(id: 'st-new', code: 'new', label: 'New Lead'),
      DynamicModuleStatus(
        id: 'st-contacted',
        code: 'contacted',
        label: 'Contacted',
      ),
    ],
    transitions: [
      DynamicModuleTransition(
        id: 'tr-1',
        fromStatusId: 'st-new',
        toStatusId: 'st-contacted',
        toStatusLabel: 'Contacted',
      ),
    ],
  );

  group('Dynamic Module End-to-End Integration Flow', () {
    testWidgets(
      'renders dynamic schema form, validates required fields, and submits record',
      (tester) async {
        final fakeRepo = _FakeDynamicModuleRepository()
          ..definitionToReturn = sampleDefinition;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              dynamicModuleRepositoryProvider.overrideWithValue(fakeRepo),
            ],
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: DynamicRecordFormScreen(definition: sampleDefinition),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 1. Verify schema fields rendered
        expect(find.text('Company Name *'), findsOneWidget);
        expect(find.text('Estimated Budget'), findsOneWidget);

        // 2. Tap save without required field -> should trigger validation
        final button = find.byType(AppButton);
        expect(button, findsOneWidget);
        await tester.tap(button);
        await tester.pumpAndSettle();

        expect(fakeRepo.createCalled, isFalse);

        // 3. Fill required field
        final textFields = find.byType(TextField);
        expect(textFields, findsNWidgets(2));
        await tester.enterText(textFields.first, 'Acme Corp Marketing');
        await tester.enterText(textFields.last, '50000');
        await tester.pumpAndSettle();

        // 4. Save with populated fields
        await tester.tap(button);
        await tester.pumpAndSettle();

        expect(fakeRepo.createCalled, isTrue);
        expect(
          fakeRepo.createdRecord?.data['company_name'],
          'Acme Corp Marketing',
        );
      },
    );

    test(
      'updates status and adds comment on dynamic record controller',
      () async {
        final detailModel = DynamicRecordDetailModel(
          id: 'rec-1',
          moduleId: 'leads',
          data: {'company_name': 'Acme Corp Marketing'},
          statusId: 'st-new',
          createdBy: 'u-1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final fakeRepo = _FakeDynamicModuleRepository()
          ..definitionToReturn = sampleDefinition
          ..detailToReturn = detailModel;

        final container = ProviderContainer(
          overrides: [
            dynamicModuleRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        addTearDown(container.dispose);

        final detailController = container.read(
          dynamicRecordDetailControllerProvider('leads', 'rec-1').notifier,
        );

        // Load detail
        await detailController.load();
        expect(
          container
              .read(dynamicRecordDetailControllerProvider('leads', 'rec-1'))
              .detail
              ?.statusId,
          'st-new',
        );

        // Change status to contacted
        final statusChanged = await detailController.changeStatus(
          'st-contacted',
        );
        expect(statusChanged, isTrue);

        // Add comment
        final commentAdded = await detailController.addComment(
          'Reached out to decision maker via phone',
        );
        expect(commentAdded, isTrue);
      },
    );
  });
}
