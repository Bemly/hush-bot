# Telegram Gift API

. "$_HB/adapter/telegram/core.sh"

tg_sendGift()                 { _tg_api "sendGift"                 "$(json_obj "chat_id" "$1" "gift_id" "$2")" "tg.sendGift"; }
tg_getAvailableGifts()        { _tg_api "getAvailableGifts"        "{}" "tg.availableGifts"; }
tg_getUserGifts()             { _tg_api "getUserGifts"             "$(json_obj "user_id" "$1")" "tg.userGifts"; }
tg_getUserChatBoosts()        { _tg_api "getUserChatBoosts"        "$(json_obj "chat_id" "$1" "user_id" "$2")" "tg.userChatBoosts"; }
tg_getChatGifts()             { _tg_api "getChatGifts"             "$(json_obj "chat_id" "$1")" "tg.chatGifts"; }
tg_giftPremiumSubscription()  { _tg_call "giftPremiumSubscription"  "$(json_obj "user_id" "$1" "month_count" "$2")" >/dev/null; }
