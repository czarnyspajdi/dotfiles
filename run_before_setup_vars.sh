#!/bin/bash

LANG=pl_PL.UTF-8

git="[git]\n\
\tautoCommit = true\n\
\tautoPush = true\n"

file_content="$git"

echo -e "$file_content" >"$HOME/.config/chezmoi/chezmoi.toml"
