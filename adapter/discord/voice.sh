# Discord Voice API

. "$_HB/adapter/discord/core.sh"

dc_voice_regions()         { _dc_get "/voice/regions"; }
dc_voice_state_get()       { _dc_get "/guilds/$1/voice-states/$2"; }
dc_voice_state_get_self()  { _dc_get "/guilds/$1/voice-states/@me"; }
dc_voice_state_modify_self(){ _dc_api "PATCH" "/guilds/$1/voice-states/@me" "$2"; }
