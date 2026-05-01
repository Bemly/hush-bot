# QQ message API tests (with mock)

test_seg_text() {
    _result="$(qq_seg_text "hello")" && _rc=0 || _rc=$?
    assert_contains "$_result" '"type":"text"' "seg_text contains type"
    assert_contains "$_result" '"text":"hello"' "seg_text contains hello"
}

test_text_segments() {
    _result="$(qq_text_segments "hi")" && _rc=0 || _rc=$?
    assert_eq "$_result" '[{"type":"text","data":{"text":"hi"}}]' "text_segments builds array"
}

test_send_group_message_ok() {
    mock_set '{"status":"ok","retcode":0,"data":{"message_seq":1,"time":1}}'
    _result="$(qq_message_send_group "100" '[{"type":"text","data":{"text":"hi"}}]')" && _rc=0 || _rc=$?
    assert_contains "$_result" "message_seq" "send_group returns message_seq"
}

test_send_private_message_ok() {
    mock_set '{"status":"ok","retcode":0,"data":{"message_seq":2,"time":1}}'
    _result="$(qq_message_send_private "111" '[{"type":"text","data":{"text":"hi"}}]')" && _rc=0 || _rc=$?
    assert_contains "$_result" "message_seq" "send_private returns message_seq"
}

test_send_message_fail() {
    mock_fail
    qq_message_send_group "100" "[]" 2>/dev/null
    assert_fail "send_group fails on wget error"
}

test_seg_text
test_text_segments
test_send_group_message_ok
test_send_private_message_ok
test_send_message_fail
