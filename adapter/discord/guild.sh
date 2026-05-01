# Discord Guild API

. "$_HB/adapter/discord/core.sh"

dc_guild_get()              { _dc_get "/guilds/$1"; }
dc_guild_channels()         { _dc_get "/guilds/$1/channels"; }
dc_guild_member_get()       { _dc_get "/guilds/$1/members/$2"; }
dc_guild_members_list()     { _dc_get "/guilds/$1/members?limit=${2:-100}"; }
dc_guild_roles()            { _dc_get "/guilds/$1/roles"; }
