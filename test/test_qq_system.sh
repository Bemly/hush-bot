# QQ system API tests (with mock)

test_get_login_info_ok() {
    mock_set '{"status":"ok","retcode":0,"data":{"uin":12345,"nickname":"TestBot"}}'
    _result="$(qq_system_get_login_info)" && _rc=0 || _rc=$?
    assert_contains "$_result" "TestBot" "login_info has nickname"
}

test_get_login_info_fail() {
    mock_fail
    qq_system_get_login_info 2>/dev/null
    assert_fail "login_info fails on wget error"
}

test_get_impl_info() {
    mock_set '{"status":"ok","retcode":0,"data":{"impl_name":"test","milky_version":"1.0"}}'
    _result="$(qq_system_get_impl_info)" && _rc=0 || _rc=$?
    assert_contains "$_result" "test" "impl_info has name"
}

test_get_login_info_ok
test_get_login_info_fail
test_get_impl_info
