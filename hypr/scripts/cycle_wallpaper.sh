#!/bin/bash

SWITCH_SCRIPT="$HOME/.config/hypr/scripts/random_wallpaper.sh"
CYCLE_PERIOD=$((15 * 60))

while true; do
  $SWITCH_SCRIPT &> /dev/null
  sleep $CYCLE_PERIOD
done
