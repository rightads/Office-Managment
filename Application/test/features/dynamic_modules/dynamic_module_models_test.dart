import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';

Map<String, dynamic> _roundtrip(Map<String, dynamic> m) =>
    jsonDecode(jsonEncode(m)) as Map<String, dynamic>;

void main() {
  group('Dynamic Module Models JSON Serialization Tests', () {
    test('DynamicSelectOption serializes and deserializes', () {
      const opt = DynamicSelectOption(value: 'opt1', label: 'Option 1');
      final json = opt.toJson();
      final fromJson = DynamicSelectOption.fromJson(_roundtrip(json));
      expect(fromJson.value, 'opt1');
      expect(fromJson.label, 'Option 1');
    });

    test('DynamicFieldValidation serializes and deserializes', () {
      const val = DynamicFieldValidation(
        min: 1,
        max: 100,
        minLength: 2,
        maxLength: 50,
        regex: r'^[a-z]+$',
        regexMessage: 'Only lowercase allowed',
      );
      final json = val.toJson();
      final fromJson = DynamicFieldValidation.fromJson(_roundtrip(json));
      expect(fromJson.min, 1);
      expect(fromJson.max, 100);
      expect(fromJson.regexMessage, 'Only lowercase allowed');
    });

    test('DynamicModuleField serializes and deserializes', () {
      const field = DynamicModuleField(
        id: 'f-1',
        key: 'budget',
        label: 'Campaign Budget',
        type: DynamicFieldType.currency,
        isRequired: true,
        isFilterable: true,
        isSearchable: true,
        options: [DynamicSelectOption(value: 'inr', label: 'INR')],
        validation: DynamicFieldValidation(min: 100),
      );
      final json = field.toJson();
      final fromJson = DynamicModuleField.fromJson(_roundtrip(json));
      expect(fromJson.id, 'f-1');
      expect(fromJson.key, 'budget');
      expect(fromJson.type, DynamicFieldType.currency);
      expect(fromJson.options.length, 1);
      expect(fromJson.validation?.min, 100);
    });

    test(
      'DynamicModuleStatus and DynamicModuleTransition serialize and deserialize',
      () {
        const status = DynamicModuleStatus(
          id: 's-1',
          code: 'in_progress',
          label: 'In Progress',
          color: '#3B82F6',
        );
        const transition = DynamicModuleTransition(
          id: 't-1',
          fromStatusId: 's-0',
          toStatusId: 's-1',
          toStatusCode: 'in_progress',
          toStatusLabel: 'In Progress',
          requiredPermission: 'module.lead.transition',
        );

        final statusJson = status.toJson();
        final transJson = transition.toJson();

        final fromStatus = DynamicModuleStatus.fromJson(_roundtrip(statusJson));
        final fromTrans = DynamicModuleTransition.fromJson(
          _roundtrip(transJson),
        );

        expect(fromStatus.code, 'in_progress');
        expect(fromTrans.toStatusId, 's-1');
        expect(fromTrans.requiredPermission, 'module.lead.transition');
      },
    );

    test('DynamicModuleDefinition serializes and deserializes', () {
      const def = DynamicModuleDefinition(
        id: 'm-1',
        code: 'leads',
        label: 'Sales Leads',
        recordLabelSingular: 'Lead',
        recordLabelPlural: 'Leads',
        fields: [
          DynamicModuleField(
            id: 'f-1',
            key: 'client_name',
            label: 'Client Name',
            type: DynamicFieldType.text,
          ),
        ],
        statuses: [
          DynamicModuleStatus(
            id: 's-1',
            code: 'open',
            label: 'Open',
            color: '#10B981',
          ),
        ],
      );

      final json = def.toJson();
      final fromJson = DynamicModuleDefinition.fromJson(_roundtrip(json));
      expect(fromJson.code, 'leads');
      expect(fromJson.fields.length, 1);
      expect(fromJson.statuses.length, 1);
    });

    test(
      'DynamicRecordComment, Attachment, and Activity serialize and deserialize',
      () {
        final comment = DynamicRecordComment(
          id: 'c-1',
          recordId: 'rec-1',
          userId: 'u-1',
          userName: 'Admin',
          comment: 'Follow up required',
          createdAt: DateTime(2026, 10, 20),
        );
        final attachment = DynamicRecordAttachment(
          id: 'att-1',
          recordId: 'rec-1',
          userId: 'u-1',
          userName: 'Admin',
          fileUrl: 'http://localhost/att-1',
          fileName: 'proposal.pdf',
          fileSize: 1024,
          mimeType: 'application/pdf',
          createdAt: DateTime(2026, 10, 20),
        );
        final activity = DynamicRecordActivity(
          id: 'act-1',
          recordId: 'rec-1',
          userId: 'u-1',
          userName: 'Admin',
          action: 'status_changed',
          details: {'old': 'draft', 'new': 'open'},
          createdAt: DateTime(2026, 10, 20),
        );

        expect(
          DynamicRecordComment.fromJson(_roundtrip(comment.toJson())).id,
          'c-1',
        );
        expect(
          DynamicRecordAttachment.fromJson(
            _roundtrip(attachment.toJson()),
          ).fileName,
          'proposal.pdf',
        );
        expect(
          DynamicRecordActivity.fromJson(_roundtrip(activity.toJson())).action,
          'status_changed',
        );
      },
    );

    test(
      'DynamicRecordModel, DetailModel, PageResponse, and Summary serialize and deserialize',
      () {
        final record = DynamicRecordModel(
          id: 'rec-1',
          moduleId: 'm-1',
          createdBy: 'u-1',
          creatorName: 'Admin',
          statusId: 's-1',
          data: {'client_name': 'Acme Corp'},
          createdAt: DateTime(2026, 10, 20),
          updatedAt: DateTime(2026, 10, 21),
        );
        final detail = DynamicRecordDetailModel(
          id: 'rec-1',
          moduleId: 'm-1',
          createdBy: 'u-1',
          creatorName: 'Admin',
          data: {'client_name': 'Acme Corp'},
          createdAt: DateTime(2026, 10, 20),
          updatedAt: DateTime(2026, 10, 21),
          allowedTransitions: [],
          comments: [],
          attachments: [],
          activities: [],
        );
        final page = DynamicRecordPageResponse(
          items: [record],
          total: 1,
        );
        const summary = DynamicModuleSummary(
          totalRecords: 1,
          countsByStatus: {'open': 1},
          fieldTotals: {'budget': 50000.0},
        );

        expect(
          DynamicRecordModel.fromJson(_roundtrip(record.toJson())).id,
          'rec-1',
        );
        expect(
          DynamicRecordDetailModel.fromJson(_roundtrip(detail.toJson())).id,
          'rec-1',
        );
        expect(
          DynamicRecordPageResponse.fromJson(_roundtrip(page.toJson())).total,
          1,
        );
        expect(
          DynamicModuleSummary.fromJson(
            _roundtrip(summary.toJson()),
          ).totalRecords,
          1,
        );
      },
    );
  });
}
