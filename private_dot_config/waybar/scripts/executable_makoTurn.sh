#!/bin/bash

# Sprawdzamy, czy Mako jest uruchomiony
if pgrep -x "mako" >/dev/null; then
  pkill mako
  echo '{"icon": " "}' # Ikona przekreślonego dzwonka
else
  mako &
  echo '{"icon": " "}' # Ikona normalnego dzwonka
fi
