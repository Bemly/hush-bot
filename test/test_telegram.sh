# Telegram adapter tests (mock)

test_tg_getMe() {
    mock_set '{"ok":true,"result":{"id":123,"first_name":"TestBot","username":"test_bot"}}'
    _result="$(tg_getMe)" && _rc=0 || _rc=$?
    assert_contains "$_result" "TestBot" "tg_getMe returns bot info"
}

test_tg_sendMessage() {
    mock_set '{"ok":true,"result":{"message_id":42,"chat":{"id":100},"text":"hi"}}'
    _result="$(tg_sendMessage "100" "hello")" && _rc=0 || _rc=$?
    assert_contains "$_result" "message_id" "tg_sendMessage returns message_id"
}

test_tg_getUpdates() {
    mock_set '{"ok":true,"result":[{"update_id":1,"message":{"message_id":1,"text":"/start"}}]}'
    _result="$(tg_getUpdates 0 10)" && _rc=0 || _rc=$?
    assert_contains "$_result" "update_id" "tg_getUpdates returns updates"
}

test_tg_setWebhook() {
    mock_set '{"ok":true,"result":true,"description":"Webhook was set"}'
    _result="$(tg_setWebhook "https://example.com/webhook")" && _rc=0 || _rc=$?
    assert_contains "$_result" "true" "tg_setWebhook ok"
}

test_tg_webhook_message() {
    _update='{"update_id":1,"message":{"message_id":42,"from":{"id":111},"chat":{"id":222},"text":"/ping"}}'
    tg_webhook "$_update" 2>/dev/null
    assert_ok "tg_webhook message parsed"
}

test_tg_webhook_callback() {
    _update='{"update_id":2,"callback_query":{"id":"cb1","from":{"id":111},"data":"btn_click"}}'
    tg_webhook "$_update" 2>/dev/null
    assert_ok "tg_webhook callback parsed"
}

test_tg_getMe
test_tg_sendMessage
test_tg_getUpdates
test_tg_setWebhook
test_tg_webhook_message
test_tg_webhook_callback
