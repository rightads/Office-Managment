"""
Utility script to export the current OpenAPI schema to JSON.
Used for API documentation, Postman collection imports, and frontend client generation.
"""

from __future__ import annotations

import json
import os
import sys
from pathlib import Path

# Ensure Backend root is on sys.path
backend_dir = Path(__file__).resolve().parent.parent
if str(backend_dir) not in sys.path:
    sys.path.insert(0, str(backend_dir))

if "DATABASE_URL" not in os.environ:
    os.environ["DATABASE_URL"] = (
        "postgresql+asyncpg://postgres:postgres@localhost:5432/right_ads_db"
    )
if "JWT_SECRET_KEY" not in os.environ:
    os.environ["JWT_SECRET_KEY"] = "this_is_a_default_secret_key_for_openapi_export_32_chars"

from app.main import app  # noqa: E402


def export_openapi() -> None:
    schema = app.openapi()
    docs_dir = Path(__file__).resolve().parent.parent / "docs"
    docs_dir.mkdir(parents=True, exist_ok=True)
    target_file = docs_dir / "openapi.json"

    with open(target_file, "w", encoding="utf-8") as f:
        json.dump(schema, f, indent=2)

    total_paths = len(schema.get("paths", {}))
    total_endpoints = sum(len(methods) for methods in schema.get("paths", {}).values())

    print(f"Successfully exported OpenAPI specification to: {target_file}")
    print(
        f"Summary: {total_paths} paths, {total_endpoints} operations, {len(schema.get('tags', []))} tags."
    )


if __name__ == "__main__":
    export_openapi()
