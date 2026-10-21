from __future__ import annotations

import csv
import datetime
import io
import re
import uuid
from typing import TYPE_CHECKING, Any

import openpyxl

from app.core.exceptions import (
    BadRequestException,
    ErrorDetail,
    ForbiddenException,
    NotFoundException,
)
from app.models.dynamic_module import (
    ModuleDefinition,
    ModuleField,
    ModuleRecord,
    ModuleRecordActivity,
    ModuleRecordAttachment,
    ModuleRecordComment,
    ModuleStatus,
)
from app.models.user import User
from app.repositories.dynamic_module_repository import DynamicModuleRepository
from app.repositories.user_repository import UserRepository
from app.schemas.dynamic_module import (
    ModuleDefinitionCreate,
    ModuleDefinitionResponse,
    ModuleDefinitionUpdate,
    ModuleFieldCreate,
    ModuleFieldResponse,
    ModuleFieldUpdate,
    ModuleRecordActivityResponse,
    ModuleRecordAttachmentCreate,
    ModuleRecordAttachmentResponse,
    ModuleRecordCommentCreate,
    ModuleRecordCommentResponse,
    ModuleRecordCreate,
    ModuleRecordDetailResponse,
    ModuleRecordPageResponse,
    ModuleRecordResponse,
    ModuleRecordStatusChange,
    ModuleRecordUpdate,
    ModuleStatusResponse,
    ModuleStatusTransitionResponse,
    ModuleSummaryResponse,
)
from app.services.audit_service import AuditService

if TYPE_CHECKING:
    from sqlalchemy.ext.asyncio import AsyncSession


class DynamicModuleService:
    """Service governing dynamic module schemas, records, status transitions, timeline, and exports."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.repo = DynamicModuleRepository(session)
        self.user_repo = UserRepository(session)

    # ---------------------------------------------------------------------------
    # Permissions Helper
    # ---------------------------------------------------------------------------

    async def _get_user_permissions(self, user: User) -> set[str]:
        return await self.user_repo.get_user_permissions(user)

    def _has_perm(self, permissions: set[str], perm: str) -> bool:
        return "*" in permissions or "modules.manage" in permissions or perm in permissions

    # ---------------------------------------------------------------------------
    # Validation Engine
    # ---------------------------------------------------------------------------

    @staticmethod
    def validate_record_data(
        fields: list[ModuleField],
        data: dict[str, Any],
        partial: bool = False,
    ) -> dict[str, str]:
        """Validates dynamic record JSON data against schema field specifications.

        Returns a dictionary of field_key -> error_message.
        """
        errors: dict[str, str] = {}
        fields_by_key = {f.key: f for f in fields if f.is_active}

        # 1. Check required fields
        if not partial:
            for f in fields:
                if not f.is_active or not f.is_required:
                    continue
                val = data.get(f.key)
                if val is None or (isinstance(val, str) and not val.strip()):
                    errors[f.key] = f"{f.label} is required."

        # 2. Type & rule checking for supplied keys
        for key, val in data.items():
            field = fields_by_key.get(key)
            if not field or val is None:
                continue

            # Text / Long Text
            if field.type in ("text", "long_text"):
                val_str = str(val).strip()
                if field.validation:
                    min_len = field.validation.get("min") or field.validation.get("min_length")
                    max_len = field.validation.get("max") or field.validation.get("max_length")
                    regex = field.validation.get("regex")
                    if min_len is not None and len(val_str) < int(min_len):
                        errors[key] = f"{field.label} must be at least {min_len} characters."
                    elif max_len is not None and len(val_str) > int(max_len):
                        errors[key] = f"{field.label} cannot exceed {max_len} characters."
                    elif regex and not re.match(regex, val_str):
                        errors[key] = f"{field.label} format is invalid."

            # Number / Currency
            elif field.type in ("number", "currency"):
                try:
                    num_val = float(val)
                    if field.validation:
                        min_val = field.validation.get("min")
                        max_val = field.validation.get("max")
                        if min_val is not None and num_val < float(min_val):
                            errors[key] = f"{field.label} must be at least {min_val}."
                        elif max_val is not None and num_val > float(max_val):
                            errors[key] = f"{field.label} cannot exceed {max_val}."
                except (ValueError, TypeError):
                    errors[key] = f"{field.label} must be a valid number."

            # Boolean
            elif field.type == "boolean":
                if not isinstance(val, bool) and str(val).lower() not in ("true", "false", "1", "0"):
                    errors[key] = f"{field.label} must be a boolean."

            # Date
            elif field.type == "date":
                val_str = str(val).split("T")[0]
                try:
                    datetime.date.fromisoformat(val_str)
                except ValueError:
                    errors[key] = f"{field.label} must be a valid date (YYYY-MM-DD)."

            # Datetime
            elif field.type == "datetime":
                try:
                    datetime.datetime.fromisoformat(str(val).replace("Z", "+00:00"))
                except ValueError:
                    errors[key] = f"{field.label} must be a valid ISO datetime."

            # Email
            elif field.type == "email":
                email_str = str(val).strip()
                if not re.match(r"^[^@\s]+@[^@\s]+\.[^@\s]+$", email_str):
                    errors[key] = f"{field.label} must be a valid email address."

            # Single Select
            elif field.type == "single_select":
                val_str = str(val).strip()
                if field.options:
                    valid_values = {str(opt.get("value")) for opt in field.options if isinstance(opt, dict)}
                    if val_str not in valid_values:
                        errors[key] = f"Invalid option '{val_str}' for {field.label}."

            # Multi Select
            elif field.type == "multi_select":
                if not isinstance(val, (list, tuple)):
                    errors[key] = f"{field.label} must be a list of values."
                elif field.options:
                    valid_values = {str(opt.get("value")) for opt in field.options if isinstance(opt, dict)}
                    for item in val:
                        if str(item) not in valid_values:
                            errors[key] = f"Invalid option '{item}' for {field.label}."
                            break

            # Geo point
            elif field.type == "geo_point":
                if isinstance(val, dict):
                    lat = val.get("latitude") or val.get("lat")
                    lng = val.get("longitude") or val.get("lng")
                    if lat is None or lng is None:
                        errors[key] = f"{field.label} must contain latitude and longitude."
                elif isinstance(val, str):
                    parts = val.split(",")
                    if len(parts) != 2:
                        errors[key] = f"{field.label} must be formatted as 'lat,lng'."

        return errors

    # ---------------------------------------------------------------------------
    # Module Definitions Management
    # ---------------------------------------------------------------------------

    async def get_definition(self, code: str, current_user: User | None = None) -> ModuleDefinitionResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")
        return ModuleDefinitionResponse.model_validate(definition)

    async def list_definitions(self, current_user: User) -> list[ModuleDefinitionResponse]:
        perms = await self._get_user_permissions(current_user)
        defs = await self.repo.list_definitions(active_only=True)
        # Filter modules where user has at least one permission
        visible = []
        for d in defs:
            if (
                self._has_perm(perms, "modules.manage")
                or self._has_perm(perms, f"module.{d.code}.view_all")
                or self._has_perm(perms, f"module.{d.code}.view_team")
                or self._has_perm(perms, f"module.{d.code}.view_own")
                or self._has_perm(perms, f"module.{d.code}.create")
            ):
                visible.append(ModuleDefinitionResponse.model_validate(d))
        return visible

    async def create_definition(
        self,
        payload: ModuleDefinitionCreate,
        current_user: User,
    ) -> ModuleDefinitionResponse:
        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message="Permission 'modules.manage' required to create module definitions.")

        existing = await self.repo.get_definition_by_code(payload.code)
        if existing:
            raise BadRequestException(message=f"Module code '{payload.code}' already exists.")

        definition = ModuleDefinition(
            code=payload.code.strip().lower(),
            label=payload.label.strip(),
            description=payload.description,
            record_label_singular=payload.record_label_singular,
            record_label_plural=payload.record_label_plural,
            is_active=payload.is_active,
            app_module_id=payload.app_module_id,
        )

        for idx, f_data in enumerate(payload.fields):
            definition.fields.append(
                ModuleField(
                    key=f_data.key.strip(),
                    label=f_data.label.strip(),
                    type=f_data.type,
                    is_required=f_data.is_required,
                    is_list_visible=f_data.is_list_visible,
                    is_filterable=f_data.is_filterable,
                    is_searchable=f_data.is_searchable,
                    options=f_data.options,
                    validation=f_data.validation,
                    default_value=f_data.default_value,
                    sort_order=f_data.sort_order or idx,
                    section=f_data.section,
                    is_active=f_data.is_active,
                )
            )

        for idx, s_data in enumerate(payload.statuses):
            definition.statuses.append(
                ModuleStatus(
                    code=s_data.code.strip().lower(),
                    label=s_data.label.strip(),
                    color=s_data.color,
                    sort_order=s_data.sort_order or idx,
                    is_terminal=s_data.is_terminal,
                    required_permission=s_data.required_permission,
                    is_active=s_data.is_active,
                )
            )

        await self.repo.create_definition(definition)
        await self.session.commit()
        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type="MODULE_DEFINITION",
            entity_id=definition.id,
            actor_id=current_user.id,
        )
        loaded = await self.repo.get_definition_by_id(definition.id)
        return ModuleDefinitionResponse.model_validate(loaded or definition)

    async def update_definition(
        self,
        code: str,
        payload: ModuleDefinitionUpdate,
        current_user: User,
    ) -> ModuleDefinitionResponse:
        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message="Permission 'modules.manage' required.")

        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        if payload.label is not None:
            definition.label = payload.label.strip()
        if payload.description is not None:
            definition.description = payload.description
        if payload.record_label_singular is not None:
            definition.record_label_singular = payload.record_label_singular
        if payload.record_label_plural is not None:
            definition.record_label_plural = payload.record_label_plural
        if payload.is_active is not None:
            definition.is_active = payload.is_active
        if payload.app_module_id is not None:
            definition.app_module_id = payload.app_module_id

        definition.version += 1
        await self.session.commit()
        loaded = await self.repo.get_definition_by_id(definition.id)
        return ModuleDefinitionResponse.model_validate(loaded or definition)

    async def add_field(
        self,
        code: str,
        payload: ModuleFieldCreate,
        current_user: User,
    ) -> ModuleFieldResponse:
        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message="Permission 'modules.manage' required.")

        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        # Check key uniqueness
        for f in definition.fields:
            if f.key.lower() == payload.key.lower().strip():
                raise BadRequestException(message=f"Field key '{payload.key}' already exists in module '{code}'.")

        field = ModuleField(
            module_id=definition.id,
            key=payload.key.strip(),
            label=payload.label.strip(),
            type=payload.type,
            is_required=payload.is_required,
            is_list_visible=payload.is_list_visible,
            is_filterable=payload.is_filterable,
            is_searchable=payload.is_searchable,
            options=payload.options,
            validation=payload.validation,
            default_value=payload.default_value,
            sort_order=payload.sort_order,
            section=payload.section,
            is_active=payload.is_active,
        )
        self.session.add(field)
        definition.version += 1
        await self.session.commit()
        await self.session.refresh(field)
        return ModuleFieldResponse.model_validate(field)

    async def update_field(
        self,
        code: str,
        field_id: uuid.UUID,
        payload: ModuleFieldUpdate,
        current_user: User,
    ) -> ModuleFieldResponse:
        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message="Permission 'modules.manage' required.")

        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        field = await self.repo.get_field_by_id(field_id)
        if not field or field.module_id != definition.id:
            raise NotFoundException(message=f"Field '{field_id}' not found in module '{code}'.")

        # Guard: If field is in use, cannot deactivate without warning
        if payload.is_active is False and field.is_active:
            in_use_count = await self.repo.count_records_using_field(definition.id, field.key)
            if in_use_count > 0:
                # Still allow deactivation, but keep historical record data intact
                pass

        if payload.label is not None:
            field.label = payload.label.strip()
        if payload.is_required is not None:
            field.is_required = payload.is_required
        if payload.is_list_visible is not None:
            field.is_list_visible = payload.is_list_visible
        if payload.is_filterable is not None:
            field.is_filterable = payload.is_filterable
        if payload.is_searchable is not None:
            field.is_searchable = payload.is_searchable
        if payload.options is not None:
            field.options = payload.options
        if payload.validation is not None:
            field.validation = payload.validation
        if payload.default_value is not None:
            field.default_value = payload.default_value
        if payload.sort_order is not None:
            field.sort_order = payload.sort_order
        if payload.section is not None:
            field.section = payload.section
        if payload.is_active is not None:
            field.is_active = payload.is_active

        definition.version += 1
        await self.session.commit()
        await self.session.refresh(field)
        return ModuleFieldResponse.model_validate(field)

    # ---------------------------------------------------------------------------
    # Module Records CRUD
    # ---------------------------------------------------------------------------

    async def list_records(
        self,
        code: str,
        current_user: User,
        page: int = 1,
        page_size: int = 20,
        search: str | None = None,
        status_id: uuid.UUID | None = None,
        status_code: str | None = None,
        assigned_to: uuid.UUID | None = None,
        client_id: uuid.UUID | None = None,
        from_date: datetime.date | None = None,
        to_date: datetime.date | None = None,
        sort_by: str | None = None,
        sort_desc: bool = True,
        dynamic_filters: dict[str, Any] | None = None,
    ) -> ModuleRecordPageResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        perms = await self._get_user_permissions(current_user)
        # Check read permission
        has_read = (
            self._has_perm(perms, "modules.manage")
            or self._has_perm(perms, f"module.{code}.view_all")
            or self._has_perm(perms, f"module.{code}.view_team")
            or self._has_perm(perms, f"module.{code}.view_own")
        )
        if not has_read:
            raise ForbiddenException(message=f"Missing view permission for module '{code}'.")

        searchable_fields = [f.key for f in definition.fields if f.is_searchable and f.is_active]

        records, total = await self.repo.list_records(
            module_id=definition.id,
            user=current_user,
            permissions=perms,
            module_code=code,
            page=page,
            page_size=page_size,
            search=search,
            status_id=status_id,
            status_code=status_code,
            assigned_to=assigned_to,
            client_id=client_id,
            from_date=from_date,
            to_date=to_date,
            sort_by=sort_by,
            sort_desc=sort_desc,
            searchable_fields=searchable_fields,
            dynamic_filters=dynamic_filters,
        )

        total_pages = (total + page_size - 1) // page_size if total > 0 else 1

        items = []
        for r in records:
            items.append(self._serialize_record(r, definition))

        return ModuleRecordPageResponse(
            items=items,
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
        )

    async def create_record(
        self,
        code: str,
        payload: ModuleRecordCreate,
        current_user: User,
    ) -> ModuleRecordResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, f"module.{code}.create") and not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message=f"Permission 'module.{code}.create' required.")

        # 1. Validate data against field definitions
        errors = self.validate_record_data(definition.fields, payload.data, partial=False)
        if errors:
            details = [
                ErrorDetail(loc=["data", k], msg=v, type="value_error")
                for k, v in errors.items()
            ]
            raise BadRequestException(message="Record data validation failed.", details=details)

        # 2. Determine initial status
        status_id = payload.status_id
        if not status_id and definition.statuses:
            status_id = definition.statuses[0].id

        record = ModuleRecord(
            module_id=definition.id,
            data=payload.data,
            status_id=status_id,
            created_by=current_user.id,
            assigned_to=payload.assigned_to,
            client_id=payload.client_id,
            due_at=payload.due_at,
        )

        self.session.add(record)
        await self.session.flush()

        # Add initial timeline activity
        activity = ModuleRecordActivity(
            record_id=record.id,
            user_id=current_user.id,
            action="created",
            details={"initial_status": str(status_id) if status_id else None},
        )
        self.session.add(activity)

        await self.session.commit()
        await self.session.refresh(record)

        await AuditService.record(
            self.session,
            action="CREATE",
            entity_type=f"MODULE_RECORD_{code.upper()}",
            entity_id=record.id,
            actor_id=current_user.id,
        )

        loaded = await self.repo.get_record_by_id(record.id, include_details=True)
        return self._serialize_record(loaded or record, definition)

    async def get_record(
        self,
        code: str,
        record_id: uuid.UUID,
        current_user: User,
    ) -> ModuleRecordDetailResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        record = await self.repo.get_record_by_id(record_id, include_details=True)
        if not record or record.module_id != definition.id:
            raise NotFoundException(message="Record not found.")

        # Check access scope
        perms = await self._get_user_permissions(current_user)
        self._check_record_access(record, current_user, perms, code)

        base_res = self._serialize_record(record, definition)

        comments = [
            ModuleRecordCommentResponse(
                id=c.id,
                record_id=c.record_id,
                user_id=c.user_id,
                user_name=c.user.full_name if c.user else "User",
                comment=c.comment,
                created_at=c.created_at,
            )
            for c in record.comments
        ]

        attachments = [
            ModuleRecordAttachmentResponse(
                id=a.id,
                record_id=a.record_id,
                user_id=a.user_id,
                user_name=a.user.full_name if a.user else "User",
                file_url=a.file_url,
                file_name=a.file_name,
                file_size=a.file_size,
                mime_type=a.mime_type,
                created_at=a.created_at,
            )
            for a in record.attachments
        ]

        activities = [
            ModuleRecordActivityResponse(
                id=act.id,
                record_id=act.record_id,
                user_id=act.user_id,
                user_name=act.user.full_name if act.user else "System",
                action=act.action,
                details=act.details,
                created_at=act.created_at,
            )
            for act in record.activities
        ]

        return ModuleRecordDetailResponse(
            **base_res.model_dump(),
            comments=comments,
            attachments=attachments,
            activities=activities,
        )

    async def update_record(
        self,
        code: str,
        record_id: uuid.UUID,
        payload: ModuleRecordUpdate,
        current_user: User,
    ) -> ModuleRecordResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        record = await self.repo.get_record_by_id(record_id, include_details=False)
        if not record or record.module_id != definition.id:
            raise NotFoundException(message="Record not found.")

        perms = await self._get_user_permissions(current_user)
        can_edit_all = self._has_perm(perms, f"module.{code}.edit_all") or self._has_perm(perms, "modules.manage")
        can_edit_own = self._has_perm(perms, f"module.{code}.edit_own") and (
            record.created_by == current_user.id or record.assigned_to == current_user.id
        )
        if not (can_edit_all or can_edit_own):
            raise ForbiddenException(message=f"Missing edit permission for record in module '{code}'.")

        # Validate partial data if updated
        if payload.data:
            merged_data = dict(record.data)
            merged_data.update(payload.data)
            errors = self.validate_record_data(definition.fields, merged_data, partial=True)
            if errors:
                details = [
                    ErrorDetail(loc=["data", k], msg=v, type="value_error")
                    for k, v in errors.items()
                ]
                raise BadRequestException(message="Record data validation failed.", details=details)
            record.data = merged_data

        if payload.assigned_to is not None:
            record.assigned_to = payload.assigned_to
        if payload.client_id is not None:
            record.client_id = payload.client_id
        if payload.due_at is not None:
            record.due_at = payload.due_at

        # Record activity
        activity = ModuleRecordActivity(
            record_id=record.id,
            user_id=current_user.id,
            action="updated",
            details={"updated_fields": list(payload.data.keys()) if payload.data else []},
        )
        self.session.add(activity)

        await self.session.commit()
        await self.session.refresh(record)

        loaded = await self.repo.get_record_by_id(record.id, include_details=True)
        return self._serialize_record(loaded or record, definition)

    async def change_status(
        self,
        code: str,
        record_id: uuid.UUID,
        payload: ModuleRecordStatusChange,
        current_user: User,
    ) -> ModuleRecordResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        record = await self.repo.get_record_by_id(record_id, include_details=False)
        if not record or record.module_id != definition.id:
            raise NotFoundException(message="Record not found.")

        perms = await self._get_user_permissions(current_user)
        can_edit = (
            self._has_perm(perms, f"module.{code}.edit_all")
            or self._has_perm(perms, "modules.manage")
            or (
                self._has_perm(perms, f"module.{code}.edit_own")
                and (record.created_by == current_user.id or record.assigned_to == current_user.id)
            )
        )
        if not can_edit:
            raise ForbiddenException(message="Permission required to change record status.")

        # Validate transition exists
        from_id = record.status_id
        to_id = payload.to_status_id

        # Find matching transition
        allowed_trans = [
            t for t in definition.transitions
            if t.from_status_id == from_id and t.to_status_id == to_id
        ]
        if not allowed_trans and from_id != to_id:
            # Check if admin or no transitions defined (open workflow)
            if definition.transitions:
                raise BadRequestException(message="Status transition is not permitted by workflow rules.")

        # Check required permission on transition if specified
        if allowed_trans:
            req_perm = allowed_trans[0].required_permission
            if req_perm and not self._has_perm(perms, req_perm):
                raise ForbiddenException(message=f"Permission '{req_perm}' required for this status transition.")

        old_status_label = record.status.label if record.status else None
        record.status_id = to_id

        activity = ModuleRecordActivity(
            record_id=record.id,
            user_id=current_user.id,
            action="status_changed",
            details={
                "from_status": str(from_id) if from_id else None,
                "to_status": str(to_id),
                "from_label": old_status_label,
                "note": payload.note,
            },
        )
        self.session.add(activity)

        await self.session.commit()
        await self.session.refresh(record)

        loaded = await self.repo.get_record_by_id(record.id, include_details=True)
        return self._serialize_record(loaded or record, definition)

    async def delete_record(
        self,
        code: str,
        record_id: uuid.UUID,
        current_user: User,
    ) -> None:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        record = await self.repo.get_record_by_id(record_id, include_details=False)
        if not record or record.module_id != definition.id:
            raise NotFoundException(message="Record not found.")

        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, f"module.{code}.delete") and not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message=f"Permission 'module.{code}.delete' required.")

        record.soft_delete()
        await self.session.commit()
        await AuditService.record(
            self.session,
            action="DELETE",
            entity_type=f"MODULE_RECORD_{code.upper()}",
            entity_id=record.id,
            actor_id=current_user.id,
        )

    async def add_comment(
        self,
        code: str,
        record_id: uuid.UUID,
        payload: ModuleRecordCommentCreate,
        current_user: User,
    ) -> ModuleRecordCommentResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        record = await self.repo.get_record_by_id(record_id, include_details=False)
        if not record or record.module_id != definition.id:
            raise NotFoundException(message="Record not found.")

        perms = await self._get_user_permissions(current_user)
        self._check_record_access(record, current_user, perms, code)

        comment = ModuleRecordComment(
            record_id=record.id,
            user_id=current_user.id,
            comment=payload.comment.strip(),
        )
        self.session.add(comment)

        activity = ModuleRecordActivity(
            record_id=record.id,
            user_id=current_user.id,
            action="comment_added",
            details={"comment_preview": payload.comment.strip()[:100]},
        )
        self.session.add(activity)

        await self.session.commit()
        await self.session.refresh(comment)

        return ModuleRecordCommentResponse(
            id=comment.id,
            record_id=comment.record_id,
            user_id=comment.user_id,
            user_name=current_user.full_name,
            comment=comment.comment,
            created_at=comment.created_at,
        )

    async def add_attachment(
        self,
        code: str,
        record_id: uuid.UUID,
        payload: ModuleRecordAttachmentCreate,
        current_user: User,
    ) -> ModuleRecordAttachmentResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        record = await self.repo.get_record_by_id(record_id, include_details=False)
        if not record or record.module_id != definition.id:
            raise NotFoundException(message="Record not found.")

        perms = await self._get_user_permissions(current_user)
        self._check_record_access(record, current_user, perms, code)

        attachment = ModuleRecordAttachment(
            record_id=record.id,
            user_id=current_user.id,
            file_url=payload.file_url,
            file_name=payload.file_name,
            file_size=payload.file_size,
            mime_type=payload.mime_type,
        )
        self.session.add(attachment)

        activity = ModuleRecordActivity(
            record_id=record.id,
            user_id=current_user.id,
            action="attachment_added",
            details={"file_name": payload.file_name},
        )
        self.session.add(activity)

        await self.session.commit()
        await self.session.refresh(attachment)

        return ModuleRecordAttachmentResponse(
            id=attachment.id,
            record_id=attachment.record_id,
            user_id=attachment.user_id,
            user_name=current_user.full_name,
            file_url=attachment.file_url,
            file_name=attachment.file_name,
            file_size=attachment.file_size,
            mime_type=attachment.mime_type,
            created_at=attachment.created_at,
        )

    # ---------------------------------------------------------------------------
    # Summary & Aggregates
    # ---------------------------------------------------------------------------

    async def get_summary(self, code: str, current_user: User) -> ModuleSummaryResponse:
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, f"module.{code}.view_all") and not self._has_perm(perms, "modules.manage"):
            # Check team/own
            if not self._has_perm(perms, f"module.{code}.view_team") and not self._has_perm(perms, f"module.{code}.view_own"):
                raise ForbiddenException(message="Permission required to inspect summary metrics.")

        numeric_keys = [
            f.key for f in definition.fields
            if f.is_active and f.type in ("currency", "number")
        ]

        summary_data = await self.repo.get_summary(definition, numeric_keys)
        return ModuleSummaryResponse(**summary_data)

    # ---------------------------------------------------------------------------
    # Export Engine (CSV / Excel)
    # ---------------------------------------------------------------------------

    async def export_records(
        self,
        code: str,
        current_user: User,
        export_format: str = "csv",
    ) -> tuple[bytes, str, str]:
        """Exports all records visible to [current_user] as CSV or XLSX bytes.

        Returns (content_bytes, media_type, filename).
        """
        definition = await self.repo.get_definition_by_code(code)
        if not definition:
            raise NotFoundException(message=f"Module '{code}' not found.")

        perms = await self._get_user_permissions(current_user)
        if not self._has_perm(perms, f"module.{code}.export") and not self._has_perm(perms, "modules.manage"):
            raise ForbiddenException(message=f"Permission 'module.{code}.export' required.")

        records, _ = await self.repo.list_records(
            module_id=definition.id,
            user=current_user,
            permissions=perms,
            module_code=code,
            page=1,
            page_size=10000,
        )

        visible_fields = [f for f in definition.fields if f.is_active and f.is_list_visible]
        headers = [f.label for f in visible_fields] + ["Status", "Created By", "Assigned To", "Created At"]

        rows = []
        for r in records:
            row = []
            for f in visible_fields:
                val = r.data.get(f.key, "")
                if isinstance(val, (dict, list)):
                    val = str(val)
                row.append(val)
            row.append(r.status.label if r.status else "")
            row.append(r.creator.full_name if r.creator else "")
            row.append(r.assignee.full_name if r.assignee else "")
            row.append(r.created_at.strftime("%Y-%m-%d %H:%M:%S"))
            rows.append(row)

        timestamp_str = datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%d_%H%M%S")

        if export_format.lower() == "xlsx":
            wb = openpyxl.Workbook()
            ws = wb.active
            ws.title = definition.label[:30]
            ws.append(headers)
            for r_data in rows:
                ws.append(r_data)
            out = io.BytesIO()
            wb.save(out)
            return (
                out.getvalue(),
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                f"{code}_export_{timestamp_str}.xlsx",
            )
        else:
            out_str = io.StringIO()
            writer = csv.writer(out_str)
            writer.writerow(headers)
            writer.writerows(rows)
            return (
                out_str.getvalue().encode("utf-8-sig"),
                "text/csv; charset=utf-8",
                f"{code}_export_{timestamp_str}.csv",
            )

    # ---------------------------------------------------------------------------
    # Internal Helpers
    # ---------------------------------------------------------------------------

    def _check_record_access(self, record: ModuleRecord, user: User, perms: set[str], code: str) -> None:
        if self._has_perm(perms, "modules.manage") or self._has_perm(perms, f"module.{code}.view_all"):
            return
        if self._has_perm(perms, f"module.{code}.view_team") and user.department_id:
            if (
                (record.creator and record.creator.department_id == user.department_id)
                or (record.assignee and record.assignee.department_id == user.department_id)
            ):
                return
        if (
            self._has_perm(perms, f"module.{code}.view_own")
            or self._has_perm(perms, f"module.{code}.create")
        ):
            if record.created_by == user.id or record.assigned_to == user.id:
                return

        raise ForbiddenException(message="Access denied to this record.")

    def _serialize_record(self, record: ModuleRecord, definition: ModuleDefinition) -> ModuleRecordResponse:
        creator_name = (
            record.creator.full_name
            if record.creator
            else None
        )
        assignee_name = (
            record.assignee.full_name
            if record.assignee
            else None
        )
        client_name = record.client.name if record.client else None

        allowed_transitions = [
            ModuleStatusTransitionResponse.model_validate(t)
            for t in definition.transitions
            if t.from_status_id == record.status_id
        ]

        return ModuleRecordResponse(
            id=record.id,
            module_id=record.module_id,
            data=record.data,
            status_id=record.status_id,
            status=ModuleStatusResponse.model_validate(record.status) if record.status else None,
            created_by=record.created_by,
            creator_name=creator_name,
            assigned_to=record.assigned_to,
            assignee_name=assignee_name,
            client_id=record.client_id,
            client_name=client_name,
            due_at=record.due_at,
            created_at=record.created_at,
            updated_at=record.updated_at,
            allowed_transitions=allowed_transitions,
        )
