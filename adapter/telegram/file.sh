# Telegram File API

. "$_HB/adapter/telegram/core.sh"

tg_getFile()              { _tg_api "getFile"              "$(json_obj "file_id" "$1")" "tg.getFile"; }
tg_getUserProfilePhotos() { _tg_api "getUserProfilePhotos" "$(json_obj "user_id" "$1" "offset" "${2:-0}" "limit" "${3:-100}")" "tg.userPhotos"; }
