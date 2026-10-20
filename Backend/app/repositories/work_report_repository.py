from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from sqlalchemy import and_, desc, func, select
from sqlalchemy.orm import selectinload

from app.models.base import utc_now
from app.models.user import User
from app.models.work_report import WorkReport, WorkReportItem, WorkReportStatus

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession


class WorkReportRepository:
    """Data access and query repository for employee daily work reports and timesheet items."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    def _base_report_query(self) -> Any:
        return select(WorkReport).options(
            selectinload(WorkReport.user).selectinload(User.department),
            selectinload(WorkReport.reviewer),
            selectinload(WorkReport.items).selectinload(WorkReportItem.task),
            selectinload(WorkReport.items).selectinload(WorkReportItem.client),
            selectinload(WorkReport.items).selectinload(WorkReportItem.project),
        )

    async def get_by_id(self, report_id: uuid.UUID) -> WorkReport | None:
        stmt = self._base_report_query().where(WorkReport.id == report_id)
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_by_user_and_date(
        self,
        user_id: uuid.UUID,
        report_date: datetime.date,
    ) -> WorkReport | None:
        stmt = self._base_report_query().where(
            and_(WorkReport.user_id == user_id, WorkReport.report_date == report_date)
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def create_report(
        self,
        user_id: uuid.UUID,
        report_date: datetime.date,
        summary: str | None = None,
        items: list[dict[str, Any]] | None = None,
    ) -> WorkReport:
        report = WorkReport(
            user_id=user_id,
            report_date=report_date,
            summary=summary,
            status=WorkReportStatus.DRAFT.value,
        )
        self.session.add(report)
        await self.session.flush()

        if items:
            for itm in items:
                item_obj = WorkReportItem(
                    report_id=report.id,
                    task_id=itm.get("task_id"),
                    client_id=itm.get("client_id"),
                    project_id=itm.get("project_id"),
                    category_id=itm.get("category_id"),
                    description=itm["description"],
                    minutes_spent=itm["minutes_spent"],
                )
                self.session.add(item_obj)
            await self.session.flush()

        # Re-fetch with relationships loaded
        return (await self.get_by_id(report.id)) or report

    async def update_report(
        self,
        report: WorkReport,
        summary: str | None = None,
        items: list[dict[str, Any]] | None = None,
    ) -> WorkReport:
        if summary is not None:
            report.summary = summary

        if items is not None:
            # Clear existing items and insert new ones
            report.items.clear()
            for itm in items:
                item_obj = WorkReportItem(
                    report_id=report.id,
                    task_id=itm.get("task_id"),
                    client_id=itm.get("client_id"),
                    project_id=itm.get("project_id"),
                    category_id=itm.get("category_id"),
                    description=itm["description"],
                    minutes_spent=itm["minutes_spent"],
                )
                report.items.append(item_obj)
            await self.session.flush()

        return report

    async def submit_report(self, report: WorkReport) -> WorkReport:
        report.status = WorkReportStatus.SUBMITTED.value
        report.submitted_at = utc_now()
        await self.session.flush()
        return (await self.get_by_id(report.id)) or report

    async def review_report(
        self,
        report: WorkReport,
        reviewer_id: uuid.UUID,
        review_note: str,
        status: str = WorkReportStatus.REVIEWED.value,
    ) -> WorkReport:
        report.status = status
        report.reviewed_by = reviewer_id
        report.reviewed_at = utc_now()
        report.review_note = review_note
        await self.session.flush()
        return (await self.get_by_id(report.id)) or report

    async def list_user_reports(
        self,
        user_id: uuid.UUID,
        from_date: datetime.date | None = None,
        to_date: datetime.date | None = None,
        status: str | None = None,
        page: int = 1,
        page_size: int = 20,
    ) -> tuple[list[WorkReport], int]:
        filters = [WorkReport.user_id == user_id]
        if from_date:
            filters.append(WorkReport.report_date >= from_date)
        if to_date:
            filters.append(WorkReport.report_date <= to_date)
        if status:
            filters.append(WorkReport.status == status)

        count_stmt = select(func.count(WorkReport.id)).where(and_(*filters))
        count_res = await self.session.execute(count_stmt)
        total = count_res.scalar_one()

        offset = (page - 1) * page_size
        stmt = (
            self._base_report_query()
            .where(and_(*filters))
            .order_by(desc(WorkReport.report_date), desc(WorkReport.created_at))
            .offset(offset)
            .limit(page_size)
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    async def list_reports(
        self,
        user_ids: list[uuid.UUID] | None = None,
        department_id: uuid.UUID | None = None,
        from_date: datetime.date | None = None,
        to_date: datetime.date | None = None,
        status: str | None = None,
        page: int = 1,
        page_size: int = 20,
    ) -> tuple[list[WorkReport], int]:
        filters: list[Any] = []

        if user_ids is not None:
            filters.append(WorkReport.user_id.in_(user_ids))

        if department_id:
            filters.append(WorkReport.user.has(User.department_id == department_id))

        if from_date:
            filters.append(WorkReport.report_date >= from_date)

        if to_date:
            filters.append(WorkReport.report_date <= to_date)

        if status:
            filters.append(WorkReport.status == status)

        count_stmt = select(func.count(WorkReport.id)).where(and_(*filters) if filters else True)
        count_res = await self.session.execute(count_stmt)
        total = count_res.scalar_one()

        offset = (page - 1) * page_size
        stmt = (
            self._base_report_query()
            .where(and_(*filters) if filters else True)
            .order_by(desc(WorkReport.report_date), desc(WorkReport.created_at))
            .offset(offset)
            .limit(page_size)
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    async def get_missing_reports(
        self,
        report_date: datetime.date,
        department_id: uuid.UUID | None = None,
    ) -> list[User]:
        """Returns active employees who do NOT have a submitted or reviewed report for report_date."""
        # Find user IDs that have submitted or reviewed reports for report_date
        submitted_subquery = (
            select(WorkReport.user_id)
            .where(
                and_(
                    WorkReport.report_date == report_date,
                    WorkReport.status.in_([
                        WorkReportStatus.SUBMITTED.value,
                        WorkReportStatus.REVIEWED.value,
                    ]),
                )
            )
            .scalar_subquery()
        )

        user_filters = [
            User.is_active.is_(True),
            User.is_deleted.is_(False),
            User.id.not_in(submitted_subquery),
        ]

        if department_id:
            user_filters.append(User.department_id == department_id)

        stmt = (
            select(User)
            .options(
                selectinload(User.department),
                selectinload(User.manager),
            )
            .where(and_(*user_filters))
            .order_by(User.full_name.asc())
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())
