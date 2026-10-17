from __future__ import annotations

import os
from collections.abc import AsyncGenerator

import pytest
from httpx import ASGITransport, AsyncClient
from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)

# Set test environment variables BEFORE importing app or settings
os.environ["APP_NAME"] = "Right Ads Test App"
os.environ["ENVIRONMENT"] = "testing"
os.environ["DEBUG"] = "true"
os.environ["DATABASE_URL"] = "sqlite+aiosqlite:///:memory:"
os.environ["JWT_SECRET_KEY"] = "this_is_a_very_secure_test_secret_key_at_least_32_chars!"
os.environ["JWT_ALGORITHM"] = "HS256"
os.environ["ACCESS_TOKEN_EXPIRE_MINUTES"] = "30"
os.environ["REFRESH_TOKEN_EXPIRE_DAYS"] = "3"
os.environ["CORS_ORIGINS"] = '["http://testserver"]'
os.environ["APP_TIMEZONE"] = "UTC"
os.environ["DEFAULT_PAGE_SIZE"] = "10"
os.environ["MAX_PAGE_SIZE"] = "50"
os.environ["MAX_UPLOAD_MB"] = "5"
os.environ["ALLOWED_UPLOAD_MIME_TYPES"] = '["image/jpeg", "image/png"]'
os.environ["STORAGE_BACKEND"] = "local"
os.environ["RATE_LIMIT_ENABLED"] = "false"
os.environ["RATE_LIMIT_REQUESTS_PER_MINUTE"] = "100"
os.environ["MAX_LOGIN_ATTEMPTS"] = "3"
os.environ["LOCKOUT_MINUTES"] = "10"

from app.core.config import get_settings

# Force refresh of cached settings with test env
get_settings.cache_clear()

from app.cli.commands import _async_seed_defaults, _async_seed_permissions
from app.core.database import Base, get_db_session
from app.core.security import create_access_token, hash_password
from app.dependencies.database import get_db
from app.main import app
from app.models.rbac import Role
from app.models.user import User

# Test in-memory async SQLite engine
test_engine = create_async_engine("sqlite+aiosqlite:///:memory:", echo=False)
TestingSessionLocal = async_sessionmaker(
    bind=test_engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autoflush=False,
)


@pytest.fixture(scope="session")
def anyio_backend() -> str:
    return "asyncio"


@pytest.fixture(autouse=True)
async def prepare_database() -> AsyncGenerator[None, None]:
    """Create in-memory tables before each test and drop after."""
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest.fixture
async def db_session() -> AsyncGenerator[AsyncSession, None]:
    async with TestingSessionLocal() as session:
        yield session


@pytest.fixture
async def async_client(db_session: AsyncSession) -> AsyncGenerator[AsyncClient, None]:
    """Provides an AsyncClient with database dependencies overridden."""

    async def override_get_db() -> AsyncGenerator[AsyncSession, None]:
        yield db_session

    app.dependency_overrides[get_db] = override_get_db
    app.dependency_overrides[get_db_session] = override_get_db
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://testserver") as client:
        yield client
    app.dependency_overrides.clear()


@pytest.fixture
async def admin_auth_headers(db_session: AsyncSession) -> dict[str, str]:
    """Seeds permissions/defaults, creates an active Admin, and returns Bearer headers."""
    await _async_seed_permissions(session=db_session)
    await _async_seed_defaults(session=db_session)

    from sqlalchemy import select

    admin_role = (await db_session.execute(select(Role).where(Role.name == "Admin"))).scalar_one()

    admin_user = User(
        employee_code="ADMIN-001",
        email="superadmin@agency.com",
        full_name="Super Administrator",
        password_hash=hash_password("SuperSecretAdmin123!#"),
        role_id=admin_role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(admin_user)
    await db_session.commit()

    token = create_access_token(user_id=str(admin_user.id), role="Admin")
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture
async def employee_auth_headers(db_session: AsyncSession) -> tuple[User, dict[str, str]]:
    """Seeds defaults, creates an employee with Tele sales role, and returns (user, headers)."""
    await _async_seed_permissions(session=db_session)
    await _async_seed_defaults(session=db_session)

    from sqlalchemy import select

    role = (await db_session.execute(select(Role).where(Role.name == "Tele sales"))).scalar_one()

    emp = User(
        employee_code="EMP-0001",
        email="sales.rep@agency.com",
        full_name="Sales Representative",
        password_hash=hash_password("EmployeeSecret123!#"),
        role_id=role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(emp)
    await db_session.commit()

    token = create_access_token(user_id=str(emp.id), role="Tele sales")
    return emp, {"Authorization": f"Bearer {token}"}
