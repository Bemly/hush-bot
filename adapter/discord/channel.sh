# Discord Channel API

. "$_HB/adapter/discord/core.sh"

dc_channel_get()               { _dc_get "/channels/$1"; }
dc_channel_modify()            { _dc_api "PATCH" "/channels/$1" "$2"; }
dc_channel_delete()            { _dc_void "DELETE" "/channels/$1"; }
dc_channel_invite_list()       { _dc_get "/channels/$1/invites"; }
dc_channel_invite_create()     { _dc_api "POST" "/channels/$1/invites" "$2"; }
dc_channel_permission_set()    { _dc_api "PUT" "/channels/$1/permissions/$2" "$3"; }
dc_channel_permission_delete() { _dc_void "DELETE" "/channels/$1/permissions/$2"; }
dc_channel_follow()            { _dc_api "POST" "/channels/$1/followers" "$2"; }
dc_typing_trigger()            { _dc_api "POST" "/channels/$1/typing" "{}"; }
dc_dm_create()                 { _dc_api "POST" "/users/@me/channels" "$1"; }
dc_thread_create_from_msg()    { _dc_api "POST" "/channels/$1/messages/$2/threads" "$3"; }
dc_thread_create()             { _dc_api "POST" "/channels/$1/threads" "$2"; }
dc_thread_join()               { _dc_void "PUT" "/channels/$1/thread-members/@me"; }
dc_thread_leave()              { _dc_void "DELETE" "/channels/$1/thread-members/@me"; }
dc_thread_member_add()         { _dc_void "PUT" "/channels/$1/thread-members/$2"; }
dc_thread_member_remove()      { _dc_void "DELETE" "/channels/$1/thread-members/$2"; }
dc_thread_member_list()        { _dc_get "/channels/$1/thread-members"; }
dc_thread_archived_public()    { _dc_get "/channels/$1/threads/archived/public"; }
dc_thread_archived_private()   { _dc_get "/channels/$1/threads/archived/private"; }
dc_thread_archived_joined()    { _dc_get "/channels/$1/users/@me/threads/archived/private"; }
