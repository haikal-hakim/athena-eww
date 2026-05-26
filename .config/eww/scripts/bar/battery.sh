#!/bin/bash
BAT=/sys/class/power_supply/BAT0
PER=$(cat "$BAT/capacity")
STATUS=$(cat "$BAT/status")

# Marker
LOW_LOCK="/tmp/battery_low_notified"
CRIT_LOCK="/tmp/battery_crit_notified"

if [ "$STATUS" = "Charging" ]; then
  ICON="󱐌"
else
  if [ "$PER" -gt 90 ]; then
    ICON="󰁹"
  elif [ "$PER" -gt 80 ]; then
    ICON="󰂂"
  elif [ "$PER" -gt 70 ]; then
    ICON="󰂁"
  elif [ "$PER" -gt 60 ]; then
    ICON="󰂀"
  elif [ "$PER" -gt 50 ]; then
    ICON="󰁿"
  elif [ "$PER" -gt 40 ]; then
    ICON="󰁾"
  elif [ "$PER" -gt 30 ]; then
    ICON="󰁽"
  elif [ "$PER" -gt 20 ]; then
    ICON="󰁼"
  elif [ "$PER" -gt 10 ]; then
    ICON="󰁻"
  else
    ICON="󰁺"
  fi
fi

if [ "$STATUS" = "Charging" ]; then
  rm -f "$LOW_LOCK" "$CRIT_LOCK"
else
  if [ "$PER" -le 10 ]; then
    if [ ! -f "$CRIT_LOCK" ]; then
      notify-send -u critical "Battery Critical" "Connect Charger NOW"
      touch "$CRIT_LOCK"
    fi
  elif [ "$PER" -le 20 ] && [ "$PER" -gt 10 ]; then
    if [ ! -f "$LOW_LOCK" ]; then
      notify-send -u normal "Battery Low" "Connect Charger"
      touch "$LOW_LOCK"
    fi
    rm -f "$CRIT_LOCK"
  else
    rm -f "$LOW_LOCK" "$CRIT_LOCK"
  fi
fi

echo "{\"icon\": \"$ICON\", \"percent\": $PER, \"status\": \"$STATUS\"}"
