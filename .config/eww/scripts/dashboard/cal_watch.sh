#!/bin/bash
STATE="/tmp/eww_cal_state"

[ -f "$STATE" ] || echo "$(date +%Y) $(date +%-m)" >"$STATE"

emit() {
  read year month <"$STATE"
  python3 ~/.config/eww/scripts/dashboard/cal.py $year $month
}

emit
while inotifywait -e modify "$STATE" -q 2>/dev/null; do
  emit
done
