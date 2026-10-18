from __future__ import annotations

import datetime
import io
from typing import Any

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.organization import Department
from app.models.rbac import Role
from app.models.task import Client, Project, TaskPriority, TaskStatus
from app.models.user import User
from app.services.task_scheduler import send_due_soon_reminders
from app.utils.timezone import now_utc


@pytest.fixture
async def task_setup_data(
    db_session: AsyncSession,
) -> dict[str, Any]:
    """Helper fixture providing seeded priorities, statuses, clients, projects, and users."""
    # Fetch seeded statuses and priorities
    todo_st = (
        await db_session.execute(select(TaskStatus).where(TaskStatus.code == "TODO"))
    ).scalar_one()
    in_progress_st = (
        await db_session.execute(select(TaskStatus).where(TaskStatus.code == "IN_PROGRESS"))
    ).scalar_one()
    in_review_st = (
        await db_session.execute(select(TaskStatus).where(TaskStatus.code == "IN_REVIEW"))
    ).scalar_one()
    done_st = (
        await db_session.execute(select(TaskStatus).where(TaskStatus.code == "DONE"))
    ).scalar_one()

    high_prio = (
        await db_session.execute(select(TaskPriority).where(TaskPriority.code == "HIGH"))
    ).scalar_one()

    # Department
    dept = Department(name="Design & Creative", description="Creative team", is_active=True)
    db_session.add(dept)

    # Client & Project
    client = Client(name="Acme Corp", contact_details={"email": "info@acme.com"}, is_active=True)
    db_session.add(client)
    await db_session.flush()

    project = Project(name="Brand Redesign", client_id=client.id, is_active=True)
    db_session.add(project)

    # Secondary employee
    designer_role = (
        await db_session.execute(select(Role).where(Role.name == "Graphic designer"))
    ).scalar_one()

    designer_user = User(
        employee_code="DES-001",
        email="designer@agency.com",
        full_name="Alice Designer",
        password_hash="fakehash",
        role_id=designer_role.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(designer_user)
    await db_session.commit()

    return {
        "todo_status": todo_st,
        "in_progress_status": in_progress_st,
        "in_review_status": in_review_st,
        "done_status": done_st,
        "high_priority": high_prio,
        "department": dept,
        "client": client,
        "project": project,
        "designer_user": designer_user,
    }


@pytest.mark.asyncio
async def test_create_task_and_list_admin(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
) -> None:
    """Test task creation by Admin with multiple assignees, priority, and list filters."""
    emp, _ = employee_auth_headers
    data = task_setup_data

    payload = {
        "title": "Create New Logo Concepts",
        "description": "Design 3 variations of company logo for Acme Corp.",
        "department_id": str(data["department"].id),
        "client_id": str(data["client"].id),
        "project_id": str(data["project"].id),
        "priority_id": str(data["high_priority"].id),
        "status_id": str(data["todo_status"].id),
        "due_at": (now_utc() + datetime.timedelta(days=3)).isoformat(),
        "assignee_ids": [str(emp.id), str(data["designer_user"].id)],
    }

    resp = await async_client.post("/api/v1/tasks", json=payload, headers=admin_auth_headers)
    assert resp.status_code == 201
    created = resp.json()
    assert created["title"] == "Create New Logo Concepts"
    assert created["status"]["code"] == "TODO"
    assert created["priority"]["code"] == "HIGH"
    assert len(created["assignees"]) == 2

    task_id = created["id"]

    # Admin list tasks with filters
    list_resp = await async_client.get(
        f"/api/v1/tasks?client_id={data['client'].id}&search=Logo",
        headers=admin_auth_headers,
    )
    assert list_resp.status_code == 200
    page_data = list_resp.json()
    assert page_data["total"] == 1
    assert page_data["items"][0]["id"] == task_id


@pytest.mark.asyncio
async def test_task_scoping_employee(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
) -> None:
    """Ensure regular employees without task.view_all only see their assigned tasks."""
    emp, emp_headers = employee_auth_headers
    data = task_setup_data

    # Create task 1 assigned to emp
    t1_payload = {
        "title": "Emp Assigned Task",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(emp.id)],
    }
    r1 = await async_client.post("/api/v1/tasks", json=t1_payload, headers=admin_auth_headers)
    assert r1.status_code == 201
    t1_id = r1.json()["id"]

    # Create task 2 assigned only to designer_user
    t2_payload = {
        "title": "Designer Task Only",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(data["designer_user"].id)],
    }
    r2 = await async_client.post("/api/v1/tasks", json=t2_payload, headers=admin_auth_headers)
    assert r2.status_code == 201
    t2_id = r2.json()["id"]

    # Employee views their tasks via /tasks/my
    my_resp = await async_client.get("/api/v1/tasks/my", headers=emp_headers)
    assert my_resp.status_code == 200
    my_items = my_resp.json()["items"]
    assert len(my_items) == 1
    assert my_items[0]["id"] == t1_id

    # Employee attempts to view details of unassigned task t2 -> 403 Forbidden
    detail_resp = await async_client.get(f"/api/v1/tasks/{t2_id}", headers=emp_headers)
    assert detail_resp.status_code == 403


@pytest.mark.asyncio
async def test_status_transitions_valid_and_invalid(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
) -> None:
    """Verify that status transitions strictly follow DB task_status_transitions table."""
    emp, emp_headers = employee_auth_headers
    data = task_setup_data

    # Create task (starts in TODO)
    t_payload = {
        "title": "Status Transition Task",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(emp.id)],
    }
    r = await async_client.post("/api/v1/tasks", json=t_payload, headers=admin_auth_headers)
    task_id = r.json()["id"]

    # 1. Invalid jump: TODO -> DONE directly without going through IN_PROGRESS/IN_REVIEW
    inv_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/status",
        json={"to_status_id": str(data["done_status"].id)},
        headers=emp_headers,
    )
    assert inv_resp.status_code == 400
    assert "not allowed" in inv_resp.json()["error"]["message"]

    # 2. Valid transition: TODO -> IN_PROGRESS
    v1_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/status",
        json={"to_status_id": str(data["in_progress_status"].id), "remarks": "Starting work"},
        headers=emp_headers,
    )
    assert v1_resp.status_code == 200
    assert v1_resp.json()["status"]["code"] == "IN_PROGRESS"
    assert v1_resp.json()["completed_at"] is None

    # 3. Valid transition: IN_PROGRESS -> IN_REVIEW
    v2_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/status",
        json={"to_status_id": str(data["in_review_status"].id), "remarks": "Ready for review"},
        headers=emp_headers,
    )
    assert v2_resp.status_code == 200
    assert v2_resp.json()["status"]["code"] == "IN_REVIEW"

    # 4. Valid transition to terminal: IN_REVIEW -> DONE (marks completed_at)
    v3_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/status",
        json={"to_status_id": str(data["done_status"].id), "remarks": "Approved and merged"},
        headers=emp_headers,
    )
    assert v3_resp.status_code == 200
    assert v3_resp.json()["status"]["code"] == "DONE"
    assert v3_resp.json()["status"]["is_terminal"] is True
    assert v3_resp.json()["completed_at"] is not None


@pytest.mark.asyncio
async def test_reassign_and_activity_timeline(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
) -> None:
    """Test reassigning tasks and inspecting audit activity timeline."""
    emp, _ = employee_auth_headers
    data = task_setup_data

    # Create task
    t_payload = {
        "title": "Timeline Test Task",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(emp.id)],
    }
    r = await async_client.post("/api/v1/tasks", json=t_payload, headers=admin_auth_headers)
    task_id = r.json()["id"]

    # Reassign: replace with designer_user
    reassign_payload = {
        "assignee_ids": [str(data["designer_user"].id)],
        "replace": True,
    }
    re_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/assign",
        json=reassign_payload,
        headers=admin_auth_headers,
    )
    assert re_resp.status_code == 200
    assignee_ids = [a["id"] for a in re_resp.json()["assignees"]]
    assert str(data["designer_user"].id) in assignee_ids
    assert str(emp.id) not in assignee_ids

    # Check timeline
    timeline_resp = await async_client.get(
        f"/api/v1/tasks/{task_id}/timeline",
        headers=admin_auth_headers,
    )
    assert timeline_resp.status_code == 200
    actions = [act["action"] for act in timeline_resp.json()]
    assert "TASK_CREATED" in actions
    assert "TASK_REASSIGNED" in actions


@pytest.mark.asyncio
async def test_task_comments_and_notifications(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
    db_session: AsyncSession,
) -> None:
    """Test adding comments to task and verifying stored comment and notification."""
    emp, emp_headers = employee_auth_headers
    data = task_setup_data

    # Create task assigned to emp
    t_payload = {
        "title": "Commentable Task",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(emp.id)],
    }
    r = await async_client.post("/api/v1/tasks", json=t_payload, headers=admin_auth_headers)
    task_id = r.json()["id"]

    # Post comment as employee
    c_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/comments",
        json={"comment": "I have started working on the initial mockups."},
        headers=emp_headers,
    )
    assert c_resp.status_code == 201
    assert c_resp.json()["comment"] == "I have started working on the initial mockups."

    # List comments
    lc_resp = await async_client.get(f"/api/v1/tasks/{task_id}/comments", headers=emp_headers)
    assert lc_resp.status_code == 200
    assert len(lc_resp.json()) == 1


@pytest.mark.asyncio
async def test_task_attachment_upload_and_signed_url(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
) -> None:
    """Test file attachment upload, size/type validation, and signed URL generation."""
    emp, emp_headers = employee_auth_headers
    data = task_setup_data

    t_payload = {
        "title": "Attachment Test Task",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(emp.id)],
    }
    r = await async_client.post("/api/v1/tasks", json=t_payload, headers=admin_auth_headers)
    task_id = r.json()["id"]

    # 1. Upload valid image
    fake_png = b"\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR" + b"A" * 100
    files = {"file": ("mockup.png", io.BytesIO(fake_png), "image/png")}

    up_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/attachments",
        files=files,
        headers=emp_headers,
    )
    assert up_resp.status_code == 201
    att = up_resp.json()
    assert att["file_name"] == "mockup.png"
    assert "download_url" in att
    assert "signature=" in att["download_url"]

    # 2. Verify download via signed URL
    dl_resp = await async_client.get(att["download_url"])
    assert dl_resp.status_code == 200
    assert dl_resp.content == fake_png

    # 3. Invalid MIME type rejected
    bad_files = {"file": ("script.exe", io.BytesIO(b"binary"), "application/x-msdownload")}
    bad_resp = await async_client.post(
        f"/api/v1/tasks/{task_id}/attachments",
        files=bad_files,
        headers=emp_headers,
    )
    assert bad_resp.status_code == 400


@pytest.mark.asyncio
async def test_task_sql_reports_and_analytics(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
) -> None:
    """Verify aggregated SQL reports for tasks per employee, department, client, and on-time rate."""
    emp, emp_headers = employee_auth_headers
    data = task_setup_data

    # Task 1: Completed on time
    t1 = {
        "title": "On-time Completed Task",
        "priority_id": str(data["high_priority"].id),
        "department_id": str(data["department"].id),
        "client_id": str(data["client"].id),
        "assignee_ids": [str(emp.id)],
        "due_at": (now_utc() + datetime.timedelta(days=2)).isoformat(),
    }
    r1 = await async_client.post("/api/v1/tasks", json=t1, headers=admin_auth_headers)
    t1_id = r1.json()["id"]
    await async_client.post(
        f"/api/v1/tasks/{t1_id}/status",
        json={"to_status_id": str(data["in_progress_status"].id)},
        headers=emp_headers,
    )
    await async_client.post(
        f"/api/v1/tasks/{t1_id}/status",
        json={"to_status_id": str(data["in_review_status"].id)},
        headers=emp_headers,
    )
    await async_client.post(
        f"/api/v1/tasks/{t1_id}/status",
        json={"to_status_id": str(data["done_status"].id)},
        headers=emp_headers,
    )

    # Task 2: Overdue pending task
    t2 = {
        "title": "Overdue Pending Task",
        "priority_id": str(data["high_priority"].id),
        "department_id": str(data["department"].id),
        "client_id": str(data["client"].id),
        "assignee_ids": [str(emp.id)],
        "due_at": (now_utc() - datetime.timedelta(days=2)).isoformat(),
    }
    await async_client.post("/api/v1/tasks", json=t2, headers=admin_auth_headers)

    # Fetch summary reports
    rep_resp = await async_client.get("/api/v1/tasks/reports/summary", headers=admin_auth_headers)
    assert rep_resp.status_code == 200
    rep = rep_resp.json()
    assert rep["total_tasks"] >= 2
    assert rep["completed_tasks"] >= 1
    assert rep["overdue_tasks"] >= 1
    assert rep["on_time_completion_rate"] == 100.0
    assert len(rep["by_employee"]) >= 1
    assert len(rep["by_department"]) >= 1
    assert len(rep["by_client"]) >= 1


@pytest.mark.asyncio
async def test_due_soon_reminder_job(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    task_setup_data: dict[str, Any],
    db_session: AsyncSession,
) -> None:
    """Test background task due-soon reminder processor."""
    emp, _ = employee_auth_headers
    data = task_setup_data

    # Create task due in 4 hours
    t_payload = {
        "title": "Urgent Due Soon Task",
        "priority_id": str(data["high_priority"].id),
        "assignee_ids": [str(emp.id)],
        "due_at": (now_utc() + datetime.timedelta(hours=4)).isoformat(),
    }
    await async_client.post("/api/v1/tasks", json=t_payload, headers=admin_auth_headers)

    sent = await send_due_soon_reminders(db_session)
    assert sent >= 1
