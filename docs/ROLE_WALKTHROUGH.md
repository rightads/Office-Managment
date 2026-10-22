# Role Walkthrough & Verification Guide (Prompt 15)

## 1. Overview
The Right Ads employee app is designed around a single dynamic core:
- **Base Modules for All Employees**:
  - `attendance`: Check-in / out with geofencing, calendar history, regularization requests.
  - `tasks`: Assigned deliverables, checklists, status updates.
  - `leave`: Leave balances, new leave applications, holiday lists.
  - `work_reports`: Daily work logs, time budgeting, submission locks.
  - `announcements`: Corporate notices and department broadcasts.
  - `notifications`: Push and alert inbox.
  - `profile`: User personal information and security settings.
- **Dynamic Role Modules**:
  Extra modules appear on the home dashboard and adaptive navigation shell strictly according to data returned by `/me/navigation` and permission checks (`ref.can(...)`). The Flutter frontend contains zero hardcoded checks for role names.

---

## 2. Dynamic Field Action Verification Matrix

| Module & Target Role | Field Key & Type | Action / Interaction | Expected UI & Verification |
|---|---|---|---|
| **Leads & Pipeline** (Tele Sales, Sales & Marketing) | `phone` (`DynamicFieldType.phone`) | Tap-to-Call & Tap-to-WhatsApp | Displays phone number with inline dialer (`tel:`) and green chat (`wa.me/`) action buttons. |
| **Follow-ups** (Tele Sales, Sales & Marketing) | `next_follow_up` (`DynamicFieldType.date`) | Overdue & Due Today Highlighting | Highlights dates in the past with a red `Overdue` badge; highlights today with an orange `Due Today` badge. |
| **Client Visits** (Sales & Marketing) | `client_location` (`DynamicFieldType.geoPoint`) | One-tap GPS Capture | Form provides a "Capture GPS Location" button that queries `Geolocator` and writes current lat/lng to the record payload. Detail view renders Google Maps link. |
| **Design Requests** (Graphic & Web Designers) | `design_assets` (`DynamicFieldType.file` / `image`) | File selection & preview | Detail card displays link/preview to uploaded assets. |
| **Invoices & Billing** (Accounts) | `amount` (`DynamicFieldType.currency`) | Currency formatting & Total | Values format with currency symbol (`₹15000.00`). |

---

## 3. Screenshots & Verification Checklist for Manual QA

| Screen / Flow | Check Items | Verified |
|---|---|---|
| **Adaptive Shell (Mobile & Tablet)** | NavigationRail on tablets (>=600dp); BottomNavigationBar on mobile phones (<600dp). | [x] |
| **Role Simulator Screen** | Available in debug mode (`/dev/role-simulator`). Presets for Tele Sales, Accounts, CSD, Admin instantly switch shell modules. | [x] |
| **Phone & WhatsApp Action** | Tap phone icon triggers native dialer; tap chat icon opens WhatsApp Web / mobile app. | [x] |
| **GPS Coordinate Capture** | Tapping "Capture GPS Location" populates lat/lng coordinates and presents success notification. | [x] |
| **Zero Hardcoded Strings** | Test `no_hardcoded_strings_test.dart` passes with 0 violations across all widgets. | [x] |

---

## 4. Role Navigation Presets (QA Testing)

### Tele Sales
```json
{
  "modules": [
    {"code": "attendance", "label": "Attendance", "route_key": "attendance", "is_base": true},
    {"code": "tasks", "label": "Tasks", "route_key": "tasks", "is_base": true},
    {"code": "leads", "label": "Leads & Pipeline", "route_key": "leads", "is_base": false},
    {"code": "work_reports", "label": "Daily Work Report", "route_key": "work_reports", "is_base": true}
  ],
  "permissions": [
    "attendance.check_in",
    "attendance.view_own",
    "task.view_assigned",
    "task.update",
    "leave.apply",
    "leave.view_own",
    "announcement.view",
    "work_reports.submit_own",
    "leads.view_own",
    "leads.create",
    "leads.edit_own"
  ]
}
```

### Accounts
```json
{
  "modules": [
    {"code": "attendance", "label": "Attendance", "route_key": "attendance", "is_base": true},
    {"code": "invoices", "label": "Invoices & Billing", "route_key": "invoices", "is_base": false},
    {"code": "work_reports", "label": "Daily Work Report", "route_key": "work_reports", "is_base": true}
  ],
  "permissions": [
    "attendance.check_in",
    "attendance.view_own",
    "task.view_assigned",
    "leave.apply",
    "leave.view_own",
    "announcement.view",
    "work_reports.submit_own",
    "invoices.view_all",
    "invoices.create",
    "invoices.edit_all"
  ]
}
```
