#!/bin/bash
STATE="/tmp/eww_cal_state"

[ -f "$STATE" ] || echo "$(date +%Y) $(date +%-m)" >"$STATE"
read year month <"$STATE"

CURRENT_YEAR=$(date +%Y)

case "$1" in
prev)
  month=$((month - 1))
  [ $month -lt 1 ] && month=1
  ;;
next)
  month=$((month + 1))
  [ $month -gt 12 ] && month=12
  ;;
reset)
  month=$(date +%-m)
  ;;
esac

echo "$CURRENT_YEAR $month" >"$STATE"
