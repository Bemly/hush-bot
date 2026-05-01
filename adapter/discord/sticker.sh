# Discord Sticker API

. "$_HB/adapter/discord/core.sh"

dc_sticker_get()          { _dc_get "/stickers/$1"; }
dc_sticker_pack_list()    { _dc_get "/sticker-packs"; }
dc_sticker_pack_get()     { _dc_get "/sticker-packs/$1"; }
dc_guild_sticker_list()   { _dc_get "/guilds/$1/stickers"; }
dc_guild_sticker_get()    { _dc_get "/guilds/$1/stickers/$2"; }
dc_guild_sticker_create() { _dc_api "POST" "/guilds/$1/stickers" "$2"; }
dc_guild_sticker_modify() { _dc_api "PATCH" "/guilds/$1/stickers/$2" "$3"; }
dc_guild_sticker_delete() { _dc_void "DELETE" "/guilds/$1/stickers/$2"; }
