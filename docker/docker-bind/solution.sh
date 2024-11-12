#!/bin/bash

curl -o nginx.conf https://raw.githubusercontent.com/NursultanKirgizbayev/TechOrda/main/docker/docker-bind/nginx.conf

docker run -d \
    --name jusan-docker-bind \
    -p 7777:80 \
    -v "$(pwd)/nginx.conf:/etc/nginx/nginx.conf" \
    "nginx:mainline"
