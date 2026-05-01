# Telegram Game API

. "$_HB/adapter/telegram/core.sh"

tg_sendGame()        { _tg_api "sendGame"        "$(json_obj "chat_id" "$1" "game_short_name" "$2")" "tg.sendGame"; }
tg_setGameScore()    { _tg_api "setGameScore"    "$(json_obj "user_id" "$1" "score" "$2" "chat_id" "${3:-0}")" "tg.setGameScore"; }
tg_getGameHighScores() { _tg_api "getGameHighScores" "$(json_obj "user_id" "$1" "chat_id" "${2:-0}")" "tg.gameHighScores"; }
