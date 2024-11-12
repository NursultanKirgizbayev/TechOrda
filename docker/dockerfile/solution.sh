#!/bin/bash

curl -O https://stepik.org/media/attachments/lesson/686238/jusan-dockerfile.conf

curl -O https://stepik.org/media/attachments/lesson/686238/jusan-dockerfile.zip

unzip jusan-dockerfile.zip -d jusan-dockerfile

cat <<EOF > Dockerfile
FROM nginx:mainline

COPY jusan-dockerfile.conf /etc/nginx/conf.d/default.conf

COPY jusan-dockerfile/* /var/www/jusan-dockerfile/
EOF

docker build -t nginx:jusan-dockerfile .

docker images

docker run -d -p 6060:80 --name jusan-dockerfile nginx:jusan-dockerfile

