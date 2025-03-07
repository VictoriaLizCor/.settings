# Microservices Project

This project is a microservices architecture designed for managing tournaments, matchmaking, game sessions, and user profiles. It utilizes Traefik as an API gateway to route requests to the appropriate services.

## Project Structure

```
microservices-project
├── docker-compose.yml        # Defines services, networks, and volumes for Docker containers
├── traefik                   # Traefik configuration files
│   ├── traefik.yml           # Static configuration for Traefik
│   └── dynamic
│       └── config.yml        # Dynamic routing rules and middleware
├── user-service              # User Service for authentication and profile management
│   ├── Dockerfile            # Dockerfile for building User Service image
│   └── src                   # Source code for User Service
│       └── ...
├── tournament-service         # Tournament Service for managing tournaments
│   ├── Dockerfile            # Dockerfile for building Tournament Service image
│   └── src                   # Source code for Tournament Service
│       └── ...
├── matchmaking-service        # Matchmaking Service for player matching
│   ├── Dockerfile            # Dockerfile for building Matchmaking Service image
│   └── src                   # Source code for Matchmaking Service
│       └── ...
├── game-session-service       # Game Session Service for managing game sessions
│   ├── Dockerfile            # Dockerfile for building Game Session Service image
│   └── src                   # Source code for Game Session Service
│       └── ...
├── frontend-service           # Frontend Service for user interface
│   ├── Dockerfile            # Dockerfile for building Frontend Service image
│   └── src                   # Source code for Frontend Service
│       └── ...
└── README.md                 # Project documentation
```

## Services Overview

1. **User Service**: Handles user authentication, registration, and profile management.
2. **Tournament Service**: Manages tournament creation, enrollment, and scheduling.
3. **Matchmaking Service**: Matches players based on skill and manages real-time queues.
4. **Game Session Service**: Manages game sessions and facilitates real-time communication.
5. **Frontend Service**: Provides the user interface and interacts with the API gateway.

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   cd microservices-project
   ```

2. Build and start the services using Docker Compose:
   ```
   docker-compose up --build
   ```

3. Access the application through the Traefik gateway at `http://localhost`.

## Usage Guidelines

- Each service can be accessed through the API gateway, which handles routing and security.
- Refer to individual service documentation for specific API endpoints and usage instructions.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes.