#!/usr/bin/env bash


TARGET="/etc/nginx/conf.d"
CERT_ROOT="/etc/letsencrypt/live"
CONFIG_FILE="/config/config.txt"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TPL_HTTPS="$DIR/https.conf"
TPL_HTTP="$DIR/http.conf"

rm ${TARGET}/*

while read -r DOMAIN HTTP_PORT HTTPS_PORT
do

  if [[ "x$DOMAIN" = "x#" ]] || [[ "x$DOMAIN" = "x" ]]; then
    continue
  fi

  printf "%s %s %s\n" $DOMAIN $HTTP_PORT $HTTPS_PORT

  sed -e "s/{DOMAIN}/$DOMAIN/g; s/{PORT}/$HTTP_PORT/g" "$TPL_HTTP" >> "$TARGET/$DOMAIN.conf"
  echo "Create HTTP config for $DOMAIN"

  if [[ "$HTTPS_PORT" = "" ]]; then
    continue
  fi

  CERT_DIR="$CERT_ROOT/$DOMAIN"
  if [[ ! -d ${CERT_DIR} ]]; then
    echo "Skip HTTPS config for $DOMAIN because cert dir not found: ${CERT_DIR}"
    continue
  fi

  case "$HTTPS_PORT" in
    "~") HTTPS_PORT=$HTTP_PORT PROTOCOL=http ;;
    *) PROTOCOL=https ;;
  esac

  sed -e "s/{DOMAIN}/$DOMAIN/g; s/{PORT}/$HTTPS_PORT/g; s/{PROTOCOL}/$PROTOCOL/g" "$TPL_HTTPS" >> "$TARGET/$DOMAIN.conf"
  echo "Create HTTPS config for $DOMAIN"

done <"$CONFIG_FILE"
