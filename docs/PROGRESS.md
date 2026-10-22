# Right Ads Backend - Progress & Execution Tracker

## Completed Prompts
- [x] **Prompt 01**: Scaffold, config, Docker, database (Completed)
- [x] **Prompt 02**: Core data models & migrations (Completed)
- [x] **Prompt 03**: Seeding, CLI, auth, RBAC (Completed)
- [x] **Prompt 04**: Employee & master data (Completed)
- [x] **Prompt 05**: Attendance engine (Completed)
- [ ] **Prompt 06**: Attendance reports & exports
- [ ] **Prompt 07**: Leave management
- [ ] **Prompt 08**: Tasks, categories, clients, projects
- [ ] **Prompt 09**: Notifications & announcements
- [ ] **Prompt 10**: Security, performance, docs
- [x] **Prompt 11**: Dynamic module engine (Completed)
- [x] **Prompt 12**: Admin: employees and master data (adaptive, works on Web/tablet) (Completed)
- [x] **Prompt 13**: Admin: attendance dashboard and reports (Completed)
- [x] **Prompt 14**: Admin: tasks, leave, announcements (Completed)
- [ ] **Prompt 15**: Role modules verification & dynamic engine tests
- [ ] **Prompt 16**: Super admin console: roles, permissions, dynamic module builder, system settings, audit logs
- [ ] **Prompt 17**: Offline-first engine & background sync
- [ ] **Prompt 18**: Complete test suite & CI verification
- [ ] **Prompt 19**: Release preparation, flavors, obfuscation, signing

---

## Active / Open Issues & Decisions
1. **Target Directory**: Backend repository lives inside `Backend/` directory with root convenience mirrors for configuration.
2. **PostgreSQL Driver**: Using `postgresql+asyncpg://` for non-blocking asynchronous database operations.
3. **Secret Enforcement**: Strict validation in Pydantic `Settings` refusing boot if `JWT_SECRET_KEY` < 32 characters or empty.
4. **Password Hashing**: Argon2id primary password hasher with transparent bcrypt legacy fallback verification (`verify_password`).
5. **Universal UUID Primary Keys**: All entity primary keys use `Uuid(as_uuid=True)` providing native PostgreSQL UUID representation and SQLite compatibility for tests.
6. **No-Hardcoding Data Architecture**: Roles, permissions, departments, attendance statuses (with `counts_as_present`), task statuses (with transitions), priorities (with weights), leave types (with quotas), holidays, office locations, and attendance policies are dynamic database entities. Runtime operational configs are stored in `system_settings`.
7. **Role Seeding**: 12 marketing agency roles (Admin, HR, Accounts, Tele sales, Sales & Marketing, CSD, Graphic designer, Website designer, Website development, Web Application, SEO, GMB) seeded idempotently from `app/seed_data/roles_permissions.json`.
8. **Permission-Based RBAC**: Handled via `require_permission(permission_code)` dependency. Business logic never inspects role names; permissions are resolved dynamically from database associations.
9. **Refresh Token Security**: Refresh tokens are stored in the database hashed via SHA-256. Rotation is enforced upon token refresh, and reuse detection automatically revokes all user sessions if a compromised/revoked token is replayed.
10. **Account Lockout Protection**: Anti-enumeration error responses combined with automatic account lockout after consecutive failed login attempts (`MAX_LOGIN_ATTEMPTS=5`, `LOCKOUT_MINUTES=15`).
11. **Sequential Employee Code Generation**: Dynamic, conflict-free sequence counter driven by `system_settings` or row counts with zero hardcoded department codes or prefixes.
12. **Secure Employee Provisioning & Credentials**: Admin creation generates a cryptographically secure temporary password, marks `must_change_password=True`, and dispatches a welcome email via `EmailService`.
13. **Last Active Administrator Protection**: Both deactivation (`/employees/{id}/deactivate`) and demotion/role change (`/employees/{id}/role`) enforce protection preventing the organization from locking out or removing its last active administrator.
14. **Self-Service Profile Whitelisting**: Employees can modify personal profile fields (`phone_number`, `avatar_url`) whitelisted in `settings.SELF_EDITABLE_PROFILE_FIELDS` without administrative privileges; all other fields are rejected.
15. **Streaming Bulk CSV Onboarding**: Multi-row employee import with streaming parser, case-insensitive foreign key resolution (roles, departments, locations, policies), granular error logs (row, column, invalid value, error detail), and dry-run preflight validation.
16. **Immutable Audit Logging**: Security and business changes are automatically captured in `audit_logs` tracking actor ID, action, entity type, entity ID, previous/new state dictionaries, client IP address, and user agent.
17. **Haversine Geofencing**: Precise great-circle distance computation in meters against office locations defined dynamically in DB (`office_locations`).
18. **Hardware Device Binding & Mock Detection**: Immediate rejection of mock location flags (`is_mock_location`). Account binds to the first physical device used and rejects rogue devices until reset by an administrator (`/attendance/users/{id}/reset-device`).
19. **Server-Time Timezone Evaluation**: All database timestamps strictly stored in timezone-aware UTC. Business day and shift start cutoff evaluations mapped to `settings.APP_TIMEZONE` (handling cross-midnight UTC cases).
20. **Threshold Status Transitions**: Dynamic check-out calculation (Present, Half-day, Absent, Late) using employee's assigned `AttendancePolicy` record.
21. **APScheduler Background Jobs**:
    - `auto_close_unclosed_checkouts`: Auto-closes forgotten checkouts from prior days at shift end and recalculates duration and status.
    - `nightly_attendance_processor`: Idempotently marks Absent, Approved Leave (`ON_LEAVE`), Holidays, or Week-offs for active employees with no check-in record.
22. **Manual Attendance Overrides**: Requires a mandatory explanation, writes changes to `attendance_corrections` table, and commits immutable entry to `audit_logs`.

---

## Permission Catalog

| Permission Code | Category | Description | Introduced In |
|-----------------|----------|-------------|---------------|
| `user.create` | User Management | Create new employee accounts and bulk import | Prompt 03 |
| `user.read` | User Management | View employee profiles and directories | Prompt 03 |
| `user.update` | User Management | Edit employee details, designations, and reset passwords | Prompt 03 |
| `user.delete` | User Management | Deactivate or soft-delete employee accounts | Prompt 03 |
| `user.manage_roles` | User Management | Assign and modify user roles, and reset device bindings | Prompt 03 / 05 |
| `role.create` | Role Management | Create custom authorization roles | Prompt 04 |
| `role.read` | Role Management | List and inspect roles and permissions | Prompt 04 |
| `role.update` | Role Management | Edit custom role descriptions and permissions | Prompt 04 |
| `role.delete` | Role Management | Delete non-system roles | Prompt 04 |
| `department.manage` | Master Data | Create, update, and manage organizational departments | Prompt 04 |
| `location.manage` | Master Data | Manage office locations and geofence coordinates | Prompt 04 |
| `holiday.manage` | Master Data | Manage company holidays and optional calendar days | Prompt 04 |
| `attendance.check_in` | Attendance | Check in and out for daily attendance | Prompt 03 / 05 |
| `attendance.view_own` | Attendance | View personal attendance history and calendar | Prompt 03 / 05 |
| `attendance.view_all` | Attendance | View company-wide attendance logs | Prompt 02 / 03 |
| `attendance.correct` | Attendance | Request and apply manual attendance corrections | Prompt 03 / 05 |
| `attendance.manage_policy` | Attendance | Create and modify shifts and attendance policies | Prompt 03 / 04 |
| `leave.apply` | Leave Management | Submit leave requests | Prompt 03 |
| `leave.view_own` | Leave Management | View personal leave balances and applications | Prompt 03 |
| `leave.view_all` | Leave Management | View company-wide leave requests and quotas | Prompt 03 |
| `leave.approve` | Leave Management | Review and approve/reject leave requests | Prompt 03 |
| `leave.manage_types` | Leave Management | Configure annual leave quotas and categories | Prompt 03 / 04 |
| `task.create` | Task Management | Create and delegate tasks | Prompt 03 |
| `task.view_assigned` | Task Management | View tasks assigned to oneself | Prompt 03 |
| `task.view_all` | Task Management | View all project and department tasks | Prompt 03 |
| `task.update` | Task Management | Update task progress, status, and comments | Prompt 03 |
| `task.delete` | Task Management | Archive or remove tasks | Prompt 03 |
| `task.manage_status` | Task Management | Manage task workflow statuses and transitions | Prompt 04 |
| `client.create` | Client Management | Register new agency clients | Prompt 03 |
| `client.view_all` | Client Management | View client directory and contact details | Prompt 03 |
| `client.update` | Client Management | Modify client information and accounts | Prompt 03 |
| `client.delete` | Client Management | Deactivate or archive clients | Prompt 03 |
| `project.create` | Project Management | Initialize new client campaigns and projects | Prompt 03 |
| `project.view_all` | Project Management | View project pipeline and statuses | Prompt 03 |
| `project.update` | Project Management | Update project timelines and parameters | Prompt 03 |
| `project.delete` | Project Management | Deactivate or archive projects | Prompt 03 |
| `announcement.create` | Communication | Publish bulletin board announcements | Prompt 03 |
| `announcement.view` | Communication | View active announcements | Prompt 03 |
| `system.view_audit_logs` | System | Inspect security and activity audit logs | Prompt 03 / 04 |
| `system.manage_settings` | System | Modify global runtime system settings | Prompt 03 / 04 |
