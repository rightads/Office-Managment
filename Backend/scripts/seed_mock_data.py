"""
Comprehensive Mock Data Seeding Script for Right Ads Management App.
Seeds 11 realistic employee profiles across all non-admin roles, complete with:
- Profiles & Argon2 hashed passwords
- Leave balances and historical + pending leave requests
- Past 5 days of geofenced attendance logs with calculated work minutes
- Real agency clients and projects
- Role-specific tasks with assignees, priorities, statuses, and comments
- Itemized daily work reports (timesheets)
- In-app notification inbox items
"""
from __future__ import annotations

import asyncio
import datetime
import uuid
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import async_session_factory
from app.core.security import hash_password
from app.models.organization import Department
from app.models.rbac import Role
from app.models.user import User
from app.models.attendance import AttendancePolicy, AttendanceRecord, AttendanceStatus
from app.models.leave import LeaveBalance, LeaveRequest, LeaveType
from app.models.task import Client, Project, Task, TaskAssignee, TaskComment, TaskPriority, TaskStatus
from app.models.work_report import WorkReport, WorkReportItem, WorkReportStatus
from app.models.communication import Notification

UNIFIED_PASSWORD = "Employee@RightAds2026!"

EMPLOYEES_CONFIG = [
    {
        "role_name": "HR",
        "dept_name": "HR",
        "code": "EMP-HR-001",
        "name": "Pooja Sharma",
        "email": "hr@rightads.com",
        "phone": "+91 98765 43210",
        "designation": "HR Manager",
        "tasks": [
            ("Conduct Q4 Employee Performance Appraisals", "Finalize appraisal review cycle and aggregate department scores.", "IN_PROGRESS", "HIGH"),
            ("Revise Workplace Attendance & Leave Policy 2026", "Incorporate flexible remote-work and compensatory off rules.", "TODO", "MEDIUM"),
        ],
    },
    {
        "role_name": "Accounts",
        "dept_name": "Accounts",
        "code": "EMP-ACC-001",
        "name": "Rohan Verma",
        "email": "accounts@rightads.com",
        "phone": "+91 98765 43211",
        "designation": "Senior Financial Accountant",
        "tasks": [
            ("Generate Monthly Client Invoices for October", "Reconcile retainers and ad-spend disbursements for Apex and Nexus.", "IN_REVIEW", "HIGH"),
            ("Process Quarterly Tax Returns & TDS Ledger", "Audit contractor invoices and file quarterly TDS statement.", "TODO", "HIGH"),
        ],
    },
    {
        "role_name": "CSD",
        "dept_name": "CSD",
        "code": "EMP-CSD-001",
        "name": "Ananya Iyer",
        "email": "csd@rightads.com",
        "phone": "+91 98765 43212",
        "designation": "Client Service Director",
        "tasks": [
            ("Client Onboarding Briefing: Urban Greens", "Align campaign goals, deliverable roadmaps, and stakeholder contacts.", "DONE", "HIGH"),
            ("Review Monthly Deliverables with Apex Leadership", "Prepare presentation deck showcasing campaign reach and conversions.", "IN_PROGRESS", "MEDIUM"),
        ],
    },
    {
        "role_name": "Sales & Marketing",
        "dept_name": "Sales & Marketing",
        "code": "EMP-MKT-001",
        "name": "Vikram Malhotra",
        "email": "sales@rightads.com",
        "phone": "+91 98765 43213",
        "designation": "Growth & Sales Lead",
        "tasks": [
            ("Pitch Digital Marketing Package to Fintech Enterprise", "Custom enterprise proposal focusing on ROI and conversion funnels.", "IN_PROGRESS", "HIGH"),
            ("Analyze Google & Meta Ad Spend Efficiency", "Review CPC and ROAS across active client campaigns.", "DONE", "MEDIUM"),
        ],
    },
    {
        "role_name": "Tele sales",
        "dept_name": "Tele sales",
        "code": "EMP-TLS-001",
        "name": "Neha Kapoor",
        "email": "telesales@rightads.com",
        "phone": "+91 98765 43214",
        "designation": "Telesales Executive",
        "tasks": [
            ("Outreach to 40 Real Estate Leads", "Qualify inbound inquiries and schedule product demos for sales team.", "IN_PROGRESS", "MEDIUM"),
            ("Follow-up on Warm Leads from October Webinar", "Send collateral brochures and verify budget expectations.", "TODO", "LOW"),
        ],
    },
    {
        "role_name": "Graphic designer",
        "dept_name": "Graphic Design",
        "code": "EMP-DES-001",
        "name": "Arjun Nair",
        "email": "graphic.designer@rightads.com",
        "phone": "+91 98765 43215",
        "designation": "Lead Visual Designer",
        "tasks": [
            ("Design Diwali Festive Ad Creative Suite (10 formats)", "Create high-converting static & animated display banners.", "IN_REVIEW", "HIGH"),
            ("Brand Identity Redesign for Horizon Tech", "Color palette, typography scale, and social media template library.", "IN_PROGRESS", "MEDIUM"),
        ],
    },
    {
        "role_name": "Website designer",
        "dept_name": "Website Design",
        "code": "EMP-WDS-001",
        "name": "Meera Patel",
        "email": "web.designer@rightads.com",
        "phone": "+91 98765 43216",
        "designation": "Senior Web UI/UX Designer",
        "tasks": [
            ("Figma Wireframes for E-Commerce Mobile Checkout", "High-fidelity mockups with interactive transitions and accessibility.", "DONE", "HIGH"),
            ("Design Responsive Landing Page for SaaS Lead Gen", "Optimize hero section, social proof cards, and pricing table.", "IN_PROGRESS", "MEDIUM"),
        ],
    },
    {
        "role_name": "Website development",
        "dept_name": "Website Development",
        "code": "EMP-WDEV-001",
        "name": "Karan Joshi",
        "email": "web.dev@rightads.com",
        "phone": "+91 98765 43217",
        "designation": "Full Stack Web Developer",
        "tasks": [
            ("Implement Core Web Vitals Performance Optimization", "Achieve 90+ Lighthouse score by minifying assets and lazy-loading images.", "IN_PROGRESS", "HIGH"),
            ("Integrate Stripe & Razorpay Multi-Currency Gateway", "Implement webhook listeners and idempotent checkout verification.", "DONE", "HIGH"),
        ],
    },
    {
        "role_name": "Web Application",
        "dept_name": "Web Application",
        "code": "EMP-WAPP-001",
        "name": "Siddharth Rao",
        "email": "webapp.dev@rightads.com",
        "phone": "+91 98765 43218",
        "designation": "Senior App Architect",
        "tasks": [
            ("Build Real-time WebSocket Notification Feed", "Implement Redis pub/sub handler for instant task status updates.", "IN_PROGRESS", "HIGH"),
            ("Develop Custom Reporting Export Engine (Excel & PDF)", "Stream formatted multi-sheet financial and attendance exports.", "TODO", "MEDIUM"),
        ],
    },
    {
        "role_name": "SEO",
        "dept_name": "SEO",
        "code": "EMP-SEO-001",
        "name": "Divya Menon",
        "email": "seo@rightads.com",
        "phone": "+91 98765 43219",
        "designation": "SEO Specialist & Strategist",
        "tasks": [
            ("Technical SEO Audit & Schema Markup Fixes", "Fix broken canonical tags, 404 crawl errors, and add Organization schema.", "DONE", "HIGH"),
            ("Targeted Keyword Research for Q1 2027 Campaigns", "Identify high-intent commercial keywords and competitor gaps.", "IN_PROGRESS", "MEDIUM"),
        ],
    },
    {
        "role_name": "GMB",
        "dept_name": "GMB",
        "code": "EMP-GMB-001",
        "name": "Rahul Saxena",
        "email": "gmb@rightads.com",
        "phone": "+91 98765 43220",
        "designation": "Google Business Profile Specialist",
        "tasks": [
            ("Optimize 15 Retail Store GMB Listings", "Update holiday operating hours, geotag photos, and publish weekly updates.", "IN_PROGRESS", "MEDIUM"),
            ("Reputation Management & Review Response Automation", "Draft responses for 50+ recent customer feedback reviews.", "DONE", "LOW"),
        ],
    },
]

CLIENTS_DATA = [
    {
        "name": "Apex Global Retail",
        "contact_details": {"contact_person": "Sunil Mehta", "email": "sunil@apexretail.com", "phone": "+91 98200 11223"},
        "projects": [
            {"name": "Q4 Festive Omnichannel Campaign", "description": "National multi-platform advertising blitz for festival season."},
        ],
    },
    {
        "name": "Nexus FinTech Labs",
        "contact_details": {"contact_person": "Kavita Reddy", "email": "kavita@nexusfintech.io", "phone": "+91 98200 44556"},
        "projects": [
            {"name": "Next-Gen Mobile Banking Web App", "description": "Complete UI/UX redesign and cloud application development."},
        ],
    },
    {
        "name": "Urban Greens Supermarket",
        "contact_details": {"contact_person": "Harish Gupta", "email": "harish@urbangreens.in", "phone": "+91 98200 77889"},
        "projects": [
            {"name": "Local Hyperlocal SEO & GMB Domination", "description": "Local search visibility across 20 metropolitan store locations."},
        ],
    },
]


async def seed_all_mock_data():
    print("Connecting to Supabase PostgreSQL database...")
    async with async_session_factory() as session:
        # 1. Fetch Admin user for reviewer/assigner foreign keys
        admin_res = await session.execute(select(User).where(User.email == "admin@rightads.com"))
        admin_user = admin_res.scalar_one_or_none()
        if not admin_user:
            raise RuntimeError("Admin user 'admin@rightads.com' not found! Please create admin first.")

        # 2. Fetch all roles and departments into lookup dicts
        roles_res = await session.execute(select(Role))
        roles_map = {r.name: r for r in roles_res.scalars().all()}

        depts_res = await session.execute(select(Department))
        depts_map = {d.name: d for d in depts_res.scalars().all()}

        # Attendance and Task Statuses
        att_stat_res = await session.execute(select(AttendanceStatus))
        att_stat_map = {s.code: s for s in att_stat_res.scalars().all()}

        task_stat_res = await session.execute(select(TaskStatus))
        task_stat_map = {s.code: s for s in task_stat_res.scalars().all()}

        task_prio_res = await session.execute(select(TaskPriority))
        task_prio_map = {p.code: p for p in task_prio_res.scalars().all()}

        leave_type_res = await session.execute(select(LeaveType))
        leave_types = leave_type_res.scalars().all()
        leave_type_map = {lt.name: lt for lt in leave_types}

        # 3. Create or Update Clients and Projects
        print("Seeding clients and projects...")
        project_pool: list[Project] = []
        for c_data in CLIENTS_DATA:
            stmt_c = select(Client).where(Client.name == c_data["name"])
            res_c = await session.execute(stmt_c)
            client_obj = res_c.scalar_one_or_none()
            if client_obj is None:
                client_obj = Client(
                    name=c_data["name"],
                    contact_details=c_data["contact_details"],
                    is_active=True,
                )
                session.add(client_obj)
                await session.flush()

            for p_data in c_data["projects"]:
                stmt_p = select(Project).where(
                    Project.name == p_data["name"],
                    Project.client_id == client_obj.id,
                )
                res_p = await session.execute(stmt_p)
                proj_obj = res_p.scalar_one_or_none()
                if proj_obj is None:
                    proj_obj = Project(
                        client_id=client_obj.id,
                        name=p_data["name"],
                        description=p_data["description"],
                        start_date=datetime.date(2026, 10, 1),
                        end_date=datetime.date(2026, 12, 31),
                        status="active",
                        is_active=True,
                    )
                    session.add(proj_obj)
                    await session.flush()
                project_pool.append(proj_obj)

        # 4. Hash unified password once for efficiency
        hashed_pw = hash_password(UNIFIED_PASSWORD)

        created_users: list[User] = []

        # 5. Seed Employees
        print("Seeding 11 employee accounts...")
        for emp in EMPLOYEES_CONFIG:
            role = roles_map.get(emp["role_name"])
            dept = depts_map.get(emp["dept_name"])
            if not role or not dept:
                print(f"Skipping {emp['name']}: role '{emp['role_name']}' or dept '{emp['dept_name']}' missing.")
                continue

            stmt_u = select(User).where(User.email == emp["email"])
            res_u = await session.execute(stmt_u)
            user_obj = res_u.scalar_one_or_none()

            if user_obj is None:
                user_obj = User(
                    employee_code=emp["code"],
                    email=emp["email"],
                    full_name=emp["name"],
                    phone=emp["phone"],
                    designation=emp["designation"],
                    role_id=role.id,
                    department_id=dept.id,
                    password_hash=hashed_pw,
                    is_active=True,
                    must_change_password=False,
                )
                session.add(user_obj)
                await session.flush()
            else:
                user_obj.full_name = emp["name"]
                user_obj.designation = emp["designation"]
                user_obj.role_id = role.id
                user_obj.department_id = dept.id
                user_obj.password_hash = hashed_pw
                user_obj.is_active = True
                user_obj.must_change_password = False

            created_users.append(user_obj)

            # --- A. Seed Leave Balances for 2026 ---
            for lt in leave_types:
                stmt_lb = select(LeaveBalance).where(
                    LeaveBalance.user_id == user_obj.id,
                    LeaveBalance.leave_type_id == lt.id,
                    LeaveBalance.year == 2026,
                )
                res_lb = await session.execute(stmt_lb)
                if res_lb.scalar_one_or_none() is None:
                    session.add(
                        LeaveBalance(
                            user_id=user_obj.id,
                            leave_type_id=lt.id,
                            year=2026,
                            allocated=float(lt.annual_quota if lt.annual_quota > 0 else 10),
                            carried_forward=0.0,
                            used=1.0 if lt.name == "Casual Leave" else 0.0,
                        )
                    )

            # --- B. Seed Leave Requests (1 Approved, 1 Pending) ---
            casual_lt = leave_type_map.get("Casual Leave", leave_types[0])
            sick_lt = leave_type_map.get("Sick Leave", leave_types[1] if len(leave_types) > 1 else casual_lt)

            # Approved past leave
            stmt_lr_past = select(LeaveRequest).where(
                LeaveRequest.user_id == user_obj.id,
                LeaveRequest.from_date == datetime.date(2026, 10, 5),
            )
            if (await session.execute(stmt_lr_past)).scalar_one_or_none() is None:
                session.add(
                    LeaveRequest(
                        user_id=user_obj.id,
                        leave_type_id=casual_lt.id,
                        from_date=datetime.date(2026, 10, 5),
                        to_date=datetime.date(2026, 10, 5),
                        is_half_day=False,
                        total_days=1.0,
                        reason="Family medical appointment",
                        status="approved",
                        reviewed_by=admin_user.id,
                        reviewed_at=datetime.datetime(2026, 10, 4, 11, 0, tzinfo=datetime.timezone.utc),
                        review_note="Approved. Hope all goes well.",
                    )
                )

            # Pending upcoming leave
            stmt_lr_pend = select(LeaveRequest).where(
                LeaveRequest.user_id == user_obj.id,
                LeaveRequest.from_date == datetime.date(2026, 11, 2),
            )
            if (await session.execute(stmt_lr_pend)).scalar_one_or_none() is None:
                session.add(
                    LeaveRequest(
                        user_id=user_obj.id,
                        leave_type_id=sick_lt.id,
                        from_date=datetime.date(2026, 11, 2),
                        to_date=datetime.date(2026, 11, 3),
                        is_half_day=False,
                        total_days=2.0,
                        reason="Doctor scheduled minor procedure",
                        status="pending",
                    )
                )

            # --- C. Seed Past 5 Days Attendance Logs ---
            # Dates: Oct 19 - Oct 23, 2026 (Mon - Fri)
            attendance_fixtures = [
                (datetime.date(2026, 10, 19), "PRESENT", 9, 15, 18, 15, 540),
                (datetime.date(2026, 10, 20), "PRESENT", 9, 10, 18, 20, 550),
                (datetime.date(2026, 10, 21), "LATE", 9, 45, 18, 30, 525),
                (datetime.date(2026, 10, 22), "PRESENT", 9, 20, 18, 0, 520),
                (datetime.date(2026, 10, 23), "HALF_DAY", 9, 30, 14, 0, 270),
            ]
            for log_date, stat_code, in_h, in_m, out_h, out_m, tot_m in attendance_fixtures:
                stmt_att = select(AttendanceRecord).where(
                    AttendanceRecord.user_id == user_obj.id,
                    AttendanceRecord.date == log_date,
                )
                if (await session.execute(stmt_att)).scalar_one_or_none() is None:
                    st_obj = att_stat_map.get(stat_code, att_stat_map.get("PRESENT"))
                    session.add(
                        AttendanceRecord(
                            user_id=user_obj.id,
                            date=log_date,
                            check_in_at=datetime.datetime(2026, 10, log_date.day, in_h, in_m, tzinfo=datetime.timezone.utc),
                            check_out_at=datetime.datetime(2026, 10, log_date.day, out_h, out_m, tzinfo=datetime.timezone.utc),
                            check_in_lat=19.0760,
                            check_in_lng=72.8777,
                            check_out_lat=19.0760,
                            check_out_lng=72.8777,
                            status_id=st_obj.id,
                            total_minutes=tot_m,
                            is_manual=False,
                            source="mobile_app",
                            remarks="Biometric geofence verified",
                        )
                    )

            # --- D. Seed Role-Specific Tasks ---
            selected_proj = project_pool[len(created_users) % len(project_pool)]
            for title, desc, stat_code, prio_code in emp["tasks"]:
                stmt_t = select(Task).where(
                    Task.title == title,
                    Task.department_id == dept.id,
                )
                res_t = await session.execute(stmt_t)
                task_obj = res_t.scalar_one_or_none()
                status_obj = task_stat_map.get(stat_code, task_stat_map.get("TODO"))
                prio_obj = task_prio_map.get(prio_code, task_prio_map.get("MEDIUM"))

                if task_obj is None:
                    task_obj = Task(
                        title=title,
                        description=desc,
                        department_id=dept.id,
                        client_id=selected_proj.client_id,
                        project_id=selected_proj.id,
                        priority_id=prio_obj.id,
                        status_id=status_obj.id,
                        assigned_by=admin_user.id,
                        due_at=datetime.datetime(2026, 10, 30, 18, 0, tzinfo=datetime.timezone.utc),
                        is_active=True,
                    )
                    session.add(task_obj)
                    await session.flush()

                    # Add Assignee
                    session.add(
                        TaskAssignee(
                            task_id=task_obj.id,
                            user_id=user_obj.id,
                        )
                    )

                    # Add sample comments
                    session.add(
                        TaskComment(
                            task_id=task_obj.id,
                            user_id=admin_user.id,
                            comment=f"Please focus on this deliverable for {selected_proj.name}. High client priority.",
                        )
                    )
                    session.add(
                        TaskComment(
                            task_id=task_obj.id,
                            user_id=user_obj.id,
                            comment="Understood! Working on the initial draft today. Will submit for review soon.",
                        )
                    )

            # --- E. Seed Daily Work Reports (Timesheets) ---
            # Past 2 days: Oct 22 and Oct 23
            for r_day, r_summary in [
                (datetime.date(2026, 10, 22), "Completed milestone deliverables and joined sprint alignment call."),
                (datetime.date(2026, 10, 23), "Finalized weekly handoff items and submitted review notes."),
            ]:
                stmt_wr = select(WorkReport).where(
                    WorkReport.user_id == user_obj.id,
                    WorkReport.report_date == r_day,
                )
                if (await session.execute(stmt_wr)).scalar_one_or_none() is None:
                    wr_obj = WorkReport(
                        user_id=user_obj.id,
                        report_date=r_day,
                        summary=r_summary,
                        status=WorkReportStatus.SUBMITTED.value,
                        submitted_at=datetime.datetime(2026, 10, r_day.day, 18, 30, tzinfo=datetime.timezone.utc),
                        reviewed_by=admin_user.id,
                        reviewed_at=datetime.datetime(2026, 10, r_day.day, 19, 0, tzinfo=datetime.timezone.utc),
                        review_note="Great job on meeting the milestone goals.",
                    )
                    session.add(wr_obj)
                    await session.flush()

                    # Add 2 detailed work report items
                    session.add(
                        WorkReportItem(
                            report_id=wr_obj.id,
                            client_id=selected_proj.client_id,
                            project_id=selected_proj.id,
                            description=f"Core deliverable execution: {emp['tasks'][0][0]}",
                            minutes_spent=270,
                        )
                    )
                    session.add(
                        WorkReportItem(
                            report_id=wr_obj.id,
                            client_id=selected_proj.client_id,
                            project_id=selected_proj.id,
                            description="Client communication, internal reviews, and documentation",
                            minutes_spent=180,
                        )
                    )

            # --- F. Seed In-App Notifications ---
            notifications_data = [
                ("New Task Assigned", f"You have been assigned to: '{emp['tasks'][0][0]}'", "task_assigned", False),
                ("Attendance Logged", "Your geofenced check-in for today was registered successfully.", "attendance", True),
                ("Leave Request Approved", "Your Casual Leave request for Oct 05 was approved by Admin.", "leave_status", True),
                ("Company All-Hands Meeting", "Join the monthly digital agency townhall on Friday at 4:00 PM.", "announcement", False),
            ]
            for n_title, n_body, n_type, n_read in notifications_data:
                stmt_notif = select(Notification).where(
                    Notification.user_id == user_obj.id,
                    Notification.title == n_title,
                )
                if (await session.execute(stmt_notif)).scalar_one_or_none() is None:
                    session.add(
                        Notification(
                            user_id=user_obj.id,
                            title=n_title,
                            body=n_body,
                            type=n_type,
                            data={"target_route": "/tasks" if "Task" in n_title else "/attendance"},
                            is_read=n_read,
                        )
                    )

        await session.commit()
        print("\nAll 11 employee accounts and full operational histories have been seeded into Supabase!")


if __name__ == "__main__":
    asyncio.run(seed_all_mock_data())
