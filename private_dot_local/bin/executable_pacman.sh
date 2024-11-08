#!/bin/bash

case $1 in
"status")
  sudo pacman -Sy

  repo_packages=$(pacman -Quq | wc -l)

  flatpak_packages=$(flatpak remote-ls --updates | sed 's/.*azwa.*//g' | wc -l)

  update_amount=$((repo_packages + flatpak_packages))

  if [[ $update_amount -gt 0 ]]; then
    is_update=" "
  else
    is_update=""
  fi

  tooltip="$update_amount packages need to be updated"

  echo "{\"text\" : \"$is_update\", \"tooltip\" : \"$tooltip\"}"
  ;;
"update")
  sudo pacman -Syu && flatpak update --noninteractive
  is_update="Updating..."
  tooltip="System is updating..."
  echo "{\"text\" : \"$is_update\", \"tooltip\" : \"$tooltip\"}"
  ;;
*)
  echo "Wrong argument"
  ;;
esac
