# Right Ads - Backup & Disaster Recovery Strategy

## 1. Strategy Overview
To guarantee Zero Data Loss and continuous business operations for the marketing agency, the platform follows a **3-2-1 backup strategy**:
- **3 copies** of data: Production primary DB, local automated snapshot, and offsite cloud replica.
- **2 different media**: Fast local NVMe storage and remote Amazon S3 bucket.
- **1 offsite copy**: Stored in a separate AWS region or external cloud provider.

---

## 2. Backup Tiers & Schedules

| Tier | Method | Frequency | Retention | Storage Location |
|:-----|:-------|:----------|:----------|:-----------------|
| **Hourly Incremental** | PostgreSQL Write-Ahead Logs (WAL) / `pg_wal` | Continuous / Every 15 min | 7 days | Local + S3 archive |
| **Daily Full Logical** | `pg_dump` compressed custom format (`.dump`) | Nightly @ 02:00 UTC | 30 days | `/var/backups/postgres` + S3 |
| **Weekly Full Archive** | Full database snapshot | Sunday @ 03:00 UTC | 90 days | Encrypted S3 Glacier Vault |

---

## 3. Automated Daily Backup Script

Place this script on the host as `/usr/local/bin/backup_right_ads.sh`:

```bash
#!/usr/bin/env bash
set -eo pipefail

BACKUP_DIR="/var/backups/right_ads"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CONTAINER_NAME="right_ads_postgres"
DB_NAME="right_ads_db"
DB_USER="agency_prod_user"
S3_BUCKET="s3://right-ads-production-backups/daily"

mkdir -p "${BACKUP_DIR}"

DUMP_FILE="${BACKUP_DIR}/db_${DB_NAME}_${TIMESTAMP}.dump"
LOG_FILE="${BACKUP_DIR}/backup_${TIMESTAMP}.log"

echo "[$(date)] Starting logical database backup..." >> "${LOG_FILE}"

# Execute pg_dump custom format inside docker
docker exec -t "${CONTAINER_NAME}" pg_dump -U "${DB_USER}" -d "${DB_NAME}" -F c -b -v > "${DUMP_FILE}"

# Compute SHA256 checksum
sha256sum "${DUMP_FILE}" > "${DUMP_FILE}.sha256"

# Ship to offsite AWS S3 bucket
aws s3 cp "${DUMP_FILE}" "${S3_BUCKET}/" --storage-class STANDARD_IA
aws s3 cp "${DUMP_FILE}.sha256" "${S3_BUCKET}/"

echo "[$(date)] Backup completed and shipped to S3." >> "${LOG_FILE}"

# Prune local backups older than 14 days
find "${BACKUP_DIR}" -name "*.dump" -mtime +14 -delete
find "${BACKUP_DIR}" -name "*.sha256" -mtime +14 -delete
```

Set executable permissions and add to crontab:
```bash
chmod +x /usr/local/bin/backup_right_ads.sh
# Add to root crontab: 0 2 * * * /usr/local/bin/backup_right_ads.sh
```

---

## 4. Disaster Recovery & Restoration Procedure

To restore data from an existing `.dump` archive:

```bash
# 1. Stop backend application to prevent concurrent transactions
docker compose stop backend

# 2. Verify archive integrity
sha256sum -c db_right_ads_db_20261018_020000.dump.sha256

# 3. Drop existing connections and restore using pg_restore
docker exec -i right_ads_postgres dropdb -U agency_prod_user --if-exists right_ads_db
docker exec -i right_ads_postgres createdb -U agency_prod_user -O agency_prod_user right_ads_db
cat db_right_ads_db_20261018_020000.dump | docker exec -i right_ads_postgres pg_restore -U agency_prod_user -d right_ads_db --clean --if-exists --no-owner

# 4. Run Alembic upgrade to verify schema version
docker compose run --rm backend alembic upgrade head

# 5. Start the backend service and verify health
docker compose start backend
curl -s http://localhost:8000/health | jq .
```
