# Dispatch tests — uses real handler.sh but mocked API

test_dispatch_match() {
    _RULES="/tmp/test-rules.$$"
    printf '/ping|qq/handler.sh|handler_ping\n' > "$_RULES"

    # Mock the QQ API so handler_ping doesnt fail on http_post
    mock_set '{"status":"ok","retcode":0,"data":{"message_seq":1,"time":1}}'

    # /ping should match and call handler_ping
    _event='{"peer_id":1,"sender_id":111,"message_seq":1,"message_scene":"friend","segments":[{"type":"text","data":{"text":"/ping"}}]}'
    dispatch "qq" "message" "111" "/ping" "$_event" 2>/dev/null
    assert_ok "dispatch matches /ping → handler_ping"
    rm -f "$_RULES"
}

test_dispatch_no_match() {
    _RULES="/tmp/test-rules.$$"
    printf '/ping|qq/handler.sh|handler_ping\n' > "$_RULES"
    dispatch "qq" "message" "u1" "/unknown" "{}" 2>/dev/null
    assert_ok "dispatch no match returns ok"
    rm -f "$_RULES"
}

test_dispatch_match
test_dispatch_no_match
