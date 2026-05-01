# Discord Stage Instance API

. "$_HB/adapter/discord/core.sh"

dc_stage_create()  { _dc_api "POST" "/stage-instances" "$1"; }
dc_stage_get()     { _dc_get "/stage-instances/$1"; }
dc_stage_modify()  { _dc_api "PATCH" "/stage-instances/$1" "$2"; }
dc_stage_delete()  { _dc_void "DELETE" "/stage-instances/$1"; }
