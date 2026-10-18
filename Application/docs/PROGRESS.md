# Right Ads Flutter App — Implementation Progress

## Completed Prompts

| Prompt | Title | Status | Notes |
|---|---|---|---|
| `01_scaffold_architecture.md` | Scaffold, architecture, environments | Completed | Feature-first Clean Architecture (`lib/core/`, `lib/features/`), `dev`/`staging`/`prod` flavors, fail-fast `AppConfig` via `--dart-define-from-file`, ARB l10n (`app_en.arb`), Material 3 theme tokens, `PermissionCodes` catalog, global error handling, unit & widget tests. |
| `02_design_system_l10n.md` | Design system, theming, localization, shared widgets | Completed | Centralized design tokens (`AppBrandColors`, `AppSpacing`, `AppRadius`, `AppElevation`, `AppBreakpoints`, `AppDurations`, `AppTypography`), Material 3 light & dark themes, `DynamicColorParser` with WCAG contrast foreground calculation, English (`en`) & Hindi (`hi`) ARB files + automated widget raw-string scanner test, `AppFormatters` (UTC -> configured display timezone, number, currency), `AppValidators`, 14 shared widgets, `/dev/gallery` debug route, and full unit/widget test suite. |

## Pending Prompts

- `03_api_layer_and_auth.md`
- **[STOP GATE: Backend Addendum A1 required before 04]** `04_navigation_shell_permissions.md`
- `05_profile_and_account.md`
- `06_attendance_employee.md`
- `07_tasks_employee.md`
- `08_leave_and_holidays.md`
- `09_announcements_notifications.md`
- **[STOP GATE: Backend Addendum A2 required before 10]** `10_daily_work_report.md`
- **[STOP GATE: Backend Addendum A3 required before 11]** `11_dynamic_module_renderer.md`
- `12_admin_employees_master_data.md`
- `13_admin_attendance_dashboard.md`
- `14_admin_tasks_leave_announcements.md`
- **[STOP GATE: Backend Addendum A4 required before 15]** `15_role_modules_verification.md`
- `16_super_admin_console.md`
- `17_offline_performance_security.md`
- `18_testing_ci_release.md`
- `19_final_no_hardcoding_audit.md`

---

## Permission Codes Defined (`lib/core/permissions/permission_codes.dart`)

Mirrors the 33 granular permission codes in the backend `PERMISSIONS_CATALOG` plus `*`:
- **User Management**: `user.create`, `user.read`, `user.update`, `user.delete`, `user.manage_roles`
- **Attendance**: `attendance.check_in`, `attendance.view_own`, `attendance.view_team`, `attendance.view_all`, `attendance.correct`, `attendance.manage_policy`
- **Leave Management**: `leave.apply`, `leave.view_own`, `leave.view_all`, `leave.approve`, `leave.manage_types`
- **Tasks & Deliverables**: `task.create`, `task.view_assigned`, `task.view_all`, `task.update`, `task.delete`
- **Clients & Projects**: `client.create`, `client.view_all`, `client.update`, `client.delete`, `project.create`, `project.view_all`, `project.update`, `project.delete`
- **Communication & Announcements**: `announcement.create`, `announcement.view`
- **System & Audit**: `system.view_audit_logs`, `system.manage_settings`

*(No role names are referenced anywhere in the Flutter codebase. `PermissionGate` and `ref.can(...)` evaluate permissions from `userPermissionsControllerProvider`.)*

---

## API Endpoints Consumed

- **Prompt 01–02**: None yet (API layer & authentication are implemented in Prompt 03).

---

## Open Issues / Blockers

- None for Prompt 02.
