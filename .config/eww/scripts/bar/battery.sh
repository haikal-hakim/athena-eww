#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

BAT_DIR=""
for d in /sys/class/power_supply/BAT* /sys/class/power_supply/battery*; do
  if [ -d "$d" ]; then
    BAT_DIR="$d"
    break
  fi
done

if [ -z "$BAT_DIR" ]; then
  echo "{\"percent\": 100, \"status\": \"AC\", \"time\": \"N/A\"}"
  exit 0
fi

PER=$(cat "$BAT_DIR/capacity" 2>/dev/null || echo 100)
STATUS=$(cat "$BAT_DIR/status" 2>/dev/null || echo "Unknown")

TIME="--:--"
if [ "$STATUS" != "Full" ]; then
  CUR=$(cat "$BAT_DIR/energy_now" 2>/dev/null || cat "$BAT_DIR/charge_now" 2>/dev/null || echo 0)
  RATE=$(cat "$BAT_DIR/power_now" 2>/dev/null || cat "$BAT_DIR/current_now" 2>/dev/null || echo 0)

  if [ "$RATE" -gt 0 ]; then
    SECS=$((CUR * 3600 / RATE))
    H=$((SECS / 3600))
    M=$(((SECS % 3600) / 60))
    TIME=$(printf "%02dh %02dm" $H $M)
  fi
fi

LOCK_LOW="/tmp/low_bat_notified"
LOCK_CRIT="/tmp/crit_bat_notified"
LOCK_FULL="/tmp/full_bat_notified"

if [ "$STATUS" = "Discharging" ]; then
  rm -f "$LOCK_FULL"

  if [ "$PER" -le 15 ]; then
    if [ ! -f "$LOCK_CRIT" ]; then
      notify-send -u critical -i "dialog-information" "BATTERY CRITICAL" "Sisa $PER% ($TIME lagi mati). Colok charger bos"
      touch "$LOCK_CRIT"
    fi
  elif [ "$PER" -le 25 ]; then
    if [ ! -f "$LOCK_LOW" ]; then
      notify-send -u normal -i "dialog-information" "Battery Low" "Sisa batre tinggal $PER% ($TIME lagi)"
      touch "$LOCK_LOW"
    fi
  fi
else
  if [ "$PER" -gt 25 ]; then
    rm -f "$LOCK_LOW"
    rm -f "$LOCK_CRIT"
  fi

  if [ "$PER" -eq 100 ] || [ "$STATUS" = "Full" ]; then
    if [ ! -f "$LOCK_FULL" ]; then
      notify-send -u normal -i "dialog-information" "Battery Full 100%" "Udah penuh bos, cabut chargernya biar gak meledak"
      touch "$LOCK_FULL"
    fi
  fi
fi

echo "{\"percent\": $PER, \"status\": \"$STATUS\", \"time\": \"$TIME\"}"
