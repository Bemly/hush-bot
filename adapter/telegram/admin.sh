# Telegram Admin API — ban, restrict, promote, invite links

. "$_HB/adapter/telegram/core.sh"

tg_banChatMember()         { _tg_call "banChatMember"         "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_unbanChatMember()       { _tg_call "unbanChatMember"       "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_restrictChatMember()    { _tg_call "restrictChatMember"    "$(json_obj "chat_id" "$1" "user_id" "$2" "permissions" "$3")" >/dev/null; }
tg_promoteChatMember()     { _tg_call "promoteChatMember"     "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_setChatPermissions()    { _tg_call "setChatPermissions"    "$(json_obj "chat_id" "$1" "permissions" "$2")" >/dev/null; }

tg_createChatInviteLink()  { _tg_api "createChatInviteLink"  "$(json_obj "chat_id" "$1")" "tg.createInviteLink"; }
tg_revokeChatInviteLink()  { _tg_call "revokeChatInviteLink"  "$(json_obj "chat_id" "$1" "invite_link" "$2")" >/dev/null; }
tg_exportChatInviteLink()  { _tg_api "exportChatInviteLink"  "$(json_obj "chat_id" "$1")" "tg.exportInviteLink"; }

tg_approveChatJoinRequest()  { _tg_call "approveChatJoinRequest"  "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
tg_declineChatJoinRequest()  { _tg_call "declineChatJoinRequest"  "$(json_obj "chat_id" "$1" "user_id" "$2")" >/dev/null; }
