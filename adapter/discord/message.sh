# Discord Message API

. "$_HB/adapter/discord/core.sh"

dc_message_create()     { _dc_api "/channels/$1/messages" "$(json_obj "content" "$2")" "dc.createMessage"; }
dc_message_edit()       { _dc_api "/channels/$1/messages/$2" "$(json_obj "content" "$3")" "dc.editMessage"; }
dc_message_delete()     { _dc_call "/channels/$1/messages/$2" "{}" >/dev/null; }
dc_message_get()        { _dc_get "/channels/$1/messages/$2"; }
dc_messages_list()      { _dc_get "/channels/$1/messages?limit=${2:-50}"; }
dc_message_reply() {
    _body="$(json_obj "content" "$3" "message_reference" "$(json_obj "message_id" "$2")")"
    _dc_api "/channels/$1/messages" "$_body" "dc.reply"
}
