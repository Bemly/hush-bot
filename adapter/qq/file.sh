# QQ File API

. "$_HB/adapter/qq/system.sh"  # for _qq_call, _qq_api

qq_file_upload_group() {
    _body="$(json_obj "group_id" "$1" "file_uri" "$2" "file_name" "$3")"
    [ -n "${4:-}" ] && _body="$(printf '%s' "$_body" | sed 's/}$/,"parent_folder_id":"'"$4"'"/}')"
    _qq_api "upload_group_file" "$_body" "qq.upload_group"
}
qq_file_upload_private()   { _qq_api "upload_private_file" "$(json_obj "user_id" "$1" "file_uri" "$2" "file_name" "$3")" "qq.upload_private"; }
qq_file_get_download_url() { _qq_api "get_group_file_download_url" "$(json_obj "group_id" "$1" "file_id" "$2")" "qq.download_url"; }
qq_file_delete_group()     { _qq_call "delete_group_file" "$(json_obj "group_id" "$1" "file_id" "$2")" >/dev/null; }
