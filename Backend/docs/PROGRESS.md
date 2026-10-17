# Right Ads Backend - Progress & Execution Tracker

## Completed Prompts
- [x] **Prompt 01**: Scaffold, config, Docker, database (Completed)
- [x] **Prompt 02**: Core data models & migrations (Completed)
- [ ] **Prompt 03**: Seeding, CLI, auth, RBAC
- [ ] **Prompt 04**: Employee & master data
- [ ] **Prompt 05**: Attendance engine
- [ ] **Prompt 06**: Attendance reports & exports
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
4. **Password Hashing**: Direct `bcrypt` implementation with 72-byte truncation for robust password security without third-party wrapper deprecation issues.
5. **Universal UUID Primary Keys**: All entity primary keys use `Uuid(as_uuid=True)` providing native PostgreSQL UUID representation and SQLite compatibility for tests.
6. **No-Hardcoding Data Architecture**: Roles, permissions, departments, attendance statuses (with `counts_as_present`), task statuses (with transitions), priorities (with weights), leave types (with quotas), holidays, office locations, and attendance policies are dynamic database entities. Runtime operational configs (e.g. employee code prefixes) are stored in `system_settings`.
7. **Clean Migration**: Initial migration `afe9548b43aa_create_core_data_models.py` contains 28 tables with zero seed data, validated for upgrade and downgrade idempotency.

---

## Permission Catalog
*(Permission definitions to be seeded and enforced starting in Prompt 03)*

| Permission Code | Category | Description | Introduced In |
|-----------------|----------|-------------|---------------|
| `attendance.view_all` | Attendance | View attendance records across all employees | Prompt 02 / 03 |
