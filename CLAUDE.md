# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Target Runtime

All code runs inside **busybox:musl** (1.37.0) Docker container via OrbStack. No bash, no gawk, no curl, no jq, no Python. Available: hush shell, busybox awk, sed, grep, wget, httpd.

**Critical: Always test inside the busybox container, never on macOS.** macOS BSD tools differ significantly from BusyBox implementations.

```sh
docker cp script.sh busybox-musl:/tmp/ && docker exec busybox-musl sh /tmp/script.sh
docker run --rm -v $(pwd):/test busybox:musl sh /test/test/run.sh
```

## Repo Structure

```
hush-bot/                  # SNS bot framework (this repo)
├── lib/
│   └── hush-json/         # → git submodule: pure hush JSON interpreter
```

## Submodule

`lib/hush-json` is a git submodule pointing to `../hush-json` (local). After changes to hush-json, update the pin in hush-bot:

```sh
cd lib/hush-json && git pull && cd ../.. && git add lib/hush-json && git commit -m "update hush-json"
```

## BusyBox awk limitations

- Function signatures must be short: total line from `function` to `{` under ~55 chars
- Use 1-3 char variable names
- See memory: busybox-awk-limits.md

## Proxy

macOS proxy at 127.0.0.1:7890. Pull images with:
```sh
HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 docker pull <image>
```
