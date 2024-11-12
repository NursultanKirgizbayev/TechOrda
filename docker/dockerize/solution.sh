#!/bin/bash

# Сборка Docker-образа
docker build -t jusan-fastapi-final:dockerized .

# Проверка наличия образа
docker images | grep jusan-fastapi-final

# Запуск контейнера
docker run -d --name jusan-dockerize -p 8080:8080 jusan-fastapi-final:dockerized