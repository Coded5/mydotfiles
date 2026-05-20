#!/bin/bash

# Get the active workspace ID
active_ws=$(hyprctl activeworkspace -j | jq '.id')

# Get monitor–workspace info
monitors_json=$(hyprctl monitors -j)

# Find the monitor of the active workspace
current_monitor=$(echo "$monitors_json" | jq -r ".[] | select(.activeWorkspace.id == $active_ws) | .name")

# Find the other monitor's active workspace
other_ws=$(echo "$monitors_json" \
    | jq ".[] | select(.name != \"$current_monitor\") | .activeWorkspace.id")

# Switch to that workspace
hyprctl dispatch workspace "$other_ws"
