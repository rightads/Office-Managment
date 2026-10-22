abstract final class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String forceChangePassword = '/force-change-password';
  static const String forceUpdate = '/force-update';
  static const String forbidden = '/forbidden';
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String taskDetail = '/tasks/:id';
  static const String leaves = '/leaves';
  static const String leaveDetail = '/leaves/:id';
  static const String holidays = '/holidays';
  static const String workReports = '/work-reports';
  static const String workReportEdit = '/work-reports/edit/:date';
  static const String workReportDetail = '/work-reports/:id';
  static const String notifications = '/notifications';
  static const String announcements = '/announcements';
  static const String announcementDetail = '/announcements/:id';
  static const String devGallery = '/dev/gallery';

  // Admin Routes (Prompt 12)
  static const String adminEmployees = '/admin/employees';
  static const String adminEmployeeCreate = '/admin/employees/create';
  static const String adminEmployeesBulkImport = '/admin/employees/bulk-import';
  static const String adminEmployeeDetailPattern = '/admin/employees/:id';
  static String adminEmployeeDetail(String id) => '/admin/employees/$id';
  static const String adminEmployeeEditPattern = '/admin/employees/:id/edit';
  static String adminEmployeeEdit(String id) => '/admin/employees/$id/edit';

  static const String adminMasterDataHub = '/admin/master-data';
  static const String adminMasterDataCrud = '/admin/master-data/manage';

  // Admin Attendance & Reports (Prompt 13)
  static const String adminAttendanceDashboard = '/admin/attendance';
  static const String adminAttendanceMatrix = '/admin/attendance/matrix';
  static const String adminEmployeeMonthlyPattern = '/admin/attendance/employee/:id/monthly';
  static String adminEmployeeMonthly(String id) => '/admin/attendance/employee/$id/monthly';
  static const String adminEmployeeYearlyPattern = '/admin/attendance/employee/:id/yearly';
  static String adminEmployeeYearly(String id) => '/admin/attendance/employee/$id/yearly';

  // Admin Operations (Prompt 14)
  static const String adminOperationsHub = '/admin/operations';
  static const String adminTaskReports = '/admin/operations/tasks/reports';
  static const String adminLeaveApprovals = '/admin/operations/leaves/approvals';
  static const String adminAnnouncementPublish = '/admin/operations/announcements/publish';
  static const String adminWorkReportsReview = '/admin/operations/work-reports/review';
}
