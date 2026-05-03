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
_sync_source_id() {
	_pf="$1" _raw="$2"
	case "$_pf" in
	qq)
		# message_receive: group_id is nested in group.group_id
		_group="$(json_get "$_raw" group 2>/dev/null)" || _group=""
		if [ -n "$_group" ] && [ "$_group" != "NOTFOUND" ]; then
			_gid="$(json_get "$_group" group_id 2>/dev/null)" || _gid=""
			if [ -n "$_gid" ] && [ "$_gid" != "NOTFOUND" ]; then
				printf 'group/%s' "$_gid"; return
			fi
		fi
		# non-message events: group_id at top level
		_gid="$(json_get "$_raw" group_id 2>/dev/null)" || _gid=""
		if [ -n "$_gid" ] && [ "$_gid" != "NOTFOUND" ]; then
			printf 'group/%s' "$_gid"; return
		fi
		# private messages
		_pid="$(json_get "$_raw" peer_id 2>/dev/null)" || _pid=""
		[ -n "$_pid" ] && [ "$_pid" != "NOTFOUND" ] && printf 'private/%s' "$_pid"
		;;
	telegram)
		_chat="$(json_get "$_raw" chat 2>/dev/null)" || _chat=""
		if [ -n "$_chat" ] && [ "$_chat" != "NOTFOUND" ]; then
			_cid="$(json_get "$_chat" id 2>/dev/null)" || _cid=""
			printf '%s' "$_cid"
		fi
		;;
	esac
}

# Main sync handler — called by dispatch
sync_handler() {
	_pf="$1" _evt="$2" _uid="$3" _txt="$4" _raw="$5"

	# Loop prevention 1: emoji prefix = already forwarded
	case "$_txt" in "🐧"*|"✈️"*|"👾"*) return 0 ;; esac
	# Loop prevention 2: sender is the bot itself
	case "$_pf" in
		qq) [ "$_uid" = "3156037162" ] && return 0 ;;
		telegram)
			_fid="$(json_get "$_raw" from 2>/dev/null)" || _fid=""
			if [ -n "$_fid" ] && [ "$_fid" != "NOTFOUND" ]; then
				_fid_id="$(json_get "$_fid" id 2>/dev/null)" || _fid_id=""
				[ "$_fid_id" = "8723729335" ] && return 0
			fi
			;;
	esac

	# Decode \uXXXX to UTF-8 before processing
	_txt="$(utf8_decode "$_txt")"

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
		log_debug "sync: no conf at $_conf"
		return 0
	fi

	# Build prefixed text with sender attribution
	_sender="$(_sync_get_sender "$_pf" "$_raw")"
		_sender="$(utf8_decode "$_sender")"
	case "$_pf" in qq) _icon="🐧" ;; telegram) _icon="✈️" ;; discord) _icon="👾" ;; *) _icon="[$_pf]" ;; esac
	_text="$_icon $_sender: $_txt"

	# Extract source ID for config lookup
	_src_id="$(_sync_source_id "$_pf" "$_raw")"
	if [ -z "$_src_id" ]; then
		log_debug "sync: no src_id pf=$_pf"
		return 0
	fi

	log_info "sync: $_pf $_src_id → $_txt"

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

		log_debug "sync: match $_src → $_tgt"

		case "$_tpf" in
		telegram)
			_tcid="${_tid%%/*}"
			_tthr="${_tid#*/}"
			if [ "$_tthr" != "$_tcid" ] && [ -n "$_tthr" ]; then
				_body="$(json_obj "chat_id" "$_tcid" "text" "$_text" "message_thread_id" "$_tthr")"
			else
				_body="$(json_obj "chat_id" "$_tcid" "text" "$_text")"
			fi
			if _tg_api "sendMessage" "$_body" "sync.tg" >/dev/null; then
				log_info "sync: $_pf→tg OK"
			else
				log_err "sync: $_pf→tg FAIL: $_ERROR"
			fi
			;;
		qq)
			case "$_tid" in
			group/*)
				_gid="${_tid#group/}"
				if qq_message_send_group "$_gid" "$_segs" >/dev/null; then
					log_info "sync: $_pf→qq group $_gid OK"
				else
					log_err "sync: $_pf→qq group $_gid FAIL: $_ERROR"
				fi
				;;
			private/*)
				_pid="${_tid#private/}"
				if qq_message_send_private "$_pid" "$_segs" >/dev/null; then
					log_info "sync: $_pf→qq private $_pid OK"
				else
					log_err "sync: $_pf→qq private $_pid FAIL: $_ERROR"
				fi
				;;
			esac
			;;
		discord)
			if dc_message_create "$_tid" "$_dc_body" >/dev/null; then
				log_info "sync: $_pf→dc OK"
			else
				log_err "sync: $_pf→dc FAIL: $_ERROR"
			fi
			;;
		esac
	done < "$_conf"

	[ $_found -eq 0 ] && log_debug "sync: no match for $_pf $_src_id"
	return 0
}
