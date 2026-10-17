from __future__ import annotations

import uuid

from sqlalchemy import func, or_, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.rbac import Role
from app.models.user import User


class EmployeeRepository:
    """Persistence operations for employee user entities."""

    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    async def get_by_id(self, user_id: uuid.UUID) -> User | None:
        """Fetches employee by ID with related metadata preloaded."""
        stmt = (
            select(User)
            .where(User.id == user_id, User.deleted_at.is_(None))
            .options(
                selectinload(User.role).selectinload(Role.permissions),
                selectinload(User.department),
                selectinload(User.attendance_policy),
                selectinload(User.manager),
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_by_email(self, email: str) -> User | None:
        """Fetches employee by unique email address."""
        stmt = (
            select(User)
            .where(func.lower(User.email) == email.strip().lower(), User.deleted_at.is_(None))
            .options(selectinload(User.role))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

    async def get_by_code(self, code: str) -> User | None:
        """Fetches employee by unique employee code."""
        stmt = (
            select(User)
            .where(User.employee_code == code.strip(), User.deleted_at.is_(None))
            .options(selectinload(User.role))
        )
        res = await self.session.execute(stmt)
        return res.scalar_one_or_none()

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
    ) -> tuple[list[User], int]:
        """Lists employees with search, multi-field filtering, sorting, and pagination."""
        stmt = select(User).where(User.deleted_at.is_(None))
        count_stmt = select(func.count()).select_from(User).where(User.deleted_at.is_(None))

        # Search term on full name, email, employee code, or phone number
        if search:
            pattern = f"%{search.strip().lower()}%"
            filter_search = or_(
                func.lower(User.full_name).ilike(pattern),
                func.lower(User.email).ilike(pattern),
                func.lower(User.employee_code).ilike(pattern),
                User.phone.ilike(pattern),
            )
            stmt = stmt.where(filter_search)
            count_stmt = count_stmt.where(filter_search)

        if department_id is not None:
            stmt = stmt.where(User.department_id == department_id)
            count_stmt = count_stmt.where(User.department_id == department_id)

        if role_id is not None:
            stmt = stmt.where(User.role_id == role_id)
            count_stmt = count_stmt.where(User.role_id == role_id)

        if is_active is not None:
            stmt = stmt.where(User.is_active == is_active)
            count_stmt = count_stmt.where(User.is_active == is_active)

        total_res = await self.session.execute(count_stmt)
        total = total_res.scalar_one()

        # Sorting
        sort_col = getattr(User, sort_by, User.created_at)
        if sort_order.lower() == "asc":
            stmt = stmt.order_by(sort_col.asc())
        else:
            stmt = stmt.order_by(sort_col.desc())

        # Pagination
        offset = (page - 1) * page_size
        stmt = (
            stmt.offset(offset)
            .limit(page_size)
            .options(
                selectinload(User.role),
                selectinload(User.department),
                selectinload(User.attendance_policy),
                selectinload(User.manager),
            )
        )

        res = await self.session.execute(stmt)
        return list(res.scalars().all()), total

    async def count_active_admins(self) -> int:
        """Counts active users holding an administrator role."""
        stmt = (
            select(func.count())
            .select_from(User)
            .join(Role, User.role_id == Role.id)
            .where(
                User.is_active.is_(True),
                User.deleted_at.is_(None),
                Role.name == "Admin",
            )
        )
        res = await self.session.execute(stmt)
        return res.scalar_one()

    async def count_total_employees(self) -> int:
        """Returns the total number of employees ever created (for sequential code generation)."""
        stmt = select(func.count()).select_from(User)
        res = await self.session.execute(stmt)
        return res.scalar_one()

    async def create(self, user: User) -> User:
        """Adds a new employee to the database session."""
        self.session.add(user)
        await self.session.flush()
        return user
