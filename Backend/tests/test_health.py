from __future__ import annotations

import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_health_endpoint(async_client: AsyncClient) -> None:
    """Verify /health returns 200 with standard structure and healthy DB."""
    response = await async_client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "ok"
    assert data["environment"] == "testing"
    assert "timestamp" in data
    assert "components" in data
    assert data["components"]["database"]["status"] == "reachable"


@pytest.mark.asyncio
async def test_api_v1_health_endpoint(async_client: AsyncClient) -> None:
    """Verify /api/v1/health also works identically."""
    response = await async_client.get("/api/v1/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "ok"
