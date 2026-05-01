# Discord User API

. "$_HB/adapter/discord/core.sh"

dc_user_get()           { _dc_get "/users/$1"; }
dc_current_user()       { _dc_get "/users/@me"; }
