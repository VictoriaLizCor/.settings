#!/bin/bash

if [ -f .secrets/.env.tmp ]; then
	echo "File with secrets not found. Please contact microservices Admin for further information"
	exit 1
fi

if [ -f srcs/.env ]; then
	exit 0
fi

# ---------- Authentication ---------- #

# ---------- DNS ---------- #
# ---------- Frontend ---------- #
# ---------- Game ---------- #
# ---------- DATABASE ---------- #

# DB_PORT=3306

# ---------- User-management ---------- #


# ---------- .env ---------- #
DEBUG="$1"
export $(grep -vE '^(AUTH_KEY|SECURE_AUTH_KEY|LOGGED_IN_KEY|NONCE_KEY|AUTH_SALT|SECURE_AUTH_SALT|LOGGED_IN_SALT|NONCE_SALT|TOKEN)=' ./secrets/.env.tmp)
export DATA=$DATA/$USER/data
export DOMAIN=$(hostname)
IP=$(hostname -i)
# IP=$(ifconfig `ifconfig wlan1 >/dev/null 2>&1 && echo wlan1 || echo enp6s0` |  grep 'inet ' | awk '{print $2}')

if [ "$DEBUG" -eq 1 ]; then
	echo "########### ---- Debug mode is enabled ---- ###########3"
fi
echo $ADMIN_EMAIL > ./secrets/ssl/adminEmail.txt
cat <<EOF > .env
USER=$USER
USER_ID=$(id -u)
GROUP_ID=$(id -g)
CONTAINER_NAME=$CONTAINER_NAME
HOST_USER=$USER
DOMAIN=$DOMAIN
DOMAIN_TEST=$DOMAIN_TEST
ADMIN_EMAIL=$ADMIN_EMAIL
IP=$IP
# ---------- VOLUMES ---------- #
NGINX_VOL=$DATA/nginx
FASTIFY_VOL=$DATA/fastify
TRAEFIK_VOL=$DATA/traefik
# ---------- CERTIFICATES ---------- #
SSL_PATH=$PWD/$SSL
SSL_CRT=$PWD/$SSL/$(hostname -s).crt
SSL_KEY=$PWD/$SSL/$(hostname -s).key
SSL_PEM=$PWD/$SSL/$(hostname -s).pem
SSL_EMAIL=$PWD/$SSL/adminEmail.txt
SSL_PORT=$SSL_PORT


# ---------- Backend ---------- #

EOF


# echo -e "\nContent: \n" && tree --dirsfirst ./
echo
