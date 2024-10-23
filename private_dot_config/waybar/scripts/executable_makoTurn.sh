#!/bin/bash

# Sprawdzamy, czy Mako jest uruchomiony
if pgrep -x "mako" >/dev/null; then
  pkill -f "mako" # Zamykamy Mako
  sleep 0.2       # Dajemy trochę czasu, żeby Mako faktycznie się wyłączył
  echo '{" "}'   # Ikona przekreślonego dzwonka
else
  mako &
  disown        # Uruchamiamy Mako w tle i odłączamy od terminala
  echo '{" "}' # Ikona normalnego dzwonka
fi
