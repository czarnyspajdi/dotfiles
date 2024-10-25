#!/bin/sh

playerctl -p spotify metadata --format "{{status}} {{artist}} - {{title}}" --follow | while read -r line; do
  player_status=$(playerctl status --player spotify 2>/dev/null)

  if [ "$player_status" = "Playing" ]; then
    echo "  $(playerctl metadata artist --player spotify) - $(playerctl metadata title --player spotify)"
  elif [ "$player_status" = "Paused" ]; then
    echo "  $(playerctl metadata artist --player spotify) - $(playerctl metadata title --player spotify)"
  else
    echo ""
  fi

  # Odśwież Waybar przy każdej zmianie
  pkill -SIGRTMIN+1 waybar
done
