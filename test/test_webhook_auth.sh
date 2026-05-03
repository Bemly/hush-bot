# test/test_webhook_auth.sh — webhook token authentication tests

test_auth_no_secret_allows_all() {
    WEBHOOK_SECRET=""
    QUERY_STRING=""
    # Simulate auth check logic from router.sh
    _blocked=""
    if [ -n "${WEBHOOK_SECRET:-}" ]; then
        _token="$(printf '%s' "${QUERY_STRING:-}" | sed 's/.*token=//' | sed 's/&.*//')"
        [ "$_token" != "$WEBHOOK_SECRET" ] && _blocked="1"
    fi
    [ -z "$_blocked" ]
    assert_ok "no secret → allows request without token"
}

test_auth_missing_token_blocked() {
    WEBHOOK_SECRET="secret123"
    QUERY_STRING=""
    _blocked=""
    if [ -n "${WEBHOOK_SECRET:-}" ]; then
        _token="$(printf '%s' "${QUERY_STRING:-}" | sed 's/.*token=//' | sed 's/&.*//')"
        [ "$_token" != "$WEBHOOK_SECRET" ] && _blocked="1"
    fi
    [ -n "$_blocked" ]
    assert_ok "secret set → blocks missing token"
}

test_auth_wrong_token_blocked() {
    WEBHOOK_SECRET="secret123"
    QUERY_STRING="token=wrong"
    _blocked=""
    if [ -n "${WEBHOOK_SECRET:-}" ]; then
        _token="$(printf '%s' "${QUERY_STRING:-}" | sed 's/.*token=//' | sed 's/&.*//')"
        [ "$_token" != "$WEBHOOK_SECRET" ] && _blocked="1"
    fi
    [ -n "$_blocked" ]
    assert_ok "secret set → blocks wrong token"
}

test_auth_correct_token_allowed() {
    WEBHOOK_SECRET="secret123"
    QUERY_STRING="token=secret123"
    _blocked=""
    if [ -n "${WEBHOOK_SECRET:-}" ]; then
        _token="$(printf '%s' "${QUERY_STRING:-}" | sed 's/.*token=//' | sed 's/&.*//')"
        [ "$_token" != "$WEBHOOK_SECRET" ] && _blocked="1"
    fi
    [ -z "$_blocked" ]
    assert_ok "correct token → allows request"
}

test_auth_token_with_extra_params() {
    WEBHOOK_SECRET="secret123"
    QUERY_STRING="platform=qq&token=secret123&other=1"
    _blocked=""
    if [ -n "${WEBHOOK_SECRET:-}" ]; then
        _token="$(printf '%s' "${QUERY_STRING:-}" | sed 's/.*token=//' | sed 's/&.*//')"
        [ "$_token" != "$WEBHOOK_SECRET" ] && _blocked="1"
    fi
    [ -z "$_blocked" ]
    assert_ok "correct token with extra params → allows request"
}

test_auth_no_secret_allows_all
test_auth_missing_token_blocked
test_auth_wrong_token_blocked
test_auth_correct_token_allowed
test_auth_token_with_extra_params
