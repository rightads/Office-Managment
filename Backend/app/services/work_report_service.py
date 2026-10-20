from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from fastapi import Request
from sqlalchemy import inspect, select

from app.core.exceptions import (
    BadRequestException,
    ForbiddenException,
    NotFoundException,
)
from app.models.system import SystemSetting
from app.models.user import User
from app.models.work_report import WorkReport, WorkReportStatus
from app.repositories.user_repository import UserRepository
from app.repositories.work_report_repository import WorkReportRepository
from app.schemas.work_report import (
    MissingWorkReportListResponse,
    MissingWorkReportUserResponse,
    WorkReportCreate,
    WorkReportItemResponse,
    WorkReportPageResponse,
    WorkReportResponse,
    WorkReportReviewRequest,
    WorkReportUpdate,
)
from app.services.audit_service import AuditService
from app.services.notification_service import NotificationService
from app.utils.timezone import get_local_today

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession


class WorkReportService:
    """Business service governing daily work reports, timesheets, validations, and notifications."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.repo = WorkReportRepository(session)
        self.user_repo = UserRepository(session)

    async def _has_permission(self, user: User, perm: str) -> bool:
        perms = await self.user_repo.get_user_permissions(user)
        return "*" in perms or perm in perms

    async def _get_system_setting(self, key: str, default: Any) -> Any:
        stmt = select(SystemSetting.value).where(SystemSetting.key == key)
        res = await self.session.execute(stmt)
        val = res.scalar_one_or_none()
        return val if val is not None else default

    def _serialize_report(
        self,
        report: WorkReport,
        reviewer_override: User | None = None,
    ) -> WorkReportResponse:
        rep_insp = inspect(report)
        items_resp: list[WorkReportItemResponse] = []
        if "items" not in rep_insp.unloaded:
            for itm in report.items:
                itm_insp = inspect(itm)
                task_title = (
                    itm.task.title
                    if ("task" not in itm_insp.unloaded and itm.task is not None)
                    else None
                )
                client_name = (
                    itm.client.name
                    if ("client" not in itm_insp.unloaded and itm.client is not None)
                    else None
                )
                project_name = (
                    itm.project.name
                    if ("project" not in itm_insp.unloaded and itm.project is not None)
                    else None
                )
                items_resp.append(
                    WorkReportItemResponse(
                        id=itm.id,
                        report_id=itm.report_id,
                        task_id=itm.task_id,
                        task_title=task_title,
                        client_id=itm.client_id,
                        client_name=client_name,
                        project_id=itm.project_id,
                        project_name=project_name,
                        category_id=itm.category_id,
                        description=itm.description,
                        minutes_spent=itm.minutes_spent,
                        created_at=itm.created_at,
                    )
                )

        user = report.user if "user" not in rep_insp.unloaded else None
        dept_name = None
        if user and "department" not in inspect(user).unloaded and user.department:
            dept_name = user.department.name

        reviewer = reviewer_override or (
            report.reviewer if "reviewer" not in rep_insp.unloaded else None
        )

        return WorkReportResponse(
            id=report.id,
            user_id=report.user_id,
            user_full_name=user.full_name if user else None,
            user_employee_code=user.employee_code if user else None,
            department_id=user.department_id if user else None,
            department_name=dept_name,
            report_date=report.report_date,
            summary=report.summary,
            status=report.status,
            total_minutes=(
                sum(i.minutes_spent for i in report.items)
                if "items" not in rep_insp.unloaded
                else 0
            ),
            submitted_at=report.submitted_at,
            reviewed_by=report.reviewed_by or (reviewer.id if reviewer else None),
            reviewer_name=reviewer.full_name if reviewer else None,
            reviewed_at=report.reviewed_at,
            review_note=report.review_note,
            items=items_resp,
            created_at=report.created_at,
            updated_at=report.updated_at,
        )

    async def create_or_save_draft(
        self,
        user: User,
        payload: WorkReportCreate,
        request: Request | None = None,
    ) -> WorkReportResponse:
        today = get_local_today()

        # Rule 1: Future dates blocked
        if payload.report_date > today:
            raise BadRequestException("Cannot create or submit work reports for future dates.")

        # Rule 2: Editable window check
        window_days = int(
            await self._get_system_setting("work_report_editable_window_days", 7)
        )
        if (today - payload.report_date).days > window_days:
            raise BadRequestException(
                f"Work reports older than {window_days} days can no longer be created or edited."
            )

        # Rule 3: Max minutes per day check
        max_minutes = int(
            await self._get_system_setting("work_report_max_minutes_per_day", 960)
        )
        items_dicts = [i.model_dump() for i in payload.items]
        total_mins = sum(i["minutes_spent"] for i in items_dicts)
        if total_mins > max_minutes:
            raise BadRequestException(
                f"Total logged time ({total_mins} minutes) exceeds maximum allowed per day ({max_minutes} minutes)."
            )

        # Check existing report for user on this date
        existing = await self.repo.get_by_user_and_date(user.id, payload.report_date)
        if existing:
            if existing.status == WorkReportStatus.REVIEWED.value:
                raise BadRequestException(
                    "This work report has already been reviewed and cannot be edited."
                )
            if existing.status == WorkReportStatus.SUBMITTED.value:
                allow_edit = bool(
                    await self._get_system_setting(
                        "work_report_allow_edit_until_reviewed", False
                    )
                )
                if not allow_edit:
                    raise BadRequestException(
                        "This work report has already been submitted and cannot be edited."
                    )

            # Update existing report
            old_data = {"summary": existing.summary, "total_minutes": existing.total_minutes}
            updated = await self.repo.update_report(
                existing,
                summary=payload.summary,
                items=items_dicts,
            )
            await self.session.commit()

            await AuditService.record(
                self.session,
                action="UPDATE",
                entity_type="WORK_REPORT",
                entity_id=updated.id,
                actor_id=user.id,
                old_data=old_data,
                new_data={"summary": updated.summary, "total_minutes": updated.total_minutes},
                request=request,
            )
            await self.session.commit()
            return self._serialize_report(updated)

        # Create new report
        report = await self.repo.create_report(
            user_id=user.id,
            report_date=payload.report_date,
            summary=payload.summary,
            items=items_dicts,
        )
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="WORK_REPORT",
            entity_id=report.id,
            actor_id=user.id,
            new_data={"summary": report.summary, "total_minutes": report.total_minutes},
            request=request,
        )
        await self.session.commit()
        return self._serialize_report(report)

    async def update_report(
        self,
        user: User,
        report_id: uuid.UUID,
        payload: WorkReportUpdate,
        request: Request | None = None,
    ) -> WorkReportResponse:
        report = await self.repo.get_by_id(report_id)
        if not report:
            raise NotFoundException(f"Work report with ID '{report_id}' not found.")

        if report.user_id != user.id:
            raise ForbiddenException("You cannot edit another employee's work report.")

        if report.status == WorkReportStatus.REVIEWED.value:
            raise BadRequestException("This work report has already been reviewed and cannot be edited.")

        if report.status == WorkReportStatus.SUBMITTED.value:
            allow_edit = bool(
                await self._get_system_setting(
                    "work_report_allow_edit_until_reviewed", False
                )
            )
            if not allow_edit:
                raise BadRequestException("This work report has already been submitted and cannot be edited.")

        today = get_local_today()
        window_days = int(
            await self._get_system_setting("work_report_editable_window_days", 7)
        )
        if (today - report.report_date).days > window_days:
            raise BadRequestException(
                f"Work reports older than {window_days} days can no longer be edited."
            )

        items_dicts = [i.model_dump() for i in payload.items] if payload.items is not None else None
        if items_dicts is not None:
            max_minutes = int(
                await self._get_system_setting("work_report_max_minutes_per_day", 960)
            )
            total_mins = sum(i["minutes_spent"] for i in items_dicts)
            if total_mins > max_minutes:
                raise BadRequestException(
                    f"Total logged time ({total_mins} minutes) exceeds maximum allowed per day ({max_minutes} minutes)."
                )

        old_data = {"summary": report.summary, "total_minutes": report.total_minutes}
        updated = await self.repo.update_report(
            report,
            summary=payload.summary,
            items=items_dicts,
        )
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="WORK_REPORT",
            entity_id=updated.id,
            actor_id=user.id,
            old_data=old_data,
            new_data={"summary": updated.summary, "total_minutes": updated.total_minutes},
            request=request,
        )
        await self.session.commit()
        return self._serialize_report(updated)

    async def submit_report(
        self,
        user: User,
        report_id: uuid.UUID,
        request: Request | None = None,
    ) -> WorkReportResponse:
        report = await self.repo.get_by_id(report_id)
        if not report:
            raise NotFoundException(f"Work report with ID '{report_id}' not found.")

        if report.user_id != user.id:
            raise ForbiddenException("You cannot submit another employee's work report.")

        if report.status == WorkReportStatus.REVIEWED.value:
            raise BadRequestException("This report has already been reviewed.")

        if not report.items:
            raise BadRequestException("Cannot submit an empty work report. Please add at least one work item.")

        if report.total_minutes <= 0:
            raise BadRequestException("Total minutes spent must be greater than zero.")

        today = get_local_today()
        window_days = int(
            await self._get_system_setting("work_report_editable_window_days", 7)
        )
        if (today - report.report_date).days > window_days:
            raise BadRequestException(
                f"Work reports older than {window_days} days can no longer be submitted."
            )

        updated = await self.repo.submit_report(report)
        await self.session.commit()

        # Audit log
        await AuditService.record(
            self.session,
            action="SUBMIT",
            entity_type="WORK_REPORT",
            entity_id=updated.id,
            actor_id=user.id,
            new_data={"status": updated.status, "submitted_at": str(updated.submitted_at)},
            request=request,
        )
        await self.session.commit()

        # Notification to reviewer / manager
        try:
            recipient_id = user.manager_id
            if recipient_id:
                await NotificationService.send(
                    session=self.session,
                    user_id=recipient_id,
                    title="Daily Work Report Submitted",
                    body=f"{user.full_name} submitted work report for {report.report_date}.",
                    notification_type="WORK_REPORT_SUBMITTED",
                    data={
                        "type": "work_report",
                        "report_id": str(report.id),
                        "report_date": str(report.report_date),
                    },
                    template_params={
                        "employee_name": user.full_name,
                        "report_date": str(report.report_date),
                    },
                )
                await self.session.commit()
        except Exception:
            # Non-critical notification failure should not abort submission
            pass

        return self._serialize_report(updated)

    async def review_report(
        self,
        reviewer: User,
        report_id: uuid.UUID,
        payload: WorkReportReviewRequest,
        request: Request | None = None,
    ) -> WorkReportResponse:
        report = await self.repo.get_by_id(report_id)
        if not report:
            raise NotFoundException(f"Work report with ID '{report_id}' not found.")

        if report.status == WorkReportStatus.DRAFT.value:
            raise BadRequestException("Cannot review a draft work report that has not yet been submitted.")

        updated = await self.repo.review_report(
            report=report,
            reviewer_id=reviewer.id,
            review_note=payload.review_note,
            status=payload.status,
        )
        await self.session.commit()

        # Audit log
        await AuditService.record(
            self.session,
            action="REVIEW",
            entity_type="WORK_REPORT",
            entity_id=updated.id,
            actor_id=reviewer.id,
            new_data={
                "status": updated.status,
                "review_note": updated.review_note,
                "reviewed_at": str(updated.reviewed_at),
            },
            request=request,
        )
        await self.session.commit()

        # Notification to employee author
        try:
            await NotificationService.send(
                session=self.session,
                user_id=report.user_id,
                title="Work Report Reviewed",
                body=f"Your work report for {report.report_date} was reviewed by {reviewer.full_name}: {payload.review_note}",
                notification_type="WORK_REPORT_REVIEWED",
                data={
                    "type": "work_report",
                    "report_id": str(report.id),
                    "report_date": str(report.report_date),
                },
                template_params={
                    "report_date": str(report.report_date),
                    "reviewer_name": reviewer.full_name,
                    "review_note": payload.review_note,
                },
            )
            await self.session.commit()
        except Exception:
            pass

        return self._serialize_report(updated, reviewer_override=reviewer)

    async def get_report_by_id(self, report_id: uuid.UUID, user: User) -> WorkReportResponse:
        report = await self.repo.get_by_id(report_id)
        if not report:
            raise NotFoundException(f"Work report with ID '{report_id}' not found.")

        # Permission check: own report or user has view_team / view_all
        is_owner = report.user_id == user.id
        has_perm = (await self._has_permission(user, "work_reports.view_all")) or (
            await self._has_permission(user, "work_reports.view_team")
        )
        if not is_owner and not has_perm:
            raise ForbiddenException("You do not have permission to view this work report.")

        return self._serialize_report(report)

    async def get_my_report_by_date(
        self,
        user_id: uuid.UUID,
        report_date: datetime.date,
    ) -> WorkReportResponse | None:
        report = await self.repo.get_by_user_and_date(user_id, report_date)
        if not report:
            return None
        return self._serialize_report(report)

    async def list_my_reports(
        self,
        user_id: uuid.UUID,
        from_date: datetime.date | None = None,
        to_date: datetime.date | None = None,
        status: str | None = None,
        page: int = 1,
        page_size: int = 20,
    ) -> WorkReportPageResponse:
        reports, total = await self.repo.list_user_reports(
            user_id=user_id,
            from_date=from_date,
            to_date=to_date,
            status=status,
            page=page,
            page_size=page_size,
        )
        total_pages = max(1, (total + page_size - 1) // page_size) if total > 0 else 1
        return WorkReportPageResponse(
            items=[self._serialize_report(r) for r in reports],
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
        )

    async def list_all_reports(
        self,
        user: User,
        employee_id: uuid.UUID | None = None,
        department_id: uuid.UUID | None = None,
        from_date: datetime.date | None = None,
        to_date: datetime.date | None = None,
        status: str | None = None,
        page: int = 1,
        page_size: int = 20,
    ) -> WorkReportPageResponse:
        has_view_all = await self._has_permission(user, "work_reports.view_all")
        has_view_team = await self._has_permission(user, "work_reports.view_team")

        if not has_view_all and not has_view_team:
            raise ForbiddenException("You do not have permission to view other employees' work reports.")

        target_user_ids: list[uuid.UUID] | None = None
        target_dept_id = department_id

        if employee_id:
            target_user_ids = [employee_id]

        # Scope restrictions for team-only managers
        if not has_view_all and has_view_team:
            if not target_dept_id:
                target_dept_id = user.department_id

        reports, total = await self.repo.list_reports(
            user_ids=target_user_ids,
            department_id=target_dept_id,
            from_date=from_date,
            to_date=to_date,
            status=status,
            page=page,
            page_size=page_size,
        )
        total_pages = max(1, (total + page_size - 1) // page_size) if total > 0 else 1
        return WorkReportPageResponse(
            items=[self._serialize_report(r) for r in reports],
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
        )

    async def get_missing_reports(
        self,
        user: User,
        report_date: datetime.date,
        department_id: uuid.UUID | None = None,
    ) -> MissingWorkReportListResponse:
        has_view_all = await self._has_permission(user, "work_reports.view_all")
        has_view_team = await self._has_permission(user, "work_reports.view_team")

        if not has_view_all and not has_view_team:
            raise ForbiddenException("You do not have permission to view missing work reports.")

        target_dept_id = department_id
        if not has_view_all and has_view_team:
            if not target_dept_id:
                target_dept_id = user.department_id

        missing_users = await self.repo.get_missing_reports(
            report_date=report_date,
            department_id=target_dept_id,
        )

        user_items: list[MissingWorkReportUserResponse] = []
        for u in missing_users:
            user_items.append(
                MissingWorkReportUserResponse(
                    user_id=u.id,
                    full_name=u.full_name,
                    employee_code=u.employee_code,
                    email=u.email,
                    department_id=u.department_id,
                    department_name=u.department.name if u.department else None,
                    manager_name=u.manager.full_name if u.manager else None,
                )
            )

        return MissingWorkReportListResponse(
            report_date=report_date,
            missing_count=len(user_items),
            users=user_items,
        )
