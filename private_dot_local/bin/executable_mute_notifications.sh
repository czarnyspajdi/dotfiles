#!/bin/bash

if makoctl mode 2>/dev/null | grep -vi 'default' | grep -qi 'disturb'; then
    is_muted=1
else
    is_muted=0
fi

if [[ $is_muted -eq 0 ]]; then
    makoctl mode -a do-not-disturb >/dev/null 2>&1
    echo "muted"
elif [[ $is_muted -eq 1 ]]; then
    makoctl mode -r do-not-disturb >/dev/null 2>&1
    echo "unmuted"
else
    echo "Something went wrong"
fi
