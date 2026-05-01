# Discord core — _dc_call + _dc_api
# Auth: Authorization: Bot <TOKEN>

. "$_HB/lib/http.sh"

_dc_auth() {
    printf 'Authorization: Bot %s' "$DC_TOKEN"
}

_dc_call() {
    _path="$1" _body="$2"
    http_post "${DC_API_BASE}${_path}" "$_body" \
        "Content-Type:application/json" \
        "$(_dc_auth)" || {
        _ERROR="dc$_path: $_ERROR"
        return 1
    }
}

# _dc_api <path> <body> <error_tag>
_dc_api() {
    _p="$1" _body="$2" _tag="$3"
    _out="/tmp/dc-api.$$"
    _dc_call "$_p" "$_body" >"$_out" || { rm -f "$_out"; return 1; }
    _result="$(cat "$_out")"
    rm -f "$_out"
    printf '%s' "$_result"
}

# _dc_get <path> — simple GET (no body)
_dc_get() {
    _path="$1"
    _out="/tmp/dc-get.$$"
    _err="/tmp/dc-err.$$"
    printf '' | wget -q -O- -T 10 -Y off \
        --header="Authorization: Bot $DC_TOKEN" \
        --header="Content-Type:application/json" \
        "${DC_API_BASE}${_path}" >"$_out" 2>"$_err"
    _rc=$?
    if [ $_rc -ne 0 ]; then
        rm -f "$_out" "$_err"
        return 1
    fi
    cat "$_out"
    rm -f "$_out" "$_err"
}
