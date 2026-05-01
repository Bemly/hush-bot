# Discord Soundboard API

. "$_HB/adapter/discord/core.sh"

dc_soundboard_send()       { _dc_api "POST" "/channels/$1/send-soundboard-sound" "$2"; }
dc_soundboard_defaults()   { _dc_get "/soundboard-default-sounds"; }
dc_soundboard_list()       { _dc_get "/guilds/$1/soundboard-sounds"; }
dc_soundboard_get()        { _dc_get "/guilds/$1/soundboard-sounds/$2"; }
dc_soundboard_create()     { _dc_api "POST" "/guilds/$1/soundboard-sounds" "$2"; }
dc_soundboard_modify()     { _dc_api "PATCH" "/guilds/$1/soundboard-sounds/$2" "$3"; }
dc_soundboard_delete()     { _dc_void "DELETE" "/guilds/$1/soundboard-sounds/$2"; }
