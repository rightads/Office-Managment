from __future__ import annotations

import logging
import uuid
from typing import TYPE_CHECKING, Any

from app.core.config import settings
from app.core.exceptions import (
    AppException,
    BadRequestException,
    ForbiddenException,
    NotFoundException,
)
from app.models.base import ensure_utc, utc_now
from app.models.task import Task, TaskActivity, TaskAssignee, TaskAttachment, TaskComment
from app.models.user import User
from app.repositories.task_repository import TaskRepository
from app.schemas.common import UserBriefResponse
from app.schemas.task import (
    TaskAssignRequest,
    TaskCommentResponse,
    TaskCreateRequest,
    TaskDetailResponse,
    TaskPriorityBriefResponse,
    TaskReportItem,
    TaskResponse,
    TaskStatusBriefResponse,
    TaskStatusTransitionRequest,
    TaskSummaryReportsResponse,
    TaskUpdateRequest,
)
from app.services.notification_service import NotificationService
from app.services.storage_service import BaseStorageService, get_storage_service

if TYPE_CHECKING:
    from fastapi import UploadFile
    from sqlalchemy.ext.asyncio import AsyncSession

logger = logging.getLogger(__name__)


class TaskService:
    """Core domain logic service for agency tasks, assignments, status transitions, attachments, and reports."""

    def __init__(
        self,
        session: AsyncSession,
        storage_service: BaseStorageService | None = None,
    ) -> None:
        self.session = session
        self.repo = TaskRepository(session)
        self.storage = storage_service or get_storage_service()

    def _to_task_response(self, task: Task) -> TaskResponse:
        now = utc_now()
        due_at_utc = ensure_utc(task.due_at) if task.due_at else None
        completed_at_utc = ensure_utc(task.completed_at) if task.completed_at else None
        is_overdue = bool(
            due_at_utc and due_at_utc < now and task.status and not task.status.is_terminal
        )

        assignees_brief = [
            UserBriefResponse.model_validate(assignee.user)
            for assignee in task.assignees
            if assignee.user
        ]

        return TaskResponse(
            id=task.id,
            title=task.title,
            description=task.description,
            department_id=task.department_id,
            department_name=task.department.name if task.department else None,
            client_id=task.client_id,
            client_name=task.client.name if task.client else None,
            project_id=task.project_id,
            project_name=task.project.name if task.project else None,
            priority=TaskPriorityBriefResponse.model_validate(task.priority),
            status=TaskStatusBriefResponse.model_validate(task.status),
            assigner=UserBriefResponse.model_validate(task.assigner),
            assignees=assignees_brief,
            due_at=due_at_utc,
            completed_at=completed_at_utc,
            is_overdue=is_overdue,
            is_active=task.is_active,
            created_at=task.created_at,
            updated_at=task.updated_at,
        )

    async def create_task(self, payload: TaskCreateRequest, creator: User) -> TaskResponse:
        priority = await self.repo.get_priority_by_id(payload.priority_id)
        if not priority:
            raise NotFoundException("Task priority not found or inactive.")

        if payload.status_id:
            status = await self.repo.get_status_by_id(payload.status_id)
            if not status:
                raise NotFoundException("Task status not found or inactive.")
        else:
            status = await self.repo.get_default_initial_status()
            if not status:
                raise BadRequestException("No initial task status configured in system.")

        task = Task(
            title=payload.title.strip(),
            description=payload.description.strip() if payload.description else None,
            department_id=payload.department_id,
            client_id=payload.client_id,
            project_id=payload.project_id,
            priority_id=priority.id,
            status_id=status.id,
            assigned_by=creator.id,
            due_at=payload.due_at,
            is_active=True,
        )
        self.session.add(task)
        await self.session.flush()

        # Add assignees
        unique_assignee_ids = set(payload.assignee_ids)
        for uid in unique_assignee_ids:
            assignee = TaskAssignee(task_id=task.id, user_id=uid)
            self.session.add(assignee)

        # Record activity
        await self.repo.record_activity(
            task_id=task.id,
            actor_id=creator.id,
            action="TASK_CREATED",
            details={
                "title": task.title,
                "priority": priority.code,
                "status": status.code,
                "assignees_count": len(unique_assignee_ids),
            },
        )

        await self.session.commit()

        # Reload with full relations
        reloaded = await self.repo.get_task_by_id(task.id)
        if not reloaded:
            raise AppException("Failed to reload created task.")

        # Notify assignees
        for uid in unique_assignee_ids:
            if uid != creator.id:
                await NotificationService.send(
                    session=self.session,
                    user_id=uid,
                    title="New Task Assigned",
                    body=f"You have been assigned to task: '{task.title}'",
                    notification_type="TASK_ASSIGNED",
                    data={"task_id": str(task.id)},
                )
        await self.session.commit()

        return self._to_task_response(reloaded)

    async def get_task_detail(
        self,
        task_id: uuid.UUID,
        current_user: User,
        can_view_all: bool,
    ) -> TaskDetailResponse:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        # Check permissions: if not can_view_all, user must be an assignee or assigner
        if not can_view_all:
            is_assignee = any(a.user_id == current_user.id for a in task.assignees)
            if not is_assignee and task.assigned_by != current_user.id:
                raise ForbiddenException("You do not have permission to view this task.")

        comments_count, attachments_count = await self.repo.get_task_counts(task.id)
        base_resp = self._to_task_response(task)

        return TaskDetailResponse(
            **base_resp.model_dump(),
            comments_count=comments_count,
            attachments_count=attachments_count,
        )

    async def update_task(
        self,
        task_id: uuid.UUID,
        payload: TaskUpdateRequest,
        actor: User,
    ) -> TaskResponse:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        changes: dict[str, Any] = {}
        if payload.title is not None and payload.title.strip() != task.title:
            changes["title"] = {"from": task.title, "to": payload.title.strip()}
            task.title = payload.title.strip()

        if payload.description is not None:
            clean_desc = payload.description.strip() if payload.description else None
            if clean_desc != task.description:
                changes["description"] = "updated"
                task.description = clean_desc

        if payload.department_id is not None:
            task.department_id = payload.department_id
            changes["department_id"] = str(payload.department_id)

        if payload.client_id is not None:
            task.client_id = payload.client_id
            changes["client_id"] = str(payload.client_id)

        if payload.project_id is not None:
            task.project_id = payload.project_id
            changes["project_id"] = str(payload.project_id)

        if payload.priority_id is not None and payload.priority_id != task.priority_id:
            prio = await self.repo.get_priority_by_id(payload.priority_id)
            if not prio:
                raise NotFoundException("Specified priority not found.")
            changes["priority"] = {"from": task.priority.code, "to": prio.code}
            task.priority_id = prio.id

        if payload.due_at is not None and payload.due_at != task.due_at:
            changes["due_at"] = {
                "from": task.due_at.isoformat() if task.due_at else None,
                "to": payload.due_at.isoformat(),
            }
            task.due_at = payload.due_at

        if changes:
            await self.repo.record_activity(
                task_id=task.id,
                actor_id=actor.id,
                action="TASK_UPDATED",
                details=changes,
            )
            await self.session.commit()

        reloaded = await self.repo.get_task_by_id(task.id)
        if not reloaded:
            raise AppException("Failed to reload task.")
        return self._to_task_response(reloaded)

    async def assign_task(
        self,
        task_id: uuid.UUID,
        payload: TaskAssignRequest,
        actor: User,
    ) -> TaskResponse:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        current_assignee_ids = {a.user_id for a in task.assignees}
        target_ids = set(payload.assignee_ids)

        if payload.replace:
            to_add = target_ids - current_assignee_ids
            task.assignees = [TaskAssignee(task_id=task.id, user_id=uid) for uid in target_ids]

            await self.repo.record_activity(
                task_id=task.id,
                actor_id=actor.id,
                action="TASK_REASSIGNED",
                details={
                    "assignee_ids": [str(uid) for uid in target_ids],
                },
            )
        else:
            to_add = target_ids - current_assignee_ids
            for uid in to_add:
                new_a = TaskAssignee(task_id=task.id, user_id=uid)
                self.session.add(new_a)

            if to_add:
                await self.repo.record_activity(
                    task_id=task.id,
                    actor_id=actor.id,
                    action="TASK_ASSIGNED",
                    details={"added": [str(uid) for uid in to_add]},
                )

        await self.session.commit()

        # Notify newly added assignees
        for uid in to_add:
            if uid != actor.id:
                await NotificationService.send(
                    session=self.session,
                    user_id=uid,
                    title="Task Assigned",
                    body=f"You have been assigned to task: '{task.title}'",
                    notification_type="TASK_ASSIGNED",
                    data={"task_id": str(task.id)},
                )
        saved_task_id = task.id
        await self.session.commit()

        reloaded = await self.repo.get_task_by_id(saved_task_id)
        if not reloaded:
            raise AppException("Failed to reload task.")
        return self._to_task_response(reloaded)

    async def update_status(
        self,
        task_id: uuid.UUID,
        payload: TaskStatusTransitionRequest,
        actor: User,
        user_permissions: set[str],
        can_view_all: bool,
    ) -> TaskResponse:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        # Permission / assignment verification
        is_assigned = any(a.user_id == actor.id for a in task.assignees)
        if not can_view_all and not is_assigned and task.assigned_by != actor.id:
            raise ForbiddenException("You are not authorized to update this task's status.")

        if task.status_id == payload.to_status_id:
            return self._to_task_response(task)

        # Non-negotiable requirement: Allowed transitions MUST be defined in task_status_transitions DB table
        transition = await self.repo.get_transition(
            from_status_id=task.status_id,
            to_status_id=payload.to_status_id,
        )
        if not transition:
            to_st = await self.repo.get_status_by_id(payload.to_status_id)
            to_label = to_st.label if to_st else str(payload.to_status_id)
            raise BadRequestException(
                f"Status transition from '{task.status.label}' to '{to_label}' is not allowed."
            )

        # Check required_permission if specified on transition
        if transition.required_permission:
            if (
                "*" not in user_permissions
                and transition.required_permission not in user_permissions
            ):
                raise ForbiddenException(
                    f"Permission '{transition.required_permission}' required for this status transition."
                )

        new_status = await self.repo.get_status_by_id(payload.to_status_id)
        if not new_status:
            raise NotFoundException("Target status not found.")

        prev_status_code = task.status.code
        task.status_id = new_status.id
        task.status = new_status

        # Terminal status handling: set completed_at when moving to terminal, clear if leaving terminal
        if new_status.is_terminal:
            task.completed_at = utc_now()
        else:
            task.completed_at = None

        await self.repo.record_activity(
            task_id=task.id,
            actor_id=actor.id,
            action="STATUS_CHANGED",
            details={
                "from_status": prev_status_code,
                "to_status": new_status.code,
                "remarks": payload.remarks,
            },
        )
        await self.session.commit()

        # Notify assignees and creator
        notify_users = {a.user_id for a in task.assignees} | {task.assigned_by}
        notify_users.discard(actor.id)

        for uid in notify_users:
            await NotificationService.send(
                session=self.session,
                user_id=uid,
                title="Task Status Updated",
                body=f"Task '{task.title}' moved to '{new_status.label}'.",
                notification_type="TASK_STATUS_CHANGED",
                data={
                    "task_id": str(task.id),
                    "from_status": prev_status_code,
                    "to_status": new_status.code,
                },
            )
        saved_task_id = task.id
        await self.session.commit()

        reloaded = await self.repo.get_task_by_id(saved_task_id)
        if not reloaded:
            raise AppException("Failed to reload task.")
        return self._to_task_response(reloaded)

    async def archive_task(self, task_id: uuid.UUID, actor: User) -> None:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        task.is_active = False
        task.deleted_at = utc_now()
        await self.repo.record_activity(
            task_id=task.id,
            actor_id=actor.id,
            action="TASK_ARCHIVED",
            details={"title": task.title},
        )
        await self.session.commit()

    # ==============================================================================
    # Comments
    # ==============================================================================
    async def add_comment(
        self,
        task_id: uuid.UUID,
        comment_text: str,
        author: User,
        can_view_all: bool,
    ) -> TaskCommentResponse:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        is_assigned = any(a.user_id == author.id for a in task.assignees)
        if not can_view_all and not is_assigned and task.assigned_by != author.id:
            raise ForbiddenException("You are not authorized to comment on this task.")

        clean_text = comment_text.strip()
        if not clean_text:
            raise BadRequestException("Comment cannot be empty.")

        comment = TaskComment(
            task_id=task.id,
            user_id=author.id,
            comment=clean_text,
        )
        self.session.add(comment)
        await self.session.flush()

        await self.repo.record_activity(
            task_id=task.id,
            actor_id=author.id,
            action="COMMENT_ADDED",
            details={"comment_id": str(comment.id)},
        )
        await self.session.commit()

        # Notify participants
        notify_users = {a.user_id for a in task.assignees} | {task.assigned_by}
        notify_users.discard(author.id)

        for uid in notify_users:
            await NotificationService.send(
                session=self.session,
                user_id=uid,
                title="New Comment on Task",
                body=f"{author.full_name} commented on '{task.title}'",
                notification_type="TASK_COMMENT_ADDED",
                data={"task_id": str(task.id), "comment_id": str(comment.id)},
            )
        await self.session.commit()

        return TaskCommentResponse(
            id=comment.id,
            task_id=comment.task_id,
            author=UserBriefResponse.model_validate(author),
            comment=comment.comment,
            created_at=comment.created_at,
        )

    async def list_comments(
        self,
        task_id: uuid.UUID,
        current_user: User,
        can_view_all: bool,
    ) -> list[TaskCommentResponse]:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        is_assigned = any(a.user_id == current_user.id for a in task.assignees)
        if not can_view_all and not is_assigned and task.assigned_by != current_user.id:
            raise ForbiddenException("You are not authorized to view comments for this task.")

        comments = await self.repo.get_comments(task.id)
        return [
            TaskCommentResponse(
                id=c.id,
                task_id=c.task_id,
                author=UserBriefResponse.model_validate(c.author),
                comment=c.comment,
                created_at=c.created_at,
            )
            for c in comments
        ]

    # ==============================================================================
    # Attachments
    # ==============================================================================
    async def upload_attachment(
        self,
        task_id: uuid.UUID,
        upload_file: UploadFile,
        uploader: User,
        can_view_all: bool,
    ) -> TaskAttachment:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        is_assigned = any(a.user_id == uploader.id for a in task.assignees)
        if not can_view_all and not is_assigned and task.assigned_by != uploader.id:
            raise ForbiddenException("You are not authorized to upload files to this task.")

        content = await upload_file.read()
        file_size = len(content)

        # Validate file size
        max_bytes = settings.MAX_UPLOAD_MB * 1024 * 1024
        if file_size > max_bytes:
            raise BadRequestException(
                f"File size exceeds maximum allowed of {settings.MAX_UPLOAD_MB} MB."
            )

        # Validate MIME type
        content_type = upload_file.content_type or "application/octet-stream"
        if content_type.lower() not in settings.ALLOWED_UPLOAD_MIME_TYPES:
            raise BadRequestException(
                f"MIME type '{content_type}' is not allowed. Supported types: {', '.join(settings.ALLOWED_UPLOAD_MIME_TYPES)}"
            )

        filename = upload_file.filename or "attachment"
        storage_key, internal_url = await self.storage.upload_file(
            file_content=content,
            filename=filename,
            mime_type=content_type,
            subfolder="tasks",
        )

        attachment = TaskAttachment(
            task_id=task.id,
            uploaded_by=uploader.id,
            file_name=filename,
            file_url=storage_key,  # Store storage key in file_url
            file_size_bytes=file_size,
            mime_type=content_type,
        )
        self.session.add(attachment)
        await self.session.flush()

        await self.repo.record_activity(
            task_id=task.id,
            actor_id=uploader.id,
            action="ATTACHMENT_UPLOADED",
            details={
                "attachment_id": str(attachment.id),
                "file_name": filename,
                "file_size_bytes": file_size,
            },
        )
        await self.session.commit()
        return attachment

    async def list_attachments(
        self,
        task_id: uuid.UUID,
        current_user: User,
        can_view_all: bool,
    ) -> list[dict[str, Any]]:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        is_assigned = any(a.user_id == current_user.id for a in task.assignees)
        if not can_view_all and not is_assigned and task.assigned_by != current_user.id:
            raise ForbiddenException("You are not authorized to view attachments for this task.")

        attachments = await self.repo.get_attachments(task.id)
        res = []
        for att in attachments:
            download_url = self.storage.generate_signed_url(
                storage_key=att.file_url,
                filename=att.file_name,
                expires_in_seconds=3600,
            )
            res.append(
                {
                    "id": att.id,
                    "task_id": att.task_id,
                    "file_name": att.file_name,
                    "file_size_bytes": att.file_size_bytes,
                    "mime_type": att.mime_type,
                    "download_url": download_url,
                    "uploader": UserBriefResponse.model_validate(att.uploader),
                    "created_at": att.created_at,
                }
            )
        return res

    # ==============================================================================
    # Timeline
    # ==============================================================================
    async def get_timeline(
        self,
        task_id: uuid.UUID,
        current_user: User,
        can_view_all: bool,
    ) -> list[TaskActivity]:
        task = await self.repo.get_task_by_id(task_id)
        if not task:
            raise NotFoundException("Task not found.")

        is_assigned = any(a.user_id == current_user.id for a in task.assignees)
        if not can_view_all and not is_assigned and task.assigned_by != current_user.id:
            raise ForbiddenException("You are not authorized to view this task's timeline.")

        return await self.repo.get_activities(task.id)

    # ==============================================================================
    # Reports
    # ==============================================================================
    async def get_summary_reports(self) -> TaskSummaryReportsResponse:
        overall = await self.repo.get_overall_report_stats()
        by_emp = await self.repo.get_report_by_employee()
        by_dept = await self.repo.get_report_by_department()
        by_client = await self.repo.get_report_by_client()

        return TaskSummaryReportsResponse(
            total_tasks=overall["total_tasks"],
            completed_tasks=overall["completed_tasks"],
            pending_tasks=overall["pending_tasks"],
            overdue_tasks=overall["overdue_tasks"],
            on_time_completion_rate=overall["on_time_completion_rate"],
            by_employee=[TaskReportItem(**item) for item in by_emp],
            by_department=[TaskReportItem(**item) for item in by_dept],
            by_client=[TaskReportItem(**item) for item in by_client],
        )
