#!/usr/bin/env bash


TARGET="/etc/nginx/conf.d"
CERT_ROOT="/etc/certs"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TPL_HTTPS="$DIR/https.conf";
TPL_HTTP="$DIR/http.conf";

rm ${TARGET}/*

IFS=';' read -ra ADDR <<< "$HTTP_DOMAINS"
for i in "${ADDR[@]}"; do
    IFS=: read -r DOMAIN PORT <<< "$i"
    sed -e "s/{DOMAIN}/$DOMAIN/g; s/{PORT}/$PORT/g" "$TPL_HTTP" >> "$TARGET/$DOMAIN.conf"
    echo "Create HTTP config for $DOMAIN"
done

IFS=';' read -ra ADDR <<< "$HTTPS_DOMAINS"
for i in "${ADDR[@]}"; do
    IFS=: read -r DOMAIN PORT <<< "$i"
    CERT_DIR="$CERT_ROOT/$DOMAIN"
    if [ -d ${CERT_DIR} ]; then
        sed -e "s/{DOMAIN}/$DOMAIN/g; s/{PORT}/$PORT/g" "$TPL_HTTPS" >> "$TARGET/$DOMAIN.conf"
        echo "Create HTTPS config for $DOMAIN"
    else
        echo "Skip HTTPS config for $DOMAIN because cert dir not found: ${CERT_DIR}"
    fi
done
