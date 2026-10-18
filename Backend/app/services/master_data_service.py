from __future__ import annotations

import uuid
from typing import Any

from fastapi import Request
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import (
    BusinessRuleViolationException,
    ConflictException,
    NotFoundException,
)
from app.models.attendance import AttendancePolicy, AttendanceStatus
from app.models.leave import LeaveType
from app.models.organization import Department, Holiday, OfficeLocation
from app.models.rbac import Permission, Role
from app.models.system import SystemSetting
from app.models.task import Client, Project, TaskPriority, TaskStatus, TaskStatusTransition
from app.repositories.master_data_repository import MasterDataRepository
from app.schemas.master_data import (
    AttendancePolicyCreate,
    AttendancePolicyUpdate,
    AttendanceStatusCreate,
    AttendanceStatusUpdate,
    ClientCreate,
    ClientUpdate,
    DepartmentCreate,
    DepartmentUpdate,
    HolidayCreate,
    HolidayUpdate,
    LeaveTypeCreate,
    LeaveTypeUpdate,
    OfficeLocationCreate,
    OfficeLocationUpdate,
    ProjectCreate,
    ProjectUpdate,
    RoleCreate,
    RoleUpdate,
    SystemSettingCreateUpdate,
    TaskPriorityCreate,
    TaskPriorityUpdate,
    TaskStatusCreate,
    TaskStatusTransitionCreate,
    TaskStatusUpdate,
)
from app.services.audit_service import AuditService


class MasterDataService:
    """Business operations and validation for master data domains."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.repo = MasterDataRepository(session)

    # ==========================================================================
    # Roles & Permissions
    # ==========================================================================
    async def create_role(
        self,
        payload: RoleCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Role:
        existing = await self.repo.get_role_by_name(payload.name)
        if existing:
            raise ConflictException(f"Role '{payload.name}' already exists.")

        perms = await self.repo.get_permissions_by_ids(payload.permission_ids)
        role = Role(
            name=payload.name.strip(),
            description=payload.description,
            is_system=False,
            permissions=perms,
        )
        self.session.add(role)
        await self.session.commit()

        reloaded = await self.repo.get_role_by_id(role.id)
        if not reloaded:
            raise NotFoundException("Role could not be retrieved.")

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="ROLE",
            entity_id=reloaded.id,
            actor_id=actor_id,
            new_data={"name": reloaded.name},
            request=request,
        )
        await self.session.commit()
        return reloaded

    async def update_role(
        self,
        role_id: uuid.UUID,
        payload: RoleUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Role:
        role = await self.repo.get_role_by_id(role_id)
        if not role:
            raise NotFoundException(f"Role with ID '{role_id}' not found.")

        old_data: dict[str, Any] = {"name": role.name, "is_active": role.is_active}

        if payload.name is not None:
            existing = await self.repo.get_role_by_name(payload.name)
            if existing and existing.id != role.id:
                raise ConflictException(f"Role '{payload.name}' already exists.")
            role.name = payload.name.strip()

        if payload.description is not None:
            role.description = payload.description

        if payload.is_active is not None:
            if role.is_system and not payload.is_active:
                raise BusinessRuleViolationException("System roles cannot be deactivated.")
            role.is_active = payload.is_active

        if payload.permission_ids is not None:
            perms = await self.repo.get_permissions_by_ids(payload.permission_ids)
            role.permissions = perms

        await self.session.commit()
        reloaded = await self.repo.get_role_by_id(role.id)
        if not reloaded:
            raise NotFoundException("Role could not be retrieved.")

        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="ROLE",
            entity_id=reloaded.id,
            actor_id=actor_id,
            old_data=old_data,
            new_data=payload.model_dump(exclude_unset=True),
            request=request,
        )
        await self.session.commit()
        return reloaded

    async def delete_role(
        self,
        role_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> None:
        role = await self.repo.get_role_by_id(role_id)
        if not role:
            raise NotFoundException(f"Role with ID '{role_id}' not found.")

        # System roles protected from deletion
        if role.is_system:
            raise BusinessRuleViolationException(
                f"System role '{role.name}' is protected and cannot be deleted."
            )

        role_name = role.name
        await self.session.delete(role)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="DELETE",
            entity_type="ROLE",
            entity_id=role_id,
            actor_id=actor_id,
            old_data={"name": role_name},
            request=request,
        )
        await self.session.commit()

    async def list_permissions(
        self, page: int = 1, page_size: int = 50
    ) -> tuple[list[Permission], int]:
        return await self.repo.list_permissions(page=page, page_size=page_size)

    # ==========================================================================
    # Departments
    # ==========================================================================
    async def create_department(
        self,
        payload: DepartmentCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Department:
        stmt = select(Department).where(func.lower(Department.name) == payload.name.strip().lower())
        if (await self.session.execute(stmt)).scalar_one_or_none():
            raise ConflictException(f"Department '{payload.name}' already exists.")

        dept = Department(name=payload.name.strip(), description=payload.description)
        self.session.add(dept)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="DEPARTMENT",
            entity_id=dept.id,
            actor_id=actor_id,
            new_data={"name": dept.name},
            request=request,
        )
        await self.session.commit()
        return dept

    async def update_department(
        self,
        dept_id: uuid.UUID,
        payload: DepartmentUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Department:
        dept = await self.repo.get_by_id(Department, dept_id)
        if not dept:
            raise NotFoundException(f"Department with ID '{dept_id}' not found.")

        if payload.name is not None:
            stmt = select(Department).where(
                func.lower(Department.name) == payload.name.strip().lower(),
                Department.id != dept.id,
            )
            if (await self.session.execute(stmt)).scalar_one_or_none():
                raise ConflictException(f"Department '{payload.name}' already exists.")
            dept.name = payload.name.strip()

        if payload.description is not None:
            dept.description = payload.description
        if payload.is_active is not None:
            dept.is_active = payload.is_active

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="DEPARTMENT",
            entity_id=dept.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return dept

    async def delete_department(
        self,
        dept_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> None:
        dept = await self.repo.get_by_id(Department, dept_id)
        if not dept:
            raise NotFoundException(f"Department with ID '{dept_id}' not found.")

        dept.is_active = False
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="DELETE",
            entity_type="DEPARTMENT",
            entity_id=dept.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()

    # ==========================================================================
    # Office Locations
    # ==========================================================================
    async def create_office_location(
        self,
        payload: OfficeLocationCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> OfficeLocation:
        loc = OfficeLocation(
            name=payload.name.strip(),
            latitude=payload.latitude,
            longitude=payload.longitude,
            radius_meters=payload.radius_meters,
        )
        self.session.add(loc)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="OFFICE_LOCATION",
            entity_id=loc.id,
            actor_id=actor_id,
            new_data={"name": loc.name},
            request=request,
        )
        await self.session.commit()
        return loc

    async def update_office_location(
        self,
        loc_id: uuid.UUID,
        payload: OfficeLocationUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> OfficeLocation:
        loc = await self.repo.get_by_id(OfficeLocation, loc_id)
        if not loc:
            raise NotFoundException(f"Office location with ID '{loc_id}' not found.")

        if payload.name is not None:
            loc.name = payload.name.strip()
        if payload.latitude is not None:
            loc.latitude = payload.latitude
        if payload.longitude is not None:
            loc.longitude = payload.longitude
        if payload.radius_meters is not None:
            loc.radius_meters = payload.radius_meters
        if payload.is_active is not None:
            loc.is_active = payload.is_active

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="OFFICE_LOCATION",
            entity_id=loc.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return loc

    # ==========================================================================
    # Holidays
    # ==========================================================================
    async def create_holiday(
        self,
        payload: HolidayCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Holiday:
        stmt = select(Holiday).where(Holiday.date == payload.date)
        if (await self.session.execute(stmt)).scalar_one_or_none():
            raise ConflictException(f"Holiday already configured for date '{payload.date}'.")

        holiday = Holiday(
            name=payload.name.strip(),
            date=payload.date,
            is_optional=payload.is_optional,
            year=payload.date.year,
        )
        self.session.add(holiday)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="HOLIDAY",
            entity_id=holiday.id,
            actor_id=actor_id,
            new_data={"name": holiday.name, "date": str(holiday.date)},
            request=request,
        )
        await self.session.commit()
        return holiday

    async def update_holiday(
        self,
        holiday_id: uuid.UUID,
        payload: HolidayUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Holiday:
        holiday = await self.repo.get_by_id(Holiday, holiday_id)
        if not holiday:
            raise NotFoundException(f"Holiday with ID '{holiday_id}' not found.")

        if payload.name is not None:
            holiday.name = payload.name.strip()
        if payload.date is not None:
            holiday.date = payload.date
            holiday.year = payload.date.year
        if payload.is_optional is not None:
            holiday.is_optional = payload.is_optional

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="HOLIDAY",
            entity_id=holiday.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return holiday

    # ==========================================================================
    # Attendance Policies & Statuses
    # ==========================================================================
    async def create_attendance_policy(
        self,
        payload: AttendancePolicyCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> AttendancePolicy:
        policy = AttendancePolicy(**payload.model_dump())
        self.session.add(policy)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="ATTENDANCE_POLICY",
            entity_id=policy.id,
            actor_id=actor_id,
            new_data={"name": policy.name},
            request=request,
        )
        await self.session.commit()
        return policy

    async def update_attendance_policy(
        self,
        policy_id: uuid.UUID,
        payload: AttendancePolicyUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> AttendancePolicy:
        policy = await self.repo.get_by_id(AttendancePolicy, policy_id)
        if not policy:
            raise NotFoundException(f"Attendance policy with ID '{policy_id}' not found.")

        for key, value in payload.model_dump(exclude_unset=True).items():
            setattr(policy, key, value)

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="ATTENDANCE_POLICY",
            entity_id=policy.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return policy

    async def create_attendance_status(
        self,
        payload: AttendanceStatusCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> AttendanceStatus:
        stmt = select(AttendanceStatus).where(AttendanceStatus.code == payload.code.strip())
        if (await self.session.execute(stmt)).scalar_one_or_none():
            raise ConflictException(f"Attendance status '{payload.code}' already exists.")

        status = AttendanceStatus(**payload.model_dump())
        self.session.add(status)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="ATTENDANCE_STATUS",
            entity_id=status.id,
            actor_id=actor_id,
            new_data={"code": status.code},
            request=request,
        )
        await self.session.commit()
        return status

    async def update_attendance_status(
        self,
        status_id: uuid.UUID,
        payload: AttendanceStatusUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> AttendanceStatus:
        status = await self.repo.get_by_id(AttendanceStatus, status_id)
        if not status:
            raise NotFoundException(f"Attendance status with ID '{status_id}' not found.")

        for key, value in payload.model_dump(exclude_unset=True).items():
            setattr(status, key, value)

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="ATTENDANCE_STATUS",
            entity_id=status.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return status

    # ==========================================================================
    # Leave Types
    # ==========================================================================
    async def create_leave_type(
        self,
        payload: LeaveTypeCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> LeaveType:
        stmt = select(LeaveType).where(LeaveType.name == payload.name.strip())
        if (await self.session.execute(stmt)).scalar_one_or_none():
            raise ConflictException(f"Leave type with name '{payload.name}' already exists.")

        lt = LeaveType(**payload.model_dump())
        self.session.add(lt)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="LEAVE_TYPE",
            entity_id=lt.id,
            actor_id=actor_id,
            new_data={"name": lt.name, "annual_quota": lt.annual_quota},
            request=request,
        )
        await self.session.commit()
        return lt

    async def update_leave_type(
        self,
        lt_id: uuid.UUID,
        payload: LeaveTypeUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> LeaveType:
        lt = await self.repo.get_by_id(LeaveType, lt_id)
        if not lt:
            raise NotFoundException(f"Leave type with ID '{lt_id}' not found.")

        for key, value in payload.model_dump(exclude_unset=True).items():
            setattr(lt, key, value)

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="LEAVE_TYPE",
            entity_id=lt.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return lt

    # ==========================================================================
    # Tasks: Statuses, Priorities & Transitions
    # ==========================================================================
    async def create_task_status(
        self,
        payload: TaskStatusCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> TaskStatus:
        stmt = select(TaskStatus).where(TaskStatus.code == payload.code.strip())
        if (await self.session.execute(stmt)).scalar_one_or_none():
            raise ConflictException(f"Task status with code '{payload.code}' already exists.")

        ts = TaskStatus(**payload.model_dump())
        self.session.add(ts)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="TASK_STATUS",
            entity_id=ts.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return ts

    async def update_task_status(
        self,
        ts_id: uuid.UUID,
        payload: TaskStatusUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> TaskStatus:
        ts = await self.repo.get_by_id(TaskStatus, ts_id)
        if not ts:
            raise NotFoundException(f"Task status with ID '{ts_id}' not found.")

        for key, value in payload.model_dump(exclude_unset=True).items():
            setattr(ts, key, value)

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="TASK_STATUS",
            entity_id=ts.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return ts

    async def create_task_priority(
        self,
        payload: TaskPriorityCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> TaskPriority:
        stmt = select(TaskPriority).where(TaskPriority.code == payload.code.strip())
        if (await self.session.execute(stmt)).scalar_one_or_none():
            raise ConflictException(f"Task priority with code '{payload.code}' already exists.")

        tp = TaskPriority(**payload.model_dump())
        self.session.add(tp)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="TASK_PRIORITY",
            entity_id=tp.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return tp

    async def update_task_priority(
        self,
        tp_id: uuid.UUID,
        payload: TaskPriorityUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> TaskPriority:
        tp = await self.repo.get_by_id(TaskPriority, tp_id)
        if not tp:
            raise NotFoundException(f"Task priority with ID '{tp_id}' not found.")

        for key, value in payload.model_dump(exclude_unset=True).items():
            setattr(tp, key, value)

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="TASK_PRIORITY",
            entity_id=tp.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return tp

    async def create_task_transition(
        self,
        payload: TaskStatusTransitionCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> TaskStatusTransition:
        existing = await self.repo.get_transition(payload.from_status_id, payload.to_status_id)
        if existing:
            raise ConflictException("Status transition already exists between these states.")

        tr = TaskStatusTransition(**payload.model_dump())
        self.session.add(tr)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="TASK_STATUS_TRANSITION",
            entity_id=tr.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return tr

    async def delete_task_transition(
        self,
        from_id: uuid.UUID,
        to_id: uuid.UUID,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> None:
        tr = await self.repo.get_transition(from_id, to_id)
        if not tr:
            raise NotFoundException("Task status transition not found.")

        await self.session.delete(tr)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="DELETE",
            entity_type="TASK_STATUS_TRANSITION",
            entity_id=f"{from_id}->{to_id}",
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()

    # ==========================================================================
    # Clients & Projects
    # ==========================================================================
    # ==========================================================================
    # Clients & Projects
    # ==========================================================================
    async def create_client(
        self,
        payload: ClientCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Client:
        client = Client(
            name=payload.name.strip(),
            contact_details={
                "contact_person": payload.contact_person,
                "email": payload.email,
                "phone": payload.phone,
                "address": payload.address,
            },
        )
        self.session.add(client)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="CLIENT",
            entity_id=client.id,
            actor_id=actor_id,
            new_data={"name": client.name},
            request=request,
        )
        await self.session.commit()
        return client

    async def update_client(
        self,
        client_id: uuid.UUID,
        payload: ClientUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Client:
        client = await self.repo.get_by_id(Client, client_id)
        if not client:
            raise NotFoundException(f"Client with ID '{client_id}' not found.")

        if payload.name is not None:
            client.name = payload.name.strip()

        details = dict(client.contact_details) if client.contact_details else {}
        if payload.contact_person is not None:
            details["contact_person"] = payload.contact_person
        if payload.email is not None:
            details["email"] = payload.email
        if payload.phone is not None:
            details["phone"] = payload.phone
        if payload.address is not None:
            details["address"] = payload.address
        client.contact_details = details

        if payload.is_active is not None:
            client.is_active = payload.is_active

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="CLIENT",
            entity_id=client.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return client

    async def create_project(
        self,
        payload: ProjectCreate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Project:
        client = await self.repo.get_by_id(Client, payload.client_id)
        if not client:
            raise NotFoundException(f"Client with ID '{payload.client_id}' not found.")

        project = Project(
            client_id=payload.client_id,
            name=payload.name.strip(),
            description=payload.description,
            start_date=payload.start_date,
            end_date=payload.end_date,
        )
        self.session.add(project)
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="PROJECT",
            entity_id=project.id,
            actor_id=actor_id,
            new_data={"name": project.name},
            request=request,
        )
        await self.session.commit()
        return project

    async def update_project(
        self,
        project_id: uuid.UUID,
        payload: ProjectUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> Project:
        project = await self.repo.get_by_id(Project, project_id)
        if not project:
            raise NotFoundException(f"Project with ID '{project_id}' not found.")

        if payload.client_id:
            client = await self.repo.get_by_id(Client, payload.client_id)
            if not client:
                raise NotFoundException(f"Client with ID '{payload.client_id}' not found.")
            project.client_id = payload.client_id

        if payload.name is not None:
            project.name = payload.name.strip()
        if payload.description is not None:
            project.description = payload.description
        if payload.start_date is not None:
            project.start_date = payload.start_date
        if payload.end_date is not None:
            project.end_date = payload.end_date
        if payload.status is not None:
            project.status = payload.status
        if payload.is_active is not None:
            project.is_active = payload.is_active

        await self.session.commit()
        await AuditService.record(
            self.session,
            action="UPDATE",
            entity_type="PROJECT",
            entity_id=project.id,
            actor_id=actor_id,
            request=request,
        )
        await self.session.commit()
        return project

    # ==========================================================================
    # Dynamic System Settings (Zero Hardcoding)
    # ==========================================================================
    async def upsert_setting(
        self,
        payload: SystemSettingCreateUpdate,
        actor_id: uuid.UUID,
        request: Request | None = None,
    ) -> SystemSetting:
        setting = await self.repo.upsert_setting(
            key=payload.key,
            value=payload.value,
            description=payload.description,
        )
        await self.session.commit()

        await AuditService.record(
            self.session,
            action="UPSERT_SETTING",
            entity_type="SYSTEM_SETTING",
            entity_id=setting.key,
            actor_id=actor_id,
            new_data={"key": setting.key, "value": setting.value},
            request=request,
        )
        await self.session.commit()
        return setting

    async def get_setting(self, key: str) -> SystemSetting:
        setting = await self.repo.get_setting(key)
        if not setting:
            raise NotFoundException(f"System setting '{key}' not found.")
        return setting

    async def list_settings(self) -> list[SystemSetting]:
        return await self.repo.list_settings()
