/// Relative API endpoint paths matching `docs/backend/openapi.json`.
///
/// Because `AppConfig.apiBaseUrl` ends with `/api/v1` (e.g.
/// `http://10.0.2.2:8000/api/v1`), these paths are relative to `/api/v1`.
abstract final class ApiEndpoints {
  static const String health = '/health';

  // Authentication
  static const String authLogin = '/auth/login';
  static const String authRefresh = '/auth/refresh';
  static const String authLogout = '/auth/logout';
  static const String authLogoutAll = '/auth/logout-all';
  static const String authChangePassword = '/auth/change-password';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';
  static const String authMe = '/auth/me';

  // App Config, Navigation & Modules (Backend Addendum A1)
  static const String appConfig = '/app/config';
  static const String meNavigation = '/me/navigation';
  static const String meAttendancePolicy = '/me/attendance-policy';
  static const String appModules = '/app-modules';

  // Employee Self-Service & Profile (Prompt 05)
  static const String employeesMe = '/employees/me';

  // Attendance & Attendance Reports (Prompt 06)
  static const String attendanceToday = '/attendance/today';
  static const String attendanceCheckIn = '/attendance/check-in';
  static const String attendanceCheckOut = '/attendance/check-out';
  static const String attendanceMe = '/attendance/me';
  static const String attendanceTodayReport = '/reports/attendance/today';
  static const String attendanceMonthlyOverview =
      '/reports/attendance/monthly-overview';
  static const String attendanceExport = '/reports/attendance/export';
  static String attendanceCorrection(String recordId) =>
      '/attendance/$recordId/correct';

  static String employeeMonthlyAttendanceReport(String employeeId) =>
      '/reports/attendance/employee/$employeeId/monthly';

  static String employeeYearlyAttendanceReport(String employeeId) =>
      '/reports/attendance/employee/$employeeId/yearly';

  // Tasks & Master Workflow (Prompt 07)
  static const String myTasks = '/tasks/my';
  static const String tasks = '/tasks';
  static const String tasksReportsSummary = '/tasks/reports/summary';
  static String taskAssign(String id) => '/tasks/$id/assign';
  static String leaveApprove(String id) => '/leaves/$id/approve';
  static String leaveReject(String id) => '/leaves/$id/reject';
  static const String workReportsMissing = '/work-reports/missing';
  static String workReportReview(String id) => '/work-reports/$id/review';
  static String taskDetail(String id) => '/tasks/$id';
  static String taskStatus(String id) => '/tasks/$id/status';
  static String taskTimeline(String id) => '/tasks/$id/timeline';
  static String taskComments(String id) => '/tasks/$id/comments';
  static String taskAttachments(String id) => '/tasks/$id/attachments';
  static const String taskStatuses = '/task-statuses';
  static const String taskPriorities = '/task-priorities';
  static const String taskStatusTransitions = '/task-status-transitions';
  static const String departments = '/departments';
  static const String clients = '/clients';
  static const String projects = '/projects';

  // Leaves & Holidays (Prompt 08)
  static const String leaveBalances = '/leaves/my-balances';
  static const String leaveTypes = '/leaves/types';
  static const String leaveMyRequests = '/leaves/my-requests';
  static const String leaveApply = '/leaves/apply';
  static const String leavePreview = '/leaves/preview';
  static String leaveDetail(String id) => '/leaves/$id';
  static String leaveCancel(String id) => '/leaves/$id/cancel';
  static String leaveCancelApproved(String id) => '/leaves/$id/cancel-approved';
  static const String holidays = '/holidays';

  // Notifications & Announcements (Prompt 09)
  static const String notificationsDevices = '/notifications/devices';
  static String notificationsDevice(String deviceId) =>
      '/notifications/devices/$deviceId';
  static const String notifications = '/notifications';
  static const String notificationsUnreadCount = '/notifications/unread-count';
  static String notificationRead(String id) => '/notifications/$id/read';
  static const String notificationsReadAll = '/notifications/read-all';

  static const String announcements = '/announcements';
  static String announcementDetail(String id) => '/announcements/$id';

  // Daily Work Reports (Prompt 10 / Backend Addendum A2)
  static const String workReports = '/work-reports';
  static const String workReportsMe = '/work-reports/me';
  static String workReportByDate(String isoDate) =>
      '/work-reports/by-date/$isoDate';
  static String workReportDetail(String id) => '/work-reports/$id';
  static String workReportSubmit(String id) => '/work-reports/$id/submit';

  // Admin: Employees & Master Data (Prompt 12)
  static const String employees = '/employees';
  static String employeeDetail(String id) => '/employees/$id';
  static String employeeDeactivate(String id) => '/employees/$id/deactivate';
  static String employeeActivate(String id) => '/employees/$id/activate';
  static String employeeResetPassword(String id) =>
      '/employees/$id/reset-password';
  static String employeeRole(String id) => '/employees/$id/role';
  static String employeeManager(String id) => '/employees/$id/manager';
  static String employeeAttendancePolicy(String id) =>
      '/employees/$id/attendance-policy';
  static const String employeesBulkImport = '/employees/bulk-import';
  static String userResetDevice(String userId) =>
      '/attendance/users/$userId/reset-device';
  static const String roles = '/roles';
  static String roleDetail(String id) => '/roles/$id';
  static const String officeLocations = '/office-locations';
  static String officeLocationDetail(String id) => '/office-locations/$id';
  static const String attendancePolicies = '/attendance-policies';
  static String attendancePolicyDetail(String id) => '/attendance-policies/$id';
  static String clientDetail(String id) => '/clients/$id';
  static String projectDetail(String id) => '/projects/$id';
  static String departmentDetail(String id) => '/departments/$id';
  static String leaveTypeDetail(String id) => '/leave-types/$id';
  static String holidayDetail(String id) => '/holidays/$id';
  static String taskStatusDetail(String id) => '/task-statuses/$id';
  static String taskPriorityDetail(String id) => '/task-priorities/$id';
  static String taskStatusTransitionDelete(String fromId, String toId) =>
      '/task-status-transitions/$fromId/$toId';

  // Dynamic Module Engine (Prompt 11 / Backend Addendum A3)
  static const String moduleDefinitions = '/modules/definitions';
  static String moduleDefinition(String code) => '/modules/$code';
  static String moduleSummary(String code) => '/modules/$code/summary';
  static String moduleRecords(String code) => '/modules/$code/records';
  static String moduleRecordDetail(String code, String id) =>
      '/modules/$code/records/$id';
  static String moduleRecordStatus(String code, String id) =>
      '/modules/$code/records/$id/status';
  static String moduleRecordComments(String code, String id) =>
      '/modules/$code/records/$id/comments';
  static String moduleRecordAttachments(String code, String id) =>
      '/modules/$code/records/$id/attachments';
  static String moduleExport(String code) => '/modules/$code/export';

  // Super Admin: System & Configurations (Prompt 16)
  static const String permissions = '/permissions';
  static String appModuleDetail(String id) => '/app-modules/$id';
  static const String systemSettings = '/system-settings';
  static String systemSetting(String key) => '/system-settings/$key';
  static const String auditLogs = '/audit-logs';
  static const String notificationTemplates = '/notifications/templates';
  static String notificationTemplate(String code) =>
      '/notifications/templates/$code';
  static String moduleFields(String code) => '/modules/$code/fields';
  static String moduleFieldDetail(String code, String fieldId) =>
      '/modules/$code/fields/$fieldId';

  /// Endpoints that do not require an `Authorization: Bearer` header or
  /// automatic 401 token refresh.
  static const Set<String> publicPaths = <String>{
    health,
    appConfig,
    authLogin,
    authRefresh,
    authForgotPassword,
    authResetPassword,
  };

  static bool isPublicPath(String path) {
    return publicPaths.any(path.endsWith);
  }
}
