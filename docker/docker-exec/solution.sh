#!/bin/bash

docker run -d -p 8181:8080 --name jusan-docker-exec nginx:mainline #указал порт 8080 потому что при курле обращения шли на default.conf

docker exec jusan-docker-exec sh -c "cat << EOF > /etc/nginx/conf.d/jusan-docker-exec.conf
server {
    listen 8080; #
    server_name jusan.singularity;

    location / { return 200 'Hello, from jusan-docker-exec'; }
    location /home { return 201 'This is my home!'; }
    location /about { return 202 'I am just an exercise!'; }
}
EOF"

docker exec jusan-docker-exec nginx -s reload
