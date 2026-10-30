#!/usr/bin/env bash
# Claude Code hook handler: records per-session state for the waybar module.
# Usage: claude-monitor-hook.sh <running|done|waiting|end>
# Reads the hook event JSON on stdin (session_id, cwd, ...).

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/claude-monitor"
mkdir -p "$STATE_DIR"

input=$(cat)
session_id=$(jq -r '.session_id // empty' <<<"$input")
[ -z "$session_id" ] && exit 0

state_file="$STATE_DIR/$session_id"

echo "$(date '+%H:%M:%S') $1 ${session_id:0:8} $(jq -r '.message // .hook_event_name // ""' <<<"$input")" >> "${STATE_DIR%/}.log"

# Notification fires for both permission prompts and the 60s-idle reminder.
# Only permission prompts mean "waiting" — idle after Stop should stay green.
if [ "$1" = "waiting" ]; then
    msg=$(jq -r '.message // ""' <<<"$input")
    case "$msg" in
        *permission*|*Permission*) ;;
        *) exit 0 ;;
    esac
fi

if [ "$1" = "end" ]; then
    rm -f "$state_file"
else
    # Preserve first-seen timestamp so the session keeps its slot order in the bar
    created=$(jq -r '.created // empty' "$state_file" 2>/dev/null)
    [ -z "$created" ] && created=$(date +%s)

    # Kitty identifiers (inherited from the session's environment) let the
    # status script locate this session's window in Hyprland and its kitty tab.
    jq -n \
        --arg state "$1" \
        --arg cwd "$(jq -r '.cwd // ""' <<<"$input")" \
        --argjson created "$created" \
        --arg kitty_pid "${KITTY_PID:-}" \
        --arg kitty_window_id "${KITTY_WINDOW_ID:-}" \
        --arg kitty_listen "${KITTY_LISTEN_ON:-}" \
        '{state: $state, cwd: $cwd, created: $created,
          kitty_pid: $kitty_pid, kitty_window_id: $kitty_window_id,
          kitty_listen: $kitty_listen}' > "$state_file"
fi

# Tell waybar to refresh the custom/claude module immediately
pkill -RTMIN+8 waybar

exit 0
