#!/bin/bash

docker run -d --name jsn-dkr-run -p 8888:80 nginx:mainline

docker ps

docker stop jsn-dkr-run

docker ps

docker ps -a
