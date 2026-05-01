# QQ Group API

. "$_HB/adapter/qq/system.sh"  # for _qq_call

qq_group_get_list() {
    _nocache="${1:-false}"
    _body="$(json_obj "no_cache" "$_nocache")"
    _resp="$(_qq_call "get_group_list" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_group: list parse fail"; return 1; }
}

qq_group_get_info() {
    _gid="$1" _nocache="${2:-false}"
    _body="$(json_obj "group_id" "$_gid" "no_cache" "$_nocache")"
    _resp="$(_qq_call "get_group_info" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_group: info parse fail"; return 1; }
}

qq_group_get_member_list() {
    _gid="$1" _nocache="${2:-false}"
    _body="$(json_obj "group_id" "$_gid" "no_cache" "$_nocache")"
    _resp="$(_qq_call "get_group_member_list" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_group: member list parse fail"; return 1; }
}

qq_group_get_member_info() {
    _gid="$1" _uid="$2" _nocache="${3:-false}"
    _body="$(json_obj "group_id" "$_gid" "user_id" "$_uid" "no_cache" "$_nocache")"
    _resp="$(_qq_call "get_group_member_info" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_group: member info parse fail"; return 1; }
}

qq_group_set_name() {
    _gid="$1" _name="$2"
    _body="$(json_obj "group_id" "$_gid" "new_group_name" "$_name")"
    _resp="$(_qq_call "set_group_name" "$_body")" || return 1
}

qq_group_set_member_card() {
    _gid="$1" _uid="$2" _card="$3"
    _body="$(json_obj "group_id" "$_gid" "user_id" "$_uid" "card" "$_card")"
    _resp="$(_qq_call "set_group_member_card" "$_body")" || return 1
}

qq_group_send_nudge() {
    _gid="$1" _uid="$2"
    _body="$(json_obj "group_id" "$_gid" "user_id" "$_uid")"
    _resp="$(_qq_call "send_group_nudge" "$_body")" || return 1
}

qq_group_quit() {
    _gid="$1"
    _body="$(json_obj "group_id" "$_gid")"
    _resp="$(_qq_call "quit_group" "$_body")" || return 1
}
