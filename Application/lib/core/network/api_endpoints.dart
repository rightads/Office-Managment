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

  static String employeeMonthlyAttendanceReport(String employeeId) =>
      '/reports/attendance/employee/$employeeId/monthly';

  static String employeeYearlyAttendanceReport(String employeeId) =>
      '/reports/attendance/employee/$employeeId/yearly';

  // Tasks & Master Workflow (Prompt 07)
  static const String myTasks = '/tasks/my';
  static const String tasks = '/tasks';
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
