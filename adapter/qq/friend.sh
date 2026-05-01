# QQ Friend API

. "$_HB/adapter/qq/system.sh"  # for _qq_call, _qq_api

qq_friend_get_list()   { _qq_api "get_friend_list" "$(json_obj "no_cache" "${1:-false}")" "qq.friend_list"; }
qq_friend_get_info()   { _qq_api "get_friend_info" "$(json_obj "user_id" "$1" "no_cache" "${2:-false}")" "qq.friend_info"; }
qq_friend_send_nudge() { _qq_call "send_friend_nudge" "$(json_obj "user_id" "$1" "is_self" "${2:-false}")" >/dev/null; }
