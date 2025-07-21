#!/bin/bash

# Find the current firefox player name (takes the first one if multiple)
PLAYER=$(playerctl -l | grep firefox | head -n1)

# Exit if no firefox player found
if [[ -z "$PLAYER" ]]; then
    echo "Firefox player not found."
    exit 1
fi

playerctl -p "$PLAYER" metadata --follow --format '{{status}} {{artist}} - {{title}}' 2>/dev/null | while read -r line; do
    status=$(echo "$line" | cut -d' ' -f1)
    info=$(echo "$line" | cut -d' ' -f2-)

    if [[ "$status" == "Playing" ]]; then
        icon="⏸"
    elif [[ "$status" == "Paused" ]]; then
        icon="▶"
    else
        icon="■"
    fi

    echo "$icon $info"
done

