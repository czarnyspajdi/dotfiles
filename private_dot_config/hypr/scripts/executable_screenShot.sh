#!/bin/bash

dir_path="$HOME/Obrazy/zrzuty/"
file_name="zrzut_$(date +'%H-%M_%d-%m-%Y').png"

error_message="No argument provided. Use -h or --help for help message."
help_message="\nUsage: screenShot [flags] [type-of-screen-shot]\n\nFlags:\n\t-c | --copy \t Copies to clipboard\n\t-s | --save \t Saves to $dir_path\n\t-e | --edit \t Edit screenshot with swappy\n\nTypes:\n\tfullscreen\n\twindow\n\tregion\n"

if [[ ! -d $dir_path ]]; then
  mkdir -p $dir_path
fi

tmp_path="/tmp/$file_name"
full_path="$dir_path$file_name"

edit=false
save=false
copy=false

while [[ $# -gt 0 ]]; do
  case "$1" in
  -c | --copy)
    copy=true
    ;;
  -s | --save)
    save=true
    ;;
  -e | --edit)
    edit=true
    ;;
  -h | --help)
    echo -e "$help_message"
    exit 0
    ;;
  fullscreen | window | region)
    type_of_screenshot="$1"
    ;;
  *)
    echo "$error_message"
    exit 1
    ;;
  esac
  shift
done

if [[ -z $type_of_screenshot ]]; then
  echo "$error_message"
  exit 1
fi

case "$type_of_screenshot" in
fullscreen)
  grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name') "$tmp_path"
  ;;
window)
  active_window_position="$(hyprctl clients -j | jq -r '.[] | select(.focusHistoryID == 0) | .at')"
  active_window_size="$(hyprctl clients -j | jq -r '.[] | select(.focusHistoryID == 0) | .size')"

  x=$(echo "$active_window_position" | jq '.[0]')
  y=$(echo "$active_window_position" | jq '.[1]')
  width=$(echo "$active_window_size" | jq '.[0]')
  height=$(echo "$active_window_size" | jq '.[1]')

  grim -g "${x},${y} ${width}x${height}" "$tmp_path"
  ;;
region)
  grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name') "$tmp_path" && feh --fullscreen "$tmp_path" &
  sleep 0.3
  feh_pid=$(pgrep feh)
  grim -g "$(slurp)" "$tmp_path"
  echo "Killing feh…"
  kill -9 "$feh_pid"
  ;;
esac

if [ "$copy" = true ] && [ "$save" = true ]; then
  cp "$tmp_path" "$full_path"
  wl-copy <"$tmp_path"
  notify-send -i "$tmp_path" "Screenshot" "Copied and saved to $full_path"
elif [ "$edit" = true ]; then
  swappy -f "$tmp_path"
elif [ "$save" = true ]; then
  cp "$tmp_path" "$full_path"
  notify-send -i "$tmp_path" "Screenshot" "Saved screenshot to $full_path"
elif [ "$copy" = true ]; then
  wl-copy <"$tmp_path"
  notify-send -i "$tmp_path" "Screenshot" "Copied screenshot"
fi

exit 0
