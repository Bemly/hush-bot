# Telegram Message API

. "$_HB/adapter/telegram/core.sh"

tg_sendMessage() {
    _body="$(json_obj "chat_id" "$1" "text" "$2")"
    [ -n "${3:-}" ] && _body="$(printf '%s' "$_body" | sed 's/}$/,"parse_mode":"'"$3"'"/}')"
    _tg_api "sendMessage" "$_body" "tg.sendMessage"
}
tg_forwardMessage()  { _tg_api "forwardMessage" "$(json_obj "chat_id" "$1" "from_chat_id" "$2" "message_id" "$3")" "tg.forwardMessage"; }
tg_copyMessage()     { _tg_api "copyMessage"    "$(json_obj "chat_id" "$1" "from_chat_id" "$2" "message_id" "$3")" "tg.copyMessage"; }
tg_deleteMessage()   { _tg_api "deleteMessage"  "$(json_obj "chat_id" "$1" "message_id" "$2")" "tg.deleteMessage"; }

tg_sendPhoto()       { _tg_api "sendPhoto"   "$(json_obj "chat_id" "$1" "photo" "$2" "caption" "${3:-}")" "tg.sendPhoto"; }
tg_sendAudio()       { _tg_api "sendAudio"   "$(json_obj "chat_id" "$1" "audio" "$2" "caption" "${3:-}")" "tg.sendAudio"; }
tg_sendDocument()    { _tg_api "sendDocument" "$(json_obj "chat_id" "$1" "document" "$2" "caption" "${3:-}")" "tg.sendDocument"; }
tg_sendVideo()       { _tg_api "sendVideo"   "$(json_obj "chat_id" "$1" "video" "$2" "caption" "${3:-}")" "tg.sendVideo"; }
tg_sendVoice()       { _tg_api "sendVoice"   "$(json_obj "chat_id" "$1" "voice" "$2")" "tg.sendVoice"; }

tg_sendChatAction() {
    _tg_api "sendChatAction" "$(json_obj "chat_id" "$1" "action" "$2")" "tg.sendChatAction"
}
tg_getChat()         { _tg_api "getChat" "$(json_obj "chat_id" "$1")" "tg.getChat"; }
tg_leaveChat()       { _tg_call "leaveChat" "$(json_obj "chat_id" "$1")" >/dev/null; }
tg_getChatMember()   { _tg_api "getChatMember" "$(json_obj "chat_id" "$1" "user_id" "$2")" "tg.getChatMember"; }
tg_getChatMemberCount() { _tg_api "getChatMemberCount" "$(json_obj "chat_id" "$1")" "tg.chatMemberCount"; }

tg_answerCallbackQuery() { _tg_api "answerCallbackQuery" "$(json_obj "callback_query_id" "$1" "text" "${2:-}")" "tg.answerCallback"; }
tg_editMessageText()     { _tg_api "editMessageText" "$(json_obj "chat_id" "$1" "message_id" "$2" "text" "$3")" "tg.editMessage"; }

# Helper: build a simple text reply
tg_reply() {
    _chat="$1" _text="$2" _parse="${3:-}"
    tg_sendMessage "$_chat" "$_text" "$_parse"
}
