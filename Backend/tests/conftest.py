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

from app.core.database import Base
from app.dependencies.database import get_db
from app.main import app

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
    """Provides an AsyncClient with database dependency overridden."""

    async def override_get_db() -> AsyncGenerator[AsyncSession, None]:
        yield db_session

    app.dependency_overrides[get_db] = override_get_db
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://testserver") as client:
        yield client
    app.dependency_overrides.clear()
