# Telegram Business API

. "$_HB/adapter/telegram/core.sh"

tg_getBusinessConnection()          { _tg_api "getBusinessConnection"          "$(json_obj "business_connection_id" "$1")" "tg.bizConnection"; }
tg_getBusinessAccountGifts()        { _tg_api "getBusinessAccountGifts"        "$(json_obj "business_connection_id" "$1")" "tg.bizGifts"; }
tg_getBusinessAccountStarBalance()  { _tg_api "getBusinessAccountStarBalance"  "$(json_obj "business_connection_id" "$1")" "tg.bizStarBalance"; }
tg_setBusinessAccountBio()          { _tg_call "setBusinessAccountBio"          "$(json_obj "business_connection_id" "$1" "bio" "$2")" >/dev/null; }
tg_setBusinessAccountName()         { _tg_call "setBusinessAccountName"         "$(json_obj "business_connection_id" "$1" "first_name" "$2")" >/dev/null; }
tg_setBusinessAccountProfilePhoto() { _tg_call "setBusinessAccountProfilePhoto" "$(json_obj "business_connection_id" "$1" "photo" "$2")" >/dev/null; }
tg_setBusinessAccountUsername()     { _tg_call "setBusinessAccountUsername"     "$(json_obj "business_connection_id" "$1" "username" "$2")" >/dev/null; }
tg_setBusinessAccountGiftSettings() { _tg_call "setBusinessAccountGiftSettings" "$(json_obj "business_connection_id" "$1" "accepted_gift_types" "$2")" >/dev/null; }
tg_removeBusinessAccountProfilePhoto() { _tg_call "removeBusinessAccountProfilePhoto" "$(json_obj "business_connection_id" "$1")" >/dev/null; }
tg_readBusinessMessage()            { _tg_call "readBusinessMessage"            "$(json_obj "business_connection_id" "$1" "chat_id" "$2" "message_id" "$3")" >/dev/null; }
tg_deleteBusinessMessages()         { _tg_call "deleteBusinessMessages"         "$(json_obj "business_connection_id" "$1" "message_ids" "$2")" >/dev/null; }
tg_transferBusinessAccountStars()   { _tg_call "transferBusinessAccountStars"   "$(json_obj "business_connection_id" "$1" "star_count" "$2")" >/dev/null; }
tg_replaceManagedBotToken()         { _tg_call "replaceManagedBotToken"         "$(json_obj "business_connection_id" "$1" "bot_token" "$2")" >/dev/null; }
tg_getManagedBotToken()             { _tg_api "getManagedBotToken"              "$(json_obj "business_connection_id" "$1")" "tg.managedBotToken"; }
