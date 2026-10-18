# Right Ads Backend - Production Deployment Guide

## 1. Prerequisites
- Docker Engine $\ge 24.0$ & Docker Compose $\ge v2.20$
- Domain with DNS A-records pointing to target host
- SSL/TLS certificate (Let's Encrypt / Certbot recommended)

---

## 2. Environment Configuration

Create a production `.env` file based on `.env.example`:

```bash
# Application
APP_NAME="Right Ads"
ENVIRONMENT=production
DEBUG=false
APP_TIMEZONE=Asia/Kolkata

# Core Security (Must be at least 32 characters!)
JWT_SECRET_KEY="generate_a_random_32_character_crypto_safe_string_here!"
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# Database Connection (PostgreSQL async)
DATABASE_URL=postgresql+asyncpg://agency_prod_user:SuperSecureDbPass2026@postgres:5432/right_ads_db

# Redis Connection
REDIS_URL=redis://redis:6379/0
RATE_LIMIT_ENABLED=true
RATE_LIMIT_REQUESTS_PER_MINUTE=60

# File Storage (local or s3)
STORAGE_BACKEND=local
MAX_UPLOAD_MB=15

# Push Notifications (Firebase Admin SDK)
ENABLE_PUSH_NOTIFICATIONS=true
FCM_CREDENTIALS_PATH=/app/credentials/firebase_service_account.json

# CORS Allowed Origins
CORS_ORIGINS=["https://app.rightads.agency", "https://portal.rightads.agency"]
```

---

## 3. Docker Compose Orchestration

Use the production `docker-compose.yml`:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: right_ads_postgres
    restart: unless-stopped
    environment:
      POSTGRES_USER: agency_prod_user
      POSTGRES_PASSWORD: SuperSecureDbPass2026
      POSTGRES_DB: right_ads_db
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U agency_prod_user -d right_ads_db"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: right_ads_redis
    restart: unless-stopped
    command: redis-server --appendonly yes --requirepass "RedisAuthToken2026!"
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  backend:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: right_ads_backend
    restart: unless-stopped
    env_file: .env
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - backend_uploads:/app/uploads
      - ./credentials:/app/credentials:ro
    ports:
      - "127.0.0.1:8000:8000"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 15s
      timeout: 5s
      retries: 3

volumes:
  postgres_data:
  redis_data:
  backend_uploads:
```

---

## 4. Nginx Reverse Proxy & SSL (HTTPS)

Sample Nginx configuration `/etc/nginx/sites-available/rightads.conf`:

```nginx
server {
    listen 80;
    server_name api.rightads.agency;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    server_name api.rightads.agency;

    ssl_certificate /etc/letsencrypt/live/api.rightads.agency/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.rightads.agency/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    # Maximum payload size
    client_max_body_size 20M;

    # Proxy headers
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Request-ID $request_id;
        proxy_connect_timeout 60s;
        proxy_read_timeout 120s;
    }
}
```

---

## 5. Deployment Commands

```bash
# 1. Build and start containers
docker compose up -d --build

# 2. Run database migrations
docker compose exec backend alembic upgrade head

# 3. Seed initial master data & default admin
docker compose exec backend python -m app.cli.commands seed-defaults
docker compose exec backend python -m app.cli.commands create-admin \
  --email "superadmin@agency.com" \
  --password "StrongAdminPass123!#" \
  --full-name "Super Administrator"

# 4. Verify system health
curl -s http://localhost:8000/health | jq .
```
