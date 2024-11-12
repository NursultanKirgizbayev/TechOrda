#!/bin/bash

curl -o jusan-docker-mount.conf https://stepik.org/media/attachments/lesson/686238/jusan-docker-mount.conf
curl -o jusan-docker-mount.zip https://stepik.org/media/attachments/lesson/686238/jusan-docker-mount.zip
unzip jusan-docker-mount.zip -d jusan-docker-mount

docker run -d \
  -p 9999:80 \
  --name jusan-docker-mount \
  -v "$(pwd)/jusan-docker-mount.conf:/etc/nginx/conf.d/jusan-docker-mount.conf" \
  -v "$(pwd)/jusan-docker-mount/jusan-docker-mount:/usr/share/nginx/html" \
  nginx:mainline
