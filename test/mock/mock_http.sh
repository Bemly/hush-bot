# mock/mock_http.sh — mock http for testing (nc + ssl_client replacement)
# Source this AFTER core.sh but BEFORE the module under test.
# Works with lib/http.sh which checks MOCK_HTTP=1 at _http_raw entry.

MOCK_HTTP=1
MOCK_RESPONSE=""
MOCK_FAIL=0
MOCK_STATUS=1
MOCK_HTTP_STATUS=200

# mock_set <json> — set the mock response for the next http call
mock_set() {
	MOCK_RESPONSE="$1"
	MOCK_FAIL=0
}

# mock_fail [code] — make next http call fail
mock_fail() {
	MOCK_FAIL=1
	MOCK_STATUS="${1:-1}"
	MOCK_RESPONSE=""
}
