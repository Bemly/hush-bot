# http.sh — wget wrapper with retry, timeout, error capture
# Source after core.sh

_HTTP_STATUS=""
_HTTP_RETRY="${_HTTP_RETRY:-2}"       # retry count
_HTTP_TIMEOUT="${_HTTP_TIMEOUT:-10}"  # seconds

# http_get <url> [header...]
http_get() {
    _url="$1"; shift
    _hdr=""
    for _h in "$@"; do _hdr="$_hdr--header=$_h "; done
    _try=0
    while [ $_try -le "$_HTTP_RETRY" ]; do
        _try=$((_try + 1))
        _body="$(wget -q -O- -T "$_HTTP_TIMEOUT" -Y off \
            $_hdr \
            "$_url" 2>/tmp/hb-http-err.$$)"
        _rc=$?
        if [ $_rc -eq 0 ]; then
            rm -f /tmp/hb-http-err.$$
            printf '%s' "$_body"
            return 0
        fi
        log_warn "http_get retry $_try/$_HTTP_RETRY: $_url"
    done
    _err="$(cat /tmp/hb-http-err.$$ 2>/dev/null)"
    rm -f /tmp/hb-http-err.$$
    _ERROR="http_get failed after $_HTTP_RETRY retries: $_url ($_err)"
    return 1
}

# http_post <url> <body> [header...]
http_post() {
    _url="$1"; _data="$2"; shift 2
    _tmp="/tmp/hb-post.$$"
    printf '%s' "$_data" > "$_tmp"
    _hdr=""
    for _h in "$@"; do _hdr="$_hdr--header=$_h "; done
    _try=0
    while [ $_try -le "$_HTTP_RETRY" ]; do
        _try=$((_try + 1))
        _body="$(wget -q -O- -T "$_HTTP_TIMEOUT" -Y off \
            --post-file "$_tmp" \
            $_hdr \
            "$_url" 2>/tmp/hb-http-err.$$)"
        _rc=$?
        if [ $_rc -eq 0 ]; then
            rm -f /tmp/hb-http-err.$$ "$_tmp"
            printf '%s' "$_body"
            return 0
        fi
        log_warn "http_post retry $_try/$_HTTP_RETRY: $_url"
    done
    _err="$(cat /tmp/hb-http-err.$$ 2>/dev/null)"
    rm -f /tmp/hb-http-err.$$ "$_tmp"
    _ERROR="http_post failed after $_HTTP_RETRY retries: $_url ($_err)"
    return 1
}
