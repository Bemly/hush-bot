# plugin/sync.sh — cross-platform message sync
# Forwards messages between QQ, Telegram, Discord based on etc/sync.conf
# Called by dispatch: sync_handler <pf> <evt> <uid> <txt> <raw>

[ -z "${_HB:-}" ] && _HB="$(pwd)"

# Source message APIs (harmless if already sourced)
[ -f "$_HB/adapter/qq/message.sh" ] && . "$_HB/adapter/qq/message.sh"
[ -f "$_HB/adapter/telegram/message.sh" ] && . "$_HB/adapter/telegram/message.sh"
[ -f "$_HB/adapter/discord/message.sh" ] && . "$_HB/adapter/discord/message.sh"

# Extract sender display name from platform-specific raw JSON
_sync_get_sender() {
	_pf="$1" _raw="$2"
	case "$_pf" in
	qq)
		_gm="$(json_get "$_raw" group_member)"
		if [ -n "$_gm" ] && [ "$_gm" != "NOTFOUND" ]; then
			_nm="$(json_get "$_gm" nickname)"
			[ -n "$_nm" ] && [ "$_nm" != "NOTFOUND" ] && { printf '%s' "$_nm"; return; }
			_nm="$(json_get "$_gm" card)"
			[ -n "$_nm" ] && [ "$_nm" != "NOTFOUND" ] && { printf '%s' "$_nm"; return; }
		fi
		_fr="$(json_get "$_raw" friend)"
		if [ -n "$_fr" ] && [ "$_fr" != "NOTFOUND" ]; then
			_nm="$(json_get "$_fr" nickname)"
			[ -n "$_nm" ] && [ "$_nm" != "NOTFOUND" ] && { printf '%s' "$_nm"; return; }
		fi
		json_get "$_raw" sender_id
		;;
	telegram)
		_from="$(json_get "$_raw" from)"
		if [ -n "$_from" ] && [ "$_from" != "NOTFOUND" ]; then
			_fn="$(json_get "$_from" first_name)"
			_ln="$(json_get "$_from" last_name)"
			if [ -n "$_fn" ] && [ "$_fn" != "NOTFOUND" ]; then
				if [ -n "$_ln" ] && [ "$_ln" != "NOTFOUND" ]; then
					printf '%s %s' "$_fn" "$_ln"
				else
					printf '%s' "$_fn"
				fi
				return
			fi
			_un="$(json_get "$_from" username)"
			[ -n "$_un" ] && [ "$_un" != "NOTFOUND" ] && { printf '@%s' "$_un"; return; }
		fi
		printf 'unknown'
		;;
	*) printf 'unknown' ;;
	esac
}

# Extract source chat/channel/group ID as config lookup key
# Returns format matching etc/sync.conf: group/<id>, private/<id>, or plain <id>
_sync_source_id() {
	_pf="$1" _raw="$2"
	case "$_pf" in
	qq)
		# group_nudge / member_join: group_id only, no message_scene
		_gid="$(json_get "$_raw" group_id)"
		if [ -n "$_gid" ] && [ "$_gid" != "NOTFOUND" ]; then
			printf 'group/%s' "$_gid"
		else
			_scene="$(json_get "$_raw" message_scene)"
			if [ "$_scene" = "group" ]; then
				_gid="$(json_get "$_raw" group_id)"
				printf 'group/%s' "$_gid"
			else
				_pid="$(json_get "$_raw" peer_id)"
				printf 'private/%s' "$_pid"
			fi
		fi
		;;
	telegram)
		_chat="$(json_get "$_raw" chat)"
		if [ -n "$_chat" ] && [ "$_chat" != "NOTFOUND" ]; then
			json_get "$_chat" id
		fi
		;;
	esac
}

# Main sync handler — called by dispatch
# Matches source platform+chat against etc/sync.conf, forwards to each target
sync_handler() {
	_pf="$1" _evt="$2" _uid="$3" _txt="$4" _raw="$5"

	# Skip already-synced messages (loop prevention)
	case "$_txt" in "[sync]"*) return 0 ;; esac

	# Map non-message events to descriptive text
	case "$_evt" in
		group_nudge) _txt="[戳一戳]" ;;
		member_join) _txt="[新成员加入]" ;;
		member_leave) _txt="[成员离开]" ;;
		friend_request) _txt="[好友请求]" ;;
		message_recall) _txt="[撤回消息]" ;;
	esac

	_conf="${_SYNC_CONF:-$_HB/etc/sync.conf}"
	if [ ! -f "$_conf" ]; then
		log_debug "sync: no config at $_conf"
		return 0
	fi

	# Build prefixed text with sender attribution
	_sender="$(_sync_get_sender "$_pf" "$_raw")"
	_text="[sync] [$_pf] $_sender: $_txt"

	# Extract source ID for config lookup
	_src_id="$(_sync_source_id "$_pf" "$_raw")"
	[ -z "$_src_id" ] && return 0

	# Pre-build platform-specific payloads
	_segs="$(qq_text_segments "$_text")"
	_dc_body="$(json_obj "content" "$_text")"

	_found=0
	while IFS='=' read -r _src _tgt; do
		case "$_src" in \#*|"") continue ;; esac
		_spf="${_src%%/*}"
		_sid="${_src#*/}"
		[ "$_spf" != "$_pf" ] && continue
		[ "$_sid" != "$_src_id" ] && continue

		_tpf="${_tgt%%/*}"
		_tid="${_tgt#*/}"
		_found=1

		case "$_tpf" in
		telegram)
			# Support topic: telegram/<chat_id>/<thread_id>
			_tcid="${_tid%%/*}"
			_tthr="${_tid#*/}"
			if [ "$_tthr" != "$_tcid" ] && [ -n "$_tthr" ]; then
				_body="$(json_obj "chat_id" "$_tcid" "text" "$_text" "message_thread_id" "$_tthr")"
			else
				_body="$(json_obj "chat_id" "$_tcid" "text" "$_text")"
			fi
			_tg_api "sendMessage" "$_body" "sync.tg" >/dev/null 
				|| log_err "sync: $_pf→tg fail: $_ERROR"
			;;		qq)
			case "$_tid" in
			group/*)
				qq_message_send_group "${_tid#group/}" "$_segs" >/dev/null \
					|| log_err "sync: $_pf→qq group fail: $_ERROR"
				;;
			private/*)
				qq_message_send_private "${_tid#private/}" "$_segs" >/dev/null \
					|| log_err "sync: $_pf→qq private fail: $_ERROR"
				;;
			esac
			;;
		discord)
			dc_message_create "$_tid" "$_dc_body" >/dev/null \
				|| log_err "sync: $_pf→dc fail: $_ERROR"
			;;
		esac
	done < "$_conf"

	[ $_found -eq 0 ] && log_debug "sync: no targets for $_pf $_src_id"
	return 0
}
