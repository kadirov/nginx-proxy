#!/bin/bash

echo "Updating certbot certificates..."

DOCKERFILE=/root/nginx-proxy/docker-compose.yml

docker compose -f $DOCKERFILE run certbot /scripts/get-certs
docker compose -f $DOCKERFILE down
docker compose -f $DOCKERFILE up -d

./autorun.sh