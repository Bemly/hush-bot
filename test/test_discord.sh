# Discord adapter tests (mock)

test_dc_createMessage() {
    mock_set '{"id":"msg123","content":"hello","channel_id":"ch1","author":{"id":"u1"}}'
    _result="$(dc_message_create "ch1" "hello")" && _rc=0 || _rc=$?
    assert_contains "$_result" "msg123" "dc_createMessage returns message id"
}

test_dc_editMessage() {
    mock_set '{"id":"msg123","content":"edited"}'
    _result="$(dc_message_edit "ch1" "msg123" "edited")" && _rc=0 || _rc=$?
    assert_contains "$_result" "edited" "dc_editMessage returns edited content"
}

test_dc_deleteMessage() {
    mock_set '{}'
    dc_message_delete "ch1" "msg123" 2>/dev/null
    assert_ok "dc_deleteMessage succeeds"
}

test_dc_getChannel() {
    mock_set '{"id":"ch1","name":"general","type":0}'
    _result="$(dc_channel_get "ch1")" && _rc=0 || _rc=$?
    assert_contains "$_result" "general" "dc_channel_get returns channel name"
}

test_dc_getGuild() {
    mock_set '{"id":"g1","name":"Test Guild","owner_id":"u1"}'
    _result="$(dc_guild_get "g1")" && _rc=0 || _rc=$?
    assert_contains "$_result" "Test Guild" "dc_guild_get returns guild name"
}

test_dc_webhook_execute() {
    mock_set '{}'
    dc_webhook_execute "https://discord.com/api/webhooks/x/y" "hello" 2>/dev/null
    assert_ok "dc_webhook_execute succeeds"
}

test_dc_createMessage
test_dc_editMessage
test_dc_deleteMessage
test_dc_getChannel
test_dc_getGuild
test_dc_webhook_execute
