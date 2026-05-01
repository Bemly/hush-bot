# QQ System API — get_login_info, get_impl_info, etc.

. "$_HB/lib/http.sh"

_qq_auth() {
    printf 'Authorization: Bearer %s' "$QQ_TOKEN"
}

_qq_call() {
    _ep="$1" _body="$2"
    http_post "${QQ_API_BASE}/${_ep}" "$_body" \
        "Content-Type:application/json;charset=utf-8" \
        "$(_qq_auth)" || {
        _ERROR="qq.$_ep: $_ERROR"
        return 1
    }
}

# _qq_api <endpoint> <body> <error_tag>
# Uses temp file to avoid $() subshell (which loses _ERROR)
_qq_api() {
    _ep="$1" _body="$2" _tag="$3"
    _out="/tmp/qq-api.$$"
    _qq_call "$_ep" "$_body" >"$_out" || { rm -f "$_out"; return 1; }
    _result="$(json_get "$(cat "$_out")" data)" || { _ERROR="$_tag: $_ERROR"; rm -f "$_out"; return 1; }
    rm -f "$_out"
    printf '%s' "$_result"
}

qq_system_get_login_info()    { _qq_api "get_login_info" "{}" "qq.login_info"; }
qq_system_get_impl_info()     { _qq_api "get_impl_info" "{}" "qq.impl_info"; }
qq_system_get_cookies()       { _domain="${1:-}"; _qq_api "get_cookies" "$(json_obj "domain" "$_domain")" "qq.cookies"; }
qq_system_get_user_profile()  { _qq_api "get_user_profile" "$(json_obj "user_id" "$1")" "qq.profile"; }
