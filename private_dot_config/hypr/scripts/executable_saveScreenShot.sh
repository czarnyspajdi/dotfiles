#!/bin/bash

# Zapisz zrzut ekranu z unikalną nazwą
grim -g "$(slurp)" ~/Obrazy/zrzuty/zrzut_$(date +%Y%m%d_%H%M%S).png
