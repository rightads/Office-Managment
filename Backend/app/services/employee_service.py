from __future__ import annotations

import secrets
import string
import uuid
from typing import Any

from fastapi import Request
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.config import settings
from app.core.exceptions import (
    BadRequestException,
    BusinessRuleViolationException,
    ConflictException,
    NotFoundException,
)
from app.core.security import hash_password, validate_password_policy
from app.models.attendance import AttendancePolicy
from app.models.organization import Department
from app.models.rbac import Role
from app.models.system import SystemSetting
from app.models.user import User
from app.repositories.employee_repository import EmployeeRepository
from app.repositories.refresh_token_repository import RefreshTokenRepository
from app.schemas.employee import (
    EmployeeCreate,
    EmployeeDetailResponse,
    EmployeeResponse,
    EmployeeSelfUpdate,
    EmployeeUpdate,
)
from app.services.audit_service import AuditService
from app.services.email_service import email_service


def _generate_temporary_password(length: int = 12) -> str:
    """Generates a secure temporary password satisfying password policies."""
    chars = string.ascii_letters + string.digits + "!@#$%^&*"
    # Ensure at least one upper, lower, digit, special
    parts = [
        secrets.choice(string.ascii_uppercase),
        secrets.choice(string.ascii_lowercase),
        secrets.choice(string.digits),
        secrets.choice("!@#$%^&*"),
    ]
    parts += [secrets.choice(chars) for _ in range(max(length - 4, 4))]
    secrets.SystemRandom().shuffle(parts)
    return "".join(parts)


class EmployeeService:
    """Business logic for employee lifecycle and identity management."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.employee_repo = EmployeeRepository(session)
        self.token_repo = RefreshTokenRepository(session)

    async def _generate_employee_code(self) -> str:
        """
        Dynamically generates next sequential employee code using format configuration
        stored in system_settings (Zero Hardcoding).
        """
        stmt = select(SystemSetting).where(SystemSetting.key == "employee_code_config")
        res = await self.session.execute(stmt)
        setting = res.scalar_one_or_none()

        prefix = "EMP"
        padding = 4
        if setting and isinstance(setting.value, dict):
            prefix = str(setting.value.get("prefix", "EMP"))
            padding = int(setting.value.get("padding", 4))

        count = await self.employee_repo.count_total_employees() + 1
        code = f"{prefix}-{str(count).zfill(padding)}"

        # Safety loop against collisions
        while await self.employee_repo.get_by_code(code) is not None:
            count += 1
            code = f"{prefix}-{str(count).zfill(padding)}"

        return code

    def _to_response(self, user: User) -> EmployeeResponse:
        """Maps ORM user entity to EmployeeResponse schema."""
        return EmployeeResponse(
            id=user.id,
            employee_code=user.employee_code,
            email=user.email,
            full_name=user.full_name,
            phone_number=user.phone,
            designation=user.designation,
            avatar_url=user.avatar_url,
            is_active=user.is_active,
            must_change_password=user.must_change_password,
            joining_date=user.date_of_joining,
            department_id=user.department_id,
            department_name=user.department.name if user.department else None,
            role_id=user.role_id,
            role_name=user.role.name if user.role else None,
            attendance_policy_id=user.attendance_policy_id,
            attendance_policy_name=user.attendance_policy.name if user.attendance_policy else None,
            manager_id=user.manager_id,
            manager_name=user.manager.full_name if user.manager else None,
            created_at=user.created_at,
        )

    async def create_employee(
        self,
        payload: EmployeeCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> tuple[EmployeeResponse, str]:
        """
        Provisions a new employee, generates code & temporary credentials,
        records audit entry, and dispatches welcome notification.
        """
        # 1. Unique email check
        existing = await self.employee_repo.get_by_email(payload.email)
        if existing:
            raise ConflictException(f"Employee with email '{payload.email}' already exists.")

        # 2. Validate role
        stmt_role = select(Role).where(Role.id == payload.role_id)
        res_role = await self.session.execute(stmt_role)
        role = res_role.scalar_one_or_none()
        if not role:
            raise NotFoundException(f"Role with ID '{payload.role_id}' not found.")

        # 3. Validate department if given
        if payload.department_id:
            stmt_dept = select(Department).where(Department.id == payload.department_id)
            if (await self.session.execute(stmt_dept)).scalar_one_or_none() is None:
                raise NotFoundException(f"Department with ID '{payload.department_id}' not found.")

        # 4. Validate attendance policy if given
        if payload.attendance_policy_id:
            stmt_pol = select(AttendancePolicy).where(
                AttendancePolicy.id == payload.attendance_policy_id
            )
            if (await self.session.execute(stmt_pol)).scalar_one_or_none() is None:
                raise NotFoundException(
                    f"Attendance policy with ID '{payload.attendance_policy_id}' not found."
                )

        # 5. Validate manager if given
        if payload.manager_id:
            manager = await self.employee_repo.get_by_id(payload.manager_id)
            if not manager:
                raise NotFoundException(f"Manager with ID '{payload.manager_id}' not found.")

        # 6. Generate employee code & temporary password
        code = await self._generate_employee_code()
        temp_password = _generate_temporary_password()
        validate_password_policy(temp_password)
        pw_hash = hash_password(temp_password)

        new_user = User(
            employee_code=code,
            email=payload.email.strip().lower(),
            full_name=payload.full_name.strip(),
            password_hash=pw_hash,
            role_id=role.id,
            department_id=payload.department_id,
            attendance_policy_id=payload.attendance_policy_id,
            manager_id=payload.manager_id,
            phone=payload.phone_number,
            designation=payload.designation,
            date_of_joining=payload.joining_date,
            is_active=True,
            must_change_password=True,
        )
        await self.employee_repo.create(new_user)
        await self.session.commit()

        # Reload with relations
        reloaded = await self.employee_repo.get_by_id(new_user.id)
        if not reloaded:
            raise NotFoundException("Created employee could not be retrieved.")

        # Audit
        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            new_data={"email": reloaded.email, "code": code, "role": role.name},
            request=request,
        )
        await self.session.commit()

        # Dispatch welcome email with credentials
        await email_service.send_welcome_credentials(
            to_email=reloaded.email,
            full_name=reloaded.full_name,
            employee_code=code,
            temporary_password=temp_password,
        )

        return self._to_response(reloaded), temp_password

    async def get_employee(self, user_id: uuid.UUID) -> EmployeeDetailResponse:
        """Fetches employee profile and dynamically resolved permission codes."""
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        permissions: list[str] = []
        if user.role:
            permissions = [p.code for p in user.role.permissions]

        base = self._to_response(user)
        return EmployeeDetailResponse(
            **base.model_dump(),
            permissions=permissions,
        )

    async def list_employees(
        self,
        *,
        page: int = 1,
        page_size: int = 20,
        search: str | None = None,
        department_id: uuid.UUID | None = None,
        role_id: uuid.UUID | None = None,
        is_active: bool | None = None,
        sort_by: str = "created_at",
        sort_order: str = "desc",
    ) -> tuple[list[EmployeeResponse], int]:
        """Lists employees with search, filters, and pagination."""
        users, total = await self.employee_repo.list_employees(
            page=page,
            page_size=page_size,
            search=search,
            department_id=department_id,
            role_id=role_id,
            is_active=is_active,
            sort_by=sort_by,
            sort_order=sort_order,
        )
        return [self._to_response(u) for u in users], total

    async def update_employee(
        self,
        user_id: uuid.UUID,
        payload: EmployeeUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """Updates employee fields with audit logging and relation verification."""
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        old_data: dict[str, Any] = {
            "full_name": user.full_name,
            "department_id": str(user.department_id) if user.department_id else None,
            "attendance_policy_id": (
                str(user.attendance_policy_id) if user.attendance_policy_id else None
            ),
            "manager_id": str(user.manager_id) if user.manager_id else None,
            "phone_number": user.phone,
            "designation": user.designation,
        }

        # Prevent assigning self as manager
        if payload.manager_id and payload.manager_id == user.id:
            raise BadRequestException("An employee cannot be their own reporting manager.")

        if payload.full_name is not None:
            user.full_name = payload.full_name.strip()
        if payload.department_id is not None:
            user.department_id = payload.department_id
        if payload.attendance_policy_id is not None:
            user.attendance_policy_id = payload.attendance_policy_id
        if payload.manager_id is not None:
            user.manager_id = payload.manager_id
        if payload.phone_number is not None:
            user.phone = payload.phone_number
        if payload.designation is not None:
            user.designation = payload.designation
        if payload.avatar_url is not None:
            user.avatar_url = payload.avatar_url
        if payload.joining_date is not None:
            user.date_of_joining = payload.joining_date

        await self.session.commit()
        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Updated employee could not be retrieved.")

        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            old_data=old_data,
            new_data=payload.model_dump(exclude_unset=True),
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)

    async def self_update_profile(
        self,
        user_id: uuid.UUID,
        payload: EmployeeSelfUpdate,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """Restricted self-service profile updates (whitelisted fields only)."""
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException("Employee profile not found.")

        # Check whitelisted fields from configuration
        allowed = set(settings.SELF_EDITABLE_PROFILE_FIELDS)
        updates = payload.model_dump(exclude_unset=True)
        for key in updates.keys():
            if key not in allowed:
                raise BusinessRuleViolationException(
                    f"Field '{key}' is not permitted for self-service modification."
                )

        if payload.phone_number is not None:
            user.phone = payload.phone_number
        if payload.avatar_url is not None:
            user.avatar_url = payload.avatar_url

        await self.session.commit()
        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Employee profile not found.")

        await AuditService.record(
            self.session,
            action="SELF_UPDATE",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=user_id,
            new_data=updates,
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)

    async def deactivate_employee(
        self,
        user_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """
        Deactivates employee account and instantly revokes all active refresh tokens.
        Enforces last-admin protection.
        """
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        # Last Admin Protection: Check if user holds administrative capability (user.manage_roles or *)
        user_has_admin_perm = bool(
            user.role and any(p.code in ("*", "user.manage_roles") for p in user.role.permissions)
        )
        if user.is_active and user_has_admin_perm:
            active_admins = await self.employee_repo.count_active_users_with_permission(
                "user.manage_roles"
            )
            if active_admins <= 1:
                raise BusinessRuleViolationException(
                    "Cannot deactivate the last active system administrator."
                )

        user.is_active = False
        await self.token_repo.revoke_all_for_user(user.id)
        await self.session.commit()

        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Deactivated employee could not be retrieved.")

        await AuditService.record(
            self.session,
            action="DEACTIVATE",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)

    async def activate_employee(
        self,
        user_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """Re-activates a previously disabled employee."""
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        user.is_active = True
        await self.session.commit()

        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Activated employee could not be retrieved.")

        await AuditService.record(
            self.session,
            action="ACTIVATE",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)

    async def change_role(
        self,
        user_id: uuid.UUID,
        new_role_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """
        Changes employee role.
        Enforces last-admin demotion protection.
        """
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        stmt_role = (
            select(Role).where(Role.id == new_role_id).options(selectinload(Role.permissions))
        )
        res_role = await self.session.execute(stmt_role)
        target_role = res_role.scalar_one_or_none()
        if not target_role:
            raise NotFoundException(f"Role with ID '{new_role_id}' not found.")

        # Last Admin Protection: Check if user holds administrative capability and target role does not
        user_has_admin_perm = bool(
            user.role and any(p.code in ("*", "user.manage_roles") for p in user.role.permissions)
        )
        target_has_admin_perm = any(
            p.code in ("*", "user.manage_roles") for p in target_role.permissions
        )
        if user_has_admin_perm and not target_has_admin_perm:
            active_admins = await self.employee_repo.count_active_users_with_permission(
                "user.manage_roles"
            )
            if active_admins <= 1:
                raise BusinessRuleViolationException(
                    "Cannot demote the last active system administrator."
                )

        old_role = user.role.name if user.role else None
        user.role_id = target_role.id
        await self.session.commit()

        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Employee could not be retrieved.")

        await AuditService.record(
            self.session,
            action="ROLE_CHANGE",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            old_data={"role": old_role},
            new_data={"role": target_role.name},
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)

    async def admin_reset_password(
        self,
        user_id: uuid.UUID,
        new_password: str | None,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> str:
        """
        Administratively resets an employee password, requires password change on next login,
        and revokes all active refresh tokens.
        """
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        temp_password = new_password or _generate_temporary_password()
        validate_password_policy(temp_password)

        user.password_hash = hash_password(temp_password)
        user.must_change_password = True
        await self.token_repo.revoke_all_for_user(user.id)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="ADMIN_PASSWORD_RESET",
            entity_type="USER",
            entity_id=user.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()

        return temp_password

    async def assign_manager(
        self,
        user_id: uuid.UUID,
        manager_id: uuid.UUID | None,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """Assigns or removes reporting manager."""
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        if manager_id and manager_id == user.id:
            raise BadRequestException("An employee cannot report to themselves.")

        if manager_id:
            mgr = await self.employee_repo.get_by_id(manager_id)
            if not mgr:
                raise NotFoundException(f"Manager with ID '{manager_id}' not found.")

        user.manager_id = manager_id
        await self.session.commit()

        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Employee could not be retrieved.")

        await AuditService.record(
            self.session,
            action="ASSIGN_MANAGER",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            new_data={"manager_id": str(manager_id) if manager_id else None},
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)

    async def assign_policy(
        self,
        user_id: uuid.UUID,
        policy_id: uuid.UUID | None,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> EmployeeResponse:
        """Assigns attendance shift policy."""
        user = await self.employee_repo.get_by_id(user_id)
        if not user:
            raise NotFoundException(f"Employee with ID '{user_id}' not found.")

        if policy_id:
            stmt = select(AttendancePolicy).where(AttendancePolicy.id == policy_id)
            if (await self.session.execute(stmt)).scalar_one_or_none() is None:
                raise NotFoundException(f"Attendance policy with ID '{policy_id}' not found.")

        user.attendance_policy_id = policy_id
        await self.session.commit()

        reloaded = await self.employee_repo.get_by_id(user.id)
        if not reloaded:
            raise NotFoundException("Employee could not be retrieved.")

        await AuditService.record(
            self.session,
            action="ASSIGN_POLICY",
            entity_type="USER",
            entity_id=reloaded.id,
            actor_id=actor_id,
            new_data={"attendance_policy_id": str(policy_id) if policy_id else None},
            request=request,
        )
        await self.session.commit()

        return self._to_response(reloaded)
