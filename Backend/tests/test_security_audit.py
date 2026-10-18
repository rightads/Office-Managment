from __future__ import annotations

from unittest.mock import patch

import pytest
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.models.user import User


@pytest.mark.asyncio
async def test_security_headers_middleware_applied(
    async_client: AsyncClient,
) -> None:
    """Verifies that all OWASP security hardening headers are injected on responses."""
    resp = await async_client.get("/api/v1/health")
    assert resp.status_code == 200
    headers = resp.headers

    assert headers.get("X-Content-Type-Options") == "nosniff"
    assert headers.get("X-Frame-Options") == "DENY"
    assert headers.get("X-XSS-Protection") == "1; mode=block"
    assert headers.get("Referrer-Policy") == "strict-origin-when-cross-origin"
    assert "default-src 'self'" in headers.get("Content-Security-Policy", "")
    assert "geolocation=()" in headers.get("Permissions-Policy", "")


@pytest.mark.asyncio
async def test_request_id_middleware_echo_and_generate(
    async_client: AsyncClient,
) -> None:
    """Verifies that X-Request-ID is generated if missing and echoed back when supplied."""
    # 1. Generated if missing
    resp1 = await async_client.get("/api/v1/health")
    assert resp1.status_code == 200
    assert "X-Request-ID" in resp1.headers
    generated_id = resp1.headers["X-Request-ID"]
    assert len(generated_id) >= 16

    # 2. Echoed when provided
    custom_id = "req-custom-client-trace-12345"
    resp2 = await async_client.get("/api/v1/health", headers={"X-Request-ID": custom_id})
    assert resp2.status_code == 200
    assert resp2.headers.get("X-Request-ID") == custom_id


@pytest.mark.asyncio
async def test_request_size_limit_middleware(
    async_client: AsyncClient,
) -> None:
    """Verifies that payload size exceeding settings.MAX_UPLOAD_MB is rejected with HTTP 413."""
    max_bytes = settings.MAX_UPLOAD_MB * 1024 * 1024
    oversized_length = max_bytes + 1024

    resp = await async_client.post(
        "/api/v1/auth/login",
        headers={"Content-Length": str(oversized_length)},
        content=b"oversized dummy payload",
    )
    assert resp.status_code == 413
    data = resp.json()
    assert data["success"] is False
    assert data["error"]["code"] == "PAYLOAD_TOO_LARGE"


@pytest.mark.asyncio
async def test_rate_limiter_exceeded_triggers_429(
    async_client: AsyncClient,
) -> None:
    """Verifies that rate limiting blocks excessive requests to sensitive endpoints."""
    with patch.object(settings, "RATE_LIMIT_ENABLED", True):
        # /api/v1/auth/login allows 5 requests per minute per IP
        results: list[int] = []
        for _ in range(7):
            resp = await async_client.post(
                "/api/v1/auth/login",
                json={"email": "nonexistent@agency.com", "password": "WrongPassword123!"},
            )
            results.append(resp.status_code)

        # At least the 6th or 7th request should have triggered HTTP 429
        assert 429 in results


@pytest.mark.asyncio
async def test_no_data_leakage_in_user_responses(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Verifies that password hashes, salt, and refresh tokens are never returned in JSON."""
    _, emp_headers = employee_auth_headers

    # 1. Profile /me
    me_resp = await async_client.get("/api/v1/auth/me", headers=emp_headers)
    assert me_resp.status_code == 200
    me_text = me_resp.text
    assert "password_hash" not in me_text
    assert "password" not in me_resp.json()["data"]

    # 2. Admin User Directory
    users_resp = await async_client.get("/api/v1/employees", headers=admin_auth_headers)
    assert users_resp.status_code == 200
    users_text = users_resp.text
    assert "password_hash" not in users_text
    assert "argon2" not in users_text
    assert "bcrypt" not in users_text


@pytest.mark.asyncio
async def test_idor_prevention_cross_user_leave_cancellation(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Verifies that an employee without admin permissions cannot cancel another user's leave."""
    import datetime

    from sqlalchemy import select

    from app.models.leave import LeaveRequest, LeaveType
    from app.utils.timezone import get_local_today

    emp, emp_headers = employee_auth_headers
    today = get_local_today()

    casual_type = (
        await db_session.execute(select(LeaveType).where(LeaveType.name == "Casual Leave"))
    ).scalar_one()

    # Create a separate user's leave request
    leave_date = today + datetime.timedelta(days=20)
    while leave_date.weekday() >= 5:
        leave_date += datetime.timedelta(days=1)

    other_user_leave = LeaveRequest(
        user_id=emp.id,  # Owned by emp
        leave_type_id=casual_type.id,
        from_date=leave_date,
        to_date=leave_date,
        is_half_day=False,
        total_days=1.0,
        status="pending",
        reason="Personal matter",
    )
    db_session.add(other_user_leave)
    await db_session.commit()

    # Now create another employee without leave.manage_types or leave.approve
    from app.core.security import create_access_token, hash_password
    from app.models.rbac import Role

    dev_role = (
        await db_session.execute(select(Role).where(Role.name == "Website development"))
    ).scalar_one()
    other_emp = User(
        employee_code="DEV-0099",
        email="dev.other@agency.com",
        full_name="Other Developer",
        password_hash=hash_password("DevSecret123!#"),
        role_id=dev_role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(other_emp)
    await db_session.commit()

    other_token = create_access_token(user_id=str(other_emp.id), role="Website development")
    other_headers = {"Authorization": f"Bearer {other_token}"}

    # Other employee attempts to cancel emp's leave request
    cancel_resp = await async_client.post(
        f"/api/v1/leaves/{other_user_leave.id}/cancel", headers=other_headers
    )
    # Must be forbidden or rejected as not owner
    assert cancel_resp.status_code in (400, 403, 404)
