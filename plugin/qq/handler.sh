# QQ message handlers — one function per command

handler_ping() {
    _pf="$1" _evt="$2" _uid="$3" _txt="$4" _raw="$5"
    log_info "handler_ping: from $_uid"
    # Build segments and reply
    . "$_HB/plugin/qq/message.sh"
    _msg="$(json_get "$_raw" peer_id)"
    _scene="$(json_get "$_raw" message_scene)"
    if [ "$_scene" = "group" ]; then
        _gid="$(json_get "$_raw" group_id)"
        _segs="$(qq_text_segments "pong!")"
        qq_message_send_group "$_gid" "$_segs" || log_err "handler_ping: reply failed"
    else
        _segs="$(qq_text_segments "pong!")"
        qq_message_send_private "$_uid" "$_segs" || log_err "handler_ping: reply failed"
    fi
}

handler_echo() {
    _pf="$1" _evt="$2" _uid="$3" _txt="$4" _raw="$5"
    . "$_HB/plugin/qq/message.sh"
    # echo back the same text (strip /echo prefix)
    _clean="$(printf '%s' "$_txt" | sed 's/^\/echo[[:space:]]*//')"
    _segs="$(qq_text_segments "$_clean")"
    _scene="$(json_get "$_raw" message_scene)"
    if [ "$_scene" = "group" ]; then
        _gid="$(json_get "$_raw" group_id)"
        qq_message_send_group "$_gid" "$_segs" || log_err "handler_echo: reply failed"
    else
        qq_message_send_private "$_uid" "$_segs" || log_err "handler_echo: reply failed"
    fi
}

handler_info() {
    _pf="$1" _evt="$2" _uid="$3" _txt="$4" _raw="$5"
    . "$_HB/plugin/qq/system.sh"
    . "$_HB/plugin/qq/message.sh"
    _info="$(qq_system_get_login_info)" || _info="unknown"
    _segs="$(qq_text_segments "Bot info: $_info")"
    _scene="$(json_get "$_raw" message_scene)"
    if [ "$_scene" = "group" ]; then
        _gid="$(json_get "$_raw" group_id)"
        qq_message_send_group "$_gid" "$_segs" || log_err "handler_info: reply failed"
    else
        qq_message_send_private "$_uid" "$_segs" || log_err "handler_info: reply failed"
    fi
}
