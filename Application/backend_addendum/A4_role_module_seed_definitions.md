# BACKEND A4 - Seed role modules and role-permission mappings (run in the BACKEND project, before Flutter 15)

Read `docs/ROLE_MODULE_MATRIX.md` (copy it into the backend repo docs if needed; confirm/edit the matrix first).

1. Create versioned seed files under app/seed_data/modules/*.json (one file per module): definition, fields, statuses, transitions, and the permission mappings per role. No module definitions inside Python code or migrations.
2. Create the roles as data: Tele Sales, Sales & Marketing, CSD, Graphic Designer, Website Designer, Website Development, HR, Accounts, Web Application, SEO, GMB, Admin, Super Admin. Every employee role gets the base permissions (own attendance, own tasks, own leave, announcements view, own work reports, own profile). Each module's permissions are mapped to the matching roles per the matrix (own/team/all as appropriate; e.g. Accounts gets invoices create/edit_all, Tele Sales gets leads view_own/create/edit_own).
3. Admin gets view_all across employee modules, attendance, tasks, leave approvals, reports; Super Admin gets everything including roles/permissions, modules.manage, system settings, audit logs.
4. Make `seed-defaults` idempotent: it adds missing roles/modules/permissions and never overwrites admin edits unless `--force` is passed.
5. Sample data is NOT included. Tests verify each role sees exactly the modules mapped to it via /me/navigation.
6. Refresh openapi.json.
