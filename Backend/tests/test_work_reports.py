from __future__ import annotations

import datetime
from typing import Any

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.cli.commands import _async_seed_defaults, _async_seed_permissions
from app.core.security import create_access_token, hash_password
from app.models.communication import Notification
from app.models.organization import Department
from app.models.rbac import Role
from app.models.task import Client, Project, Task, TaskPriority, TaskStatus
from app.models.user import User
from app.utils.timezone import get_local_today


@pytest.fixture
async def work_report_fixture(
    db_session: AsyncSession,
) -> dict[str, Any]:
    """Helper fixture setting up manager, employee, client, project, and task."""
    await _async_seed_permissions(session=db_session)
    await _async_seed_defaults(session=db_session)

    # Department
    dept = Department(name="Development", description="Software Dev", is_active=True)
    db_session.add(dept)
    await db_session.flush()

    # Manager (CSD role has work_reports.view_team and work_reports.review)
    manager_role = (
        await db_session.execute(select(Role).where(Role.name == "CSD"))
    ).scalar_one()

    manager = User(
        employee_code="MGR-001",
        email="manager.dev@agency.com",
        full_name="Dev Manager",
        password_hash=hash_password("ManagerSecret123!#"),
        role_id=manager_role.id,
        department_id=dept.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(manager)
    await db_session.flush()

    # Employee reporting to manager
    dev_role = (
        await db_session.execute(select(Role).where(Role.name == "Website development"))
    ).scalar_one()

    employee = User(
        employee_code="DEV-001",
        email="dev.employee@agency.com",
        full_name="Bob Developer",
        password_hash=hash_password("DevSecret123!#"),
        role_id=dev_role.id,
        department_id=dept.id,
        manager_id=manager.id,
        is_active=True,
        must_change_password=False,
    )
    db_session.add(employee)

    # Client and Project
    client = Client(name="Brand Alpha", contact_details={"phone": "1234567890"}, is_active=True)
    db_session.add(client)
    await db_session.flush()

    project = Project(name="E-Commerce App", client_id=client.id, is_active=True)
    db_session.add(project)
    await db_session.flush()

    # Task
    todo_st = (
        await db_session.execute(select(TaskStatus).where(TaskStatus.code == "TODO"))
    ).scalar_one()
    prio = (
        await db_session.execute(select(TaskPriority).where(TaskPriority.code == "MEDIUM"))
    ).scalar_one()

    task = Task(
        title="Setup Payment Gateway",
        description="Integrate Stripe/Razorpay",
        department_id=dept.id,
        client_id=client.id,
        project_id=project.id,
        priority_id=prio.id,
        status_id=todo_st.id,
        assigned_by=manager.id,
    )
    db_session.add(task)
    await db_session.commit()

    manager_token = create_access_token(user_id=str(manager.id), role="CSD")
    emp_token = create_access_token(user_id=str(employee.id), role="Website development")

    return {
        "department": dept,
        "manager": manager,
        "manager_headers": {"Authorization": f"Bearer {manager_token}"},
        "employee": employee,
        "employee_headers": {"Authorization": f"Bearer {emp_token}"},
        "client": client,
        "project": project,
        "task": task,
    }


@pytest.mark.asyncio
async def test_create_draft_work_report(
    async_client: AsyncClient,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    payload = {
        "report_date": today,
        "summary": "Completed payment gateway integration and code review.",
        "items": [
            {
                "task_id": str(data["task"].id),
                "client_id": str(data["client"].id),
                "project_id": str(data["project"].id),
                "description": "Implemented webhook listener for payment capture",
                "minutes_spent": 180,
            },
            {
                "description": "Team standup and architecture discussion",
                "minutes_spent": 60,
            },
        ],
    }

    resp = await async_client.post(
        "/api/v1/work-reports",
        json=payload,
        headers=data["employee_headers"],
    )
    assert resp.status_code == 201
    res = resp.json()
    assert res["status"] == "draft"
    assert res["report_date"] == today
    assert res["total_minutes"] == 240
    assert len(res["items"]) == 2
    assert res["user_full_name"] == "Bob Developer"


@pytest.mark.asyncio
async def test_future_date_blocked(
    async_client: AsyncClient,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    tomorrow = (get_local_today() + datetime.timedelta(days=1)).isoformat()

    payload = {
        "report_date": tomorrow,
        "summary": "Future work",
        "items": [{"description": "Future activity", "minutes_spent": 60}],
    }

    resp = await async_client.post(
        "/api/v1/work-reports",
        json=payload,
        headers=data["employee_headers"],
    )
    assert resp.status_code == 400
    msg = resp.json().get("detail") or resp.json().get("error", {}).get("message", "")
    assert "future" in msg.lower()


@pytest.mark.asyncio
async def test_max_minutes_exceeded(
    async_client: AsyncClient,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    payload = {
        "report_date": today,
        "summary": "Too many hours",
        "items": [{"description": "Non-stop work", "minutes_spent": 1200}],
    }

    resp = await async_client.post(
        "/api/v1/work-reports",
        json=payload,
        headers=data["employee_headers"],
    )
    assert resp.status_code == 400
    msg = resp.json().get("detail") or resp.json().get("error", {}).get("message", "")
    assert "exceeds maximum allowed" in msg.lower()


@pytest.mark.asyncio
async def test_update_draft_work_report(
    async_client: AsyncClient,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    # 1. Create draft
    create_payload = {
        "report_date": today,
        "summary": "Initial draft",
        "items": [{"description": "Initial task", "minutes_spent": 120}],
    }
    create_resp = await async_client.post(
        "/api/v1/work-reports",
        json=create_payload,
        headers=data["employee_headers"],
    )
    assert create_resp.status_code == 201
    report_id = create_resp.json()["id"]

    # 2. Update draft
    update_payload = {
        "summary": "Updated summary after afternoon work",
        "items": [
            {"description": "Initial task refined", "minutes_spent": 150},
            {"description": "Bug fix on checkout", "minutes_spent": 90},
        ],
    }
    update_resp = await async_client.put(
        f"/api/v1/work-reports/{report_id}",
        json=update_payload,
        headers=data["employee_headers"],
    )
    assert update_resp.status_code == 200
    updated = update_resp.json()
    assert updated["summary"] == "Updated summary after afternoon work"
    assert updated["total_minutes"] == 240
    assert len(updated["items"]) == 2


@pytest.mark.asyncio
async def test_submit_and_review_work_report(
    async_client: AsyncClient,
    db_session: AsyncSession,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    # 1. Create draft
    create_resp = await async_client.post(
        "/api/v1/work-reports",
        json={
            "report_date": today,
            "summary": "Ready to submit",
            "items": [{"description": "Database optimization", "minutes_spent": 300}],
        },
        headers=data["employee_headers"],
    )
    assert create_resp.status_code == 201
    report_id = create_resp.json()["id"]

    # 2. Submit report
    submit_resp = await async_client.post(
        f"/api/v1/work-reports/{report_id}/submit",
        headers=data["employee_headers"],
    )
    assert submit_resp.status_code == 200
    sub_data = submit_resp.json()
    assert sub_data["status"] == "submitted"
    assert sub_data["submitted_at"] is not None

    # Check notification dispatched to manager
    notif_stmt = select(Notification).where(
        Notification.user_id == data["manager"].id,
        Notification.type == "WORK_REPORT_SUBMITTED",
    )
    notif = (await db_session.execute(notif_stmt)).scalar_one_or_none()
    assert notif is not None
    assert "Bob Developer" in notif.body

    # 3. Attempting to update submitted report without allow_edit config fails
    err_resp = await async_client.put(
        f"/api/v1/work-reports/{report_id}",
        json={"summary": "Trying to edit"},
        headers=data["employee_headers"],
    )
    assert err_resp.status_code == 400
    err_msg = err_resp.json().get("detail") or err_resp.json().get("error", {}).get("message", "")
    assert "already been submitted" in err_msg.lower()

    # 4. Manager reviews report
    review_resp = await async_client.post(
        f"/api/v1/work-reports/{report_id}/review",
        json={"review_note": "Great work on the database queries!", "status": "reviewed"},
        headers=data["manager_headers"],
    )
    assert review_resp.status_code == 200
    reviewed_data = review_resp.json()
    assert reviewed_data["status"] == "reviewed"
    assert reviewed_data["review_note"] == "Great work on the database queries!"
    assert reviewed_data["reviewer_name"] == "Dev Manager"

    # Check notification dispatched to employee
    emp_notif_stmt = select(Notification).where(
        Notification.user_id == data["employee"].id,
        Notification.type == "WORK_REPORT_REVIEWED",
    )
    emp_notif = (await db_session.execute(emp_notif_stmt)).scalar_one_or_none()
    assert emp_notif is not None
    assert "reviewed by Dev Manager" in emp_notif.body


@pytest.mark.asyncio
async def test_get_by_date_and_list_my_reports(
    async_client: AsyncClient,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    # Create report
    await async_client.post(
        "/api/v1/work-reports",
        json={
            "report_date": today,
            "summary": "Check list by date",
            "items": [{"description": "Work item", "minutes_spent": 60}],
        },
        headers=data["employee_headers"],
    )

    # 1. Get by date
    by_date_resp = await async_client.get(
        f"/api/v1/work-reports/by-date/{today}",
        headers=data["employee_headers"],
    )
    assert by_date_resp.status_code == 200
    report = by_date_resp.json()
    assert report is not None
    assert report["report_date"] == today

    # 2. Get for date with no report returns null
    yesterday = (get_local_today() - datetime.timedelta(days=1)).isoformat()
    null_resp = await async_client.get(
        f"/api/v1/work-reports/by-date/{yesterday}",
        headers=data["employee_headers"],
    )
    assert null_resp.status_code == 200
    assert null_resp.json() is None

    # 3. List my reports
    list_resp = await async_client.get(
        "/api/v1/work-reports/me?page=1&page_size=10",
        headers=data["employee_headers"],
    )
    assert list_resp.status_code == 200
    page_data = list_resp.json()
    assert page_data["total"] == 1
    assert len(page_data["items"]) == 1


@pytest.mark.asyncio
async def test_manager_list_and_missing_reports(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    # 1. Employee creates and submits report
    create_resp = await async_client.post(
        "/api/v1/work-reports",
        json={
            "report_date": today,
            "summary": "Finished tasks",
            "items": [{"description": "API fixes", "minutes_spent": 120}],
        },
        headers=data["employee_headers"],
    )
    report_id = create_resp.json()["id"]
    await async_client.post(
        f"/api/v1/work-reports/{report_id}/submit",
        headers=data["employee_headers"],
    )

    # 2. Manager lists reports
    mgr_list_resp = await async_client.get(
        f"/api/v1/work-reports?department_id={data['department'].id}&status=submitted",
        headers=data["manager_headers"],
    )
    assert mgr_list_resp.status_code == 200
    assert mgr_list_resp.json()["total"] >= 1

    # 3. Admin lists missing reports for today
    missing_resp = await async_client.get(
        f"/api/v1/work-reports/missing?date={today}",
        headers=admin_auth_headers,
    )
    assert missing_resp.status_code == 200
    missing_data = missing_resp.json()
    # The developer submitted, so the developer should NOT be in missing users
    missing_user_ids = [u["user_id"] for u in missing_data["users"]]
    assert str(data["employee"].id) not in missing_user_ids
    # Manager has not submitted, so manager SHOULD be in missing users
    assert str(data["manager"].id) in missing_user_ids


@pytest.mark.asyncio
async def test_permission_guards(
    async_client: AsyncClient,
    work_report_fixture: dict[str, Any],
) -> None:
    data = work_report_fixture
    today = get_local_today().isoformat()

    # Create a report by developer
    create_resp = await async_client.post(
        "/api/v1/work-reports",
        json={
            "report_date": today,
            "summary": "Check permissions",
            "items": [{"description": "Some code", "minutes_spent": 60}],
        },
        headers=data["employee_headers"],
    )
    report_id = create_resp.json()["id"]
    await async_client.post(
        f"/api/v1/work-reports/{report_id}/submit",
        headers=data["employee_headers"],
    )

    # Employee does not have `work_reports.review` -> 403 on review
    review_err = await async_client.post(
        f"/api/v1/work-reports/{report_id}/review",
        json={"review_note": "Trying to review myself"},
        headers=data["employee_headers"],
    )
    assert review_err.status_code == 403

    # Employee does not have `work_reports.view_team` / `view_all` -> 403 on manager list
    list_err = await async_client.get(
        "/api/v1/work-reports",
        headers=data["employee_headers"],
    )
    assert list_err.status_code == 403
