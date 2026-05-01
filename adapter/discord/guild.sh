# Discord Guild API

. "$_HB/adapter/discord/core.sh"

dc_guild_get()                 { _dc_get "/guilds/$1"; }
dc_guild_preview()             { _dc_get "/guilds/$1/preview"; }
dc_guild_modify()              { _dc_api "PATCH" "/guilds/$1" "$2"; }
dc_guild_channel_list()        { _dc_get "/guilds/$1/channels"; }
dc_guild_channel_create()      { _dc_api "POST" "/guilds/$1/channels" "$2"; }
dc_guild_member_get()          { _dc_get "/guilds/$1/members/$2"; }
dc_guild_member_list()         { _dc_get "/guilds/$1/members"; }
dc_guild_member_add()          { _dc_api "PUT" "/guilds/$1/members/$2" "$3"; }
dc_guild_member_modify()       { _dc_api "PATCH" "/guilds/$1/members/$2" "$3"; }
dc_guild_nick_set()            { _dc_api "PATCH" "/guilds/$1/members/@me/nick" "$2"; }
dc_guild_member_role_add()     { _dc_void "PUT" "/guilds/$1/members/$2/roles/$3"; }
dc_guild_member_role_remove()  { _dc_void "DELETE" "/guilds/$1/members/$2/roles/$3"; }
dc_guild_member_kick()         { _dc_void "DELETE" "/guilds/$1/members/$2"; }
dc_guild_ban_list()            { _dc_get "/guilds/$1/bans"; }
dc_guild_ban_create()          { _dc_api "PUT" "/guilds/$1/bans/$2" "$3"; }
dc_guild_ban_remove()          { _dc_void "DELETE" "/guilds/$1/bans/$2"; }
dc_guild_role_list()           { _dc_get "/guilds/$1/roles"; }
dc_guild_role_create()         { _dc_api "POST" "/guilds/$1/roles" "$2"; }
dc_guild_role_modify()         { _dc_api "PATCH" "/guilds/$1/roles/$2" "$3"; }
dc_guild_role_delete()         { _dc_void "DELETE" "/guilds/$1/roles/$2"; }
dc_guild_invite_list()         { _dc_get "/guilds/$1/invites"; }
dc_guild_leave()               { _dc_void "DELETE" "/users/@me/guilds/$1"; }
