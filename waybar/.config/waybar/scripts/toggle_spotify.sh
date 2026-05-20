#!/bin/bash

if eww active-windows | grep -q "spotify_player"; then
    eww close spotify_player
else
    # Stop any ghost timers before opening
    ~/.config/eww/scripts/tooltip_logic.sh stop
    eww open spotify_player
    # Start the "grace period" timer
    ~/.config/eww/scripts/tooltip_logic.sh start
fi
