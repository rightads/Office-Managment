from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class PermissionDefinition:
    code: str
    description: str
    category: str


# Central Permission Catalog (Single Source of Truth)
PERMISSIONS_CATALOG: list[PermissionDefinition] = [
    # User Management
    PermissionDefinition("user.create", "Create new employee accounts", "User Management"),
    PermissionDefinition("user.read", "View employee profiles and directories", "User Management"),
    PermissionDefinition(
        "user.update", "Edit employee details and designations", "User Management"
    ),
    PermissionDefinition(
        "user.delete", "Deactivate or soft-delete employee accounts", "User Management"
    ),
    PermissionDefinition("user.manage_roles", "Assign and modify user roles", "User Management"),
    # Attendance
    PermissionDefinition(
        "attendance.check_in", "Check in and out for daily attendance", "Attendance"
    ),
    PermissionDefinition("attendance.view_own", "View personal attendance history", "Attendance"),
    PermissionDefinition(
        "attendance.view_team", "View team and direct reports attendance logs", "Attendance"
    ),
    PermissionDefinition("attendance.view_all", "View company-wide attendance logs", "Attendance"),
    PermissionDefinition(
        "attendance.correct", "Request and apply manual attendance corrections", "Attendance"
    ),
    PermissionDefinition(
        "attendance.manage_policy", "Create and modify shifts and attendance policies", "Attendance"
    ),
    # Leave Management
    PermissionDefinition("leave.apply", "Submit leave requests", "Leave Management"),
    PermissionDefinition(
        "leave.view_own", "View personal leave balances and applications", "Leave Management"
    ),
    PermissionDefinition(
        "leave.view_all", "View company-wide leave requests and quotas", "Leave Management"
    ),
    PermissionDefinition(
        "leave.approve", "Review and approve/reject leave requests", "Leave Management"
    ),
    PermissionDefinition(
        "leave.manage_types", "Configure annual leave quotas and categories", "Leave Management"
    ),
    # Tasks & Deliverables
    PermissionDefinition("task.create", "Create and delegate tasks", "Task Management"),
    PermissionDefinition("task.view_assigned", "View tasks assigned to oneself", "Task Management"),
    PermissionDefinition(
        "task.view_all", "View all project and department tasks", "Task Management"
    ),
    PermissionDefinition(
        "task.update", "Update task progress, status, and comments", "Task Management"
    ),
    PermissionDefinition("task.delete", "Archive or remove tasks", "Task Management"),
    # Clients & Projects
    PermissionDefinition("client.create", "Register new agency clients", "Client Management"),
    PermissionDefinition(
        "client.view_all", "View client directory and contact details", "Client Management"
    ),
    PermissionDefinition(
        "client.update", "Modify client information and accounts", "Client Management"
    ),
    PermissionDefinition("client.delete", "Deactivate or archive clients", "Client Management"),
    PermissionDefinition(
        "project.create", "Initialize new client campaigns and projects", "Project Management"
    ),
    PermissionDefinition(
        "project.view_all", "View project pipeline and statuses", "Project Management"
    ),
    PermissionDefinition(
        "project.update", "Update project timelines and parameters", "Project Management"
    ),
    PermissionDefinition("project.delete", "Deactivate or archive projects", "Project Management"),
    # Communication & Announcements
    PermissionDefinition(
        "announcement.create", "Publish bulletin board announcements", "Communication"
    ),
    PermissionDefinition("announcement.view", "View active announcements", "Communication"),
    # Work Reports
    PermissionDefinition(
        "work_reports.submit_own", "Create and submit own daily work reports", "Work Reports"
    ),
    PermissionDefinition(
        "work_reports.view_team",
        "View daily work reports of team and department members",
        "Work Reports",
    ),
    PermissionDefinition(
        "work_reports.view_all", "View company-wide daily work reports", "Work Reports"
    ),
    PermissionDefinition(
        "work_reports.review", "Review and comment on employee work reports", "Work Reports"
    ),
    # System & Audit
    PermissionDefinition(
        "system.view_audit_logs", "Inspect security and activity audit logs", "System"
    ),
    PermissionDefinition(
        "system.manage_settings", "Modify global runtime system settings", "System"
    ),
    PermissionDefinition(
        "modules.manage",
        "Create, configure, and reorder application modules and navigation",
        "System",
    ),
]


def get_all_permission_codes() -> list[str]:
    """Returns a list of all defined permission code strings."""
    return [perm.code for perm in PERMISSIONS_CATALOG]
