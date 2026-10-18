from __future__ import annotations

from collections.abc import Callable
from typing import Any

from fastapi import Request, Response, status
from fastapi.responses import JSONResponse
from starlette.middleware.base import BaseHTTPMiddleware

from app.core.config import settings
from app.core.exceptions import ErrorEnvelope, StandardErrorResponse


class SecurityHeadersMiddleware(BaseHTTPMiddleware):
    """
    Middleware applying hardened OWASP security headers to all HTTP responses.
    Prevents MIME-sniffing, clickjacking, cross-site scripting, and unauthorized framing.
    """

    async def dispatch(self, request: Request, call_next: Callable[[Request], Any]) -> Response:
        response: Response = await call_next(request)

        # Standard OWASP hardening headers
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["X-XSS-Protection"] = "1; mode=block"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        response.headers["Permissions-Policy"] = (
            "geolocation=(), camera=(), microphone=(), payment=()"
        )
        response.headers["Content-Security-Policy"] = (
            "default-src 'self'; frame-ancestors 'none'; object-src 'none';"
        )

        # Enforce HSTS if running over HTTPS or in production/staging environments
        if request.url.scheme == "https" or settings.ENVIRONMENT in ("production", "staging"):
            response.headers["Strict-Transport-Security"] = (
                "max-age=31536000; includeSubDomains; preload"
            )

        return response


class RequestSizeLimitMiddleware(BaseHTTPMiddleware):
    """
    Middleware enforcing maximum payload size based on settings.MAX_UPLOAD_MB.
    Rejects oversized request payloads before full memory ingestion.
    """

    async def dispatch(self, request: Request, call_next: Callable[[Request], Any]) -> Response:
        content_length = request.headers.get("content-length")
        max_bytes = settings.MAX_UPLOAD_MB * 1024 * 1024

        if content_length:
            try:
                length_int = int(content_length)
                if length_int > max_bytes:
                    payload = StandardErrorResponse(
                        success=False,
                        error=ErrorEnvelope(
                            code="PAYLOAD_TOO_LARGE",
                            message=(
                                f"Request payload size ({length_int} bytes) exceeds "
                                f"the maximum allowed limit of {settings.MAX_UPLOAD_MB} MB."
                            ),
                            details=[],
                        ),
                    )
                    return JSONResponse(
                        status_code=getattr(status, "HTTP_413_CONTENT_TOO_LARGE", 413),
                        content=payload.model_dump(),
                    )
            except ValueError:
                pass

        response: Response = await call_next(request)
        return response
