# Discord Audit Log API

. "$_HB/adapter/discord/core.sh"

dc_audit_log() { _dc_get "/guilds/$1/audit-logs"; }
