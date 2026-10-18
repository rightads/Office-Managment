import os
import re

ROLES = [
    "Admin",
    "HR",
    "Accounts",
    "Tele sales",
    "Sales & Marketing",
    "CSD",
    "Graphic designer",
    "Website designer",
    "Website development",
    "Web Application",
    "SEO",
    "GMB",
]

STATUS_LITERALS = [
    "pending",
    "approved",
    "rejected",
    "cancelled",
    "PRESENT",
    "ABSENT",
    "HALF_DAY",
    "LATE",
    "ON_LEAVE",
    "WEEK_OFF",
    "HOLIDAY",
]


def scan_codebase():
    findings = []
    for root, _, files in os.walk("app"):
        for f in files:
            if not f.endswith(".py"):
                continue
            path = os.path.join(root, f)
            if "permissions_registry.py" in f or "seed" in f:
                continue

            with open(path, encoding="utf-8") as file:
                lines = file.readlines()

            for idx, line in enumerate(lines, 1):
                clean_line = line.strip()
                if clean_line.startswith("#"):
                    continue

                # 1. Role comparisons
                for role in ROLES:
                    pat = rf'(==|!=)\s*["\']{re.escape(role)}["\']|["\']{re.escape(role)}["\']\s*(==|!=)'
                    if re.search(pat, line):
                        findings.append((path, idx, "ROLE_NAME_COMPARISON", clean_line))

                # 2. General role equality checks (e.g. if role == ...)
                if re.search(r"\b(user\.role|role\.name|role)\s*(==|!=)\s*", line):
                    # Exclude type annotations and SQLAlchemy select queries where Role.name == ... for master lookups if any
                    if not any(
                        token in line
                        for token in ["Role.", "Mapped[", ": Role", "role: Role", "role_id"]
                    ):
                        findings.append((path, idx, "GENERIC_ROLE_CHECK", clean_line))

                # 3. Raw status string literals in comparisons
                for st in STATUS_LITERALS:
                    pat = rf'(==|!=|in)\s*\(?.*["\']{re.escape(st)}["\']'
                    if re.search(pat, line) and "status" in line.lower():
                        findings.append((path, idx, "STATUS_LITERAL_COMPARISON", clean_line))

                # 4. Department name comparisons
                if "department.name ==" in line or '== "Engineering"' in line:
                    findings.append((path, idx, "DEPARTMENT_NAME_COMPARISON", clean_line))

                # 5. Hardcoded timezones or URLs
                if (
                    '"Asia/Kolkata"' in line
                    or "'Asia/Kolkata'" in line
                    or '"UTC"' in line
                    or "'UTC'" in line
                ):
                    if "timezone" not in path and "config.py" not in path:
                        findings.append((path, idx, "HARDCODED_TIMEZONE", clean_line))

                # 6. Emails
                if (
                    re.search(r"[\w\.-]+@[\w\.-]+\.\w+", line)
                    and "config.py" not in path
                    and "constants.py" not in path
                ):
                    findings.append((path, idx, "HARDCODED_EMAIL", clean_line))

                # 7. URLs
                if (
                    re.search(r'https?://[^\s"\'>]+', line)
                    and "config.py" not in path
                    and "storage_service.py" not in path
                    and "rate_limiter.py" not in path
                    and "router" not in clean_line
                ):
                    findings.append((path, idx, "HARDCODED_URL", clean_line))

    return findings


if __name__ == "__main__":
    results = scan_codebase()
    print(f"Total findings: {len(results)}")
    for path, idx, kind, code in results:
        print(f"[{kind}] {path}:{idx}: {code}")
