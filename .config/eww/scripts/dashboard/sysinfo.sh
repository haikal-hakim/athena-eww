#!/bin/bash

# CPU USAGE
CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')

# RAM
RAM_TOTAL_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_AVAILABLE_KB=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
RAM_USED_KB=$((RAM_TOTAL_KB - RAM_AVAILABLE_KB))

RAM_TOTAL=$((RAM_TOTAL_KB / 1024))
RAM_USED=$((RAM_USED_KB / 1024))
RAM_PERCENT=$((RAM_USED_KB * 100 / RAM_TOTAL_KB))

# DISK / SSD
DISK_TOTAL=$(df -h --output=size / | tail -n 1 | tr -d ' ')
DISK_USED=$(df -h --output=used / | tail -n 1 | tr -d ' ')
DISK_PERCENT=$(df --output=pcent / | tail -n 1 | tr -d ' %')

# TEMPERATUR CPU (lm-sensors)
if command -v sensors >/dev/null 2>&1; then
  TEMP=$(sensors | grep -E '(Package id 0|Core 0|Tctl)' | head -1 | cut -d: -f2 | sed 's/[^0-9.]//g' | cut -d. -f1)
else
  TEMP=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | sort -rn | head -1)
  TEMP=$((TEMP / 1000))
fi

[[ "$TEMP" =~ ^[0-9]+$ ]] || TEMP=0

# OUTPUT JSON
echo "{\"cpu\": $CPU, \"ram_used\": $RAM_USED, \"ram_total\": $RAM_TOTAL, \"ram_percent\": $RAM_PERCENT, \"disk_used\": \"$DISK_USED\", \"disk_total\": \"$DISK_TOTAL\", \"disk_percent\": $DISK_PERCENT, \"temp\": $TEMP}"
