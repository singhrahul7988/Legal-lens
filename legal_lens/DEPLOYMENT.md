# Deployment & Runbook Guide

This document outlines the steps to deploy, run, and maintain the **Legal Lens** application. It serves as a single source of truth for ensuring a clean start in both development and production environments.

## 1. Prerequisites

Before starting, ensure the following tools are installed:

- **Flutter SDK** (Latest Stable)
- **Dart SDK** (Included with Flutter)
- **Docker Desktop** (Running and accessible)
- **Serverpod CLI** (`dart pub global activate serverpod_cli`)

## 2. Environment Setup

### 2.1 Configuration Files
Ensure the `config/passwords.yaml` file in `legal_lens_server` is correctly configured with your secrets.

**Development (`legal_lens_server/config/passwords.yaml`):**
```yaml
# This is the password for the development database
development:
  database: 'your_dev_db_password'
  redis: 'your_dev_redis_password'
  geminiApiKey: 'YOUR_GEMINI_API_KEY'

# This is the password for the production database
production:
  database: 'your_prod_db_password'
  redis: 'your_prod_redis_password'
  geminiApiKey: 'YOUR_GEMINI_API_KEY'
```

## 3. Development Runbook

Follow these steps to start the application cleanly in a local development environment.

### Step 1: Start Infrastructure (Docker)
Start the PostgreSQL and Redis containers.

```bash
cd legal_lens_server
docker-compose up --build --detach
```
*Verification:* Run `docker ps` to confirm `postgres` and `redis` containers are running.

### Step 2: Apply Database Migrations
Ensure the database schema is up to date.

```bash
cd legal_lens_server
serverpod create-migration
serverpod migrate
```

### Step 3: Start the Backend Server
Run the Serverpod server in development mode.

```bash
cd legal_lens_server
dart bin/main.dart --apply-migrations
```
*Note:* The server should be running on `http://localhost:8080`.

### Step 4: Start the Flutter Client
Launch the mobile/web application.

```bash
cd legal_lens_flutter
flutter run
```

---

## 4. Production Deployment

For production, we use a containerized approach (e.g., AWS, GCP, or Serverpod Cloud).

### Step 1: Build Server Docker Image
```bash
cd legal_lens_server
docker build -t legal_lens_server:latest .
```

### Step 2: Deploy Infrastructure
Ensure your production PostgreSQL and Redis instances are running and accessible.

### Step 3: Run Server
Run the docker container with production profile.
```bash
docker run -e SERVERPOD_PASSWORDS_PATH=/app/config/passwords.yaml -p 8080:8080 legal_lens_server:latest --mode production
```

### Step 4: Build Client
```bash
cd legal_lens_flutter
flutter build apk --release  # Android
flutter build ios --release  # iOS
flutter build web --release  # Web
```

---

## 5. Troubleshooting & Health Checks

### Common Issues
- **401 Unauthorized:** Ensure you are signed in. The app now enforces auth checks on the client side before calling sensitive endpoints.
- **Database Connection Refused:** Check Docker containers (`docker ps`) and `config/development.yaml` ports.
- **Gemini API Errors:** Verify the API Key in `passwords.yaml` and ensure quota is available.

### Health Audit Commands
Run these commands to verify the codebase health.

**Server Analysis & Tests:**
```bash
cd legal_lens_server
dart analyze .
dart test
```

**Client Analysis & Tests:**
```bash
cd legal_lens_flutter
dart analyze .
flutter test
```
