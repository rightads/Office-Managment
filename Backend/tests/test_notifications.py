from __future__ import annotations

import datetime
from unittest.mock import MagicMock, patch

import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.models.communication import DeviceToken, Notification, NotificationTemplate
from app.models.user import User
from app.services.notification_channels import FCMNotificationChannel
from app.services.notification_service import NotificationService
from app.utils.timezone import now_utc


@pytest.mark.asyncio
async def test_device_token_register_and_unregister(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test registering and unregistering FCM device tokens for an employee."""
    emp, headers = employee_auth_headers
    emp_id = emp.id

    # 1. Register device
    reg_payload = {
        "fcm_token": "fcm_test_token_1234567890_abc",
        "device_id": "pixel_7_pro_hw_id",
        "platform": "android",
    }
    resp = await async_client.post(
        "/api/v1/notifications/devices", json=reg_payload, headers=headers
    )
    assert resp.status_code == 201
    data = resp.json()
    assert data["device_id"] == "pixel_7_pro_hw_id"
    assert data["platform"] == "android"

    # Verify in DB
    tokens = (
        (await db_session.execute(select(DeviceToken).where(DeviceToken.user_id == emp_id)))
        .scalars()
        .all()
    )
    assert len(tokens) == 1
    assert tokens[0].fcm_token == "fcm_test_token_1234567890_abc"

    # 2. Unregister device
    del_resp = await async_client.delete(
        "/api/v1/notifications/devices/pixel_7_pro_hw_id", headers=headers
    )
    assert del_resp.status_code == 204

    # Verify removed from DB
    tokens_after = (
        (await db_session.execute(select(DeviceToken).where(DeviceToken.user_id == emp_id)))
        .scalars()
        .all()
    )
    assert len(tokens_after) == 0


@pytest.mark.asyncio
async def test_notifications_inbox_and_read_endpoints(
    async_client: AsyncClient,
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test in-app notification listing, unread count, and marking read/all-read."""
    emp, headers = employee_auth_headers

    # Seed 2 in-app notifications
    n1 = Notification(
        user_id=emp.id,
        title="Notice 1",
        body="Body 1",
        type="TASK_ASSIGNED",
        is_read=False,
    )
    n2 = Notification(
        user_id=emp.id,
        title="Notice 2",
        body="Body 2",
        type="TASK_STATUS_CHANGED",
        is_read=False,
    )
    db_session.add_all([n1, n2])
    await db_session.commit()

    # 1. Check unread count
    cnt_resp = await async_client.get("/api/v1/notifications/unread-count", headers=headers)
    assert cnt_resp.status_code == 200
    assert cnt_resp.json()["unread_count"] == 2

    # 2. List notifications
    list_resp = await async_client.get("/api/v1/notifications", headers=headers)
    assert list_resp.status_code == 200
    paged = list_resp.json()
    assert paged["total"] == 2
    assert len(paged["items"]) == 2

    # 3. Mark single notification as read
    read_resp = await async_client.patch(f"/api/v1/notifications/{n1.id}/read", headers=headers)
    assert read_resp.status_code == 200
    assert read_resp.json()["is_read"] is True

    # Check unread count -> 1
    cnt_resp2 = await async_client.get("/api/v1/notifications/unread-count", headers=headers)
    assert cnt_resp2.json()["unread_count"] == 1

    # 4. Mark all read
    all_read_resp = await async_client.post("/api/v1/notifications/read-all", headers=headers)
    assert all_read_resp.status_code == 200

    cnt_resp3 = await async_client.get("/api/v1/notifications/unread-count", headers=headers)
    assert cnt_resp3.json()["unread_count"] == 0


@pytest.mark.asyncio
async def test_fcm_channel_mock_and_token_invalidation(
    db_session: AsyncSession,
) -> None:
    """Verify FCM push dispatch via mock and automatic invalid token removal."""
    fcm_channel = FCMNotificationChannel()

    # Create mock response simulating 1 valid token and 1 unregistered/invalid token
    mock_success_item = MagicMock()
    mock_success_item.success = True

    mock_fail_item = MagicMock()
    mock_fail_item.success = False
    mock_fail_item.exception = Exception("registration-token-not-registered")

    mock_batch_response = MagicMock()
    mock_batch_response.success_count = 1
    mock_batch_response.failure_count = 1
    mock_batch_response.responses = [mock_success_item, mock_fail_item]

    mock_messaging = MagicMock()
    mock_messaging.send_multicast.return_value = mock_batch_response
    mock_messaging.Notification = MagicMock()
    mock_messaging.MulticastMessage = MagicMock()

    mock_firebase_admin = MagicMock()
    mock_firebase_admin.messaging = mock_messaging
    mock_firebase_admin._apps = ["mock_app"]

    with (
        patch.object(settings, "ENABLE_PUSH_NOTIFICATIONS", True),
        patch.dict(
            "sys.modules",
            {
                "firebase_admin": mock_firebase_admin,
                "firebase_admin.messaging": mock_messaging,
            },
        ),
    ):
        fcm_channel = FCMNotificationChannel()
        fcm_channel._initialized = True
        tokens = ["token_valid_123", "token_stale_999"]
        invalid_tokens = await fcm_channel.send(
            recipient_tokens=tokens,
            title="Test Title",
            body="Test Body",
            data={"key": "val"},
        )

        assert "token_stale_999" in invalid_tokens
        assert "token_valid_123" not in invalid_tokens


@pytest.mark.asyncio
async def test_template_placeholders_and_notification_service(
    db_session: AsyncSession,
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Verify that NotificationService resolves DB templates and formats placeholders."""
    emp, _ = employee_auth_headers

    # Ensure template exists
    tmpl = NotificationTemplate(
        code="TEST_CUSTOM_EVENT",
        title_template="Hello {user_name}",
        body_template="Your order {order_id} is ready.",
        channel_push=False,
        channel_email=False,
        is_active=True,
    )
    db_session.add(tmpl)
    await db_session.commit()

    notif = await NotificationService.send(
        session=db_session,
        user_id=emp.id,
        title="Default Title",
        body="Default Body",
        notification_type="TEST_CUSTOM_EVENT",
        template_params={"user_name": "Alice", "order_id": "ORD-42"},
    )
    await db_session.commit()

    assert notif.title == "Hello Alice"
    assert notif.body == "Your order ORD-42 is ready."


@pytest.mark.asyncio
async def test_announcements_creation_and_visibility(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
    db_session: AsyncSession,
) -> None:
    """Test company-wide and department announcements, expiry filtering, and employee visibility."""
    emp, emp_headers = employee_auth_headers

    # 1. Admin creates company-wide active announcement
    c_ann_payload = {
        "title": "Annual Company Retreat",
        "body": "The retreat will take place next month.",
        "expires_at": (now_utc() + datetime.timedelta(days=10)).isoformat(),
    }
    c_resp = await async_client.post(
        "/api/v1/announcements", json=c_ann_payload, headers=admin_auth_headers
    )
    assert c_resp.status_code == 201
    c_data = c_resp.json()
    assert c_data["title"] == "Annual Company Retreat"
    assert c_data["target_department_id"] is None

    # 2. Admin creates expired announcement
    exp_ann_payload = {
        "title": "Expired Notice",
        "body": "This notice already expired.",
        "expires_at": (now_utc() - datetime.timedelta(days=1)).isoformat(),
    }
    await async_client.post(
        "/api/v1/announcements", json=exp_ann_payload, headers=admin_auth_headers
    )

    # 3. Employee fetches active announcements
    list_resp = await async_client.get("/api/v1/announcements", headers=emp_headers)
    assert list_resp.status_code == 200
    active_announcements = list_resp.json()
    titles = [a["title"] for a in active_announcements]
    assert "Annual Company Retreat" in titles
    assert "Expired Notice" not in titles


@pytest.mark.asyncio
async def test_admin_notification_templates_crud(
    async_client: AsyncClient,
    admin_auth_headers: dict[str, str],
    employee_auth_headers: tuple[User, dict[str, str]],
) -> None:
    """Test admin template listing and editing via settings permission."""
    _, emp_headers = employee_auth_headers

    # 1. Admin lists templates
    list_resp = await async_client.get(
        "/api/v1/notifications/templates", headers=admin_auth_headers
    )
    assert list_resp.status_code == 200
    templates = list_resp.json()
    assert len(templates) >= 5

    # 2. Employee cannot list or edit templates (Forbidden)
    emp_list = await async_client.get("/api/v1/notifications/templates", headers=emp_headers)
    assert emp_list.status_code == 403

    # 3. Admin updates a template
    update_payload = {
        "title_template": "Updated Task Alert: {task_title}",
        "channel_email": True,
    }
    up_resp = await async_client.patch(
        "/api/v1/notifications/templates/TASK_ASSIGNED",
        json=update_payload,
        headers=admin_auth_headers,
    )
    assert up_resp.status_code == 200
    updated = up_resp.json()
    assert updated["title_template"] == "Updated Task Alert: {task_title}"
    assert updated["channel_email"] is True
