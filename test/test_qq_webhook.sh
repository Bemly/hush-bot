# QQ webhook parsing tests

test_webhook_message_receive() {
    _event='{"time":1,"self_id":1,"event_type":"message_receive","data":{"peer_id":1,"sender_id":111,"message_seq":1,"message_scene":"friend","segments":[{"type":"text","data":{"text":"hello"}}]}}'
    _result="$(qq_extract_text "$(json_get "$_event" data)")" && _rc=0 || _rc=$?
    assert_eq "$_result" "hello" "extract text from message_receive"
}

test_webhook_group_nudge() {
    _event='{"time":1,"self_id":1,"event_type":"group_nudge","data":{"group_id":100,"sender_id":222,"receiver_id":1}}'
    # Just verify it parses without error
    qq_webhook "$_event" 2>/dev/null
    assert_ok "webhook group_nudge parsed"
}

test_webhook_friend_request() {
    _event='{"time":1,"self_id":1,"event_type":"friend_request","data":{"initiator_id":333,"comment":"hi"}}'
    qq_webhook "$_event" 2>/dev/null
    assert_ok "webhook friend_request parsed"
}

test_webhook_bot_offline() {
    _event='{"time":1,"self_id":1,"event_type":"bot_offline","data":{"reason":"kick"}}'
    qq_webhook "$_event" 2>/dev/null
    assert_ok "webhook bot_offline parsed"
}

test_webhook_unknown_event() {
    _event='{"time":1,"self_id":1,"event_type":"weird_custom","data":{}}'
    qq_webhook "$_event" 2>/dev/null
    assert_ok "webhook unknown event doesnt crash"
}

test_webhook_message_receive
test_webhook_group_nudge
test_webhook_friend_request
test_webhook_bot_offline
test_webhook_unknown_event
