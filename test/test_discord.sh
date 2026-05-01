# Discord adapter tests (mock_wget, no real API keys)

# --- Message ---
test_dc_message_create() {
    mock_set '{"id":"msg1","content":"hello","channel_id":"ch1"}'
    _r="$(dc_message_create "ch1" '{"content":"hello"}')" && _rc=0 || _rc=$?
    assert_contains "$_r" "msg1" "dc_message_create"
}
test_dc_message_get() {
    mock_set '{"id":"msg1","content":"hi"}'
    _r="$(dc_message_get "ch1" "msg1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "hi" "dc_message_get"
}
test_dc_message_edit() {
    mock_set '{"id":"msg1","content":"edited"}'
    _r="$(dc_message_edit "ch1" "msg1" '{"content":"edited"}')" && _rc=0 || _rc=$?
    assert_contains "$_r" "edited" "dc_message_edit"
}
test_dc_message_delete() {
    mock_set '{}'; dc_message_delete "ch1" "msg1" 2>/dev/null; assert_ok "dc_message_delete"
}
test_dc_pin_add() {
    mock_set '{}'; dc_pin_add "ch1" "msg1" 2>/dev/null; assert_ok "dc_pin_add"
}

# --- Channel ---
test_dc_channel_get() {
    mock_set '{"id":"ch1","name":"general"}'
    _r="$(dc_channel_get "ch1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "general" "dc_channel_get"
}
test_dc_dm_create() {
    mock_set '{"id":"dm1"}'
    _r="$(dc_dm_create '{"recipient_id":"u1"}')" && _rc=0 || _rc=$?
    assert_contains "$_r" "dm1" "dc_dm_create"
}
test_dc_thread_join() {
    mock_set '{}'; dc_thread_join "ch1" 2>/dev/null; assert_ok "dc_thread_join"
}

# --- Guild ---
test_dc_guild_get() {
    mock_set '{"id":"g1","name":"TestGuild"}'
    _r="$(dc_guild_get "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "TestGuild" "dc_guild_get"
}
test_dc_guild_member_get() {
    mock_set '{"user":{"id":"u1","nick":"test"}}'
    _r="$(dc_guild_member_get "g1" "u1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "test" "dc_guild_member_get"
}
test_dc_guild_ban_create() {
    mock_set '{}'; dc_guild_ban_create "g1" "u1" "{}" 2>/dev/null; assert_ok "dc_guild_ban_create"
}
test_dc_guild_role_list() {
    mock_set '[{"id":"r1","name":"admin"}]'
    _r="$(dc_guild_role_list "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "admin" "dc_guild_role_list"
}
test_dc_guild_leave() {
    mock_set '{}'; dc_guild_leave "g1" 2>/dev/null; assert_ok "dc_guild_leave"
}

# --- Webhook ---
test_dc_webhook_execute() {
    mock_set '{}'
    dc_webhook_execute "x" "y" "hello" 2>/dev/null
    assert_ok "dc_webhook_execute"
}
test_dc_webhook_create() {
    mock_set '{"id":"wh1","name":"testhook"}'
    _r="$(dc_webhook_create "ch1" '{"name":"test"}')" && _rc=0 || _rc=$?
    assert_contains "$_r" "wh1" "dc_webhook_create"
}

# --- User ---
test_dc_user_get() {
    mock_set '{"id":"u1","username":"testuser"}'
    _r="$(dc_user_get "u1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "testuser" "dc_user_get"
}
test_dc_user_current() {
    mock_set '{"id":"me","username":"bot"}'
    _r="$(dc_user_current)" && _rc=0 || _rc=$?
    assert_contains "$_r" "bot" "dc_user_current"
}

# --- Emoji ---
test_dc_emoji_list() {
    mock_set '[{"id":"e1","name":"smile"}]'
    _r="$(dc_emoji_list "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "smile" "dc_emoji_list"
}
test_dc_emoji_create() {
    mock_set '{"id":"e2","name":"laugh"}'
    _r="$(dc_emoji_create "g1" '{"name":"laugh","image":"data:image/png;base64,x"}')" && _rc=0 || _rc=$?
    assert_contains "$_r" "laugh" "dc_emoji_create"
}

# --- Sticker ---
test_dc_sticker_get() {
    mock_set '{"id":"s1","name":"wave"}'
    _r="$(dc_sticker_get "s1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "wave" "dc_sticker_get"
}
test_dc_guild_sticker_list() {
    mock_set '[{"id":"s1","name":"wave"}]'
    _r="$(dc_guild_sticker_list "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "wave" "dc_guild_sticker_list"
}

# --- Auto Moderation ---
test_dc_automod_list() {
    mock_set '[{"id":"am1","name":"no-spam"}]'
    _r="$(dc_automod_list "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "no-spam" "dc_automod_list"
}

# --- Scheduled Events ---
test_dc_event_list() {
    mock_set '[{"id":"ev1","name":"Party"}]'
    _r="$(dc_event_list "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "Party" "dc_event_list"
}

# --- Template ---
test_dc_template_get() {
    mock_set '{"code":"abc","name":"cool-server"}'
    _r="$(dc_template_get "abc")" && _rc=0 || _rc=$?
    assert_contains "$_r" "cool-server" "dc_template_get"
}

# --- Invite ---
test_dc_invite_get() {
    mock_set '{"code":"xyz","guild":{"id":"g1","name":"invited"}}'
    _r="$(dc_invite_get "xyz")" && _rc=0 || _rc=$?
    assert_contains "$_r" "invited" "dc_invite_get"
}

# --- Stage ---
test_dc_stage_create() {
    mock_set '{"id":"st1","topic":"karaoke"}'
    _r="$(dc_stage_create '{"channel_id":"ch1","topic":"karaoke"}')" && _rc=0 || _rc=$?
    assert_contains "$_r" "karaoke" "dc_stage_create"
}

# --- Voice ---
test_dc_voice_regions() {
    mock_set '[{"id":"us-east","name":"US East"}]'
    _r="$(dc_voice_regions)" && _rc=0 || _rc=$?
    assert_contains "$_r" "US East" "dc_voice_regions"
}

# --- Audit Log ---
test_dc_audit_log() {
    mock_set '{"audit_log_entries":[]}'
    _r="$(dc_audit_log "g1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "audit_log_entries" "dc_audit_log"
}

# --- Poll ---
test_dc_poll_expire() {
    mock_set '{}'; dc_poll_expire "ch1" "msg1" 2>/dev/null; assert_ok "dc_poll_expire"
}

# --- Soundboard ---
test_dc_soundboard_defaults() {
    mock_set '[{"name":"quack","sound_id":"s1"}]'
    _r="$(dc_soundboard_defaults)" && _rc=0 || _rc=$?
    assert_contains "$_r" "quack" "dc_soundboard_defaults"
}

# --- Application ---
test_dc_app_current() {
    mock_set '{"id":"app1","name":"MyBot"}'
    _r="$(dc_app_current)" && _rc=0 || _rc=$?
    assert_contains "$_r" "MyBot" "dc_app_current"
}

# --- Monetization ---
test_dc_sku_list() {
    mock_set '[{"id":"sku1","name":"Premium"}]'
    _r="$(dc_sku_list "app1")" && _rc=0 || _rc=$?
    assert_contains "$_r" "Premium" "dc_sku_list"
}

# Run all tests
test_dc_message_create; test_dc_message_get; test_dc_message_edit; test_dc_message_delete; test_dc_pin_add
test_dc_channel_get; test_dc_dm_create; test_dc_thread_join
test_dc_guild_get; test_dc_guild_member_get; test_dc_guild_ban_create; test_dc_guild_role_list; test_dc_guild_leave
test_dc_webhook_execute; test_dc_webhook_create
test_dc_user_get; test_dc_user_current
test_dc_emoji_list; test_dc_emoji_create
test_dc_sticker_get; test_dc_guild_sticker_list
test_dc_automod_list
test_dc_event_list
test_dc_template_get
test_dc_invite_get
test_dc_stage_create
test_dc_voice_regions
test_dc_audit_log
test_dc_poll_expire
test_dc_soundboard_defaults
test_dc_app_current
test_dc_sku_list
