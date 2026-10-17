from __future__ import annotations

import pytest
from httpx import ASGITransport, AsyncClient

from app.core.constants import ErrorCode
from app.core.exceptions import (
    ConflictException,
    ForbiddenException,
    NotFoundException,
    UnauthorizedException,
    ValidationException,
)
from app.main import app


@pytest.mark.asyncio
async def test_not_found_exception_envelope() -> None:
    """Verify 404 responses conform to the standard error envelope."""
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://testserver") as client:
        response = await client.get("/non-existent-route-for-testing")
        assert response.status_code == 404
        data = response.json()
        assert data["success"] is False
        assert "error" in data
        assert data["error"]["code"] == ErrorCode.NOT_FOUND.value
        assert "message" in data["error"]


def test_custom_exception_properties() -> None:
    """Verify custom domain exceptions set proper status codes and error codes."""
    exc1 = NotFoundException("Employee not found")
    assert exc1.status_code == 404
    assert exc1.error_code == ErrorCode.NOT_FOUND.value
    assert exc1.message == "Employee not found"

    exc2 = UnauthorizedException()
    assert exc2.status_code == 401
    assert exc2.error_code == ErrorCode.UNAUTHORIZED.value

    exc3 = ForbiddenException()
    assert exc3.status_code == 403
    assert exc3.error_code == ErrorCode.FORBIDDEN.value

    exc4 = ValidationException(
        "Invalid data", details=[{"msg": "Bad field", "loc": ["body", "email"]}]
    )
    assert exc4.status_code == 422
    assert exc4.error_code == ErrorCode.VALIDATION_ERROR.value
    assert len(exc4.details) == 1
    assert exc4.details[0].msg == "Bad field"

    exc5 = ConflictException()
    assert exc5.status_code == 409
    assert exc5.error_code == ErrorCode.CONFLICT.value
