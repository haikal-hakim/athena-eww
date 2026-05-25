#!/bin/bash

DISPLAYED=$(dunstctl count | grep "Currently displayed" | awk '{print $NF}')
HISTORY=$(dunstctl count | grep "History" | awk '{print $NF}')

TOTAL_NOTIF=$((DISPLAYED + HISTORY))

IS_PAUSED=$(dunstctl is-paused 2>/dev/null || echo "false")

if [ "$IS_PAUSED" = "true" ]; then
  echo '{"icon": "󰂛", "class": "dnd", "count": '$TOTAL_NOTIF'}'
else
  if [ "$TOTAL_NOTIF" -gt 0 ]; then
    echo '{"icon": "󱅫", "class": "has-notif", "count": '$TOTAL_NOTIF'}'
  else
    echo '{"icon": "󰂚", "class": "empty", "count": 0}'
  fi
fi
