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
├── hush-json/              # submodule — pure hush JSON interpreter
├── cgi-bin/                # CGI scripts (busybox httpd hardcodes /cgi-bin/)
│   ├── start.sh            # Launch httpd
│   └── router.sh           # CGI entry point (platform routing)
├── lib/
│   ├── core.sh             # _ERROR chain, die(), hush-json bootstrap
│   ├── http.sh             # wget wrapper (GET/POST, retry, timeout)
│   ├── dispatch.sh         # Message routing + plugin interface
│   └── log.sh              # Leveled logging (debug/info/warn/err)
├── adapter/                # Platform adapters
│   ├── qq/                 # QQ — 6 files (system/message/group/friend/file/webhook)
│   ├── telegram/           # Telegram — 17 files (bot/message/chat/admin/...)
│   └── discord/            # Discord — 17 files (message/channel/guild/user/...)
├── etc/                    # config.sh, rules, httpd.conf
├── plugin/                 # Business logic (your handlers go here)
└── test/                   # 58 tests, 0 failures (mock_wget, no API keys)
```

## Quick Start

```sh
# Build
docker build -t ayu-core .

# Run
docker run -d -p 8080:8080 --name ayu ayu-core

# QQ webhook
curl -X POST http://localhost:8080/cgi-bin/router.sh/qq \
  -H 'Content-Type: application/json' \
  -d '{"event_type":"message_receive","data":{"sender_id":111,"message_scene":"friend","segments":[{"type":"text","data":{"text":"/ping"}}]}}'
# → {"status":"ok"}

# Telegram webhook
curl -X POST http://localhost:8080/cgi-bin/router.sh/telegram \
  -H 'Content-Type: application/json' \
  -d '{"update_id":1,"message":{"from":{"id":111},"chat":{"id":222},"text":"/ping"}}'
# → {"status":"ok"}

# Discord webhook (no Bot token needed)
dc_webhook_execute "<id>" "<token>" "hello from Ayu.Core"
```

## Configuration

```sh
# etc/config.sh
QQ_HOST="localhost"          # Lagrange.Milky address
QQ_PORT="8080"
QQ_TOKEN="your-qq-token"

TG_TOKEN="123:abc"          # Telegram Bot token

DC_TOKEN="your-bot-token"   # Discord Bot token

BOT_PORT="8080"             # httpd listen port
_LOG_LEVEL="1"              # 0=trace, 1=info, 2=warn, 3=err
```

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
. ./adapter/discord/webhook.sh
dc_message_create "ch1" '{"content":"hello"}'
dc_webhook_execute "id" "token" "message"
```

## Message Dispatch

`etc/rules` — one rule per line: `<pattern>|<handler_file>|<handler_func>`

```
/ping|qq/handler.sh|handler_ping
/echo|qq/handler.sh|handler_echo
```

Handler example (`plugin/qq/handler.sh`):
```sh
handler_ping() {
    . "$_HB/adapter/qq/message.sh"
    _segs="$(qq_text_segments "pong!")"
    qq_message_send_private "$3" "$_segs"
}
```

## Error Handling

hush has no `trap ERR`. Errors **prepend** at each layer (never overwrite):

```
qq.send_group: qq.send_group_message: http_post failed: http://x:8080/api/... (connection refused)
```

```sh
json_get "$resp" key || die "missing key"
# → Ayu.Core ERROR (line 23): missing key
```

## Tests

```sh
# All tests (mock_wget, no API keys required)
docker run --rm -v $(pwd):/test busybox:musl hush /test/test/run.sh

# Single category
docker run --rm -v $(pwd):/test busybox:musl hush -c "
  cd /test && . ./lib/core.sh && . ./test/helper.sh && . ./test/test_qq_message.sh
"
```

**58 tests, 0 failures** — QQ(14) + Telegram(6) + Discord(26) + HTTP(4) + Dispatch(2)

## Performance

| Metric | Value |
|--------|-------|
| httpd idle memory | ~600 KB |
| Per CGI request | ~1-2 MB |
| Bot instance resident | ~5-10 MB |
| CGI overhead | <10ms |
| Webhook receive only | ~100-200 req/s |
| Webhook + API reply | ~1-5 req/s |

Bottleneck: httpd is single-threaded. One slow API call blocks subsequent requests. Fine for personal/small-group bots.

## Constraints

- **busybox:musl** — no bash, gawk, curl, jq
- **wget** — GET/POST only
- **httpd CGI** — path hardcoded to `/cgi-bin/`, `H:` does NOT enable CGI
- **hush** — no arrays, no `trap ERR`, no `FUNCNAME`
- **awk** — var names ≤3 chars, `"\n"` is literal
- **JSON escapes** — only `\"` and `\\` resolved; `\n` `\t` preserved as-is
- **$() trap** — functions that set `_ERROR` must not run inside subshells
