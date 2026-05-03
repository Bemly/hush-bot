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

test_tg_extract_photo() {
	_r="$(tg_extract_text '{"photo":[{"file_id":"p1"}]}')"
	assert_eq "$_r" "[图片]" "tg_extract photo"
}

test_tg_extract_sticker() {
	_r="$(tg_extract_text '{"sticker":{"emoji":"😂","file_id":"s1"}}')"
	assert_eq "$_r" "[贴纸: 😂]" "tg_extract sticker emoji"
}

test_tg_extract_document() {
	_r="$(tg_extract_text '{"document":{"file_name":"report.pdf","file_id":"d1"}}')"
	assert_eq "$_r" "[文件: report.pdf]" "tg_extract document filename"
}

test_tg_extract_voice() {
	_r="$(tg_extract_text '{"voice":{"file_id":"v1","duration":10}}')"
	assert_eq "$_r" "[语音]" "tg_extract voice"
}

test_tg_extract_video() {
	_r="$(tg_extract_text '{"video":{"file_id":"v1","width":800,"height":600,"duration":30}}')"
	assert_eq "$_r" "[视频]" "tg_extract video"
}

test_tg_extract_text_priority() {
	_r="$(tg_extract_text '{"text":"hello","photo":[{"file_id":"p1"}]}')"
	assert_eq "$_r" "hello" "tg_extract text over photo"
}

test_tg_extract_caption() {
	_r="$(tg_extract_text '{"photo":[{"file_id":"p1"}],"caption":"check this out"}')"
	assert_eq "$_r" "[图片] check this out" "tg_extract caption with photo"
}

test_tg_extract_empty() {
	_r="$(tg_extract_text '{"message_id":1,"date":123,"chat":{"id":1}}')"
	assert_eq "$_r" "" "tg_extract no content"
}

test_tg_webhook_channel_post() {
	_update='{"update_id":3,"channel_post":{"message_id":1,"chat":{"id":-100},"text":"/announce"}}'
	tg_webhook "$_update" 2>/dev/null
	assert_ok "tg_webhook channel_post parsed"
}

test_tg_webhook_edited_message() {
	_update='{"update_id":4,"edited_message":{"message_id":1,"chat":{"id":222},"text":"edited"}}'
	tg_webhook "$_update" 2>/dev/null
	assert_ok "tg_webhook edited_message parsed"
}

test_tg_extract_photo
test_tg_extract_sticker
test_tg_extract_document
test_tg_extract_voice
test_tg_extract_video
test_tg_extract_text_priority
test_tg_extract_caption
test_tg_extract_empty
test_tg_webhook_channel_post
test_tg_webhook_edited_message
test_tg_getMe
test_tg_sendMessage
test_tg_getUpdates
test_tg_setWebhook
test_tg_webhook_message
test_tg_webhook_callback
