# Ayu.Core

> [中文文档](README.zh.md)

Pure shell SNS Bot framework. Runs in busybox:musl container, hush + httpd CGI + wget + [hush-json](https://github.com/Bemly/hush-json).

[![test](https://github.com/Bemly/Ayu.Core/actions/workflows/test.yml/badge.svg)](https://github.com/Bemly/Ayu.Core/actions/workflows/test.yml)

## Adapter Coverage

| Platform | Endpoints | Functions | Reference |
|----------|-----------|-----------|-----------|
| QQ (LagrangeV2.Milky) | 29/29 | 27 | [adapter/qq/README.md](adapter/qq/README.md) |
| Telegram Bot API | 169/169 | 169 | [adapter/telegram/README.md](adapter/telegram/README.md) |
| Discord REST API v10 | 185 bot API | 135 | [adapter/discord/README.md](adapter/discord/README.md) |

## Architecture

```
Request flow:
  Platform → webhook → httpd CGI → router.sh → adapter → dispatch.sh → handler → adapter → wget → Platform

Ayu.Core/
├── cgi-bin/                # CGI scripts (busybox httpd hardcodes /cgi-bin/)
│   ├── start.sh            # Launch httpd
│   └── router.sh           # CGI entry (platform routing + token auth)
├── lib/
│   ├── core.sh             # _ERROR chain, die(), hush-json + hush-url bootstrap
│   ├── http.sh             # wget wrapper (GET/POST, retry, proxy auto-detect)
│   ├── dispatch.sh         # Message routing + plugin interface (etc/rules)
│   ├── log.sh              # Leveled logging (debug/info/warn/err)
│   └── url.sh              # url_encode/decode + utf8_decode (\uXXXX→UTF-8)
├── adapter/                # Platform adapters
│   ├── qq/                 # QQ — 6 files, 15 segment types, 8 event types
│   ├── telegram/           # Telegram — 17 files, 20 Update types, 18 content types
│   └── discord/            # Discord — 17 files (REST only)
├── plugin/                 # Business logic
│   └── sync.sh             # Cross-platform sync (🐧✈️👾 emoji icons)
├── etc/                    # config.sh, rules, sync.conf, config.nas.sh (gitignored)
└── test/                   # 129 tests, 0 failures (mock_wget, no API keys)
```

## Quick Start

```sh
# Build
docker build -t ayu-core .

# Run
docker run -d -p 6160:6160 --name ayu ayu-core

# QQ webhook
curl -X POST http://localhost:6160/cgi-bin/router.sh/qq \
  -H 'Content-Type: application/json' \
  -d '{"event_type":"message_receive","data":{"sender_id":111,"message_scene":"friend","segments":[{"type":"text","data":{"text":"/ping"}}]}}'
# → {"status":"ok"}

# Telegram webhook
curl -X POST http://localhost:6160/cgi-bin/router.sh/telegram \
  -H 'Content-Type: application/json' \
  -d '{"update_id":1,"message":{"from":{"id":111},"chat":{"id":222},"text":"/ping"}}'
# → {"status":"ok"}
```

## Configuration

```sh
# etc/config.sh — all values can be overridden via environment variables
QQ_HOST="host.docker.internal"   # bridge: host.docker.internal, host: 127.0.0.1
QQ_PORT="616"
QQ_TOKEN=""                      # set via env or config.nas.sh

TG_TOKEN=""                      # Bot token from @BotFather
TG_API_HOST="api.telegram.org"   # use tghook.bemly.moe (CF Worker) to bypass GFW
TG_API_SECRET=""                 # X-Ayu-Token header for CF WAF

DC_TOKEN=""

BOT_PORT="6160"
WEBHOOK_SECRET=""                # if set, require ?token=<secret> in webhook URL
_LOG_LEVEL="1"                   # 0=trace, 1=info, 2=warn, 3=err
```

> Never commit secrets. Use `etc/config.nas.sh` (gitignored) for production values.  
> See `etc/config.nas.sh` for full production example.

## Platform APIs

```sh
. ./lib/core.sh && . ./etc/config.sh

# --- QQ ---
. ./adapter/qq/message.sh
qq_message_send_group "123456" "$(qq_text_segments 'hello')"

# --- Telegram ---
. ./adapter/telegram/message.sh
tg_sendMessage "222" "hello world" "HTML"

# --- Discord ---
. ./adapter/discord/message.sh
dc_message_create "ch1" '{"content":"hello"}'
```

## Message Dispatch

`etc/rules` — one rule per line: `<pattern>|<handler_file>|<handler_func>`

```
/ping|qq/handler.sh|handler_ping
/echo|qq/handler.sh|handler_echo
*|../plugin/sync.sh|sync_handler
```

Rules are matched first-to-last. Commands match first; the `*` fallback forwards to cross-platform sync.

## Cross-Platform Sync

Messages from one platform auto-forward to the others. Non-text content (images, stickers, voice, etc.) is converted to descriptive labels.

| From→To | Prefix | Loop Prevention |
|---------|--------|-----------------|
| QQ→TG | `🐧 用户: 消息` | emoji prefix + bot sender ID |
| TG→QQ | `✈️ 用户: 消息` | emoji prefix + bot sender ID |
| →DC | `👾 用户: 消息` | (not implemented) |

**Content types handled**: text, image, sticker, GIF, voice, video, file, reply, forward, location, contact, dice, poll, service messages (join/leave/pin), and more. See adapter READMEs for complete type tables.

**1. Configure mappings** in `etc/sync.conf`:

```
qq/group/123456=telegram/-100111            # QQ group → TG group
qq/group/123456=telegram/-100111/16553      # QQ group → TG forum topic
telegram/-100111=qq/group/123456            # TG group → QQ group
```

**2. Enable** with the `*` rule in `etc/rules` (included by default).

**Limitation**: Discord→QQ/TG requires Gateway (WebSocket), not feasible in pure shell. QQ↔Telegram is fully bidirectional.

## Webhook Auth

Set `WEBHOOK_SECRET` to require `?token=<secret>` in all webhook URLs. Router returns 403 without it.

The token supports special characters (`#`, `<`, `;`) via URL encoding — `url_encode`/`url_decode` handle encoding automatically.

## Telegram + GFW Bypass

If `api.telegram.org` is blocked, use a Cloudflare Worker as forward proxy:

1. Create CF Worker that proxies to `api.telegram.org`
2. Set `TG_API_HOST=your-worker.example.com`
3. Ayu calls Worker via HTTPS (busybox wget supports TLS 1.0, configure Cloudflare accordingly)

## Error Handling

hush has no `trap ERR`. Errors **prepend** at each layer (never overwrite):

```
qq.send_group: qq.send_group_message: http_post failed: http://x:8080/api/... (connection refused)
```

```sh
json_get "$resp" key || die "missing key"
# → Ayu.Core ERROR (line 23): missing key
```

> **Important**: hush has no local variables. Utility functions must use `$1` `$2` `$3` directly — assigning to named parameters (e.g., `_msg="$3"`) corrupts the caller's variables.

## Tests

```sh
# All tests (mock_wget, no API keys required)
docker run --rm -v $(pwd):/test busybox:musl hush /test/test/run.sh

# Single category
docker run --rm -v $(pwd):/test busybox:musl hush -c "
  cd /test && . ./lib/core.sh && . ./test/helper.sh && . ./test/test_qq_message.sh
"
```

**129 tests, 0 failures** — QQ(14) + Telegram(6) + Discord(26) + HTTP(4) + Dispatch(2) + Sync(12) + URL(26) + Log(4) + Auth(5) + Webhook(16)

## Constraints

- **busybox:musl** — no bash, gawk, curl, jq
- **wget** — GET/POST only, TLS 1.0 (needs CF minimum TLS set to 1.0)
- **httpd CGI** — path hardcoded to `/cgi-bin/`, `H:` does NOT enable CGI
- **hush** — no arrays, no `trap ERR`, no local variables
- **awk** — var names ≤3 chars, `"\n"` is literal
- **JSON escapes** — only `\"` and `\\` resolved natively; `\uXXXX` decoded via `utf8_decode`
- **$() trap** — functions that set `_ERROR` must not run inside subshells
