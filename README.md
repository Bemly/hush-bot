# Ayu.Core

纯 shell SNS Bot 框架。运行在 busybox:musl 容器中，hush + httpd CGI + wget + [hush-json](https://github.com/Bemly/hush-json)。

[![test](https://github.com/Bemly/Ayu.Core/actions/workflows/test.yml/badge.svg)](https://github.com/Bemly/Ayu.Core/actions/workflows/test.yml)

## 适配器覆盖

| 平台 | 端点 | 方法 | README |
|------|------|------|--------|
| QQ (LagrangeV2.Milky) | 29/29 | 27 | [adapter/qq/README.md](adapter/qq/README.md) |
| Telegram Bot API | 169/169 | 169 | [adapter/telegram/README.md](adapter/telegram/README.md) |
| Discord REST API v10 | 185 bot API | 135 | [adapter/discord/README.md](adapter/discord/README.md) |

## 架构

```
请求流:
  SNS平台 → webhook → httpd CGI → router.sh → adapter → dispatch.sh → handler → adapter → wget → SNS平台

Ayu.Core/
├── hush-json/              # submodule — 纯 hush JSON 解释器
├── cgi-bin/                # CGI 脚本 (busybox httpd 写死 /cgi-bin/)
│   ├── start.sh            # 启动 httpd
│   └── router.sh           # CGI 入口 (平台路由)
├── lib/
│   ├── core.sh             # _ERROR 链, die(), hush-json 引导
│   ├── http.sh             # wget 封装 (GET/POST, 重试, 超时)
│   ├── dispatch.sh         # 消息路由 + 插件接口
│   └── log.sh              # 分级日志 (debug/info/warn/err)
├── adapter/                # 平台适配器
│   ├── qq/                 # QQ — 6 文件 (system/message/group/friend/file/webhook)
│   ├── telegram/           # Telegram — 17 文件 (bot/message/chat/admin/inline/...)
│   └── discord/            # Discord — 17 文件 (message/channel/guild/user/webhook/...)
├── etc/                    # config.sh, rules, httpd.conf
├── plugin/                 # 业务插件 (你的 handler 放这里)
└── test/                   # 58 tests, 0 failures (mock_wget, 无需 API key)
```

## 快速开始

```sh
# 构建
docker build -t ayu-core .

# 启动
docker run -d -p 8080:8080 --name ayu ayu-core

# QQ webhook
curl -X POST http://localhost:8080/cgi-bin/router.sh/qq \
  -H 'Content-Type: application/json' \
  -d '{"event_type":"message_receive","data":{"sender_id":111,"message_scene":"friend","segments":[{"type":"text","data":{"text":"/ping"}}]}}'
# → {"status":"ok"}

# Telegram webhook
curl -X POST http://localhost:8080/cgi-bin/router.sh/telegram \
  -H 'Content-Type: application/json' \
  -d '{"update_id":1,"message":{"message_id":1,"from":{"id":111},"chat":{"id":222},"text":"/ping"}}'
# → {"status":"ok"}

# Discord webhook (直接用 webhook URL, 无需 Bot token)
dc_webhook_execute "<webhook_id>" "<webhook_token>" "hello from Ayu.Core"
```

## 配置

```sh
# etc/config.sh
QQ_HOST="localhost"          # Lagrange.Milky 地址
QQ_PORT="8080"
QQ_TOKEN="your-qq-token"

TG_TOKEN="123:abc"          # Telegram Bot token

DC_TOKEN="your-bot-token"   # Discord Bot token

BOT_PORT="8080"             # httpd 监听端口
_LOG_LEVEL="1"              # 0=trace, 1=info, 2=warn, 3=err
```

## 平台 API 示例

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

## 消息分发

`etc/rules` — 每行一个规则：`<pattern>|<handler_file>|<handler_func>`

```
/ping|qq/handler.sh|handler_ping
/echo|qq/handler.sh|handler_echo
```

Handler 示例 (`plugin/qq/handler.sh`):
```sh
handler_ping() {
    . "$_HB/adapter/qq/message.sh"
    _segs="$(qq_text_segments "pong!")"
    qq_message_send_private "$3" "$_segs"
}
```

## 错误处理

hush 无 `trap ERR`，错误在各层逐级 **prepend**（不覆盖）：

```
qq.send_group: qq.send_group_message: http_post failed: http://x:8080/api/... (connection refused)
```

```sh
json_get "$resp" key || die "missing key"
# → Ayu.Core ERROR (line 23): missing key
```

## 运行测试

```sh
# 全部测试 (mock_wget, 无需 API key)
docker run --rm -v $(pwd):/test busybox:musl hush /test/test/run.sh

# 单个分类
docker run --rm -v $(pwd):/test busybox:musl hush -c "
  cd /test && . ./lib/core.sh && . ./test/helper.sh && . ./test/test_qq_message.sh
"
```

**58 tests, 0 failures** — QQ(14) + Telegram(6) + Discord(26) + HTTP(4) + Dispatch(2) + 其他(6)

## 性能基准

| 指标 | 值 |
|------|-----|
| httpd 空载内存 | ~600 KB |
| 单 CGI 请求内存 | ~1-2 MB |
| bot 实例常驻 | ~5-10 MB |
| CGI 本体耗时 | <10ms |
| webhook 纯收 | ~100-200 req/s |
| webhook + API 回复 | ~1-5 req/s |

瓶颈: httpd 单线程串行，一个 API 调用卡住会堵后续。适合个人/小群 bot。

## 关键约束

- **busybox:musl** — 无 bash, gawk, curl, jq
- **wget** — 仅 GET/POST
- **httpd CGI** — 路径写死 `/cgi-bin/`，`H:` 指令不启用 CGI
- **hush** — 无数组、无 `trap ERR`、无 `FUNCNAME`
- **awk** — 变量名 ≤3 字符，`"\n"` 是字面量
- **JSON 转义** — 只解析 `\"` `\\`，`\n` `\t` 保留字面量
- **$() 禁忌** — 设置 `_ERROR` 的函数不能放 subshell
