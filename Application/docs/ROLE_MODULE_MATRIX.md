# Role -> Extra Module Matrix (PROPOSAL - edit before running backend_addendum/A4)

Everyone gets the BASE app: Attendance, Tasks, Leave, Announcements, Notifications, Daily Work Report, Profile.
Roles and modules are DATA on the server. This table is only the input for the seed files in backend A4. The Flutter app never names these roles.

| Role | Extra modules (proposed) | Typical fields / actions |
|---|---|---|
| Tele Sales | Leads & Call Log, Follow-ups, Targets | lead name, phone, source, call outcome, next follow-up date, notes; one-tap call/WhatsApp |
| Sales & Marketing | Lead Pipeline, Client Visits, Quotations, Targets | stage, deal value, visit check-in (geo), quotation request, notes |
| CSD (Customer Service) | Customer Tickets, Complaints, Feedback | client, issue type, priority, status, resolution, escalation |
| Graphic Designer | Design Requests, Revisions, Asset Submission | client, brief, deadline, files, revision count, approval status |
| Website Designer | Design Mockups / Reviews, Asset Submission | project, page, mockup file, review status, feedback |
| Website Development | Dev Tickets, Bug Reports, Deployment Checklist | project, bug severity, status, environment, release notes |
| HR | Recruitment, Onboarding Checklist, Policies, Payroll Inputs | candidate, stage, interview date, onboarding tasks, policy documents |
| Accounts | Invoices, Payments, Expenses/Reimbursements, Salary Slips | client, invoice no., amount, due date, payment status, receipts |
| Web Application | App Tickets, Bug Reports, Release Tracker | project, module, severity, version, status |
| SEO | Keyword Tracker, Monthly SEO Reports, Backlink Log | client, keyword, rank, URL, report period, status |
| GMB | Listing Tracker, Review Monitor, Post Schedule | client, listing, rating, review reply status, post date |
| Admin | Team views of all above (view_team / view_all), reports | permission driven |
| Super Admin | Everything + roles/permissions, module builder, settings, audit logs | permission driven |

Notes:
- Simple record-based modules above are built with the DYNAMIC MODULE ENGINE (backend A3 + Flutter 11): a module is a definition (fields, statuses, permissions) not code.
- Complex features (invoice PDF generation, payroll calculation, rank API integrations, GMB API integration) are NOT in v1; they are separate future prompts.
