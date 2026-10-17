from __future__ import annotations

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.user import User


@pytest.mark.asyncio
async def test_bulk_import_successful(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test importing multiple employees successfully using agency roles."""
    csv_data = (
        "email,full_name,role,department,phone_number,designation\n"
        "sara.sales@agency.com,Sara Sales,Tele sales,Tele sales,+1112223333,Sales Rep\n"
        "mark.dev@agency.com,Mark Web,Website development,Website Development,+1444555666,Frontend Dev\n"
        "lisa.gmb@agency.com,Lisa Local,GMB,GMB,+1777888999,GMB Specialist\n"
    )

    files = {"file": ("employees.csv", csv_data.encode("utf-8"), "text/csv")}
    res = await async_client.post(
        "/api/v1/employees/bulk-import?dry_run=false",
        files=files,
        headers=admin_auth_headers,
    )
    assert res.status_code == 200
    report = res.json()
    assert report["total_rows"] == 3
    assert report["successful_imports"] == 3
    assert report["failed_rows"] == 0
    assert len(report["errors"]) == 0

    # Verify users exist in DB
    u1 = (
        await db_session.execute(select(User).where(User.email == "sara.sales@agency.com"))
    ).scalar_one_or_none()
    assert u1 is not None
    assert u1.full_name == "Sara Sales"
    assert u1.employee_code.startswith("EMP-")


@pytest.mark.asyncio
async def test_bulk_import_validation_errors(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
) -> None:
    """Test row-level error reporting for invalid emails, non-existent roles, and duplicates."""
    csv_data = (
        "email,full_name,role,department\n"
        "invalid-email-address,Bad User,Tele sales,Tele sales\n"
        "valid.user@agency.com,Valid User,NonExistentRole123,Tele sales\n"
        "dup.user@agency.com,Dup One,SEO,SEO\n"
        "dup.user@agency.com,Dup Two,SEO,SEO\n"
    )

    files = {"file": ("employees.csv", csv_data.encode("utf-8"), "text/csv")}
    res = await async_client.post(
        "/api/v1/employees/bulk-import",
        files=files,
        headers=admin_auth_headers,
    )
    assert res.status_code == 200
    report = res.json()
    assert report["failed_rows"] >= 3
    assert report["successful_imports"] == 0
    assert len(report["errors"]) >= 3

    error_fields = {e["field"] for e in report["errors"]}
    assert "email" in error_fields
    assert "role" in error_fields


@pytest.mark.asyncio
async def test_bulk_import_dry_run(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    db_session: AsyncSession,
) -> None:
    """Test dry_run mode returns validation report without writing records to DB."""
    csv_data = "email,full_name,role\ndryrun.user@agency.com,Dry Run Employee,CSD\n"

    files = {"file": ("employees.csv", csv_data.encode("utf-8"), "text/csv")}
    res = await async_client.post(
        "/api/v1/employees/bulk-import?dry_run=true",
        files=files,
        headers=admin_auth_headers,
    )
    assert res.status_code == 200
    report = res.json()
    assert report["dry_run"] is True
    assert report["successful_imports"] == 1
    assert report["failed_rows"] == 0

    # Verify record was NOT created in DB
    user = (
        await db_session.execute(select(User).where(User.email == "dryrun.user@agency.com"))
    ).scalar_one_or_none()
    assert user is None
