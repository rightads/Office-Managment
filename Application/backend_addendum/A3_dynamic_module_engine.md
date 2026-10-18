# BACKEND A3 - Dynamic module engine (run in the BACKEND project, before Flutter 11)

Goal: role-specific modules (Leads, Tickets, Invoices, Keyword Tracker, ...) must be DEFINITIONS in the database, not new code per module.

Design and implement:
- `module_definitions` (id, app_module_id, code unique, label, description, record_label_singular/plural, version, is_active)
- `module_fields` (id, module_id, key, label, type [text, long_text, number, currency, date, datetime, phone, email, url, single_select, multi_select, boolean, file, image, user, client, project, geo_point], is_required, is_list_visible, is_filterable, is_searchable, options json (for selects, with label/color), validation json (min/max/regex), default_value, sort_order, section)
- `module_statuses` and `module_status_transitions` (like task statuses; label, color, is_terminal, required_permission nullable)
- `module_records` (id, module_id, data jsonb, status_id, created_by, assigned_to nullable, client_id nullable, due_at nullable, is_active, created_at/updated_at), with GIN index on data and indexes on module_id/status/assigned_to.
- `module_record_comments`, `module_record_attachments`, `module_record_activities` (timeline).
- Permissions generated per module from the registry: `module.<code>.view_own`, `view_team`, `view_all`, `create`, `edit_own`, `edit_all`, `delete`, `export`. Admin may map them to roles from the UI.

Endpoints (/api/v1/modules/{code}):
- GET definition (fields, statuses, transitions) - used by the app to render screens.
- Records: create, list (pagination, search, filters on filterable fields, status, assignee, date range, sort), get, update, change status (via allowed transitions), assign, delete (soft), comments, attachments, timeline.
- Summary/aggregate endpoint (counts per status, per assignee, total of currency fields) in SQL.
- Export to xlsx/csv.
- Admin (permission `modules.manage`): CRUD for definitions, fields, statuses, transitions with validation that existing records are not broken (no removing a field in use without a migration path; deactivate instead).
- Server-side validation of record `data` against the field definitions (types, required, options, regex). Return field-level errors in a consistent format.
- Notifications on assignment/status change via templates.
- Tests, audit logs, performance (no N+1), refresh openapi.json.
