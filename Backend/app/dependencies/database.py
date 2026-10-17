from __future__ import annotations

from collections.abc import AsyncGenerator

from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db_session

# Reusable database session dependency
DatabaseSession = AsyncSession


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """FastAPI dependency for obtaining an asynchronous database session."""
    async for session in get_db_session():
        yield session
