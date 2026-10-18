from __future__ import annotations

from typing import Any

import pytest
from fastapi.routing import APIRoute

from app.dependencies.auth import (
    get_current_user,
    require_active_user,
)
from app.main import app

# Explicit public allow-list exempt from authentication/permissions
PUBLIC_ALLOW_LIST = {
    "/health",
    "/api/v1/health",
    "/api/v1/app/config",
    "/api/v1/auth/login",
    "/api/v1/auth/refresh",
    "/api/v1/auth/forgot-password",
    "/api/v1/auth/reset-password",
    "/docs",
    "/redoc",
    "/openapi.json",
}

# Known security check callables and names
SECURITY_CALLABLES = {
    get_current_user,
    require_active_user,
}

SECURITY_CALLABLE_NAMES = {
    "permission_checker",
    "any_permission_checker",
    "require_active_user",
    "get_current_user",
}


def _has_security_dependency(dependant: Any) -> bool:
    """Recursively checks if a dependant or any sub-dependant has a security guard."""
    if dependant.call in SECURITY_CALLABLES:
        return True
    if hasattr(dependant.call, "__name__") and dependant.call.__name__ in SECURITY_CALLABLE_NAMES:
        return True

    for sub_dep in getattr(dependant, "dependencies", []):
        if _has_security_dependency(sub_dep):
            return True

    return False


@pytest.mark.unit
def test_every_endpoint_has_explicit_security_dependency() -> None:
    """
    Automated security audit: Verifies that EVERY registered FastAPI route
    has an explicit authentication/permission dependency unless explicitly
    enumerated on the PUBLIC_ALLOW_LIST.
    """
    unprotected_routes: list[str] = []

    for route in app.routes:
        if not isinstance(route, APIRoute):
            continue

        path = route.path
        # Skip FastAPI built-in docs/openapi
        if path in PUBLIC_ALLOW_LIST:
            continue

        # Check route dependencies
        has_security = False
        for dep in route.dependant.dependencies:
            if _has_security_dependency(dep):
                has_security = True
                break

        if not has_security:
            methods = ",".join(route.methods)
            unprotected_routes.append(f"[{methods}] {path} -> {route.endpoint.__name__}")

    assert not unprotected_routes, (
        f"Found {len(unprotected_routes)} unprotected route(s) lacking an explicit "
        f"permission or authentication dependency:\n" + "\n".join(unprotected_routes)
    )
