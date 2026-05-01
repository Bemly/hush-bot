# Discord Scheduled Event API

. "$_HB/adapter/discord/core.sh"

dc_event_list()       { _dc_get "/guilds/$1/scheduled-events"; }
dc_event_create()     { _dc_api "POST" "/guilds/$1/scheduled-events" "$2"; }
dc_event_get()        { _dc_get "/guilds/$1/scheduled-events/$2"; }
dc_event_modify()     { _dc_api "PATCH" "/guilds/$1/scheduled-events/$2" "$3"; }
dc_event_delete()     { _dc_void "DELETE" "/guilds/$1/scheduled-events/$2"; }
dc_event_users()      { _dc_get "/guilds/$1/scheduled-events/$2/users"; }
