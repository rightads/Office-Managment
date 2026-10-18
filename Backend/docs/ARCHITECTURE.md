# Right Ads Backend - Architecture & Design System

## 1. System Overview
Right Ads is an enterprise employee management, attendance tracking, task workflow, and notification platform tailored for a multi-department digital marketing agency. The backend is built on **Python 3.10+**, **FastAPI**, **SQLAlchemy 2.0 (async)**, **PostgreSQL**, and **Redis**.

```
+-----------------------------------------------------------------------------------+
|                                  Client Tier                                      |
|                       (Mobile Apps - iOS/Android, Web Portal)                     |
+-----------------------------------------------------------------------------------+
                                         |
                                         | HTTPS / REST / JSON
                                         v
+-----------------------------------------------------------------------------------+
|                                API Gateway / Nginx                                |
|                        (SSL Termination, Reverse Proxy)                           |
+-----------------------------------------------------------------------------------+
                                         |
                                         v
+-----------------------------------------------------------------------------------+
|                                FastAPI Application                                |
|  +-----------------------------------------------------------------------------+  |
|  | Middleware Pipeline: Security Headers -> Size Limit -> Request ID -> CORS   |  |
|  +-----------------------------------------------------------------------------+  |
|  | Dependency Injection Tier: Auth (JWT), RBAC Permissions, DB Session, Rate   |  |
|  +-----------------------------------------------------------------------------+  |
|  | API Routing Tier: Auth, Employees, Attendance, Leaves, Tasks, Notifications |  |
|  +-----------------------------------------------------------------------------+  |
|  | Service Tier: Business logic, validations, state machines, notifications     |  |
|  +-----------------------------------------------------------------------------+  |
|  | Repository Tier: Async queries, pagination, eager loading, transactions      |  |
+-----------------------------------------------------------------------------------+
             |                                     |                         |
             v                                     v                         v
+------------------------+             +-----------------------+   +-------------------+
|   PostgreSQL Engine    |             |      Redis 7+         |   | FCM / S3 Storage  |
|  (Data, RBAC, Ledger)  |             | (Cache, Sliding Rate) |   | (Push, Artifacts) |
+------------------------+             +-----------------------+   +-------------------+
```

---

## 2. Core Architectural Principles

### 2.1 Zero Hardcoding
- **No Hardcoded Roles**: Roles are dynamic database records (`roles` table). System roles like `Admin` are protected by `is_system` database flags, but all permission checks use dynamic granular permission strings (`require_permissions("task.create")`).
- **No Hardcoded Enums in Code Branches**: Task statuses (`task_statuses`), task transitions (`task_status_transitions`), priorities (`task_priorities`), attendance statuses (`attendance_statuses`), leave types (`leave_types`), and notification templates (`notification_templates`) live in relational tables.
- **Dynamic Configuration**: Runtime operational policies (geofencing tolerance, leave accruals, notification channels, lockout rules) are managed in `system_settings`.

### 2.2 Layered Architecture
- **API Endpoints (`app/api/v1/endpoints/`)**: Thin controllers handling HTTP serialization, validation, status codes, and dependency guards.
- **Schemas (`app/schemas/`)**: Pydantic v2 data contracts enforcing strict validation, type safety, and prohibiting sensitive field leakage (`password_hash`, tokens).
- **Services (`app/services/`)**: Encapsulates all domain rules, state machine transitions, background dispatches, and coordinate calculations.
- **Repositories (`app/repositories/`)**: Manages SQLAlchemy ORM statements, transactions, eager loading (`selectinload`), and SQL aggregations.
- **Models (`app/models/`)**: Declarative SQLAlchemy 2.0 mapped entities using UUID primary keys and standard mixins (`UUIDMixin`, `TimestampMixin`, `SoftDeleteMixin`).

### 2.3 Non-Blocking Asynchronous Operations
- All I/O operations (database access via `asyncpg`, caching via `redis.asyncio`, external push dispatches via non-blocking background workers) are asynchronous (`async`/`await`).

---

## 3. Data Flow & Security Pipeline
1. **Request Intake**:
   - `SecurityHeadersMiddleware`: Enforces OWASP headers.
   - `RequestSizeLimitMiddleware`: Blocks payloads exceeding `MAX_UPLOAD_MB` (HTTP 413).
   - `RequestIDMiddleware`: Captures or creates `X-Request-ID` and sets `ContextVar`.
2. **Authentication & Authorization**:
   - `get_current_user`: Decodes JWT access token, queries user with preloaded permissions.
   - `require_permissions`: Validates presence of necessary permissions from database role assignment.
3. **Execution & Auditing**:
   - Service handles domain transactions; critical master data alterations create persistent `AuditLog` records.
4. **Structured JSON Logging**:
   - Log records include timestamp, log level, request correlation ID, and exception stack traces in uniform JSON.
