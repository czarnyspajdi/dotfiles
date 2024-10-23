#!/bin/bash

wallpaper_dir="$HOME/Obrazy/tapety/"

conf_dir="$HOME/.config/"
wal_dir="$HOME/.cache/wal/"
hypr_dir="$conf_dir/hypr"
waybar_dir="$conf_dir/waybar"

function restart_hyprpaper() {
  if pgrep hyprpaper >/dev/null; then
    killall hyprpaper
  fi
  nohup hyprpaper &
}

function restart_waybar() {
  if pgrep waybar >/dev/null; then
    killall waybar
  fi
  nohup waybar &
}

choosen_wallpaper=$(find $wallpaper_dir -type f | rofi -dmenu -i -p "Wybierz tapetę")

hyprpaper_content="
preload = $choosen_wallpaper\n
wallpaper = ,$choosen_wallpaper\n
splash = off\n
ipc = off
"

echo -e $hyprpaper_content >$hypr_dir/hyprpaper.conf
restart_hyprpaper

wal -i $choosen_wallpaper
cp "$wal_dir/colors-waybar.css" "$waybar_dir/style/var.css"
cp "$wal_dir/colors-kitty.conf" "$conf_dir/kitty/colors.conf"

restart_waybar
