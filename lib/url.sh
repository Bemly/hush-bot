# hush-url/lib/url.sh — pure shell URL encode/decode
# Works in busybox:musl, no external dependencies
#
# url_encode <string>  → percent-encoded string
# url_decode <string>  → decoded string

# Percent-encode non-unreserved ASCII characters (RFC 3986)
# Unreserved: A-Z a-z 0-9 - _ . ~  (NOT encoded)
# Encode % first so already-encoded strings double-encode correctly
url_encode() {
	printf '%s' "$1" | sed '
		s/%/%25/g
		s/ /%20/g
		s/!/%21/g
		s/"/%22/g
		s/#/%23/g
		s/\$/%24/g
		s/&/%26/g
		s/'\''/%27/g
		s/(/%28/g
		s/)/%29/g
		s/\*/%2A/g
		s/+/%2B/g
		s/,/%2C/g
		s/\//%2F/g
		s/:/%3A/g
		s/;/%3B/g
		s/</%3C/g
		s/=/%3D/g
		s/>/%3E/g
		s/?/%3F/g
		s/@/%40/g
		s/\[/%5B/g
		s/\\/%5C/g
		s/\]/%5D/g
		s/\^/%5E/g
		s/`/%60/g
		s/{/%7B/g
		s/|/%7C/g
		s/}/%7D/g
	'
}

# Decode percent-encoded strings (+ → space, %XX → char)
# Decode %25 first so double-encoded strings (%2520) resolve correctly
url_decode() {
	printf '%s' "$1" | sed '
		s/+/ /g
		s/%25/%/g
		s/%20/ /g
		s/%21/!/g
		s/%22/"/g
		s/%23/#/g
		s/%24/$/g
		s/%26/\&/g
		s/%27/'\''/g
		s/%28/(/g
		s/%29/)/g
		s/%2A/*/g
		s/%2B/+/g
		s/%2C/,/g
		s/%2E/./g
		s/%2F/\//g
		s/%3A/:/g
		s/%3B/;/g
		s/%3C/</g
		s/%3D/=/g
		s/%3E/>/g
		s/%3F/?/g
		s/%40/@/g
		s/%5B/[/g
		s/%5C/\\/g
		s/%5D/]/g
		s/%5E/^/g
		s/%5F/_/g
		s/%60/`/g
		s/%7B/{/g
		s/%7C/|/g
		s/%7D/}/g
		s/%7E/~/g
	'
}
