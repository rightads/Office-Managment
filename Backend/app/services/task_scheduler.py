from __future__ import annotations

import datetime
import logging
from typing import TYPE_CHECKING

from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.cron import CronTrigger
from sqlalchemy import select

from app.core.config import settings
from app.core.constants import DEFAULT_TASK_DUE_REMINDER_LEAD_HOURS
from app.core.database import async_session_factory
from app.models.base import ensure_utc, utc_now
from app.models.system import SystemSetting
from app.repositories.task_repository import TaskRepository
from app.services.notification_service import NotificationService
from app.utils.timezone import get_app_timezone

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession

logger = logging.getLogger(__name__)


async def send_due_soon_reminders(session: AsyncSession) -> int:
    """
    Find active, non-terminal tasks due within the configured lead time window
    and send in-app reminder notifications to all assigned employees.
    """
    repo = TaskRepository(session)

    # Lead time in hours from system_settings (zero-hardcoding)
    lead_hours = DEFAULT_TASK_DUE_REMINDER_LEAD_HOURS
    stmt = select(SystemSetting).where(SystemSetting.key == "task_due_reminder_lead_hours")
    setting_res = await session.execute(stmt)
    setting = setting_res.scalar_one_or_none()
    if setting and setting.value is not None:
        try:
            lead_hours = int(setting.value)
        except (ValueError, TypeError):
            pass

    now = utc_now()
    window_end = now + datetime.timedelta(hours=lead_hours)

    tasks_due = await repo.get_tasks_due_soon(window_start=now, window_end=window_end)
    reminders_sent = 0

    for task in tasks_due:
        if not task.due_at:
            continue

        task_due_utc = ensure_utc(task.due_at)
        hours_remaining = max(1, int((task_due_utc - now).total_seconds() // 3600))
        for assignee in task.assignees:
            await NotificationService.send(
                session=session,
                user_id=assignee.user_id,
                title="Task Due Soon",
                body=f"Task '{task.title}' is due in approx {hours_remaining} hours.",
                notification_type="TASK_DUE_SOON",
                data={
                    "task_id": str(task.id),
                    "due_at": task.due_at.isoformat(),
                    "hours_remaining": hours_remaining,
                },
            )
            reminders_sent += 1

    await session.commit()
    logger.info("Task reminder job processed %d reminders.", reminders_sent)
    return reminders_sent


class TaskScheduler:
    """Background scheduler executing periodic task due-soon reminders."""

    def __init__(self) -> None:
        self.scheduler = AsyncIOScheduler(timezone=str(get_app_timezone()))

    async def _run_due_reminders(self) -> None:
        async with async_session_factory() as session:
            try:
                await send_due_soon_reminders(session)
            except Exception as e:
                logger.error("Error executing task due-soon reminder job: %s", e)

    def start(self) -> None:
        if not settings.SCHEDULER_ENABLED:
            logger.info("Task scheduler disabled via configuration.")
            return

        # Run every hour at minute 15
        self.scheduler.add_job(
            self._run_due_reminders,
            trigger=CronTrigger(minute=15),
            id="task_due_soon_reminders",
            name="Send task due-soon notifications",
            replace_existing=True,
        )
        self.scheduler.start()
        logger.info("Task background scheduler started.")

    def shutdown(self) -> None:
        if self.scheduler.running:
            self.scheduler.shutdown(wait=False)
            logger.info("Task background scheduler stopped.")


task_scheduler_instance = TaskScheduler()
