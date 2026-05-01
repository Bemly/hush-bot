# Telegram Commands API

. "$_HB/adapter/telegram/core.sh"

tg_setMyCommands()    { _tg_call "setMyCommands"    "$(json_obj "commands" "$1")" >/dev/null; }
tg_getMyCommands()    { _tg_api "getMyCommands"     "{}" "tg.getMyCommands"; }
tg_deleteMyCommands() { _tg_call "deleteMyCommands" "{}" >/dev/null; }
