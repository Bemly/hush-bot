# Discord Invite API

. "$_HB/adapter/discord/core.sh"

dc_invite_get()            { _dc_get "/invites/$1"; }
dc_invite_delete()         { _dc_void "DELETE" "/invites/$1"; }
