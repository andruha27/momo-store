#!/bin/bash
set +e


docker network create -d bridge momo_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/momo-store/momo-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker-compose up -d frontend