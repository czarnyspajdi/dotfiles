#!/bin/bash

cpu_cores=$(lscpu --json | jq -r '.lscpu[] | select(.field == "CPU:") | .data')
threads_per_core=$(lscpu --json | jq -r '.lscpu[] | select(.field == "Wątków na rdzeń:") | .data')

cpu=$((cpu_cores * threads_per_core / 2))
ram=$(lsmem --json | jq -r '.memory[] | .size' | sed 's/,/./g' | sed 's/G//' | awk '{s+=$1} END {print s}')

echo "Total number of CPU threads: $((cpu_cores * threads_per_core))"
echo "Half of the cpu threads: $cpu"
echo "Total RAM size: $ram GB"
echo "Half of the RAM: $((ram / 2)) GB"
echo -e "\e[33mIMPORTANT: Half of the values will be used for vm settings. To change this edit this script OR file at $HOME/.config/chezmoi/chezmoi.toml\e[0m"

# setup chezmoi variable like this:

vm_hardware="[data.vm.hardware]\n
\tcpu = $cpu\n 
\tram = $((ram / 2))\n"

git="[git]\n
\tautoCommit = true\n
\tautoPush = true\n"

file_content="$vm_hardware$git" # also add it here

echo -e $file_content >$HOME/.config/chezmoi/chezmoi.toml
