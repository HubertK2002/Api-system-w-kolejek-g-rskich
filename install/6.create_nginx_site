#!/bin/bash

CONFIG_FILE="../config"

PROD_HOST=$(awk -F' = ' '/^\[prod\]/{f=1} f && /host/{print $2; exit}' $CONFIG_FILE)
PROD_PORT=$(awk -F' = ' '/^\[prod\]/{f=1} f && /port/{print $2; exit}' $CONFIG_FILE)

EXTERNAL_IP=$(awk -F' = ' '/^\[prod\]/{f=1} f && /external_ip/{print $2; exit}' $CONFIG_FILE)
EXTERNAL_PORT=$(awk -F' = ' '/^\[prod\]/{f=1} f && /external_port/{print $2; exit}' $CONFIG_FILE)

NGINX_SITE_NAME="kolejka_gorska"

NGINX_CONFIG="/etc/nginx/sites-available/$NGINX_SITE_NAME"

cat > $NGINX_CONFIG <<EOL
server {
    listen $EXTERNAL_PORT;
    server_name $EXTERNAL_IP;

    access_log /var/log/nginx/kolejka_gorska_access.log;
    error_log /var/log/nginx/kolejka_gorska_error.log;

    location / {
		if (\$request_method = 'OPTIONS') {
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
            add_header 'Access-Control-Allow-Headers' 'Origin, Content-Type, Accept, Authorization, X-Requested-With';
            add_header 'Access-Control-Max-Age' 1728000;  # Opcjonalnie, aby zwiększyć czas przechowywania w cache
            return 204;  # Kod odpowiedzi dla zapytania OPTIONS
        }

        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'Origin, Content-Type, Accept, Authorization, X-Requested-With';

        proxy_pass http://$PROD_HOST:$PROD_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

ln -s $NGINX_CONFIG /etc/nginx/sites-enabled/

systemctl restart nginx