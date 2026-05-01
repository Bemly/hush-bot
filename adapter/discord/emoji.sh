# Discord Emoji API

. "$_HB/adapter/discord/core.sh"

dc_emoji_list()           { _dc_get "/guilds/$1/emojis"; }
dc_emoji_get()            { _dc_get "/guilds/$1/emojis/$2"; }
dc_emoji_create()         { _dc_api "POST" "/guilds/$1/emojis" "$2"; }
dc_emoji_modify()         { _dc_api "PATCH" "/guilds/$1/emojis/$2" "$3"; }
dc_emoji_delete()         { _dc_void "DELETE" "/guilds/$1/emojis/$2"; }
dc_app_emoji_list()       { _dc_get "/applications/$1/emojis"; }
dc_app_emoji_get()        { _dc_get "/applications/$1/emojis/$2"; }
dc_app_emoji_create()     { _dc_api "POST" "/applications/$1/emojis" "$2"; }
dc_app_emoji_modify()     { _dc_api "PATCH" "/applications/$1/emojis/$2" "$3"; }
dc_app_emoji_delete()     { _dc_void "DELETE" "/applications/$1/emojis/$2"; }
