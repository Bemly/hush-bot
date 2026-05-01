# QQ webhook handler — parse Lagrange.Milky events
# Event JSON format: { time, self_id, event_type, data: {...} }

qq_webhook() {
    _raw="$1"

    # Extract event_type
    _evt="$(json_get "$_raw" event_type)" || {
        _ERROR="qq_webhook: cannot parse event_type from $_raw"
        return 1
    }

    log_info "qq_webhook: event=$_evt"

    case "$_evt" in
        message_receive)
            _msg="$(json_get "$_raw" data)" || { _ERROR="qq_webhook: no data"; return 1; }
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

# Extract plain text from QQ message segments
# Uses sed to extract text from segments array (avoids pipe/subshell issues)
qq_extract_text() {
    _msg="$1"
    _segs="$(json_get "$_msg" segments)" || { echo ""; return; }
    # Extract all "text":"..." values from the segments array
    printf '%s' "$_segs" | sed -n 's/.*"type":"text"[^}]*"text":"\([^"]*\)".*/\1/p'
}
