#!/bin/bash

echo "Updating certbot certificates..."

DOCKERFILE=/root/nginx-proxy/docker-compose.yml
REPO_DIR=/root/nginx-proxy

docker compose -f $DOCKERFILE run certbot /scripts/get-certs
docker compose -f $DOCKERFILE down
docker compose -f $DOCKERFILE up -d

/bin/bash $REPO_DIR/autorun.sh
