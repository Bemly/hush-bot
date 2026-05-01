# hush-bot config — tokens, endpoints, settings
# Source after core.sh

# ---- QQ (Lagrange.Milky) ----
QQ_HOST="${QQ_HOST:-localhost}"
QQ_PORT="${QQ_PORT:-8080}"
QQ_PREFIX="${QQ_PREFIX:-/}"
QQ_TOKEN="${QQ_TOKEN:-}"

# QQ API base URL
QQ_API_BASE="http://${QQ_HOST}:${QQ_PORT}${QQ_PREFIX}api"

# ---- Bot server ----
BOT_PORT="${BOT_PORT:-8080}"
BOT_HOST="${BOT_HOST:-0.0.0.0}"

# ---- Logging ----
_LOG_LEVEL="${_LOG_LEVEL:-1}"    # 0=trace, 1=info, 2=warn, 3=err
_LOG_DIR="${_LOG_DIR:-$(pwd)/var/log}"

# ---- State ----
_STATE_DIR="${_STATE_DIR:-$(pwd)/var/state}"
