#!/bin/bash
grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name') /tmp/fullscreen.png && feh --fullscreen /tmp/fullscreen.png &
sleep 0.3            # Dajemy feh chwilę, żeby się w pełni uruchomił
feh_pid=$(pgrep feh) # Znajdujemy PID procesu feh
grim -g "$(slurp)" - | swappy -f -
echo "Killing FEH..."
kill -9 $feh_pid # Zabijamy feh
