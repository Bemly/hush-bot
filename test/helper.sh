# test/helper.sh — test assertion helpers for Ayu.Core

_PASS=0
_FAIL=0

assert_eq() {
    _got="$1" _want="$2" _msg="$3"
    if [ "$_got" = "$_want" ]; then
        _PASS=$((_PASS + 1))
    else
        _FAIL=$((_FAIL + 1))
        printf 'FAIL: %s\n' "$_msg"
        printf '  want: %s\n' "$_want"
        printf '  got:  %s\n' "$_got"
    fi
}

assert_ok() {
    _rc=$? _msg="$1"
    if [ $_rc -eq 0 ]; then
        _PASS=$((_PASS + 1))
    else
        _FAIL=$((_FAIL + 1))
        printf 'FAIL: %s (expected success)\n' "$_msg"
    fi
}

assert_fail() {
    _rc=$? _msg="$1"
    if [ $_rc -ne 0 ]; then
        _PASS=$((_PASS + 1))
    else
        _FAIL=$((_FAIL + 1))
        printf 'FAIL: %s (expected failure)\n' "$_msg"
    fi
}

assert_contains() {
    _str="$1" _sub="$2" _msg="$3"
    case "$_str" in
        *"$_sub"*) _PASS=$((_PASS + 1)) ;;
        *)
            _FAIL=$((_FAIL + 1))
            printf 'FAIL: %s\n' "$_msg"
            printf '  string does not contain: %s\n' "$_sub"
            printf '  got: %s\n' "$_str"
            ;;
    esac
}

test_summary() {
    printf '%s passed, %s failed, %s total\n' "$_PASS" "$_FAIL" $((_PASS + _FAIL))
    [ "$_FAIL" -eq 0 ] || exit 1
}
