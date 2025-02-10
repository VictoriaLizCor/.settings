#!/bin/bash

if [ -f srcs/.env ]; then
	exit 0
fi
# Prompt for the decryption key
echo 
# read -sp "Enter decryption key:" DECRYPTION_KEY # uncomment
# # DECRYPTION_KEY="$1" # to be deleted
# # Decrypt the .env file
# if [ -f .tmp.enc ]; then
# 	gpg --batch --passphrase "$DECRYPTION_KEY" -o .tmp.tar.gz -d .tmp.enc
# 	if [ $? -ne 0 ]; then
# 		echo "Error: Decryption failed."
# 		shred -u srcs/.env
# 		exit 1
# 	fi
# 	mkdir -p .tmp_extract
# 	tar -xzf .tmp.tar.gz -C .tmp_extract
# 	sleep 2
# 	rm .tmp.tar.gz
# 	mv .tmp_extract/srcs/.env.tmp srcs/.env
# 	cp -r .tmp_extract/srcs/requirements/nginx/conf/ssl secrets
# 	rm -r .tmp_extract
# 	# openssl enc -aes-256-cbc -d -salt -pbkdf2 -in srcs/.env.enc -out srcs/.env -k "$DECRYPTION_KEY"
# else
# 	echo "Error: srcs/.env.enc file not found."
# 	exit 1
# fi

# sleep 1 
# Load environment variables from .env file
# export $(grep -v '^#' srcs/.env | xargs)
while IFS='=' read -r key value; do
	if [[ ! $key =~ ^# && -n $key ]]; then
		export "$key=$(echo "$value" | sed 's/^"\(.*\)"$/\1/')"
	fi
done < srcs/.env


# Create secret files
echo "$MYSQL_ROOT_PASSWORD" > secrets/db_root_password.txt
echo "$MYSQL_PASSWORD" > secrets/db_password.txt
# echo "$WORDPRESS_ADMIN_PASSWORD" > secrets/wp_admin_password.txt
# echo "$WORDPRESS_USER_PASSWORD" > secrets/wp_user_password.txt

chmod 600 secrets/db_root_password.txt secrets/db_password.txt 
# Create credentials.txt file
export DOMAIN=pong.42.fr
cat <<EOF > secrets/credentials.txt
USER=$USER
CONTAINER_NAME=FT_Transcendence
HOSTNAME=$USER
USER_DOMAIN=$USER.$DOMAIN
NETWORK_NAME=intranet
EOF
chmod 600 secrets/credentials.txt
IP=$(ifconfig `ifconfig wlan1 >/dev/null 2>&1 && echo wlan1 || echo enp6s0` |  grep 'inet ' | awk '{print $2}')

# Load environment variables from .env file and filter out the specified variables
filtered_env=$(grep -vE '^(AUTH_KEY|SECURE_AUTH_KEY|LOGGED_IN_KEY|NONCE_KEY|AUTH_SALT|SECURE_AUTH_SALT|LOGGED_IN_SALT|NONCE_SALT)=' srcs/.env)
# Write the filtered environment variables back to the .env file
echo "$filtered_env" > srcs/.env
echo "NGINX_DNS='127.0.0.1'" >> srcs/.env

echo -e "\nContent: \n" && tree ./
echo
# Clean up
# shred -u srcs/.env