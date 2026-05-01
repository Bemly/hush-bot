# dispatch.sh — message routing with plugin handlers
# Format: patterns in etc/rules, one per line:
#   <pattern>|<handler_script>|<handler_func>
# Pattern matching: glob/case on message text

dispatch() {
    _pf="$1" _evt="$2" _uid="$3" _txt="$4" _raw="$5"
    _rules="${_RULES:-$(pwd)/etc/rules}"

    if [ ! -f "$_rules" ]; then
        log_warn "dispatch: no rules file at $_rules"
        return 0
    fi

    while IFS='|' read -r _pat _script _func; do
        [ -z "$_pat" ] && continue
        case "$_pat" in \#*) continue ;; esac  # skip comments

        # glob match
        case "$_txt" in
            $_pat)
                log_info "dispatch: $_txt → $_func (from $_script)"
                _script="$(pwd)/adapter/$_script"
                if [ -f "$_script" ]; then
                    . "$_script"
                    "$_func" "$_pf" "$_evt" "$_uid" "$_txt" "$_raw" || {
                        log_err "dispatch: $_func failed: $_ERROR"
                        return 1
                    }
                else
                    log_err "dispatch: handler not found: $_script"
                fi
                return 0
                ;;
        esac
    done < "$_rules"

    log_debug "dispatch: no match for $_txt"
    return 0
}
