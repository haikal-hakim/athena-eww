#!/bin/bash
EWW="$(which eww)"
STATE_FILE="/tmp/eww_dashboard"
LOCK_FILE="/tmp/eww_dashboard.lock"

if [ -f "$LOCK_FILE" ]; then
  exit 0
fi
touch "$LOCK_FILE"

## Run eww daemon if not running already
if [[ ! $(pidof eww) ]]; then
  ${EWW} daemon
  sleep 1
fi

close_dash() {
  "$EWW" close \
    window_weather \
    window_profile \
    window_sysinfo \
    window_folders \
    window_launcher \
    window_music \
    window_website \
    window_uptime \
    window_todo \
    window_calendar
  rm -f "$STATE_FILE"
  bash ~/.config/eww/scripts/dashboard/cal_nav.sh reset
}

case "$1" in
close)
  close_dash
  ;;
*)
  if [[ ! -f "$STATE_FILE" ]]; then
    touch "$STATE_FILE"
    "$EWW" --no-daemonize open window_weather
    "$EWW" --no-daemonize open window_profile
    "$EWW" --no-daemonize open window_sysinfo
    "$EWW" --no-daemonize open window_calendar
    "$EWW" --no-daemonize open window_folders
    "$EWW" --no-daemonize open window_launcher
    "$EWW" --no-daemonize open window_music
    "$EWW" --no-daemonize open window_website
    "$EWW" --no-daemonize open window_uptime
    "$EWW" --no-daemonize open window_todo
  else
    close_dash
  fi
  ;;
esac

rm -f "$LOCK_FILE"
