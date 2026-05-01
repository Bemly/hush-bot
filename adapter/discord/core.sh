# Discord core — _dc_req, _dc_get, _dc_post, _dc_api
# Auth: Authorization: Bot <TOKEN>

. "$_HB/lib/http.sh"

_dc_auth() {
    printf 'Authorization: Bot %s' "$DC_TOKEN"
}

# _dc_get <path> — GET request (no body)
_dc_get() {
    _path="$1"
    _out="/tmp/dc-out.$$"
    http_get "${DC_API_BASE}${_path}" \
        "Content-Type:application/json" \
        "$(_dc_auth)" >"$_out"
    _rc=$?
    if [ $_rc -ne 0 ]; then
        _ERROR="dc.GET $_path: $_ERROR"
        rm -f "$_out"
        return 1
    fi
    cat "$_out"
    rm -f "$_out"
}

# _dc_post <path> <body> — POST/PATCH/PUT request
_dc_post() {
    _method="$1" _path="$2" _body="$3"
    _out="/tmp/dc-out.$$"
    http_post "${DC_API_BASE}${_path}" "$_body" \
        "Content-Type:application/json" \
        "$(_dc_auth)" >"$_out"
    _rc=$?
    if [ $_rc -ne 0 ]; then
        _ERROR="dc.$_method $_path: $_ERROR"
        rm -f "$_out"
        return 1
    fi
    cat "$_out"
    rm -f "$_out"
}

# _dc_api <method> <path> <body> <error_tag>
_dc_api() {
    _m="$1" _p="$2" _body="$3" _tag="$4"
    _out="/tmp/dc-api.$$"
    _dc_post "$_m" "$_p" "$_body" >"$_out" || { rm -f "$_out"; return 1; }
    cat "$_out"
    rm -f "$_out"
}

# _dc_void <method> <path> <body> — fire and forget
_dc_void() {
    _m="$1" _p="$2" _body="${3:-{}}"
    _out="/tmp/dc-void.$$"
    _dc_post "$_m" "$_p" "$_body" >"$_out" || { rm -f "$_out"; return 1; }
    rm -f "$_out"
}

# _dc_execute <webhook_url> <body> — execute webhook (no auth)
dc_webhook_execute() {
    _url="$1" _content="$2" _username="${3:-}"
    _body="$(json_obj "content" "$_content")"
    [ -n "$_username" ] && _body="$(printf '%s' "$_body" | sed 's/}$/,"username":"'"$_username"'"/}')"
    http_post "$_url" "$_body" "Content-Type:application/json" || {
        _ERROR="dc.webhook: $_ERROR"
        return 1
    }
}
