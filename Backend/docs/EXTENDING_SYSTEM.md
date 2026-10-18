# Right Ads - Developer Guide: Extending the System

This guide walks through adding new features, modules, and permissions to the Right Ads platform while preserving the **Zero Hardcoding** architecture.

---

## 1. Adding a New Permission

Permissions are dynamic database rows. To add a new permission (e.g. `invoice.create`):

1. **Register the permission in `app/seed_data/roles_permissions.json`**:
   ```json
   {
     "code": "invoice.create",
     "category": "Invoicing",
     "description": "Create and issue client invoices"
   }
   ```
2. **Assign the permission to appropriate roles in the seed JSON**:
   Add `"invoice.create"` to the `permissions` array for `Admin` and `Accounts`.
3. **Run the seeding CLI command**:
   ```bash
   python -m app.cli.commands seed-permissions
   ```
4. **Use the permission in your API route**:
   ```python
   from app.dependencies.auth import require_permissions

   @router.post("/invoices", dependencies=[Depends(require_permissions("invoice.create"))])
   async def create_invoice(...):
       ...
   ```

---

## 2. Adding a New Data Model & Migration

All entity models must use `UUIDMixin`, `TimestampMixin`, and optionally `SoftDeleteMixin`.

1. **Define the SQLAlchemy 2.0 Model in `app/models/`**:
   ```python
   # app/models/invoice.py
   from __future__ import annotations
   import uuid
   from sqlalchemy import String, Float, ForeignKey, Uuid
   from sqlalchemy.orm import Mapped, mapped_column, relationship
   from app.models.base import Base, UUIDMixin, TimestampMixin


   class Invoice(Base, UUIDMixin, TimestampMixin):
       __tablename__ = "invoices"

       invoice_number: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
       client_id: Mapped[uuid.UUID] = mapped_column(
           Uuid(as_uuid=True), ForeignKey("clients.id"), nullable=False
       )
       amount: Mapped[float] = mapped_column(Float, nullable=False)
       status: Mapped[str] = mapped_column(String(50), default="draft", nullable=False)
   ```
2. **Export the model in `app/models/__init__.py`**:
   Add `Invoice` to imports and `__all__`.
3. **Generate and apply an Alembic migration**:
   ```bash
   alembic revision --autogenerate -m "create_invoices_table"
   alembic upgrade head
   ```

---

## 3. Creating Repository, Service, and Schemas

Follow the standard multi-tier design:

### 3.1 Pydantic Schemas (`app/schemas/invoice.py`)
```python
from pydantic import BaseModel, ConfigDict
import uuid


class InvoiceCreate(BaseModel):
    client_id: uuid.UUID
    amount: float


class InvoiceResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: uuid.UUID
    invoice_number: str
    amount: float
    status: str
```

### 3.2 Repository (`app/repositories/invoice_repository.py`)
```python
from app.repositories.base import BaseRepository
from app.models.invoice import Invoice


class InvoiceRepository(BaseRepository[Invoice]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Invoice, session)
```

### 3.3 Service (`app/services/invoice_service.py`)
```python
class InvoiceService:
    def __init__(self, session: AsyncSession) -> None:
        self.repo = InvoiceRepository(session)

    async def create_invoice(self, payload: InvoiceCreate) -> Invoice:
        # Enforce business rules
        ...
```

---

## 4. Mounting the API Router

1. Create `app/api/v1/endpoints/invoices.py` with standard `StandardResponse` envelopes.
2. Mount the router in `app/api/v1/router.py`:
   ```python
   from app.api.v1.endpoints import invoices

   api_v1_router.include_router(invoices.router)
   ```
3. Run the automated permission audit test:
   ```bash
   pytest tests/test_route_permissions.py
   ```
   If you forgot to add a security dependency (`require_permissions`), the test will immediately fail with the exact method and path.
