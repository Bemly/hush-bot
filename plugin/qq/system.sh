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
        _ERROR="qq_system($_ep): $_ERROR"
        return 1
    }
}

qq_system_get_login_info() {
    _resp="$(_qq_call "get_login_info" "{}")" || return 1
    json_get "$_resp" data || { _ERROR="qq_system: login_info parse fail"; return 1; }
}

qq_system_get_impl_info() {
    _resp="$(_qq_call "get_impl_info" "{}")" || return 1
    json_get "$_resp" data || { _ERROR="qq_system: impl_info parse fail"; return 1; }
}

qq_system_get_cookies() {
    _domain="${1:-}"
    _resp="$(_qq_call "get_cookies" "$(json_obj "domain" "$_domain")")" || return 1
    json_get "$_resp" data || { _ERROR="qq_system: cookies parse fail"; return 1; }
}

qq_system_get_user_profile() {
    _uid="$1"
    _resp="$(_qq_call "get_user_profile" "$(json_obj "user_id" "$_uid")")" || return 1
    json_get "$_resp" data || { _ERROR="qq_system: profile parse fail"; return 1; }
}
