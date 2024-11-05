#!/bin/bash

# Katalog z bindami oraz dodatkowy plik konfiguracyjny
BIND_DIR="$HOME/.config/hypr/files/binds"
BIND_CONF="$HOME/.config/hypr/files/bind.conf"
TMP_FILE="/tmp/bind_list.txt"

# Czyszczenie pliku tymczasowego
>"$TMP_FILE"

# Funkcja do odczytu bindów z pliku
function parse_binds() {
  local file="$1"
  while IFS='=' read -r key value; do
    if [[ $key == "bind " ]]; then
      # Usunięcie spacji i podział po przecinku
      bind_entry=$(echo "$value" | sed 's/ //g')
      mod="${bind_entry%%,*}"
      key="${bind_entry#*,}"
      key="${key%%,*}"
      action="${bind_entry##*,}"
      # Formatowanie wiersza i zapis do pliku tymczasowego
      echo "$mod + $key → $action" >>"$TMP_FILE"
    fi
  done <"$file"
}

# Przechodzenie przez pliki w katalogu z bindami
for file in "$BIND_DIR"/*; do
  parse_binds "$file"
done

# Odczyt z bind.conf
parse_binds "$BIND_CONF"

# Wyświetlenie wyników w rofi
cat "$TMP_FILE" | rofi -dmenu -i -p "Binds"

# Usunięcie pliku tymczasowego
rm "$TMP_FILE"
