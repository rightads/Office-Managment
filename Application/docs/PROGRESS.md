# Right Ads Flutter App — Implementation Progress

## Completed Prompts

| Prompt | Title | Status | Notes |
|---|---|---|---|
| `01_scaffold_architecture.md` | Scaffold, architecture, environments | Completed | Feature-first Clean Architecture (`lib/core/`, `lib/features/`), `dev`/`staging`/`prod` flavors, fail-fast `AppConfig` via `--dart-define-from-file`, ARB l10n (`app_en.arb`), Material 3 theme tokens, `PermissionCodes` catalog, global error handling, unit & widget tests. |
| `02_design_system_l10n.md` | Design system, theming, localization, shared widgets | Completed | Centralized design tokens (`AppBrandColors`, `AppSpacing`, `AppRadius`, `AppElevation`, `AppBreakpoints`, `AppDurations`, `AppTypography`), Material 3 light & dark themes, `DynamicColorParser` with WCAG contrast foreground calculation, English (`en`) & Hindi (`hi`) ARB files + automated widget raw-string scanner test, `AppFormatters` (UTC -> configured display timezone, number, currency), `AppValidators`, 14 shared widgets, `/dev/gallery` debug route, and full unit/widget test suite. |
| `03_api_layer_and_auth.md` | Networking, token refresh, error mapping, authentication | Completed | Dio client configured from `AppConfig`, `RequestIdInterceptor`, `AuthHeaderInterceptor`, single-flight `TokenRefreshInterceptor` (supporting token rotation and reuse detection), `RedactingLogInterceptor`, `ErrorMapper` (`StandardErrorResponse` + FastAPI 422 `HTTPValidationError` -> `AppFailure`), `DeviceIdentityService`, optional `BiometricService`, full Auth feature (`LoginScreen`, `ForgotPasswordScreen`, `ResetPasswordScreen`, `ForceChangePasswordScreen`, `SessionController`), GoRouter auth redirect state machine, OpenAPI & permission contract verification tests. |
| `backend_addendum/A1_navigation_and_app_config.md` | Backend A1: Navigation, modules registry, public app config | Completed | Added `app_modules` table + Alembic migration, `modules.manage` permission, seeded 7 base modules in `app/seed_data/app_modules.json`, added `GET /api/v1/app/config`, `GET /api/v1/me/navigation`, `GET /api/v1/me/attendance-policy`, and Admin CRUD `/api/v1/app-modules`, exported updated `docs/backend/openapi.json`. |
| `04_navigation_shell_permissions.md` | Permission-driven navigation shell | Completed | `RuntimeAppConfigController` + `NavigationController` loading `/app/config` and `/me/navigation` with offline cache fallback in `PreferencesStorageService`, `PermissionService` (`can`, `canAny`, `canAll`, `ref.can()`, `PermissionGate`), `ModuleRegistry` (safe fallback for unknown `route_key`) & `ModuleIconMapper` (safe fallback for unknown `icon_key`), `AdaptiveShellScreen` (5-tab cap + "More" sheet on phones; `NavigationRail` sidebar on tablet/web; foreground resume hot-reload after `N` minutes), `HomeDashboardView` (quick cards + module tiles), `ForbiddenScreen` (403), `ForceUpdateScreen` (`min_supported_app_version` gate), and full unit & widget tests. |
| `05_profile_and_account.md` | Profile and account | Completed | `ProfileScreen` & `ProfileController` consuming `GET /api/v1/employees/me` (displaying `employee_code`, `full_name`, `email`, `role_name`, `department_name`, `designation`, `manager_name`, `joining_date`, `attendance_policy_name` verbatim from API with zero role logic) and `PATCH /api/v1/employees/me` (self-editable `phone_number` & `avatar_url`), `PhotoPickerService` (camera/gallery picker with compression and `RuntimeAppConfig` `max_upload_mb` / `allowed_upload_mime_types` validation), `ChangePasswordBottomSheet` with dynamic `PasswordPolicySummary` hints from `/app/config`, 422 field error mapping onto form fields, theme/language/biometric toggles, `DeviceInfoService` ("device info" + app version), logout & logout-all confirmation flows, and unit/widget tests. |

## Pending Prompts

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

Mirrors all 34 granular permission codes in the backend `PERMISSIONS_CATALOG` plus `*`:
- **User Management**: `user.create`, `user.read`, `user.update`, `user.delete`, `user.manage_roles`
- **Attendance**: `attendance.check_in`, `attendance.view_own`, `attendance.view_team`, `attendance.view_all`, `attendance.correct`, `attendance.manage_policy`
- **Leave Management**: `leave.apply`, `leave.view_own`, `leave.view_all`, `leave.approve`, `leave.manage_types`
- **Tasks & Deliverables**: `task.create`, `task.view_assigned`, `task.view_all`, `task.update`, `task.delete`
- **Clients & Projects**: `client.create`, `client.view_all`, `client.update`, `client.delete`, `project.create`, `project.view_all`, `project.update`, `project.delete`
- **Communication & Announcements**: `announcement.create`, `announcement.view`
- **System, Modules & Audit**: `system.view_audit_logs`, `system.manage_settings`, `modules.manage`

*(No role names are referenced anywhere in the Flutter codebase. `SessionController`, `NavigationController`, and `ProfileController` hydrate `userPermissionsControllerProvider` from `/auth/me`, `/me/navigation`, and `/employees/me`, hot-reload permissions on foreground resume after `N` minutes, and clear permissions on logout.)*

---

## API Endpoints Consumed

- `GET /api/v1/health` (`ApiEndpoints.health`)
- `GET /api/v1/app/config` (`ApiEndpoints.appConfig`)
- `GET /api/v1/me/navigation` (`ApiEndpoints.meNavigation`)
- `GET /api/v1/me/attendance-policy` (`ApiEndpoints.meAttendancePolicy`)
- `GET /api/v1/app-modules` (`ApiEndpoints.appModules`)
- `POST /api/v1/auth/login` (`ApiEndpoints.authLogin`)
- `POST /api/v1/auth/refresh` (`ApiEndpoints.authRefresh`)
- `POST /api/v1/auth/logout` (`ApiEndpoints.authLogout`)
- `POST /api/v1/auth/logout-all` (`ApiEndpoints.authLogoutAll`)
- `POST /api/v1/auth/change-password` (`ApiEndpoints.authChangePassword`)
- `POST /api/v1/auth/forgot-password` (`ApiEndpoints.authForgotPassword`)
- `POST /api/v1/auth/reset-password` (`ApiEndpoints.authResetPassword`)
- `GET /api/v1/auth/me` (`ApiEndpoints.authMe`)
- `GET /api/v1/employees/me` (`ApiEndpoints.employeesMe`)
- `PATCH /api/v1/employees/me` (`ApiEndpoints.employeesMe`)

---

## Open Issues / Blockers

- None for Prompts 05–09. Next stop gate will be **Backend Addendum A2** before Flutter Prompt 10.
