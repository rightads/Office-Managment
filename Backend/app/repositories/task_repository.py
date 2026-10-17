from __future__ import annotations

import datetime
import uuid
from typing import TYPE_CHECKING, Any

from sqlalchemy import (
    case,
    desc,
    func,
    or_,
    select,
)
from sqlalchemy.orm import selectinload

from app.models.base import utc_now
from app.models.organization import Department
from app.models.task import (
    Client,
    Task,
    TaskActivity,
    TaskAssignee,
    TaskAttachment,
    TaskComment,
    TaskPriority,
    TaskStatus,
    TaskStatusTransition,
)
from app.models.user import User
from app.repositories.base import BaseRepository

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession


class TaskRepository(BaseRepository[Task]):
    """Data access repository for tasks, activities, comments, attachments, and transitions."""

    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Task, session)

    async def get_task_by_id(
        self,
        task_id: uuid.UUID,
        include_soft_deleted: bool = False,
    ) -> Task | None:
        """Fetch task by ID with full relational graph loaded."""
        stmt = (
            select(Task)
            .where(Task.id == task_id)
            .options(
                selectinload(Task.status),
                selectinload(Task.priority),
                selectinload(Task.department),
                selectinload(Task.client),
                selectinload(Task.project),
                selectinload(Task.assigner),
                selectinload(Task.assignees).selectinload(TaskAssignee.user),
            )
        )
        if not include_soft_deleted:
            stmt = stmt.where(Task.is_active.is_(True))

        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_status_by_id(self, status_id: uuid.UUID) -> TaskStatus | None:
        stmt = select(TaskStatus).where(TaskStatus.id == status_id, TaskStatus.is_active.is_(True))
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_default_initial_status(self) -> TaskStatus | None:
        """Get the default starting status (lowest non-terminal order)."""
        stmt = (
            select(TaskStatus)
            .where(TaskStatus.is_active.is_(True), TaskStatus.is_terminal.is_(False))
            .order_by(TaskStatus.order.asc())
            .limit(1)
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_priority_by_id(self, priority_id: uuid.UUID) -> TaskPriority | None:
        stmt = select(TaskPriority).where(
            TaskPriority.id == priority_id, TaskPriority.is_active.is_(True)
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_transition(
        self, from_status_id: uuid.UUID, to_status_id: uuid.UUID
    ) -> TaskStatusTransition | None:
        """Fetch allowed transition from the database task_status_transitions table."""
        stmt = select(TaskStatusTransition).where(
            TaskStatusTransition.from_status_id == from_status_id,
            TaskStatusTransition.to_status_id == to_status_id,
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def list_tasks_paginated(
        self,
        *,
        page: int = 1,
        page_size: int = 20,
        assignee_id: uuid.UUID | None = None,
        department_id: uuid.UUID | None = None,
        client_id: uuid.UUID | None = None,
        project_id: uuid.UUID | None = None,
        status_id: uuid.UUID | None = None,
        priority_id: uuid.UUID | None = None,
        is_overdue: bool | None = None,
        due_from: datetime.datetime | None = None,
        due_to: datetime.datetime | None = None,
        search: str | None = None,
        sort_by: str = "created_at",
        sort_desc: bool = True,
        scoped_user_id: uuid.UUID | None = None,
    ) -> tuple[list[Task], int]:
        """
        List tasks with rich filters, full search, pagination, and RBAC scoping.
        If scoped_user_id is provided, only tasks assigned to that user are returned.
        """
        base_query = (
            select(Task).join(Task.status).outerjoin(Task.priority).where(Task.is_active.is_(True))
        )

        # Scoping to assigned tasks (for regular employees without task.view_all)
        if scoped_user_id:
            base_query = base_query.where(
                Task.id.in_(
                    select(TaskAssignee.task_id).where(TaskAssignee.user_id == scoped_user_id)
                )
            )

        # Optional assignee filter
        if assignee_id:
            base_query = base_query.where(
                Task.id.in_(select(TaskAssignee.task_id).where(TaskAssignee.user_id == assignee_id))
            )

        if department_id:
            base_query = base_query.where(Task.department_id == department_id)
        if client_id:
            base_query = base_query.where(Task.client_id == client_id)
        if project_id:
            base_query = base_query.where(Task.project_id == project_id)
        if status_id:
            base_query = base_query.where(Task.status_id == status_id)
        if priority_id:
            base_query = base_query.where(Task.priority_id == priority_id)

        now = utc_now()
        if is_overdue is True:
            base_query = base_query.where(
                Task.due_at.is_not(None),
                Task.due_at < now,
                TaskStatus.is_terminal.is_(False),
            )
        elif is_overdue is False:
            base_query = base_query.where(
                or_(
                    Task.due_at.is_(None),
                    Task.due_at >= now,
                    TaskStatus.is_terminal.is_(True),
                )
            )

        if due_from:
            base_query = base_query.where(Task.due_at >= due_from)
        if due_to:
            base_query = base_query.where(Task.due_at <= due_to)

        if search:
            pattern = f"%{search.strip()}%"
            base_query = base_query.where(
                or_(
                    Task.title.ilike(pattern),
                    Task.description.ilike(pattern),
                )
            )

        # Count total
        count_stmt = select(func.count()).select_from(base_query.subquery())
        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar_one() or 0

        # Sort
        order_col: Any = Task.created_at
        if sort_by == "due_at":
            order_col = Task.due_at
        elif sort_by == "priority":
            order_col = TaskPriority.weight
        elif sort_by == "title":
            order_col = Task.title

        if sort_desc:
            base_query = base_query.order_by(desc(order_col), desc(Task.created_at))
        else:
            base_query = base_query.order_by(order_col, Task.created_at)

        # Pagination & eager loading
        offset = (page - 1) * page_size
        stmt = (
            base_query.offset(offset)
            .limit(page_size)
            .options(
                selectinload(Task.status),
                selectinload(Task.priority),
                selectinload(Task.department),
                selectinload(Task.client),
                selectinload(Task.project),
                selectinload(Task.assigner),
                selectinload(Task.assignees).selectinload(TaskAssignee.user),
            )
        )

        res = await self.session.execute(stmt)
        tasks = list(res.scalars().all())
        return tasks, total

    async def get_task_counts(self, task_id: uuid.UUID) -> tuple[int, int]:
        """Return (comments_count, attachments_count) for a task."""
        c_stmt = select(func.count()).select_from(TaskComment).where(TaskComment.task_id == task_id)
        a_stmt = (
            select(func.count())
            .select_from(TaskAttachment)
            .where(TaskAttachment.task_id == task_id)
        )

        c_res = await self.session.execute(c_stmt)
        a_res = await self.session.execute(a_stmt)
        return c_res.scalar_one() or 0, a_res.scalar_one() or 0

    async def get_comments(self, task_id: uuid.UUID) -> list[TaskComment]:
        stmt = (
            select(TaskComment)
            .where(TaskComment.task_id == task_id)
            .order_by(TaskComment.created_at.asc())
            .options(selectinload(TaskComment.author))
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_attachments(self, task_id: uuid.UUID) -> list[TaskAttachment]:
        stmt = (
            select(TaskAttachment)
            .where(TaskAttachment.task_id == task_id)
            .order_by(TaskAttachment.created_at.desc())
            .options(selectinload(TaskAttachment.uploader))
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def get_attachment_by_id(self, attachment_id: uuid.UUID) -> TaskAttachment | None:
        stmt = (
            select(TaskAttachment)
            .where(TaskAttachment.id == attachment_id)
            .options(selectinload(TaskAttachment.task))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_activities(self, task_id: uuid.UUID) -> list[TaskActivity]:
        stmt = (
            select(TaskActivity)
            .where(TaskActivity.task_id == task_id)
            .order_by(TaskActivity.created_at.asc())
            .options(selectinload(TaskActivity.actor))
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())

    async def record_activity(
        self,
        task_id: uuid.UUID,
        actor_id: uuid.UUID,
        action: str,
        details: dict[str, Any] | None = None,
    ) -> TaskActivity:
        activity = TaskActivity(
            task_id=task_id,
            actor_id=actor_id,
            action=action,
            details=details or {},
            created_at=utc_now(),
        )
        self.session.add(activity)
        await self.session.flush()
        return activity

    # ==============================================================================
    # Aggregated SQL Reporting
    # ==============================================================================
    async def get_overall_report_stats(self) -> dict[str, Any]:
        """Aggregate total, completed, pending, overdue, and on-time completion rate."""
        now = utc_now()
        is_overdue_case = case(
            (
                (Task.due_at.is_not(None))
                & (Task.due_at < now)
                & (TaskStatus.is_terminal.is_(False)),
                1,
            ),
            else_=0,
        )
        is_completed_case = case((TaskStatus.is_terminal.is_(True), 1), else_=0)
        is_on_time_case = case(
            (
                (TaskStatus.is_terminal.is_(True))
                & (Task.due_at.is_not(None))
                & (Task.completed_at.is_not(None))
                & (Task.completed_at <= Task.due_at),
                1,
            ),
            (
                (TaskStatus.is_terminal.is_(True)) & (Task.due_at.is_(None)),
                1,
            ),
            else_=0,
        )

        stmt = (
            select(
                func.count(Task.id).label("total"),
                func.sum(is_completed_case).label("completed"),
                func.sum(is_overdue_case).label("overdue"),
                func.sum(is_on_time_case).label("on_time_completed"),
            )
            .join(Task.status)
            .where(Task.is_active.is_(True))
        )

        res = await self.session.execute(stmt)
        row = res.one()

        total = row.total or 0
        completed = int(row.completed or 0)
        overdue = int(row.overdue or 0)
        pending = total - completed
        on_time_completed = int(row.on_time_completed or 0)
        on_time_rate = round((on_time_completed / completed) * 100.0, 2) if completed > 0 else 100.0

        return {
            "total_tasks": total,
            "completed_tasks": completed,
            "pending_tasks": pending,
            "overdue_tasks": overdue,
            "on_time_completion_rate": on_time_rate,
        }

    async def get_report_by_employee(self) -> list[dict[str, Any]]:
        now = utc_now()
        stmt = (
            select(
                User.id,
                User.full_name,
                func.count(Task.id).label("total"),
                func.sum(case((TaskStatus.is_terminal.is_(True), 1), else_=0)).label("completed"),
                func.sum(
                    case(
                        (
                            (Task.due_at.is_not(None))
                            & (Task.due_at < now)
                            & (TaskStatus.is_terminal.is_(False)),
                            1,
                        ),
                        else_=0,
                    )
                ).label("overdue"),
            )
            .join(TaskAssignee, TaskAssignee.user_id == User.id)
            .join(Task, Task.id == TaskAssignee.task_id)
            .join(TaskStatus, TaskStatus.id == Task.status_id)
            .where(Task.is_active.is_(True), User.is_active.is_(True))
            .group_by(User.id, User.full_name)
            .order_by(desc("total"))
        )

        res = await self.session.execute(stmt)
        items = []
        for r in res.all():
            tot = r.total or 0
            comp = int(r.completed or 0)
            items.append(
                {
                    "id": r.id,
                    "name": r.full_name,
                    "total_tasks": tot,
                    "completed_tasks": comp,
                    "pending_tasks": tot - comp,
                    "overdue_tasks": int(r.overdue or 0),
                }
            )
        return items

    async def get_report_by_department(self) -> list[dict[str, Any]]:
        now = utc_now()
        stmt = (
            select(
                Department.id,
                Department.name,
                func.count(Task.id).label("total"),
                func.sum(case((TaskStatus.is_terminal.is_(True), 1), else_=0)).label("completed"),
                func.sum(
                    case(
                        (
                            (Task.due_at.is_not(None))
                            & (Task.due_at < now)
                            & (TaskStatus.is_terminal.is_(False)),
                            1,
                        ),
                        else_=0,
                    )
                ).label("overdue"),
            )
            .join(Task, Task.department_id == Department.id)
            .join(TaskStatus, TaskStatus.id == Task.status_id)
            .where(Task.is_active.is_(True), Department.is_active.is_(True))
            .group_by(Department.id, Department.name)
            .order_by(desc("total"))
        )

        res = await self.session.execute(stmt)
        items = []
        for r in res.all():
            tot = r.total or 0
            comp = int(r.completed or 0)
            items.append(
                {
                    "id": r.id,
                    "name": r.name,
                    "total_tasks": tot,
                    "completed_tasks": comp,
                    "pending_tasks": tot - comp,
                    "overdue_tasks": int(r.overdue or 0),
                }
            )
        return items

    async def get_report_by_client(self) -> list[dict[str, Any]]:
        now = utc_now()
        stmt = (
            select(
                Client.id,
                Client.name,
                func.count(Task.id).label("total"),
                func.sum(case((TaskStatus.is_terminal.is_(True), 1), else_=0)).label("completed"),
                func.sum(
                    case(
                        (
                            (Task.due_at.is_not(None))
                            & (Task.due_at < now)
                            & (TaskStatus.is_terminal.is_(False)),
                            1,
                        ),
                        else_=0,
                    )
                ).label("overdue"),
            )
            .join(Task, Task.client_id == Client.id)
            .join(TaskStatus, TaskStatus.id == Task.status_id)
            .where(Task.is_active.is_(True), Client.is_active.is_(True))
            .group_by(Client.id, Client.name)
            .order_by(desc("total"))
        )

        res = await self.session.execute(stmt)
        items = []
        for r in res.all():
            tot = r.total or 0
            comp = int(r.completed or 0)
            items.append(
                {
                    "id": r.id,
                    "name": r.name,
                    "total_tasks": tot,
                    "completed_tasks": comp,
                    "pending_tasks": tot - comp,
                    "overdue_tasks": int(r.overdue or 0),
                }
            )
        return items

    async def get_tasks_due_soon(
        self, window_start: datetime.datetime, window_end: datetime.datetime
    ) -> list[Task]:
        """Fetch active non-terminal tasks with due_at in [window_start, window_end]."""
        stmt = (
            select(Task)
            .join(Task.status)
            .where(
                Task.is_active.is_(True),
                TaskStatus.is_terminal.is_(False),
                Task.due_at.is_not(None),
                Task.due_at >= window_start,
                Task.due_at <= window_end,
            )
            .options(
                selectinload(Task.status),
                selectinload(Task.assignees).selectinload(TaskAssignee.user),
            )
        )
        res = await self.session.execute(stmt)
        return list(res.scalars().all())
