# Right Ads Backend - Progress & Execution Tracker

## Completed Prompts
- [x] **Prompt 01**: Scaffold, config, Docker, database (Completed)
- [ ] **Prompt 02**: Core data models & migrations
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

---

## Permission Catalog
*(Populated incrementally as features are designed and implemented in subsequent prompts)*

| Permission Code | Category | Description | Introduced In |
|-----------------|----------|-------------|---------------|
| *(None yet - prompt 01 focuses on scaffolding and config)* | - | - | - |
