# Right Ads - Employee Management Backend

Production-ready backend API for the "Right Ads" employee management application, built with **FastAPI**, **SQLAlchemy 2.0 (async)**, **PostgreSQL**, **Alembic**, **Pydantic v2**, and **Redis**.

---

## Architecture Principles
1. **Zero Hardcoding**: All secrets, environment settings, upload limits, pagination sizes, and CORS origins are strictly driven by environment variables through Pydantic Settings (`app/core/config.py`).
2. **Layered Design**:
   `Routers (app/api/v1/)` -> `Services (app/services/)` -> `Repositories (app/repositories/)` -> `Models (app/models/)`.
3. **Permission-Based Access Control**: Strict granular permission authorization (e.g. `attendance.view_all`).
4. **Timezone Uniformity**: All database timestamps are timezone-aware and stored in **UTC**.
5. **Standardized JSON Envelope**: All errors follow a uniform JSON structure with machine-readable error codes.
6. **Soft Deletions**: Entities are deactivated/soft-deleted rather than permanently removed from the database.

---

## Directory Structure
```
Backend/
├── alembic/              # Database migration configuration and revisions
├── app/
│   ├── api/              # API router and v1 endpoints
│   ├── cli/              # Management commands and CLI tools
│   ├── core/             # Config, security, DB engine, exceptions, logging
│   ├── dependencies/     # Reusable FastAPI dependencies
│   ├── models/           # SQLAlchemy 2.0 ORM models
│   ├── repositories/     # Data access layer
│   ├── schemas/          # Pydantic v2 schemas and validation models
│   ├── services/         # Domain business logic
│   └── utils/            # Shared utility functions
├── docs/                 # Documentation & PROGRESS.md tracker
├── scripts/              # Helper scripts for run, test, lint, and migrate
├── tests/                # Automated pytest test suite
├── Dockerfile            # Multi-stage production container definition
├── docker-compose.yml    # Orchestration for API, PostgreSQL 16, and Redis 7
├── pyproject.toml        # Ruff, Mypy, and Pytest configuration
├── requirements.txt      # Production dependencies
├── requirements-dev.txt  # Testing & development dependencies
└── .env.example          # Environment variable template with placeholders
```

---

## Getting Started

### 1. Prerequisites
- Python 3.10+ (Docker image uses Python 3.12)
- PostgreSQL 16+
- Redis 7+ (optional for caching/rate-limiting)
- Docker & Docker Compose (optional for local containerized run)

### 2. Environment Configuration
Copy the template and fill in your local credentials:
```bash
cp .env.example .env
```
> [!IMPORTANT]
> `JWT_SECRET_KEY` must be at least 32 characters long. The application will fail validation on startup if it is shorter or absent.

### 3. Option A: Running with Docker Compose (Recommended)
Start API, PostgreSQL, and Redis in isolated containers:
```bash
docker compose up --build -d
```
Check health:
```bash
curl http://localhost:8000/health
```

### 4. Option B: Running Locally

Create and activate a virtual environment:
```bash
python -m venv venv
# On Windows PowerShell:
.\venv\Scripts\Activate.ps1
# On Linux/macOS:
source venv/bin/activate
```

Install dependencies:
```bash
pip install --upgrade pip
pip install -r requirements-dev.txt
```

Run database migrations:
```bash
alembic upgrade head
```

Start the development server:
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

---

## API Documentation
When running in `development` or with `DEBUG=true`:
- **Swagger UI**: [http://localhost:8000/docs](http://localhost:8000/docs)
- **ReDoc**: [http://localhost:8000/redoc](http://localhost:8000/redoc)
- **Health Check**: [http://localhost:8000/health](http://localhost:8000/health)

---

## Code Quality & Testing

Run linting with Ruff:
```bash
ruff check .
ruff format --check .
```

Run static type checking with Mypy:
```bash
mypy app
```

Run automated tests:
```bash
pytest -v tests/
```
