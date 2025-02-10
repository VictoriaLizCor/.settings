# Secure Docker Compose Project

This project provides a secure setup for multiple microservices using Docker Compose. It includes services for authentication, user management, DNS resolution, backend processing, game management, and a frontend interface.

## Project Structure

```
ft_transcendence
├── authentication-service
│   ├── Dockerfile
│   ├── src
│   │   └── app.js
│   └── package.json
├── user-management-service
│   ├── Dockerfile
│   ├── src
│   │   └── app.js
│   └── package.json
├── dns-service
│   ├── Dockerfile
│   ├── src
│   │   └── app.js
│   └── package.json
├── backend-service
│   ├── Dockerfile
│   ├── src
│   │   └── app.js
│   └── package.json
├── game-service
│   ├── Dockerfile
│   ├── src
│   │   └── app.ts
│   └── package.json
├── frontend-service
│   ├── Dockerfile
│   ├── src
│   │   └── index.html
│   └── package.json
├── docker-compose.yml
└── README.md
```

## Services Overview

1. **Authentication Service**
   - Handles user registration, login, and permission management.
   - Utilizes OAuth and JWT for secure authentication.

2. **User Management Service**
   - Manages user profiles, tracks statistics, and handles user preferences.

3. **DNS Service**
   - Provides DNS resolution for the services.

4. **Backend Service**
   - Handles API requests, interacts with the database, and manages business logic.

5. **Game Service**
   - Manages game creation, tracking within tournaments, player matchmaking, and recording results.

6. **Frontend Service**
   - Provides the user interface for the application.

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   cd secure-docker-compose
   ```

2. Build and run the services using Docker Compose:
   ```
   docker-compose up --build
   ```

3. Access the services through the specified ports as defined in the `docker-compose.yml` file.

## Usage Guidelines

- Ensure that all services are running before accessing the frontend.
- Use HTTPS for secure communication between services.
- Implement server-side validation for all user inputs and forms.
- Protect all API routes and use secure WebSocket connections.

## Security Considerations

- Implement HTTPS for all endpoints.
- Use WebSocket Secure (WSS) for real-time communication.
- Ensure routes are protected and implement two-factor authentication (2FA) where applicable.