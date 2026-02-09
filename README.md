# Legal Lens

## Project Overview
Legal Lens is an AI-powered mobile app designed for everyday Indians to handle routine personal legal and financial documents without the need for a lawyer. This innovative solution empowers users by providing them with necessary tools for document analysis and creation, making legal processes more accessible.

## Key Features
- **Document Analysis**:  
  - Upload and summarize documents  
  - Red-flag detection  
  - Q&A feature
- **Document Creation**:  
  - Template-based generation of documents  
- **Supporting Features**:  
  - Language support for English and various Indian languages

## Repository Structure
- **legal_lens_client**:  
  The client library for interacting with the backend.
- **legal_lens_flutter**:  
  The Flutter app for mobile users.
- **legal_lens_server**:  
  The backend server handling requests and processing.

## Prerequisites
- **Dart SDK**: Ensure you have the Dart SDK installed. You can download it from [Dart SDK](https://dart.dev/get-dart).
- **Flutter SDK**: Install Flutter by following the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- **Docker**: Use Docker for containerizing the servers. Install it from [Docker](https://www.docker.com/get-started).
- **PostgreSQL**: Set up PostgreSQL for database management by following the [PostgreSQL installation guide](https://www.postgresql.org/download/).
- **Git**: Ensure Git is installed to clone the repository. You can download it from [Git](https://git-scm.com/downloads).

## Setup Instructions
### Backend Server
1. Clone the repository:
   ```bash
   git clone https://github.com/singhrahul7988/Legal-lens.git
   cd Legal-lens/legal_lens_server
   ```
2. Build and run the server:
   ```bash
   docker build -t legal_lens_server .
   docker run -p 8000:8000 legal_lens_server
   ```

### Client Library
1. Navigate to the client directory:
   ```bash
   cd legal_lens_client
   ```
2. Install dependencies:
   ```bash
   pub get
   ```

### Flutter App
1. Navigate to the Flutter app directory:
   ```bash
   cd legal_lens_flutter
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Development Runbook
1. Start Docker infrastructure:
   ```bash
   docker-compose up
   ```
2. Apply migrations:
   ```bash
   docker exec -it legal_lens_server bash
   ./migrate.sh
   ```
3. Run the backend server:
   Follow the steps in the **Backend Server** section above.
4. Run the Flutter app:
   Follow the steps in the **Flutter App** section above.

## Production Deployment Instructions
1. Build Docker image:
   ```bash
   docker build -t legal_lens .
   ```
2. Push to cloud deployment (e.g., AWS, Google Cloud, etc.):
   Follow your cloud provider's instructions for pushing Docker containers.

## Troubleshooting and Health Checks
- **Common Issues**:
  - If you encounter issues with Docker, ensure it is running properly.
  - For database-related errors, check PostgreSQL connection settings.
- **Verification Commands**:
  - To check if Docker containers are running:
    ```bash
    docker ps
    ```
  - To check database connection:
    ```bash
    psql -U <username> -d <database>
    ```

## Testing and Development Practices
- Ensure to write tests for every new feature.
- Use test-driven development (TDD) principles where possible.
- Regularly run all tests to ensure stability.

## Additional Documentation
- [CONTEXT.md](CONTEXT.md)
- [DEPLOYMENT.md](DEPLOYMENT.md)
- [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)

---
This README was generated on 2026-02-09 21:26:39 UTC.