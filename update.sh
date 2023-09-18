#!/bin/bash

echo "Updating certbot certificates..."

REPO_DIR=/root/nginx-proxy
DOCKERFILE=$REPO_DIR/docker-compose.yml

docker compose -f $DOCKERFILE run certbot /scripts/get-certs
docker compose -f $DOCKERFILE down
docker compose -f $DOCKERFILE up -d

/bin/bash $REPO_DIR/autorun.sh
