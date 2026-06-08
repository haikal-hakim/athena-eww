#!/bin/bash

get_net_json() {
  ETH_INTERFACE=$(ip -br link show | grep -v "lo" | grep "UP" | awk '{print $1}' | grep '^e' | head -1)

  if [ -n "$ETH_INTERFACE" ]; then
    STATUS="connected"
    SSID="Ethernet"
    SIGNAL=100
    ICON=""
  else
    WIFI_RADIO=$(nmcli radio wifi)
    INTERFACE=$(ip -br link show | grep -v "lo" | awk '{print $1}' | grep '^w' | head -1)

    STATUS="disconnected"
    SSID="Off"
    SIGNAL=0
    ICON="󰤮"

    if [ "$WIFI_RADIO" = "enabled" ]; then
      STATUS="not-connected"
      SSID="Not Connected"
      ICON="󰤣"

      ACTIVE_SSID=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)

      if [ -n "$ACTIVE_SSID" ]; then
        SSID="$ACTIVE_SSID"
        STATUS="connected"

        if [ -f /proc/net/wireless ] && [ -n "$INTERFACE" ]; then
          LINK_QUAL=$(awk -v iface="$INTERFACE" '$0 ~ iface {print $3}' /proc/net/wireless | tr -d '.')
          if [[ "$LINK_QUAL" =~ ^[0-9]+$ ]]; then
            SIGNAL=$((LINK_QUAL * 100 / 70))
            [ "$SIGNAL" -gt 100 ] && SIGNAL=100
          fi
        fi

        if [ "$SIGNAL" -lt 25 ]; then
          ICON="󰤟"
        elif [ "$SIGNAL" -lt 50 ]; then
          ICON="󰤢"
        elif [ "$SIGNAL" -lt 75 ]; then
          ICON="󰤥"
        else
          ICON="󰤥"
        fi
      fi
    fi
  fi

  printf '{"status": "%s", "ssid": "%s", "signal": %d, "icon": "%s"}\n' "$STATUS" "$SSID" "$SIGNAL" "$ICON"
}

get_net_json

nmcli monitor | while read -r _; do
  get_net_json
done
