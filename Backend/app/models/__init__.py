from __future__ import annotations

from app.models.attendance import (
    AttendanceCorrection,
    AttendancePolicy,
    AttendanceRecord,
    AttendanceStatus,
)
from app.models.base import (
    Base,
    SoftDeleteMixin,
    TimestampMixin,
    UUIDMixin,
    utc_now,
)
from app.models.communication import (
    Announcement,
    DeviceToken,
    Notification,
    NotificationTemplate,
)
from app.models.leave import (
    LeaveBalance,
    LeaveRequest,
    LeaveType,
)
from app.models.organization import (
    Department,
    Holiday,
    OfficeLocation,
)
from app.models.rbac import (
    Permission,
    Role,
    RolePermission,
)
from app.models.system import (
    AuditLog,
    RefreshToken,
    SystemSetting,
)
from app.models.task import (
    Client,
    Project,
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

__all__ = [
    "Base",
    "UUIDMixin",
    "TimestampMixin",
    "SoftDeleteMixin",
    "utc_now",
    # RBAC
    "Role",
    "Permission",
    "RolePermission",
    # Organization
    "Department",
    "OfficeLocation",
    "Holiday",
    # User
    "User",
    # Attendance
    "AttendancePolicy",
    "AttendanceStatus",
    "AttendanceRecord",
    "AttendanceCorrection",
    # Leave
    "LeaveType",
    "LeaveBalance",
    "LeaveRequest",
    # Task
    "Client",
    "Project",
    "TaskStatus",
    "TaskStatusTransition",
    "TaskPriority",
    "Task",
    "TaskAssignee",
    "TaskComment",
    "TaskAttachment",
    "TaskActivity",
    # Communication
    "Announcement",
    "NotificationTemplate",
    "Notification",
    "DeviceToken",
    # System
    "RefreshToken",
    "AuditLog",
    "SystemSetting",
]
