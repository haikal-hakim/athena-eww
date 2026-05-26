#!/bin/bash

INTERFACE=$(ip -br link show | grep -v "lo" | grep "UP" | awk '{print $1}' | head -1)

TYPE=""
if [[ "$INTERFACE" =~ ^w ]]; then
  TYPE="wireless"
elif [[ "$INTERFACE" =~ ^e ]]; then
  TYPE="ethernet"
fi

SIGNAL=""
if [ "$TYPE" = "wireless" ]; then
  LINK_QUAL=$(awk -v iface="$INTERFACE" '$0 ~ iface {print $3}' /proc/net/wireless | tr -d '.')
  if [ ! -z "$LINK_QUAL" ]; then
    SIGNAL=$((LINK_QUAL * 100 / 70))
  fi
fi

case "$1" in
icon)
  if [ "$TYPE" = "ethernet" ]; then
    echo "󰈀"
  elif [ "$TYPE" = "wireless" ]; then
    if [ -z "$SIGNAL" ] || [ "$SIGNAL" -lt 25 ]; then
      echo "󰤟"
    elif [ "$SIGNAL" -lt 50 ]; then
      echo "󰤢"
    elif [ "$SIGNAL" -lt 75 ]; then
      echo "󰤥"
    else
      echo "󰤨"
    fi
  else
    echo "󰤭"
  fi
  ;;

status)
  if [ "$TYPE" = "ethernet" ]; then
    echo "wired"
  elif [ "$TYPE" = "wireless" ]; then
    if [ -z "$SIGNAL" ] || [ "$SIGNAL" -lt 25 ]; then
      echo "wifi-low"
    else
      echo "wifi-ok"
    fi
  else
    echo "disconnected"
  fi
  ;;
esac
