# Ayu.Core

纯 shell SNS Bot 框架。运行在 busybox:musl 容器中，hush + httpd CGI + wget + [hush-json](https://github.com/Bemly/hush-json)。

## 架构

```
请求流:
  SNS平台 → webhook → httpd CGI → router.sh → 平台 webhook.sh → dispatch.sh → handler → 平台 API → wget → SNS平台

Ayu.Core/
├── hush-json/              # submodule — 纯 hush JSON 解释器
├── cgi-bin/                # CGI 脚本 (busybox httpd 写死 /cgi-bin/)
│   ├── start.sh            # 启动 httpd
│   └── router.sh           # CGI 入口
├── etc/
│   ├── config.sh           # token, endpoint, port
│   ├── rules               # 消息分发规则
│   └── httpd.conf          # busybox httpd 配置
├── lib/
│   ├── core.sh             # 错误处理 + hush-json 引导
│   ├── http.sh             # wget 封装 (GET/POST, 重试, 超时)
│   ├── dispatch.sh         # 消息路由 + 插件接口
│   └── log.sh              # 分级日志
├── plugin/                 # 平台插件
│   └── qq/                 # QQ (LagrangeV2.Milky)
│       ├── webhook.sh      # 事件解析
│       ├── system.sh       # get_login_info, get_impl_info
│       ├── message.sh      # send/get/recall message
│       ├── group.sh        # 群管理
│       ├── friend.sh       # 好友管理
│       ├── file.sh         # 文件操作
│       └── handler.sh      # /ping, /echo, /info
├── test/                   # 内部测试 (mock + fixtures)
└── var/
    ├── log/                # 运行日志
    └── state/              # 会话状态
```

## 快速开始

```sh
# 构建
docker build -t ayu-core .

# 启动 (QQ API 需要配置 etc/config.sh)
docker run -d -p 8080:8080 --name ayu ayu-core

# 测试 webhook
curl -X POST http://localhost:8080/cgi-bin/router.sh/qq \
  -H 'Content-Type: application/json' \
  -d '{"time":1,"self_id":1,"event_type":"message_receive","data":{"peer_id":1,"sender_id":111,"message_seq":1,"message_scene":"friend","segments":[{"type":"text","data":{"text":"/ping"}}]}}'
# → {"status":"ok"}
```

## 配置

`etc/config.sh`:

```sh
# QQ (Lagrange.Milky) API
QQ_HOST="${QQ_HOST:-localhost}"
QQ_PORT="${QQ_PORT:-8080}"
QQ_PREFIX="${QQ_PREFIX:-/}"
QQ_TOKEN="${QQ_TOKEN:-}"

# Bot HTTP 服务
BOT_PORT="${BOT_PORT:-8080}"

# 日志级别: 0=trace, 1=info, 2=warn, 3=err
_LOG_LEVEL="${_LOG_LEVEL:-1}"
```

## 消息分发

规则文件 `etc/rules`，格式：`<pattern>|<handler_script>|<handler_func>`

```
/ping|qq/handler.sh|handler_ping
/echo|qq/handler.sh|handler_echo
/info|qq/handler.sh|handler_info
```

## 错误处理

hush 无 `trap ERR`，错误在各层逐级上报：

```sh
json_get "$resp" key || die "missing key"
# → Ayu.Core ERROR (line 23): missing key
```

Parse 函数失败时设置 `_ERROR` 并返回 1。调用方用 `||` 链捕获。

## QQ 平台 API

LagrangeV2.Milky 协议，全部 POST + Bearer token。

```sh
. ./plugin/qq/system.sh
. ./plugin/qq/message.sh

# 发群消息
qq_message_send_group "123456" "$(qq_text_segments 'hello')"

# 获取登录信息
qq_system_get_login_info
```

## hush-json API

```sh
json_get '{"key":"val"}' key          # 取值
json_type '{"x":123}' x               # 类型
json_keys '{"a":1,"b":2}'             # 键列表
json_len '{"arr":[1,2,3]}' arr        # 数组长度
json_escape 'say "hi"'                # 转义
json_obj "k" "v" "count" 42           # 构建对象
json_arr "a" "b" "c"                  # 构建数组
# 别名: hjg, hjt, hjk, hjl, hje, hjo, hja
```

## 运行测试

```sh
docker run --rm -v $(pwd):/test busybox:musl sh /test/test/run.sh
```

## 关键约束

- **busybox:musl** 运行时 — 无 bash, gawk, curl, jq
- **wget** 仅 GET/POST
- **httpd CGI** 路径写死 `/cgi-bin/`，`H:` 指令不启用 CGI
- **hush** 无数组、无 `trap ERR`、无 `FUNCNAME`
- **awk** 函数行宽限制 ~55 字符，变量名 ≤3 字符
- **JSON 转义** 只解析 `\"` `\\`，其余 `\n` `\t` 等保留字面量
