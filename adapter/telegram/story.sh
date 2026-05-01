# Telegram Story API

. "$_HB/adapter/telegram/core.sh"

tg_postStory()    { _tg_api "postStory"    "$(json_obj "chat_id" "$1" "content" "$2")" "tg.postStory"; }
tg_editStory()    { _tg_call "editStory"    "$(json_obj "chat_id" "$1" "story_id" "$2" "content" "$3")" >/dev/null; }
tg_deleteStory()  { _tg_call "deleteStory"  "$(json_obj "chat_id" "$1" "story_id" "$2")" >/dev/null; }
tg_repostStory()  { _tg_api "repostStory"  "$(json_obj "chat_id" "$1" "story_chat_id" "$2" "story_id" "$3")" "tg.repostStory"; }
