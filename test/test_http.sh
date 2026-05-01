# HTTP library tests (uses mock_wget)

test_http_get_ok() {
    mock_set "response body"
    _result="$(http_get "http://example.com")" && _rc=0 || _rc=$?
    assert_eq "$_result" "response body" "http_get returns body"
}

test_http_post_ok() {
    mock_set '{"ok":true}'
    _result="$(http_post "http://example.com/api" '{"x":1}')" && _rc=0 || _rc=$?
    assert_eq "$_result" '{"ok":true}' "http_post returns body"
}

test_http_get_retry() {
    mock_fail
    http_get "http://fail.example.com" 2>/dev/null
    assert_fail "http_get fails on mock_fail"
    assert_contains "$_ERROR" "http_get" "http_get sets _ERROR on failure"
}

test_http_get_ok
test_http_post_ok
test_http_get_retry
