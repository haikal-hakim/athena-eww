#!/bin/bash

if eww active-windows | grep -q wifi_popup; then
  eww close wifi_popup
  exit
fi

~/.config/eww/panel/scripts/networkctl.sh scan &

eww open wifi_popup
