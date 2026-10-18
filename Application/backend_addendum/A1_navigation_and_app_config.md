# BACKEND A1 - Navigation, modules registry and public app config (run in the BACKEND project, before Flutter 04)

Follow the same backend rules (no hardcoding, layered architecture, permission-based auth, tests, plan first).

Add:
1. Table `app_modules` (id, code unique, label, icon_key, route_key, sort_order, required_permission, is_base bool, is_active, show_on_home bool, description). Everything is DATA. Add admin CRUD (permission `modules.manage`).
2. `GET /api/v1/me/navigation`: returns the modules the current user may see (filtered by the user's permissions, is_active), ordered, plus the user's permission codes list, role name/label (for display only), department, and flags (must_change_password).
3. `GET /api/v1/app/config` (public or authenticated, decide and justify): returns non-secret runtime config: app timezone, default/max page size, max upload MB, allowed upload MIME types, minimum supported app version, force-update flag, password policy summary, and feature flags. Values come from settings / system_settings, not literals.
4. `GET /api/v1/me/attendance-policy`: the effective policy for the user (geofence required, selfie required, shift times, allowed office locations with lat/lng/radius).
5. Seed the base modules through the versioned seed files (attendance, tasks, leave, announcements, notifications, work_reports, profile) with the `seed-defaults` command. No seed data inside migrations.
6. Tests for permission filtering. Refresh and export openapi.json.
