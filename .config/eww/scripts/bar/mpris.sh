#!/bin/bash

while true; do
  if playerctl -p spotify status >/dev/null 2>&1; then
    playerctl -p spotify metadata --format '{"title": "{{title}}", "artist": "{{artist}}", "status": "{{status}}"}' --follow 2>/dev/null
  else
    echo '{"title": "No Media", "artist": "No Artist", "status": "Stopped"}'
    sleep 2
  fi
done
