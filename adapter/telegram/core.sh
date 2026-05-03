# Telegram core — _tg_call + _tg_api
# Auth is token in URL (already in TG_API_BASE)

. "$_HB/lib/http.sh"

_tg_call() {
    _method="$1" _body="$2"
    if [ -n "${TG_API_SECRET:-}" ]; then
        http_post "${TG_API_BASE}/${_method}" "$_body" \
            "Content-Type:application/json" \
            "X-Ayu-Token: ${TG_API_SECRET}" || {
            _ERROR="tg.$_method: $_ERROR"
            return 1
        }
    else
        http_post "${TG_API_BASE}/${_method}" "$_body" \
            "Content-Type:application/json" || {
            _ERROR="tg.$_method: $_ERROR"
            return 1
        }
    fi
}

# _tg_api <method> <body> <error_tag>
_tg_api() {
    _m="$1" _body="$2" _tag="$3"
    _out="/tmp/tg-api.$$"
    _tg_call "$_m" "$_body" >"$_out" || { rm -f "$_out"; return 1; }
    _result="$(json_get "$(cat "$_out")" result)" || { _ERROR="$_tag: $_ERROR"; rm -f "$_out"; return 1; }
    rm -f "$_out"
    printf '%s' "$_result"
}
