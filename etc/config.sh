# Ayu.Core config — tokens, endpoints, settings
# Source after core.sh

# ---- QQ (Lagrange.Milky) ----
QQ_HOST="${QQ_HOST:-127.0.0.1}"
QQ_PORT="${QQ_PORT:-616}"
QQ_PREFIX="${QQ_PREFIX:-/}"
QQ_TOKEN="${QQ_TOKEN:-REDACTED}"

# QQ API base URL
QQ_API_BASE="http://${QQ_HOST}:${QQ_PORT}${QQ_PREFIX}api"

# ---- Telegram ----
TG_TOKEN="${TG_TOKEN:-}"
TG_API_BASE="https://api.telegram.org/bot${TG_TOKEN}"

# ---- Discord ----
DC_TOKEN="${DC_TOKEN:-}"
DC_API_BASE="https://discord.com/api/v10"

# ---- Bot server ----
BOT_PORT="${BOT_PORT:-6160}"
BOT_HOST="${BOT_HOST:-0.0.0.0}"

# Webhook auth: if set, require ?token=<secret> in webhook URL
WEBHOOK_SECRET="${WEBHOOK_SECRET:-}"

# ---- Logging ----
_LOG_LEVEL="${_LOG_LEVEL:-1}"    # 0=trace, 1=info, 2=warn, 3=err
_LOG_DIR="${_LOG_DIR:-$_HB/var/log}"

# ---- State ----
_STATE_DIR="${_STATE_DIR:-$_HB/var/state}"
