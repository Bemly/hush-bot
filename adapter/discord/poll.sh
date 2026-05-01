# Discord Poll API

. "$_HB/adapter/discord/core.sh"

dc_poll_answer()   { _dc_api "POST" "/channels/$1/polls/$2/answers/$3" "$4"; }
dc_poll_expire()   { _dc_api "POST" "/channels/$1/polls/$2/expire" "{}"; }
