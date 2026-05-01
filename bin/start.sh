#!/bin/sh
# start.sh — launch hush-bot httpd server

_HB="$(cd "$(dirname "$0")/.." && pwd)"
cd "$_HB" || exit 1

. ./lib/core.sh
. ./etc/config.sh
. ./lib/log.sh

mkdir -p var/log var/state

log_info "hush-bot starting on ${BOT_HOST}:${BOT_PORT}"
log_info "QQ API: ${QQ_API_BASE}"
log_info "log dir: ${_LOG_DIR}"

httpd -f -h "$_HB" -p "$BOT_PORT" -c etc/httpd.conf -vv
