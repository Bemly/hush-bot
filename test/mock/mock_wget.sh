# mock/mock_wget.sh — fake wget for testing
# Source this AFTER core.sh but BEFORE the module under test.
# Sets $MOCK_RESPONSE from env var or fixture file.

_MOCK_DIR="$(pwd)/test/mock/fixtures"

# Override wget: reads from $MOCK_RESPONSE or fixture file.
# Set MOCK_FAIL=1 to make wget return exit code 1.
# Set MOCK_STATUS=<code> to return a specific exit code.
wget() {
    _wget_args="$*"

    # Check if we should simulate failure
    if [ "${MOCK_FAIL:-0}" = "1" ]; then
        return "${MOCK_STATUS:-1}"
    fi

    # If MOCK_RESPONSE is set, echo it
    if [ -n "$MOCK_RESPONSE" ]; then
        printf '%s' "$MOCK_RESPONSE"
        return 0
    fi

    # Check for fixture file by matching --post-file or URL pattern
    for _f in "$_MOCK_DIR"/*.json; do
        _name="$(basename "$_f")"
        case "$_wget_args" in
            *"$_name"*) cat "$_f"; return 0 ;;
        esac
    done

    # Default: return empty success
    return 0
}

# mock_set <json> — set the mock response for the next wget call
mock_set() {
    MOCK_RESPONSE="$1"
    MOCK_FAIL=0
}

# mock_fail [code] — make next wget call fail
mock_fail() {
    MOCK_FAIL=1
    MOCK_STATUS="${1:-1}"
    MOCK_RESPONSE=""
}
