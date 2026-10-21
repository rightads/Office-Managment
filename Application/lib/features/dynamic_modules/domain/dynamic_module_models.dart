import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_module_models.freezed.dart';
part 'dynamic_module_models.g.dart';

/// Supported field types in the dynamic module schema engine.
abstract final class DynamicFieldType {
  static const String text = 'text';
  static const String longText = 'long_text';
  static const String number = 'number';
  static const String currency = 'currency';
  static const String date = 'date';
  static const String datetime = 'datetime';
  static const String phone = 'phone';
  static const String email = 'email';
  static const String url = 'url';
  static const String singleSelect = 'single_select';
  static const String multiSelect = 'multi_select';
  static const String boolean = 'boolean';
  static const String file = 'file';
  static const String image = 'image';
  static const String user = 'user';
  static const String client = 'client';
  static const String project = 'project';
  static const String geoPoint = 'geo_point';
}

/// A selectable option inside single_select or multi_select fields.
@freezed
abstract class DynamicSelectOption with _$DynamicSelectOption {
  const factory DynamicSelectOption({
    required String value,
    required String label,
    String? color,
  }) = _DynamicSelectOption;

  factory DynamicSelectOption.fromJson(Map<String, dynamic> json) =>
      _$DynamicSelectOptionFromJson(json);
}

/// Validation rules for a field in the module definition.
@freezed
abstract class DynamicFieldValidation with _$DynamicFieldValidation {
  const factory DynamicFieldValidation({
    num? min,
    num? max,
    @JsonKey(name: 'min_length') int? minLength,
    @JsonKey(name: 'max_length') int? maxLength,
    String? regex,
    @JsonKey(name: 'regex_message') String? regexMessage,
  }) = _DynamicFieldValidation;

  factory DynamicFieldValidation.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldValidationFromJson(json);
}

/// A field definition belonging to a dynamic module.
@freezed
abstract class DynamicModuleField with _$DynamicModuleField {
  const factory DynamicModuleField({
    required String id,
    required String key,
    required String label,
    required String type,
    @JsonKey(name: 'is_required') @Default(false) bool isRequired,
    @JsonKey(name: 'is_list_visible') @Default(true) bool isListVisible,
    @JsonKey(name: 'is_filterable') @Default(false) bool isFilterable,
    @JsonKey(name: 'is_searchable') @Default(false) bool isSearchable,
    @Default(<DynamicSelectOption>[]) List<DynamicSelectOption> options,
    DynamicFieldValidation? validation,
    @JsonKey(name: 'default_value') dynamic defaultValue,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    String? section,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _DynamicModuleField;

  factory DynamicModuleField.fromJson(Map<String, dynamic> json) =>
      _$DynamicModuleFieldFromJson(json);
}

/// A lifecycle status belonging to a dynamic module.
@freezed
abstract class DynamicModuleStatus with _$DynamicModuleStatus {
  const factory DynamicModuleStatus({
    required String id,
    required String code,
    required String label,
    @Default('#6B7280') String color,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_terminal') @Default(false) bool isTerminal,
    @JsonKey(name: 'required_permission') String? requiredPermission,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _DynamicModuleStatus;

  factory DynamicModuleStatus.fromJson(Map<String, dynamic> json) =>
      _$DynamicModuleStatusFromJson(json);
}

/// A permitted status transition between lifecycle statuses.
@freezed
abstract class DynamicModuleTransition with _$DynamicModuleTransition {
  const factory DynamicModuleTransition({
    required String id,
    @JsonKey(name: 'from_status_id') required String fromStatusId,
    @JsonKey(name: 'to_status_id') required String toStatusId,
    @JsonKey(name: 'to_status_code') String? toStatusCode,
    @JsonKey(name: 'to_status_label') String? toStatusLabel,
    @JsonKey(name: 'to_status_color') String? toStatusColor,
    @JsonKey(name: 'required_permission') String? requiredPermission,
  }) = _DynamicModuleTransition;

  factory DynamicModuleTransition.fromJson(Map<String, dynamic> json) =>
      _$DynamicModuleTransitionFromJson(json);
}

/// The complete schema definition for a dynamic module.
@freezed
abstract class DynamicModuleDefinition with _$DynamicModuleDefinition {
  const factory DynamicModuleDefinition({
    required String id,
    required String code,
    required String label,
    @Default(1) int version,
    @JsonKey(name: 'record_label_singular')
    @Default('Record')
    String recordLabelSingular,
    @JsonKey(name: 'record_label_plural')
    @Default('Records')
    String recordLabelPlural,
    String? description,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'app_module_id') String? appModuleId,
    @Default(<DynamicModuleField>[]) List<DynamicModuleField> fields,
    @Default(<DynamicModuleStatus>[]) List<DynamicModuleStatus> statuses,
    @Default(<DynamicModuleTransition>[])
    List<DynamicModuleTransition> transitions,
  }) = _DynamicModuleDefinition;

  factory DynamicModuleDefinition.fromJson(Map<String, dynamic> json) =>
      _$DynamicModuleDefinitionFromJson(json);
}

/// A record comment.
@freezed
abstract class DynamicRecordComment with _$DynamicRecordComment {
  const factory DynamicRecordComment({
    required String id,
    @JsonKey(name: 'record_id') required String recordId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') String? userName,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _DynamicRecordComment;

  factory DynamicRecordComment.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordCommentFromJson(json);
}

/// A file attachment on a dynamic record.
@freezed
abstract class DynamicRecordAttachment with _$DynamicRecordAttachment {
  const factory DynamicRecordAttachment({
    required String id,
    @JsonKey(name: 'record_id') required String recordId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'file_url') required String fileUrl,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'file_size') @Default(0) int fileSize,
    @JsonKey(name: 'mime_type') String? mimeType,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _DynamicRecordAttachment;

  factory DynamicRecordAttachment.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordAttachmentFromJson(json);
}

/// An audit activity log entry on a dynamic record's timeline.
@freezed
abstract class DynamicRecordActivity with _$DynamicRecordActivity {
  const factory DynamicRecordActivity({
    required String id,
    @JsonKey(name: 'record_id') required String recordId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'user_name') String? userName,
    required String action,
    Map<String, dynamic>? details,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _DynamicRecordActivity;

  factory DynamicRecordActivity.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordActivityFromJson(json);
}

/// A single dynamic module record item.
@freezed
abstract class DynamicRecordModel with _$DynamicRecordModel {
  const factory DynamicRecordModel({
    required String id,
    @JsonKey(name: 'module_id') required String moduleId,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
    @JsonKey(name: 'status_id') String? statusId,
    DynamicModuleStatus? status,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'creator_name') String? creatorName,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'assignee_name') String? assigneeName,
    @JsonKey(name: 'client_id') String? clientId,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'due_at') DateTime? dueAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'allowed_transitions')
    @Default(<DynamicModuleTransition>[])
    List<DynamicModuleTransition> allowedTransitions,
  }) = _DynamicRecordModel;

  factory DynamicRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordModelFromJson(json);
}

/// Full record detail including comments, attachments, and timeline activities.
@freezed
abstract class DynamicRecordDetailModel with _$DynamicRecordDetailModel {
  const factory DynamicRecordDetailModel({
    required String id,
    @JsonKey(name: 'module_id') required String moduleId,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
    @JsonKey(name: 'status_id') String? statusId,
    DynamicModuleStatus? status,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'creator_name') String? creatorName,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'assignee_name') String? assigneeName,
    @JsonKey(name: 'client_id') String? clientId,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'due_at') DateTime? dueAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'allowed_transitions')
    @Default(<DynamicModuleTransition>[])
    List<DynamicModuleTransition> allowedTransitions,
    @Default(<DynamicRecordComment>[]) List<DynamicRecordComment> comments,
    @Default(<DynamicRecordAttachment>[])
    List<DynamicRecordAttachment> attachments,
    @Default(<DynamicRecordActivity>[]) List<DynamicRecordActivity> activities,
  }) = _DynamicRecordDetailModel;

  factory DynamicRecordDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordDetailModelFromJson(json);
}

/// Paginated page of module records.
@freezed
abstract class DynamicRecordPageResponse with _$DynamicRecordPageResponse {
  const factory DynamicRecordPageResponse({
    @Default(<DynamicRecordModel>[]) List<DynamicRecordModel> items,
    @Default(0) int total,
    @Default(1) int page,
    @JsonKey(name: 'page_size') @Default(20) int pageSize,
    @JsonKey(name: 'total_pages') @Default(1) int totalPages,
  }) = _DynamicRecordPageResponse;

  factory DynamicRecordPageResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordPageResponseFromJson(json);
}

/// Status and numeric aggregates for the module summary strip.
@freezed
abstract class DynamicModuleSummary with _$DynamicModuleSummary {
  const factory DynamicModuleSummary({
    @JsonKey(name: 'total_records') @Default(0) int totalRecords,
    @JsonKey(name: 'counts_by_status')
    @Default(<String, int>{})
    Map<String, int> countsByStatus,
    @JsonKey(name: 'field_totals')
    @Default(<String, double>{})
    Map<String, double> fieldTotals,
  }) = _DynamicModuleSummary;

  factory DynamicModuleSummary.fromJson(Map<String, dynamic> json) =>
      _$DynamicModuleSummaryFromJson(json);
}
