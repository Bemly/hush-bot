# Telegram Sticker API

. "$_HB/adapter/telegram/core.sh"

tg_getStickerSet()              { _tg_api "getStickerSet"              "$(json_obj "name" "$1")" "tg.getStickerSet"; }
tg_uploadStickerFile()          { _tg_api "uploadStickerFile"          "$(json_obj "user_id" "$1" "sticker" "$2" "sticker_format" "$3")" "tg.uploadStickerFile"; }
tg_createNewStickerSet()        { _tg_api "createNewStickerSet"        "$(json_obj "user_id" "$1" "name" "$2" "title" "$3" "stickers" "$4")" "tg.createStickerSet"; }
tg_addStickerToSet()            { _tg_call "addStickerToSet"           "$(json_obj "user_id" "$1" "name" "$2" "sticker" "$3")" >/dev/null; }
tg_setStickerPositionInSet()    { _tg_call "setStickerPositionInSet"   "$(json_obj "sticker" "$1" "position" "$2")" >/dev/null; }
tg_deleteStickerFromSet()       { _tg_call "deleteStickerFromSet"      "$(json_obj "sticker" "$1")" >/dev/null; }
tg_setStickerEmojiList()        { _tg_call "setStickerEmojiList"       "$(json_obj "sticker" "$1" "emoji_list" "$2")" >/dev/null; }
tg_setStickerKeywords()         { _tg_call "setStickerKeywords"        "$(json_obj "sticker" "$1" "keywords" "$2")" >/dev/null; }
tg_setStickerMaskPosition()     { _tg_call "setStickerMaskPosition"    "$(json_obj "sticker" "$1" "mask_position" "$2")" >/dev/null; }
tg_setStickerSetThumbnail()     { _tg_call "setStickerSetThumbnail"    "$(json_obj "name" "$1" "user_id" "$2" "thumbnail" "$3")" >/dev/null; }
tg_setCustomEmojiStickerSetThumbnail() { _tg_call "setCustomEmojiStickerSetThumbnail" "$(json_obj "name" "$1" "custom_emoji_id" "$2")" >/dev/null; }
tg_setStickerSetTitle()         { _tg_call "setStickerSetTitle"        "$(json_obj "name" "$1" "title" "$2")" >/dev/null; }
tg_deleteStickerSet()           { _tg_call "deleteStickerSet"          "$(json_obj "name" "$1")" >/dev/null; }
tg_replaceStickerInSet()        { _tg_call "replaceStickerInSet"       "$(json_obj "user_id" "$1" "name" "$2" "old_sticker" "$3" "sticker" "$4")" >/dev/null; }
tg_getCustomEmojiStickers()     { _tg_api "getCustomEmojiStickers"     "$(json_obj "custom_emoji_ids" "$1")" "tg.customEmoji"; }
tg_getForumTopicIconStickers()  { _tg_api "getForumTopicIconStickers"  "{}" "tg.forumTopicIcons"; }
