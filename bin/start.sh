#!/bin/sh
# start.sh — launch hush-bot httpd server

_HB="$(dirname "$0")/.."
cd "$_HB" || exit 1

. ./lib/core.sh
. ./etc/config.sh
. ./lib/log.sh

mkdir -p var/log var/state

# CGI scripts must be accessible by httpd
# busybox httpd requires CGI dir specified in httpd.conf with H:
# The bin/ directory is served as /cgi-bin/
log_info "hush-bot starting on ${BOT_HOST}:${BOT_PORT}"
log_info "QQ API: ${QQ_API_BASE}"
log_info "log dir: ${_LOG_DIR}"

httpd -h "$_HB" -p "${BOT_PORT}:${BOT_HOST}" -c etc/httpd.conf -vv
