#!/bin/bash

# Wyciągnij historię powiadomień
NOTIFICATIONS=$(makoctl history)

# Sprawdź, czy są powiadomienia
if [ -z "$NOTIFICATIONS" ]; then
  notify-send "Brak powiadomień" "Nie masz żadnych zapisanych powiadomień."
  exit 0
fi

# Parsuj historię powiadomień i wyciągnij ikonę, tytuły oraz treści
NOTIFICATIONS=$(echo "$NOTIFICATIONS" | jq -r '
  .data[0][] | 
  (.["app-icon"].data // "🔔") + " " + 
  (.summary.data // "Brak tytułu") + ": " + 
  (.body.data // "Brak treści")
')

# Sprawdź, czy jq poprawnie wyciągnął dane
if [ -z "$NOTIFICATIONS" ]; then
  notify-send "Błąd parsowania" "Nie udało się wyciągnąć powiadomień z historii."
  exit 1
fi

# Przygotowanie do wyświetlenia powiadomień w rofi z ikonkami
echo "$NOTIFICATIONS" | rofi -dmenu -p "Powiadomienia" -show-icons -theme-str 'listview { lines: 15; }' -format i
