# Discord Application API

. "$_HB/adapter/discord/core.sh"

dc_app_current()          { _dc_get "/applications/@me"; }
dc_app_edit()             { _dc_api "PATCH" "/applications/@me" "$1"; }
dc_app_activity_instance(){ _dc_get "/applications/$1/activity-instances/$2"; }
dc_app_role_connection_get()   { _dc_get "/applications/$1/role-connections/metadata"; }
dc_app_role_connection_update(){ _dc_api "PUT" "/applications/$1/role-connections/metadata" "$2"; }
