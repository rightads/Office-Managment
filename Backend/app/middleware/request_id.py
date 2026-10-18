from __future__ import annotations

import uuid
from collections.abc import Callable
from contextvars import ContextVar
from typing import Any

from fastapi import Request, Response
from starlette.middleware.base import BaseHTTPMiddleware

# Context variable preserving request correlation ID across async execution branches
request_id_ctx: ContextVar[str | None] = ContextVar("request_id_ctx", default=None)


def get_request_id() -> str | None:
    """Retrieve the current request ID from context."""
    return request_id_ctx.get()


class RequestIDMiddleware(BaseHTTPMiddleware):
    """
    Middleware that captures or generates a correlation Request ID (X-Request-ID),
    stores it in the async contextvar for structured logging, and attaches it
    to outgoing HTTP response headers.
    """

    async def dispatch(self, request: Request, call_next: Callable[[Request], Any]) -> Response:
        req_id = request.headers.get("X-Request-ID")
        if not req_id:
            req_id = uuid.uuid4().hex

        token = request_id_ctx.set(req_id)
        try:
            response: Response = await call_next(request)
            response.headers["X-Request-ID"] = req_id
            return response
        finally:
            request_id_ctx.reset(token)
