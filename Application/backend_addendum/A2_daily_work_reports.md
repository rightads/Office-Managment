# BACKEND A2 - Daily work reports / timesheets (run in the BACKEND project, before Flutter 10)

Implement a daily work report module usable by every role.
- Tables: `work_reports` (id, user_id, report_date, summary, status [draft/submitted/reviewed], submitted_at, reviewed_by, review_note) and `work_report_items` (report_id, task_id nullable, client_id nullable, project_id nullable, description, minutes_spent, category_id nullable).
- Endpoints: employee create/update (while draft or until reviewed, rule configurable in system_settings), submit, list my reports, get by date; admin/manager: list by employee/date/department, review with a note, and missing-report list for a date.
- Permissions: `work_reports.submit_own`, `work_reports.view_team`, `work_reports.view_all`, `work_reports.review`.
- Rules: one report per user per date; future dates blocked; max minutes per day and the editable window come from system_settings.
- Notification to the reviewer on submit and to the employee on review (via notification service).
- Add to app_modules seed, tests, audit log, refresh openapi.json.
