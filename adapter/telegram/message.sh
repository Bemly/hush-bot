# Telegram Message API — send, edit, delete, forward

. "$_HB/adapter/telegram/core.sh"

tg_sendMessage() {
    _body="$(json_obj "chat_id" "$1" "text" "$2")"
    [ -n "${3:-}" ] && _body="$(printf '%s' "$_body" | sed 's/}$/,"parse_mode":"'"$3"'"/}')"
    _tg_api "sendMessage" "$_body" "tg.sendMessage"
}
tg_forwardMessage()     { _tg_api "forwardMessage" "$(json_obj "chat_id" "$1" "from_chat_id" "$2" "message_id" "$3")" "tg.forwardMessage"; }
tg_copyMessage()        { _tg_api "copyMessage"    "$(json_obj "chat_id" "$1" "from_chat_id" "$2" "message_id" "$3")" "tg.copyMessage"; }
tg_deleteMessage()      { _tg_api "deleteMessage"  "$(json_obj "chat_id" "$1" "message_id" "$2")" "tg.deleteMessage"; }
tg_deleteMessages()     { _tg_api "deleteMessages" "$(json_obj "chat_id" "$1" "message_ids" "$2")" "tg.deleteMessages"; }

tg_sendPhoto()          { _tg_api "sendPhoto"    "$(json_obj "chat_id" "$1" "photo" "$2" "caption" "${3:-}")" "tg.sendPhoto"; }
tg_sendAudio()          { _tg_api "sendAudio"    "$(json_obj "chat_id" "$1" "audio" "$2" "caption" "${3:-}")" "tg.sendAudio"; }
tg_sendDocument()       { _tg_api "sendDocument" "$(json_obj "chat_id" "$1" "document" "$2" "caption" "${3:-}")" "tg.sendDocument"; }
tg_sendVideo()          { _tg_api "sendVideo"    "$(json_obj "chat_id" "$1" "video" "$2" "caption" "${3:-}")" "tg.sendVideo"; }
tg_sendVoice()          { _tg_api "sendVoice"    "$(json_obj "chat_id" "$1" "voice" "$2")" "tg.sendVoice"; }
tg_sendAnimation()      { _tg_api "sendAnimation" "$(json_obj "chat_id" "$1" "animation" "$2" "caption" "${3:-}")" "tg.sendAnimation"; }
tg_sendVideoNote()      { _tg_api "sendVideoNote" "$(json_obj "chat_id" "$1" "video_note" "$2")" "tg.sendVideoNote"; }
tg_sendMediaGroup()     { _tg_api "sendMediaGroup" "$(json_obj "chat_id" "$1" "media" "$2")" "tg.sendMediaGroup"; }
tg_sendSticker()        { _tg_api "sendSticker"  "$(json_obj "chat_id" "$1" "sticker" "$2")" "tg.sendSticker"; }
tg_sendDice()           { _tg_api "sendDice"     "$(json_obj "chat_id" "$1")" "tg.sendDice"; }

tg_sendLocation()       { _tg_api "sendLocation" "$(json_obj "chat_id" "$1" "latitude" "$2" "longitude" "$3")" "tg.sendLocation"; }
tg_sendVenue()          { _tg_api "sendVenue"    "$(json_obj "chat_id" "$1" "latitude" "$2" "longitude" "$3" "title" "$4" "address" "$5")" "tg.sendVenue"; }
tg_sendContact()        { _tg_api "sendContact"  "$(json_obj "chat_id" "$1" "phone_number" "$2" "first_name" "$3")" "tg.sendContact"; }
tg_sendPoll()           { _tg_api "sendPoll"     "$(json_obj "chat_id" "$1" "question" "$2" "options" "$3")" "tg.sendPoll"; }
tg_stopPoll()           { _tg_api "stopPoll"     "$(json_obj "chat_id" "$1" "message_id" "$2")" "tg.stopPoll"; }

tg_sendChatAction()     { _tg_api "sendChatAction" "$(json_obj "chat_id" "$1" "action" "$2")" "tg.sendChatAction"; }

tg_editMessageText()    { _tg_api "editMessageText" "$(json_obj "chat_id" "$1" "message_id" "$2" "text" "$3")" "tg.editMessageText"; }
tg_editMessageCaption() { _tg_api "editMessageCaption" "$(json_obj "chat_id" "$1" "message_id" "$2" "caption" "${3:-}")" "tg.editMessageCaption"; }

tg_answerCallbackQuery() { _tg_api "answerCallbackQuery" "$(json_obj "callback_query_id" "$1" "text" "${2:-}")" "tg.answerCallback"; }

tg_reply() { tg_sendMessage "$1" "$2" "${3:-}"; }
