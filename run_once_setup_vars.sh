#!/bin/bash
# Pobierz liczbę rdzeni procesora i wątków na rdzeń

cpu_cores=$(lscpu --json | jq -r '.lscpu[] | select(.field == "CPU:") | .data')
threads_per_core=$(lscpu --json | jq -r '.lscpu[] | select(.field == "Wątków na rdzeń:") | .data')

# Oblicz liczbę wątków i połowę wątków
cpu=$((cpu_cores * threads_per_core / 2))

# Pobierz sumę pamięci RAM
ram=$(lsmem --json | jq -r '.memory[] | .size' | sed 's/,/./g' | sed 's/G//' | awk '{s+=$1} END {print s}')

# Wyświetl wyniki
echo "Liczba wszystkich wątków procesora: $((cpu_cores * threads_per_core))"
echo "Połowa wątków procesora: $cpu"
echo "Suma pamięci RAM: $ram GB"
echo "Połowa pamięci RAM: $((ram / 2)) GB"

# Twórz zawartość pliku
file_content="[data.vm.hardware]\n
\tcpu = $cpu\n 
\tram = $((ram / 2))"

echo -e $file_content >>$HOME/.config/chezmoi/chezmoi.toml
