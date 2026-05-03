# QQ webhook handler — parse Lagrange.Milky events
# Event JSON format: { time, self_id, event_type, data: {...} }

qq_webhook() {
    _raw="$1"

    # Extract event_type
    _evt="$(json_get "$_raw" event_type)" || {
        _ERROR="webhook.qq: cannot parse event_type from $_raw"
        return 1
    }

    log_info "qq_webhook: event=$_evt"

    case "$_evt" in
        message_receive)
            _msg="$(json_get "$_raw" data)" || { _ERROR="webhook.qq: no event data"; return 1; }
            _mid="$(json_get "$_msg" sender_id)" || _mid=""
            _txt="$(qq_extract_text "$_msg")"
            log_info "qq_webhook: message from $_mid: $_txt"
            dispatch "qq" "message" "$_mid" "$_txt" "$_msg"
            ;;
        group_nudge)
            _data="$(json_get "$_raw" data)"
            _gid="$(json_get "$_data" group_id)"
            _sid="$(json_get "$_data" sender_id)"
            dispatch "qq" "group_nudge" "$_sid" "nudge:$_gid" "$_data"
            ;;
        friend_request)
            _data="$(json_get "$_raw" data)"
            _uid="$(json_get "$_data" initiator_id)"
            _cmt="$(json_get "$_data" comment)"
            dispatch "qq" "friend_request" "$_uid" "friend_req:$_cmt" "$_data"
            ;;
        group_member_increase)
            _data="$(json_get "$_raw" data)"
            _uid="$(json_get "$_data" user_id)"
            _gid="$(json_get "$_data" group_id)"
            dispatch "qq" "member_join" "$_uid" "join:$_gid" "$_data"
            ;;
        group_member_decrease)
            _data="$(json_get "$_raw" data)"
            _uid="$(json_get "$_data" user_id)"
            _gid="$(json_get "$_data" group_id)"
            dispatch "qq" "member_leave" "$_uid" "leave:$_gid" "$_data"
            ;;
        message_recall)
            _data="$(json_get "$_raw" data)"
            _sid="$(json_get "$_data" sender_id)"
            _gid="$(json_get "$_data" peer_id)"
            dispatch "qq" "message_recall" "$_sid" "recall:$_gid" "$_data"
            ;;
        bot_offline)
            _data="$(json_get "$_raw" data)"
            _reason="$(json_get "$_data" reason)"
            log_err "qq_webhook: bot offline: $_reason"
            ;;
        *)
            log_debug "qq_webhook: unhandled event $_evt"
            ;;
    esac
}

# Extract descriptive text from QQ message segments (all 15 types)
# Order: text → face → image → record → video → file → mention →
#        mention_all → reply → forward → market_face → light_app → xml
qq_extract_text() {
    _msg="$1"
    _segs="$(json_get "$_msg" segments)" || { echo ""; return; }

    _out=""
    _sp=""

    # text — extract content from "text":"..."
    _txt="$(printf '%s' "$_segs" | sed -n 's/.*"type":"text"[^}]*"text":"\([^"]*\)".*/\1/p')"
    if [ -n "$_txt" ]; then
        _out="$_out$_sp$_txt"
        _sp=" "
    fi

    # face
    if printf '%s' "$_segs" | grep -q '"type":"face"'; then
        _out="$_out$_sp[表情]"; _sp=" "
    fi

    # image
    if printf '%s' "$_segs" | grep -q '"type":"image"'; then
        _out="$_out$_sp[图片]"; _sp=" "
    fi

    # record
    if printf '%s' "$_segs" | grep -q '"type":"record"'; then
        _out="$_out$_sp[语音]"; _sp=" "
    fi

    # video
    if printf '%s' "$_segs" | grep -q '"type":"video"'; then
        _out="$_out$_sp[视频]"; _sp=" "
    fi

    # file — extract file_name
    _fn="$(printf '%s' "$_segs" | sed -n 's/.*"type":"file"[^}]*"file_name":"\([^"]*\)".*/\1/p')"
    if [ -n "$_fn" ]; then
        _out="$_out$_sp[文件: $_fn]"; _sp=" "
    fi

    # mention — extract user_id
    _uid="$(printf '%s' "$_segs" | sed -n 's/.*"type":"mention"[^}]*"user_id":\([0-9]*\).*/@\1/p')"
    if [ -n "$_uid" ]; then
        _out="$_out$_sp$_uid"; _sp=" "
    fi

    # mention_all
    if printf '%s' "$_segs" | grep -q '"type":"mention_all"'; then
        _out="$_out$_sp@所有人"; _sp=" "
    fi

    # reply
    if printf '%s' "$_segs" | grep -q '"type":"reply"'; then
        _out="$_out$_sp[回复]"; _sp=" "
    fi

    # forward
    if printf '%s' "$_segs" | grep -q '"type":"forward"'; then
        _out="$_out$_sp[转发]"; _sp=" "
    fi

    # market_face
    if printf '%s' "$_segs" | grep -q '"type":"market_face"'; then
        _out="$_out$_sp[商城表情]"; _sp=" "
    fi

    # light_app
    if printf '%s' "$_segs" | grep -q '"type":"light_app"'; then
        _out="$_out$_sp[小程序]"; _sp=" "
    fi

    # xml
    if printf '%s' "$_segs" | grep -q '"type":"xml"'; then
        _out="$_out$_sp[卡片消息]"; _sp=" "
    fi

    printf '%s' "$_out"
}
