// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmployeeItem _$EmployeeItemFromJson(Map<String, dynamic> json) =>
    _EmployeeItem(
      id: json['id'] as String,
      employeeCode: json['employee_code'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String?,
      designation: json['designation'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool,
      mustChangePassword: json['must_change_password'] as bool,
      joiningDate: json['joining_date'] as String?,
      departmentId: json['department_id'] as String?,
      departmentName: json['department_name'] as String?,
      roleId: json['role_id'] as String,
      roleName: json['role_name'] as String?,
      attendancePolicyId: json['attendance_policy_id'] as String?,
      attendancePolicyName: json['attendance_policy_name'] as String?,
      managerId: json['manager_id'] as String?,
      managerName: json['manager_name'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$EmployeeItemToJson(_EmployeeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_code': instance.employeeCode,
      'email': instance.email,
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'designation': instance.designation,
      'avatar_url': instance.avatarUrl,
      'is_active': instance.isActive,
      'must_change_password': instance.mustChangePassword,
      'joining_date': instance.joiningDate,
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'role_id': instance.roleId,
      'role_name': instance.roleName,
      'attendance_policy_id': instance.attendancePolicyId,
      'attendance_policy_name': instance.attendancePolicyName,
      'manager_id': instance.managerId,
      'manager_name': instance.managerName,
      'created_at': instance.createdAt,
    };

_EmployeeCreatePayload _$EmployeeCreatePayloadFromJson(
  Map<String, dynamic> json,
) => _EmployeeCreatePayload(
  email: json['email'] as String,
  fullName: json['full_name'] as String,
  roleId: json['role_id'] as String,
  departmentId: json['department_id'] as String?,
  attendancePolicyId: json['attendance_policy_id'] as String?,
  managerId: json['manager_id'] as String?,
  phoneNumber: json['phone_number'] as String?,
  designation: json['designation'] as String?,
  joiningDate: json['joining_date'] as String?,
);

Map<String, dynamic> _$EmployeeCreatePayloadToJson(
  _EmployeeCreatePayload instance,
) => <String, dynamic>{
  'email': instance.email,
  'full_name': instance.fullName,
  'role_id': instance.roleId,
  'department_id': instance.departmentId,
  'attendance_policy_id': instance.attendancePolicyId,
  'manager_id': instance.managerId,
  'phone_number': instance.phoneNumber,
  'designation': instance.designation,
  'joining_date': instance.joiningDate,
};

_EmployeeUpdatePayload _$EmployeeUpdatePayloadFromJson(
  Map<String, dynamic> json,
) => _EmployeeUpdatePayload(
  fullName: json['full_name'] as String?,
  departmentId: json['department_id'] as String?,
  attendancePolicyId: json['attendance_policy_id'] as String?,
  managerId: json['manager_id'] as String?,
  phoneNumber: json['phone_number'] as String?,
  designation: json['designation'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  joiningDate: json['joining_date'] as String?,
);

Map<String, dynamic> _$EmployeeUpdatePayloadToJson(
  _EmployeeUpdatePayload instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'department_id': instance.departmentId,
  'attendance_policy_id': instance.attendancePolicyId,
  'manager_id': instance.managerId,
  'phone_number': instance.phoneNumber,
  'designation': instance.designation,
  'avatar_url': instance.avatarUrl,
  'joining_date': instance.joiningDate,
};

_RoleItem _$RoleItemFromJson(Map<String, dynamic> json) => _RoleItem(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  isSystem: json['is_system'] as bool,
  isActive: json['is_active'] as bool,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$RoleItemToJson(_RoleItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'is_system': instance.isSystem,
  'is_active': instance.isActive,
  'created_at': instance.createdAt,
};

_BulkImportRowError _$BulkImportRowErrorFromJson(Map<String, dynamic> json) =>
    _BulkImportRowError(
      row: (json['row'] as num).toInt(),
      field: json['field'] as String,
      error: json['error'] as String,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$BulkImportRowErrorToJson(_BulkImportRowError instance) =>
    <String, dynamic>{
      'row': instance.row,
      'field': instance.field,
      'error': instance.error,
      'value': instance.value,
    };

_BulkImportReport _$BulkImportReportFromJson(Map<String, dynamic> json) =>
    _BulkImportReport(
      totalRows: (json['total_rows'] as num).toInt(),
      successfulImports: (json['successful_imports'] as num).toInt(),
      failedRows: (json['failed_rows'] as num).toInt(),
      dryRun: json['dry_run'] as bool,
      errors:
          (json['errors'] as List<dynamic>?)
              ?.map(
                (e) => BulkImportRowError.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <BulkImportRowError>[],
    );

Map<String, dynamic> _$BulkImportReportToJson(_BulkImportReport instance) =>
    <String, dynamic>{
      'total_rows': instance.totalRows,
      'successful_imports': instance.successfulImports,
      'failed_rows': instance.failedRows,
      'dry_run': instance.dryRun,
      'errors': instance.errors,
    };

_MasterDataItem _$MasterDataItemFromJson(Map<String, dynamic> json) =>
    _MasterDataItem(
      id: json['id'] as String,
      name: json['name'] as String?,
      label: json['label'] as String?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      color: json['color'] as String?,
      order: (json['order'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      isTerminal: json['is_terminal'] as bool?,
      annualQuota: (json['annual_quota'] as num?)?.toDouble(),
      isPaid: json['is_paid'] as bool?,
      carryForward: json['carry_forward'] as bool?,
      date: json['date'] as String?,
      year: (json['year'] as num?)?.toInt(),
      isOptional: json['is_optional'] as bool?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      radiusMeters: (json['radius_meters'] as num?)?.toDouble(),
      address: json['address'] as String?,
      clientId: json['client_id'] as String?,
      contactPerson: json['contact_person'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      shiftStart: json['shift_start'] as String?,
      shiftEnd: json['shift_end'] as String?,
      graceMinutes: (json['grace_minutes'] as num?)?.toInt(),
      halfDayMinHours: (json['half_day_min_hours'] as num?)?.toDouble(),
      fullDayMinHours: (json['full_day_min_hours'] as num?)?.toDouble(),
      requireGeofence: json['require_geofence'] as bool?,
      requireSelfie: json['require_selfie'] as bool?,
      isDefault: json['is_default'] as bool?,
      isActive: json['is_active'] as bool?,
      fromStatusId: json['from_status_id'] as String?,
      toStatusId: json['to_status_id'] as String?,
      requiredPermission: json['required_permission'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MasterDataItemToJson(_MasterDataItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'code': instance.code,
      'description': instance.description,
      'color': instance.color,
      'order': instance.order,
      'weight': instance.weight,
      'is_terminal': instance.isTerminal,
      'annual_quota': instance.annualQuota,
      'is_paid': instance.isPaid,
      'carry_forward': instance.carryForward,
      'date': instance.date,
      'year': instance.year,
      'is_optional': instance.isOptional,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius_meters': instance.radiusMeters,
      'address': instance.address,
      'client_id': instance.clientId,
      'contact_person': instance.contactPerson,
      'email': instance.email,
      'phone': instance.phone,
      'shift_start': instance.shiftStart,
      'shift_end': instance.shiftEnd,
      'grace_minutes': instance.graceMinutes,
      'half_day_min_hours': instance.halfDayMinHours,
      'full_day_min_hours': instance.fullDayMinHours,
      'require_geofence': instance.requireGeofence,
      'require_selfie': instance.requireSelfie,
      'is_default': instance.isDefault,
      'is_active': instance.isActive,
      'from_status_id': instance.fromStatusId,
      'to_status_id': instance.toStatusId,
      'required_permission': instance.requiredPermission,
      'created_at': instance.createdAt,
    };
