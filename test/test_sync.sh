# test/test_sync.sh — cross-platform sync tests (no accounts needed)
# Uses mock_wget to simulate API responses

. ./plugin/sync.sh

test_sync_qq_to_telegram() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'qq/group/100=telegram/-200\n' > "$_SYNC_CONF"
    mock_set '{"ok":true,"result":{"message_id":99}}'

    _raw='{"peer_id":100,"sender_id":111,"message_seq":1,"message_scene":"group","group_id":100,"group_member":{"user_id":111,"nickname":"Alice"},"segments":[{"type":"text","data":{"text":"hello"}}]}'
    sync_handler "qq" "message" "111" "hello" "$_raw" 2>/dev/null
    assert_ok "sync qq→telegram"
    rm -f "$_SYNC_CONF"
}

test_sync_qq_to_discord() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'qq/group/100=discord/300\n' > "$_SYNC_CONF"
    mock_set '{"id":"msg1","content":"discord msg"}'

    _raw='{"peer_id":100,"sender_id":111,"message_seq":1,"message_scene":"group","group_id":100,"group_member":{"user_id":111,"nickname":"Alice"},"segments":[{"type":"text","data":{"text":"hello"}}]}'
    sync_handler "qq" "message" "111" "hello" "$_raw" 2>/dev/null
    assert_ok "sync qq→discord"
    rm -f "$_SYNC_CONF"
}

test_sync_telegram_to_qq() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'telegram/-200=qq/group/100\n' > "$_SYNC_CONF"
    mock_set '{"status":"ok","retcode":0,"data":{"message_seq":1,"time":1}}'

    _raw='{"message_id":1,"from":{"id":222,"is_bot":false,"first_name":"Bob"},"chat":{"id":-200,"type":"group","title":"Test"},"date":1234567890,"text":"hi from tg"}'
    sync_handler "telegram" "message" "" "hi from tg" "$_raw" 2>/dev/null
    assert_ok "sync telegram→qq"
    rm -f "$_SYNC_CONF"
}

test_sync_telegram_to_discord() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'telegram/-200=discord/300\n' > "$_SYNC_CONF"
    mock_set '{"id":"msg2","content":"discord msg"}'

    _raw='{"message_id":1,"from":{"id":222,"is_bot":false,"first_name":"Bob"},"chat":{"id":-200,"type":"group","title":"Test"},"date":1234567890,"text":"hi from tg"}'
    sync_handler "telegram" "message" "" "hi from tg" "$_raw" 2>/dev/null
    assert_ok "sync telegram→discord"
    rm -f "$_SYNC_CONF"
}

test_sync_skip_non_message() {
    sync_handler "qq" "group_nudge" "111" "nudge" "{}" 2>/dev/null
    assert_ok "sync skips non-message events"
}

test_sync_skip_sync_prefix() {
    sync_handler "qq" "message" "111" "[sync] [tg] Bob: hello" "{}" 2>/dev/null
    assert_ok "sync skips [sync] prefixed messages"
}

test_sync_no_config() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'qq/group/999=telegram/-888\n' > "$_SYNC_CONF"

    _raw='{"peer_id":100,"sender_id":111,"message_seq":1,"message_scene":"group","group_id":100,"segments":[{"type":"text","data":{"text":"hello"}}]}'
    sync_handler "qq" "message" "111" "hello" "$_raw" 2>/dev/null
    assert_ok "sync handles no matching config"
    rm -f "$_SYNC_CONF"
}

test_sync_missing_config_file() {
    _SYNC_CONF="/tmp/nonexistent-sync-$$.conf"
    sync_handler "qq" "message" "111" "hello" "{}" 2>/dev/null
    assert_ok "sync handles missing config file"
}

test_sync_api_fail() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'qq/group/100=telegram/-200\n' > "$_SYNC_CONF"
    mock_fail

    _raw='{"peer_id":100,"sender_id":111,"message_seq":1,"message_scene":"group","group_id":100,"group_member":{"user_id":111,"nickname":"Alice"},"segments":[{"type":"text","data":{"text":"hello"}}]}'
    sync_handler "qq" "message" "111" "hello" "$_raw" 2>/dev/null
    assert_ok "sync survives API failure (best-effort)"
    rm -f "$_SYNC_CONF"
}

test_sync_multi_target() {
    _SYNC_CONF="/tmp/sync-test-$$.conf"
    printf 'qq/group/100=telegram/-200\n' > "$_SYNC_CONF"
    printf 'qq/group/100=discord/300\n' >> "$_SYNC_CONF"
    mock_set '{"ok":true,"result":{"message_id":99}}'

    _raw='{"peer_id":100,"sender_id":111,"message_seq":1,"message_scene":"group","group_id":100,"group_member":{"user_id":111,"nickname":"Alice"},"segments":[{"type":"text","data":{"text":"hello"}}]}'
    sync_handler "qq" "message" "111" "hello" "$_raw" 2>/dev/null
    assert_ok "sync multi-target (qq→tg+dc)"
    rm -f "$_SYNC_CONF"
}

test_sync_qq_to_telegram
test_sync_qq_to_discord
test_sync_telegram_to_qq
test_sync_telegram_to_discord
test_sync_skip_non_message
test_sync_skip_sync_prefix
test_sync_no_config
test_sync_missing_config_file
test_sync_api_fail
test_sync_multi_target
