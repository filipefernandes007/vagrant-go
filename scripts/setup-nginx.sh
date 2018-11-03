#!/usr/bin/env bash

apt-get -o Dpkg::Progress-Fancy="1" install -q -y nginx

cat << EOF > /etc/nginx/sites-available/default 
upstream app_dev {
    server 127.0.0.1:6666;
}

server {
    listen 80;
    server_name _; 
    root /home/vagrant/app/public;

    access_log /home/vagrant/app/logs/nginx-access.log;
    error_log  /home/vagrant/app/logs/nginx-error.log error;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ @app;
    }

    location @app {
      proxy_set_header x-real-ip \$remote_addr;
      proxy_set_header x-forwarded-for \$proxy_add_x_forwarded_for;
      proxy_set_header host \$http_host;
      proxy_set_header x-nginx-proxy true;

      proxy_pass http://app_dev;
      proxy_redirect off;
    }
}
EOF

service nginx restart
