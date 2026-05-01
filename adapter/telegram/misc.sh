# Telegram misc API — remaining methods

. "$_HB/adapter/telegram/core.sh"

tg_answerWebAppQuery()           { _tg_api "answerWebAppQuery"           "$(json_obj "web_app_query_id" "$1" "result" "$2")" "tg.answerWebApp"; }
tg_savePreparedInlineMessage()   { _tg_api "savePreparedInlineMessage"   "$(json_obj "user_id" "$1" "result" "$2")" "tg.savePreparedInline"; }
tg_savePreparedKeyboardButton()  { _tg_api "savePreparedKeyboardButton"  "$1" "tg.savePreparedButton"; }
tg_getUserProfileAudios()        { _tg_api "getUserProfileAudios"        "$(json_obj "user_id" "$1")" "tg.userAudios"; }
tg_approveSuggestedPost()        { _tg_call "approveSuggestedPost"        "$(json_obj "chat_id" "$1" "message_id" "$2")" >/dev/null; }
tg_declineSuggestedPost()        { _tg_call "declineSuggestedPost"        "$(json_obj "chat_id" "$1" "message_id" "$2")" >/dev/null; }
tg_sendMessageDraft()            { _tg_call "sendMessageDraft"            "{}" >/dev/null; }
tg_sendChecklist()               { _tg_api "sendChecklist"               "$(json_obj "chat_id" "$1" "items" "$2")" "tg.sendChecklist"; }
tg_editMessageChecklist()        { _tg_api "editMessageChecklist"        "$(json_obj "chat_id" "$1" "message_id" "$2" "items" "$3")" "tg.editChecklist"; }
tg_sendPaidMedia()               { _tg_api "sendPaidMedia"               "$(json_obj "chat_id" "$1" "star_count" "$2" "media" "$3")" "tg.sendPaidMedia"; }
tg_editUserStarSubscription()    { _tg_call "editUserStarSubscription"    "$(json_obj "user_id" "$1" "is_canceled" "$2")" >/dev/null; }
tg_setPassportDataErrors()       { _tg_call "setPassportDataErrors"       "$(json_obj "user_id" "$1" "errors" "$2")" >/dev/null; }
