#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

BAT_DIR=""
for d in /sys/class/power_supply/BAT* /sys/class/power_supply/battery*; do
  if [ -d "$d" ]; then
    BAT_DIR="$d"
    break
  fi
done

check_battery_notifications() {
  if [ -z "$BAT_DIR" ]; then
    return
  fi

  PER=$(cat "$BAT_DIR/capacity" 2>/dev/null || echo 100)
  STATUS=$(cat "$BAT_DIR/status" 2>/dev/null || echo "Unknown")

  LOCK_LOW="/tmp/low_bat_notified"
  LOCK_CRIT="/tmp/crit_bat_notified"
  LOCK_FULL="/tmp/full_bat_notified"

  if [ "$STATUS" = "Discharging" ]; then
    rm -f "$LOCK_FULL"

    if [ "$PER" -le 15 ]; then
      if [ ! -f "$LOCK_CRIT" ]; then
        notify-send -u critical -i "dialog-information" "BATTERY CRITICAL" "Sisa $PER% bos. Buruan colok charger!"
        touch "$LOCK_CRIT"
      fi
    elif [ "$PER" -le 25 ]; then
      if [ ! -f "$LOCK_LOW" ]; then
        notify-send -u normal -i "dialog-information" "Battery Low" "Batre tinggal $PER% lagi."
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
        notify-send -u normal -i "dialog-information" "Battery Full 100%" "Udah penuh bos, cabut chargernya."
        touch "$LOCK_FULL"
      fi
    fi
  fi
}

check_battery_notifications

udevadm monitor --subsystem=power_supply | grep --line-buffered "UDEV" | while read -r line; do
  check_battery_notifications
done
