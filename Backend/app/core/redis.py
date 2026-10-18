from __future__ import annotations

import logging
from typing import Any

import redis.asyncio as aioredis
from redis.exceptions import RedisError

from app.core.config import get_settings

logger = logging.getLogger(__name__)

_redis_client: aioredis.Redis | None = None
_redis_disabled: bool = False


async def get_redis_client() -> aioredis.Redis | None:
    """
    Get or initialize the async Redis client singleton.
    Degrades gracefully if REDIS_URL is not configured or server is unreachable.
    """
    global _redis_client, _redis_disabled

    if _redis_disabled:
        return None

    settings = get_settings()
    if not settings.REDIS_URL:
        return None

    if _redis_client is None:
        try:
            _redis_client = aioredis.from_url(
                settings.REDIS_URL,
                decode_responses=True,
                socket_connect_timeout=2.0,
                socket_timeout=2.0,
            )
            # Test connectivity
            await _redis_client.ping()
            logger.info("Successfully connected to Redis at %s", settings.REDIS_URL)
        except Exception as exc:
            logger.warning("Failed to connect to Redis (%s). Running in cache-bypass mode.", exc)
            _redis_client = None
            _redis_disabled = True
            return None

    return _redis_client


async def get_cache(key: str) -> str | None:
    """Retrieve a string value from Redis cache by key. Gracefully returns None on failure."""
    try:
        client = await get_redis_client()
        if client is None:
            return None
        val: Any = await client.get(key)
        return str(val) if val is not None else None
    except (RedisError, Exception) as exc:
        logger.warning("Redis get_cache error for key %s: %s", key, exc)
        return None


async def set_cache(key: str, value: str, expire_seconds: int = 86400) -> bool:
    """Store a string value in Redis with TTL. Gracefully returns False on failure."""
    try:
        client = await get_redis_client()
        if client is None:
            return False
        await client.set(key, value, ex=expire_seconds)
        return True
    except (RedisError, Exception) as exc:
        logger.warning("Redis set_cache error for key %s: %s", key, exc)
        return False


async def invalidate_cache_pattern(pattern: str) -> int:
    """Invalidate all cache keys matching the given pattern (e.g. 'reports:attendance:*')."""
    try:
        client = await get_redis_client()
        if client is None:
            return 0
        keys: list[str] = []
        async for k in client.scan_iter(match=pattern):
            keys.append(k)
        if keys:
            deleted = await client.delete(*keys)
            return int(deleted)
        return 0
    except (RedisError, Exception) as exc:
        logger.warning("Redis invalidate_cache_pattern error for pattern %s: %s", pattern, exc)
        return 0


async def close_redis() -> None:
    """Close active Redis connections during application shutdown."""
    global _redis_client, _redis_disabled
    if _redis_client is not None:
        try:
            await _redis_client.aclose()
        except Exception as exc:
            logger.warning("Error closing Redis client: %s", exc)
        finally:
            _redis_client = None
            _redis_disabled = False
