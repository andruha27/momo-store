#!/bin/bash
set +e
cat > .backend.env <<EOF

VIRTUAL_HOST=momo-backend
EOF

docker network create -d bridge momo_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/momo-store/momo-backend:latest

set -e

if [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-blue))" == "healthy" ]; then
  docker-compose --env-file .backend.env up -d backend-green
  until [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-green))" == "healthy" ]; do sleep 5; done
  docker-compose stop backend-blue
else
  docker-compose --env-file .backend.env up -d backend-blue
  until [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-blue))" == "healthy" ]; do sleep 5; done
  docker-compose stop backend-green
fi