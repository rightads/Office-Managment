from __future__ import annotations

import logging
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request, status
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException

from app.api.v1.endpoints import health
from app.api.v1.router import api_v1_router
from app.core.config import settings
from app.core.constants import ErrorCode
from app.core.database import engine
from app.core.exceptions import (
    AppException,
    ErrorDetail,
    ErrorEnvelope,
    StandardErrorResponse,
)
from app.core.logging import setup_logging

logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Lifespan context manager for application startup and shutdown."""
    # Setup structured JSON logging
    setup_logging(debug=settings.DEBUG)
    logger.info(
        "Application starting up",
        extra={
            "app_name": settings.APP_NAME,
            "environment": settings.ENVIRONMENT,
            "debug": settings.DEBUG,
        },
    )
    yield
    # Graceful shutdown: close async database pool
    logger.info("Application shutting down, disposing database engine")
    await engine.dispose()


app = FastAPI(
    title=settings.APP_NAME,
    description="Right Ads Employee Management Platform Backend API",
    version="1.0.0",
    docs_url="/docs" if settings.DEBUG or settings.ENVIRONMENT != "production" else None,
    redoc_url="/redoc" if settings.DEBUG or settings.ENVIRONMENT != "production" else None,
    lifespan=lifespan,
)

# CORS Configuration strictly from settings
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Global Exception Handlers
@app.exception_handler(AppException)
async def app_exception_handler(request: Request, exc: AppException) -> JSONResponse:
    """Handle custom application exceptions."""
    payload = StandardErrorResponse(
        success=False,
        error=ErrorEnvelope(
            code=exc.error_code,
            message=exc.message,
            details=exc.details,
        ),
    )
    return JSONResponse(status_code=exc.status_code, content=payload.model_dump())


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(
    request: Request, exc: RequestValidationError
) -> JSONResponse:
    """Handle Pydantic request validation errors."""
    details: list[ErrorDetail] = []
    for err in exc.errors():
        loc = list(err.get("loc", []))
        msg = err.get("msg", "Invalid input")
        err_type = err.get("type", "validation_error")
        details.append(ErrorDetail(loc=loc, msg=msg, type=err_type))

    payload = StandardErrorResponse(
        success=False,
        error=ErrorEnvelope(
            code=ErrorCode.VALIDATION_ERROR.value,
            message="Request validation failed.",
            details=details,
        ),
    )
    return JSONResponse(
        status_code=getattr(status, "HTTP_422_UNPROCESSABLE_CONTENT", 422),
        content=payload.model_dump(),
    )


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException) -> JSONResponse:
    """Handle Starlette HTTP exceptions."""
    code = ErrorCode.BAD_REQUEST.value
    if exc.status_code == status.HTTP_404_NOT_FOUND:
        code = ErrorCode.NOT_FOUND.value
    elif exc.status_code == status.HTTP_401_UNAUTHORIZED:
        code = ErrorCode.UNAUTHORIZED.value
    elif exc.status_code == status.HTTP_403_FORBIDDEN:
        code = ErrorCode.FORBIDDEN.value
    elif exc.status_code == status.HTTP_409_CONFLICT:
        code = ErrorCode.CONFLICT.value

    payload = StandardErrorResponse(
        success=False,
        error=ErrorEnvelope(
            code=code,
            message=str(exc.detail),
            details=[],
        ),
    )
    return JSONResponse(status_code=exc.status_code, content=payload.model_dump())


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    """Catch-all unhandled exception handler logging stack traces securely."""
    logger.exception("Unhandled server exception: %s", str(exc))
    payload = StandardErrorResponse(
        success=False,
        error=ErrorEnvelope(
            code=ErrorCode.INTERNAL_SERVER_ERROR.value,
            message="An unexpected server error occurred. Please contact support.",
            details=[],
        ),
    )
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content=payload.model_dump(),
    )


# Root health endpoint
app.include_router(health.router)

# Mount API v1 router
app.include_router(api_v1_router, prefix="/api/v1")
