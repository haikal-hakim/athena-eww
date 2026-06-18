#!/bin/bash

get_status() {

  ETH_CONNECTED=$(nmcli -t -f TYPE,STATE dev | grep '^ethernet:connected')

  if [ -n "$ETH_CONNECTED" ]; then
    printf '{"status":"connected","ssid":"Ethernet","signal":100,"icon":""}\n'
    return
  fi

  WIFI_RADIO=$(nmcli radio wifi)

  if [ "$WIFI_RADIO" != "enabled" ]; then
    printf '{"status":"disconnected","ssid":"Off","signal":0,"icon":"󰤮"}\n'
    return
  fi

  ACTIVE_SSID=$(
    nmcli -t -f ACTIVE,SSID dev wifi |
      awk -F: '/^yes/ {
      sub(/^yes:/, "")
      print
    }'
  )

  if [ -z "$ACTIVE_SSID" ]; then
    printf '{"status":"not-connected","ssid":"Not Connected","signal":0,"icon":"󰤣"}\n'
    return
  fi

  INTERFACE=$(
    nmcli -t -f DEVICE,TYPE dev |
      awk -F: '$2=="wifi" {
      print $1
      exit
    }'
  )

  SIGNAL=$(
    awk -v iface="$INTERFACE" '
      $0 ~ iface {
        gsub(/\./,"",$3)
        print int($3 * 100 / 70)
      }
    ' /proc/net/wireless
  )

  [ -z "$SIGNAL" ] && SIGNAL=0
  [ "$SIGNAL" -gt 100 ] && SIGNAL=100

  if [ "$SIGNAL" -lt 25 ]; then
    ICON="󰤟"
  elif [ "$SIGNAL" -lt 50 ]; then
    ICON="󰤢"
  elif [ "$SIGNAL" -lt 75 ]; then
    ICON="󰤥"
  else
    ICON="󰤥"
  fi

  printf '{"status":"connected","ssid":"%s","signal":%d,"icon":"%s"}\n' \
    "$ACTIVE_SSID" "$SIGNAL" "$ICON"
}

scan_wifi() {

  LIST=$(
    nmcli -t -f SSID,SIGNAL,SECURITY dev wifi |
      awk -F: '

NF && $1 != "" {

  secure = ($3 != "--") ? "true" : "false"

  icon="󰤯"

  if ($2 < 25)
      icon="󰤟"
  else if ($2 < 50)
      icon="󰤢"
  else if ($2 < 75)
      icon="󰤥"
  else
      icon="󰤥"

  printf "{\"ssid\":\"%s\",\"icon\":\"%s\",\"secure\":%s},", \
    $1, icon, secure
}
' | sed 's/,$//'
  )

  eww update wifi_list="[$LIST]"
}

toggle_wifi() {

  scan_wifi

  eww open wifi_popup
}

connect_wifi() {

  SSID="$1"
  SECURE="$2"

  if [ "$SECURE" = "true" ]; then

    PASSWORD=$(
      rofi -dmenu \
        -password \
        -p "$SSID"
    )

    [ -z "$PASSWORD" ] && exit

    nmcli dev wifi connect "$SSID" password "$PASSWORD"

  else

    nmcli dev wifi connect "$SSID"

  fi

  eww close wifi_popup
}

monitor() {

  get_status

  nmcli device monitor | while read -r _; do
    get_status
  done
}

case "$1" in

monitor)
  monitor
  ;;

scan)
  scan_wifi
  ;;

toggle)
  toggle_wifi
  ;;

connect)
  connect_wifi "$2" "$3"
  ;;

esac
