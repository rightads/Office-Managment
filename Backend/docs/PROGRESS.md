# Right Ads Backend - Progress & Execution Tracker

## Completed Prompts
- [x] **Prompt 01**: Scaffold, config, Docker, database (Completed)
- [x] **Prompt 02**: Core data models & migrations (Completed)
- [x] **Prompt 03**: Seeding, CLI, auth, RBAC (Completed)
- [x] **Prompt 04**: Employee & master data (Completed)
- [x] **Prompt 05**: Attendance engine (Completed)
- [x] **Prompt 06**: Attendance reports & exports (Completed)
- [ ] **Prompt 07**: Leave management
- [ ] **Prompt 08**: Tasks, categories, clients, projects
- [ ] **Prompt 09**: Notifications & announcements
- [ ] **Prompt 10**: Security, performance, docs
- [ ] **Prompt 11**: Final no-hardcoding audit

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
11. **Attendance Reporting & Caching**: Aggregates attendance metrics via SQL, implements hierarchical scoping (`attendance.view_all`, `attendance.view_team`, `attendance.view_own`), caches closed reporting periods in Redis with graceful offline fallback, and streams formatted Excel (`openpyxl`) and PDF (`reportlab`) exports.

---

## Permission Catalog

| Permission Code | Category | Description | Introduced In |
|-----------------|----------|-------------|---------------|
| `user.create` | User Management | Create new employee accounts | Prompt 03 |
| `user.read` | User Management | View employee profiles and directories | Prompt 03 |
| `user.update` | User Management | Edit employee details and designations | Prompt 03 |
| `user.delete` | User Management | Deactivate or soft-delete employee accounts | Prompt 03 |
| `user.manage_roles` | User Management | Assign and modify user roles | Prompt 03 |
| `attendance.check_in` | Attendance | Check in and out for daily attendance | Prompt 03 |
| `attendance.view_own` | Attendance | View personal attendance history | Prompt 03 |
| `attendance.view_team` | Attendance | View team and direct reports attendance logs | Prompt 06 |
| `attendance.view_all` | Attendance | View company-wide attendance logs | Prompt 02 / 03 |
| `attendance.correct` | Attendance | Request and apply manual attendance corrections | Prompt 03 |
| `attendance.manage_policy` | Attendance | Create and modify shifts and attendance policies | Prompt 03 |
| `leave.apply` | Leave Management | Submit leave requests | Prompt 03 |
| `leave.view_own` | Leave Management | View personal leave balances and applications | Prompt 03 |
| `leave.view_all` | Leave Management | View company-wide leave requests and quotas | Prompt 03 |
| `leave.approve` | Leave Management | Review and approve/reject leave requests | Prompt 03 |
| `leave.manage_types` | Leave Management | Configure annual leave quotas and categories | Prompt 03 |
| `task.create` | Task Management | Create and delegate tasks | Prompt 03 |
| `task.view_assigned` | Task Management | View tasks assigned to oneself | Prompt 03 |
| `task.view_all` | Task Management | View all project and department tasks | Prompt 03 |
| `task.update` | Task Management | Update task progress, status, and comments | Prompt 03 |
| `task.delete` | Task Management | Archive or remove tasks | Prompt 03 |
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
| `system.view_audit_logs` | System | Inspect security and activity audit logs | Prompt 03 |
| `system.manage_settings` | System | Modify global runtime system settings | Prompt 03 |
