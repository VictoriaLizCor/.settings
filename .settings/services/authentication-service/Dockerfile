if i use docker compose for webservice with fastify with nodejs web server, is it a good practice to use nginx and dns to use secure https and wss? instead onf localhost, i would like to use static ip address, is it possible?
I have host with ip 10.12.1.2, i want to run my docker compose here and be able to acccess from any other host in intranet 

```
# Architecture ft_transcendence

Creating a Secure Docker compose Microservice Architecture for User Management and Tournaments

1. Authentication and Authorization Service

    Functionality:
        User registration
        Login
        Permission management
    Technologies:
        OAuth
        JWT (JSON Web Tokens)
        HTTPS for secure communication
    Security:
        Implement HTTPS for all endpoints
        Use wss for WebSocket connections
        Ensure routes are protected
        Implement 2FA for added security

2. User Management Service

    Functionality:
        Manage user profiles
        Track statistics
        Handle user preferences
    Technologies:
        Databases like SQLite
        HTTPS for secure communication
    Validation:
        Implement server-side validation for all user inputs and forms

3. DNS Service

    Functionality:
        Provide DNS resolution for your services
    Technologies:
        Use a DNS service like dnsmasq or a cloud-based DNS provider
    Configuration:
        Ensure the DNS service resolves https://pong.42.fr to the appropriate IP addresses

4. Backend Service

    Functionality:
        Handle API requests
        Interact with the database
        Manage business logic
    Technologies:
        Fastify (Node.js)
        SQLite for the database
    Security:
        Ensure all API routes are protected
        Use HTTPS

5. Game Service

    Functionality:
        Manage game creation and tracking within tournaments
        Handle player matchmaking
        Record results
    Technologies:
        TypeScript
        WebSockets for real-time communication
        Databases for result storage
    Security:
        Use wss for secure WebSocket communication

6. Frontend Service

    Functionality:
        Provide the user interface for the application
    Technologies:
        HTML
        CSS
        Tailwind
        TypeScript
    Validation:
        Implement client-side validation for forms and user inputs
```