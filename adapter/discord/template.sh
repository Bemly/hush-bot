# Discord Guild Template API

. "$_HB/adapter/discord/core.sh"

dc_template_get()           { _dc_get "/guilds/templates/$1"; }
dc_guild_template_list()    { _dc_get "/guilds/$1/templates"; }
dc_guild_template_create()  { _dc_api "POST" "/guilds/$1/templates" "$2"; }
dc_guild_template_sync()    { _dc_api "PUT" "/guilds/$1/templates/$2" "{}"; }
dc_guild_template_modify()  { _dc_api "PATCH" "/guilds/$1/templates/$2" "$3"; }
dc_guild_template_delete()  { _dc_void "DELETE" "/guilds/$1/templates/$2"; }
