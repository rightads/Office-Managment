# Right Ads - Permission Catalog & Agency Role Matrix

## 1. Permission Catalog

All endpoints require explicit permissions validated via `require_permissions("...")` or `require_any_permissions(...)`.

| Permission Code | Category | Description | Introduced In |
|:----------------|:---------|:------------|:--------------|
| `user.create` | User Management | Create new employee accounts and perform bulk CSV imports | Prompt 03 |
| `user.read` | User Management | View employee profiles and directories | Prompt 03 |
| `user.update` | User Management | Edit employee details, designations, and departmental links | Prompt 03 |
| `user.delete` | User Management | Deactivate or soft-delete employee accounts | Prompt 03 |
| `user.manage_roles` | User Management | Create and modify roles and role-permission associations | Prompt 03 |
| `attendance.check_in` | Attendance | Check in and check out with geofence verification | Prompt 03 |
| `attendance.view_own` | Attendance | View personal daily logs, monthly summaries, and calendar | Prompt 03 |
| `attendance.view_team` | Attendance | View attendance records for assigned department or reports | Prompt 06 |
| `attendance.view_all` | Attendance | Company-wide attendance reports, overview matrix, and exports | Prompt 02 / 03 |
| `attendance.correct` | Attendance | Submit manual attendance correction requests | Prompt 03 |
| `attendance.manage_policy` | Attendance | Configure shifts, geofences, and review correction requests | Prompt 03 |
| `leave.apply` | Leave Management | Submit and cancel personal leave applications | Prompt 03 |
| `leave.view_own` | Leave Management | View personal leave quotas, used balances, and request history | Prompt 03 |
| `leave.view_all` | Leave Management | View all employee leave applications across the agency | Prompt 03 |
| `leave.approve` | Leave Management | Review and approve or reject employee leave requests | Prompt 03 |
| `leave.manage_types` | Leave Management | Configure annual quotas, carry-forward caps, and leave types | Prompt 03 |
| `task.create` | Task Management | Create new tasks, assign employees, and attach deliverables | Prompt 03 |
| `task.view_assigned` | Task Management | View tasks assigned to or created by oneself | Prompt 03 |
| `task.view_all` | Task Management | View all agency projects, tasks, and executive metrics | Prompt 03 |
| `task.update` | Task Management | Transition task statuses, post comments, and upload files | Prompt 03 |
| `task.delete` | Task Management | Soft-delete or archive tasks | Prompt 03 |
| `client.create` | Client Management | Register new agency clients | Prompt 03 |
| `client.view_all` | Client Management | View client directory, contacts, and account details | Prompt 03 |
| `client.update` | Client Management | Modify client accounts and statuses | Prompt 03 |
| `client.delete` | Client Management | Deactivate or archive agency clients | Prompt 03 |
| `project.create` | Project Management | Initialize new client campaigns and projects | Prompt 03 |
| `project.view_all` | Project Management | View project pipeline, milestones, and status | Prompt 03 |
| `project.update` | Project Management | Modify project timelines, deliverables, and budgets | Prompt 03 |
| `project.delete` | Project Management | Deactivate or archive client projects | Prompt 03 |
| `announcement.create` | Communication | Publish company-wide or departmental announcements | Prompt 03 |
| `announcement.view` | Communication | View bulletin board announcements | Prompt 03 |
| `system.view_audit_logs` | System | View security logs, master data changes, and audit trail | Prompt 03 |
| `system.manage_settings` | System | Modify runtime system settings and notification templates | Prompt 03 |

---

## 2. Dynamic Agency Role Matrix (12 Roles)

The initial permissions granted to each role are seeded idempotently from `app/seed_data/roles_permissions.json`. Administrators can dynamically alter role permissions via `/api/v1/roles` endpoints at runtime.

| Role Name | Primary Responsibility | Default Granted Permissions |
|:----------|:-----------------------|:----------------------------|
| **Admin** | Full system operations | All 33 permissions |
| **HR** | Personnel, attendance, leave | `user.create`, `user.read`, `user.update`, `attendance.check_in`, `attendance.view_own`, `attendance.view_team`, `attendance.view_all`, `attendance.correct`, `attendance.manage_policy`, `leave.apply`, `leave.view_own`, `leave.view_all`, `leave.approve`, `leave.manage_types`, `announcement.create`, `announcement.view`, `system.view_audit_logs` |
| **Accounts** | Financials, attendance audit | `user.read`, `attendance.check_in`, `attendance.view_own`, `attendance.view_all`, `leave.apply`, `leave.view_own`, `leave.view_all`, `client.view_all`, `project.view_all`, `announcement.view` |
| **CSD (Client Service)** | Client management, campaigns | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.create`, `task.view_assigned`, `task.view_all`, `task.update`, `client.create`, `client.view_all`, `client.update`, `project.create`, `project.view_all`, `project.update`, `announcement.view` |
| **Sales & Marketing** | Business development, leads | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `client.create`, `client.view_all`, `client.update`, `project.view_all`, `announcement.view` |
| **Tele sales** | Outbound lead qualification | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `announcement.view` |
| **Graphic designer** | Creative visual deliverables | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `project.view_all`, `announcement.view` |
| **Website designer** | UI/UX prototypes and designs | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `project.view_all`, `announcement.view` |
| **Website development** | Frontend/backend websites | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `project.view_all`, `announcement.view` |
| **Web Application** | Web app engineering | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `project.view_all`, `announcement.view` |
| **SEO** | Search engine ranking & audits | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `project.view_all`, `announcement.view` |
| **GMB** | Google Business Profile ops | `attendance.check_in`, `attendance.view_own`, `leave.apply`, `leave.view_own`, `task.view_assigned`, `task.update`, `project.view_all`, `announcement.view` |
