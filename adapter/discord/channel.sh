# Discord Channel API

. "$_HB/adapter/discord/core.sh"

dc_channel_get()        { _dc_get "/channels/$1"; }
dc_channel_modify()     { _dc_api "/channels/$1" "$(json_obj "name" "$2")" "dc.modifyChannel"; }
dc_channel_delete()     { _dc_call "/channels/$1" "{}" >/dev/null; }
dc_channel_messages()   { _dc_get "/channels/$1/messages?limit=${2:-50}"; }

dc_create_dm()          { _dc_api "/users/@me/channels" "$(json_obj "recipient_id" "$1")" "dc.createDM"; }
