# QQ Message API — send, get, recall messages

. "$_HB/adapter/qq/system.sh"  # for _qq_call, _qq_auth

qq_message_send_group() {
    _gid="$1" _segs="$2"   # segments is a JSON array string
    _body="$(json_obj "group_id" "$_gid" "message" "$_segs")"
    _resp="$(_qq_call "send_group_message" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_message: send_group parse fail"; return 1; }
}

qq_message_send_private() {
    _uid="$1" _segs="$2"
    _body="$(json_obj "user_id" "$_uid" "message" "$_segs")"
    _resp="$(_qq_call "send_private_message" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_message: send_private parse fail"; return 1; }
}

qq_message_get() {
    _scene="$1" _peer="$2" _seq="$3"
    _body="$(json_obj "message_scene" "$_scene" "peer_id" "$_peer" "message_seq" "$_seq")"
    _resp="$(_qq_call "get_message" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_message: get parse fail"; return 1; }
}

qq_message_get_history() {
    _scene="$1" _peer="$2" _start="${3:-0}" _limit="${4:-20}"
    _body="$(json_obj "message_scene" "$_scene" "peer_id" "$_peer" "start_message_seq" "$_start" "limit" "$_limit")"
    _resp="$(_qq_call "get_history_messages" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_message: history parse fail"; return 1; }
}

qq_message_recall_group() {
    _gid="$1" _seq="$2"
    _body="$(json_obj "group_id" "$_gid" "message_seq" "$_seq")"
    _resp="$(_qq_call "recall_group_message" "$_body")" || return 1
}

qq_message_recall_private() {
    _uid="$1" _seq="$2"
    _body="$(json_obj "user_id" "$_uid" "message_seq" "$_seq")"
    _resp="$(_qq_call "recall_private_message" "$_body")" || return 1
}

# Build a text segment JSON
qq_seg_text() {
    printf '{"type":"text","data":{"text":"%s"}}' "$(printf '%s' "$1" | sed 's/"/\\"/g')"
}

# Build segments array from plain text
qq_text_segments() {
    json_arr "$(qq_seg_text "$1")"
}
