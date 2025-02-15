# Use Debian bullseye as the base image
FROM debian:bullseye

ARG DOMAIN
ARG HOST_USER
ARG USER_ID
ARG GROUP_ID

# RUN groupadd -g ${GROUP_ID} ${HOST_USER} && \
#    useradd -m -u ${USER_ID} -g ${HOST_USER} ${HOST_USER}
#USER ${USER_ID}:${GROUP_ID}
# Create a user with a unique UID
# RUN useradd -u 1000 -o -m -s /bin/bash ${HOST-USER}
# Update package list and install Nginx and OpenSSL
RUN apt-get update && apt-get install -y \
	nginx curl openssl  \
	&& rm -rf /var/lib/apt/lists/* \
	rm /etc/nginx/sites-enabled/default \
	rm /var/www/html/index.nginx-debian.html

RUN env
# Create directory for Nginx PID
RUN mkdir -p /run/nginx 
RUN set -e

# Copy Nginx configuration file
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
# RUN cat /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Create directory and set permissions
RUN mkdir -p /var/www/html && \
	chown -R 755 /var/www/html

# Create a health check file
# RUN touch /var/www/html/healthcheck.html && \
RUN echo "OK" > /var/www/html/health.html

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]