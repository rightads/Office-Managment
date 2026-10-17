from __future__ import annotations

from pydantic import BaseModel, Field


class RowError(BaseModel):
    """Specific error identified in a CSV row."""

    row: int = Field(..., description="1-indexed row number in the CSV file")
    field: str = Field(..., description="Target column or field name")
    error: str = Field(..., description="Detailed validation error message")
    value: str | None = Field(default=None, description="Invalid value provided in row")


class BulkImportReport(BaseModel):
    """Validation report and execution summary for bulk employee imports."""

    total_rows: int = Field(..., description="Total rows parsed from CSV")
    successful_imports: int = Field(
        ..., description="Number of successfully validated/created employees"
    )
    failed_rows: int = Field(..., description="Number of rows with validation errors")
    dry_run: bool = Field(..., description="Whether this was a validation dry-run")
    errors: list[RowError] = Field(default_factory=list, description="Row-level validation errors")
