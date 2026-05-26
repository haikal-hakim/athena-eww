#!/bin/bash

generate_workspaces() {
  ACTIVE=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .activeWorkspace.id')
  OCCUPIED=$(hyprctl workspaces -j | jq -r '.[] | select(.windows > 0) | .id' | tr '\n' ' ')
  URGENT=$(hyprctl workspaces -j | jq -r '.[] | select(.has_urgent == true or .urgent == true) | .id' | tr '\n' ' ')

  echo -n "(box :class \"workspaces\" :orientation \"h\" :space-evenly false :spacing 12"
  for i in {1..5}; do
    CLASS="ws-dot"
    ICON="󰊠"

    if [ "$i" -eq "$ACTIVE" ]; then
      CLASS="$CLASS active"
      ICON="󱍢"
    elif [[ " $URGENT " =~ " $i " ]]; then
      CLASS="$CLASS urgent"
      ICON="󱁂"
    elif [[ " $OCCUPIED " =~ " $i " ]]; then
      CLASS="$CLASS occupied"
      ICON="󰶵"
    else
      CLASS="$CLASS empty"
      ICON=""
    fi
    echo -n " (button :class \"$CLASS\" :onclick \"hyprctl dispatch workspace $i\" \"$ICON\")"
  done
  echo ")"
}

generate_workspaces

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  if [[ "$line" =~ ^workspace[^v] ]] || [[ "$line" =~ ^focusedmon ]] || [[ "$line" =~ ^destroyworkspace ]] || [[ "$line" =~ ^createworkspace ]] || [[ "$line" =~ ^urgent ]]; then
    generate_workspaces
  fi
done
