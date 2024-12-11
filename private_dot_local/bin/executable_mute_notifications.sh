#!/bin/bash

is_muted=$(makoctl mode 2>/dev/null | grep -vi 'default' | grep -qi 'disturb' && echo 1 || echo 0)

if [[ $1 == "toggle" ]]; then
    if [[ $is_muted -eq 0 ]]; then
        makoctl mode -a do-not-disturb >/dev/null 2>&1
        echo " "
    else
        makoctl mode -r do-not-disturb >/dev/null 2>&1
        echo " "
    fi
else
    if [[ $is_muted -eq 0 ]]; then
        echo " "
    else
        echo " "
    fi
fi

