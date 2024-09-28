#!/bin/bash

# Skrypt do monitorowania okien i przypisywania ikon
while true; do
  workspaces=$(hyprctl workspaces -j)
  declare -A app_icons
  app_icons=(["firefox"]="" ["alacritty"]="" ["discord"]="ﭮ" ["code"]="" ["spotify"]="" ["default"]="")

  format=""
  for workspace in $(echo $workspaces | jq -r '.[].id'); do
    # Pobieranie okien na workspace
    window=$(hyprctl clients -j | jq -r --arg wsid "$workspace" '.[] | select(.workspace == $wsid) | .class')
    icon=${app_icons[$window]:-${app_icons["default"]}}
    format+="{\"name\": \"workspace-${workspace}\", \"icon\": \"${icon}\"},"
  done

  # Usunięcie ostatniego przecinka
  format=${format%,}

  # Zapis formatu do pliku JSON
  echo "[${format}]" >~/.config/hyprland/workspace-icons.json

  # Aktualizacja co 2 sekundy
  sleep 2
done
