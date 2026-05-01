# Telegram webhook — parse update events

# Extract nested JSON value using sed (avoids $() subshell pipe issue)
_tg_nested() {
    _obj="$1" _key="$2"
    printf '%s' "$_obj" | sed -n 's/.*"'"$_key"'":{"\([^}]*\)"}.*/\1/p'
    # More robust: extract the sub-object, then get the field
    _sub="$(printf '%s' "$_obj" | sed -n 's/.*"'"$_key"'":{\([^}]*\)}.*/\1/p')"
    [ -n "$_sub" ] && printf '%s' "$_sub" | sed -n 's/.*"'"$3"'":\([^,}]*\).*/\1/p' | sed 's/"//g;s/ //g'
}

tg_webhook() {
    _raw="$1"

    _msg="$(json_get "$_raw" message 2>/dev/null)" || _msg=""
    if [ -n "$_msg" ] && [ "$_msg" != "NOTFOUND" ]; then
        # Pass the raw message object to dispatch — handler extracts what it needs
        _txt="$(json_get "$_msg" text 2>/dev/null)" || _txt=""
        [ "$_txt" = "NOTFOUND" ] && _txt=""
        log_info "tg_webhook: message text=$_txt"
        dispatch "telegram" "message" "" "$_txt" "$_msg"
        return 0
    fi

    _cb="$(json_get "$_raw" callback_query 2>/dev/null)" || _cb=""
    if [ -n "$_cb" ] && [ "$_cb" != "NOTFOUND" ]; then
        _data="$(json_get "$_cb" data 2>/dev/null)" || _data=""
        log_info "tg_webhook: callback data=$_data"
        dispatch "telegram" "callback" "" "$_data" "$_cb"
        return 0
    fi

    log_debug "tg_webhook: unhandled update type"
    return 0
}
