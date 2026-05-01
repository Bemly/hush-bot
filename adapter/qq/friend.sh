# QQ Friend API

. "$_HB/adapter/qq/system.sh"  # for _qq_call

qq_friend_get_list() {
    _nocache="${1:-false}"
    _body="$(json_obj "no_cache" "$_nocache")"
    _resp="$(_qq_call "get_friend_list" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_friend: list parse fail"; return 1; }
}

qq_friend_get_info() {
    _uid="$1" _nocache="${2:-false}"
    _body="$(json_obj "user_id" "$_uid" "no_cache" "$_nocache")"
    _resp="$(_qq_call "get_friend_info" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_friend: info parse fail"; return 1; }
}

qq_friend_send_nudge() {
    _uid="$1" _self="${2:-false}"
    _body="$(json_obj "user_id" "$_uid" "is_self" "$_self")"
    _resp="$(_qq_call "send_friend_nudge" "$_body")" || return 1
}
