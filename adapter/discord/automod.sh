# Discord Auto Moderation API

. "$_HB/adapter/discord/core.sh"

dc_automod_list()   { _dc_get "/guilds/$1/auto-moderation/rules"; }
dc_automod_get()    { _dc_get "/guilds/$1/auto-moderation/rules/$2"; }
dc_automod_create() { _dc_api "POST" "/guilds/$1/auto-moderation/rules" "$2"; }
dc_automod_modify() { _dc_api "PATCH" "/guilds/$1/auto-moderation/rules/$2" "$3"; }
dc_automod_delete() { _dc_void "DELETE" "/guilds/$1/auto-moderation/rules/$2"; }
