# Telegram Chat API — info, settings, forums, pinning

. "$_HB/adapter/telegram/core.sh"

# Info
tg_getChat()              { _tg_api "getChat"              "$(json_obj "chat_id" "$1")" "tg.getChat"; }
tg_getChatMember()        { _tg_api "getChatMember"        "$(json_obj "chat_id" "$1" "user_id" "$2")" "tg.getChatMember"; }
tg_getChatMemberCount()   { _tg_api "getChatMemberCount"   "$(json_obj "chat_id" "$1")" "tg.chatMemberCount"; }
tg_getChatAdministrators() { _tg_api "getChatAdministrators" "$(json_obj "chat_id" "$1")" "tg.chatAdmin"; }
tg_leaveChat()             { _tg_call "leaveChat"           "$(json_obj "chat_id" "$1")" >/dev/null; }

# Settings
tg_setChatTitle()              { _tg_call "setChatTitle"              "$(json_obj "chat_id" "$1" "title" "$2")" >/dev/null; }
tg_setChatDescription()        { _tg_call "setChatDescription"        "$(json_obj "chat_id" "$1" "description" "$2")" >/dev/null; }
tg_setChatPhoto()              { _tg_call "setChatPhoto"              "$(json_obj "chat_id" "$1" "photo" "$2")" >/dev/null; }
tg_deleteChatPhoto()           { _tg_call "deleteChatPhoto"           "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_setChatAdministratorCustomTitle() { _tg_call "setChatAdministratorCustomTitle" "$(json_obj "chat_id" "$1" "user_id" "$2" "custom_title" "$3")" >/dev/null; }
tg_setChatStickerSet()         { _tg_call "setChatStickerSet"         "$(json_obj "chat_id" "$1" "sticker_set_name" "$2")" >/dev/null; }
tg_deleteChatStickerSet()      { _tg_call "deleteChatStickerSet"      "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_setChatMenuButton()         { _tg_call "setChatMenuButton"         "$(json_obj "chat_id" "$1" "menu_button" "$2")" >/dev/null; }
tg_getChatMenuButton()         { _tg_api "getChatMenuButton"          "$(json_obj "chat_id" "$1")" "tg.chatMenuButton"; }
tg_setChatMemberTag()          { _tg_call "setChatMemberTag"          "$(json_obj "chat_id" "$1" "user_id" "$2" "tag" "$3")" >/dev/null; }

# Pinning
tg_pinChatMessage()            { _tg_call "pinChatMessage"            "$(json_obj "chat_id" "$1" "message_id" "$2")" >/dev/null; }
tg_unpinChatMessage()          { _tg_call "unpinChatMessage"          "$(json_obj "chat_id" "$1" "message_id" "$2")" >/dev/null; }
tg_unpinAllChatMessages()      { _tg_call "unpinAllChatMessages"      "$(json_obj "chat_id" "$1")" >/dev/null; }

# Forum topics
tg_createForumTopic()          { _tg_api "createForumTopic"           "$(json_obj "chat_id" "$1" "name" "$2")" "tg.createForumTopic"; }
tg_editForumTopic()            { _tg_call "editForumTopic"            "$(json_obj "chat_id" "$1" "message_thread_id" "$2" "name" "${3:-}")" >/dev/null; }
tg_closeForumTopic()           { _tg_call "closeForumTopic"           "$(json_obj "chat_id" "$1" "message_thread_id" "$2")" >/dev/null; }
tg_reopenForumTopic()          { _tg_call "reopenForumTopic"          "$(json_obj "chat_id" "$1" "message_thread_id" "$2")" >/dev/null; }
tg_deleteForumTopic()          { _tg_call "deleteForumTopic"          "$(json_obj "chat_id" "$1" "message_thread_id" "$2")" >/dev/null; }
tg_unpinAllForumTopicMessages() { _tg_call "unpinAllForumTopicMessages" "$(json_obj "chat_id" "$1" "message_thread_id" "$2")" >/dev/null; }
tg_editGeneralForumTopic()     { _tg_call "editGeneralForumTopic"     "$(json_obj "chat_id" "$1" "name" "$2")" >/dev/null; }
tg_closeGeneralForumTopic()    { _tg_call "closeGeneralForumTopic"    "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_reopenGeneralForumTopic()   { _tg_call "reopenGeneralForumTopic"   "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_hideGeneralForumTopic()     { _tg_call "hideGeneralForumTopic"     "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_unhideGeneralForumTopic()   { _tg_call "unhideGeneralForumTopic"   "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_unpinAllGeneralForumTopicMessages() { _tg_call "unpinAllGeneralForumTopicMessages" "$(json_obj "chat_id" "$1")" >/dev/null; }
