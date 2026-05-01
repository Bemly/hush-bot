# Telegram Inline API

. "$_HB/adapter/telegram/core.sh"

# answerInlineQuery <inline_query_id> <results_json_array>
tg_answerInlineQuery() {
    _tg_api "answerInlineQuery" "$(json_obj "inline_query_id" "$1" "results" "$2")" "tg.answerInlineQuery"
}
