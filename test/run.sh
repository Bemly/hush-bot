#!/bin/sh
# test/run.sh — Ayu.Core test runner
# Usage: docker run --rm -v $(pwd):/test busybox:musl sh /test/test/run.sh

cd "$(dirname "$0")/.." || exit 1
. ./lib/core.sh
. ./lib/log.sh
. ./lib/http.sh
. ./lib/dispatch.sh
. ./etc/config.sh
. ./plugin/qq/system.sh
. ./plugin/qq/message.sh
. ./plugin/qq/webhook.sh
. ./test/helper.sh
. ./test/mock/mock_wget.sh

# run all test files
for _f in test/test_*.sh; do
    printf '\n--- %s ---\n' "$_f"
    . "./$_f"
done

printf '\n'
test_summary
