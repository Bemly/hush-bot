# Telegram Chat API

. "$_HB/adapter/telegram/core.sh"

tg_getChat()              { _tg_api "getChat"              "$(json_obj "chat_id" "$1")" "tg.getChat"; }
tg_getChatMember()        { _tg_api "getChatMember"        "$(json_obj "chat_id" "$1" "user_id" "$2")" "tg.getChatMember"; }
tg_getChatMemberCount()   { _tg_api "getChatMemberCount"   "$(json_obj "chat_id" "$1")" "tg.chatMemberCount"; }
tg_getChatAdministrators() { _tg_api "getChatAdministrators" "$(json_obj "chat_id" "$1")" "tg.chatAdmin"; }
tg_leaveChat()             { _tg_call "leaveChat"           "$(json_obj "chat_id" "$1")" >/dev/null; }

tg_setChatTitle()         { _tg_call "setChatTitle"         "$(json_obj "chat_id" "$1" "title" "$2")" >/dev/null; }
tg_setChatDescription()   { _tg_call "setChatDescription"   "$(json_obj "chat_id" "$1" "description" "$2")" >/dev/null; }
tg_setChatPhoto()         { _tg_call "setChatPhoto"         "$(json_obj "chat_id" "$1" "photo" "$2")" >/dev/null; }
tg_deleteChatPhoto()      { _tg_call "deleteChatPhoto"      "$(json_obj "chat_id" "$1")" >/dev/null; }

tg_pinChatMessage()       { _tg_call "pinChatMessage"       "$(json_obj "chat_id" "$1" "message_id" "$2")" >/dev/null; }
tg_unpinChatMessage()     { _tg_call "unpinChatMessage"     "$(json_obj "chat_id" "$1" "message_id" "$2")" >/dev/null; }
tg_unpinAllChatMessages() { _tg_call "unpinAllChatMessages" "$(json_obj "chat_id" "$1")" >/dev/null; }
