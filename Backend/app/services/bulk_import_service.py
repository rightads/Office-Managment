from __future__ import annotations

import csv
import io
import re
import uuid

from fastapi import Request
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.attendance import AttendancePolicy
from app.models.organization import Department
from app.models.rbac import Role
from app.models.user import User
from app.repositories.employee_repository import EmployeeRepository
from app.schemas.bulk_import import BulkImportReport, RowError
from app.schemas.employee import EmployeeCreate
from app.services.employee_service import EmployeeService

EMAIL_REGEX = re.compile(r"^[\w\.-]+@[\w\.-]+\.\w+$")


class BulkImportService:
    """Service validating and importing employee rosters from CSV files."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.employee_service = EmployeeService(session)
        self.employee_repo = EmployeeRepository(session)

    async def import_employees_csv(
        self,
        csv_content: str,
        actor_id: uuid.UUID,
        dry_run: bool = False,
        request: Request | None = None,
    ) -> BulkImportReport:
        """
        Parses CSV, performs row-level validation, checks database integrity,
        and provisions employees if validation passes.
        """
        f = io.StringIO(csv_content.strip())
        reader = csv.DictReader(f)

        if not reader.fieldnames:
            return BulkImportReport(
                total_rows=0,
                successful_imports=0,
                failed_rows=0,
                dry_run=dry_run,
                errors=[
                    RowError(row=0, field="file", error="CSV file is empty or missing headers.")
                ],
            )

        # Standardize field names
        field_names = [fn.strip().lower() for fn in reader.fieldnames if fn]
        required_cols = {"email", "full_name", "role"}
        missing_cols = required_cols - set(field_names)
        if missing_cols:
            return BulkImportReport(
                total_rows=0,
                successful_imports=0,
                failed_rows=0,
                dry_run=dry_run,
                errors=[
                    RowError(
                        row=0,
                        field="header",
                        error=f"Missing required columns: {', '.join(sorted(missing_cols))}",
                    )
                ],
            )

        # Pre-load reference maps for fast validation
        all_roles_res = await self.session.execute(select(Role))
        roles_by_name = {r.name.lower().strip(): r for r in all_roles_res.scalars().all()}

        all_depts_res = await self.session.execute(select(Department))
        depts_by_name = {d.name.lower().strip(): d for d in all_depts_res.scalars().all()}

        all_pols_res = await self.session.execute(select(AttendancePolicy))
        pols_by_name = {p.name.lower().strip(): p for p in all_pols_res.scalars().all()}

        errors: list[RowError] = []
        valid_rows: list[tuple[int, EmployeeCreate]] = []
        seen_emails: set[str] = set()

        for idx, row in enumerate(reader, start=1):
            # Clean dictionary keys
            clean_row = {
                k.strip().lower(): v.strip() for k, v in row.items() if k and v is not None
            }
            row_has_error = False

            # 1. Validate email
            email_val = clean_row.get("email", "")
            if not email_val:
                errors.append(RowError(row=idx, field="email", error="Email is required."))
                row_has_error = True
            elif not EMAIL_REGEX.match(email_val):
                errors.append(
                    RowError(row=idx, field="email", error="Invalid email format.", value=email_val)
                )
                row_has_error = True
            elif email_val.lower() in seen_emails:
                errors.append(
                    RowError(
                        row=idx,
                        field="email",
                        error="Duplicate email within the same CSV upload.",
                        value=email_val,
                    )
                )
                row_has_error = True
            else:
                # Check DB duplicate
                stmt_email = select(User).where(func.lower(User.email) == email_val.lower())
                if (await self.session.execute(stmt_email)).scalar_one_or_none():
                    errors.append(
                        RowError(
                            row=idx,
                            field="email",
                            error=f"Email '{email_val}' already exists in database.",
                            value=email_val,
                        )
                    )
                    row_has_error = True
                else:
                    seen_emails.add(email_val.lower())

            # 2. Validate full_name
            full_name_val = clean_row.get("full_name", "")
            if not full_name_val or len(full_name_val) < 2:
                errors.append(
                    RowError(
                        row=idx,
                        field="full_name",
                        error="Full name is required and must be at least 2 characters.",
                        value=full_name_val,
                    )
                )
                row_has_error = True

            # 3. Validate role
            role_val = clean_row.get("role", "")
            role_obj = roles_by_name.get(role_val.lower()) if role_val else None
            if not role_val:
                errors.append(RowError(row=idx, field="role", error="Role is required."))
                row_has_error = True
            elif not role_obj:
                errors.append(
                    RowError(
                        row=idx,
                        field="role",
                        error=f"Role '{role_val}' does not exist.",
                        value=role_val,
                    )
                )
                row_has_error = True

            # 4. Validate department (optional)
            dept_val = clean_row.get("department")
            dept_obj = None
            if dept_val:
                dept_obj = depts_by_name.get(dept_val.lower())
                if not dept_obj:
                    errors.append(
                        RowError(
                            row=idx,
                            field="department",
                            error=f"Department '{dept_val}' does not exist.",
                            value=dept_val,
                        )
                    )
                    row_has_error = True

            # 5. Validate attendance policy (optional)
            pol_val = clean_row.get("attendance_policy")
            pol_obj = None
            if pol_val:
                pol_obj = pols_by_name.get(pol_val.lower())
                if not pol_obj:
                    errors.append(
                        RowError(
                            row=idx,
                            field="attendance_policy",
                            error=f"Attendance policy '{pol_val}' does not exist.",
                            value=pol_val,
                        )
                    )
                    row_has_error = True

            # 6. Validate manager email (optional)
            mgr_email = clean_row.get("manager_email")
            mgr_id: uuid.UUID | None = None
            if mgr_email:
                stmt_mgr = select(User).where(func.lower(User.email) == mgr_email.lower())
                mgr = (await self.session.execute(stmt_mgr)).scalar_one_or_none()
                if not mgr:
                    errors.append(
                        RowError(
                            row=idx,
                            field="manager_email",
                            error=f"Manager with email '{mgr_email}' not found.",
                            value=mgr_email,
                        )
                    )
                    row_has_error = True
                else:
                    mgr_id = mgr.id

            if not row_has_error and role_obj:
                valid_rows.append(
                    (
                        idx,
                        EmployeeCreate(
                            email=email_val,
                            full_name=full_name_val,
                            role_id=role_obj.id,
                            department_id=dept_obj.id if dept_obj else None,
                            attendance_policy_id=pol_obj.id if pol_obj else None,
                            manager_id=mgr_id,
                            phone_number=clean_row.get("phone_number"),
                            designation=clean_row.get("designation"),
                        ),
                    )
                )

        total_rows = len(valid_rows) + len({e.row for e in errors if e.row > 0})
        failed_count = len({e.row for e in errors if e.row > 0})

        # If dry run or errors exist, don't write to DB
        if dry_run or errors:
            return BulkImportReport(
                total_rows=total_rows,
                successful_imports=len(valid_rows) if not errors else 0,
                failed_rows=failed_count,
                dry_run=dry_run,
                errors=errors,
            )

        # Batch creation
        for _row_idx, emp_payload in valid_rows:
            await self.employee_service.create_employee(
                payload=emp_payload,
                actor_id=actor_id,
                request=request,
            )

        return BulkImportReport(
            total_rows=total_rows,
            successful_imports=len(valid_rows),
            failed_rows=0,
            dry_run=False,
            errors=[],
        )
