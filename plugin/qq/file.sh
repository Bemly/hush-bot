# QQ File API

. "$_HB/plugin/qq/system.sh"  # for _qq_call

qq_file_upload_group() {
    _gid="$1" _uri="$2" _name="$3" _folder="${4:-}"
    _body="$(json_obj "group_id" "$_gid" "file_uri" "$_uri" "file_name" "$_name")"
    [ -n "$_folder" ] && _body="$(printf '%s' "$_body" | sed 's/}$/,"parent_folder_id":"'"$_folder"'"/}')"
    _resp="$(_qq_call "upload_group_file" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_file: upload group parse fail"; return 1; }
}

qq_file_upload_private() {
    _uid="$1" _uri="$2" _name="$3"
    _body="$(json_obj "user_id" "$_uid" "file_uri" "$_uri" "file_name" "$_name")"
    _resp="$(_qq_call "upload_private_file" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_file: upload private parse fail"; return 1; }
}

qq_file_get_download_url() {
    _gid="$1" _fid="$2"
    _body="$(json_obj "group_id" "$_gid" "file_id" "$_fid")"
    _resp="$(_qq_call "get_group_file_download_url" "$_body")" || return 1
    json_get "$_resp" data || { _ERROR="qq_file: download url parse fail"; return 1; }
}

qq_file_delete_group() {
    _gid="$1" _fid="$2"
    _body="$(json_obj "group_id" "$_gid" "file_id" "$_fid")"
    _resp="$(_qq_call "delete_group_file" "$_body")" || return 1
}
