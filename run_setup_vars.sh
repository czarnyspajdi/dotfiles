#!/bin/bash

cpu_cores=$(lscpu --json | jq -r '.lscpu[] | select(.field == "CPU:") | .data')
threads_per_core=$(lscpu --json | jq -r '.lscpu[] | select(.field == "Wątków na rdzeń:") | .data')
cpu_threads=$((cpu_cores * threads_per_core))

ram=$(lsmem --json | jq -r '.memory[] | .size' | sed 's/,/./g' | sed 's/G//' | awk '{s+=$1} END {print s}')

half_cpu_threads=$(echo "($cpu_threads + 1) / 2" | bc)
half_ram=$(echo "($ram + 1) / 2" | bc)

echo "Total number of CPU threads: $cpu_threads"
echo "Half of the CPU threads: $half_cpu_threads"
echo "Total RAM size: $ram GB"
echo "Half of the RAM: $half_ram GB"

echo -e "\e[33mIMPORTANT: Half of the values will be used for VM settings. To change this edit this script OR file at $HOME/.config/chezmoi/chezmoi.toml\e[0m"

# add your chezmoi variables here

vm_hardware="[data.vm.hardware]\n\
\tcpu = $half_cpu_threads\n\
\tram = $half_ram\n"

git="[git]\n\
\tautoCommit = true\n\
\tautoPush = true\n"

file_content="$vm_hardware$git" # and add it here

echo -e "$file_content" >"$HOME/.config/chezmoi/chezmoi.toml"
