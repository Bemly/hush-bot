# Discord Webhook — execute pre-configured webhook objects
# Webhook URL: https://discord.com/api/webhooks/<id>/<token>
# No Bearer auth needed, just POST to the URL

dc_webhook_execute() {
    _url="$1" _content="$2" _username="${3:-}"
    _body="$(json_obj "content" "$_content")"
    [ -n "$_username" ] && _body="$(printf '%s' "$_body" | sed 's/}$/,"username":"'"$_username"'"/}')"
    http_post "$_url" "$_body" "Content-Type:application/json" || {
        _ERROR="dc.webhook: $_ERROR"
        return 1
    }
}
