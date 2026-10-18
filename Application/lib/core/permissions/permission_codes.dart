/// Single source of truth for permission codes, mirroring the backend's
/// `PERMISSIONS_CATALOG` in `app/core/permissions_registry.py`.
///
/// Screens and controllers must check permissions via these constants, never
/// by role names.
abstract final class PermissionCodes {
  static const String wildcard = '*';

  // User Management
  static const String userCreate = 'user.create';
  static const String userRead = 'user.read';
  static const String userUpdate = 'user.update';
  static const String userDelete = 'user.delete';
  static const String userManageRoles = 'user.manage_roles';

  // Attendance
  static const String attendanceCheckIn = 'attendance.check_in';
  static const String attendanceViewOwn = 'attendance.view_own';
  static const String attendanceViewTeam = 'attendance.view_team';
  static const String attendanceViewAll = 'attendance.view_all';
  static const String attendanceCorrect = 'attendance.correct';
  static const String attendanceManagePolicy = 'attendance.manage_policy';

  // Leave Management
  static const String leaveApply = 'leave.apply';
  static const String leaveViewOwn = 'leave.view_own';
  static const String leaveViewAll = 'leave.view_all';
  static const String leaveApprove = 'leave.approve';
  static const String leaveManageTypes = 'leave.manage_types';

  // Tasks & Deliverables
  static const String taskCreate = 'task.create';
  static const String taskViewAssigned = 'task.view_assigned';
  static const String taskViewAll = 'task.view_all';
  static const String taskUpdate = 'task.update';
  static const String taskDelete = 'task.delete';

  // Clients & Projects
  static const String clientCreate = 'client.create';
  static const String clientViewAll = 'client.view_all';
  static const String clientUpdate = 'client.update';
  static const String clientDelete = 'client.delete';
  static const String projectCreate = 'project.create';
  static const String projectViewAll = 'project.view_all';
  static const String projectUpdate = 'project.update';
  static const String projectDelete = 'project.delete';

  // Communication & Announcements
  static const String announcementCreate = 'announcement.create';
  static const String announcementView = 'announcement.view';

  // System & Audit
  static const String systemViewAuditLogs = 'system.view_audit_logs';
  static const String systemManageSettings = 'system.manage_settings';
  static const String modulesManage = 'modules.manage';

  /// Complete catalog of all 34 granular permission codes defined on the server.
  static const List<String> all = <String>[
    userCreate,
    userRead,
    userUpdate,
    userDelete,
    userManageRoles,
    attendanceCheckIn,
    attendanceViewOwn,
    attendanceViewTeam,
    attendanceViewAll,
    attendanceCorrect,
    attendanceManagePolicy,
    leaveApply,
    leaveViewOwn,
    leaveViewAll,
    leaveApprove,
    leaveManageTypes,
    taskCreate,
    taskViewAssigned,
    taskViewAll,
    taskUpdate,
    taskDelete,
    clientCreate,
    clientViewAll,
    clientUpdate,
    clientDelete,
    projectCreate,
    projectViewAll,
    projectUpdate,
    projectDelete,
    announcementCreate,
    announcementView,
    systemViewAuditLogs,
    systemManageSettings,
    modulesManage,
  ];
}
