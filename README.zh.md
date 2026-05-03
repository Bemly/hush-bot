# Ayu.Core

> [English](README.md)

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
├── cgi-bin/                # CGI 脚本 (busybox httpd 写死 /cgi-bin/)
│   ├── start.sh            # 启动 httpd
│   └── router.sh           # CGI 入口 (平台路由 + token 鉴权)
├── lib/
│   ├── core.sh             # _ERROR 链, die(), hush-json + hush-url 引导
│   ├── http.sh             # wget 封装 (GET/POST, 重试, 代理自动检测)
│   ├── dispatch.sh         # 消息路由 + 插件接口 (etc/rules)
│   ├── log.sh              # 分级日志 (debug/info/warn/err)
│   └── url.sh              # url_encode/decode + utf8_decode (\uXXXX→UTF-8)
├── adapter/                # 平台适配器
│   ├── qq/                 # QQ — 6 文件, 15 种 segment, 8 种事件
│   ├── telegram/           # Telegram — 17 文件, 20 种 Update, 18 种内容类型
│   └── discord/            # Discord — 17 文件 (仅 REST 出站)
├── plugin/                 # 业务插件
│   └── sync.sh             # 跨平台消息同步 (🐧✈️👾 emoji 图标)
├── etc/                    # config.sh, rules, sync.conf, config.nas.sh (gitignore)
└── test/                   # 129 tests, 0 failures (mock_wget, 无需 API key)
```

## 快速开始

```sh
# 构建
docker build -t ayu-core .

# 启动
docker run -d -p 6160:6160 --name ayu ayu-core

# QQ webhook
curl -X POST http://localhost:6160/cgi-bin/router.sh/qq \
  -H 'Content-Type: application/json' \
  -d '{"event_type":"message_receive","data":{"sender_id":111,"message_scene":"friend","segments":[{"type":"text","data":{"text":"/ping"}}]}}'
# → {"status":"ok"}

# Telegram webhook
curl -X POST http://localhost:6160/cgi-bin/router.sh/telegram \
  -H 'Content-Type: application/json' \
  -d '{"update_id":1,"message":{"message_id":1,"from":{"id":111},"chat":{"id":222},"text":"/ping"}}'
# → {"status":"ok"}
```

## 配置

```sh
# etc/config.sh — 所有值都可通过环境变量覆盖
QQ_HOST="host.docker.internal"   # bridge 用 host.docker.internal, host 用 127.0.0.1
QQ_PORT="616"
QQ_TOKEN=""                      # 通过环境变量或 config.nas.sh 设置

TG_TOKEN=""                      # @BotFather 获取的 Bot token
TG_API_HOST="api.telegram.org"   # 国内被墙时用 tghook.bemly.moe (CF Worker)
TG_API_SECRET=""                 # CF WAF 用的 X-Ayu-Token 头部

DC_TOKEN=""

BOT_PORT="6160"
WEBHOOK_SECRET=""                # 设了就要 ?token=xxx，否则 403
_LOG_LEVEL="1"                   # 0=trace, 1=info, 2=warn, 3=err
```

> 绝不要提交密钥。生产环境用 `etc/config.nas.sh`（已 gitignore）。  
> 完整示例见 `etc/config.nas.sh`。

## 平台 API

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

## 消息分发

`etc/rules` — 每行一个规则：`<pattern>|<handler_file>|<handler_func>`

```
/ping|qq/handler.sh|handler_ping
/echo|qq/handler.sh|handler_echo
*|../plugin/sync.sh|sync_handler
```

规则从上到下匹配。命令 handler 先命中，末尾的 `*` 交给同步插件转发。

## 跨平台消息同步

一个平台的消息自动转发到其他平台。非文本内容（图片、贴纸、语音等）自动转为描述性标签。

| 方向 | 格式 | 防循环 |
|------|------|--------|
| QQ→TG | `🐧 用户: 消息` | emoji 前缀 + bot 发送者 ID |
| TG→QQ | `✈️ 用户: 消息` | emoji 前缀 + bot 发送者 ID |
| →DC | `👾 用户: 消息` | (未实现) |

**支持的内容类型**: 文字、图片、贴纸、GIF、语音、视频、文件、回复、转发、位置、联系人、骰子、投票、服务消息（入群/离群/置顶）等。详见适配器 README。

**1. 配置映射** `etc/sync.conf`：

```
qq/group/123456=telegram/-100111            # QQ 群 → TG 群
qq/group/123456=telegram/-100111/16553      # QQ 群 → TG 论坛话题
telegram/-100111=qq/group/123456            # TG 群 → QQ 群
```

**2. 启用**: `etc/rules` 中默认已包含 `*` 规则。

**限制**: Discord→QQ/TG 需要 Gateway (WebSocket)，纯 shell 无法实现。QQ↔Telegram 完全双向同步。

## Webhook 鉴权

设置 `WEBHOOK_SECRET` 后，所有 webhook URL 必须带 `?token=xxx`，否则返回 403。

特殊字符（`#` `<` `;` 等）通过 URL 编码处理——`url_encode`/`url_decode` 自动编解码。

## Telegram 被墙绕过

如果 `api.telegram.org` 被墙，用 Cloudflare Worker 做转发：

1. 创建 CF Worker，proxy 到 `api.telegram.org`
2. 设 `TG_API_HOST=你的worker域名`
3. Ayu 通过 HTTPS 调 Worker（busybox wget 支持 TLS 1.0，CF 端配好最小 TLS 版本）

## 错误处理

hush 无 `trap ERR`，错误在各层逐级 **prepend**（不覆盖）：

```
qq.send_group: qq.send_group_message: http_post failed: http://x:8080/api/... (connection refused)
```

```sh
json_get "$resp" key || die "missing key"
# → Ayu.Core ERROR (line 23): missing key
```

> **重要**: hush 没有局部变量。工具函数参数必须直接用 `$1` `$2` `$3`——赋给命名变量（如 `_msg="$3"`）会污染调用方的同名变量。

## 运行测试

```sh
# 全部测试 (mock_wget, 无需 API key)
docker run --rm -v $(pwd):/test busybox:musl hush /test/test/run.sh

# 单个分类
docker run --rm -v $(pwd):/test busybox:musl hush -c "
  cd /test && . ./lib/core.sh && . ./test/helper.sh && . ./test/test_qq_message.sh
"
```

**129 tests, 0 failures** — QQ(14) + Telegram(6) + Discord(26) + HTTP(4) + Dispatch(2) + Sync(12) + URL(26) + Log(4) + Auth(5) + Webhook(16)

## 关键约束

- **busybox:musl** — 无 bash, gawk, curl, jq
- **wget** — 仅 GET/POST, TLS 1.0（CF 需设最小 TLS 为 1.0）
- **httpd CGI** — 路径写死 `/cgi-bin/`，`H:` 指令不启用 CGI
- **hush** — 无数组、无 `trap ERR`、无局部变量
- **awk** — 变量名 ≤3 字符，`"\n"` 是字面量
- **JSON 转义** — 只解析 `\"` `\\`，`\uXXXX` 通过 `utf8_decode` 额外处理
- **$() 禁忌** — 设置 `_ERROR` 的函数不能放 subshell
