Below is an example of how you can set up Option A (redirect to canonical) completely via Docker labels. In this approach, you define both routers and the redirection middleware on your Fastify container so that when its labels change the updated configuration is picked up by Traefik automatically without needing to restart Traefik.

Below is a complete sample:

---

### 1. **Traefik Static Configuration (traefik.yml)**

This file sets up your entry points, TLS, and enables the Docker provider. Note that we’re not using a file provider (dynamic config file) here since all routers and middleware will come from container labels.

```yaml
# traefik.yml
entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
  websecure:
    address: ":443"
    http:
      tls:
        # Adjust TLS details as needed.
        domains:
          - main: "{{ env \"DOMAIN_TEST\" }}"
            sans:
              - "{{ env \"DOMAIN\" }}"
              - "{{ env \"IP\" }}"
              - "localhost"
              - "127.0.0.1"
providers:
  docker:
    exposedByDefault: false
log:
  level: DEBUG
api:
  dashboard: true
accessLog: {}
global:
  checkNewVersion: false
```

---

### 2. **Docker Compose File**

In this example both the Traefik and Fastify containers are attached to the same network. All route definitions and the redirect middleware are defined on the Fastify container via labels. Traefik picks up these labels (using its Docker provider) and creates the corresponding routers at runtime without requiring a restart if you change the labels on Fastify and redeploy that container.

```yaml
version: "3.8"

services:
  traefik:
    image: traefik:v2.9
    container_name: traefik
    command:
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
      - "--api.dashboard=true"
      - "--log.level=DEBUG"
    ports:
      - "80:80"
      - "443:443"
      - "8080:8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - "./traefik.yml:/etc/traefik/traefik.yml:ro"
    environment:
      - DOMAIN=old-domain.example.com
      - DOMAIN_TEST=c2r1s2.42wolfsburg.de
      - IP=10.12.1.2
    networks:
      - web

  fastify:
    image: your-fastify-image    # Replace with your Fastify image build or image name.
    container_name: fastify
    environment:
      - DOMAIN=old-domain.example.com
      - DOMAIN_TEST=c2r1s2.42wolfsburg.de
      - IP=10.12.1.2
    labels:
      - "traefik.enable=true"
      #
      # Router for canonical domain requests (highest priority)
      - "traefik.http.routers.fastify-canonical.rule=Host(`${DOMAIN_TEST}`)"
      - "traefik.http.routers.fastify-canonical.entrypoints=web,websecure"
      - "traefik.http.routers.fastify-canonical.priority=30"
      #
      # Router that catches other requests (IP or non‐canonical domain) and redirects them
      - "traefik.http.routers.fastify-redirect.rule=Host(`${DOMAIN}`) || Host(`${IP}`) || Host(`127.0.0.1`)"
      - "traefik.http.routers.fastify-redirect.entrypoints=web,websecure"
      - "traefik.http.routers.fastify-redirect.priority=20"
      - "traefik.http.routers.fastify-redirect.middlewares=redirect-to-canonical"
      #
      # Middleware: Redirect requests from non-canonical hosts to the canonical domain.
      # Note: In the regex, dots are escaped (\\.) and use $$ to inject a literal $ in the replacement.
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.regex=^https?://(?:${DOMAIN}|${IP}|127\\.0\\.0\\.1)(.*)"
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.replacement=https://${DOMAIN_TEST}$$1"
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.permanent=true"
      #
      # Define the service to which both routers send traffic.
      - "traefik.http.services.fastify-service.loadbalancer.server.port=3000"
    networks:
      - web

--------------------------------------------------
    labels:
      - "traefik.enable=true"
      #
      # Router for canonical domain requests (highest priority)
      - "traefik.http.routers.fastify-canonical.rule=Host(`${DOMAIN}`)"
      - "traefik.http.routers.fastify-canonical.entrypoints=web,websecure"
      - "traefik.http.routers.fastify-canonical.priority=30"
      #
      # Router that catches other requests (IP or non‐canonical domain) and redirects them
      - "traefik.http.routers.fastify-redirect.rule=Host(`${IP}`) || Host(`127.0.0.1`)"
      - "traefik.http.routers.fastify-redirect.entrypoints=web"
      - "traefik.http.routers.fastify-redirect.priority=20"
      - "traefik.http.routers.fastify-redirect.middlewares=redirect-to-canonical"
      #
      # Middleware: Redirect requests from non-canonical hosts to the canonical domain.
      # Note: In the regex, dots are escaped (\\.) and use $$ to inject a literal $ in the replacement.
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.regex=^https?://(?:${IP}|127\\.0\\.0\\.1)(.*)"
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.replacement=https://${DOMAIN}$$1"
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.permanent=true"
      #
      # Define the service to which both routers send traffic.
      - "traefik.http.services.fastify.loadbalancer.server.port=3000"

----------------------------------------------------------------------------------
      # Enable Traefik on this service.
      - "traefik.enable=true"
      # -----------------------------------------
      # Router for canonical traffic (HTTPS only)
      # -----------------------------------------
      # When a client uses the canonical domain in the Host header,
      # this router uses the HTTPS entrypoint ("websecure") to forward traffic.
      - "traefik.http.routers.fastify-canonical.rule=Host(`${DOMAIN}`)"
      - "traefik.http.routers.fastify-canonical.entrypoints=websecure"
      - "traefik.http.routers.fastify-canonical.priority=30"
      # ------------------------------------------------
      # Router for non-canonical traffic (HTTP only)
      # ------------------------------------------------
      # This router catches requests coming in with the IP or localhost.
      # We attach it to the HTTP entrypoint ("web") so that no TLS handshake occurs.
      - "traefik.http.routers.fastify-redirect.rule=Host(`${IP}`) || Host(`127.0.0.1`)"
      - "traefik.http.routers.fastify-redirect.entrypoints=web"
      - "traefik.http.routers.fastify-redirect.priority=20"
      # Attach the redirect middleware.
      - "traefik.http.routers.fastify-redirect.middlewares=redirect-to-canonical"
      # ---------------------------------------------------------
      # Middleware: Redirect with regex to canonical HTTPS URL
      # ---------------------------------------------------------
      # This middleware intercepts requests to IP or localhost
      # and permanently redirects them to "https://${DOMAIN}" keeping the path.
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.regex=^https?://(?:${IP}|127\\.0\\.0\\.1)(.*)"
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.replacement=https://${DOMAIN}$$1"
      - "traefik.http.middlewares.redirect-to-canonical.redirectregex.permanent=true"
      # ---------------------------------------------------------
      # Service Definition: Fastify listens on port 3000.
      # ---------------------------------------------------------
      - "traefik.http.services.fastify.loadbalancer.server.port=3000"
  # frontend:
  #   image: your-web-server-image
  #   labels:
  #     - "traefik.http.services.web-service.loadbalancer.server.port=80"
networks:
  web:
    driver: bridge
```

---

### 3. **Explanation**

- **Traefik Configuration:**  
  The `traefik.yml` file defines the two entry points (`web` and `websecure`), TLS settings, and activates the Docker provider. No dynamic file is used here.

- **Fastify Container Labels:**
  - **Canonical Router (`fastify-canonical`):**  
    – Matches requests where the `Host` header equals the canonical domain (from `${DOMAIN_TEST}`).  
    – Priority is set higher (30) so that if the client uses the canonical domain it’s handled here.
 
  - **Redirect Router (`fastify-redirect`):**  
    – Matches requests coming in via the non‑canonical host names (i.e. `${DOMAIN}`, `${IP}`, or `127.0.0.1`).  
    – Priority is lower (20) than the canonical router.  
    – Uses the `redirect-to-canonical` middleware.
 
  - **Middleware (`redirect-to-canonical`):**  
    – Uses a regex to capture any path appended to the incoming URL and issues a permanent redirect (HTTP 301) to the canonical URL by replacing the host with `${DOMAIN_TEST}`.
 
  - **Service:**  
    – Both routers point to the same service that load-balances to port 3000 on the Fastify container.

- **Dynamic Updates:**  
  When you want to change the canonical (or other) settings, update the container’s labels and restart only the Fastify container. Traefik (using the Docker provider) will pick up the label changes without a restart.

---

### 4. **Usage**

- Deploy the stack with the above docker-compose.  
- When a client accesses your service using, say, the IP address or the old domain (`old-domain.example.com`), the `fastify-redirect` router will catch it and the middleware sends a redirect to `https://c2r1s2.42wolfsburg.de` (your canonical domain).  
- Requests made to the canonical domain (`c2r1s2.42wolfsburg.de`) match the canonical router and are forwarded directly to the Fastify container.

This setup fulfills your requirement to use Option A with a redirect—managed entirely by container labels—so that you can simply update a service’s labels to change routing without restarting Traefik.

Feel free to ask if you need further customization or run into any issues!

