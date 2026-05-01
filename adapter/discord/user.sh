# Discord User API

. "$_HB/adapter/discord/core.sh"

dc_user_current()  { _dc_get "/users/@me"; }
dc_user_modify()   { _dc_api "PATCH" "/users/@me" "$1"; }
dc_user_get()      { _dc_get "/users/$1"; }
dc_dm_create()     { _dc_api "POST" "/users/@me/channels" "$1"; }
