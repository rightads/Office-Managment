from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from sqlalchemy import Float, String, func, or_, select
from sqlalchemy.orm import selectinload

from app.models.dynamic_module import (
    ModuleDefinition,
    ModuleField,
    ModuleRecord,
    ModuleRecordActivity,
    ModuleRecordAttachment,
    ModuleRecordComment,
    ModuleStatus,
)
from app.models.user import User

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession


class DynamicModuleRepository:
    """Repository handling SQL persistence for dynamic module schemas, records, and timeline."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    async def get_definition_by_code(self, code: str) -> ModuleDefinition | None:
        stmt = (
            select(ModuleDefinition)
            .where(func.lower(ModuleDefinition.code) == code.lower().strip())
            .options(
                selectinload(ModuleDefinition.fields),
                selectinload(ModuleDefinition.statuses),
                selectinload(ModuleDefinition.transitions),
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_definition_by_id(self, definition_id: uuid.UUID) -> ModuleDefinition | None:
        stmt = (
            select(ModuleDefinition)
            .where(ModuleDefinition.id == definition_id)
            .options(
                selectinload(ModuleDefinition.fields),
                selectinload(ModuleDefinition.statuses),
                selectinload(ModuleDefinition.transitions),
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_definitions(self, active_only: bool = True) -> list[ModuleDefinition]:
        stmt = select(ModuleDefinition).options(
            selectinload(ModuleDefinition.fields),
            selectinload(ModuleDefinition.statuses),
            selectinload(ModuleDefinition.transitions),
        )
        if active_only:
            stmt = stmt.where(ModuleDefinition.is_active.is_(True))
        stmt = stmt.order_by(ModuleDefinition.label)
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def create_definition(self, definition: ModuleDefinition) -> ModuleDefinition:
        self.session.add(definition)
        await self.session.flush()
        return definition

    async def get_field_by_id(self, field_id: uuid.UUID) -> ModuleField | None:
        stmt = select(ModuleField).where(ModuleField.id == field_id)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def count_records_using_field(self, module_id: uuid.UUID, field_key: str) -> int:
        """Checks if any non-deleted records have a non-null/non-empty value for [field_key]."""
        stmt = (
            select(func.count(ModuleRecord.id))
            .where(
                ModuleRecord.module_id == module_id,
                ModuleRecord.is_deleted.is_(False),
                ModuleRecord.data[field_key].is_not(None),
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar() or 0

    async def get_record_by_id(
        self,
        record_id: uuid.UUID,
        include_details: bool = True,
    ) -> ModuleRecord | None:
        stmt = select(ModuleRecord).where(
            ModuleRecord.id == record_id,
            ModuleRecord.is_deleted.is_(False),
        )
        if include_details:
            stmt = stmt.options(
                selectinload(ModuleRecord.status),
                selectinload(ModuleRecord.creator),
                selectinload(ModuleRecord.assignee),
                selectinload(ModuleRecord.client),
                selectinload(ModuleRecord.comments).selectinload(ModuleRecordComment.user),
                selectinload(ModuleRecord.attachments).selectinload(ModuleRecordAttachment.user),
                selectinload(ModuleRecord.activities).selectinload(ModuleRecordActivity.user),
            )
        else:
            stmt = stmt.options(
                selectinload(ModuleRecord.status),
                selectinload(ModuleRecord.creator),
                selectinload(ModuleRecord.assignee),
                selectinload(ModuleRecord.client),
            )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_records(
        self,
        module_id: uuid.UUID,
        user: User,
        permissions: set[str],
        module_code: str,
        page: int = 1,
        page_size: int = 20,
        search: str | None = None,
        status_id: uuid.UUID | None = None,
        status_code: str | None = None,
        assigned_to: uuid.UUID | None = None,
        client_id: uuid.UUID | None = None,
        from_date: datetime.date | None = None,
        to_date: datetime.date | None = None,
        sort_by: str | None = None,
        sort_desc: bool = True,
        searchable_fields: list[str] | None = None,
        dynamic_filters: dict[str, Any] | None = None,
    ) -> tuple[list[ModuleRecord], int]:
        stmt = select(ModuleRecord).where(
            ModuleRecord.module_id == module_id,
            ModuleRecord.is_deleted.is_(False),
        )

        # 1. Role-based Scope Filtering
        has_view_all = "*" in permissions or "modules.manage" in permissions or f"module.{module_code}.view_all" in permissions
        has_view_team = f"module.{module_code}.view_team" in permissions
        has_view_own = f"module.{module_code}.view_own" in permissions or f"module.{module_code}.create" in permissions

        if not has_view_all:
            if has_view_team and user.department_id:
                # Team scope: created by or assigned to users in the same department
                dept_users_stmt = select(User.id).where(User.department_id == user.department_id)
                stmt = stmt.where(
                    or_(
                        ModuleRecord.created_by.in_(dept_users_stmt),
                        ModuleRecord.assigned_to.in_(dept_users_stmt),
                    )
                )
            elif has_view_own:
                # Own scope
                stmt = stmt.where(
                    or_(
                        ModuleRecord.created_by == user.id,
                        ModuleRecord.assigned_to == user.id,
                    )
                )

        # 2. Status filtering
        if status_id:
            stmt = stmt.where(ModuleRecord.status_id == status_id)
        elif status_code:
            status_stmt = select(ModuleStatus.id).where(
                ModuleStatus.module_id == module_id,
                func.lower(ModuleStatus.code) == status_code.lower().strip(),
            )
            stmt = stmt.where(ModuleRecord.status_id.in_(status_stmt))

        # 3. Assignee and Client filtering
        if assigned_to:
            stmt = stmt.where(ModuleRecord.assigned_to == assigned_to)
        if client_id:
            stmt = stmt.where(ModuleRecord.client_id == client_id)

        # 4. Date filtering
        if from_date:
            stmt = stmt.where(
                func.coalesce(ModuleRecord.due_at, ModuleRecord.created_at)
                >= datetime.datetime.combine(from_date, datetime.time.min, tzinfo=datetime.timezone.utc)
            )
        if to_date:
            stmt = stmt.where(
                func.coalesce(ModuleRecord.due_at, ModuleRecord.created_at)
                <= datetime.datetime.combine(to_date, datetime.time.max, tzinfo=datetime.timezone.utc)
            )

        # 5. Search across marked searchable fields
        if search and search.strip() and searchable_fields:
            search_pattern = f"%{search.strip().lower()}%"
            search_conditions = []
            for field_key in searchable_fields:
                search_conditions.append(
                    func.lower(func.cast(ModuleRecord.data[field_key], String)).like(search_pattern)
                )
            if search_conditions:
                stmt = stmt.where(or_(*search_conditions))

        # 6. Dynamic field filtering
        if dynamic_filters:
            for k, val in dynamic_filters.items():
                if val is not None and str(val).strip():
                    stmt = stmt.where(ModuleRecord.data[k] == val)

        # 7. Total count
        count_stmt = select(func.count()).select_from(stmt.subquery())
        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar() or 0

        # 8. Sorting
        order_col = ModuleRecord.created_at.desc() if sort_desc else ModuleRecord.created_at.asc()
        if sort_by:
            if sort_by in ("due_at", "updated_at", "created_at"):
                col_attr = getattr(ModuleRecord, sort_by)
                order_col = col_attr.desc() if sort_desc else col_attr.asc()
            else:
                # JSON data field
                json_expr = ModuleRecord.data[sort_by]
                order_col = json_expr.desc() if sort_desc else json_expr.asc()

        stmt = stmt.order_by(order_col)
        stmt = stmt.offset((page - 1) * page_size).limit(page_size)
        stmt = stmt.options(
            selectinload(ModuleRecord.status),
            selectinload(ModuleRecord.creator),
            selectinload(ModuleRecord.assignee),
            selectinload(ModuleRecord.client),
        )

        records_res = await self.session.execute(stmt)
        records = list(records_res.scalars().all())
        return records, total

    async def get_summary(
        self,
        module: ModuleDefinition,
        currency_or_number_fields: list[str],
    ) -> dict[str, Any]:
        """Calculates aggregate metrics (counts by status, counts by assignee, and field totals) in SQL."""
        base_filter = [
            ModuleRecord.module_id == module.id,
            ModuleRecord.is_deleted.is_(False),
        ]

        # Total count
        total_stmt = select(func.count(ModuleRecord.id)).where(*base_filter)
        total_count = (await self.session.execute(total_stmt)).scalar() or 0

        # Counts by status
        status_stmt = (
            select(ModuleStatus.code, func.count(ModuleRecord.id))
            .join(ModuleRecord, ModuleRecord.status_id == ModuleStatus.id)
            .where(*base_filter)
            .group_by(ModuleStatus.code)
        )
        status_res = await self.session.execute(status_stmt)
        counts_by_status = {row[0]: row[1] for row in status_res.all()}

        # Counts by assignee
        assignee_stmt = (
            select(
                ModuleRecord.assigned_to,
                User.full_name,
                func.count(ModuleRecord.id),
            )
            .outerjoin(User, ModuleRecord.assigned_to == User.id)
            .where(*base_filter, ModuleRecord.assigned_to.is_not(None))
            .group_by(ModuleRecord.assigned_to, User.full_name)
        )
        assignee_res = await self.session.execute(assignee_stmt)
        counts_by_assignee = [
            {
                "assignee_id": str(row[0]),
                "assignee_name": row[1] if row[1] else "Unassigned",
                "count": row[2],
            }
            for row in assignee_res.all()
        ]

        # Field totals for numeric / currency fields
        field_totals: dict[str, float] = {}
        for f_key in currency_or_number_fields:
            # Cast JSON string to float
            sum_stmt = select(
                func.sum(func.cast(func.cast(ModuleRecord.data[f_key], String), Float))
            ).where(*base_filter, ModuleRecord.data[f_key].is_not(None))
            try:
                val = (await self.session.execute(sum_stmt)).scalar()
                field_totals[f_key] = float(val or 0.0)
            except Exception:
                field_totals[f_key] = 0.0

        return {
            "total_records": total_count,
            "counts_by_status": counts_by_status,
            "counts_by_assignee": counts_by_assignee,
            "field_totals": field_totals,
        }
