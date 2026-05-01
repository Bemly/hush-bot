# Telegram Profile API — name, description, photo, commands, rights

. "$_HB/adapter/telegram/core.sh"

tg_setMyName()           { _tg_call "setMyName"           "$(json_obj "name" "$1")" >/dev/null; }
tg_getMyName()           { _tg_api "getMyName"            "{}" "tg.myName"; }
tg_setMyDescription()    { _tg_call "setMyDescription"    "$(json_obj "description" "$1")" >/dev/null; }
tg_getMyDescription()    { _tg_api "getMyDescription"     "{}" "tg.myDescription"; }
tg_setMyShortDescription() { _tg_call "setMyShortDescription" "$(json_obj "short_description" "$1")" >/dev/null; }
tg_getMyShortDescription() { _tg_api "getMyShortDescription"  "{}" "tg.myShortDescription"; }

tg_setMyProfilePhoto()   { _tg_call "setMyProfilePhoto"   "$(json_obj "photo" "$1")" >/dev/null; }
tg_removeMyProfilePhoto() { _tg_call "removeMyProfilePhoto" "{}" >/dev/null; }

tg_setMyDefaultAdministratorRights()  { _tg_call "setMyDefaultAdministratorRights"  "$(json_obj "rights" "$1")" >/dev/null; }
tg_getMyDefaultAdministratorRights()  { _tg_api "getMyDefaultAdministratorRights"   "{}" "tg.myAdminRights"; }

tg_setUserEmojiStatus()  { _tg_call "setUserEmojiStatus"  "$(json_obj "emoji_status_custom_emoji_id" "$1")" >/dev/null; }
