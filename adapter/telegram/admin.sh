# Telegram Admin API — ban, restrict, promote, invites, verification

. "$_HB/adapter/telegram/core.sh"

# Ban / unban
tg_banChatMember()         { _tg_call "banChatMember"         "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_unbanChatMember()       { _tg_call "unbanChatMember"       "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_banChatSenderChat()     { _tg_call "banChatSenderChat"     "$(json_obj "chat_id" "$1" "sender_chat_id" "$2")" >/dev/null; }
tg_unbanChatSenderChat()   { _tg_call "unbanChatSenderChat"   "$(json_obj "chat_id" "$1" "sender_chat_id" "$2")" >/dev/null; }

# Restrict / promote
tg_restrictChatMember()    { _tg_call "restrictChatMember"    "$(json_obj "chat_id" "$1" "user_id" "$2" "permissions" "$3")" >/dev/null; }
tg_promoteChatMember()     { _tg_call "promoteChatMember"     "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_setChatPermissions()    { _tg_call "setChatPermissions"    "$(json_obj "chat_id" "$1" "permissions" "$2")" >/dev/null; }

# Invite links
tg_createChatInviteLink()       { _tg_api "createChatInviteLink"       "$(json_obj "chat_id" "$1")" "tg.createInviteLink"; }
tg_editChatInviteLink()         { _tg_call "editChatInviteLink"         "$(json_obj "chat_id" "$1" "invite_link" "$2")" >/dev/null; }
tg_revokeChatInviteLink()       { _tg_call "revokeChatInviteLink"       "$(json_obj "chat_id" "$1" "invite_link" "$2")" >/dev/null; }
tg_exportChatInviteLink()       { _tg_api "exportChatInviteLink"       "$(json_obj "chat_id" "$1")" "tg.exportInviteLink"; }
tg_createChatSubscriptionInviteLink() { _tg_api "createChatSubscriptionInviteLink" "$(json_obj "chat_id" "$1" "subscription_period" "$2" "subscription_price" "$3")" "tg.createSubInviteLink"; }
tg_editChatSubscriptionInviteLink()   { _tg_call "editChatSubscriptionInviteLink"   "$(json_obj "chat_id" "$1" "invite_link" "$2")" >/dev/null; }

# Join requests
tg_approveChatJoinRequest()  { _tg_call "approveChatJoinRequest"  "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_declineChatJoinRequest()  { _tg_call "declineChatJoinRequest"  "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }

# Verification
tg_verifyChat()            { _tg_call "verifyChat"            "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_verifyUser()            { _tg_call "verifyUser"            "$(json_obj "user_id" "$1")" >/dev/null; }
tg_removeChatVerification() { _tg_call "removeChatVerification" "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_removeUserVerification() { _tg_call "removeUserVerification" "$(json_obj "user_id" "$1")" >/dev/null; }
