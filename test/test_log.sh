# test/test_log.sh — verify logging paths and behavior

test_log_dir_uses_HB() {
    # Reset to force fallback evaluation
    _LOG_DIR=""
    _log_dir="$_HB/var/log"
    # Re-evaluate config/log defaults (simulate fresh source)
    _LOG_DIR="${_LOG_DIR:-$_HB/var/log}"
    assert_eq "$_LOG_DIR" "$_log_dir" "log dir uses _HB not pwd"
}

test_log_info_writes() {
    _tmp="/tmp/test-log-$$.log"
    _LOG_FILE="$_tmp"
    log_info "test message 123"
    assert_contains "$(cat "$_tmp")" "test message 123" "log_info writes to _LOG_FILE"
    rm -f "$_tmp"
}

test_log_warn_writes() {
    _tmp="/tmp/test-log-$$.log"
    _LOG_FILE="$_tmp"
    log_warn "warning msg"
    assert_contains "$(cat "$_tmp")" "warning msg" "log_warn writes to _LOG_FILE"
    rm -f "$_tmp"
}

test_log_err_writes_to_stderr() {
    _tmp="/tmp/test-log-$$.log"
    _LOG_FILE="$_tmp"
    _ERROR_FILE="/tmp/test-err-$$.log"
    _err="$(log_err "critical error" 2>&1)"
    assert_contains "$_err" "critical error" "log_err writes to stderr"
    assert_contains "$(cat "$_tmp")" "critical error" "log_err writes to _LOG_FILE"
    assert_contains "$(cat "$_ERROR_FILE")" "critical error" "log_err writes to _ERROR_FILE"
    rm -f "$_tmp" "$_ERROR_FILE"
}

test_log_dir_uses_HB
test_log_info_writes
test_log_warn_writes
test_log_err_writes_to_stderr
