#!/bin/bash

# Sprawdzenie, czy podano argument
if [ $# -ne 1 ]; then
  echo "Użycie: $0 {up|down}"
  exit 1
fi

# Ustawienia zmiennej dla domyślnego audio sink
AUDIO_SINK="@DEFAULT_AUDIO_SINK@"
VOLUME_CHANGE_SOUND="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"

case $1 in
up)
  # Zwiększenie głośności
  wpctl set-volume -l 5.0 "$AUDIO_SINK" 5%+
  ;;
down)
  # Zmniejszenie głośności
  wpctl set-volume -l 0.0 "$AUDIO_SINK" 5%-
  ;;
*)
  echo "Nieprawidłowy argument: $1. Użyj 'up' lub 'down'."
  exit 1
  ;;
esac

# Odtworzenie dźwięku
paplay "$VOLUME_CHANGE_SOUND"

# Wyświetlenie powiadomienia
