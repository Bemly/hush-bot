# test/test_url.sh — URL encode/decode tests (lib/url.sh)

test_url_encode_hash()       { _r="$(url_encode '#')"; assert_eq "$_r" "%23" "encode #"; }
test_url_encode_lt()         { _r="$(url_encode '<')"; assert_eq "$_r" "%3C" "encode <"; }
test_url_encode_gt()         { _r="$(url_encode '>')"; assert_eq "$_r" "%3E" "encode >"; }
test_url_encode_semicolon()  { _r="$(url_encode ';')"; assert_eq "$_r" "%3B" "encode ;"; }
test_url_encode_ampersand()  { _r="$(url_encode '&')"; assert_eq "$_r" "%26" "encode &"; }
test_url_encode_space()      { _r="$(url_encode ' ')" ; assert_eq "$_r" "%20" "encode space"; }
test_url_encode_percent()    { _r="$(url_encode '%')"; assert_eq "$_r" "%25" "encode %"; }
test_url_encode_unreserved() { _r="$(url_encode 'abc-ABC_123.~')"; assert_eq "$_r" "abc-ABC_123.~" "encode unreserved unchanged"; }
test_url_encode_password()   { _r="$(url_encode 'REDACTED')"; assert_eq "$_r" "REDACTED" "encode password"; }

test_url_decode_hash()       { _r="$(url_decode '%23')"; assert_eq "$_r" "#" "decode %23"; }
test_url_decode_lt()         { _r="$(url_decode '%3C')"; assert_eq "$_r" "<" "decode %3C"; }
test_url_decode_gt()         { _r="$(url_decode '%3E')"; assert_eq "$_r" ">" "decode %3E"; }
test_url_decode_semicolon()  { _r="$(url_decode '%3B')"; assert_eq "$_r" ";" "decode %3B"; }
test_url_decode_space()      { _r="$(url_decode '%20')"; assert_eq "$_r" " " "decode %20"; }
test_url_decode_plus()       { _r="$(url_decode 'a+b')"; assert_eq "$_r" "a b" "decode + → space"; }
test_url_decode_percent()    { _r="$(url_decode '%25')"; assert_eq "$_r" "%" "decode %25"; }
test_url_decode_double()     { _r="$(url_decode '%2520')"; assert_eq "$_r" " " "decode %2520 → space"; }

test_url_roundtrip_password() { _e="$(url_encode 'REDACTED')"; _d="$(url_decode "$_e")"; assert_eq "$_d" "REDACTED" "round-trip password"; }
test_url_roundtrip_query()    { _e="$(url_encode 'key=value&x=1')"; _d="$(url_decode "$_e")"; assert_eq "$_d" "key=value&x=1" "round-trip query"; }
test_url_roundtrip_all()      { _a='!"#$%&'"'"'()*+,-./:;<=>?@[\]^_`{|}~'; _e="$(url_encode "$_a")"; _d="$(url_decode "$_e")"; assert_eq "$_d" "$_a" "round-trip all special"; }
test_url_encode_empty()       { _r="$(url_encode '')"; assert_eq "$_r" "" "encode empty"; }
test_url_decode_empty()       { _r="$(url_decode '')"; assert_eq "$_r" "" "decode empty"; }

test_url_encode_hash
test_url_encode_lt
test_url_encode_gt
test_url_encode_semicolon
test_url_encode_ampersand
test_url_encode_space
test_url_encode_percent
test_url_encode_unreserved
test_url_encode_password
test_url_decode_hash
test_url_decode_lt
test_url_decode_gt
test_url_decode_semicolon
test_url_decode_space
test_url_decode_plus
test_url_decode_percent
test_url_decode_double
test_utf8_decode_cjk()       { _r="$(utf8_decode '\u8349\u4E86')"; assert_eq "$_r" '草了' "utf8 CJK"; }
test_utf8_decode_mixed()     { _r="$(utf8_decode 'hi \u4F60\u597D')"; assert_eq "$_r" 'hi 你好' "utf8 mixed"; }
test_utf8_decode_plain()     { _r="$(utf8_decode 'hello world')"; assert_eq "$_r" 'hello world' "utf8 plain unchanged"; }
test_utf8_decode_empty()     { _r="$(utf8_decode '')"; assert_eq "$_r" '' "utf8 empty"; }

test_url_roundtrip_password
test_url_roundtrip_query
test_url_roundtrip_all
test_url_encode_empty
test_url_decode_empty
test_utf8_decode_cjk
test_utf8_decode_mixed
test_utf8_decode_plain
test_utf8_decode_empty
