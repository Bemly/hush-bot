# QQ Message API — send, get, recall messages

. "$_HB/adapter/qq/system.sh"  # for _qq_call, _qq_api

qq_message_send_group()      { _qq_api "send_group_message" "$(json_obj "group_id" "$1" "message" "$2")" "qq.send_group"; }
qq_message_send_private()    { _qq_api "send_private_message" "$(json_obj "user_id" "$1" "message" "$2")" "qq.send_private"; }
qq_message_get()             { _qq_api "get_message" "$(json_obj "message_scene" "$1" "peer_id" "$2" "message_seq" "$3")" "qq.get_message"; }
qq_message_get_history()     { _qq_api "get_history_messages" "$(json_obj "message_scene" "$1" "peer_id" "$2" "start_message_seq" "${3:-0}" "limit" "${4:-20}")" "qq.history"; }
qq_message_recall_group()    { _qq_call "recall_group_message" "$(json_obj "group_id" "$1" "message_seq" "$2")" >/dev/null; }
qq_message_recall_private()  { _qq_call "recall_private_message" "$(json_obj "user_id" "$1" "message_seq" "$2")" >/dev/null; }

# Build a text segment JSON
qq_seg_text() {
    printf '{"type":"text","data":{"text":"%s"}}' "$(printf '%s' "$1" | sed 's/"/\\"/g')"
}

# Build segments array from plain text
qq_text_segments() {
    json_arr "$(qq_seg_text "$1")"
}
