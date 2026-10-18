// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) =>
    _LeaveTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      annualQuota: (json['annual_quota'] as num).toInt(),
      isPaid: json['is_paid'] as bool,
      carryForward: json['carry_forward'] as bool,
      maxCarryForward: (json['max_carry_forward'] as num).toInt(),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$LeaveTypeModelToJson(_LeaveTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'annual_quota': instance.annualQuota,
      'is_paid': instance.isPaid,
      'carry_forward': instance.carryForward,
      'max_carry_forward': instance.maxCarryForward,
      'is_active': instance.isActive,
    };

_LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) =>
    _LeaveBalanceModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      leaveTypeId: json['leave_type_id'] as String,
      leaveTypeName: json['leave_type_name'] as String,
      year: (json['year'] as num).toInt(),
      allocated: (json['allocated'] as num).toDouble(),
      carriedForward: (json['carried_forward'] as num).toDouble(),
      used: (json['used'] as num).toDouble(),
      available: (json['available'] as num).toDouble(),
    );

Map<String, dynamic> _$LeaveBalanceModelToJson(_LeaveBalanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'leave_type_id': instance.leaveTypeId,
      'leave_type_name': instance.leaveTypeName,
      'year': instance.year,
      'allocated': instance.allocated,
      'carried_forward': instance.carriedForward,
      'used': instance.used,
      'available': instance.available,
    };

_LeaveRequestModel _$LeaveRequestModelFromJson(Map<String, dynamic> json) =>
    _LeaveRequestModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      userFullName: json['user_full_name'] as String,
      employeeCode: json['employee_code'] as String,
      leaveTypeId: json['leave_type_id'] as String,
      leaveTypeName: json['leave_type_name'] as String,
      fromDate: DateTime.parse(json['from_date'] as String),
      toDate: DateTime.parse(json['to_date'] as String),
      isHalfDay: json['is_half_day'] as bool,
      totalDays: (json['total_days'] as num).toDouble(),
      reason: json['reason'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      departmentName: json['department_name'] as String?,
      halfDaySession: json['half_day_session'] as String?,
      reviewedBy: json['reviewed_by'] as String?,
      reviewerName: json['reviewer_name'] as String?,
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      reviewNote: json['review_note'] as String?,
    );

Map<String, dynamic> _$LeaveRequestModelToJson(_LeaveRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_full_name': instance.userFullName,
      'employee_code': instance.employeeCode,
      'leave_type_id': instance.leaveTypeId,
      'leave_type_name': instance.leaveTypeName,
      'from_date': instance.fromDate.toIso8601String(),
      'to_date': instance.toDate.toIso8601String(),
      'is_half_day': instance.isHalfDay,
      'total_days': instance.totalDays,
      'reason': instance.reason,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'department_name': instance.departmentName,
      'half_day_session': instance.halfDaySession,
      'reviewed_by': instance.reviewedBy,
      'reviewer_name': instance.reviewerName,
      'reviewed_at': instance.reviewedAt?.toIso8601String(),
      'review_note': instance.reviewNote,
    };

_LeaveRequestListResponse _$LeaveRequestListResponseFromJson(
  Map<String, dynamic> json,
) => _LeaveRequestListResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => LeaveRequestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  pages: (json['pages'] as num).toInt(),
);

Map<String, dynamic> _$LeaveRequestListResponseToJson(
  _LeaveRequestListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'size': instance.size,
  'pages': instance.pages,
};

_LeaveApplyPayload _$LeaveApplyPayloadFromJson(Map<String, dynamic> json) =>
    _LeaveApplyPayload(
      leaveTypeId: json['leave_type_id'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      reason: json['reason'] as String,
      isHalfDay: json['is_half_day'] as bool? ?? false,
      halfDaySession: json['half_day_session'] as String?,
    );

Map<String, dynamic> _$LeaveApplyPayloadToJson(_LeaveApplyPayload instance) =>
    <String, dynamic>{
      'leave_type_id': instance.leaveTypeId,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'reason': instance.reason,
      'is_half_day': instance.isHalfDay,
      'half_day_session': instance.halfDaySession,
    };

_LeavePreviewPayload _$LeavePreviewPayloadFromJson(Map<String, dynamic> json) =>
    _LeavePreviewPayload(
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      leaveTypeId: json['leave_type_id'] as String?,
      isHalfDay: json['is_half_day'] as bool? ?? false,
      halfDaySession: json['half_day_session'] as String?,
    );

Map<String, dynamic> _$LeavePreviewPayloadToJson(
  _LeavePreviewPayload instance,
) => <String, dynamic>{
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
  'leave_type_id': instance.leaveTypeId,
  'is_half_day': instance.isHalfDay,
  'half_day_session': instance.halfDaySession,
};

_LeavePreviewResponse _$LeavePreviewResponseFromJson(
  Map<String, dynamic> json,
) => _LeavePreviewResponse(
  fromDate: DateTime.parse(json['from_date'] as String),
  toDate: DateTime.parse(json['to_date'] as String),
  isHalfDay: json['is_half_day'] as bool,
  workingDays: (json['working_days'] as num).toDouble(),
  isValid: json['is_valid'] as bool,
  halfDaySession: json['half_day_session'] as String?,
  validationError: json['validation_error'] as String?,
  availableBalance: (json['available_balance'] as num?)?.toDouble(),
  hasOverlap: json['has_overlap'] as bool? ?? false,
  overlappingRequestId: json['overlapping_request_id'] as String?,
);

Map<String, dynamic> _$LeavePreviewResponseToJson(
  _LeavePreviewResponse instance,
) => <String, dynamic>{
  'from_date': instance.fromDate.toIso8601String(),
  'to_date': instance.toDate.toIso8601String(),
  'is_half_day': instance.isHalfDay,
  'working_days': instance.workingDays,
  'is_valid': instance.isValid,
  'half_day_session': instance.halfDaySession,
  'validation_error': instance.validationError,
  'available_balance': instance.availableBalance,
  'has_overlap': instance.hasOverlap,
  'overlapping_request_id': instance.overlappingRequestId,
};

_HolidayModel _$HolidayModelFromJson(Map<String, dynamic> json) =>
    _HolidayModel(
      id: json['id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      year: (json['year'] as num).toInt(),
      isOptional: json['is_optional'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$HolidayModelToJson(_HolidayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      'year': instance.year,
      'is_optional': instance.isOptional,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_HolidayPageResponse _$HolidayPageResponseFromJson(Map<String, dynamic> json) =>
    _HolidayPageResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => HolidayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
    );

Map<String, dynamic> _$HolidayPageResponseToJson(
  _HolidayPageResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
};
