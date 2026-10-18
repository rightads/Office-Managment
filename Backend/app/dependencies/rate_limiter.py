from __future__ import annotations

import collections
import logging
import time
from typing import Any

from fastapi import Request

from app.core.config import settings
from app.core.exceptions import RateLimitExceededException
from app.core.redis import get_redis_client

logger = logging.getLogger(__name__)

# Fallback in-memory storage: key -> deque of timestamps
_in_memory_cache: dict[str, collections.deque[float]] = collections.defaultdict(collections.deque)


class RateLimiter:
    """
    FastAPI dependency for endpoint-level rate limiting.
    Supports Redis distributed sliding-window counter with automatic fallback
    to in-memory sliding-window timestamps when Redis is unavailable.
    """

    def __init__(self, times: int = 5, seconds: int = 60, prefix: str = "rate") -> None:
        self.times = times
        self.seconds = seconds
        self.prefix = prefix

    async def __call__(self, request: Request) -> None:
        if not settings.RATE_LIMIT_ENABLED:
            return

        client_ip = request.headers.get("x-forwarded-for", "").split(",")[0].strip() or (
            request.client.host if request.client else "unknown"
        )
        rate_key = f"rate_limit:{self.prefix}:{client_ip}"
        now = time.time()

        # Try Redis first
        redis_client = await get_redis_client()
        if redis_client is not None:
            try:
                # Sliding window via sorted set in Redis
                pipe = redis_client.pipeline()
                pipe.zremrangebyscore(rate_key, 0, now - self.seconds)
                pipe.zadd(rate_key, {str(now): now})
                pipe.zcard(rate_key)
                pipe.expire(rate_key, self.seconds + 1)
                results: list[Any] = await pipe.execute()
                current_count: int = results[2]

                if current_count > self.times:
                    logger.warning(
                        "Rate limit exceeded for %s on %s: %d/%d in %ds",
                        client_ip,
                        request.url.path,
                        current_count,
                        self.times,
                        self.seconds,
                    )
                    raise RateLimitExceededException(
                        message=f"Too many requests. Limit is {self.times} per {self.seconds} seconds."
                    )
                return
            except RateLimitExceededException:
                raise
            except Exception as exc:
                logger.warning("Redis rate limiter error (%s), falling back to in-memory.", exc)

        # In-memory sliding window fallback
        timestamps = _in_memory_cache[rate_key]
        window_start = now - self.seconds

        # Prune expired timestamps
        while timestamps and timestamps[0] <= window_start:
            timestamps.popleft()

        if len(timestamps) >= self.times:
            logger.warning(
                "In-memory rate limit exceeded for %s on %s: %d/%d in %ds",
                client_ip,
                request.url.path,
                len(timestamps),
                self.times,
                self.seconds,
            )
            raise RateLimitExceededException(
                message=f"Too many requests. Limit is {self.times} per {self.seconds} seconds."
            )

        timestamps.append(now)
